function Refresh(_d,_elseData)
    if _d then
        CSAPI.LoadImg(icon,"UIs/ShopComm/".._d.icon..".png",true,nil,true);
        CSAPI.SetImgColorByCode(tagNode,_d.color2);
    end
end
