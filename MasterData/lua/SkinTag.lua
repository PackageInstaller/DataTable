--皮肤标签
local skinInfo=nil;
function Refresh(_d,_elseData)
    skinInfo=_elseData and _elseData.skinInfo or nil;
    if _d then
        CSAPI.LoadImg(img,"UIs/ShopComm/".._d..".png",true,nil,true);
        local isShow=_elseData and this.index<_elseData.count or false;
        CSAPI.SetGOActive(line,isShow);
    end
end

function SetIndex(_i)
    this.index=_i
end

function OnClick()
    if skinInfo then
        CSAPI.OpenView("SkinTagDesc",skinInfo);
    end
end