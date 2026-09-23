local assistData = nil
local teamData = nil

function SetIndex(_index, _len, _optionDatas)
    index = _index
    len = _len
    optionDatas = _optionDatas
end

function Refresh(_mainLine)
    mainLineCfg = _mainLine
    if assistData and not TeamMgr:GetAssistCID(eTeamType.SkinPass + index - 1) then --检测缓存有没有助战，没有则清空助战
        assistData = nil
    end
    if mainLineCfg.arrForceTeam then
        forceCfg = mainLineCfg.arrForceTeam[1]
        LoadDefaultForceTeam()
        if teamData then
            TeamMgr:SaveDataByIndex(teamData:GetIndex(),teamData);
        end
        -- CSAPI.SetGOAlpha(btnAI,0.5)
        
    else
        SetTeamData(eTeamType.SkinPass + index - 1)
    end
    -- boss
    SetBoss()
    -- downList 
    SetDownList()
    -- items 
    SetItems()

    CSAPI.SetGOActive(btnSkill,g_SkinPassAssist == nil and mainLineCfg.MainLinetype and mainLineCfg.MainLinetype == 2)
    CSAPI.SetGOActive(btnAI,g_SkinPassAssist == nil and forceCfg == nil)
    CSAPI.SetAnchor(btnAI,763,mainLineCfg.MainLinetype and mainLineCfg.MainLinetype == 2 and -80 or -31)

    SetSkillIcon(teamData:GetSkillGroupID())
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
    local max = g_SkinPassAssist ~= nil and 6 or 5
    for k = 1, max do
        local _data = teamData:GetItemByIndex(k) or {
            isEmpty = 1
        }
        table.insert(itemDatas, _data)
    end
    items = items or {}
    ItemUtil.AddItems("TeamConfirm/TowerDeepTeamListItem", items, itemDatas, gridNode, ItemClickCB)
end

--加载默认的强制上阵队伍数据
function LoadDefaultForceTeam()
	local tData = {};
	tData.name = optionDatas[index].desc;
	tData.leader = nil;
    tData.index = tonumber(mainLineCfg.id)*10+1
    tData.data = {};
    tData.performance=0;
	tData.bIsReserveSP=false;
	tData.nReserveNP=0;
    formatTab=FormationTable.New(3,3);
    if forceCfg~=nil then
        --根据表中配置先加载相应的队伍数据
		for k,v in ipairs(forceCfg) do
            local nForceID = FormationUtil.GetNForceID(v);
			if nForceID~=nil then
                local cid,grids=TeamConfirmUtil.GetBetterCards(v.bIsNpc,nForceID);
                if cid==nil then
                    -- local nForceID=v.nForceID;
                    -- if RoleMgr:IsSexInitCardIDs(nForceID) then--判断当前卡牌是否是主角卡，是的话替换为当前性别的对应卡牌ID
                    --     nForceID=RoleMgr:GetCurrSexCardCfgId();
                    -- end
                    local cfg=Cfgs.CardData:GetByID(nForceID);
                    if v.bIsNpc==false and cfg and cfg.role_tag=="lead" then --主角例外，如果没有找到男主，则去找女主，反之亦然
					    cid,grids=TeamConfirmUtil.GetBetterCards(v.bIsNpc,nForceID);
                        if cid==nil then
                            Tips.ShowTips(string.format(LanguageMgr:GetTips(14013),tostring(cfg.name)));
                            do return end;
                        end
                    else
                        LogError("未找到必须上阵的卡牌数据："..tostring(nForceID));
                        if v.bIsNpc==false then
                            Tips.ShowTips(string.format(LanguageMgr:GetTips(14013),tostring(cfg.name)));
                        end
                        do return end
                    end
                end
                if  v.nPos then --设置了放置位置
                    local teamItem=TeamItemData.New();
                    local tempData={
                        cid=v.bIsNpc and FormationUtil.FormatNPCID(cid) or cid,
                        row=v.nPos[1],
                        col=v.nPos[2],
                        bIsNpc=v.bIsNpc,
                        index=v.index,
                        isLeader=v.index==1,
                        isForce=true,
                    }
                    teamItem:SetData(tempData);
                    local isSuccess,pos=formatTab:TryPushTeamItemData(teamItem);
                    if isSuccess~=true then
                        LogError("强制上阵配置错误！卡牌位置重叠！配置信息："..tostring(forceCfg));
                    else
                        formatTab:AddCardPosInfo(teamItem);
                        if v.index==1 then
                            tData.leader=cid;
                        end
                        table.insert(tData.data,tempData);
                    end
                else --自动放置
                    local isSuccess,pos=formatTab:TryPushCard(cid,grids);
                    if isSuccess then
                        local teamItemData = TeamItemData.New();
                        local tempData={
                            cid=v.bIsNpc and FormationUtil.FormatNPCID(cid) or cid,
                            row=pos.row,
                            col=pos.col,
                            bIsNpc=v.bIsNpc,
                            index=v.index,
                            isLeader=v.index==1,
                            isForce=true,
                        }
                        teamItemData:SetData(tempData);
                        formatTab:AddCardPosInfo(teamItemData);
                        if v.index==1 then
                            tData.leader=cid;
                        end
                        table.insert(tData.data,tempData);
                        -- teamData:AddCard(teamItemData);
                    else
                        LogError("强制上阵配置错误！无法放置所有卡牌！配置信息："..tostring(forceCfg));
                    end
                end
			end
        end
    end
    if tData.data and #tData.data>=1 then
        teamData=TeamData.New();
        teamData:SetData(tData);
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

