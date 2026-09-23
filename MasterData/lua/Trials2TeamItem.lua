local assistData = nil
local teamData = nil
local assistItem = nil
local curSkill = nil
local items = nil
local items2 = nil
local teamIndex = 0

function Awake()
    CSAPI.SetGOActive(lockObj,false)
    CSAPI.SetGOActive(teamSelect,false)
    CSAPI.SetGOActive(curObj,false)
end

function SetIndex(_index, _len, _optionDatas)
    index = _index
    len = _len
    optionDatas = _optionDatas
end

function SetClickCB(_cb,_cb2)
    cb = _cb
    cb2 = _cb2
end

function Refresh(_mainLine)
    mainLineCfg = _mainLine
    teamIndex = eTeamType.ChainFront + index - 1
    if TrialsMgr:IsFighting() and TrialsMgr:IsTeamLock(index) then
        if assistData == nil then
            ReplaceAssistData(TrialsMgr:GetLockAssistData(index,teamIndex))
        end
    elseif assistData and not TeamMgr:GetAssistCID(teamIndex) then -- 检测缓存有没有助战，没有则清空助战
        assistData = nil
    end
    SetTeamData(teamIndex)
    -- boss
    SetBoss()

    -- items 
    SetItems()

    local info = FileUtil.LoadByPath("Trials2_Team_Skill.txt") or {}
    curSkill = info[mainLineCfg.id]
    SetAssistSkillState(curSkill)

    --战斗状态
    SetState()
end

function SetTeamData(index)
    -- TeamMgr.currentIndex = index;
    -- if teamData then
        -- TeamMgr:DelEditTeam(index);
    -- end
    teamData = TeamMgr:GetEditTeam(index);
    if assistData ~= nil then -- 存在助战卡牌
        PushAssistCard(assistData);
    end
    SetSkillIcon(teamData:GetSkillGroupID())
end

-- 放置助战卡牌
function PushAssistCard(assist)
    local card =assist.card;
    -- 判断当前队伍中是否存在同样的人物
    local roleInfo = teamData:GetItemByRoleTag(card:GetRoleTag());
    if roleInfo then
        -- assistData = nil
        -- TeamMgr:RemoveAssistTeamIndex(card:GetID());
        -- SetTeamData(teamData.index);
        -- Tips.ShowTips(LanguageMgr:GetTips(14010))
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
        index = 6,
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

function SetBoss()
    local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(mainLineCfg.nGroupID) -- mainLineCfg.enemyPreview[1])
    ResUtil.TrialsPage:Load(bossIcon, mainLineCfg.icon)
    CSAPI.SetText(txtScore, LanguageMgr:GetByID(37052) .. ":" .. TrialsMgr:GetDupScore(mainLineCfg.id))
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
    CSAPI.SetText(txtName, bossCfg and bossCfg.name or "")
end

function SetItems()
    itemDatas = {}
    for k = 1, 5 do
        local _data = teamData:GetItemByIndex(k) or {
            isEmpty = 1
        }
        table.insert(itemDatas, _data)
    end
    items = items or {}
    ItemUtil.AddItems("Trials2/Trials2TeamCard", items, itemDatas, itemParent, ItemClickCB)

    if assistItem then
        assistItem.Refresh(assistData or {
            isEmpty = 1
        })
    else
        ResUtil:CreateUIGOAsync("Trials2/Trials2TeamCard", assistParent, function(go)
            assistItem = ComUtil.GetLuaTable(go)
            assistItem.SetIndex(6)
            assistItem.SetClickCB(ItemClickCB)
            assistItem.Refresh(assistData or {
                isEmpty = 1
            })
        end)
    end
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
            selectType = TeamSelectType.Support,
            NPCList = mainLineCfg.arrNPC
        }, TeamOpenSetting.Trials2)
    else
        SetTeamData(teamData:GetIndex())
        CSAPI.OpenView("TeamView", {
            currentIndex = teamData:GetIndex(),
            canEmpty = true,
            closeFunc = OnCloseFunc,
            is2D = true,
            canAssist = true,
            NPCList = mainLineCfg.arrNPC
        }, TeamOpenSetting.Trials2)
    end
end

function OnCloseFunc(assist)
    assistData = assist
    if assistData ~= nil then
        local card = assist:GetCard();
        TeamMgr:AddAssistTeamIndex(card:GetID(), teamData:GetIndex());
    end
    EventMgr.Dispatch(EventType.Team_Card_Refresh)
