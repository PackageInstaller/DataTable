local cb = nil
local slider = nil
local isDay = false
local isGet = false
local isFinish = false
local rItems = nil

function Awake()
    slider = ComUtil.GetCom(numSlider, "Slider")
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
        SetDay()
        SetSlider()
        SetReward()
        SetState()
    end
end

function SetDay()
    local cfg = info:GetCfg()
    isDay = cfg and cfg.type == 1
    CSAPI.SetGOActive(dayTag, isDay)
    if isDay then
        if isGet then
            CSAPI.SetTextColorByCode(txt_day, "929296")
            CSAPI.LoadImg(dayTag, "UIs/RegressionActivity3/img_05_02.png", true, nil, true)
        else
            CSAPI.SetTextColorByCode(txt_day, "ffffff")
            CSAPI.LoadImg(dayTag, "UIs/RegressionActivity3/img_05_01.png", true, nil, true)
        end
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
    ItemUtil.AddItems("Activity2/MissionContinueReward", rItems, gridDatas, rewardParent, GridClickFunc.OpenInfoSmiple,
        1)
end

function SetState()
    CSAPI.SetGOActive(btnJump, not isGet and not isFinish)
    CSAPI.SetGOActive(btnGet, isFinish and not isGet)
    CSAPI.SetGOActive(txtFinish, isGet)
    CSAPI.SetGOAlpha(node, isGet and 0.5 or 1)
end

function OnClickGet()
    if (MissionMgr:CheckIsReset(info)) then
        -- LanguageMgr:ShowTips(xxx)
        LogError("任务已过期")
    else
        MissionMgr:GetReward(info:GetID())
    end
end

function OnClickJump()
    if (info:GetJumpID()) then
        JumpMgr:Jump(info:GetJumpID())
    end
end
