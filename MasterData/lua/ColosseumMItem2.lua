function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_datas, _oldID)
    cfg = _datas[1]
    alpha = _datas[2]
    isOpen = _datas[3]
    oldID = _oldID

    CSAPI.SetGOActive(entity, isOpen)
    CSAPI.SetGOActive(empty, not isOpen)
    -- alpha 
    if (not isOpen) then
        return
    end

    CSAPI.SetGOAlpha(gameObject, alpha)
    -- icon
    local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(cfg.nGroupID) -- mainLineCfg.enemyPreview[1])
    local monsterCfg = Cfgs.MonsterData:GetByID(monsterGroupCfg.monster)
    local modelCfg = Cfgs.character:GetByID(monsterCfg.model)
    ResUtil.FightCard:Load(icon, modelCfg.Fight_head)
    -- theme 
    local themeCfg = Cfgs.cfgColosseumThemeType:GetByID(cfg.themeType)
    local themeName = themeCfg.icon
    ResUtil.Colosseum:Load(themeIcon, themeName)
    -- name
    LanguageMgr:SetText(txtName1, 64014, cfg.turn)
    CSAPI.SetText(txtName2, themeCfg.name)
    -- pass 
    local isPass = false
    local starNum = 0
    local dungeonData = DungeonMgr:GetDungeonData(cfg.id)
    if (dungeonData and dungeonData:IsPass()) then
        isPass = true
        starNum = dungeonData:GetStar()
    end
    CSAPI.SetGOActive(pass, isPass)
    for k = 1, 3 do
        CSAPI.SetImgColorByCode(this["star" .. k],starNum >= k and "ffc146" or "b7b7b7")
    end
end

function Select(b)
    CSAPI.SetGOActive(select, b)
end

-- 自选  
function OnClick()
    if (isOpen and alpha == 1 and cb) then
        cb(this)
    end
end
