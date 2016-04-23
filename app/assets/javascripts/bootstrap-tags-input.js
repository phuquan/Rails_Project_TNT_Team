$(document).ready(function () {
    $('#defaultForm')
        .find('[name="cities"]')
    // Revalidate the color when it is changed
    .change(function (e) {
        console.warn($('[name="cities"]').val());
        console.info($('#aa').val());
        console.info($("#aa").tagsinput('items'));
        var a = $("#aa").tagsinput('items');
        console.log(typeof (a));
        console.log(a.length);
        $('#defaultForm').bootstrapValidator('revalidateField', 'cities');
    })
        .end()
        .find('[name="cities1"]')
    // Revalidate the color when it is changed
    .change(function (e) {
        console.warn($('[name="cities1"]').val());
        console.info($('#aa1').val());
        console.info($("#aa1").tagsinput('items'));
        var a = $("#aa1").tagsinput('items');
        console.log(typeof (a));
        console.log(a.length);
        $('#defaultForm').bootstrapValidator('revalidateField', 'cities1');
    })
        .end()
        .bootstrapValidator({
        excluded: ':disabled',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            cities: {
                validators: {
                    notEmpty: {
                        message: 'Please enter at least one city you like the most'
                    }
                }
            },
            cities1: {
                validators: {
                    callback: {
                        message: 'Please choose 2-4 color you like most',
                        callback: function (value, validator) {
                            // Get the selected options
                            var options = validator.getFieldElements('cities1').tagsinput('items');
                            // console.info(options);
                            return (options !== null && options.length >= 2 && options.length <= 4);
                        }
                    }
                }
            }
        }
    })
        .on('success.form.bv', function (e) {
        // Prevent form submission
        e.preventDefault();
    });
});