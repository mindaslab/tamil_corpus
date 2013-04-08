$('#tags :checkbox').click(function() {
    var $this = $(this);
    // $this will contain a reference to the checkbox   
    if ($this.is(':checked')) {
        // the checkbox was checked 
        alert($this.attr('id').match(/\d+/g));
    } else {
        // the checkbox was unchecked
    }
});
