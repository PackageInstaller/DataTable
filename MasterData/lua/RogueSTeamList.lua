function SetIndex(_index, _len, _optionDatas)
    index = _index
    len = _len
    optionDatas = _optionDatas
end

function Refresh(_mainLine)
    mainLineCfg = _mainLine

    teamData = TeamMgr:GetTeamData(eTeamType.RogueS + index)
    -- boss
    SetBoss()
    -- downList 
    SetDownList()
    -- items 
    SetItems()
    -- btns
    SetBtns()
end

function SetBtns()
    local skillId = teamData:GetSkillGroupID()
    SetSkillIcon(skillId)
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
    CSAPI.SetText(txtName, "0" .. index)
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
    teamData = TeamMgr:GetTeamData(eTeamType.RogueS + index)
    SetBtns()
    itemDatas = {}
    for k = 1, 5 do
        local _data = teamData:GetItemByIndex(k) or {
            isEmpty = 1
        }
        table.insert(itemDatas, _data)
    end
    items = items or {}
    ItemUtil.AddItems("TeamConfirm/RogueSTeamListItem", items, itemDatas, gridNode, ItemClickCB)
end

function ItemClickCB(tab)
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.RogueS + index,
        canEmpty = true,
        closeFunc = SetItems,
        is2D = true
    }, TeamOpenSetting.RogueS)
end

function SetSkillIcon(cfgId)
    if cfgId == nil or cfgId == -1 then
        CSAPI.SetText(txtSkill, LanguageMgr:GetByID(26015))
        CSAPI.LoadImg(skillIcon, "UIs/TeamConfirm/btn_13_06.png", true, nil, true)
        return
    end
    local tactice = TacticsMgr:GetDataByID(cfgId)
    if tactice then
        CSAPI.SetText(txtSkill, tactice:GetName())
        ResUtil.Ability:Load(skillIcon, tactice:GetIcon() .. "_1", false)
    else
        CSAPI.SetText(txtSkill, LanguageMgr:GetByID(26015))
        CSAPI.LoadImg(skillIcon, "UIs/TeamConfirm/btn_13_06.png", true, nil, true)
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
        local team1 = TeamMgr:GetTeamData(eTeamType.RogueS + index)
        local team2 = TeamMgr:GetTeamData(eTeamType.RogueS + _index)
        team1.index = eTeamType.RogueS + _index
        team2.index = eTeamType.RogueS + index
        TeamMgr:SaveDatas({team1, team2}, function()
            EventMgr.Dispatch(EventType.TeamView_RogueS_Change)
        end)
    end
end

function OnClickSkill()
    if teamData and teamData:GetRealCount() > 0 then
        local isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.main, FormationUtil.SkillModuleKey)
        if isOpen ~= true then
            Tips.ShowTips(lockStr)
            return
        end
        CSAPI.OpenView("TacticsView", {
            teamData = teamData,
            closeFunc = OnSkillChange
        })
    elseif teamData and teamData:GetRealCount() == 0 then
        Tips.ShowTips(LanguageMgr:GetByID(26047))
    else
        Tips.ShowTips(LanguageMgr:GetByID(26048))
    end
end

function OnSkillChange(cfgId)
    AbilityProto:SkillGroupUse(cfgId, teamData.index, function(proto)
        if teamData then
            teamData:SetSkillGroupID(cfgId)
            local teamData2 = TeamMgr:GetTeamData(teamData.index)
            teamData2:SetSkillGroupID(cfgId)
            TeamMgr:SaveDataByIndex(teamData.index, teamData2)
        end
        SetSkillIcon(cfgId)
    end)
end

function OnClickAI()
    if teamData then
        if teamData:GetRealCount() <= 0 then
            Tips.ShowTips(LanguageMgr:GetByID(26047))
            do
                return
            end
        end
        local isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.special, FormationUtil.AIModuleKey)
        if isOpen ~= true then
            Tips.ShowTips(lockStr);
            return
        end
        CSAPI.OpenView("AIPrefabSetting", {
            teamData = teamData
        });
    else
        Tips.ShowTips(LanguageMgr:GetByID(26048))
    end
end

