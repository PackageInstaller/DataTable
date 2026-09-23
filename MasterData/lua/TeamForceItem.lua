-- 队伍信息物体
local teamData=nil;
-- local isChange=false;
local state=TeamConfirmItemState.Normal;
local grids={};
local data=nil;
local canvasGroup=nil;
-- local skillClicker=nil;
-- local aiClicker=nil;
local useClicker=nil;
local forceSkill=nil;
local dropClick=nil;
local eventMgr=nil;
-- local skillAlpha=nil;
-- local aiAlpha=nil;
local dCfg=nil;
local assistData=nil;
function Awake()
    TeamConfirmUtil.CreateGrids(nil,grids,gridNode,OnClickGrid);
    canvasGroup=ComUtil.GetCom(dropDownList,"CanvasGroup");
    -- skillClicker=ComUtil.GetCom(btnSkill,"Image");
    -- skillAlpha=ComUtil.GetCom(skillRoot,"CanvasGroup");
    -- aiAlpha=ComUtil.GetCom(aiRoot,"CanvasGroup")
    -- aiClicker=ComUtil.GetCom(btnAI,"Image");
    useClicker=ComUtil.GetCom(btnSwitch,"Image");
    dropClick=ComUtil.GetCom(dClick,"Image");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.AIPreset_Use,OnUseAIPreset);
    eventMgr:AddListener(EventType.Team_Raising_GoTeamView,OnGoTeamView)
end

--改变了AI策略，缓存编队信息
function OnUseAIPreset(eventData)
    if teamData then
        local tIndex=nil;
        for k,v in ipairs(teamData.data) do
            if v:GetID()==eventData.cid then
                tIndex=teamData:GetIndex();
                v:SetStrategyIndex(eventData.index);
            end
        end
        if tIndex then
            TeamMgr:SaveItemStrategyIndex(tIndex,eventData.cid,eventData.index);
            TeamConfirmUtil.CreateGrids(teamData,grids,gridNode,OnClickGrid);
        end
    end
end

function OnGoTeamView(teamIdx)
    if not IsNil(gameObject) and teamIdx and teamData and teamData:GetIndex()==teamIdx and grids then
        OnClickGrid(grids[1]);
    end
end


function GetTeamIndex()
    if teamData then
        return teamData.index
    else
        return nil;
    end
end

function SetTeamData(index)
    local skillId=nil
    local isAssistLimit=false;
    if state==TeamConfirmItemState.UnUse or index==nil then--锁定或者id为nil
        if teamData then
            TeamMgr:DelEditTeam(teamData:GetIndex());
            TeamMgr:RemoveAssistTeamIndex(teamData:GetAssistID());
        end
        teamData=nil;
        assistData=nil;
    else
        TeamMgr.currentIndex=index;
        if teamData then
            TeamMgr:DelEditTeam(index);
        end
        teamData=TeamMgr:GetEditTeam();
        CheckhasCard(teamData);
        if teamData~=nil and CheckTeamFormation() then --有本地缓存时读取本地缓存
            -- Log( "----------------------------------------");
            -- Log( teamData:GetData());
            if teamData:GetTeamName()=="" or teamData:GetTeamName()==nil then
                teamData:SetTeamName(GetTeamName());
            end
            --记录所有的占位信息
            -- for k, v in pairs(teamData.data) do
            --     formatTab:AddCardPosInfo(v);
            -- end
            if data.forceNPC then
                PushForceNPC();
            elseif assistData then
                PushAssistCard(assistData);
                isAssistLimit=FormationUtil.CheckAssitCardIsLimit(assistData);
            end
            skillId=teamData:GetSkillGroupID()
        else--否则读取默认阵型
            LoadDefaultForceTeam();
            if teamData~=nil then
                TeamMgr:SaveDataByIndex(teamData:GetIndex(),teamData);
                teamData=TeamMgr:GetEditTeam();
                if data.forceNPC then
                    PushForceNPC();
                elseif assistData then
                    PushAssistCard(assistData);
                end
                skillId=teamData:GetSkillGroupID()
            end
        end
    end
    CSAPI.SetGOActive(txt_limitAssistTips,isAssistLimit);
    CSAPI.SetText(txt_fight, tostring(GetTeamStrength()));
    if dCfg and dCfg.type==eDuplicateType.Teaching then
        forceSkill=dCfg.forceSkill and dCfg.forceSkill[data.id] or nil;
        if teamData then
            teamData:SetSkillGroupID(forceSkill,true);
        end
        SetSkillIcon(forceSkill);
    else
        SetSkillIcon(skillId);
    end
    TeamConfirmUtil.CreateGrids(teamData,grids,gridNode,OnClickGrid);
