local cb=nil;
local canClick=true;
local quality=nil;
function Refresh(_data,isShowTips)
    this.data=_data;
    if this.data then
        local card=_data:GetCard();
        SetIcon(card==true and _data:GetIcon() or _data:GetModelCfg().icon);
        SetLv(_data:GetLv());
        SetQuality(_data:GetQuality());
        SetTipsIcon(isShowTips);
        CSAPI.SetGOActive(nilObj,true);
    else
        InitNull();
    end
end

function SetIcon(iconName)
    CSAPI.SetGOActive(icon,iconName~=nil);
    if iconName then
        ResUtil.RoleCard:Load(icon, iconName)
    end
end

function SetLv(lv)
    CSAPI.SetGOActive(lvObj,lv~=nil);
    if lv then
        CSAPI.SetText(txt_lv,tostring(lv));
    end
end

function SetTipsIcon(isShow)
    if this.data~=nil and isShow==true then
        local name=nil;
        if this.data:IsLeader() then
            name="img_02_03";
        elseif this.data:IsNPC() then
            name="img_02_03";       
        end
        if name~=nil then
            CSAPI.LoadImg(tipsIcon,string.format("UIs/Team/%s.png",name),true,nil,true);
        end
    end
    CSAPI.SetGOActive(tipsIcon,false);
end

function SetQuality(_quality)
    if quality~=_quality then
        quality=_quality or 1;
        local frame = TeamSeletFrame[quality];
	    ResUtil.CardBorder:Load(border, frame);
        local idx=_quality>2 and quality or 3;
        ResUtil.CardBorder:Load(qualityImg,"img_02_0"..idx);
    end
end

function ActiveClick(isActive)
    canClick=isActive;
    CSAPI.SetGOActive(clickImg,isActive);
end

function InitNull()
    SetQuality(1);
    SetIcon();
    SetLv();
    SetTipsIcon();
    CSAPI.SetGOActive(nilObj,true);
    ActiveClick(canClick)
end

function SetClickCB(_cb)
    cb=_cb;
end

--点击
function OnClickSelf()
    if cb and canClick then
        cb(this);
    end
end