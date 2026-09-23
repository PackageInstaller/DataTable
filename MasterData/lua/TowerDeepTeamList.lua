local assistData = nil
local teamData = nil

function SetIndex(_index, _len, _optionDatas)
    index = _index
    len = _len
    optionDatas = _optionDatas
end

function Refresh(_mainLine)
    mainLineCfg = _mainLine
    if assistData and not TeamMgr:GetAssistCID(eTeamType.TowerDeep + index - 1) then --检测缓存有没有助战，没有则清空助战
        assistData = nil
    end
    SetTeamData(eTeamType.TowerDeep + index - 1)
    -- boss
    SetBoss()
    -- downList 
    SetDownList()
    -- items 
    SetItems()

    CSAPI.SetGOActive(btnSkill,g_TowerDeepAssist == nil)
    CSAPI.SetGOActive(btnAI,g_TowerDeepAssist == nil)
end

function SetBoss()
    local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(mainLineCfg.nGroupID) -- mainLineCfg.enemyPreview[1])
    local monsterCfg = Cfgs.MonsterData:GetByID(monsterGroupCfg.monster)
    local modelCfg = Cfgs.character:GetByID(monsterCfg.model)
    ResUtil.Card:Load(bossIcon, modelCfg.List_head)
    -- 封装 
    monsters = {}
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
end

function SetDownList()
    LanguageMgr:SetText(txtName,130024,index)
    -- 名字
    CSAPI.SetText(txt_teamName, optionDatas[index].desc)
    -- 战力
    if teamData ~= nil then
        local haloStrength = teamData:GetHaloStrength()
        CSAPI.SetText(txt_fight, tostring(teamData:GetTeamStrength() + haloStrength))
    else
        CSAPI.SetText(txt_fight, tostring(0))
    end
    -- 
    CSAPI.SetText(dropVal, "0" .. index)
end

function SetItems()
    itemDatas = {}
    local max = g_TowerDeepAssist ~= nil and 6 or 5
    for k = 1, max do
        local _data = teamData:GetItemByIndex(k) or {
            isEmpty = 1
        }
        table.insert(itemDatas, _data)
    end
    items = items or {}
    ItemUtil.AddItems("TeamConfirm/TowerDeepTeamListItem", items, itemDatas, gridNode, ItemClickCB)
end

function OnCloseFunc(assist)
    assistData = assist
    if assistData ~= nil then
        local card = assist:GetCard();
        TeamMgr:AddAssistTeamIndex(card:GetID(), teamData:GetIndex());
    end
    EventMgr.Dispatch(EventType.Team_Card_Refresh)
end

function ItemClickCB(tab)
    local isAssist = tab.index == 6
    if isAssist then
        SetTeamData(teamData:GetIndex())
        local cid = nil
        if assistData then
            cid = assistData.card:GetID()
        end
        CSAPI.OpenView("TeamView", {
            currentIndex = teamData:GetIndex(),
            canEmpty = true,
            closeFunc = OnCloseFunc,
            is2D = true,
            canAssist = true,
            cid = cid,
            selectType = TeamSelectType.Support
        }, TeamOpenSetting.TowerDeep)
    else
        SetTeamData(teamData:GetIndex())
        CSAPI.OpenView("TeamView", {
            currentIndex = teamData:GetIndex(),
            canEmpty = true,
            closeFunc = OnCloseFunc,
            is2D = true,
            canAssist = true
        }, TeamOpenSetting.TowerDeep)
    end
end

function OnClickBoss()
    CSAPI.OpenView("FightEnemyInfo", monsters)
end

function OnClickDownList() -- 点击下拉框
    -- CSAPI.SetGOActive(dropTween, true)
    -- FuncUtil:Call(function()
    --     CSAPI.SetGOActive(dropTween, false)
    -- end, nil, 400)
    CSAPI.OpenView("RogueSTeamDownList", {optionDatas, OnDropValChange, dropDownList})
end

-- 下拉框的值改变之后
function OnDropValChange(_index)
    if (index ~= _index) then
        local team1 = TeamMgr:GetEditTeam(eTeamType.TowerDeep + index - 1)
        local team2 = TeamMgr:GetEditTeam(eTeamType.TowerDeep + _index - 1)
        team1.index = eTeamType.TowerDeep + _index - 1
        team2.index = eTeamType.TowerDeep + index - 1
        TeamMgr:SaveDatas({team1, team2}, function()
            -- EventMgr.Dispatch(EventType.TeamView_RogueS_Change)
        end)
    end
end

function SetTeamData(index)
    -- TeamMgr.currentIndex = index;
    if teamData then
        TeamMgr:DelEditTeam(index);
    end
    teamData = TeamMgr:GetEditTeam(index);
    local isAssistLimit=false;
    if assistData ~= nil then -- 存在助战卡牌
        PushAssistCard(assistData);
        isAssistLimit=FormationUtil.CheckAssitCardIsLimit(assistData);
    end
    CSAPI.SetGOActive(txt_limitAssistTips,isAssistLimit);
