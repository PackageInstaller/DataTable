
local data=nil;
function Hide()
    CSAPI.SetGOActive(gameObject,false);
    data=nil;
end

function Show(item)
    CSAPI.SetGOActive(gameObject,true);
    if item~=nil then
        data=item;
        CSAPI.SetText(svText,item:GetCfgID().."_"..item:GetName());
        -- CSAPI.SetText(svText,item.id.."_"..item.name);
    end
end

function OnClick()
    if data~=nil then
        CS.UnityEngine.GUIUtility.systemCopyBuffer = data:GetCfgID();
    end
end