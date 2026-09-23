--战斗信息界面的通用框
function Refresh(iconName,borderName,lv,iconLoader,isBorderLoader)
    if iconName then
        if iconLoader then
            iconLoader:Load(icon,iconName);
        else
            ResUtil.IconGoods:Load(icon,iconName);
        end
        
    end
    if borderName then
       if isBorderLoader then
            iconLoader:Load(border,borderName);
        else
            ResUtil.IconGoods:Load(border,borderName);
        end
    end
    SetLv(lv);
end

function SetLv(str)
    if str~=nil and str~="" then
        CSAPI.SetGOActive(lvObj,true);   
        CSAPI.SetText(txt_lv,tostring(str));
    else
        CSAPI.SetGOActive(lvObj,false);       
    end
end

function SetIconScale(scale)
    scale=scale or 1;
    CSAPI.SetScale(icon,scale,scale,scale)
end