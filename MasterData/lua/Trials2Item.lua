
local cfg = nil
local monsters = nil

function SetClickCB(_cb)
    cb =_cb
end

function Refresh(_cfg)
    cfg = _cfg
    if cfg then
        SetIcon()
        SetMonster()
    end
end

function SetMonster()
    local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(cfg.nGroupID)
    -- 封装 
    monsters = {}
    for k, v in ipairs(monsterGroupCfg.stage) do
        for p, q in ipairs(v.monsters) do
            table.insert(monsters, {
                id = q,
                -- level = mainLineCfg.previewLv,
                isBoss = q == monsterGroupCfg.monster
            })
        end
    end

    local bossCfg = nil
    if #monsters > 0 then
        for i, v in ipairs(monsters) do
            if v.isBoss then
                bossCfg = Cfgs.MonsterData:GetByID(v.id)
                break
            end
        end
    end
    CSAPI.SetText(txtName,bossCfg and bossCfg.name or "")
end

function SetIcon()
    local iconName = cfg.icon
    if iconName ~= nil and iconName ~= "" then
        ResUtil.TrialsPage:Load(icon,iconName)
    end
end

function GetMonsters()
    return monsters
end 

function OnClick()
    if cb then
        cb(this)
    end
end