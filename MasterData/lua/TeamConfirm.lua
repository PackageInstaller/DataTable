--队伍选择面板
local currDungeonID=nil;
local teamItems={};
local startTeamIdx=0; --起始队伍下标
local endTeamIdx=0; --结束队伍下标
local teamMax=1;
local count=0;--当前可用队伍数量
local localCfg=nil;--本地保存信息
local choosieID={};--当前选择的队伍id
local downListView
local forceNPC=nil;--强制支援NPC
local assistNPCList=nil;--可选支援NPC ID列表
local isEdit=false;
local isNotAssist=false;
local slider=nil;
local currCostHot=0;--当前消耗的热值
local currCostInfo=nil;--当前消耗物品的信息
local cond=nil;
local dungeonCfg=nil;
local battleCanvas=nil;
local towerIndex=eTeamType.Tower;
local condDescItems={};
local disChoosie=false;--禁用下来选择
local raisingInfo=nil;--培养引导信息
local isFightCond=false;--队伍战力是否满足
-- {-5.22988,-200}
-- {-5.22988,250}
function Awake()
    UIUtil:AddQuestionItem("TeamConfirm", gameObject, AdaptiveScreen)
    -- slider=ComUtil.GetCom(hotSlider, "OutlineBar")
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Team_Confirm_Refreh, RefreshItems)
    eventMgr:AddListener(EventType.Team_Confirm_ItemDisable, OnOptionChange)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.CoolView_Close, RefreshTeams);    
    eventMgr:AddListener(EventType.Team_Card_Refresh, RefreshTeams);    
    --更新热值
	eventMgr:AddListener(EventType.CardCool_Update, OnCardCoolUpdate)
    eventMgr:AddListener(EventType.Player_HotChange, SetEnterCost)
    eventMgr:AddListener(EventType.Bag_Update,SetEnterCost);
    eventMgr:AddListener(EventType.Fight_Enter_Fail,OnEnterFail)
    eventMgr:AddListener(EventType.Team_Raising_GoBattle,OnGoBattle)
    CSAPI.SetGOActive(btnAISetting,true);
    battleCanvas=ComUtil.GetCom(btnBattle,"CanvasGroup");
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
    local team=TeamMgr:GetTeamData(1,true);
    if not isEdit then
        RefreshItems();
    end
end

function OnInit()
    UIUtil:AddTop2("TeamConfirm",gameObject, OnClickClose,nil,{})
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

function OnOpen()
    TeamMgr:ClearAssistTeamIndex();
    if data then
        isNotAssist=data.isNotAssist;
        disChoosie=data.disChoosie;
        if data.dungeonId then
            currDungeonID=data.dungeonId;
            dungeonCfg=Cfgs.MainLine:GetByID(currDungeonID)
            if dungeonCfg~=nil then
                DungeonMgr:SetCurrId1(dungeonCfg.id);
            end
        end
    end
    -- if FriendMgr:IsRefreshAssist() then
    --     FriendMgr:InitAssistData();
    -- end
    CSAPI.SetGOActive(condObj,false);
    if openSetting==TeamConfirmOpenType.Dungeon then
        LoadConfig();
        InitDungeon();
    elseif openSetting==TeamConfirmOpenType.Matrix then
        InitMatrix();
    elseif openSetting==TeamConfirmOpenType.FieldBoss then
        InitFieldBoss()
    elseif openSetting==TeamConfirmOpenType.Tower then
        InitTower();
    elseif openSetting==TeamConfirmOpenType.Rogue then
        InitRogue();
    elseif openSetting==TeamConfirmOpenType.TotalBattle then
        InitTotalBattle();
    elseif openSetting==TeamConfirmOpenType.GlobalBoss then
        InitGlobalBoss()
    elseif openSetting==TeamConfirmOpenType.RogueT then
        InitRogueT();
    elseif openSetting==TeamConfirmOpenType.BuffBattle then
        InitBuffBattle();
    elseif openSetting==TeamConfirmOpenType.MultTeamBattle then
        InitMTB();
    elseif openSetting==TeamConfirmOpenType.RogueMap then
        InitRogueMap();
    elseif openSetting==TeamConfirmOpenType.RogueMapAssist then
        InitRogueMapAssist();
    elseif openSetting==TeamConfirmOpenType.Trials then
        InitDungeon()
    elseif openSetting==TeamConfirmOpenType.PeriodicBoss then
        LoadConfig()
        InitPeriodicBoss()
    end
    InitChoosieIDs();--初始化已选择的队伍id
    InitOptions();
    InitItem();
    InitHotItem();
    InitRaisingInfo();
    --LogError(data);
    EventMgr.Dispatch(EventType.Guide_Trigger_View,data);--尝试触发引导
end

function InitHotItem()
    if currCostInfo then
         --读取消耗信息
         local type = currCostInfo[3] or 2
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

function RefreshItems()
    RefreshChoosieIDs();
    InitOptions()
    InitRaisingInfo();
    local list={};
    for k,v in ipairs(teamItems) do
        local state=TeamConfirmItemState.Normal;
        if openSetting==TeamConfirmOpenType.Matrix or isNotAssist then
            state=TeamConfirmItemState.UnAssist;
        end
        if k>teamMax then
            state=TeamConfirmItemState.Disable;
        end
        local npc=k==1 and forceNPC or nil
        table.insert(list,{id=k,num=k,options=optionsData,forceNPC=npc,NPCList=assistNPCList,showClean=teamMax>1,currState=v.GetState(),state=state,ShowDownList=ShowDownList,openSetting=openSetting,cond=cond,dungeonCfg=dungeonCfg,isDirll=data.isDirll,dungeonId = data.dungeonId,showFakeLevel = data.showFakeLevel});
    end
    ItemUtil.AddItems("TeamConfirm/TeamListItem", teamItems, list, itemNode, nil, 1, nil)
end

function RefreshTeams()
    InitRaisingInfo();
    for k,v in ipairs(teamItems) do
        v.SetTeamData(v.GetTeamIndex());
    end
    if openSetting==TeamConfirmOpenType.Tower then
        SetBtnStateTower();
    end
end

function InitItem()
    local list={};
    if teamMax>1 then
        CSAPI.SetGOActive(lines,true);
        CSAPI.SetGOActive(lines2,false);
    else
        CSAPI.SetGOActive(lines2,true);
        CSAPI.SetGOActive(lines,false);
    end
    for i=1,teamMax do
        local state=TeamConfirmItemState.Normal;
        if openSetting==TeamConfirmOpenType.Matrix or isNotAssist then
            state=TeamConfirmItemState.UnAssist;
        end
        if i>teamMax then
            state=TeamConfirmItemState.Disable;
        end
        local npc=i==1 and forceNPC or nil
        table.insert(list,{id=i,num=i,options=optionsData,showClean=teamMax>1,forceNPC=npc,NPCList=assistNPCList,state=state,ShowDownList=ShowDownList,openSetting=openSetting,cond=cond,dungeonCfg=dungeonCfg,isDirll=data.isDirll,dungeonId = data.dungeonId,showFakeLevel = data.showFakeLevel});
    end
    ItemUtil.AddItems("TeamConfirm/TeamListItem", teamItems, list, itemNode, nil, 1, nil)
end

