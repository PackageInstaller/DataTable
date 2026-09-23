--队伍选择面板
local currDungeonID=nil;
local teamItems={};
local teamMax=1;
local forceNPC=nil;--强制支援NPC
local assistNPCList=nil;--可选支援NPC ID列表
local isTeaching=true; --是否是教学关卡
local isNotAssist=false;
local slider=nil;
local currCostHot=0;--当前消耗的热值
local  currCostInfo=nil;
local dungeonCfg=nil;
local raisingInfo=nil;
function Awake()
    -- slider=ComUtil.GetCom(hotSlider, "OutlineBar")
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Team_Confirm_Refreh, OnRefresh)
    eventMgr:AddListener(EventType.CoolView_Close, OnRefresh);
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
     --更新热值
	eventMgr:AddListener(EventType.CardCool_Update, OnCardCoolUpdate)
    eventMgr:AddListener(EventType.Player_HotChange, SetEnterCost)
    eventMgr:AddListener(EventType.Bag_Update,SetEnterCost);
    eventMgr:AddListener(EventType.Fight_Enter_Fail,OnEnterFail)
    eventMgr:AddListener(EventType.Team_Raising_GoBattle,OnGoBattle)
    -- eventMgr:AddListener(EventType.Team_Confirm_OpenSkill, OnClickSkill)
    CSAPI.SetGOActive(btnAISetting,true);
    CSAPI.SetGOActive(btnNavi,false)
end


function OnViewOpened(viewkey)
    if viewkey=="TeamView" then
        isEdit=true;
    end
end

function OnViewClosed(viewkey)
    if viewkey=="TeamView" then
        isEdit=false;
    end
end

function OnCardCoolUpdate()
    if not isEdit then
        OnRefresh();
    end
end

function OnDisable()
    DungeonMgr:ClearAIFightInfo();
    TeamMgr:DelEditTeam();
end

function OnDestroy()
    --清理助战AI预设
    AIStrategyMgr:ClearAssistAIPrefs();
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end


function OnInit()
    UIUtil:AddTop2("TeamForceConfirm",gameObject, OnClickClose,nil,{})
end

function OnOpen()
    TeamMgr:ClearAssistTeamIndex();
    -- if FriendMgr:IsRefreshAssist() then
    --     FriendMgr:InitAssistData();
    -- end
    currDungeonID=data.dungeonId;
    teamMax=data.teamNum;
    isNotAssist=data.isNotAssist;
    --读取强制NPC的id，该支援位只有队伍一存在
    local dungeonData= DungeonMgr:GetDungeonData(currDungeonID);
    dungeonCfg=Cfgs.MainLine:GetByID(currDungeonID)
    if dungeonCfg~=nil then
        DungeonMgr:SetCurrId1(dungeonCfg.id);
    end
    local warnDesc=dungeonCfg.teamDescription
    if isNotAssist then
        warnDesc=teamMax>1 and LanguageMgr:GetByID(15076) or LanguageMgr:GetByID(15075)
    end
    if teamMax>1 then
        CSAPI.SetGOActive(lines,true);
        CSAPI.SetGOActive(lines2,false);
    else
        CSAPI.SetGOActive(lines2,true);
        CSAPI.SetGOActive(lines,false);
    end
    CSAPI.SetGOActive(tipsWarn,warnDesc~=nil);
    CSAPI.SetText(txt_tipsWarn,warnDesc==nil and "" or warnDesc);
    local starNum=0;
    local enterCost=0;
    local moveLimit=0;
    local successCost=0;
    if dungeonData and dungeonData:IsPass() then--已通关
        forceNPC=nil;
        assistNPCList=dungeonData:GetAssistNPCList();
        starNum=dungeonData:GetStar();
        enterCost=dungeonData:GetCfg().enterCostHot or 0;
        successCost=dungeonData:GetCfg().winCostHot or 0;
        moveLimit=dungeonData:GetActionNum();
    else
        forceNPC=dungeonCfg.forceNPC;
        assistNPCList=dungeonCfg.arrNPC;
        enterCost=dungeonCfg.enterCost or 0;
        successCost=dungeonCfg.winCostHot or 0;
        local winNum=10000
        local type = dungeonCfg.jWinCon[1];
        if type == 3 then
            winNum = tonumber(dungeonCfg.jWinCon[2]);
        end
        local loseNum=10000;
        for k,v in ipairs(dungeonCfg.jLostCon) do
            if v[1]==3 then
                loseNum=tonumber(v[2]);
                break;
            end
        end
        moveLimit=winNum<loseNum and winNum or loseNum;
    end
    CSAPI.SetText(txt_cost,tostring(enterCost));
    CSAPI.SetText(txt_move,tostring(moveLimit));
    --如果配置表中存在cost值，则读取cost信息，否则直接当热值处理
    currCostInfo=DungeonUtil.GetCost(dungeonCfg);
    currCostHot=DungeonUtil.GetHot(dungeonCfg);
    --math.ceil((enterCost+successCost) * (100- DungeonUtil.GetExtreHotNum()) / 100);
    SetFighting(dungeonCfg.lvTips);
    SetEnterCost();
    -- if dungeonCfg and dungeonCfg.type==eDuplicateType.Teaching then
    --     isTeaching=true;
    --     CSAPI.SetGOActive(btnNavi,false);
    -- elseif dungeonCfg.nGroupID==nil or dungeonCfg.nGroupID=="" then --没有怪物组ID的时候执行逻辑
    --     CSAPI.SetGOActive(btnNavi,starNum==3);
    -- else
    --     CSAPI.SetGOActive(btnNavi,false);
    -- end
    Init();
    InitHotItem();
    InitRaisingInfo();
    EventMgr.Dispatch(EventType.Guide_Trigger_View,data);--尝试触发引导