end

function GetTeamStrength()
    if teamData~=nil then
        local haloStrength=teamData:GetHaloStrength();
        return teamData:GetTeamStrength()+haloStrength;
    else
        return 0
    end
end

function Refresh(d)
    data=d;
    if data then
        dCfg=Cfgs.MainLine:GetByID(data.dungeonID);
        LoadForceCfg();
        if data.currState then
            SetState(data.currState);
        else
            SetState(data.state);
        end
        CSAPI.SetText(dropVal,"0"..tostring(data.id));
        SetTeamData(data.teamID);
        SetClick(data.canClick);
        if teamData then
            CSAPI.SetText(txt_teamName,teamData:GetTeamName())
        end
    end
end

--是否使用中
function IsUse()
    if state==TeamConfirmItemState.UnUse or state==TeamConfirmItemState.Disable then
        return false
    end
    return true;
end

function SetClick(canClick)
    useClicker.raycastTarget=canClick==true;
    -- skillClicker.raycastTarget=canClick==true;
    -- aiClicker.raycastTarget=canClick==true;
    UIUtil:SetBtnState(btnSkill,canClick==true);
    UIUtil:SetBtnState(btnAI,canClick==true);
    if grids then
        for k,v in ipairs(grids) do
            v.SetClick(canClick==true);
            local isShow=k==6;
            v.SetAssist(isShow and canClick==true or false)
        end
    end
end

function PushForceNPC()
    if teamData then
        local teamItem=TeamItemData.New();
        teamItem:SetData({
            cid=FormationUtil.FormatNPCID(data.forceNPC),
            row=1,
            col=1,
            index=6,
            isForce=true,
            bIsNpc=true,
        });
        local formatTab=FormationTable.New(3,3);
        --记录所有的占位信息
        for k, v in pairs(teamData.data) do
            formatTab:AddCardPosInfo(v);
        end
        local isSuccess,pos=formatTab:TryPushTeamItemData(teamItem);
        if isSuccess then
            teamItem.col=pos.col;
            teamItem.row=pos.row;
            teamData:AddCard(teamItem);
            TeamMgr:AddAssistTeamIndex(teamItem:GetID(), teamData:GetIndex());
        else
            Tips.ShowTips(LanguageMgr:GetTips(14007));
        end
    end
end

function GetState()
    return state;
end

function OnClickGrid(tab)
    if data.forceNPC~=nil then--强制上阵NPC时无法改变队员
        return;
    end
    if teamData==nil then
        Tips.ShowTips(LanguageMgr:GetTips(14008));
        return
    end
    local isAssist=false
    for k,v in ipairs(grids) do
        if v==tab then
            isAssist=k==6;
            break;
        end
    end
    TeamMgr.currentIndex=teamData:GetIndex();
    local excludIds=data.parent.GetScreenIDs(data.id);
    local canAddAssist=GetState()~=TeamConfirmItemState.UnAssist
    if isAssist then
        local cid=nil;
        SetTeamData(teamData:GetIndex());
        if assistData then
            cid=assistData.card:GetID();
        end
        CSAPI.OpenView("TeamView",{team=teamData,cid=cid,dungeonID=data.dungeonID,NPCList=data.NPCList,forceCfg=forceCfg,closeFunc=OnChange,selectType=TeamSelectType.Support,canAssist=canAddAssist},TeamOpenSetting.PVE);
    else
        SetTeamData(teamData:GetIndex());
        CSAPI.OpenView("TeamView",{team=teamData,dungeonID=data.dungeonID,forceCfg=forceCfg,NPCList=data.NPCList,excludIds=excludIds,canEmpty=false,closeFunc=OnChange,selectType=TeamSelectType.Force,canAssist=canAddAssist},TeamOpenSetting.PVE);
    end
