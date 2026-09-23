--皮肤标签
function Refresh(_d,count)
    if _d then
        CSAPI.LoadImg(img,"UIs/ShopComm/".._d..".png",true,nil,true);
        CSAPI.SetGOActive(line,this.index<count);
    end
end

function SetIndex(_i)
    this.index=_i
end