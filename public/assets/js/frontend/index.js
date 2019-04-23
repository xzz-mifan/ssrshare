define(['jquery', 'bootstrap', 'frontend', 'form', 'template'], function ($, undefined, Frontend, Form, Template) {
    var Controller = {
        index:function () {

            Form.api.bindevent();
        },
    };

    return Controller;
});