function InitChoosieIDs()
    local choosieCount=0;
    local otherID={};--未选中的可用队伍id
    --查找当前可用的队伍中是否有对应的id
    for i = startTeamIdx, endTeamIdx do
        local team=TeamMgr:GetTeamData(i);
        if team and ((team:GetCount()>0 and team:HasLeader()) or disChoosie) then
            if  localCfg~=nil then
                local hasID=false;
                local idx=0;
                for k,v in ipairs(localCfg) do
                    if v.order==-1 then --置空
                        hasID=true;
                        choosieID[v.index]={index=v.index,teamId=v.order};
                        choosieCount=choosieCount+1;
                        idx=k;
                        break;
                    elseif i==v.order then                 
                        hasID=true;
                        --可以选中的队伍
                        choosieID[v.index]={index=v.index,teamId=i};--index:子物体的下标，teamId:队伍id
                        choosieCount=choosieCount+1;
                        idx=k;
                        break;
                    end
                end
                if hasID==false then
                    table.insert(otherID,i);
                else
                    table.remove(localCfg,idx);
                end
            elseif disChoosie then--禁用选择
                choosieID[1]={index=1,teamId=i};
                choosieCount=choosieCount+1;
            else
                table.insert(otherID,i);
            end
        end
    end
    if choosieCount<teamMax then
        if choosieCount==0 then
            otherID={1,2};
        elseif (otherID==nil or #otherID<=0) and choosieID then
            for i = startTeamIdx, endTeamIdx do
                local has=false;
                for k,v in pairs(choosieID) do
                    if i==v.teamId then
                        has=true;
                        break;
                    end
                end
                if has~=true then
                    table.insert(otherID,i);
                    break;
                end
            end
        end
        local otherIndex=1;
        for i=1,teamMax  do
            if choosieCount>0 then
                for k,v in pairs(choosieID) do
                    if i~=v.index then
                        choosieID[i]={index=i,teamId=otherID[otherIndex]};
                        otherIndex=otherIndex+1;
                        choosieCount=choosieCount+1;
                    end
                end
            else
                choosieID[i]={index=i,teamId=otherID[otherIndex]};
                otherIndex=otherIndex+1;
                choosieCount=choosieCount+1;
            end
            if choosieCount==teamMax then
                break;
            end
        end
    end
    count=choosieCount;
end

function RefreshChoosieIDs() --当编队消失时查找下一支符合编队条件的队伍
    local choosieCount=0;
    local otherID={};--未选中的可用队伍id
    local choosieIndex=0;
    --查找当前可用的队伍中是否有对应的id
    for i = startTeamIdx, endTeamIdx do
        local team=TeamMgr:GetTeamData(i);
        local hasID=false;
        if choosieID then
            for k,v in pairs(choosieID) do
                 if v.teamId==i and team and ((team:GetCount()>0 and team:HasLeader()) or  disChoosie) then --置空
                    hasID=true
                    choosieCount=choosieCount+1;
                    choosieIndex=v.index;
                    break;
                elseif v.teamId==-1 then                 
                    hasID=true;
                    choosieID[v.index]={index=tonumber(v.index),teamId=i};--index:子物体的下标，teamId:队伍id
                    choosieCount=choosieCount+1;
                    break;
                end
            end
        end
        if hasID==false and team and team:GetCount()>0 and team:HasLeader() then
            table.insert(otherID,i);
        end
    end
    if choosieCount<teamMax and otherID~=nil and #otherID>0 then
        if choosieCount==0 then
            otherID={1,2};
        elseif (otherID==nil or #otherID<=0) and choosieID then
            for i = startTeamIdx, endTeamIdx do
                local has=false;
                for k,v in pairs(choosieID) do
                    if i==v.teamId then
                        has=true;
                        break;
                    end
                end
                if has~=true then
                    table.insert(otherID,i);
                    break;
                end
            end
        end
        local otherIndex=1;
        for i=1,teamMax  do
            if choosieCount>0 then
                for k,v in pairs(choosieID) do
                    if choosieIndex~=v.index then
                        choosieID[v.index]={index=v.index,teamId=otherID[otherIndex]};
                        otherIndex=otherIndex+1;
                        choosieCount=choosieCount+1;
                    end
                end
            else
                choosieID[i]={index=i,teamId=otherID[otherIndex]};
                otherIndex=otherIndex+1;
                choosieCount=choosieCount+1;
            end
            if choosieCount==teamMax then
                break;
            end
        end
    end
    count=choosieCount;
end

function InitOptions()
    optionsData = {};
    local sNum=0;--选中的id数
    for i = startTeamIdx, endTeamIdx do
        local team=TeamMgr:GetTeamData(i);
        if team then
            local option={};
            if sNum<count then
                for k,v in pairs(choosieID) do
                    if i==v.teamId then
                        option.isSelect=true;
                        option.itemID=v.index; --子物体id
                        sNum=sNum+1;
                        break;
                    end
                end   
            end
            if team:GetIndex()<=g_TeamMaxNum then
                option.desc=i<10 and "0".. i or i; --选项描述
            else
                option.desc="???";
            end
            option.name=team:GetTeamName();
            option.id=i; --队伍id
            -- option.index=#optionsData+1;--选项下标
            if (team:GetCount()>0 and team:HasLeader()) or option.isSelect  then
                option.enable=true;
                table.insert(optionsData, option);
            -- else
            --     option.enable=false;
            end
        end
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
        if isFightLess then
            local raisingCfg=Cfgs.CultivateId:GetByID(dungeonCfg.idCultivate)
            raisingInfo= FormationUtil.CheckRaising(teamList,raisingCfg);
        end
        isFightCond=not isFightLess
    end
    if raisingInfo~=nil then
        --根据类型显示培养不足的提示
        CSAPI.SetGOActive(raisingObj,true)
        -- CSAPI.SetText(txtRaising,LanguageMgr:GetByID(FormationUtil.RaisingTypeTips[raisingInfo.raisingType]));
    else
        CSAPI.SetGOActive(raisingObj,false)
    end
end

function OnClickBattle()
	local isHideDailyTips1 = TipsMgr:IsShowDailyTips(FormationUtil.RaisingDailyKey)
    local isHideDailyTips2 = TipsMgr:IsShowDailyTips(FormationUtil.RaisingDailyKey2)
    local key=dungeonCfg and "RaisingTips"..dungeonCfg.id or nil;
    local isCurrTips=TipsMgr:IsShowDailyTips(key)
    --如果两个窗口都被屏蔽，则不弹窗口
    if raisingInfo and dungeonCfg and dungeonCfg.idCultivate and isFightCond~=true and data and data.isDirll~=true then
        local isShowTips=false;
        if isHideDailyTips1 and raisingInfo.lessMemberID~=nil then
            isShowTips=true;
        elseif isHideDailyTips2 and raisingInfo.raisingType~=nil and isCurrTips then
            isShowTips=true;
        end
        if isHideDailyTips2 and isCurrTips~=true then
            isHideDailyTips2=false
        end
        if isShowTips then
            FormationUtil.OpenRaisingView(raisingInfo,dungeonCfg,not isHideDailyTips1,not isHideDailyTips2);
            do return end;
        end
    end
    OnBattle();
end

function OnClickRaising()
    if raisingInfo and dungeonCfg and dungeonCfg.idCultivate then
        FormationUtil.OpenRaisingView(raisingInfo,dungeonCfg,true,2);
        TipsMgr:SaveDailyTips(key,true)
    end
end

function OnBattle()
    -- 检测热值
    if data.isDirll ~= true then
        if currCostInfo then
            -- 读取消耗信息
            local type = currCostInfo[3]
            -- local type=2;
            local num = currCostInfo[2];
            local cid = currCostInfo[1];
            if type == RandRewardType.ITEM then
                local data = GoodsData()
                data:InitCfg(cid)
                local hasCount = BagMgr:GetCount(cid);
                if hasCount < num then
                    Tips.ShowTips(LanguageMgr:GetTips(8014, data:GetName()))
                    return;
                end
            else
                LogError("配置表错误！道具类型错误！");
                LogError(currCostInfo);
            end
        else
            local currHot = PlayerClient:Hot();
            if currHot < math.abs(currCostHot) then
                -- 弹出补充热值的提示
                CSAPI.OpenView("HotPanel");
                return;
            end
        end
    end
    if openSetting == TeamConfirmOpenType.Dungeon then
        OnDungeon();
    elseif openSetting == TeamConfirmOpenType.Matrix then
        OnMatrix();
    elseif openSetting == TeamConfirmOpenType.FieldBoss then
        OnFieldBoss()
    elseif openSetting == TeamConfirmOpenType.Tower then
        OnTower();
    elseif openSetting == TeamConfirmOpenType.Rogue then
        OnRogue();
    elseif openSetting == TeamConfirmOpenType.TotalBattle then
        OnTotalBattle();
    elseif openSetting == TeamConfirmOpenType.GlobalBoss then
        OnGlobalBoss()
    elseif openSetting == TeamConfirmOpenType.RogueT then
        OnRogueT();
    elseif openSetting == TeamConfirmOpenType.BuffBattle then
        OnBuffBattle();
    elseif openSetting==TeamConfirmOpenType.MultTeamBattle then
        OnMTB();
    elseif openSetting==TeamConfirmOpenType.RogueMap then
        OnRogueMap();
    elseif openSetting==TeamConfirmOpenType.RogueMapAssist then
        OnRogueMapAssist();
    elseif openSetting == TeamConfirmOpenType.Trials then
        OnTrials()
    elseif openSetting==TeamConfirmOpenType.PeriodicBoss then
        OnPeriodicBoss()
    end
end

function OnGoBattle(eventData)
    if not IsNil(gameObject) and eventData[1] and dungeonCfg and dungeonCfg.id==eventData[1] then
        if eventData[2]~=true then
            OnBattle();
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
            OnBattle();
        end
    end
end

function OnClickClose()
    TeamMgr:ClearAssistTeamIndex();
    Close();
end

function SetEnterCost()
    if currCostInfo~=nil then
        --读取消耗信息
        local type = currCostInfo[3]
        -- local type=2;
        local num=currCostInfo[2];
        if data and data.isDirll then
            num=0;
        end
        local cid=currCostInfo[1];
        if type == RandRewardType.ITEM then
            local d = GoodsData()
            d:InitCfg(cid)
            local hasCount=BagMgr:GetCount(cid);
            ResUtil.IconGoods:Load(costIcon,d:GetIcon().."_3");
            local costHot=hasCount>=num and string.format("<color='#000000'>%s</color>",num) or string.format("<color='#cd333e'>%s</color>",num);
            CSAPI.SetText(txt_cost,d:GetName().."-"..costHot);
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

function Close()
    view:Close();
end
function OnClickEdit()
    CSAPI.OpenView("TeamView");
end

function InitDungeon()
    if CSAPI.IsViewOpen("FightOverResult") then
        FightClient:Clean()
        FriendMgr:ClearAssistData();
        TeamMgr:ClearAssistTeamIndex();
        TeamMgr:ClearFightTeamData();
        UIUtil:AddFightTeamState(2, "FightOverResult:ApplyQuit()")
    end
    if data and data.teamNum then
        teamMax=data.teamNum 
    else
        teamMax=1;
    end
    --读取强制NPC的id，该支援位只有队伍一存在
    local starNum=0;
    local dungeonData= DungeonMgr:GetDungeonData(currDungeonID);
    -- local enterCost=0;
    -- local successCost=0;
    local moveLimit=0;
    local warnDesc=nil;
    if dungeonData and dungeonData:IsPass() then--已通关
        forceNPC=nil;
        assistNPCList=dungeonData:GetAssistNPCList();
        starNum=dungeonData:GetStar();
        -- enterCost=dungeonData:GetCfg().enterCostHot or 0;
        -- successCost=dungeonData:GetCfg().winCostHot or 0;
        moveLimit=dungeonData:GetActionNum();
        warnDesc=dungeonData:GetCfg().teamDescription
    else
        forceNPC=dungeonCfg.forceNPC;
        assistNPCList=dungeonCfg.arrNPC;
        -- enterCost=dungeonCfg.enterCostHot or 0;
        -- successCost=dungeonCfg.winCostHot or 0;
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
        warnDesc=dungeonCfg.teamDescription
    end
    if isNotAssist then
        warnDesc=teamMax>1 and LanguageMgr:GetByID(15076) or LanguageMgr:GetByID(15075)
    end
    CSAPI.SetGOActive(tipsWarn,warnDesc~=nil);
    CSAPI.SetText(txt_tipsWarn,warnDesc==nil and "" or warnDesc);
    --如果配置表中存在cost值，则读取cost信息，否则直接当热值处理
    currCostInfo=DungeonUtil.GetCost(dungeonCfg);
    currCostHot=DungeonUtil.GetHot(dungeonCfg);
    -- math.ceil((enterCost+successCost) * (100- DungeonUtil.GetExtreHotNum()) / 100);
    SetFighting(dungeonCfg.lvTips);
    SetEnterCost();
    CSAPI.SetText(txt_move,tostring(moveLimit));
    -- if dungeonCfg.nGroupID==nil or dungeonCfg.nGroupID=="" then --没有怪物组ID的时候执行逻辑
    --     CSAPI.SetGOActive(btnNavi,starNum==3);
    -- else
    --     CSAPI.SetGOActive(btnNavi,false);
    -- end
    CSAPI.SetGOActive(nameObj,true);
    startTeamIdx = 1;
    endTeamIdx = g_TeamMaxNum;
end

function OnDungeon()
    local teamNum=0;
    local duplicateTeamDatas={};
    local choosieID={};
    local choosieInfo={};--缓存配置的信息
    for k,v in ipairs(teamItems) do
        if k<=teamMax and v.IsUse()==true then
            local duplicateTeam=v.GetDuplicateTeamData();
            local canBattle=v.CanBattle();
            if v.GetState()~=TeamConfirmItemState.UnUse and canBattle==false then
                teamNum=teamNum+1;
            elseif duplicateTeam~=nil and canBattle==true and v.GetState()~=TeamConfirmItemState.UnUse then
                teamNum=teamNum+1;
                table.insert(duplicateTeamDatas,duplicateTeam);
                table.insert(choosieID,duplicateTeam.nTeamIndex);
                table.insert(choosieInfo,{index=k,order=duplicateTeam.nTeamIndex});
            end
        end
    end
    if currDungeonID==nil or currDungeonID=="" then
        LogError("出战关卡的ID不能为nil！"..tostring(currDungeonID));
        return;
    elseif #duplicateTeamDatas==teamNum then
        if #duplicateTeamDatas>0 then
            --判断装备是否超量
            if EquipMgr:IsBagFull() then
                TipsMgr:HandleMsg({strId="equipBagSpaceLimit"});
                -- Tips.ShowTips(LanguageMgr:GetTips(14003));
                do return end
            end
            --进入战斗！！
            BattleMgr:SetLastCtrlId(nil);
            for k,v in ipairs(choosieID) do --用于处理单机模式下获取不到战斗中队伍数据的情况
                TeamMgr.currentIndex=v;
                local teamData=TeamMgr:GetEditTeam();
                if  teamItems[k] and teamItems[k].GetAssistData()~=nil then
                    teamData:AddCard(teamItems[k].GetAssistData());
                end
                TeamMgr:AddFightTeamData(teamData);
                UIUtil:AddFightTeamState(1,"TeamConfirm:OnDungeon()")
            end
            TeamMgr:DelEditTeam();
            for k, v in ipairs(duplicateTeamDatas) do
                for _, val in ipairs(v.team) do
                    if val.fuid then --助战卡
                        FriendMgr:SetAssistMemberCnt(val.fuid);
                    end
                end
            end
            -- LogError(duplicateTeamDatas)
            DungeonMgr:ApplyEnter(currDungeonID, choosieID, duplicateTeamDatas);
            SaveConfig(choosieInfo);
            UIUtil:AddNetWeakHandle(500);
        else
            Tips.ShowTips(LanguageMgr:GetTips(14004));
        end
    elseif duplicateTeamDatas==nil or #duplicateTeamDatas<1 then
        Tips.ShowTips(LanguageMgr:GetTips(14005));
    end
end

function InitMatrix()
    CSAPI.SetGOActive(nameObj,false);
    -- CSAPI.SetGOActive(btnNavi,false);
    startTeamIdx = 1;
    endTeamIdx = g_TeamMaxNum;  
    teamMax=2;
end

function OnMatrix()
    local item=teamItems[1];
    if item.CanBattle()==true then
        local teamData = item.GetDuplicateTeamData()
        MatrixMgr:SetIsAttack(true)
        BuildingProto:AssualtAttack(data.id,data.index,teamData.nTeamIndex,teamData.nSkillGroup);
    end
end

function InitTower()
    CSAPI.SetGOActive(nameObj,false);
    -- CSAPI.SetGOActive(btnNavi,false);
    CSAPI.SetGOActive(fightObj,false);
    if dungeonCfg then
        TowerMgr:SetSectionId(dungeonCfg.group)
        if dungeonCfg.group==7001 then
            towerIndex = eTeamType.Tower
        elseif dungeonCfg.group == 23001 then
            towerIndex = eTeamType.EternalBattle
        elseif dungeonCfg.group == 7002 then
            towerIndex =  eTeamType.TowerDifficulty
        end
        if dungeonCfg.teamLimted~=nil and dungeonCfg.teamLimted~=""  then
            cond=TeamCondition.New();
            cond:Init(dungeonCfg.teamLimted);
            towerIndex=dungeonCfg.group==7001 and eTeamType.Tower or eTeamType.TowerDifficulty;
            CSAPI.SetGOActive(condObj,true);
            local descList=cond:GetDesc();
            if dungeonCfg.tacticsSwitch==1 then
                table.insert(descList,LanguageMgr:GetByID(49028));
            end
            --初始化条件描述
            ItemUtil.AddItems("TeamConfirm/TeamConfirmCondItem", condDescItems, descList, conLayout);
        end
    end
    startTeamIdx = towerIndex;
    endTeamIdx = towerIndex;
    teamMax=1;
    local teamData=TeamMgr:GetTeamData(towerIndex);
    --剔除当前队伍中耐久度为0的卡牌
    FormationUtil.CleanDeathTowerMember(teamData);
    --判断当前队伍中上一局是否存在助战卡，存在则直接上阵
    SetBtnStateTower();
    SetEnterCost();
end

function InitRogue()
    SetEnterCost()
    CSAPI.SetGOActive(nameObj,false);
    -- CSAPI.SetGOActive(btnNavi,false);
    CSAPI.SetGOActive(fightObj,false);
    CSAPI.SetGOActive(hotObj,false)
    startTeamIdx = eTeamType.Rogue;
    endTeamIdx =  eTeamType.Rogue;
    teamMax=1;
    LanguageMgr:SetText(txtRogue,50011)
    CSAPI.SetGOActive(txtRogue,true)
    CSAPI.SetGOActive(rogueMonster,true)
    CSAPI.CreateGOAsync("UIs/DungeonItemInfo/DungeonInfoDetailsRogue", 0, 0, 0, rogueMonster, function(go)
        local lua = ComUtil.GetLuaTable(go)
        lua.Refresh(data.rogueData)
    end)
end

--无限血关
function InitRogueT()
    SetEnterCost()
    CSAPI.SetGOActive(nameObj,false);
    -- CSAPI.SetGOActive(btnNavi,false);
    CSAPI.SetGOActive(fightObj,false);
    CSAPI.SetGOActive(hotObj,false)
    if(dungeonCfg and dungeonCfg.teamLimted)then 
        cond = TeamCondition.New()
        cond:Init(dungeonCfg.teamLimted)
    end
    startTeamIdx = eTeamType.RogueT;
    endTeamIdx =  eTeamType.RogueT;
    teamMax=1;
    CSAPI.SetGOActive(rogueMonster,true)
    CSAPI.CreateGOAsync("UIs/DungeonItemInfo/DungeonInfoDetailsRogue", 0, 0, 0, rogueMonster, function(go)
        local lua = ComUtil.GetLuaTable(go)
        lua.Refresh(data.rogueTData)
    end)
end

function OnRogue()
    local item=teamItems[1];
    if item.CanBattle()==true then
        local teamData = item.GetDuplicateTeamData()
        if(teamData) then 
            FightProto:EnterRogueDuplicate(data.rogueData:GetID(),{teamData},function ()
                view:Close()
                CSAPI.OpenView("RogueBuffSelect",data.rogueData)
            end)
        else
            Tips.ShowTips(LanguageMgr:GetTips(14005)) 
        end 
    end
end

function OnRogueT()
    local item=teamItems[1];
    if item.CanBattle()==true then
        local teamData = item.GetDuplicateTeamData()
        if(teamData) then
            FightProto:EnterRogueTDuplicate(data.rogueTData:GetID(), true)
            FightProto:EnterRogueTFight({teamData})
        else
            Tips.ShowTips(LanguageMgr:GetTips(14005)) 
        end 
    end
end

--爬塔设置按钮状态
function SetBtnStateTower()
    local teamData=TeamMgr:GetTeamData(towerIndex);
    --判断当前队伍中上一局是否存在助战卡，存在则直接上阵
    if cond then
		local result2=cond:CheckPass(teamData)
        battleCanvas.alpha=result2 and 1 or 0.5;
	end
end

--初始化总力战
function InitTotalBattle()
    currCostInfo=DungeonUtil.GetCost(dungeonCfg);
    if TotalBattleMgr:IsFighting() then
        currCostInfo[2]=0
    end
    SetEnterCost()
    CSAPI.SetGOActive(nameObj,false);
    -- CSAPI.SetGOActive(btnNavi,false);
    CSAPI.SetGOActive(fightObj,false);
    CSAPI.SetGOActive(hotObj,false)
    startTeamIdx = eTeamType.TotalBattle;
    endTeamIdx =  eTeamType.TotalBattle;
    teamMax=1;
    local teamData=TeamMgr:GetTeamData(startTeamIdx);
    --剔除当前队伍中耐久度为0的卡牌
    FormationUtil.CleanTotalBattleMember(teamData);
end

function OnTotalBattle()
    local item=teamItems[1];
    local dupTeam = item.GetDuplicateTeamData()
    TeamMgr.currIndex=eTeamType.TotalBattle;
    local teamData=TeamMgr:GetEditTeam();
    if data.isDirll == true and dungeonCfg and dungeonCfg.nGroupID then --模拟战
        if teamData:GetRealCount()<=0 then
            Tips.ShowTips(LanguageMgr:GetTips(14005));
            do return end;
        end
        local dirllData={}
        local tCommanderSkill=nil;
        local skillGroupID=teamData:GetSkillGroupID();
        if skillGroupID and dungeonCfg and dungeonCfg.tacticsSwitch~=1 then
            local tacticData=TacticsMgr:GetDataByID(skillGroupID);
            if tacticData and  tacticData:IsUnLock() then
                tCommanderSkill={};
                tCommanderSkill=tacticData:GetSkillsIds();
            end
        end
        for k,v in ipairs(teamData.data) do
            local itemData=v:GetFightCardData();
            table.insert(dirllData,itemData);
        end
        TeamMgr:AddFightTeamData(teamData);
        DungeonMgr:SetFightTeamId(teamData:GetIndex());
        -- LogError("111111111111111111")
        -- LogError(dirllData)
        -- LogError(tCommanderSkill)
        -- do return end 
        local exData = {}
        if TotalBattleMgr:GetFightBossHp() > 0 then --赋予模拟boss血量，队列表示第几只boss怪
            exData.hpinfo = {{hp = TotalBattleMgr:GetFightBossHp()}}
        end
        CreateDirllFightByData({data=dirllData},dungeonCfg.nGroupID,data.overCB,tCommanderSkill,exData);
        do return end
    else
        OnDungeon();
    end
end
   
function OnTower()
    --检查队伍是否符合限制
    local item=teamItems[1];
    local dupTeam = item.GetDuplicateTeamData()
    TeamMgr.currIndex=towerIndex;
    local teamData=TeamMgr:GetEditTeam();
    if cond and teamData~=nil then
		-- LogError("检测限制--------------->")
        -- LogError(teamData:GetData())
		local result2=cond:CheckPass(teamData)
		if result2~=true then
			-- local dialogData = {}
			-- dialogData.content = "当前队伍不符合限制条件！"
			-- CSAPI.OpenView("Dialog", dialogData)
            if teamData:GetRealCount()>0 then
                Tips.ShowTips(LanguageMgr:GetByID(49033));
            else
                Tips.ShowTips(LanguageMgr:GetTips(14005));
            end
            do return end
		end
		-- LogError("条件："..tostring(cond:GetID()).."\t检测结果："..tostring(result).."\t队伍结果："..tostring(result2))
	end
    --检测是否有助战卡并判断是否已经锁定该卡牌,未锁定则提示是否锁定
    local assistData=item.GetAssistData();
    if data.isDirll == true and dungeonCfg and dungeonCfg.nGroupID then --模拟战
        if teamData:GetRealCount()<=0 then
            Tips.ShowTips(LanguageMgr:GetTips(14005));
            do return end;
        end
        local assistInfo=nil;
        if assistData~=nil and assistData.card~=nil then
            assistInfo=assistData.card:GetAssistData()
        end
        --LogError(assistData)
        local dirllData={}
        local tCommanderSkill=nil;
        local skillGroupID=teamData:GetSkillGroupID();
        if skillGroupID and dungeonCfg and dungeonCfg.tacticsSwitch~=1 then
            local tacticData=TacticsMgr:GetDataByID(skillGroupID);
            if tacticData and  tacticData:IsUnLock() then
                tCommanderSkill={};
                tCommanderSkill=tacticData:GetSkillsIds();
            end
        end
        if (assistInfo and assistInfo.isFull==true) or (assistInfo==nil and teamData:GetAssistID()==nil) then --锁定卡
            if  assistData~=nil and teamData:GetAssistID()==nil then
                assistData.data.hp_percent = TowerMgr:GetCardInfo(assistData.cid,assistData.fuid,dungeonCfg.group) and TowerMgr:GetCardInfo(assistData.cid,assistData.fuid,dungeonCfg.group).tower_hp / 100 or nil
                teamData:AddCard(assistData);
            end
            for k,v in ipairs(teamData.data) do
                local itemData=v:GetFightCardData();
                --赋予剩余血量
                itemData.data.hp_percent = TowerMgr:GetCardInfo(itemData.cid,nil,dungeonCfg.group) and TowerMgr:GetCardInfo(itemData.cid,nil,dungeonCfg.group).tower_hp / 100 or nil
                table.insert(dirllData,itemData);
            end
            TeamMgr:AddFightTeamData(teamData);
            DungeonMgr:SetFightTeamId(teamData:GetIndex());
            -- LogError("111111111111111111")
            -- LogError(dirllData)
            -- LogError(tCommanderSkill)
            -- do return end 
            CreateDirllFightByData({data=dirllData},dungeonCfg.nGroupID,data.overCB,tCommanderSkill,{hpData ={stage = 1,data = TowerMgr:GetDirllMonsterInfos(dungeonCfg.id)}});
        elseif assistInfo~=nil then --未锁定的卡
            local uid=assistData.card:GetData().fuid;
            local cid=assistData.card:GetData().old_cid;
            FriendMgr:SetAssistInfos(uid, {cid}, function()
                if  assistData~=nil and teamData:GetAssistID()==nil then
                    teamData:AddCard(assistData);
                elseif assistData~=nil and teamData:GetAssistID()~=nil then
                    teamData:RemoveCard(assistData:GetID());
                    teamData:AddCard(assistData);
                end
                for k,v in ipairs(teamData.data) do
                    local itemData=v:GetFightCardData();
                    --赋予剩余血量
                    itemData.data.hp_percent = TowerMgr:GetCardInfo(itemData.cid,nil,dungeonCfg.group) and TowerMgr:GetCardInfo(itemData.cid,nil,dungeonCfg.group).tower_hp / 100 or nil
                    table.insert(dirllData,itemData);
                end
                TeamMgr:AddFightTeamData(teamData);
                DungeonMgr:SetFightTeamId(teamData:GetIndex());
                -- LogError(dirllData)
                -- LogError(tCommanderSkill)
                -- do return end 
                CreateDirllFightByData({data=dirllData},dungeonCfg.nGroupID,data.overCB,tCommanderSkill,{hpData ={stage = 1,data = TowerMgr:GetDirllMonsterInfos(dungeonCfg.id)}});
            end);
        end
        do return end
    end
    if assistData~=nil then
        local isLockAssist=FriendMgr:IsLockAssist(assistData:GetID(),dungeonCfg.group);
        -- LogError(assistData)
        -- LogError(tostring(isLockAssist).."\t"..tostring(assistData:GetID()).."\t"..tostring(dungeonCfg.group))
        if isLockAssist~=true then
            local data={
                assist=assistData,
                okCallBack=function() 
                    OnTowerEnter(dupTeam,item,assistData);
                end,
            }
            CSAPI.OpenView("TowerAssistDialog",data);
        else
            OnTowerEnter(dupTeam,item,assistData)
        end
    else
        OnTowerEnter(dupTeam,item,assistData)
    end
end

function OnTowerEnter(dupTeam,item,assistData)
    --提示是否锁定助战卡牌
    if currDungeonID==nil or currDungeonID=="" then
        LogError("出战关卡的ID不能为nil！"..tostring(currDungeonID));
        return;
    elseif item.CanBattle()==true then
        local duplicateTeamDatas = {dupTeam}
        if #duplicateTeamDatas>0 then
            if dungeonCfg.tacticsSwitch then
                for k,v in ipairs(duplicateTeamDatas) do
                    v.nSkillGroup=nil
                end
            end
            --判断装备是否超量
            if EquipMgr:IsBagFull() then
                TipsMgr:HandleMsg({strId="equipBagSpaceLimit"});
                -- Tips.ShowTips(LanguageMgr:GetTips(14003));
                do return end
            end
                --进入战斗！！
                BattleMgr:SetLastCtrlId(nil);
                TeamMgr.currentIndex=dupTeam.nTeamIndex;
                local teamData=TeamMgr:GetEditTeam();
                if  assistData~=nil then
                    teamData:AddCard(item.GetAssistData());
                    -- FriendMgr:SetAssistMemberCnt(assistData.fuid);
                end
                TeamMgr:AddFightTeamData(teamData);
                UIUtil:AddFightTeamState(1,"TeamConfirm:OnTower()")
                TeamMgr:DelEditTeam();
                DungeonMgr:ApplyEnter(currDungeonID, {dupTeam.nTeamIndex}, duplicateTeamDatas);
                UIUtil:AddNetWeakHandle(500);
        else
            Tips.ShowTips(LanguageMgr:GetTips(14004));
        end
    elseif dupTeam==nil then
        Tips.ShowTips(LanguageMgr:GetTips(14005));
    end
end

function InitFieldBoss()
    -- CSAPI.SetGOActive(btnNavi,false)
    startTeamIdx = 1;
    endTeamIdx = g_TeamMaxNum;  
    teamMax=2;
end

function OnFieldBoss()
    local item=teamItems[1];
    if item.CanBattle()==true then
        local index = item.GetTeamIndex()
        FightProto:EnterBattleFieldBossFight({nTeamIndex = index})
    end
end

function InitGlobalBoss()
    -- CSAPI.SetGOActive(btnNavi,false)
    startTeamIdx = 1;
    endTeamIdx = g_TeamMaxNum;  
    teamMax=1;
    SetEnterCost();
    SetFighting(dungeonCfg and dungeonCfg.lvTips or 0);
end

function OnGlobalBoss()
    local item=teamItems[1];
    local teamData=TeamMgr:GetEditTeam();
    if item.CanBattle()==true then
        if data.isDirll == true and dungeonCfg and dungeonCfg.nGroupID then --模拟战
            if teamData:GetRealCount()<=0 then
                Tips.ShowTips(LanguageMgr:GetTips(14005));
                do return end;
            end
            local dirllData={}
            local tCommanderSkill=nil;
            -- local skillGroupID=teamData:GetSkillGroupID();
            -- if skillGroupID and dungeonCfg and dungeonCfg.tacticsSwitch~=1 then
            --     local tacticData=TacticsMgr:GetDataByID(skillGroupID);
            --     if tacticData and  tacticData:IsUnLock() then
            --         tCommanderSkill={};
            --         tCommanderSkill=tacticData:GetSkillsIds();
            --     end
            -- end
            for k,v in ipairs(teamData.data) do
                local itemData=v:GetFightCardData();
                itemData.data.nStrategyIndex = v:GetStrategyIndex()
                table.insert(dirllData,itemData);
            end
            TeamMgr:AddFightTeamData(teamData);
            DungeonMgr:SetFightTeamId(teamData:GetIndex());
            local exData = {}
            if GlobalBossMgr:GetMaxHp() > 0 then --赋予模拟boss血量，队列表示第几只boss怪
                exData.bossMaxHp = GlobalBossMgr:GetMaxHp()
                exData.bossId = GlobalBossMgr:GetData():GetID()
                exData.buffIds = GlobalBossMgr:GetBuffIds()
            end
            CreateDirllFightByData({data=dirllData},dungeonCfg.nGroupID,data.overCB,tCommanderSkill,exData);
        else
            if GlobalBossMgr:IsKill() then
                LanguageMgr:ShowTips(47001)
                return
            end
            local index = item.GetTeamIndex()
            FightProto:EnterGlobalBossFight(index)    
        end
    end
end

function InitBuffBattle()
    InitDungeon()
end

function OnBuffBattle()
    local teamNum=0;
    local duplicateTeamDatas={};
    local choosieID={};
    local choosieInfo={};--缓存配置的信息
    for k,v in ipairs(teamItems) do
        if k<=teamMax and v.IsUse()==true then
            local duplicateTeam=v.GetDuplicateTeamData();
            local canBattle=v.CanBattle();
            if v.GetState()~=TeamConfirmItemState.UnUse and canBattle==false then
                teamNum=teamNum+1;
            elseif duplicateTeam~=nil and canBattle==true and v.GetState()~=TeamConfirmItemState.UnUse then
                teamNum=teamNum+1;
                table.insert(duplicateTeamDatas,duplicateTeam);
                table.insert(choosieID,duplicateTeam.nTeamIndex);
                table.insert(choosieInfo,{index=k,order=duplicateTeam.nTeamIndex});
            end
        end
    end
    if currDungeonID==nil or currDungeonID=="" then
        LogError("出战关卡的ID不能为nil！"..tostring(currDungeonID));
        return;
    elseif #duplicateTeamDatas==teamNum then
        if #duplicateTeamDatas>0 then
            --判断装备是否超量
            if EquipMgr:IsBagFull() then
                TipsMgr:HandleMsg({strId="equipBagSpaceLimit"});
                -- Tips.ShowTips(LanguageMgr:GetTips(14003));
                do return end
            end
            --进入战斗！！
            BattleMgr:SetLastCtrlId(nil);
            for k,v in ipairs(choosieID) do --用于处理单机模式下获取不到战斗中队伍数据的情况
                TeamMgr.currentIndex=v;
                local teamData=TeamMgr:GetEditTeam();
                if  teamItems[k] and teamItems[k].GetAssistData()~=nil then
                    teamData:AddCard(teamItems[k].GetAssistData());
                end
                TeamMgr:AddFightTeamData(teamData);
                UIUtil:AddFightTeamState(1,"TeamConfirm:OnDungeon()")
            end
            TeamMgr:DelEditTeam();
            for k, v in ipairs(duplicateTeamDatas) do
                for _, val in ipairs(v.team) do
                    if val.fuid then --助战卡
                        FriendMgr:SetAssistMemberCnt(val.fuid);
                    end
                end
            end
            local buffs = (data and data.buffs) and data.buffs or nil
            -- LogError(duplicateTeamDatas)
            DungeonMgr:ApplyBuffBattle(currDungeonID, choosieID, duplicateTeamDatas,buffs);
            BuffBattleMgr:ClearIDs()
            SaveConfig(choosieInfo);
            UIUtil:AddNetWeakHandle(500);
        else
            Tips.ShowTips(LanguageMgr:GetTips(14004));
        end
    elseif duplicateTeamDatas==nil or #duplicateTeamDatas<1 then
        Tips.ShowTips(LanguageMgr:GetTips(14005));
    end
end

function InitMTB()
    CSAPI.SetGOActive(rogueMonster,true)
    --加载详情界面
    CSAPI.CreateGOAsync("UIs/MultTeamBattle/DungeonInfoDetails", 0, 0, 0, rogueMonster, function(go)
        local lua = ComUtil.GetLuaTable(go)
        lua.Refresh({
            cfg=dungeonCfg,
        })
    end)
    currCostInfo=DungeonUtil.GetCost(dungeonCfg);
    startTeamIdx = eTeamType.MultBattle;
    endTeamIdx =  eTeamType.MultBattle;
    if data and data.teamNum then
        teamMax=data.teamNum 
    else
        teamMax=1;
    end
    CSAPI.SetGOActive(nameObj,false);
    -- CSAPI.SetGOActive(btnNavi,false);
    CSAPI.SetGOActive(fightObj,false);
    CSAPI.SetGOActive(hotObj,false)
    SetEnterCost()
end

function OnMTB()
    local item=teamItems[1];
    local teamData=TeamMgr:GetEditTeam();
    if item.CanBattle()==true and teamData and teamData:GetRealCount()>0 then
        local activityData=MultTeamBattleMgr:GetCurData();
        if activityData and activityData:IsPass(dungeonCfg.id) then
            do return end
        end
        if data.isDirll == true and dungeonCfg and dungeonCfg.nGroupID then --模拟战
            if teamData:GetRealCount()<=0 then
                Tips.ShowTips(LanguageMgr:GetTips(14005));
                do return end;
            end
            local dirllData={}
            local tCommanderSkill=nil;
            local skillGroupID=teamData:GetSkillGroupID();
            if skillGroupID and dungeonCfg and dungeonCfg.tacticsSwitch~=1 then
                local tacticData=TacticsMgr:GetDataByID(skillGroupID);
                if tacticData and  tacticData:IsUnLock() then
                    tCommanderSkill={};
                    tCommanderSkill=tacticData:GetSkillsIds();
                end
            end
            local exData = {}
            local bossInfo=activityData:GetBossInfo(dungeonCfg.id);
            bossInfo=bossInfo or {};
            bossInfo.isMultTeam=true;
            exData=bossInfo;
            --助战卡
            local assistInfo=nil;
            local assistData=item.GetAssistData();
            if assistData~=nil and assistData.card~=nil then
                assistInfo=assistData.card:GetAssistData()
            end
            if (assistInfo and assistInfo.isFull==true) or (assistInfo==nil and teamData:GetAssistID()==nil) then
                if  assistData~=nil and teamData:GetAssistID()==nil then
                    teamData:AddCard(assistData);
                end
                for k,v in ipairs(teamData.data) do
                    local itemData=v:GetFightCardData();
                    itemData.data.nStrategyIndex = v:GetStrategyIndex()
                    table.insert(dirllData,itemData);
                end
                TeamMgr:AddFightTeamData(teamData);
                DungeonMgr:SetFightTeamId(teamData:GetIndex());
                CreateDirllFightByData({data=dirllData},dungeonCfg.nGroupID,data.overCB,tCommanderSkill,exData);
            elseif assistInfo~=nil then --未锁定的卡
                local uid=assistData.card:GetData().fuid;
                local cid=assistData.card:GetData().old_cid;
                FriendMgr:SetAssistInfos(uid, {cid}, function()
                    if  assistData~=nil and teamData:GetAssistID()==nil then
                        teamData:AddCard(assistData);
                    elseif assistData~=nil and teamData:GetAssistID()~=nil then
                        teamData:RemoveCard(assistData:GetID());
                        teamData:AddCard(assistData);
                    end
                    for k,v in ipairs(teamData.data) do
                        local itemData=v:GetFightCardData();
                        itemData.data.nStrategyIndex = v:GetStrategyIndex()
                        table.insert(dirllData,itemData);
                    end
                    TeamMgr:AddFightTeamData(teamData);
                    DungeonMgr:SetFightTeamId(teamData:GetIndex());
                    -- LogError(dirllData)
                    -- LogError(tCommanderSkill)
                    -- do return end 
                    CreateDirllFightByData({data=dirllData},dungeonCfg.nGroupID,data.overCB,tCommanderSkill,exData);
                end);
            end
            -- TeamMgr:AddFightTeamData(teamData);
            -- DungeonMgr:SetFightTeamId(teamData:GetIndex());
            -- LogError(dirllData)
            -- CreateDirllFightByData({data=dirllData},dungeonCfg.nGroupID,data.overCB,tCommanderSkill,exData);
        else
            local duplicateTeam=item.GetDuplicateTeamData();
            FightProto:EnterMultTeamFight(activityData:GetID(),activityData:GetRound(),dungeonCfg.id,{duplicateTeam})    
        end
    else
        Tips.ShowTips(LanguageMgr:GetTips(14005));
    end
end

function InitRogueMap()
    if data and data.teamNum then
        teamMax=data.teamNum 
    else
        teamMax=1;
    end
    --如果配置表中存在cost值，则读取cost信息，否则直接当热值处理
    currCostInfo=DungeonUtil.GetCost(dungeonCfg);
    currCostHot=DungeonUtil.GetHot(dungeonCfg);
    SetFighting(dungeonCfg.lvTips);
    SetEnterCost();
    CSAPI.SetGOActive(nameObj,true);
    startTeamIdx = 1;
    endTeamIdx = g_TeamMaxNum;  
end

function OnRogueMap()
    local teamNum=0;
    local duplicateTeamDatas={};
    local choosieID={};
    local choosieInfo={};--缓存配置的信息
    for k,v in ipairs(teamItems) do
        if k<=teamMax and v.IsUse()==true then
            local duplicateTeam=v.GetDuplicateTeamData();
            local canBattle=v.CanBattle();
            if v.GetState()~=TeamConfirmItemState.UnUse and canBattle==false then
                teamNum=teamNum+1;
            elseif duplicateTeam~=nil and canBattle==true and v.GetState()~=TeamConfirmItemState.UnUse then
                teamNum=teamNum+1;
                table.insert(duplicateTeamDatas,duplicateTeam);
                table.insert(choosieID,duplicateTeam.nTeamIndex);
                table.insert(choosieInfo,{index=k,order=duplicateTeam.nTeamIndex});
            end
        end
    end
    if currDungeonID==nil or currDungeonID=="" then
        LogError("出战关卡的ID不能为nil！"..tostring(currDungeonID));
        return;
    elseif #duplicateTeamDatas==teamNum then
        if #duplicateTeamDatas>0 then
            --判断装备是否超量
            if EquipMgr:IsBagFull() then
                TipsMgr:HandleMsg({strId="equipBagSpaceLimit"});
                do return end
            end
            --进入战斗！！
            BattleMgr:SetLastCtrlId(nil);
            for k, v in ipairs(duplicateTeamDatas) do
                for _, val in ipairs(v.team) do
                    if val.fuid then --助战卡
                        FriendMgr:SetAssistMemberCnt(val.fuid);
                    end
                end
            end
            RogueMapMgr:ApplyEnter(currDungeonID, duplicateTeamDatas,data and data.isDirll)
            SaveConfig(choosieInfo);
            UIUtil:AddNetWeakHandle(500);
        else
            Tips.ShowTips(LanguageMgr:GetTips(14004));
        end
    elseif duplicateTeamDatas==nil or #duplicateTeamDatas<1 then
        Tips.ShowTips(LanguageMgr:GetTips(14005));
    end
end

function InitRogueMapAssist()
    teamMax=1;
    --如果配置表中存在cost值，则读取cost信息，否则直接当热值处理
    currCostInfo=DungeonUtil.GetCost(dungeonCfg);
    currCostHot=DungeonUtil.GetHot(dungeonCfg);
    SetFighting(dungeonCfg.lvTips);
    SetEnterCost();
    CSAPI.SetGOActive(nameObj,true);
    startTeamIdx = 1;
    endTeamIdx = g_TeamMaxNum;  
end

function OnRogueMapAssist()
    local item=teamItems[1];
    if item.CanBattle()==true then
        local duplicateTeam=item.GetDuplicateTeamData();
        RogueMapMgr:ApplyAssistFight(data.assistData,duplicateTeam)
    end
end

function OnTrials()
    local teamNum=0;
    local duplicateTeamDatas={};
    local choosieID={};
    local choosieInfo={};--缓存配置的信息
    local buffs = nil
    for k,v in ipairs(teamItems) do
        if k<=teamMax and v.IsUse()==true then
            local duplicateTeam=v.GetDuplicateTeamData();
            local canBattle=v.CanBattle();
            if v.GetState()~=TeamConfirmItemState.UnUse and canBattle==false then
                teamNum=teamNum+1;
            elseif duplicateTeam~=nil and canBattle==true and v.GetState()~=TeamConfirmItemState.UnUse then
                teamNum=teamNum+1;
                table.insert(duplicateTeamDatas,duplicateTeam);
                table.insert(choosieID,duplicateTeam.nTeamIndex);
                table.insert(choosieInfo,{index=k,order=duplicateTeam.nTeamIndex});
            end
            if v.GetAssistBuff() then
                buffs = buffs or {}
                table.insert(buffs, v.GetAssistBuff())
            end
        end
    end
    if currDungeonID==nil or currDungeonID=="" then
        LogError("出战关卡的ID不能为nil！"..tostring(currDungeonID));
        return;
    elseif #duplicateTeamDatas==teamNum then
        if #duplicateTeamDatas>0 then
            --判断装备是否超量
            if EquipMgr:IsBagFull() then
                TipsMgr:HandleMsg({strId="equipBagSpaceLimit"});
                -- Tips.ShowTips(LanguageMgr:GetTips(14003));
                do return end
            end
            --进入战斗！！
            BattleMgr:SetLastCtrlId(nil);
            for k,v in ipairs(choosieID) do --用于处理单机模式下获取不到战斗中队伍数据的情况
                TeamMgr.currentIndex=v;
                local teamData=TeamMgr:GetEditTeam();
                if  teamItems[k] and teamItems[k].GetAssistData()~=nil then
                    teamData:AddCard(teamItems[k].GetAssistData());
                end
                TeamMgr:AddFightTeamData(teamData);
                UIUtil:AddFightTeamState(1,"TeamConfirm:OnDungeon()")
            end
            TeamMgr:DelEditTeam();
            for k, v in ipairs(duplicateTeamDatas) do
                for _, val in ipairs(v.team) do
                    if val.fuid then --助战卡
                        FriendMgr:SetAssistMemberCnt(val.fuid);
                    end
                end
            end
            -- LogError(duplicateTeamDatas)
            DungeonMgr:ApplyEnter(currDungeonID, choosieID, duplicateTeamDatas,buffs);
            SaveConfig(choosieInfo);
            UIUtil:AddNetWeakHandle(500);
        else
            Tips.ShowTips(LanguageMgr:GetTips(14004));
        end
    elseif duplicateTeamDatas==nil or #duplicateTeamDatas<1 then
        Tips.ShowTips(LanguageMgr:GetTips(14005));
    end
end

function InitPeriodicBoss()
    teamMax=1;
    --如果配置表中存在cost值，则读取cost信息，否则直接当热值处理
    currCostInfo=DungeonUtil.GetCost(dungeonCfg);
    currCostHot=DungeonUtil.GetHot(dungeonCfg);
    SetFighting(dungeonCfg.lvTips);
    SetEnterCost();
    startTeamIdx = eTeamType.PeriodBoss;
    endTeamIdx = eTeamType.PeriodBoss;  
    if data.buffId then
        CSAPI.SetGOActive(buffObj, true)
        local _cfg = Cfgs.cfgPeriodicBossBuffBattle:GetByID(data.buffId)
        if _cfg then
            CSAPI.SetText(txtBuffName,_cfg.name)
            CSAPI.SetText(txtBuffDesc,_cfg.desc)
            if _cfg.icon2 then
                ResUtil.BuffPeridicBoss:Load(buffIcon,_cfg.icon2)
            end
        end
    end
end

function OnPeriodicBoss()
    local item=teamItems[1];
    if item.CanBattle()==true then
        DungeonMgr:SetFightTeamId(item.GetTeamIndex()); -- 设置正在战斗中的队伍id
        DungeonMgr:SetCurrId(dungeonCfg.id)
        local duplicateTeam=item.GetDuplicateTeamData();
        if not duplicateTeam then
            return
        end
        SaveConfig({{index=1,order=duplicateTeam.nTeamIndex}});
        local _data = {
            id = data.bossId,
            isSimulated = data.isDirll,
            list = {duplicateTeam}
        }
        FightProto:PeriodicBossEnterFight(_data)
    end
end

--本地保存当前选择的队伍id
function SaveConfig(tab)
    if tab then
        FileUtil.SaveToFile("config"..data.dungeonId..".txt",tab);
    end
end

--读取当前选择的队伍id
function LoadConfig()
    localCfg=FileUtil.LoadByPath("config"..data.dungeonId..".txt");
end

--刷新下拉面板
function ShowDownList(pos,itemID,func,func2)
    if downListView==nil then
        local go=ResUtil:CreateUIGO("TeamConfirm/TeamDownListView",gameObject.transform);
        downListView=ComUtil.GetLuaTable(go);
    end
    --将pos转为本地坐标
    -- pos=transform:InverseTransformPoint(pos);
    -- pos.x=pos.x+150
    downListView.Show(pos,optionsData,itemID);
    downListView.AddOnValueChange(OnDownValChange);
    downListView.AddOnClose(func2);
end

function OnDownValChange(options)
    for k,v in pairs(options) do
        teamItems[v.itemID].OnDropValChange(v);
        choosieID[v.itemID]={index=v.itemID,teamId=v.id};
    end
end

function OnOptionChange(eventData)
    if optionsData==nil then
        LogError("选择数据为空！"..tostring(startTeamIdx).."\t"..tostring(endTeamIdx).."\t"..tostring(dungeonCfg.id));
        do return end
    end
    for k,v in ipairs(optionsData) do
        if v.itemID==eventData then
            v.itemID=nil;
            v.isSelect=false;
            break;
        end
    end
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
tipsWarn=nil;
txt_tipsWarn=nil;
btnBattle=nil;
txt_battle=nil;
txt_battleTips=nil;
btnNavi=nil;
txt_navi=nil;
txt_naviTips=nil;
hotIcon=nil;
moveIcon=nil;
txt_cost=nil;
txt_move=nil;
view=nil;
end
----#End#----