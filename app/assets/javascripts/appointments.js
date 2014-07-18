$(document).ready(function(){
var ArrayIndex=$(".fields").length-1;
var clone;
$( document ).on( 'click', '.remove', function(){
  $(this).prev("input[type=hidden]").val("1");
  $(this).first().parent().hide();
});
$(".add").click(function(){
  clone=$(".add").prev().children(".first_field").first().clone();
  clone.removeClass("first_field");
  clone.css("display","");
  ArrayIndex++;
  clone.find("label").attr("for","appointment_invitations_attributes_"+ArrayIndex+"_invite_email");
  clone.find("input[type=email]").attr("id","appointment_invitations_attributes_"+ArrayIndex+"_invite_email").attr("name","appointment[invitations_attributes]["+ArrayIndex+"][invite_email]").val("");
clone.find("input[type=hidden]").attr("id","appointment_invitations_attributes_"+ArrayIndex+"_accept").attr("name","appointment[invitations_attributes]["+ArrayIndex+"][accept]")
//clone.find("input[type=hidden]").attr("id","appointment_invitations_attributes_"+ArrayIndex+"__destroy").attr("name","appointment[invitations_attributes]["+ArrayIndex+"][_destroy]").attr("value","false");
  //$(".add").after();
  $(".emailF").append(clone);
    
  });

$("a.accept").parent().addClass("accept");
  $("a.decline").parent().addClass("decline");
});
