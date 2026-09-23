local cfg = nil
local data = nil
local sectionData = nil

local hpSlider = nil

function Awake()
    hpSlider = ComUtil.GetCom(sliderHp,"Slider")
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetLv()
        SetHp()
    end
end

function SetLv()
    CSAPI.SetText(txtLv,cfg.previewLv and cfg.previewLv .. "" or "")
end

function SetHp()
    CSAPI.SetText(txtMaxHp,"/" .. GlobalBossMgr:GetMaxHp())
    CSAPI.SetText(txtHp,"" .. GlobalBossMgr:GetHp())
    CSAPI.SetGOActive(sliderImg, GlobalBossMgr:GetHp() > 0)

    local percent = GlobalBossMgr:GetMaxHp() > 0 and GlobalBossMgr:GetHp() / GlobalBossMgr:GetMaxHp() or 0
    hpSlider.value = percent
    local p = math.floor(percent * 10000)
    if p <= 0 and GlobalBossMgr:GetHp() > 0 then
        p = 1
    end
    CSAPI.SetText(txtPercent,string.format("%.2f",p / 100) .. "%")
end