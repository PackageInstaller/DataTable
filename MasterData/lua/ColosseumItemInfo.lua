local alpha = 0.5
local goGoals = {}

function Awake()

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Team_Data_Update, function()
        SetTeams()
        CSAPI.SetGOAlpha(btnChallenge, alpha)
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(_data, _closeCB)
    cfg = _data
    closeCB = _closeCB
    -- name
    CSAPI.SetText(txtName1, cfg.name)
    LanguageMgr:SetText(txtName2, 64014, cfg.turn)
    -- targets
    SetTargets()
    -- teams
    SetTeams()
    -- 
    CSAPI.SetGOAlpha(btnChallenge, alpha)
end

function SetTargets()
    local starInfos = DungeonUtil.GetStarInfo4(cfg.id)
    targetItems = targetItems or {}
    if #starInfos > 0 then
        for i = 1, 3 do
            if #goGoals >= i then
                CSAPI.SetGOActive(goGoals[i].gameObject, true)
                goGoals[i].Init(starInfos[i].tips, starInfos[i].isComplete);
            else
                ResUtil:CreateUIGOAsync("FightTaskItem/FightBigTaskItem", goalTitle, function(go)
                    goGoals = goGoals or {};
                    local item = ComUtil.GetLuaTable(go);
                    CSAPI.SetGOActive(item.gameObject, true)
                    item.Init(starInfos[i].tips, starInfos[i].isComplete);
                    table.insert(goGoals, item);
                end);
            end
        end
    end
end

function SetTeams()
    local teamData = TeamMgr:GetTeamData(ColosseumMgr:GetTeamIndex(cfg.modeType))
    local itemDatas = {}
    for k = 1, 5 do
        local _data = teamData:GetItemByIndex(k)
        table.insert(itemDatas, _data ~= nil and _data:GetCard() or {})
    end
    items = items or {}
    ItemUtil.AddItems("RoleLittleCard/RoleSmallCard", items, itemDatas, teamGrids, ItemClickCB)

    alpha = teamData:GetCount() > 0 and 1 or 0.5
end

function ItemClickCB(item)
    if (item.data ~= nil) then
        local id = item.data:GetID()
        CSAPI.OpenView("RoleInfo", item.data)
    end
end
function OnClickEnemy()
    local monsters = {}
    local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(cfg.nGroupID)
    local _monsters = monsterGroupCfg.monsters or {}
    for k, v in ipairs(monsterGroupCfg.stage) do
        for p, q in ipairs(v.monsters) do
            table.insert(monsters, {
                id = q,
                -- level = mainLineCfg.previewLv,
                isBoss = q == monsterGroupCfg.monster
            })
        end
    end
    CSAPI.OpenView("FightEnemyInfo", monsters)
end

function OnClickChallenge()
    local teamData = TeamMgr:GetTeamData(ColosseumMgr:GetTeamIndex(cfg.modeType))
    if (teamData and teamData:GetCount() > 0) then
        local duplicateTeamDatas = TeamMgr:DuplicateTeamData(1, teamData)
        local indexList = {ColosseumMgr:GetTeamIndex(cfg.modeType)}
        DungeonMgr:ApplyEnter(cfg.id, indexList, {duplicateTeamDatas})
    else 
        LanguageMgr:ShowTips(44003)
    end
end

-- function OnClickMask()
--     if (closeCB) then
--         closeCB()
--     end
-- end
