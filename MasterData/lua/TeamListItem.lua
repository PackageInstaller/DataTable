-- 队伍信息物体
local teamData=nil;
local state=TeamConfirmItemState.Normal;
local grids={};
local data=nil;
local canvasGroup=nil;
local dropClick=nil;
local dropClick2=nil;
local eventMgr=nil;
local delayCtrl=nil
local assistData=nil; --TeamItemData类型
local openSetting=nil;
local assistSkillId = nil
-- local skillAlpha=nil;
-- local aiAlpha=nil;
function Awake()
    canvasGroup=ComUtil.GetCom(dropDownList,"CanvasGroup");
    -- skillAlpha=ComUtil.GetCom(skillRoot,"CanvasGroup");
    -- aiAlpha=ComUtil.GetCom(aiRoot,"CanvasGroup")
    dropClick=ComUtil.GetCom(dClick,"Image");
    dropClick2=ComUtil.GetCom(dropDownList,"Image");
    delayCtrl=ComUtil.GetCom(dropTween,"ActionsDelayCtrl");
    delayCtrl.unitDelay=250;
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
            TeamConfirmUtil.CreateGrids(teamData,grids,gridNode,OnClickGrid,openSetting);
        end
    end
end

function OnGoTeamView(teamIdx)
    if not IsNil(gameObject) and teamIdx and teamData and teamData:GetIndex()==teamIdx and grids then
        OnClickGrid(grids[1]);
    end
end

function GetAssistData()
    return assistData;
end

function SetTeamData(index)
    local skillId=nil
    local isAssistLimit=false;
    if index~=nil and type(index)=="number" then
        TeamMgr.currentIndex=index;
        if teamData then
            TeamMgr:DelEditTeam(index);
        end
        teamData=TeamMgr:GetEditTeam();
        if data.forceNPC then
            PushForceNPC();
        elseif assistData~=nil then --存在助战卡牌
            PushAssistCard(assistData);
            isAssistLimit=FormationUtil.CheckAssitCardIsLimit(assistData);
        end
        -- RefreshFormationTab();
        skillId=teamData:GetSkillGroupID()
    else
        if teamData then
            TeamMgr:DelEditTeam(teamData:GetIndex());
            TeamMgr:RemoveAssistTeamIndex(teamData:GetAssistID());
        end
        teamData=nil;
        assistData=nil;
    end
    CSAPI.SetGOActive(txt_limitAssistTips,isAssistLimit);
    CSAPI.SetText(txt_fight, tostring(GetTeamStrength()));
    if teamData~=nil then
        CSAPI.SetText(txt_teamName,tostring(teamData:GetTeamName()));
    else
        CSAPI.SetText(txt_teamName,LanguageMgr:GetByID(25021));
    end
    SetSkillIcon(skillId);
    TeamConfirmUtil.CreateGrids(teamData,grids,gridNode,OnClickGrid,openSetting);
end

function GetTeamStrength()
    if teamData~=nil then
        local haloStrength=teamData:GetHaloStrength();
        return teamData:GetTeamStrength()+haloStrength;
    else
        return 0
    end
end

function GetTeamIndex()
    if teamData then
        return teamData.index
    else
        return nil;
    end
end

function SetOpenSetting(op)
    op=op==nil and TeamConfirmOpenType.Dungeon or op;
    if op==TeamConfirmOpenType.Tower then
        openSetting=TeamOpenSetting.Tower
    elseif op==TeamConfirmOpenType.TotalBattle then
        openSetting=TeamOpenSetting.TotalBattle
    elseif op==TeamConfirmOpenType.Rogue then
        openSetting=TeamOpenSetting.Rogue
    elseif op==TeamConfirmOpenType.GlobalBoss then
        openSetting=TeamOpenSetting.GlobalBoss    
    elseif op==TeamConfirmOpenType.RogueT then
        openSetting=TeamOpenSetting.RogueT 
    elseif op==TeamConfirmOpenType.MultTeamBattle then
        openSetting=TeamOpenSetting.MultBattle
    elseif op==TeamConfirmOpenType.PeriodicBoss then
        openSetting=TeamOpenSetting.PeriodicBoss
    elseif op == TeamConfirmOpenType.VirCat then
        openSetting=TeamOpenSetting.VirCat
    else
        openSetting=TeamOpenSetting.PVE
    end
