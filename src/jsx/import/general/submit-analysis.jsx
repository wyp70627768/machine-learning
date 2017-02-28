/**
 * submit-analysis.jsx: append 'submit-analysi' button.
 *
 * @Submit, must be capitalized in order for reactjs to render it as a
 *     component. Otherwise, the variable is rendered as a dom node.
 *
 * Note: this script implements jsx (reactjs) syntax.
 */

import React from 'react';

var SubmitAnalysis = React.createClass({
  // triggered when 'state properties' change
    render: function(){
        var clickCallback = !!this.props.onClick ? this.props.onClick : null;
        return(
            <input
                type='submit'
                className='form-submit'
                onClick={clickCallback}
            />
        );
    }
});

// indicate which class can be exported, and instantiated via 'require'
export default SubmitAnalysis