(function($){

    // Index top carousel;
    $('.expert-carousel').length==1&&
        (function(){
            var itemCarousel = $('.expert-carousel .item-carousel');
            var itemCarouselPagination = $('.expert-carousel-pagination');
            var expertLink= $('#expert-link a');
            var clickLock = false;
            itemCarousel.each(function(i){
                $(this).carouFredSel({
                    width:130,
                    height:121,
                    auto:false,
                    scroll:{
                        items:1,
                        duration:300,
                        onBefore:function($Carousel){
                            expertLink.eq(i).attr('href',$Carousel.items.visible.data('href'));
                        }
                    },
                    onCreate:function($Carousel){
                        expertLink.eq(i).attr('href',$Carousel.items.data('href'));
                    }
                });
            });

            itemCarouselPagination.find('a').each(function(i){
                $(this).on('click',function(){
                    if(!clickLock){
                        itemTarget(i);
                        $(this).addClass('selected').siblings().removeClass('selected');
                        clickLock = true;
                        setTimeout(function(){
                            clickLock = false;
                        },400);
                    }

                });
            });

            function itemTarget(i){
                itemCarousel.each(function(){
                    $(this).trigger('slideToPage',i);
                })
            };

            expertLink.each(function(i){
                $(this).on('mouseenter',function(){
                    expertLinkHover(i,'top');
                })
                $(this).on('mouseleave',function(){
                    expertLinkHover(i,'down');
                })
            });
            function expertLinkHover(i,direction){
                var direction = direction == "top" ? "-121":"0"

                itemCarousel.eq(i).trigger('currentPage',function(a){
                    $('li',this).find('img').eq(0).stop(false,true).animate({'marginTop':direction},200);
                });
            }
        })();


})(window.jQuery);