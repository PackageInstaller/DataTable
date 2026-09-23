--道具池奖励说明子物体
local items={};
function Refresh(d)
    if d==nil then
        do return end
    end
    if d.min==d.max and (d.type~=ItemPoolExtractType.DropLoop or d.type~=ItemPoolExtractType.RoundLoop) and d.min<=d.maxRounds then
        CSAPI.SetText(txtTitle,LanguageMgr:GetByID(60109,string.format("<color=#ffc146>%s</color>",d.min)));  
    elseif (d.type==ItemPoolExtractType.DropLoop or d.type==ItemPoolExtractType.RoundLoop) and d.max<d.maxRounds then
        CSAPI.SetText(txtTitle,LanguageMgr:GetByID(60113,string.format("<color=#ffc146>%s</color>",d.min),string.format("<color=#ffc146>%s</color>",d.max)));  
    else
        CSAPI.SetText(txtTitle,LanguageMgr:GetByID(60114,string.format("<color=#ffc146>%s</color>",d.min)));  
    end
    local list={};
    if d.infos~=nil then
        list=d.infos;
    end
    ItemUtil.AddItems("ItemPool/ItemPoolRewardGrid", items, list, itemRoot);
end