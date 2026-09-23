local data = nil
local datas = nil
local assistData = nil
local items = nil
local assistItem = nil
local rankType = nil
local dungeonId = 0
local assistSkillId = 0
local teamData = nil

function Refresh(_data, _elseData)
    data = _data
    rankType = _elseData and _elseData.type
    dungeonId = _elseData and _elseData.dupId or 0
    assistSkillId = _elseData and _elseData.skillId or 0
    if data then
        SetBoss()
        SetData()
        SetItems()
        SetAssist()
        SetBuff()
    end
end

function SetBoss()
    local cfgDungeon = Cfgs.MainLine:GetByID(dungeonId)
    local name = ""
    if cfgDungeon then
        if cfgDungeon.bossHead then
            ResUtil.TrialsList:Load(icon1, cfgDungeon.bossHead)
        end
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

function SetData()
    if teamData == nil then
        teamData = TeamData.New()
        teamData:SetData(data)
    end
    datas = {}
    for i = 1, 5 do
        local _data = teamData:GetItemByIndex(i) or {
            isEmpty = 1
        }
        table.insert(datas, _data)
    end
    assistData = teamData:GetItemByIndex(6) or {
        isEmpty = 1
    }
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Rank/RankTeamCard",items,datas,itemParent,OnItemClickCB)
end

function OnItemClickCB(item)
    if item.cardData.data then
        CSAPI.OpenView("RoleInfo", item.cardData)
    end
end

function SetAssist()
    if assistItem then
        assistItem.Refresh(assistData)
    else
        ResUtil:CreateUIGOAsync("Rank/RankTeamCard",assistParent,function (go)
            assistItem = ComUtil.GetLuaTable(go)
            assistItem.SetIndex(6)
            assistItem.SetClickCB(OnItemClickCB)
            assistItem.Refresh(assistData)
        end)
    end
end

function SetBuff()
    CSAPI.SetGOActive(buffEmpty,assistSkillId == 0)
    CSAPI.SetGOActive(iconParent2,assistSkillId ~= 0)
    if assistSkillId > 0 then
        local _cfg = Cfgs.CfgBuffChain:GetByID(assistSkillId)
        local iconName = _cfg and _cfg.icon or ""
        if iconName and iconName ~= "" then
            ResUtil.BuffChain:Load(icon2,iconName)
        end
    end
end
