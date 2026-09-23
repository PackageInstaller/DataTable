local isGet = false
local cfg

function Awake()
    slider = ComUtil.GetCom(zfSlider, "Slider")
    cg_node = ComUtil.GetCom(node,"CanvasGroup")
end

function Refresh(_data)
    cfg = _data:GetCfg()
    isGet = false

    local curLv = ExerciseMgr:GetRankLevel()
    local curScore = ExerciseMgr:GetScore()

    -- icon 
    SetGrade(cfg.icon)
    -- name 
    CSAPI.SetText(txtName, cfg.name)
    -- slider 
    local num1 = 0
    local num2 = cfg.nScore
    if (curLv < cfg.id) then
        slider.value = 0
    elseif (curLv == cfg.id) then
        slider.value = curScore / cfg.nScore
        num1 = curScore
    else
        slider.value = 1
        isGet = true
        num1 = num2
    end
    CSAPI.SetText(txtCount, string.format("%s/%s", num1, num2))
    -- rewards
    SetGetItems()
    -- 
    cg_node.alpha = slider.value == 1 and 0.5 or 1
end

-- 段位图标
function SetGrade(iconName)
    CSAPI.SetGOActive(imgGrade, iconName ~= nil)
    if (iconName) then
        ResUtil.ExerciseGrade:Load(icon, iconName, true)
    end
end

function SetGetItems()
    items = items or {}
    local rewards = GetCurRewards()
    ItemUtil.AddItems("ExerciseL/ExerciseLRankRewardItem2", items, rewards, grid, nil, 1, isGet)
end

function GetCurRewards()
    local _cfg = Cfgs.CfgPracticeRankLevel:GetByID(cfg.id + 1)
    if (_cfg) then
        return _cfg.rewards
    else
        return {}
    end
end
