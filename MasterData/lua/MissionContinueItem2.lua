local cb = nil
local slider = nil
local isGet = false
local isFinish = false
local rItems = nil
local canvasGroup = nil

function Awake()
    slider = ComUtil.GetCom(finshSlider, "Slider")
    canvasGroup = ComUtil.GetCom(node, "CanvasGroup")
end

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(idx)
    index = idx
end

function Refresh(_data)
    info = _data
    if info then
        isGet = info:IsGet()
        isFinish = info:IsFinish()
        SetTitle()
        SetSlider()
        SetReward()
        SetState()
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle, info:GetName())
end

function SetSlider()
    CSAPI.SetText(txtNum, info:GetCnt() .. "/" .. info:GetMaxCnt())
    slider.value = info:GetCnt() / info:GetMaxCnt()
end

function SetReward()
    local gridDatas = GridUtil.GetGridObjectDatas(info:GetJAwardId())
    rItems = rItems or {}
    ItemUtil.AddItems("Activity2/MissionContinueReward", rItems, gridDatas, rewardParent, GridClickFunc.OpenInfoSmiple, 1)
end

function SetState()
    CSAPI.SetGOActive(btnJump, not isGet and not isFinish)
    CSAPI.SetGOActive(btnGet, isFinish and not isGet)
    CSAPI.SetGOActive(txtFinish, isGet)
    canvasGroup.alpha = isGet and 0.5 or 1

    --red
    UIUtil:SetRedPoint2("Common/Red2", btnGet, info:IsFinish() and not info:IsGet(), 104, 27)
end

function OnClickBtn()
    if (info) then
        if cb then
            cb(info)
            return
        end
        if (not info:IsGet() and info:IsFinish()) then
            if (MissionMgr:CheckIsReset(info)) then
                -- LanguageMgr:ShowTips(xxx)
                LogError("任务已过期")
            else
                MissionMgr:GetReward(info:GetID())
            end
        elseif (not info:IsGet() and not info:IsFinish()) then
            if (info:GetJumpID()) then
                JumpMgr:Jump(info:GetJumpID())
            end
        end
    end
end
