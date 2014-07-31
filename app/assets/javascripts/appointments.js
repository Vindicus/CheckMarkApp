$(document).ready(function(){
  var ArrayIndex=$(".fields").length-1;
  var clone;
  
  //This function is for the form field appointment#create when a user decides to remove a friend's email
  //Changes the value of the hidden field to 1 indicates removal
  $(document).on( 'click', '.remove', function(){
    $(this).prev("input[type=hidden]").val("1");
    $(this).first().parent().hide();
  });
  
  //Creates a clone field when user wants to send appointments to more than one friend
  $(".add").click(function(){
    clone=$(".add").prev().children(".first_field").first().clone();
    clone.removeClass("first_field");
    clone.css("display","");
    ArrayIndex++;
    clone.find("label").attr("for","appointment_invitations_attributes_"+ArrayIndex+"_invite_email");
    clone.find("input[type=email]").attr("id","appointment_invitations_attributes_"+ArrayIndex+"_invite_email").attr("name","appointment[invitations_attributes]["+ArrayIndex+"][invite_email]").val("");
    clone.find("input[type=hidden]").attr("id","appointment_invitations_attributes_"+ArrayIndex+"_accept").attr("name","appointment[invitations_attributes]["+ArrayIndex+"][accept]")
    $(".emailF").append(clone);
  });
  
  $("p.queued-msg").parent().addClass("accept");
});