end

function Init()
    local list={};
    for i=1,teamMax do
        local teamID=tonumber(currDungeonID)*10+i;
        local state=TeamConfirmItemState.Normal;
        if openSetting==TeamConfirmOpenType.Matrix or isNotAssist then
            state=TeamConfirmItemState.UnAssist;
        end
        if i>teamMax then
            state=TeamConfirmItemState.Disable;
        end
        local npc=i==1 and forceNPC or nil
        table.insert(list,{id=i,teamID=teamID,showClean=teamMax>1,forceNPC=npc,NPCList=assistNPCList,dungeonID=currDungeonID,state=state,parent=this,canClick=not isTeaching});
    end
    ItemUtil.AddItems("TeamConfirm/TeamForceItem", teamItems, list, itemNode, nil, 1, nil)
end

function InitHotItem()
    if currCostInfo then
        --读取消耗信息
        local type = currCostInfo[3]
        -- local type=2;
        local num=currCostInfo[2];
        local cid=currCostInfo[1];
        if type == RandRewardType.ITEM then
            local data = GoodsData()
            data:InitCfg(cid)
            local hasCount=BagMgr:GetCount(cid);
            ResUtil.IconGoods:Load(moneyIcon3,data:GetIcon().."_1");
            CSAPI.SetText(txt_hot,tostring(hasCount));
            CSAPI.SetGOActive(moneyAdd,data:GetMoneyJumpID()~=nil);
        else
            LogError("配置表错误！道具类型错误！");
            LogError(currCostInfo);
        end
   else
       local maxHot=PlayerClient:MaxHot();
       local currHot=PlayerClient:Hot();
       ResUtil.IconGoods:Load(moneyIcon3, "10035_1")
       CSAPI.SetText(txt_hot,string.format("%s/%s",currHot,maxHot));
       CSAPI.SetGOActive(moneyAdd,true);
       -- slider:SetProgress(currHot/maxHot);
   end
end

function SetFighting(num)
    if num==nil or num==0 then
        CSAPI.SetGOActive(fightObj,false);
    else
        CSAPI.SetGOActive(fightObj,true);
        CSAPI.SetText(txt_fighting,tostring(tostring(num)));
    end
end