end

function OnClickBoss()
    CSAPI.OpenView("FightEnemyInfo", monsters)
end

function OnClickAssistSkill()
    local skillInfo = {}
    skillInfo.datas = GetAssistSkillDatas()
    skillInfo.closeCallBack = OnCloseCallBack
    CSAPI.OpenView("Trials2Skill", skillInfo)
end

function GetAssistSkillDatas()
    local _cfgs = {}
    if mainLineCfg.arrSkill then
        local _cfg = nil
        for i, v in ipairs(mainLineCfg.arrSkill) do
            _cfg = Cfgs.CfgBuffChain:GetByID(v)
            if _cfg then
                table.insert(_cfgs, _cfg)
            end
        end
    end
    return _cfgs
end

function OnCloseCallBack(selId)
    curSkill = selId
    SetAssistSkillState(selId)
    local info = FileUtil.LoadByPath("Trials2_Team_Skill.txt") or {}
    info[mainLineCfg.id] = selId
    FileUtil.SaveToFile("Trials2_Team_Skill.txt", info)
end

function SetAssistSkillState(selId)
    CSAPI.SetGOActive(skillImg, selId ~= nil)
    CSAPI.SetGOActive(skillEmptyImg, selId == nil)
    CSAPI.SetGOActive(icon, selId ~= nil)
    if selId ~= nil then
        local _cfg = Cfgs.CfgBuffChain:GetByID(selId)
        if _cfg and _cfg.icon then
            ResUtil.BuffChain:Load(icon, _cfg.icon)
        end
    end
end

function SetState()
    CSAPI.SetGOActive(curObj,TrialsMgr:IsFighting() and TrialsMgr:GetFightRound() == index)
    CSAPI.SetGOActive(lockObj,TrialsMgr:IsFighting() and TrialsMgr:IsTeamLock(index))
end

function GetAssistSkillId()
    return curSkill
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
    AbilityProto:SkillGroupUse(cfgId,teamIndex,function(proto)
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
        CSAPI.SetText(txtSkill,LanguageMgr:GetByID(37099))
        CSAPI.LoadImg(skillIcon,"UIs/TeamConfirm/btn_13_06.png",true,nil,true);
        return
    end
    local tactice=TacticsMgr:GetDataByID(cfgId);
    if tactice then
        CSAPI.SetText(txtSkill,tactice:GetName());
        ResUtil.Ability:Load(skillIcon, tactice:GetIcon().."_1",true);
    else
        CSAPI.SetText(txtSkill,LanguageMgr:GetByID(26015))
        CSAPI.LoadImg(skillIcon,"UIs/TeamConfirm/btn_13_06.png",true,nil,true);
    end
end

function OnClickTeamSelect()
    if cb then
        cb(this)
    end
end

function SetTeamSelectItems()
    local datas = {}
    for i = 1, 3 do
        table.insert(datas,{index = i,isCur = i == index,isLock = TrialsMgr:IsFighting() and TrialsMgr:IsTeamLock(i)})
    end
    table.sort(datas,function (a,b)
        if a.isCur ~= b.isCur then
            return a.isCur
        elseif a.isLock ~= b.isLock then
            return not a.isLock
        else
            return a.index < b.index
        end
    end)
    items2 = items2 or {}
    ItemUtil.AddItems("Trials2/Trials2TeamItem2",items2,datas,itemParent2,OnItemClickCB)
end

function OnItemClickCB(item)
    if cb2 then
        cb2(item)
    end
end

function GetAssistData()
    if assistData then
        local card = assistData:GetCard()
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
            row = assistData.row,
            col = assistData.col,
            fuid = assistData.fuid,
            bIsNpc = isNpc,
            index = 6
        }
        teamItemData:SetData(tempData);
        local isSuccess, pos = formatTab:TryPushTeamItemData(teamItemData);
        if isSuccess then
            teamItemData.col = pos.col;
            teamItemData.row = pos.row;
            return teamItemData
        end
    end
end

function ReplaceAssistData(_teamItemData)
    TeamMgr:RemoveAssistTeamIndex(TeamMgr:GetAssistCID(teamIndex))
    if teamData then
        teamData:RemoveCard(teamData:GetAssistID())
    end
    assistData = _teamItemData
    if _teamItemData and not TrialsMgr:IsTeamLock(index) then
        local card = _teamItemData:GetCard()
        TeamMgr:AddAssistTeamIndex(card:GetID(),teamIndex)
    end
end
