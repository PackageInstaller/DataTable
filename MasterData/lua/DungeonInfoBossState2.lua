local cfg = nil
local data = nil
local sectionData = nil
local mCfg=nil;

local hpSlider = nil

function Awake()
    hpSlider = ComUtil.GetCom(sliderHp,"Slider")
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        if cfg and cfg.enemyPreview then
            mCfg = Cfgs.MonsterData:GetByID(cfg.enemyPreview[1]);
        end
        SetLv()
        SetHp()
    end
end

function SetLv()
    local lv=""
    if mCfg then
        lv=tostring(mCfg.level);
    end
    CSAPI.SetText(txtLv,lv)
end

function SetHp()
    local bossData=MultTeamBattleMgr:GetBossInfoByCurData(cfg.id);
    local mHp=0;
    if mCfg then
        mHp=mCfg.maxhp;
    end
    local maxHp=bossData and bossData.totalMaxHp or mHp;
    local hp=bossData and bossData.totalHp or maxHp;

    CSAPI.SetText(txtMaxHp,"/" .. maxHp)
    CSAPI.SetText(txtHp,"" .. hp)
    CSAPI.SetGOActive(sliderImg, hp > 0)

    local percent = maxHp > 0 and hp / maxHp or 0
    hpSlider.value = percent
    local p = math.floor(percent * 10000)
    if p <= 0 and hp > 0 then
        p = 1
    end
    CSAPI.SetText(txtPercent,string.format("%.2f",p / 100) .. "%")
end