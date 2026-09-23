--回归绑定任务子物体
local isGet = false
local isFinish = false
local grid=nil;
function Awake()
    m_Slider = ComUtil.GetCom(Slider, "Slider")
    cg_node = ComUtil.GetCom(node, "CanvasGroup")
    ResUtil.IconGoods:Load(noneObj, GridFrame[1],true);
end

function Refresh(_data, _isMax)
    if (_data) then
        data = _data
        isGet = data:IsGet()
        isFinish = data:IsFinish()
        isMax = _isMax -- 如果当天/周奖励已经全部领取

        -- isShowBg1 =(not isMax and isFinish and not isGet) and true or false
        
        SetNode()
        SetDesc(data:GetDesc())
        SetCount(data:GetCnt(), data:GetMaxCnt())
        SetBtn()
        SetGrid(data:GetJAwardId()[1]);
    end
end

function SetGrid(_itemInfo)
    local isNil=_itemInfo==nil;
    if grid==nil then
        _,grid=ResUtil:CreateRewardGrid(gridNode.transform);        
    end
    if not isNil then
        local itemData=GridFakeData(_itemInfo);
        grid.Refresh(itemData);
        grid.SetClickCB(GridClickFunc.OpenInfoSmiple);
    else
        grid.Refresh();
    end
end

function SetNode()
    local alpha = 1
    if (isMax or isGet) then
        alpha = 0.38
    end
    cg_node.alpha = alpha
end

function SetDesc(str)
    -- CSAPI.SetTextColorByCode(txtDesc, not isFinish and not isGet and "ffffff" or "000000")
    -- CSAPI.SetTextColorByCode(txtDesc, isShowBg1 and "000000" or "ffffff")
    CSAPI.SetText(txtDesc, str)
end

function SetCount(cur, max)
    local str = cur .. " / " .. max
    CSAPI.SetText(txtCount, str)

    m_Slider.value = (max ~= nil and max ~= 0) and cur / max or 0
end

function SetBtn()
    -- red
    local isAdd = false
    --
    CSAPI.SetGOActive(success, isGet)
    if (isMax) then
        CSAPI.SetGOActive(btnRevice, false)
        CSAPI.SetGOActive(btnJump, false)
        CSAPI.SetGOActive(overObj, false)
    else
        local isOver,isRevice,isJump=false,false,false
        if isFinish then
            if isGet then
                isOver=true;
            else
                isRevice=true;
                isAdd=true
            end
        else
            isJump=true;
        end
        CSAPI.SetGOActive(btnRevice, isRevice)
        CSAPI.SetGOActive(btnJump, isJump)
        CSAPI.SetGOActive(overObj, isOver)
    end

    UIUtil:SetRedPoint(node, isAdd, 482.5, 27.2, 0)
end


function OnClickRevice()
    OnClick()
end

function OnClickJump()
    OnClick()
end

function OnClick()
    if (data and not isGet) then
        if (isFinish) then
            if (MissionMgr:CheckIsReset(data)) then
                -- LanguageMgr:ShowTips(xxx)
                LogError("任务已过期")
            else
                -- MissionMgr:GetReward(data:GetID())
                TaskProto:GetRewardByType(data:GetType())
            end
        else
            if (data:GetJumpID()) then
                JumpMgr:Jump(data:GetJumpID())
            end
        end

    end
end

