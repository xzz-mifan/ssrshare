define(['jquery', 'bootstrap', 'frontend', 'form', 'template','jquery-fullpage'], function ($, undefined, Frontend, Form, Template,jqueryfullpage) {
    var Controller = {
        index:function () {
            $(function(){
                /* 每日背景图 */
                $.getJSON(
                    '/api/Unofficial/bingImage',{},
                    function (data) {
                        $('#dowebok div:eq(0)').css('background',' url('+data.data+') 50%');
                        home_animate(1);
                        $('#dowebok').fullpage({
                            sectionsColor: ['#1bbc9b', '#4BBFC3', '#7BAABE', '#f90'],
                            anchors: ['page1', 'page2', 'page3', 'page4'],
                            menu: '#menu',
                            verticalCentered:true,
                            navigation:true,
                            paddingTop:"40px",
                            afterLoad:function (anchorLink,index) {
                                if (index==1)
                                {
                                    home_animate(1);
                                }else{
                                    $('.navbar-default').removeClass('navbar-default').addClass('navbar-inverse');
                                }

                            }
                        });
                    }
                );
            });
            function home_animate(index)
            {
                switch (index) {
                    case 1:
                        $('.navbar-inverse').removeClass('navbar-inverse').addClass('navbar-default');
                        $('.section1').find('.left').delay(500).animate({
                            left: '0'
                        }, 1000);
                        $('.section1').find('.right').delay(500).animate({
                            right: '0'
                        }, 1000);

                    break;
                }

            }
            Form.api.bindevent();
        },
    };

    return Controller;
});