--扭蛋奖励界面
function Open(_info)
    if _info then
        local goods=_info:GetGoodInfo();
        if goods then
            ResUtil.GachaBall:Load(ball,ItemPoolActivityMgr:GetGachaBallImgName(goods:GetQuality(),true));
            goods:GetIconLoader():Load(icon,goods:GetIcon());
            CSAPI.SetText(txtName,string.format("%s x%s",goods:GetName(),goods:GetCount()));
        end
    end
    CSAPI.SetGOActive(gameObject,true);
end

function Hide()
    CSAPI.SetGOActive(gameObject,false);
end

function OnClickMask()
    Hide();
end