function SetEnterCost()
        if currCostInfo~=nil then
            --读取消耗信息
            local type = currCostInfo[3]
            -- local type=2;
            local num=currCostInfo[2];
            local cid=currCostInfo[1];
            if type == RandRewardType.ITEM then
                local data = GoodsData()
                data:InitCfg(cid)
                local hasCount=BagMgr:GetCount(cid);
                ResUtil.IconGoods:Load(costIcon,data:GetIcon().."_3");
                local costHot=hasCount>=num and string.format("<color='#000000'>%s</color>",num) or string.format("<color='#cd333e'>%s</color>",num);
                CSAPI.SetText(txt_cost,data:GetName().."-"..costHot);
            else
                LogError("配置表错误！道具类型错误！");
                LogError(currCostInfo);
            end
        else
            local currHot=PlayerClient:Hot();
            local cHot=math.abs(currCostHot)
            local costHot=currHot>=cHot and string.format("<color='#000000'>%s</color>",currCostHot) or string.format("<color='#cd333e'>%s</color>",currCostHot);
            CSAPI.LoadImg(costIcon,"UIs/TeamConfirm/btn_8_07.png",true,nil,true);
            CSAPI.SetText(txt_cost,LanguageMgr:GetByID(26041,costHot));
        end
        InitHotItem();
end

function OnClickBattle()
	if dungeonCfg and dungeonCfg.idCultivate then
        local teamList=nil;
        for k,v in ipairs(teamItems) do
            if k<=teamMax and v.IsUse()==true then
                local duplicateTeam=v.GetDuplicateTeamData();
                local canBattle=v.CanBattle();
                if duplicateTeam~=nil and canBattle==true and v.GetState()~=TeamConfirmItemState.UnUse then
                    teamList=teamList or {};
                    table.insert(teamList,TeamMgr:GetTeamData(v.GetTeamIndex()));
                end
            end
        end
        local raisingCfg=Cfgs.CultivateId:GetByID(dungeonCfg.idCultivate)
        local result= FormationUtil.CheckRaising(teamList,raisingCfg);
        local isHideDailyTips1 = TipsMgr:IsShowDailyTips(FormationUtil.RaisingDailyKey)
        local isHideDailyTips2 = TipsMgr:IsShowDailyTips(FormationUtil.RaisingDailyKey2)
        local key=dungeonCfg and "RaisingTips"..dungeonCfg.id or nil;
        local isCurrTips=TipsMgr:IsShowDailyTips(key)
        --如果两个窗口都被屏蔽，则不弹窗口
        if result and dungeonCfg and dungeonCfg.idCultivate and data and data.isDirll~=true then
            local isShowTips=false;
            if isHideDailyTips1 and result.lessMemberID~=nil then
                isShowTips=true;
            elseif isHideDailyTips2 and result.raisingType~=nil and isCurrTips then
                isShowTips=true;
            end
            if isHideDailyTips2 and isCurrTips~=true then
                isHideDailyTips2=false
            end
            if isShowTips then
                FormationUtil.OpenRaisingView(result,dungeonCfg,not isHideDailyTips1,not isHideDailyTips2);
                do return end;
            end
        end
    end
    OnDungeon();
end


function OnGoBattle(eventData)
     if not IsNil(gameObject) and eventData[1] and dungeonCfg and dungeonCfg.id==eventData[1] then
        if eventData[2]~=true then
            OnDungeon();
        else
            local key=dungeonCfg and "RaisingTips"..dungeonCfg.id or nil;
            local isCurrTips=TipsMgr:IsShowDailyTips(key)
            local isHideDailyTips2 = TipsMgr:IsShowDailyTips(FormationUtil.RaisingDailyKey2)
            if raisingInfo and dungeonCfg and dungeonCfg.idCultivate and isFightCond~=true and data and data.isDirll~=true then
                local isShowTips=false;
                if isHideDailyTips2 and raisingInfo.raisingType~=nil and isCurrTips then
                    isShowTips=true;
                end
                if isHideDailyTips2 and isCurrTips~=true then
                    isHideDailyTips2=false
                end
                if isShowTips then
                    FormationUtil.OpenRaisingView(raisingInfo,dungeonCfg,true,not isHideDailyTips2);
                    do return end;
                end
            end
            OnDungeon();
        end
    end
