
function Refresh(data)
    if data then
        CSAPI.LoadImg(descIcon,"UIs/ShopComm/"..data.icon..".png",true,nil,true);
        CSAPI.SetText(descTxt,LanguageMgr:GetByID(data.lID));
    end
end
