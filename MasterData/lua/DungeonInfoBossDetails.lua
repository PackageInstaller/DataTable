local cfg = nil
local data = nil
local sectionData = nil
local recordInfo = nil

function Awake()
    eventMgr =ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClose)
end

function OnViewClose(viewKey)
    if viewKey == "FightEnemyInfo" and recordInfo then
        SetMonsterCfgSkill(recordInfo.id,recordInfo.tfSkills,true)
        recordInfo = nil
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetIcon()
    end
end

function SetIcon()
    local bossData = GlobalBossMgr:GetData()
    if bossData then
        local iconName = bossData:GetIcon()
        if iconName and iconName~="" then
            ResUtil.GlobalBoss:Load(icon,iconName)
        end
    end
end

function OnClickDetails()
    local list = {};
    if cfg and cfg.enemyPreview then
        for k, v in ipairs(cfg.enemyPreview) do
            table.insert(list, {
                id = v,
                isBoss = k == 1
            });
        end
    end
    SetMonsterCfgSkill(list[1].id,GlobalBossMgr:GetSkills())
    CSAPI.OpenView("FightEnemyInfo", list);
end

--设置怪物特效
function SetMonsterCfgSkill(id,info,isClear)
    local cfgMonster = Cfgs.MonsterData:GetByID(id)
    if cfgMonster then
        if cfgMonster.tfSkills and recordInfo == nil then
            recordInfo = {}
            recordInfo.id = id
            recordInfo.tfSkills = {}
            for i, v in ipairs(cfgMonster.tfSkills) do
                table.insert(recordInfo.tfSkills,v)
            end
        end
        if isClear then
            cfgMonster.tfSkills = {}
        end
        if info then
            for i, v in ipairs(info) do
                table.insert(cfgMonster.tfSkills,v)
            end
        end
    end
end