end

function Refresh(d)
    data=d;
    if data then
        SetOpenSetting(data.openSetting);
        TeamConfirmUtil.CreateGrids(nil,grids,gridNode,OnClickGrid,openSetting);
        local teamID=nil;
        if data.currState then
            SetState(data.currState);
        else
            SetState(data.state);
        end
        local optionData=nil;
        for k,v in ipairs(data.options) do
            if v.itemID==data.id then
                teamID=v.id;
                optionData=v;
                ShowDownListInfo(v);
                break;
            end
        end
        if optionData~=nil then
            CSAPI.SetText(dropVal,optionData.desc);
        else
            CSAPI.SetText(dropVal,"-");
        end
        if openSetting==TeamOpenSetting.Tower and assistData==nil then
            --获取锁定的助战卡牌信息
            local assistInfo= TowerMgr:GetLockAssistInfo(data.dungeonCfg.group);
            if assistInfo~=nil and assistInfo.tower_hp>0 and assistInfo.isSelect then
                --直接设置助战卡
                 local teamItemData=TeamItemData.New();
                 local cid=FormationUtil.FormatAssitID(assistInfo.fuid,assistInfo.cid);
                 local d={
                    cid=cid,
                    row=assistInfo.row,
                    col=assistInfo.col,
                    fuid=assistInfo.fuid,
                    bIsNpc=false,
                    index=6,
                 }
                 teamItemData:SetData(d);
                 if teamItemData:GetCard()~=nil then
                    assistData=teamItemData;
                 end
            end
        end
        SetTeamData(teamID);
        SetAssistSkill()
    else
        TeamConfirmUtil.CreateGrids(nil,grids,gridNode,OnClickGrid,openSetting);
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

--是否使用中
function IsUse()
    if state==TeamConfirmItemState.UnUse or state==TeamConfirmItemState.Disable then
        return false
    end
    return true;
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
    local canAddAssist=GetState()~=TeamConfirmItemState.UnAssist
    -- TeamMgr.currentIndex=teamData:GetIndex();
    local canEmpty=teamData:GetIndex()~=1 and true or false;
    if isAssist then
        local cid=nil;
        SetTeamData(teamData:GetIndex());
        if assistData then
            cid=assistData.card:GetID();
        end
        CSAPI.OpenView("TeamView",{team=teamData,cid=cid,canEmpty=canEmpty,NPCList=data.NPCList,closeFunc=OnChange,selectType=TeamSelectType.Support,canAssist=canAddAssist,cond=data.cond,dungeonCfg=data.dungeonCfg,dungeonId = data.dungeonId,showFakeLevel = data.showFakeLevel},openSetting);
    else
        SetTeamData(teamData:GetIndex());
        CSAPI.OpenView("TeamView",{team=teamData,canEmpty=canEmpty,NPCList=data.NPCList,closeFunc=OnChange,selectType=TeamSelectType.Normal,canAssist=canAddAssist,cond=data.cond,dungeonCfg=data.dungeonCfg,dungeonId = data.dungeonId,showFakeLevel = data.showFakeLevel},openSetting);
    end
end

--队员变更后
function OnChange(_assist)
    assistData=_assist;
    EventMgr.Dispatch(EventType.Team_Card_Refresh);
end

function OnClickSwitch()
    if state==TeamConfirmItemState.Normal then
        state=TeamConfirmItemState.UnUse    
    elseif state==TeamConfirmItemState.UnUse then
        state=data.state
        SetTeamData(nil)
    elseif state==TeamConfirmItemState.UnAssist then
        state=TeamConfirmItemState.UnUse
    end
    CSAPI.SetGOActive(switchOn,state~=TeamConfirmItemState.UnUse);
    CSAPI.SetGOActive(switchOff,state==TeamConfirmItemState.UnUse);
    SetState(state);
    EventMgr.Dispatch(EventType.Team_Confirm_ItemDisable,data.id);
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

