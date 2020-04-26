document.addEventListener("DOMContentLoaded", e => {
  Payjp.setPublicKey("pk_test_08732027da1662b188a9926a");
  
  const btn = document.getElementById("token_submit");
  btn.addEventListener("click", e => {
    e.preventDefault();
    
    const card = {
      number: document.getElementById("card_number").value,
      cvc: document.getElementById("cvc").value,
      exp_month: document.getElementById("exp_month").value,
      exp_year: document.getElementById("exp_year").value
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        $("#card_token").append(
          $('<input type="hidden" name="payjp_token">').val(response.id)
        );
        document.inputForm.submit();
        console.log("payjp-token")
        alert("登録が完了しました");
      } else {
        alert("カード情報が正しくありません");
      }
    });
  });
});