end

--助战队员变更后
-- function OnAssistChange()
--     teamData=TeamMgr:GetEditTeam();
--     assistData=teamData:GetAssistData();
--     -- TeamConfirmUtil.CreateGrids(teamData,grids,gridNode,OnClickGrid);
--     SaveData();
-- end

--队员变更后
function OnChange(_assist)
    assistData=_assist;
    -- SetTeamData(teamData.index);
    -- if teamData~=nil and teamData:GetCount()>0 then
        EventMgr.Dispatch(EventType.Team_Confirm_Refreh);
    -- end
    -- if assistData then
    --     local item=teamData:GetItem(assistData.cid);
    --     if item then
    --         assistData.row=item.row;
    --         assistData.col=item.col;
    --     end
    -- end
    -- --保存修改
    -- SaveData();
end


function OnClickSwitch()
    if state==TeamConfirmItemState.Normal then
        state=TeamConfirmItemState.UnUse    
    elseif state==TeamConfirmItemState.UnUse then
        state=data.state
        --清空数据
        ClearTeam();
        SetTeamData(data.teamID)
    elseif state==TeamConfirmItemState.UnAssist then
        state=TeamConfirmItemState.UnUse
    end
    CSAPI.SetGOActive(switchOn,state~=TeamConfirmItemState.UnUse);
    CSAPI.SetGOActive(switchOff,state==TeamConfirmItemState.UnUse);
    SetState(state);
    EventMgr.Dispatch(EventType.Team_Confirm_ItemDisable,data.id);
end

-- 点击清空队伍数据
function ClearTeam() 
    if forceCfg~=nil then
        LoadDefaultForceTeam();
    elseif teamData then
        teamData:ClearCard();
    end
    if teamData then
        TeamMgr:SaveDataByIndex(teamData:GetIndex(),teamData);
    end
end

function SaveData()
    if teamData~=nil and teamData:GetCount()>0 then
        TeamMgr.currentIndex=teamData.index;
        TeamMgr:SaveEditTeam();
    end
end

--是否可以出战
function CanBattle()
    local canBattle = true
    if teamData==nil and assistData~=nil then
        Tips.ShowTips(string.format(LanguageMgr:GetTips(14009),teamData.teamName));
        return false;
    end
    return canBattle
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
		bIsReserveSP=config[string.format("team%sSP",data.id)]
		nReserveNP=config[string.format("team%sNP",data.id)]
        target=config.target;
	end
    local duplicateTeamData = {nTeamIndex = teamData.index, team = list,nSkillGroup=teamData.skillGroupID,bIsReserveSP=bIsReserveSP,nReserveNP=nReserveNP,nFocusFire=target}
    return duplicateTeamData;
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

