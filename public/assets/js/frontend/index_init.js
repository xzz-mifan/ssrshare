$(function(){
    /* 每日背景图 */
    $.ajax({
        url:'/api/Unofficial/bingImage',
        dataType:'json',
        async:false,
        success:function(data) {
            $('body').css('background',' url('+data.data+') 50%');
            // #dowebok div:eq(0)
            home_animate(1);
            $('#dowebok').fullpage({
                // sectionsColor: ['#1bbc9b', '#4BBFC3', '#7BAABE', '#f90'],
                anchors: ['page1', 'page2', 'page3', 'page4'],
                menu: '#menu',
                verticalCentered:true,
                navigation:true,
                paddingTop:"40px",
                afterLoad:function (anchorLink,index) {
                    home_animate(index);
                }
            });
        },

    })
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
        default:
            $('.navbar-default').removeClass('navbar-default').addClass('navbar-inverse');
    }

}