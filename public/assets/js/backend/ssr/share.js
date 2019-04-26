define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'ssr/share/index' + location.search,
                    add_url: 'ssr/share/add',
                    edit_url: 'ssr/share/edit',
                    del_url: 'ssr/share/del',
                    multi_url: 'ssr/share/multi',
                    table: 'share',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'name', title: __('Name')},
                        {field: 'url', title: __('Url'), formatter: Table.api.formatter.url},
                        {field: 'analyze_tyep', title: __('Analyze_tyep'), searchList: {"1":__('Analyze_tyep 1'),"2":__('Analyze_tyep 2')}, formatter: Table.api.formatter.normal},
                        {field: 'key', title: __('Key')},
                        {field: 'marker_content', title: __('Marker_content')},
                        {field: 'url_status', title: __('Url_status'),searchList: {"0":__('Url_status 0'),"1":__('Url_status 1')}, formatter: Table.api.formatter.status},
                        {field: 'status', title: __('Status'), searchList: {"0":__('Status 0'),"1":__('Status 1')}, formatter: Table.api.formatter.status},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});