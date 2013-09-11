$(document).on 'click', "#add_a_community_link", ->
  $(this).parent().next().slideToggle()
  false
$(document).on 'click', "#community_header_info_link", ->
  $(this).parent().parent().find('.info').slideToggle()
  false