--返回队伍信息
function GetDuplicateTeamData()
    -- local list = {}
    -- if teamData==nil or teamData:GetRealCount()==0 then
    --     return nil;
    -- end
    -- local assistID=teamData:GetAssistID();
    -- local assistCard=FormationUtil.FindTeamCard(assistID);
    -- for k, v in ipairs(teamData.data) do
    --     local item = {cid = v.cid, row = v.row, col = v.col}
    --     if assistID~=nil and v.cid == assistID then
    --         local ids=StringUtil:split(v.cid, "_");
    --         item.cid = tonumber(ids[2])
    --         if v.bIsNpc then
    --             item.id=v:GetCfgID();
    --             item.npcid=v.bIsNpc and v:GetCfgID() or nil;
    --             item.bIsNpc=true;
    --             item.index=6;
    --         else
    --             item.fuid =tonumber(ids[1])
    --             item.id=assistCard:GetCfgID();
    --             item.index=6;
    --         end
    --     else
    --         local cardData=FormationUtil.FindTeamCard(v.cid);
    --         item.id=cardData:GetCfgID();
    --         item.index=v.index;
    --     end
    --     table.insert(list, item)
    -- end
    -- if list and #list>6 then
    --     LogError("队伍数据有误！");
    --     LogError(teamData:GetData());
    --     return
    -- end
    -- local duplicateTeamData = {nTeamIndex = teamData.index, team = list,nSkillGroup=teamData.skillGroupID}
    return TeamMgr:DuplicateTeamData(data.id,teamData);
end

--------------------------------下拉框
function ShowDownListInfo(option)
    if option and option.id~=-1 then
        CSAPI.SetText(dropVal,tostring(option.desc));
    elseif option.id==-1 then
        CSAPI.SetText(dropVal,tostring("—"));
    end
end

function OnClickDownList()--点击下拉框
    delayCtrl.unitDelay=0;
    local p1=view.myParent:InverseTransformPoint(dropDownList.transform.position);
    CSAPI.SetGOActive(dropTween,true);
    FuncUtil:Call(function()
        CSAPI.SetGOActive(dropTween,false);
    end,nil,400);
    local index=1;
    local oNum=1;
    if data then
        index=data.id;
        oNum=data.options and #data.options or 1;
    end
    local pos=UnityEngine.Vector3(p1.x+385,p1.y+15,0);
    data.ShowDownList(pos,data.id,OnDropValChange,nil);
end

-- function OnDropClose()
    -- CSAPI.SetAngle(downListIcon,0,0,-90);
-- end

-- 下拉框的值改变之后
function OnDropValChange(option)
    ShowDownListInfo(option);
    if option.id==-1 then
        SetTeamData(nil);
    else
        SetTeamData(option.id);
        -- if assistData~=nil then --当前有助战数据的话，放置到新的队伍中
        --     PushAssistCard(assistData)
        --     assistData=teamData:GetAssistData();
        -- end
    end
    EventMgr.Dispatch(EventType.Team_Card_Refresh);
end
------------------------------下拉框逻辑完毕