function ItemClickCB(tab)
    if forceCfg ~= nil then
        return
    end
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
            canAssist = false,
            cid = cid,
            selectType = TeamSelectType.Support
        }, TeamOpenSetting.SkinPass)
    else
        SetTeamData(teamData:GetIndex())
        CSAPI.OpenView("TeamView", {
            currentIndex = teamData:GetIndex(),
            canEmpty = true,
            closeFunc = OnCloseFunc,
            is2D = true,
            canAssist = false
        }, TeamOpenSetting.SkinPass)
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
        local team1 = TeamMgr:GetEditTeam(eTeamType.SkinPass + index - 1)
        local team2 = TeamMgr:GetEditTeam(eTeamType.SkinPass + _index - 1)
        team1.index = eTeamType.SkinPass + _index - 1
        team2.index = eTeamType.SkinPass + index - 1
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
    if assistData ~= nil then -- 存在助战卡牌
        PushAssistCard(assistData);
    end
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
    if forceCfg ~= nil then
        return
    end
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
    AbilityProto:SkillGroupUse(cfgId,eTeamType.SkinPass + index - 1,function(proto)
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

--返回队伍信息
function GetDuplicateTeamData()
    if teamData==nil or (teamData~=nil and teamData:GetCount()==0) then
        return nil;
    end
    -- TeamMgr:AddFightTeamData(teamData)
    local list = {}
    local assistID=teamData:GetAssistID();
    local assistCard = FormationUtil.FindTeamCard(assistID);
    for k, v in ipairs(teamData.data) do
        local item = {cid = v.cid, row = v.row, col = v.col,index=v.index}
        if assistID~=nil and v.cid == assistID then
            local ids=StringUtil:split(v.cid, "_");
            item.cid = tonumber(ids[2])
            if v.bIsNpc then
                item.id=v:GetCfgID();
                item.npcid=v.bIsNpc and v:GetCfgID() or nil;
                item.bIsNpc=true;
                item.index=6;
            else
                item.fuid =tonumber(ids[1])
                item.id=assistCard:GetCfgID();
                item.index=6;
            end
        else
            item.id=v:GetCfgID();
            item.cid=v.bIsNpc and v:GetCfgID() or item.cid;
            item.npcid=v.bIsNpc and v:GetCfgID() or nil;
        end
        item.nStrategyIndex=v:GetStrategyIndex();
        table.insert(list, item)
    end
    if list and #list>6 then
        LogError("队伍数据有误！");
        LogError(teamData:GetData());
        return
    end
    local config=TeamMgr:LoadStrategyConfig();
	local bIsReserveSP=false;
	local nReserveNP=0;
    local target=nil;
	if config then
		bIsReserveSP=config[string.format("team%sSP",index)]
		nReserveNP=config[string.format("team%sNP",index)]
        target=config.target;
	end
    local duplicateTeamData = {nTeamIndex = teamData.index, team = list,nSkillGroup=teamData.skillGroupID,bIsReserveSP=bIsReserveSP,nReserveNP=nReserveNP,nFocusFire=target}
    return duplicateTeamData;
end

function GetTeamData()
    return teamData
end
