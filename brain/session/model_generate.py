#!/usr/bin/python

## @model_generate.py
#  This file receives data (i.e. settings) required to query from the database,
#      a previously stored session, involving one or more stored dataset uploads,
#      and generates an SVM model, respectively. The new SVM model, is stored
#      into respective database table(s), which later can be retrieved within
#      'model_use.py'.
from brain.database.retrieve_dataset import Retrieve_Dataset

## Class: Model_Generate
#
#  Note: this class is invoked within 'load_data.py'
class Model_Generate:

    ## constructor:
    def __init__(self, svm_data):
        self.svm_data   = svm_data
        self.session_id = self.svm_data['data']['settings']['svm_session_id']
        self.list_error = []

    ## select_dataset: select a dataset from the database
    def select_dataset(self):
        requester             = Retrieve_Dataset()
        self.selected_dataset = requester.get_dataset(self.session_id)

    ## return_error: returns current error(s)
    def return_error(self):
        return self.list_error