function SetState(_state)
    state=_state;
    local gridDisable=false;
    -- CSAPI.SetText(txt_teamTips,"请选择队伍");
    local alpha=1;
    local dropCanClicker=false;
    if state==TeamConfirmItemState.Normal then
        -- CSAPI.SetGOActive(grids[6].gameObject,true);
        grids[6].SetDisable(false);
        CSAPI.SetGOActive(gridNode,true);
        CSAPI.SetGOActive(btnSkill,true);
        CSAPI.SetGOActive(btnAI,true);
        CSAPI.SetText(txt_teamName,LanguageMgr:GetByID(25021));
        dropCanClicker=true;
        -- CSAPI.SetGOActive(dropDownList,true);
        CSAPI.SetGOActive(btnUse,data.showClean);
        CSAPI.SetGOActive(txt_fightTips,true);
        CSAPI.SetGOActive(txt_disable,false);
    elseif state==TeamConfirmItemState.Disable then
        -- CSAPI.SetGOActive(grids[6].gameObject,true);
        grids[6].SetDisable(false);
        CSAPI.SetGOActive(gridNode,false);
        CSAPI.SetGOActive(btnSkill,false);
        CSAPI.SetGOActive(btnAI,false);
        dropCanClicker=false;
        -- CSAPI.SetGOActive(dropDownList,false);
        CSAPI.SetGOActive(btnUse,false);
        CSAPI.SetText(dropVal,"—");
        CSAPI.SetText(txt_teamName,"——");
        CSAPI.SetGOActive(txt_fightTips,false);
        CSAPI.SetText(txt_disable,LanguageMgr:GetByID(25019));
        CSAPI.SetGOActive(txt_disable,true);
        alpha=0.4;
        gridDisable=true;
    elseif state==TeamConfirmItemState.UnUse then
        -- CSAPI.SetGOActive(grids[6].gameObject,true);
        CSAPI.SetGOActive(gridNode,false);
        CSAPI.SetGOActive(btnSkill,false);
        dropCanClicker=false;
        -- CSAPI.SetGOActive(dropDownList,false);
        CSAPI.SetGOActive(btnUse,true);
        CSAPI.SetGOActive(btnAI,false);
        CSAPI.SetGOActive(txt_fightTips,false);
        CSAPI.SetText(dropVal,"—");
        CSAPI.SetText(txt_teamName,"——");
        CSAPI.SetText(txt_disable,LanguageMgr:GetByID(25020));
        CSAPI.SetGOActive(txt_disable,true);
        alpha=0.4;
    elseif state==TeamConfirmItemState.UnAssist then
        grids[6].SetDisable(true);
        CSAPI.SetGOActive(gridNode,true);
        -- CSAPI.SetGOActive(grids[6].gameObject,false);
        CSAPI.SetGOActive(btnSkill,true);
        CSAPI.SetGOActive(btnAI,true);
        dropCanClicker=true;
        CSAPI.SetGOActive(txt_fightTips,true);
        CSAPI.SetText(dropVal,"—");
        CSAPI.SetText(txt_teamName,LanguageMgr:GetByID(25021));
        -- CSAPI.SetGOActive(dropDownList,true);
        CSAPI.SetGOActive(btnUse,data.showClean);
        CSAPI.SetGOActive(txt_disable,false);
    end
    if data.openSetting==TeamConfirmOpenType.Tower or data.openSetting==TeamConfirmOpenType.TotalBattle then
        dropClick.raycastTarget=false;
        dropClick2.raycastTarget=false;
        CSAPI.SetGOActive(dropTirangle,false);
        if data.dungeonCfg and data.dungeonCfg.type == eDuplicateType.EternalBattle then --永境战域
            grids[6].SetDisable(g_EternityWarzoneAssist == nil or g_EternityWarzoneAssist == 0);
            CSAPI.SetGOActive(btnSkill,g_EternityWarzoneTactics ~= nil and g_EternityWarzoneTactics == 1);
            CSAPI.SetAnchor(btnAI,738,(g_EternityWarzoneTactics ~= nil and g_EternityWarzoneTactics == 1) and -87 or -40)
        end
    elseif data.openSetting==TeamConfirmOpenType.GlobalBoss then
        dropClick.raycastTarget=dropCanClicker;
        dropClick2.raycastTarget=dropCanClicker;
        CSAPI.SetGOActive(dropTirangle,dropCanClicker);
        CSAPI.SetGOActive(btnSkill,false);
        CSAPI.SetAnchor(btnAI,738,-40)        
    else
        dropClick.raycastTarget=dropCanClicker;
        dropClick2.raycastTarget=dropCanClicker;
        CSAPI.SetGOActive(dropTirangle,dropCanClicker);
    end
    canvasGroup.alpha=alpha;
    CheckModelOpen();
    if grids then
        for i=1,5 do
            grids[i].SetDisable(gridDisable);
        end
    end
