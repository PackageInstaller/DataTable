local data = nil
local cfgBuff = nil

function Refresh(_data)
    data= _data
    if data then
        cfgBuff =Cfgs.CfgBossBuffChain:GetByID(data.buffId)
        SetIcon(data.icon1,data.icon2)
        SetText()
        SetBoss()
    end
end

function SetIcon(iconName1,iconName2)
    if iconName1 and iconName1~="" then
        ResUtil.BuffChain:Load(icon1,iconName1)
    end
    if iconName2 and iconName2~="" then
        ResUtil.TrialsHead:Load(icon2,iconName2)
    end
end

function SetText()
    if cfgBuff then
        CSAPI.SetText(txtName,cfgBuff.name)
        CSAPI.SetText(txtDesc,cfgBuff.desc)
    end
end

function SetBoss()
    local cfgDungeon = Cfgs.MainLine:GetByID(data.dungeonId)
    local name = ""
    if cfgDungeon then
        local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(cfgDungeon.nGroupID)
        for k, v in ipairs(monsterGroupCfg.stage) do
            for p, q in ipairs(v.monsters) do
                if q == monsterGroupCfg.monster then -- boss
                    local cfgMonster = Cfgs.MonsterData:GetByID(q)
                    if cfgMonster and cfgMonster.name then
                        name = cfgMonster.name
                        break
                    end
                end
            end
        end
    end
    CSAPI.SetText(txtBossName, name)
end
