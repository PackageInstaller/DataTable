local data=nil;
local isGet=nil;
local isFinish=nil;
local grids={};
local clickImg=nil;
function Awake()
    clickImg=ComUtil.GetCom(btnReward,"Image")
end

function Refresh(_d)
    data=_d
    if data then
        CSAPI.SetText(txtContent,data:GetDesc());
        isGet = data:IsGet()
        isFinish = data:IsFinish()
        SetBtn()
        SetReward();
    end
end

function SetBtn()
    if (isFinish or (not isGet and data:GetJumpID() ~= nil)) then
        if isFinish and isGet then
            CSAPI.SetGOActive(btnReward,false)
            CSAPI.SetGOActive(overObj,true)
            clickImg.raycastTarget=false;
        else
            clickImg.raycastTarget=true;
            LanguageMgr:SetText(txtState, isFinish and 330006 or 330007)
            CSAPI.SetTextColorByCode(txtState, isFinish and "fffd4f" or "512213")
            CSAPI.SetGOActive(btnReward,true)
            CSAPI.SetGOActive(overObj,false)
        end
    else
        CSAPI.SetGOActive(overObj,false);
        clickImg.raycastTarget=false;
        LanguageMgr:SetText(txtState, isFinish and 330006 or 330007)
        CSAPI.SetTextColorByCode(txtState, isFinish and "fffd4f" or "512213")
        CSAPI.SetGOActive(btnReward,true)
    end
    local b = isFinish and not isGet and true or false
    UIUtil:SetRedPoint(btnReward, b, 60, 30, 0)
end

function SetReward()
    local rewards = data:GetJAwardId()
    ItemUtil.AddItems("GoldenRebate/GoldenRebateGridItem",grids,rewards,layout,nil,1);
end

function OnClickReward()
    if data then
        if (not isGet and isFinish) then
            MissionMgr:GetReward(data:GetID())
            if CSAPI.IsADV() or CSAPI.IsDomestic() then
                BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_MAINTASK_FINISH);
            end
        -- elseif (not isGet and not isFinish) then
        --     if (data:GetJumpID()) then
        --         JumpMgr:Jump(data:GetJumpID())
        --     end
        end
    end
end