end

function OnClickRaising()
    if raisingInfo and dungeonCfg and dungeonCfg.idCultivate then
        FormationUtil.OpenRaisingView(raisingInfo,dungeonCfg,true,2);
        TipsMgr:SaveDailyTips(key,true)
    end
end

function InitRaisingInfo()
    local isFightLess=false;
    raisingInfo=nil;
    if dungeonCfg and dungeonCfg.idCultivate and data and data.isDirll~=true then
        local teamList=nil;
        local targetFightVal=dungeonCfg.lvTips and tonumber(dungeonCfg.lvTips) or 0;
        for k,v in ipairs(teamItems) do
            if k<=teamMax and v.IsUse()==true then
                local duplicateTeam=v.GetDuplicateTeamData();
                local canBattle=v.CanBattle();
                if v.GetTeamStrength()<targetFightVal then
                    isFightLess=true;
                end
                if duplicateTeam~=nil and canBattle==true and v.GetState()~=TeamConfirmItemState.UnUse then
                    teamList=teamList or {};
                    table.insert(teamList,TeamMgr:GetTeamData(v.GetTeamIndex()));
                end
            end
        end
        if isFightLess==true then
            local raisingCfg=Cfgs.CultivateId:GetByID(dungeonCfg.idCultivate)
            raisingInfo= FormationUtil.CheckRaising(teamList,raisingCfg);
        end
        isFightCond=not isFightLess
    end
    -- LogError(raisingInfo)
    if raisingInfo~=nil then
        --根据类型显示培养不足的提示
        CSAPI.SetGOActive(raisingObj,true)
        -- CSAPI.SetText(txtRaising,LanguageMgr:GetByID(FormationUtil.RaisingTypeTips[raisingInfo.raisingType]));
    else
        CSAPI.SetGOActive(raisingObj,false)
    end
end

function OnDungeon()
    --检测热值
    if currCostInfo then
        --读取消耗信息
        local type = currCostInfo[3]
        -- local type=2;
        local num=currCostInfo[2];
        local cid=currCostInfo[1];
        if type == RandRewardType.ITEM then
            local data = GoodsData()
            data:InitCfg(cid)
            local hasCount=BagMgr:GetCount(cid);
            if hasCount<num then
                Tips.ShowTips(LanguageMgr:GetTips(8014,data:GetName()))
                return;
            end
        else
            LogError("配置表错误！道具类型错误！");
            LogError(currCostInfo);
        end
   else
        local currHot=PlayerClient:Hot();
        if currHot<math.abs(currCostHot) then
            --弹出补充热值的提示
            CSAPI.OpenView("HotPanel");
            return;
        end
   end
    local canBattle=true;
    local duplicateTeamDatas={};
    local choosieIdx={};
    for k,v in ipairs(teamItems) do
        if k<=teamMax and v.IsUse()==true then
            if v.CheckTeamFormation(true)==false then
                return;
            end
            if v.GetState()==TeamConfirmItemState.UnUse then 
                canBattle=false;
                break;
            else
                local duplicateTeam=v.GetDuplicateTeamData();
                if duplicateTeam~=nil then
                    table.insert(duplicateTeamDatas,duplicateTeam);
                    table.insert(choosieIdx,duplicateTeam.nTeamIndex);
                    if v.isChange then
                        v.SaveData();
                    end
                elseif duplicateTeam==nil and k==1 then
                    --队伍A必须要有队员
                    Tips.ShowTips(LanguageMgr:GetTips(14006));
                    return;
                end
            end
        end
    end
    -- Log( duplicateTeamDatas);
    if currDungeonID==nil or currDungeonID=="" then
        LogError("出战关卡的ID不能为nil！"..tostring(currDungeonID));
        return;
    elseif canBattle and #duplicateTeamDatas>=1 then
        --判断装备是否超量
        if EquipMgr:IsBagFull() then
            TipsMgr:HandleMsg({strId="equipBagSpaceLimit"});
            -- Tips.ShowTips(LanguageMgr:GetTips(14003));
            do return end
        end
        --进入战斗！！
        BattleMgr:SetLastCtrlId(nil);   
        for k,v in ipairs(choosieIdx) do --用于处理单机模式下获取不到战斗中队伍数据的情况
            TeamMgr.currentIndex=v;
            local teamData=TeamMgr:GetEditTeam();
            if  teamItems[k] and teamItems[k].GetAssistData()~=nil then
                teamData:AddCard(teamItems[k].GetAssistData());
            end
            TeamMgr:AddFightTeamData(teamData);
            UIUtil:AddFightTeamState(1,"TeamForceConfirm:OnClickBattle()")
        end
        TeamMgr:DelEditTeam();
        for k, v in ipairs(duplicateTeamDatas) do
            for _, val in ipairs(v.team) do
                if val.fuid then --助战卡
                    FriendMgr:SetAssistMemberCnt(val.fuid);
                end
            end
        end
        DungeonMgr:ApplyEnter(currDungeonID, choosieIdx, duplicateTeamDatas);
        UIUtil:AddNetWeakHandle(500);
    elseif duplicateTeamDatas==nil or #duplicateTeamDatas<1 then
        Tips.ShowTips(LanguageMgr:GetTips(14004));
    end