function SetState(_state)
    state=_state;
    local gridDisable=false;
    CSAPI.SetText(txt_teamName,"");
    local alpha=1;
    local isShowUse=false;
    if state==TeamConfirmItemState.Normal then
        grids[6].SetDisable(false);
        CSAPI.SetGOActive(gridNode,true);
        CSAPI.SetGOActive(btnSkill,true);
        CSAPI.SetGOActive(btnAI,true);
        dropClick.raycastTarget=true;
        CSAPI.SetText(txt_teamName,"——");
        CSAPI.SetGOActive(txt_fightTips,true);
        -- CSAPI.SetGOActive(dropDownList,true);
        isShowUse=data.showClean;
        CSAPI.SetGOActive(txt_disable,false);
    elseif state==TeamConfirmItemState.Disable then
        grids[6].SetDisable(false);
        CSAPI.SetGOActive(gridNode,false);
        CSAPI.SetGOActive(btnSkill,false);
        CSAPI.SetGOActive(btnAI,false);
        dropClick.raycastTarget=false;
        CSAPI.SetGOActive(txt_fightTips,true);
        -- CSAPI.SetGOActive(dropDownList,false);
        isShowUse=false;
        CSAPI.SetText(txt_disable,LanguageMgr:GetByID(25019));
        CSAPI.SetText(txt_teamName,"——");
        CSAPI.SetGOActive(txt_disable,false);
        alpha=0.4;
        gridDisable=true;
    elseif state==TeamConfirmItemState.UnUse then
        CSAPI.SetGOActive(gridNode,false);
        CSAPI.SetGOActive(btnSkill,false);
        CSAPI.SetGOActive(btnAI,false);
        CSAPI.SetGOActive(txt_fightTips,true);
        CSAPI.SetText(txt_teamName,"——");
        dropClick.raycastTarget=false;
        -- CSAPI.SetGOActive(dropDownList,false);
        isShowUse=true;
        CSAPI.SetText(txt_disable,LanguageMgr:GetByID(25020));
        CSAPI.SetGOActive(txt_disable,false);
        alpha=0.4;
    elseif state==TeamConfirmItemState.UnAssist then
        grids[6].SetDisable(true);
        CSAPI.SetGOActive(gridNode,true);
        CSAPI.SetGOActive(txt_fightTips,true);
        CSAPI.SetGOActive(btnSkill,true);
        CSAPI.SetGOActive(btnAI,true);
        dropClick.raycastTarget=true;
        -- CSAPI.SetGOActive(dropDownList,true);
        CSAPI.SetText(txt_teamName,"——");
        isShowUse=data.showClean;
        CSAPI.SetGOActive(txt_disable,false);
    end
    if forceCfg then
        CSAPI.SetGOActive(btnUse,false);
    else
        CSAPI.SetGOActive(btnUse,isShowUse==true);
    end
    canvasGroup.alpha=alpha;
    CheckModelOpen();
    if grids then
        for k,v in ipairs(grids) do
            v.SetDisable(gridDisable);
        end
    end
end

function GetAssistData()
    return assistData;
end

function CheckModelOpen()
    local isLock,isLock1=true,true;
    if dCfg and dCfg.type==eDuplicateType.Teaching then
    else
        local isOpen,lockStr=MenuMgr:CheckModelOpen(OpenViewType.main, FormationUtil.SkillModuleKey)
        local isOpen2,lockStr2=MenuMgr:CheckModelOpen(OpenViewType.special, FormationUtil.AIModuleKey)
        isLock=isOpen;
        isLock1=isOpen2;
    end
    CSAPI.SetGOActive(sLockImg,isLock~=true);
    CSAPI.SetGOActive(aLockImg,isLock1~=true);
    UIUtil:SetBtnState(btnSkill,isLock);
    UIUtil:SetBtnState(btnAI,isLock1);
    -- skillAlpha.alpha=isLock and 1 or 0.5
    -- aiAlpha.alpha=isLock1 and 1 or 0.5;
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
    if teamData then
        teamData:SetSkillGroupID(cfgId);
        TeamMgr:SaveDataByIndex(teamData.index,teamData);
	end
	SetSkillIcon(cfgId);
end

function SetSkillIcon(cfgId)
    if cfgId==nil or cfgId==-1 then
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
    else
        CSAPI.SetText(txtSkill,LanguageMgr:GetByID(26015))
        CSAPI.LoadImg(skillIcon,"UIs/TeamConfirm/btn_13_06.png",true,nil,true);
    end
end

