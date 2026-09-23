function Refresh(_cfg)
    cfg = _cfg

    -- bg 
    CSAPI.SetGOActive(bg, math.fmod(cfg.id, 2) == 1)
    -- icon 
    SetGrade(cfg.icon)
    -- name 
    local nameColor = GetRealIndex() == cfg.id and "ffc146" or "ffffff"
    StringUtil:SetColorByName(txtName, cfg.name, nameColor)
    -- zf 
    StringUtil:SetColorByName(txtZf, cfg.scoreShow, nameColor)
    -- items
    items = items or {}
    ResUtil:CreateCfgRewardGrids(items, cfg.rewards, grid)
end

-- 段位图标
function SetGrade(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if (iconName) then
        ResUtil.ExerciseGrade:Load(icon, iconName, true)
    end
end

function GetRealIndex()
    local rankLv = ExerciseMgr:GetRankLevel()
    return math.ceil(rankLv / 5)
end