end

--返回不在卡牌列表中显示的卡牌ID
function GetScreenIDs(itemID)
    local ids=nil;
    for k,v in ipairs(teamItems) do
        if k~=itemID then
            local tab=v.GetScreenIDs();
            ids=ids or {};
            if tab then
                for key, val in ipairs(tab) do
                    table.insert(ids,val);
                end
            end
        end
    end
    return ids;
end

function OnClickClose()
    Close();
end

function Close()
    --保存队伍数据
    for k,v in ipairs(teamItems) do
        v.SaveData();--还原
    end
    view:Close();
end

function OnClickHot()
    if currCostInfo then
        --读取消耗信息
        local type = currCostInfo[3]
        -- local type=2;
        local num=currCostInfo[2];
        local cid=currCostInfo[1];
        if type == RandRewardType.ITEM then
            local data = GoodsData()
            data:InitCfg(cid)
            local jumpId=data:GetMoneyJumpID();
           if jumpId then
                JumpMgr:Jump(jumpId);
           end
        else
            LogError("配置表错误！道具类型错误！");
            LogError(currCostInfo);
        end
    else
        CSAPI.OpenView("HotPanel");
    end
end

function OnRefresh()
    local list={};
    for k,v in ipairs(teamItems) do
        local state=TeamConfirmItemState.Normal;
        if openSetting==TeamConfirmOpenType.Matrix or isNotAssist then
            state=TeamConfirmItemState.UnAssist;
        end
        if k>teamMax then
            state=TeamConfirmItemState.Disable;
        end
        local teamID=tonumber(currDungeonID)*10+k;
        local npc=k==1 and forceNPC or nil
        table.insert(list,{id=k,teamID=teamID,showClean=teamMax>1,forceNPC=npc,NPCList=assistNPCList,dungeonID=currDungeonID,currState=v.GetState(),state=state,parent=this,canClick=not isTeaching});
    end
    ItemUtil.AddItems("TeamConfirm/TeamListItem", teamItems, list, itemNode, nil, 1, nil)
    InitRaisingInfo();
end

--设置AI寻路
function OnClickNavi(go)
    local num=0;
    for k,v in ipairs(teamItems) do
        if v.GetDuplicateTeamData()~=nil and v.GetState()~=TeamConfirmItemState.UnUse then
            num=num+1;
        end
    end
    CSAPI.OpenView("FightNaviSetting",nil,num);
end

function OnEnterFail()
    if gameObject or view then
        view:Close();
    end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
itemNode=nil;
btnBattle=nil;
txt_battle=nil;
txt_battleTips=nil;
tipsWarn=nil;
txt_tipsWarn=nil;
btnNavi=nil;
txt_navi=nil;
txt_naviTips=nil;
tipsObj=nil;
hotIcon=nil;
moveIcon=nil;
txt_cost=nil;
txt_move=nil;
view=nil;
end
----#End#----