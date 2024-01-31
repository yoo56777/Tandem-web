function getAll(){
    // var dataUrl = "http://172.16.82.2:9090/com/getAll"
    var dataUrl = "http://localhost:9090/com/getAll"

    $('#com-list').empty();
    $.ajax({
        url: dataUrl,
        method: 'GET',
        dataType: 'text',
        data: '',
        async: true,

        success: res => {
            var resList = JSON.parse(res) // string 轉 JSON object
            console.log(resList)
            $.each(resList, function(i, n){
                $('#com-list').append('<div class="product">'+
                                           '<a href="product.html?id='+n.commodityID+'" style="display:block">'+
                                           '<img src='+n.commodityImgPath+'>'+
                                           '<p>'+n.commodityName+'</p>'+
                                           '</a>'+
                                           '<a href="#"><button type="button" style="width: 50%">直接購買</button></a>'+
                                      '</div');
            })
        },
    //     <div class="product">
    //     <a href="product.html">
    //     <img src="博美1.jpg" alt="圖片一">
    //     <p>商品一</p>
    //     </a>
    //     <a href="#"><button type="button" style="width: 50%">直接購買</button></a>
    //     </div>
        error: err => {
            console.log(err)
        },
    });
}

 