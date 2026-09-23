function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_datas, _oldID)
    cfg = _datas[1]
    oldID = _oldID

    if (cfg.isEmpty) then
        CSAPI.SetGOActive(gameObject, false)
        return
    end
    CSAPI.SetGOActive(gameObject, true)
    -- alpha 
    alpha = _datas[2]
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
    if (isPass) then
        CSAPI.SetGOActive(pass, oldID == nil)
        CSAPI.SetGOActive(pass2, oldID ~= nil)
    else
        CSAPI.SetGOActive(pass, false)
        CSAPI.SetGOActive(pass2, false)
    end
    CSAPI.SetGOAlpha(imgNormal, isPass and 1 or 0.5)
    for k = 1, 3 do
        local imgName = starNum >= k and "img_star1.png" or "img_star2.png"
        CSAPI.LoadImg(this["star" .. k], "UIs/Colosseum/" .. imgName, true, nil, true)
        CSAPI.LoadImg(this["Star" .. k], "UIs/Colosseum/" .. imgName, true, nil, true)
    end
end

function Select(b)
    CSAPI.SetGOActive(select, b)
    CSAPI.SetGOActive(imgNormal, not b)
end

-- 自选  
function OnClick()
    if (alpha == 1 and cb) then
        cb(this)
    end
end