--放置助战卡牌
function PushAssistCard(assist)
    local card =assist.card;
    --判断当前队伍中是否存在同样的人物
    local roleInfo=teamData:GetItemByRoleTag(card:GetRoleTag());
    if roleInfo then
        assistData=nil
        TeamMgr:RemoveAssistTeamIndex(card:GetID());
        SetTeamData(teamData.index);
        Tips.ShowTips(LanguageMgr:GetTips(14010))
        return 
    end
    local holderInfo = FormationUtil.GetPlaceHolderInfo(card:GetGrids());
    local formatTab=FormationTable.New(3,3);
    --记录所有的占位信息
    for k, v in pairs(teamData.data) do
        formatTab:AddCardPosInfo(v);
    end
    local hasRecord=formatTab:HasRecord(assist.row, assist.col,card:GetID(),holderInfo);
    if not hasRecord then
        local teamItemData = TeamItemData.New();
        local isNpc,s1,s2=FormationUtil.CheckNPCID(card:GetID());
        local tempData={
            cid=card:GetID(),
            row=assist.row,
            col=assist.col,
            fuid=assist.fuid,
            bIsNpc=isNpc,
            index=6,
        }
        teamItemData:SetData(tempData);
        --记录位置
        teamData:AddCard(teamItemData);
        TeamMgr:AddAssistTeamIndex(teamItemData:GetID(), teamData:GetIndex());
    else
        local isSuccess, pos = formatTab:TryPushCard(card:GetID(),card:GetGrids());
        if isSuccess then
            --可以放置
            local teamItemData = TeamItemData.New();
            local tempData={
                cid=card:GetID(),
                row=pos.row,
                col=pos.col,
                fuid=assist.fuid,
                index=6,
            }
            teamItemData:SetData(tempData);
            --记录位置
            teamData:AddCard(teamItemData);
            TeamMgr:AddAssistTeamIndex(teamItemData:GetID(), teamData:GetIndex());
        else
            Tips.ShowTips(LanguageMgr:GetTips(14007));
            TeamMgr:RemoveAssistTeamIndex(card:GetID());
            assistData=nil;
        end
    end
end

--读取强制配置信息
function LoadForceCfg()
    local idx=data.id;
	if data.dungeonID then
        local cfg=Cfgs.MainLine:GetByID(data.dungeonID);
        if cfg then
            forceCfg=cfg.arrForceTeam[idx];
        end
    else
        forceCfg=nil;
    end
end

function GetTeamName()
    if data then
        if data.id==1 then
            return LanguageMgr:GetByID(25022)
        elseif data.id==2 then
            return LanguageMgr:GetByID(25023)
        end
    end
    return nil;
end

--检查队伍格式是否正确
function CheckTeamFormation(showTips)
    if teamData~=nil then
        if teamData:GetCount()>0 and teamData:HasLeader()~=true then
            if showTips then
                Tips.ShowTips(string.format(LanguageMgr:GetTips(14011),teamData:GetTeamName()));
            end
            return false;
        elseif teamData:CheckTeamForce(forceCfg)==false then
            if showTips then
                Tips.ShowTips(string.format(LanguageMgr:GetTips(14012),teamData:GetTeamName()));
            end
            return false;
        end
    end
    return true;
end

--判断队伍中非npc的卡牌数据是否存在，不存在则踢出队伍
function CheckhasCard(team)
    if team then
        for k,v in ipairs(team.data) do
            if v.bIsNpc==false and v:GetCard()==nil then
                team:RemoveCard(v.cid);
            end
        end
    end
end

--加载默认的强制上阵队伍数据
function LoadDefaultForceTeam()
	local tData = {};
	tData.name = GetTeamName();
	tData.leader = nil;
    tData.index = data.teamID;
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

--获取强制上阵的卡牌ID
function GetScreenIDs()
    local ids=nil;
    if teamData~=nil and teamData.data~=nil then
        for k,v in ipairs(teamData.data) do
            ids=ids or {}; 
            if v.isForce==true or v.bIsNpc==true then
                table.insert(ids,v:GetID());
            end
        end
    end
    return ids;
end

function OnDestroy()    
    eventMgr=nil;
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
childNode=nil;
dropDownList=nil;
dClick=nil;
dropVal=nil;
txt_teamName=nil;
btnSkill=nil;
txt_noSkillTips=nil;
skillNilImg=nil;
skillRoot=nil;
skillIcon=nil;
gridNode=nil;
txt_disable=nil;
btnUse=nil;
btnSwitch=nil;
switchOn=nil;
switchOff=nil;
view=nil;
end
----#End#----