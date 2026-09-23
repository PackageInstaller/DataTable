local isGet = false
local isFinish = false
local CloseCB = nil 
function Awake()
    mSlider = ComUtil.GetCom(Slider, "Slider")
    cg_node = ComUtil.GetCom(node, "CanvasGroup")
end

function Refresh(_data,_CloseCB)
    CloseCB = _CloseCB
    if (_data) then
        data = _data
        isGet = data:IsGet()
        isFinish = data:IsFinish()

        SetNode()
        SetDesc(data:GetDesc())
        SetCount(data:GetCnt(), data:GetMaxCnt())
        SetBtn()
        SetReward()
    end
end

function SetNode()
    cg_node.alpha = isGet and 0.3 or 1
end

function SetDesc(str)
    -- CSAPI.SetTextColorByCode(txtDesc, not isFinish and not isGet and "ffffff" or "000000")
    CSAPI.SetText(txtDesc, str)
end

function SetCount(cur, max)
    local str = cur .. " / " .. max
    CSAPI.SetText(txtCount, str)

    mSlider.value = max and (cur / max) or 0
end

function SetBtn()
    local b = false
    if ((isFinish and not isGet) or (not isGet and data:GetJumpID() ~= nil)) then
        b = true 
    end
    CSAPI.SetGOActive(btn, b)
    CSAPI.SetGOActive(success, isGet)
    if (b) then
        CSAPI.SetGOActive(btnBg1, isFinish)
        CSAPI.SetGOActive(btnBg2, not isFinish)
        LanguageMgr:SetText(txtBtn1, isFinish and 6011 or 6012)
        LanguageMgr:SetEnText(txtBtn2, isFinish and 6011 or 6012)
    end

    local b = isFinish and not isGet and true or false
    UIUtil:SetRedPoint(node, b, 662, 71, 0)
end

function SetReward()
    grids = grids and grids or {}
    for i, v in ipairs(grids) do
        CSAPI.SetGOActive(v.gameObject, false)
    end
    local rewards = data:GetJAwardId()
    local item, go = nil, nil
    for i = 1, 3 do
        if (i <= #grids) then
            item = grids[i]
            CSAPI.SetGOActive(item.gameObject, true)
        else
            go, item = ResUtil:CreateRewardGrid(hLayout.transform)
            table.insert(grids, item)
        end
        local data = i <= #rewards and rewards[i] or nil
        if (data) then
            local result, clickCB = GridFakeData(data)
            item.Refresh(result)
            item.SetClickCB(clickCB)
            item.SetCount(data.num)
        else
            item.Refresh(nil, {
                plus = false
            })
            item.SetClickCB(nil)
        end
    end
end

function OnClick()
    if (data) then
        if (not isGet and isFinish) then
            -- if (MissionMgr:CheckIsReset(data)) then
            --     -- LanguageMgr:ShowTips(xxx)
            --     LogError("任务已过期")
            -- else
            MissionMgr:GetReward(data:GetID())
            -- end
        elseif (not isGet and not isFinish) then
            if (data:GetJumpID()) then
                local cfg = Cfgs.CfgJump:GetByID(data:GetJumpID())
                if(cfg.sName=="RogueView") then 
                    if(CloseCB) then 
                        CloseCB()
                    end 
                end 
                JumpMgr:Jump(data:GetJumpID())
            end
        end
    end
end
