/*-----------------------------------------------------------------------------------
/*
/* Custom JS
/*
-----------------------------------------------------------------------------------*/

jQuery(document).ready(function() {

/*----------------------------------------------------*/
/*  Back To Top Button
/*----------------------------------------------------*/
    var pxShow = 300;//height on which the button will show
    var fadeInTime = 400;//how slow/fast you want the button to show
    var fadeOutTime = 400;//how slow/fast you want the button to hide
    var scrollSpeed = 300;//how slow/fast you want the button to scroll to top. can be a value, 'slow', 'normal' or 'fast'

    // Show or hide the sticky footer button
    jQuery(window).scroll(function() {

        if (jQuery(window).scrollTop() >= pxShow) {
            jQuery("#go-top").fadeIn(fadeInTime);
        } else {
            jQuery("#go-top").fadeOut(fadeOutTime);
        }

    });

    // Animate the scroll to top
    jQuery("#go-top a").click(function() {
        jQuery("html, body").animate({scrollTop:0}, scrollSpeed);
        return false;
    });

/*----------------------------------------------------*/
/*  Select PGP key
/*----------------------------------------------------*/
    jQuery.fn.selectText = function() {
        var range, selection;
        return this.each(function() {
            if (document.body.createTextRange) {
                range = document.body.createTextRange();
                range.moveToElementText(this);
                range.select();
            } else if (window.getSelection) {
                selection = window.getSelection();
                range = document.createRange();
                range.selectNodeContents(this);
                selection.removeAllRanges();
                selection.addRange(range);
            }
        });
    };

    jQuery.fn.unselectText = function() {
        window.getSelection().removeAllRanges();
    }

    $('.pgp').mouseenter(function() {
        $(this).selectText();
    });

    $('.pgp').mouseleave(function() {
        $(this).unselectText();
    });

});
