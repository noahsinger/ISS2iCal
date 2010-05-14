$(function( ) {
	// Accordion
	$("#accordion").accordion({ header: "h2", autoHeight: false, collapsible: true, active: false });
	
	vertical_center( $("#content"), -80 );
	bottom_position( $("#display"), 430 );
	setup_scale_page( );
});

var display_speed = "fast";

function display_content( text ) {
	display_nothing( function( ) {
		$("#threesuns #display").find( ".content" ).append( text );
		$("#threesuns #display").find( ".content" ).fadeIn( display_speed, function( ) {
			bottom_position( $("#display"), 430 );
		});
	});
}

function display_nothing( callback ) {
	$("#threesuns #display").find( ".content" ).fadeOut( display_speed, function( ) {
		$("#threesuns #display").find( ".content" ).empty( );
		$("#threesuns #display").find( "#threesuns_link" ).fadeOut( display_speed, function( ) {
			if( callback ) callback( );
		});	
	});
}

function display_threesuns( ) {
	if( $("#threesuns #display").find( ".content" ).css("display") != "none"  ) {
		$("#threesuns #display").find( ".content" ).fadeOut( display_speed, function( ) {
			show_threesuns_link( );
		});
	} else {
		show_threesuns_link( );
	}
}

function show_threesuns_link( ) {
	if( $("#threesuns #display").find( "#threesuns_link" ).css("display") == "none"  ) {
		$("#threesuns #display").find( "#threesuns_link" ).fadeIn( display_speed );
	}
}

function vertical_center( element, adj ) {
	var window_height = $(window).height( );
	var content_height = $(element).height( );
	
	var y = (window_height - content_height) / 2;
	
	if( y > 0 ) {
		$(element).css( "top", (y + adj) );
	}
}

function bottom_position( element, bottom ) {
	var content_height = $(element).height( );
	var new_bottom = bottom - content_height;
	$(element).css( "top", new_bottom );
}

function setup_scale_page( ) {
	//monitor position
	$(window).scroll( function( ) {
		// var pos = $(window).scrollTop( );
	});
	
	$(window).scrollTo( $("#sun h2"), 2000, {offset: {left: 0, top: -463}, easing:'easeInOut'} );
	
	//setup links
	$("a.planet_link").each( function( ) {		
		var light_speed_multiple = 100;
		var next_planet = $($(this).attr("href"));
		var travel_time = (next_planet.find( ".travel_time" ).text( ) * 1000) / light_speed_multiple;
		
		$(this).before( "<p>Travel time to <strong>" + next_planet.find("h2").text( ) + "</strong> will be <strong>" + (travel_time / 1000) + "</strong> seconds at <strong>" + light_speed_multiple + "</strong> times the speed of light</p>" );
		
		$(this).click( function( ) {
			display_content( 'In transit to ' + next_planet.find("h2").text( ) );
			$(window).scrollTo( next_planet.find("h2"), travel_time || 0, {offset: {left: 0, top: -463}, easing:'easeInOut', onAfter: function( ) {
				display_content( 'Arrived at ' + next_planet.find("h2").text( ) );
			}} );
			return false;
		});
	});
}