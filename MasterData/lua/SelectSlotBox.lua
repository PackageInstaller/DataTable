local idx=nil;
function OnOpen()
    if data then
        local cfg=Cfgs.CfgSuit:GetByID(data.suitID);
        idx=data.idx
        for i=1,5 do
            ResUtil.EquipSkillIcon:Load(this["selBorder"..i], EquipQualityFrame[data.quality],false);
            CSAPI.SetImgColorByCode(this["slot"..i],EquipQualityColor[data.quality],true);
            ResUtil.EquipSkillIcon:Load(this["selIcon"..i], cfg.icon .. "")
            CSAPI.SetGOActive(this["onObj"..i],idx and idx==i or false);
        end
    end
end

function SetChoosie(_idx)
    for i=1,5 do
        CSAPI.SetGOActive(this["onObj"..i],_idx and i==_idx or false);
    end
end

function OnClick(go)
    for i=1,5 do
        if go==this["selBox"..i] then
            if idx==i then
                idx=nil
            else
                idx=i;
            end
            SetChoosie(idx);
            break;
        end
    end
end

function OnClickClose()
    EventMgr.Dispatch(EventType.Equip_Combine_SelSlot,idx);
    view:Close();
end

function OnClickOK()
    OnClickClose()
end