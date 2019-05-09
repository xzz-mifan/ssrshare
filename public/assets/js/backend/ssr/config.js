define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'ssr/config/index' + location.search,
                    add_url: 'ssr/config/add',
                    edit_url: 'ssr/config/edit',
                    del_url: 'ssr/config/del',
                    multi_url: 'ssr/config/multi',
                    table: 'ssr_config',
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
                        {field: 'id', title: __('Id'),visible:false},
                        {field: 'share.name', title: __('Share.name'),sortable: true},
                        {field: 'address', title: __('Address'),sortable: true},
                        {field: 'ip', title: __('真实IP'),sortable: true},
                        {field: 'port', title: __('Port')},
                        {field: 'country', title: __('地区'),sortable: true},
                        {field: 'password', title: __('Password')},
                        {field: 'method', title: __('Method')},
                        {field: 'protocol', title: __('Protocol')},
                        {field: 'protocol_param', title: __('Protocol_param'),visible:false},
                        {field: 'obfs', title: __('Obfs')},
                        {field: 'obfs_param', title: __('Obfs_param'),visible:false},
                        {field: 'group', title: __('Group'),visible:false},
                        {field: 'remark', title: __('Remark'),visible:false},
                        {field: 'ssrurl', title: __('Ssrurl'), formatter: Table.api.formatter.url,visible:false},
                        {field: 'status', title: __('Status'), searchList: {"0":__('Status 0'),"-1":__('Status -1'),"1":__('Status 1')}, formatter: Table.api.formatter.status},
                        {field: 'timeout', title: __('Timeout'),sortable: true},
                        {field: 'updatetime', title: __('检测更新时间'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime,sortable: true},
                        {field: 'updatetime1', title: __('采集更新时间'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime,sortable: true},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime,visible:false,sortable: true},
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