end

-- 放置助战卡牌
function PushAssistCard(assist)
    -- local card =assist.card;
    local card = assist:GetCard();
    -- 判断当前队伍中是否存在同样的人物
    local roleInfo = teamData:GetItemByRoleTag(card:GetRoleTag());
    if roleInfo then
        assistData = nil
        TeamMgr:RemoveAssistTeamIndex(card:GetID());
        SetTeamData(teamData.index);
        Tips.ShowTips(LanguageMgr:GetTips(14010))
        return
    end
    local holderInfo = FormationUtil.GetPlaceHolderInfo(card:GetGrids());
    local formatTab = FormationTable.New(3, 3);
    -- 记录所有的占位信息
    for k, v in pairs(teamData.data) do
        formatTab:AddCardPosInfo(v);
    end
    local teamItemData = TeamItemData.New();
    local isNpc, s1, s2 = FormationUtil.CheckNPCID(card:GetID());
    local tempData = {
        cid = card:GetID(),
        row = assist.row,
        col = assist.col,
        fuid = assist.fuid,
        bIsNpc = isNpc,
        index = 6
    }
    teamItemData:SetData(tempData);
    local isSuccess, pos = formatTab:TryPushTeamItemData(teamItemData);
    if isSuccess then
        teamItemData.col = pos.col;
        teamItemData.row = pos.row;
        teamData:AddCard(teamItemData);
        TeamMgr:AddAssistTeamIndex(card:GetID(), teamData:GetIndex());
    else
        Tips.ShowTips(LanguageMgr:GetTips(14007));
        TeamMgr:RemoveAssistTeamIndex(card:GetID());
        assistData = nil;
    end
end

function OnClickAI()
    if teamData then
        if teamData:GetRealCount()<=0 then
            Tips.ShowTips(LanguageMgr:GetByID(26047))
            do return end
        end
        local isOpen,lockStr=MenuMgr:CheckModelOpen(OpenViewType.special, FormationUtil.AIModuleKey)
        if isOpen~=true then
            Tips.ShowTips(lockStr);
            return
        end
        CSAPI.OpenView("AIPrefabSetting",{teamData=teamData});
    else
        Tips.ShowTips(LanguageMgr:GetByID(26048))
    end
end

function OnClickSkill()
    if teamData and teamData:GetRealCount()>0 then
        local isOpen,lockStr=MenuMgr:CheckModelOpen(OpenViewType.main, FormationUtil.SkillModuleKey)
        if isOpen~=true then
            Tips.ShowTips(lockStr);
            return
        end
        CSAPI.OpenView("TacticsView",{teamData=teamData,closeFunc=OnSkillChange});
    elseif teamData and teamData:GetRealCount()==0 then
        Tips.ShowTips(LanguageMgr:GetByID(26047))
    else
        Tips.ShowTips(LanguageMgr:GetByID(26048))
    end
end

function OnSkillChange(cfgId)
    AbilityProto:SkillGroupUse(cfgId,TeamMgr.currentIndex,function(proto)
        if teamData then
            teamData:SetSkillGroupID(cfgId);
            local teamData2=TeamMgr:GetTeamData(teamData.index);
            teamData2:SetSkillGroupID(cfgId);
            TeamMgr:SaveDataByIndex(teamData.index, teamData2)
        end
        SetSkillIcon(cfgId)
    end);
end

function SetSkillIcon(cfgId)
    if cfgId==nil or cfgId==-1 then
        -- CSAPI.SetGOActive(txtSkill,false)
        -- CSAPI.SetGOActive(txtSkillLv,false)
        CSAPI.SetText(txtSkill,LanguageMgr:GetByID(26015))
        CSAPI.LoadImg(skillIcon,"UIs/TeamConfirm/btn_13_06.png",true,nil,true);
        return
    end
    local tactice=TacticsMgr:GetDataByID(cfgId);
    if tactice then
        CSAPI.SetText(txtSkill,tactice:GetName());
        -- CSAPI.SetText(txtSkillLv,string.format("LV.%s",tactice:GetLv()))
        -- CSAPI.SetGOActive(txtSkill,true)
        ResUtil.Ability:Load(skillIcon, tactice:GetIcon().."_1",false);
        -- CSAPI.SetGOActive(txtSkillLv,true)
    else
        -- CSAPI.SetGOActive(txtSkill,false)
        CSAPI.SetText(txtSkill,LanguageMgr:GetByID(26015))
        CSAPI.LoadImg(skillIcon,"UIs/TeamConfirm/btn_13_06.png",true,nil,true);
        -- CSAPI.SetGOActive(txtSkillLv,false)
    end
end
