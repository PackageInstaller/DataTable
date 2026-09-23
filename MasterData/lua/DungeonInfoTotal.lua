local cfg = nil
local data = nil --dungeonData
local sectionData = nil
local slider = nil

function Awake()
    slider = ComUtil.GetCom(hpSlider,"Slider")
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetName()
        SetNum()
    end
end

function SetName()
    CSAPI.SetText(txtName, cfg.name)
end

function SetNum()
    local max = cfg.hp or 1
    local cur = max
    if TotalBattleMgr:IsFighting() then
        local fightInfo = TotalBattleMgr:GetFightInfo()
        if fightInfo and fightInfo.id == cfg.id then
            cur = TotalBattleMgr:GetFightBossHp()
        end
    end
    slider.value = cur / max
    CSAPI.SetText(txtNum,cur.."/"..max)
end