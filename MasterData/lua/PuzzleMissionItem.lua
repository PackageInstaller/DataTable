--拼图任务
local data=nil;
local grid=nil;
local isGet=false;
local isFinish=false;
local type=nil;
local clickImg=nil;

function Awake()
    clickImg=ComUtil.GetCom(btn,"Image");
end

function Refresh(_data,_type)
    data=_data;
    type=_type;
    if data then
        CSAPI.SetText(txtDesc,data:GetDesc());
        CSAPI.SetText(txtProgress,string.format("<color=#8da621>%s</color><color=#6e793d>/%s</color>",data:GetCnt(),data:GetMaxCnt()));
        --创建奖励物品格子
        SetReward();
        --设置按钮状态
        isGet = data:IsGet()
        isFinish = data:IsFinish()
        SetBtn();
    end
end

function SetBtn()
    if (isFinish or (not isGet and data:GetJumpID() ~= nil)) then
        if isFinish and isGet then
            CSAPI.SetGOActive(btn,true)
            LanguageMgr:SetText(txtS1, 74024)
            CSAPI.SetTextColorByCode(txtS1,"FFFFFF")
            clickImg.raycastTarget=false;
            CSAPI.LoadImg(img,"UIs/PuzzleActivity/img_11_03.png",true,nil,true);
            CSAPI.SetGOActive(mask,true);
        else
            clickImg.raycastTarget=true;
            LanguageMgr:SetText(txtS1, isFinish and 74015 or 6012)
            CSAPI.SetTextColorByCode(txtS1, isFinish and "FFFFFF" or "8A984D")
            if data:GetJumpID() ~= nil or isFinish then
                CSAPI.SetGOActive(btn,true)
            else
                CSAPI.SetGOActive(btn,false)
            end
            CSAPI.LoadImg(img,string.format("UIs/PuzzleActivity/%s.png",isFinish and "img_11_02" or  "img_11_01"),true,nil,true);
            CSAPI.SetGOActive(mask,false);
        end
    else
        CSAPI.SetGOActive(mask,false);
        CSAPI.SetGOActive(btn,false)
    end

    local b = isFinish and not isGet and true or false
    UIUtil:SetRedPoint(btn, b, 60, 30, 0)
end

function SetReward()
    local h,w=472,74;
    CSAPI.SetGOActive(node,type~=ePuzzleType.Type2);
    if type~=ePuzzleType.Type2 then
        h=376;
        local rewards = data:GetJAwardId()
        CSAPI.SetText(num,"x"..tostring(rewards[1].num));
    end
    CSAPI.SetRectSize(txtDesc,h,w);
    -- local rewards = data:GetJAwardId()
    -- if grid==nil then
    --     local go=nil;
    --     go,grid = ResUtil:CreateRewardGrid(node.transform)
    --     CSAPI.SetScale(go,0.5,0.5);
    -- end
    -- local data = rewards and rewards[1] or nil
    -- if (data) then
    --     local result, clickCB = GridFakeData(data)
    --     grid.Refresh(result)
    --     grid.SetClickCB(clickCB)
    --     grid.SetCount(data.num)
    --     CSAPI.SetGOActive(grid.gameObject, true)
    -- else
    --     CSAPI.SetGOActive(grid,false);
    -- end
end

function OnClickBtn()
    if data then
        if (not isGet and isFinish) then
            MissionMgr:GetReward(data:GetID())
            if CSAPI.IsADV() or CSAPI.IsDomestic() then
                BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_MAINTASK_FINISH);
            end
            -- end
        elseif (not isGet and not isFinish) then
            if (data:GetJumpID()) then
                JumpMgr:Jump(data:GetJumpID())
            end
        end
    end
end