end

function CheckModelOpen()
    local isOpen,lockStr=MenuMgr:CheckModelOpen(OpenViewType.main, FormationUtil.SkillModuleKey)
    local isOpen2,lockStr2=MenuMgr:CheckModelOpen(OpenViewType.special, FormationUtil.AIModuleKey)
    CSAPI.SetGOActive(sLockImg,isOpen~=true);
    CSAPI.SetGOActive(aLockImg,isOpen2~=true);
    UIUtil:SetBtnState(btnSkill,isOpen);
    UIUtil:SetBtnState(btnAI,isOpen2)
    -- skillAlpha.alpha=isOpen and 1 or 0.5
    -- aiAlpha.alpha=isOpen2 and 1 or 0.5;
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

--放置助战卡牌
function PushAssistCard(assist)
    -- local card =assist.card;
    local card=assist:GetCard();
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
    local isSuccess,pos=formatTab:TryPushTeamItemData(teamItemData);
    if isSuccess then
        teamItemData.col=pos.col;
        teamItemData.row=pos.row;
        teamData:AddCard(teamItemData);
        TeamMgr:AddAssistTeamIndex(card:GetID(), teamData:GetIndex());
    else
        Tips.ShowTips(LanguageMgr:GetTips(14007));
        TeamMgr:RemoveAssistTeamIndex(card:GetID());
        assistData=nil;
    end
end

---------------------------------------------支援技能
function SetAssistSkill()
    CSAPI.SetGOActive(btnAssitSkill,data.openSetting == TeamConfirmOpenType.Trials)
    if data.openSetting == TeamConfirmOpenType.Trials then
        local info = FileUtil.LoadByPath("Trials_Team_Skill.txt") or {}
        local str = LanguageMgr:GetByID(37082)
        if info[data.dungeonCfg.group] and info[data.dungeonCfg.group].skillId then
            local _cfg = Cfgs.CfgBuffChain:GetByID(info[data.dungeonCfg.group].skillId)
            str = _cfg and _cfg.name or str
            assistSkillId = info[data.dungeonCfg.group].skillId
        end
        CSAPI.SetText(txtAssistSkill, str)
    end
end

function OnClickAssistSkill()
    local skillInfo = {}
    skillInfo.datas = GetSkillDatas()
    skillInfo.closeCallBack = OnCloseCallBack
    CSAPI.OpenView("Trials2Skill", skillInfo)
end

function GetSkillDatas()
    local _cfgs = {}
    if data.dungeonCfg.arrSkill then
        local _cfg = nil
        for i, v in ipairs(data.dungeonCfg.arrSkill) do
            _cfg = Cfgs.CfgBuffChain:GetByID(v)
            if _cfg then
                table.insert(_cfgs, _cfg)
            end
        end
    end
    return _cfgs
end

function OnCloseCallBack(selId)
    assistSkillId = selId
    local info = FileUtil.LoadByPath("Trials_Team_Skill.txt") or {}
    info[data.dungeonCfg.group] = info[data.dungeonCfg.group] or {}
    info[data.dungeonCfg.group].skillId = selId
    FileUtil.SaveToFile("Trials_Team_Skill.txt", info)
    local str = LanguageMgr:GetByID(37082)
    if info[data.dungeonCfg.group].skillId then
        local _cfg = Cfgs.CfgBuffChain:GetByID(info[data.dungeonCfg.group].skillId)
        str = _cfg and _cfg.name or str
    end
    CSAPI.SetText(txtAssistSkill, str)
end

function GetAssistBuff()
    return assistSkillId
end

function OnDestroy()   
    if(eventMgr)then         
        eventMgr:ClearListener();
    end
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
dropTween=nil;
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