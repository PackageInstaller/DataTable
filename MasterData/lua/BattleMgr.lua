require "BattleCharacterMgr";

--副本管理
BattleMgr = {};
local this = BattleMgr;

--初始化监听器
function this:InitListener()
    EventMgr.AddListener(EventType.Battle_Ground_Inited,self.OnBattleGroundInited);  
    EventMgr.AddListener(EventType.Loading_Complete,self.OnLoadingComplete); 
    EventMgr.AddListener(EventType.Loading_View_Close,self.OnLoadingViewClose); 
             
    --EventMgr.AddListener(EventType.Input_Scene_Battle_End_Rot,self.OnBattleGroundRotEnd);  
    EventMgr.AddListener(EventType.Loading_Start,this.OnLoadingStart);
end

--场地初始化完成
function this.OnBattleGroundInited(battleGround)
    this:SetBattleGround(battleGround);
    this:ApplyStart();

    --EventMgr.Dispatch(EventType.Battle_View_Show_Changed,false);
    EventMgr.Dispatch(EventType.Replay_BGM);--重播场景背景音乐    
end

--加载完成
function this.OnLoadingComplete()
    BattleMgr:LoadingComplete();    
    
end
function this:LoadingComplete()  
    self.loadingComplete = 1;
   
    FuncUtil:Call(self.UpdateInputState,self,500);

    if(not self.dontAutoTriggerGuide)then
        self:TriggerGuide();
    end

    local ctrlTargetId = self.moveCtrlTargetId;
    self:SetMoveCtrlTarget();
    FuncUtil:Call(self.SetMoveCtrlTarget,self,200,ctrlTargetId);

    if(self.isReverting)then
        self:RevertComplete();
    end
    self:UpdateInputState("BattleMgr");    

    if(GuideMgr:HasGuide("Battle"))then
        self:UpdateInputState("guide",true); 
    end
    if(self.disableInputTime)then
        self.disableInputTime = nil;
        --CSAPI.DisableInput(3000);   
    end

    self:LoadingViewClose();

    self:UpdateMistViewDis();
end

function this.OnLoadingViewClose()
    BattleMgr:LoadingViewClose()
end
function this:LoadingViewClose()
    if(self.loadingViewClosed )then
        return;
    end
    self.loadingViewClosed = 1;
    if(self.tryShowExplore)then
        self.tryShowExplore = nil;
        self:TryShowExplore();
    end
end

function this:IsCloseInput()
    if(not self.closeInputStates)then
        return false;
    end
    for _,closeInputState in pairs(self.closeInputStates)do
        if(closeInputState)then            
            return true;
        end
    end

    return false;
end

function this:UpdateInputState(key,state)
    self.closeInputStates = self.closeInputStates or {};
    if(key)then
        self.closeInputStates[key] = state;
    end

    for _,closeInputState in pairs(self.closeInputStates)do
        if(closeInputState)then
            self:SetInputState(false);
            return;
        end
    end
    self:SetInputState(true);   
end

function this:SetInputState(state)
    if(self.ground)then        
        self.ground.SetInputState(state);
    end
end
function this:SetLockInputState(key,state)
    self.lockDic = self.lockDic or {};
    self.lockDic[key] = state;

    for _,targetState in pairs(self.lockDic)do
        if(targetState)then
            self:SetInputState(false);
            return;
        end
    end

    self:SetInputState(true);
end


--function this.OnBattleGroundRotEnd()
--    this:ApplyCharactersFaceToCamera();
--end

--重置
function this:Reset()

    --LogError("小地图重置");

    if(self.clearFlag)then
        self.clearFlag = nil;
        self.datas = nil;
        self:SetBattleData();
    end
    self.isInited = nil;
    self.battling = nil;
    self.cacheDatas = self.datas;
    self.datas = {};
    self.currData = nil;
    self.moveData = nil;
    self.isStart = nil;
    self.isFighting = nil; 
    self.isReverting = nil;
    self.isReverted = nil;
    if(self.ground)then
        self.ground.Remove();
    end
    self.ground = nil;
    self.moveCtrlTargetId = nil;
    self.dontAutoTriggerGuide = nil;
    --self.lastCtrlId = nil;
    self.closeInputStates = nil;
    self:UpdateCtrlState(false);
    BattleCharacterMgr:Reset();
    self.bIsNewWave = nil;
    self.autoCheckGridId = nil;
    self.applyFightTime = nil;
    self.triggerFight = nil;
    self.mistDis = nil;
    self.mistEffGO = nil;
    self.mistEff = nil;
    self:SetMistDis();

    if(self.isInitedListener == nil)then
        self.isInitedListener = 1;
        self:InitListener();
    end   
    
    self.loadingComplete = nil;
    self.loadingApply = nil;
    self.loadingViewClosed = nil;

    self:UpdateActionTurn();
end

function this:GetDatas()
    return self.datas;
end

function this:SetNoQuitState(noQuit)
    self.noQuit = noQuit;
    EventMgr.Dispatch(EventType.Battle_Quit_State_Changed);    
end
function this:IsCanQuit()
    return not self.noQuit;
end

function this:SetLastCtrlId(id)
    self.lastCtrlId = id;
end
function this:GetLastCtrlId(id)
    return self.lastCtrlId;
end

--加载界面控制

--开场角色加载loading界面控制用的key
local loading_weight_key = "battle_init";
function this.OnLoadingStart()
--    BattleMgr.isListenLoading = nil;
--    EventMgr.RemoveListener(EventType.Loading_Start,this.OnLoadingStart);

    if(not this.loadingApply)then
        this.loadingApply = 1;
        EventMgr.Dispatch(EventType.Loading_Weight_Apply,loading_weight_key);
        FuncUtil:Call(this.ApplyLoadComplete,this,3000,true);--3秒保护

        EventMgr.Dispatch(EventType.Loading_View_Delay_Close,200); 
    end
end

function this:ApplyLoadComplete(isForce)   
    if(not isForce)then
        if(not self.isStart or not self.isInited)then
            return;
        end
    end
    --关闭loading界面
     EventMgr.Dispatch(EventType.Loading_Weight_Update,loading_weight_key);  
end

function this:NeedShowExplore()
    return self.bIsNewWave;
end
--尝试显示探索界面
function this:TryShowExplore()    
    if(self.bIsNewWave)then
        self.dontAutoTriggerGuide = 1;

        self.bIsNewWave = nil;
        self:SetEnemyShowState(false);
        self:UpdateCharactersMistState();
        --LogError("aa");
        self:Explore();        
        return true;
    else
        self:ExploreCallBack();
    end

    return false;
end

function this:Explore()
    local newMonsterType = self:NewMonsterType(self.battleData.arrChar);
    CSAPI.OpenView("BattleExplore",newMonsterType,BattleEnterType.Start);      
    self:UpdateInputState("explore",true);     
end


function this:TryShowThunderWarning()
 
    if(self.battleData.nStep and self.battleData.nStep == 0)then
        local thunderData = self:GetThunderData();
        if(thunderData)then
            self:ShowThunderWarning(self.ExploreNext);
            return true;
        end
    end
end

function this:NeedShowThunderWarning()
    local data = self.battleData;
    if(data and data.bIsNewWave and data.nStep and data.nStep == 0)then
        local thunderData = self:GetThunderData();
        if(thunderData)then
            return true;
        end
    end
end


function this:NewMonsterType(datas)
    local characters = BattleCharacterMgr:GetAll();
    local targetType = 0;
    if(datas)then
        for _,data in pairs(datas)do
            if(data.type == eDungeonCharType.MonsterGroup and data.bIsNew)then
                local cfgMonsterGroup = Cfgs.MonsterGroup:GetByID(data.nMonsterGroupID);
                targetType = math.max(targetType,cfgMonsterGroup.type);
            end           
        end
    end
   
    return targetType;
end

function this:ExploreCallBack()
    self:UpdateInputState("explore");    

    if(self:TryShowThunderWarning())then--显示落雷预警
        self:UpdateCtrlState(false);
    else
        self:ExploreNext(); 
    end
end
function this:ExploreNextWave()
    self:UpdateInputState("explore");    

    self:SetEnemyShowState(true);
    self:UpdateCharactersMistState();
    FuncUtil:Call(self.RefreshComplete,self,1200);
    --self:RefreshComplete();
end
function this:ExploreNext()

    self:SetEnemyShowState(true);

    self:RefreshComplete();

     if(self:GetCtrlCharacter())then
        self:UpdateActionTurn(true);
    end


    if(self:TryPlayPlot())then     
        self.dontAutoTriggerGuide = 1;
    else
        self:TriggerGuide();	
    end

    --self:UpdateCtrlState(true);
end

function this:ApplyShake(time,range)
    if(not self.ground)then
        return;
    end
    self.ground.ApplyShake(time,range);
end

function this:SetEnemyShowState(isShow)
     --地图单位（友军，怪物，道具）
    local characters = BattleCharacterMgr:GetAll();
    if(characters)then
        for id,character in pairs(characters)do
            local characterType = character.GetType();
            if(characterType == eDungeonCharType.MonsterGroup)then                
                character.SetShowState(isShow and (not character.IsFighting()),true);                    

                if(isShow and character.IsNew())then
                    character.ApplyBorn();
                end     
            end
        end
    end

end

function this:HideNewMonsters()
    local characters = BattleCharacterMgr:GetAll();
    if(characters)then
        for id,character in pairs(characters)do
            local characterType = character.GetType();
            if(characterType == eDungeonCharType.MonsterGroup)then  
                if(character.IsNew())then
                    character.SetShowState(false);   
                end     
            end
        end
    end
end


--尝试播放副本开头剧情
function this:TryPlayPlot0()  
    local currId = DungeonMgr:GetCurrId();
    local cfgDungeon = Cfgs.MainLine:GetByID(currId);
    
    local plotState = PlotMgr:TryPlay(cfgDungeon.storyID0,self.OnPlayPlot0Complete,self);
    if(plotState)then
        self:UpdateInputState("plot0",true);    
        FuncUtil:Call(EventMgr.Dispatch,nil,50,EventType.Plot_Close_Delay,500);
    end
    return plotState;
end
--尝试播放剧情
function this:TryPlayPlot()  
    local currId = DungeonMgr:GetCurrId();
    local cfgDungeon = Cfgs.MainLine:GetByID(currId);
    
    local plotState = PlotMgr:TryPlay(cfgDungeon.storyID,self.OnPlayPlotComplete,self);
    if(plotState)then
        self:UpdateInputState("plot",true);    
    end
    return plotState;
end

function this:HasPlot()
    local currId = DungeonMgr:GetCurrId();
    local cfgDungeon = Cfgs.MainLine:GetByID(currId);

    local plotState = PlotMgr:IsPlayed(cfgDungeon.storyID) and PlotMgr:IsPlayed(cfgDungeon.storyID0);    
    return not plotState;
    --return true;
end

function this:TryPlayBGM()
    local currId = DungeonMgr:GetCurrId();
    local cfgDungeon = Cfgs.MainLine:GetByID(currId);
    if(cfgDungeon)then
        EventMgr.Dispatch(EventType.Play_BGM, cfgDungeon.bgm);
    end
end

--设置场地
function this:SetBattleGround(battleGround)   
    self.ground = battleGround;    
    self:UpdateInputState("BattleMgr",false); 
end
--获取镜头
function this:GetCamera()
    return self.ground.GetCamera();    
end

function this:PlayerEnterFight(time)
    local cameraMgr = self.ground.cameraMgr;
    if(cameraMgr)then
        cameraMgr:SetMoveLimit(-1000,1000,-1000,1000);
        cameraMgr:SetDis(0,0,3000);
        cameraMgr:ZoomToTarget(1000);
        cameraMgr:SyncActionTime(time);
    end 
end

--function this:ApplyCharactersFaceToCamera()
----    local characters = BattleCharacterMgr:GetAll();
----    local goCamera = self:GetCamera();
----    if(characters)then
----        for id,character in pairs(characters)do
----            if(character.FaceToCamera)then
----                character.FaceToCamera(goCamera);     
----            end       
----        end
----    end
--end

--启动
function this:ApplyStart()   
    self.isStart = 1;

    self:ApplyLoadComplete();

    self:HandleCacheData();

    self:ApplyNext();   

    self.disableInputTime = 1;
end

--处理缓存数据
function this:HandleCacheData()
    if(not self.cacheDatas or #self.cacheDatas == 0)then
        return;
    end
--    LogError("未处理副本数据");
--    LogError(self.cacheDatas);

    if(not self.battleData)then
        self.cacheDatas = nil;
        LogError("无副本数据缓存，无法复原副本旧副本数据！将直接用新数据构造副本");
        return;
    end

    local count = #self.cacheDatas;
    for i = 1,count do
        local cacheData =self.cacheDatas[count - i + 1];
        table.insert(self.datas,1,cacheData);
    end

    table.insert(self.datas,1,{data = self.battleData,func = self.Revert});
end

--处理下一个
function this:ApplyNext()  
    if(self.isStart == nil)then
        return false;
    end
    if(self.currData)then
        return false;
    end
    if(self.isFighting)then
        return false;
    end
    
    if(#self.datas == 0)then
        --LogError("副本数据处理完毕");
        self:TryOpenFightFormationView();
        --CSAPI.DisableInput(100);
        self:SetInputState(true);
        return false;
    end
    --CSAPI.DisableInput(3000);
    self:SetInputState(false);
    self.currData = table.remove(self.datas,1);
    --LogError("应用副本数据" .. table.tostring(self.currData));
    self.currData.func(self,self.currData.data);

    return true;
end

function this:GetCurrData()
    return self.currData;
end

function this:ApplyComplete(data)
    --LogError("副本操作完成" .. table.tostring(self.currData));
    self.currData = nil;
    self:ApplyNext();
end

function this:GetCurrData()
    return self.currData;
end

--添加数据
function this:PushData(data,func)  
    self.datas = self.datas or {};
    --LogError("副本数据入列" .. table.tostring(data));
    table.insert(self.datas,{data = data,func = func});
    self:ApplyNext();
end
function this:IsBatting()
    return self.battling;
end
--初始化
function this:Init(data)
--    LogError( "进入副本系统=====================");
--    LogError( data);
    --进入副本前，释放声音资源
    if(SceneMgr and SceneMgr:IsMajorCity())then
        ReleaseMgr:ReleaseSound();
    end

    self.isInited = 1;
    self.battling = 1;
    self.battleData = data;
    self.dungeonSetting = self:GetDungeonSetting(data.nDuplicateID);
    self:CreateCharacters(data.arrChar);
    self:HideNewMonsters();


    self:ApplyLoadComplete();

    if(self:NeedShowThunderWarning())then
        self.needApplyComplete = 1;
    else
        self:ApplyComplete();    
    end
    

    self:TryPlayBGM();

    self.bIsNewWave = data.bIsNewWave and not self.isReverted;

    if(self:HasPlot() or self:NeedShowExplore())then
        self.dontAutoTriggerGuide = 1;  
    end

    self:TryPlayPlot0();
    --self:ApplyExploreAfterLoadingViewClosed();

    

    self:ShowBattleView();
        
    
    if(not self.bIsNewWave)then
        self:UpdateCtrlState(true);
    end

    --self:UpdateMistViewDis();
end


function this:ApplyExploreAfterLoadingViewClosed()
    if(self.loadingViewClosed)then  
        self:TryShowExplore()
    else
        self.tryShowExplore = 1;
    end
end

--function this:RefreshCharacterData()
--    --LogError(self.battleData);
--    if(not self.battleData)then
--        return;
--    end

--    for _,characterData in ipairs(self.battleData.arrChar)do
--        local battleCharacter = BattleCharacterMgr:GetCharacter(characterData.oid);
--        if(battleCharacter)then
--            battleCharacter.SetData(characterData);
--        end
--    end
--end

--还原
function this:Revert(data)
--    LogError( "还原副本系统=====================");
--    LogError( data);

    self.isInited = 1;
    self.battleData = data;
    self.dungeonSetting = self:GetDungeonSetting(data.nDuplicateID);
    self:CreateCharacters(data.arrChar);
    
    self:ApplyLoadComplete();
    self.isReverting = 1;
    FuncUtil:Call(self.RevertComplete,self,2000);
    --self:ApplyComplete();    

    self:TryPlayBGM();
end

function this:RevertComplete()
    if(not self.isReverting)then
        return;
    end
    self.isReverted = 1;
    self.isReverting = nil;
    FuncUtil:Call(self.ApplyComplete,self,800);
end

function this:GetDungeonSetting(id)
    self.dungeonSettings = self.dungeonSettings or {};
    if(self.dungeonSettings[id] == nil)then
        self.dungeonSettings[id] = Loader:Require ("Dungeon_" .. id);
    end

    return self.dungeonSettings[id];
end

function this:GetCurrDungeonSetting()
    return self.dungeonSetting;
end

function this:GetPropSetting(propId)
    if(not propId)then
        LogError("获取副本道具数据失败！！" .. tostring(propId));
        return;
    end

    local dungeonSetting = self:GetCurrDungeonSetting();
    if(dungeonSetting and dungeonSetting.props)then
        return dungeonSetting.props[propId];
    end
end

--获取副本落雷数据
function this:GetThunderData()
    local dungeonSetting = self:GetCurrDungeonSetting();
    if(dungeonSetting and dungeonSetting.props)then
        for _,propData in ipairs(dungeonSetting.props)do
            if(propData.type == ePropType.WarmingThunderA)then
                return propData;
            end
        end
    end
end


function this:ShowThunderWarning(completeCallBack)
    self:UpdateInputState("ThunderWarning",true); 

    self.thunderCompleteCallBack = completeCallBack;
    local thunderData = self:GetThunderData();
    if(not thunderData)then
        self:ShowThunderCompleteCallBack();
        return;
    end

    local ranges = thunderData.ranges;
    local delay = 0;
    local spaceTime = 2000;
    for i,rangeId in ipairs(ranges)do
        delay = (i - 1) * spaceTime;
        FuncUtil:Call(self.CreateGridEffsInRange,self,delay,rangeId,"dungeon_warning_thunder");
    end
    FuncUtil:Call(self.ShowThunderCompleteCallBack,self,delay + spaceTime + 100);
end

function this:ShowThunderCompleteCallBack()
  self:UpdateInputState("ThunderWarning"); 

   local callBack = self.thunderCompleteCallBack;
   self.thunderCompleteCallBack = nil;
   if(callBack)then
        callBack(self);
   end

   if(self.needApplyComplete)then
        self.needApplyComplete = nil;
        self:ApplyComplete();
   end   
end

--显示落雷范围预警
function this:CreateGridEffsInRange(rangeId,effName)
    local gridIds = self:GetGridGroup(rangeId);

    self:CreateGridEffs(gridIds,effName);
end

function this:CreateGridEffs(gridIds,effName)

    if(not gridIds)then
        return;
    end
    for _,gridId in ipairs(gridIds)do
        self:CreateEff(effName,gridId)
    end
end

function this:GetGridGroup(groupId)
    local dungeonSetting = self:GetCurrDungeonSetting();
    if(dungeonSetting and dungeonSetting.groups)then
        return dungeonSetting.groups[groupId];
    end
end

function this:RefreshData(data)
    if(self.isStart)then
        local newMonsterType = self:NewMonsterType(data.arrChar);
        CSAPI.OpenView("BattleExplore",newMonsterType,BattleEnterType.Next);
        self:CreateCharacters(data.arrChar);
        self:HideNewMonsters();
    end

    self.isRefreshing = 1;
    FuncUtil:Call(self.RefreshComplete,self,3000);
end

function this:RefreshComplete()
    if(not self.isRefreshing)then
        return;
    end

    self.isRefreshing = nil;

    FuncUtil:Call(self.ApplyComplete,self,500);
end

function this:ShowBattleView()
    EventMgr.Dispatch(EventType.Battle_View_Show_Changed,true);
end

function this:TriggerGuide()   
    
    local cfgScene = SceneMgr:GetCurrScene();    
    if(not cfgScene or cfgScene.key ~= "Battle")then
        return;
    end
   
    if(self.loadingComplete)then    
        if(GuideMgr:HasGuide("Battle"))then
            FuncUtil:Call(self.EnableGuideInputState,self,3000);        
        else
            self:EnableGuideInputState();
        end
        --LogError("引导")
        EventMgr.Dispatch(EventType.Guide_Trigger,"Battle");               
    end
end

function this:EnableGuideInputState()
    self:UpdateInputState("guide");
end

function this:OnPlayPlot0Complete()  
    self:ApplyExploreAfterLoadingViewClosed();
    self:UpdateInputState("plot0");    
end
function this:OnPlayPlotComplete()
    self:UpdateCtrlState(true);
    self:ShowBattleView();
    self:TriggerGuide();    

    self:UpdateInputState("plot");    
end

--更新角色
function this:UpdateCharacter(data)
    -- LogError("更新战棋角色数据==============");
    -- LogError(data);

    if(not self.ground or IsNil(self.ground.gameObject))then
        return;
    end

    local character = BattleCharacterMgr:GetCharacter(data.oid);
    if(character)then
        character.UpdateData(data);      
        if(self:IsBatting())then 
            if((character.GetType() == eDungeonCharType.MyCard or character.GetType() == eDungeonCharType.MonsterGroup) and character.IsDead())then
                FuncUtil:Call(self.ApplyComplete,self,2000);
                return;
            end
        end
    else        
        local characterParentGo = self:GetCharacterParentGO();
        BattleCharacterMgr:ApplyCreate(data,characterParentGo);   

        self:RefreshCharacterMoveRange();
    end

    self:ApplyComplete();
end

--刷新当前控制的角色可行动范围
function this:RefreshCharacterMoveRange()
    local character = self:GetCtrlCharacter();
    if(character)then
        if(character.IsFighting() or character.IsDead())then
            self:ShowCharacterMoveRange();
        else           
            self:ShowCharacterMoveRange(character);
        end
    end         
end

function this:Encounter(data)    
    self.autoCheckGridId = nil;
    --LogError("Encounter!set to nil");
    self.encounterData = data;
    self:UpdateCharacter(data);
    CSAPI.OpenView("Prompt", {content = "1075" ,okCallBack=function()        
		BattleMgr:ConfirmEncounter();
	end});

    self:ApplyComplete();
end
function this:ConfirmEncounter()
    if(self.encounterData)then
        self:TryOpenFightFormationView();
    end
end

function this:UpdateCharBuff(data)
--    LogError("更新角色冰冻buff");
--    LogError(data);
    local character = BattleCharacterMgr:GetCharacter(data.oid);
    if(character)then
        character.UpdateBuffData(data.buffData);
    end     
    
    self:ApplyComplete();   
end

function this:UseProp(data)
--    LogError("使用道具");
--    LogError(data);

    local prop = BattleCharacterMgr:GetCharacter(data.nPropOid);

    if(prop)then        
        prop.ApplyUse(data,self.UsePropComplete,self);      
    else      
        self:ApplyComplete();
    end    
end

function this:UsePropComplete()
    self:ApplyComplete();
end

function this:SetFightCheck(gridId)
    self.autoCheckGridId = gridId;
    --LogError("set!" .. tostring(gridId));
end

function this:DungeonOver(data)
--    LogError("副本结算");
--    LogError(data);

    if data.bIsWin==true then
        DungeonMgr:SetDungeonOver(data);
        CSAPI.OpenView("DungeonPassView");
        self:ApplyComplete();
    else
        FuncUtil:Call(self.DelayShowDungeonOver,self,3000,data);
    end
--    DungeonMgr:SetDungeonOver(data);
--    CSAPI.OpenView("FightLost", data);
--    self:ApplyComplete();
end

function this:DelayShowDungeonOver(data)
    DungeonMgr:SetDungeonOver(data);
    FightOverTool.OnBattleViewLost();
    -- local teamData = TeamMgr:GetFightTeamData(DungeonMgr:GetFightTeamId());
    -- CSAPI.OpenView("FightOverResult", {bIsWin=false,sceneType=SceneType.PVE,team=teamData});
    self:ApplyComplete();
end

function this:SetMoveState(proto)
    self:SetStepNum(proto.nStep);
    EventMgr.Dispatch(EventType.Battle_Character_Move,{
        type=DungeonStarType.MoveNum,
        num=self:GetStepNum(),
    });
    self:UpdateCtrlState(proto.nIsCanMove);
    self:ApplyComplete();
end

--更新控制状态
function this:UpdateCtrlState(state,noEff)
    self.ctrlState = state;
   
    if(self.ctrlState)then
        local defaultCtrlId = self:GetDefaultCtrlId();
        self:SetMoveCtrlTarget(defaultCtrlId,noEff);
    else
        self:SetMoveCtrlTarget(nil);
    end    
end

function this:GetDefaultCtrlId()
   local defaultCtrlId = nil;

   local lastCtrlCharacter = self.lastCtrlId and BattleCharacterMgr:GetCharacter(self.lastCtrlId);
    if(lastCtrlCharacter and not lastCtrlCharacter.IsDead())then
        defaultCtrlId = self.lastCtrlId;
    end

    if(defaultCtrlId == nil)then
        local allCharacters = BattleCharacterMgr:GetAll();
        if(allCharacters)then
            for id,character in pairs(allCharacters)do
                if(character.GetType() == eDungeonCharType.MyCard and not character.IsDead())then
                    defaultCtrlId = id;
                    break;
                end
            end
        end
    end
    return defaultCtrlId;
end

--获取控制状态
function this:GetCtrlState()
    return self.ctrlState;
end

--移动角色
function this:AskMoveTo(data)
--    LogError("执行移动==========");
--    LogError( data);
    if(not self:GetAIMoveState())then
        CSAPI.DisableInput(3000);
    end
    local character = BattleCharacterMgr:GetCharacter(data.oid);
    
    if(character == nil)then
        LogError("移动战棋目标失败！！！找不到目标");
        LogError(data);
        self:ApplyComplete();  
        return;
    end
    if(data.state)then
        character.UpdateState(data.state);
    end
    self.moveData = data;

    self:SetMoveCtrlTarget(nil);
    self.ground.ApplyMove(character,data.pos,data.specialMove);
    self:SetFollow(character.gameObject);
    --玩家移动
    -- local cData=character.GetData();

    if(character and character.GetType() == eDungeonCharType.MonsterGroup)then
        self:UpdateActionTurn(false);
    end
end

--应答破坏道具
function this:AskDestroyProp(data)
    local prop = BattleCharacterMgr:GetCharacter(data.desID);
    if(prop)then
        prop.Remove();
        self:RefreshCharacterMoveRange();
    end

    self:ApplyComplete();  
end
--应答推动道具
function this:AskPushBox(data)
    local character = BattleCharacterMgr:GetCharacter(data.oid);
    local prop = BattleCharacterMgr:GetCharacter(data.desID);


    local characterGrid = character.GetCurrGrid();
    local characterGridId = characterGrid.GetID();
    local propGrid = prop.GetCurrGrid();
    local propGridId = propGrid.GetID();

    local xDir = propGrid.x - characterGrid.x;
    local yDir = propGrid.y - characterGrid.y;

    local propMoveTargetGrid = propGrid.GetNearGrid(xDir,yDir);   

    prop.MoveTo(propMoveTargetGrid.GetID(),{propGrid.gameObject,propMoveTargetGrid.gameObject});
    character.MoveTo(propGrid.GetID(),{characterGrid.gameObject,propGrid.gameObject},self.OnPushComplete,self);
end
function this:OnPushComplete()
    self:RefreshCharacterMoveRange();
    self:ApplyComplete();  
end

--获取波数
function this:GetMonsterWave()
    local data = self.battleData;
    return data and data.nWave;
end

--获取格子（新）
function this:GetGrid(gridId)
    local grid = self.ground and self.ground.GetGrid(gridId);
--    if(not grid)then
--        LogError("不存在格子对象！！" .. tostring(gridId));
--    end

    return grid;
end
function this:GetGridByGO(go)
    return self.ground and self.ground.GetGridByGO(go);
end
--获取层级
function this:GetMapGridHeight(gridId)
    local grid = self:GetGrid(gridId);
    if(grid == nil)then
        return 0;
        --LogError("无法将战棋目标设置到格子" .. gridId);
    end
        
    return grid.Height();
end


function this:MoveComplete()
    CSAPI.DisableInput(50);

    --LogError(self.currData);
    local moveData = self.moveData; 
    self.moveData = nil;
--    LogError("移动完成==========");
--    LogError(moveData);

    if(moveData == nil)then
        return;
    end

    --相遇打开战斗界面   
    self:PlayerMoveTryTriggerProp(moveData);
    --local triggerFight = self:TryOpenFightFormationView();     
    --if(not triggerFight)then        
--        local allCharacters = BattleCharacterMgr:GetAll();       
--        if(allCharacters)then           
--            for tmpId,tmpCharacter in pairs(allCharacters)do
--                local gridId = tmpCharacter.GetCurrGridId();
--            end
--        end
    
        self:UpdateCtrlState(self.ctrlState,true);
    --end

    if(not self.autoCheckGridId or moveData.state == eDungeonCharState.Fighting)then
        local isLastFight = self:CheckFightOnGrid(self.autoCheckGridId);
        if(self.autoCheckGridId)then
            isLastFight = self:CheckFightOnGrid(self.autoCheckGridId);
        end

        if(not isLastFight)then
            self.autoCheckGridId = moveData.pos;
        end   
    end
    
    self:ApplyComplete();
end

--玩家移动结束后，尝试触发道具表现
function this:PlayerMoveTryTriggerProp(moveData)
    if(not moveData)then
        return;
    end
    local character = BattleCharacterMgr:GetCharacter(moveData.oid);
    if(character and character.GetType() == eDungeonCharType.MyCard)then
        local allCharacters = BattleCharacterMgr:GetAll();       
        if(allCharacters)then           
            for tmpId,tmpCharacter in pairs(allCharacters)do
                local gridId = tmpCharacter.GetCurrGridId();
                if(gridId == moveData.pos and tmpCharacter.GetType() == eDungeonCharType.Prop)then
                    local lua = tmpCharacter.GetLuaRes();
                    if(lua and lua.TriggerProp)then
                        lua.TriggerProp();
                    end
                end
            end
        end
    end
end


function this:CheckFightOnGrid(targetGridId)
    local allCharacters = BattleCharacterMgr:GetAll();
    if(allCharacters)then
        for _,tmpCharacter in pairs(allCharacters)do
            local gridId = tmpCharacter.GetCurrGridId();

            if(gridId == targetGridId)then
                if(tmpCharacter.IsFighting())then
                    return true;
                end            
            end
        end
    end
end

--尝试打开战斗准备界面
function this:TryOpenFightFormationView()
    --LogError("检测战斗1");
    if(self.applyFightTime and CSAPI.GetTime() < self.applyFightTime + 5)then
        return;
    end
    --LogError("检测战斗2");
    local gridCharacterDic = {};

    local attackCharacter = nil;    
    local targetMonster = nil;
    local allCharacters = BattleCharacterMgr:GetAll();
    if(allCharacters)then
        for _,tmpCharacter in pairs(allCharacters)do         
            if(not tmpCharacter.IsDead() )then       
                if(tmpCharacter.GetType() == eDungeonCharType.MyCard or tmpCharacter.GetType() == eDungeonCharType.MonsterGroup)then
                    fightingGridId = tmpCharacter.GetCurrGridId();
                    --LogError(tmpCharacter.GetId() .. ":" .. tostring(fightingGridId));
                    if(gridCharacterDic[fightingGridId])then
                        local gridCharacter = gridCharacterDic[fightingGridId];
                        if(tmpCharacter.GetType() == eDungeonCharType.MyCard)then
                            attackCharacter = tmpCharacter; 
                            targetMonster = gridCharacter;                   
                        elseif(tmpCharacter.GetType() == eDungeonCharType.MonsterGroup)then
                            attackCharacter = gridCharacter; 
                            targetMonster = tmpCharacter;
                        end
                    else
                        gridCharacterDic[fightingGridId] = tmpCharacter;
                    end
                end
            end
        end
    end
   
    if((attackCharacter and attackCharacter.IsFighting()) or (targetMonster and targetMonster.IsFighting()))then       

        if(attackCharacter)then
            attackCharacter.UpdateState(eDungeonCharState.Fighting);
            attackCharacter.UpdateFightShow();
        else
            --触发战斗时，角色被机关打死
            --LogError("触发战斗，目标位置找不到玩家单位，无法进入战斗！！！格子id：" .. tostring(targetGridId));
            self:UpdateCtrlState(self.ctrlState);
            return false;
        end
        if(targetMonster)then
            targetMonster.UpdateState(eDungeonCharState.Fighting);
            targetMonster.UpdateFightShow();
        else
            --遭遇战
            --LogError("触发战斗，目标位置找不到敌人单位，无法进入战斗！！！格子id：" .. tostring(targetGridId));
            return false;
        end
        
        EventMgr.Dispatch(EventType.RewardPanel_Post_Close);
        EventMgr.Dispatch(EventType.Battle_Lock_Click);	
        self.autoCheckGridId = nil;
           
        --直接进入战斗
        FightClient:Clean();
		fightTeamInfo = attackCharacter.GetData();
        local teamData = TeamMgr:GetFightTeamData(fightTeamInfo.nTeamID);
        DungeonMgr:SetFightMonsterGroup(targetMonster.GetCfg());--设置战斗中的怪物组配置数据

        self:SendToFight(attackCharacter,targetMonster);
        DungeonMgr:ClearDragList();	

        self:UpdateInputState("fight",true);    
        self.applyFightTime = CSAPI.GetTime();    
            
        self.isFighting = 1;      
        DungeonMgr:QueryDungeonData();--刷新副本数据
        --LogError("进入战斗");
        return true;
    end
--    LogError("无战斗发生===================");
--    LogError("attackCharacter:" .. (attackCharacter and 1 or 0));
--    if(attackCharacter)then
--        LogError("attackCharacter fight:" .. (attackCharacter.IsFighting() and 1 or 0));
--    end
--    LogError("targetMonster:" .. (targetMonster and 1 or 0));
--    if(targetMonster)then
--        LogError("targetMonster fight:" .. (targetMonster.IsFighting() and 1 or 0));
--    end
    
end

function this:SendToFight(attackCharacter,targetMonster)
    --LogError("进入战斗");

    local delayEnterTime = 300;
    if(targetMonster.IsInviside())then
        delayEnterTime = targetMonster.PlayFightAction();
        if(delayEnterTime)then
           delayEnterTime = delayEnterTime + 500;
        else
           delayEnterTime = 300;
        end
    end
    local index = BattleMgr:GetDungeonIndex();
    local proto = {index = index, myOID = attackCharacter.GetId(), monsterOID =  targetMonster.GetId()};	
    
    self:SetFollow(attackCharacter.gameObject);
    self:PlayerEnterFight(delayEnterTime);
    FuncUtil:Call(FightProto.EnterFight, FightProto, delayEnterTime + 100, proto);	

    self.triggerFight = 1;
end

--创建一组角色
function this:CreateCharacters(datas)
    if(datas == nil)then
        return;
    end
    local characterParentGo = self:GetCharacterParentGO();

    for i,data in ipairs(datas)do        
        local character = BattleCharacterMgr:ApplyCreate(data,characterParentGo);       
        if(character and character.GetType() == eDungeonCharType.MyCard)then
            if(not character.GetTeamNO())then
                character.SetTeamNO(i);
            end
        end
    end 
end

function this:GetCharacterParentGO()
    return self.ground.GetCharacterParentGO();
end


function this:UpdateActionTurn(isPlayerAction)

    if(isPlayerAction ~= nil and self:IsCloseInput())then
        return;
    end

    if(self.isPlayerAction == isPlayerAction)then
        return;
    end
    self.isPlayerAction = isPlayerAction;

    if(isPlayerAction ~= nil)then
        EventMgr.Dispatch(EventType.Battle_Turn_Changed,isPlayerAction);    
        --LogError(isPlayerAction and "玩家行动回合" or "敌方行动");
    end
    
end

--设置移动控制目标
function this:SetMoveCtrlTarget(id,noEff)
    --LogError("设置移动目标" .. tostring(id));

    if(id and self:GetAIMoveState())then
        if(not self.isFighting)then
            --LogError("FuncUtil:Call(self.ApplyAICtrl,self,500)");
            FuncUtil:Call(self.ApplyAICtrl,self,500);         
        end
    end

    if(id and self.moveCtrlTargetId == id)then
        return;
    end

    if(id)then
        local lastCharacter = self:GetCtrlCharacter();
        if(lastCharacter)then
            lastCharacter.SetSelectState(false);
        end
    end
    
    self.moveCtrlTargetId = id;

    if(not self.loadingComplete)then
        return;
    end

    if(id)then
        
        local character = self:GetCtrlCharacter();
        if character==nil or character.IsDead() then
            local allCharacters = BattleCharacterMgr:GetAll();
            --获取当前我方队员信息
            if(allCharacters)then
                for _,tmpCharacter in pairs(allCharacters)do
                    if(tmpCharacter.data.type==eDungeonCharType.MyCard and id~=tmpCharacter.GetId() and tmpCharacter.IsDead()==false)then                
                        character=tmpCharacter;
                    end
                end
            end
        end
        if(character)then
            character.SetSelectState(true);
            self:SetFollow(character.gameObject);
            if(character.IsFighting())then
                self:ShowCharacterMoveRange();
            else
                self:ShowCharacterMoveRange(character);
                --CSAPI.DisableInput(1000);
            end
            if(not noEff)then
            self:CreateEff("Grid_VFX_2Op_Indicator_Teammate",character.GetCurrGridId());
            end
        end
        EventMgr.Dispatch(EventType.Battle_Character_Ctrl_Changed,character);    
        
        --记录上一个有效的控制目标ID
        self.lastCtrlId = id;   

        self:UpdateActionTurn(true);
    end

    self:UpdateCharactersMistState();
end

function this:SetFollow(go)
    if(not self.ground)then
        return;
    end
    --已触发战斗不可改变追随目标
    if(self.triggerFight)then
        return;
    end
    self.ground.SetFollow(go);
end

--显示角色移动范围
function this:ShowCharacterMoveRange(character)
    if(not self.ground)then
        return;
    end
    self.ground.SetLightRange(character);   
end

--获取控制的角色
function this:GetCtrlCharacter()
    if(self.moveCtrlTargetId == nil)then
        return;
    end

    local  character = BattleCharacterMgr:GetCharacter(self.moveCtrlTargetId);
    return character;
end
function this:ApplyTransfer(oid,posId,targetId,isTranferState,callBack,caller,transferProp)
    self:ShowCharacterMoveRange();
    self:SetMoveCtrlTarget(nil);

    local character = BattleCharacterMgr:GetCharacter(oid);
    self.ground.ApplyTransfer(character,posId,targetId,isTranferState,callBack,caller,transferProp);
end
--提交移动
function this:ApplyMove(targetGridId,character,force)    
    character = character or self:GetCtrlCharacter();
    local id = character.GetId();
    if(character == nil)then
        LogError("申请移动战棋目标失败！！！找不到目标");
        LogError(id);

        return;
    end
    local startId = character.GetCurrGridId();
    if(startId == nil)then
        LogError("无法移动战棋目标，目标不在棋盘中" .. id);
    end

    if(self:ExistMonster(startId))then
        --与怪物战斗中，不可移动
        return;
    end
    if(self:TryHandleProp(targetGridId))then
        --处理目标格子上的特殊道具（破坏、推动）
        return;
    end    

    local path = self:FindPathIDs(character,targetGridId);
    if(path == null)then
        --LogError("不存在路径");
        return;
    end
    
    --限制连续发送
    local sendTime = CSAPI.GetTime();
    --LogError("self.lastSendTime：" .. tostring(self.lastSendTime) .."，self.sendTime：" .. tostring(sendTime));
    local isSend = not self.lastSendTime or sendTime > self.lastSendTime + 1;
    if(not isSend and not force)then
        return;
    end
    self.lastSendTime = sendTime;
    
    local index = self:GetDungeonIndex();
    local data = {index = index,oid = id,path = path};
    --Log("申请移动角色========================================");
    --Log(data);
    FightProto:MoveTo(data);

end

--目标位置是否存在怪物
function this:ExistMonster(targetGridId)
    local monster = self:GetUnitOnGrid(targetGridId,eDungeonCharType.MonsterGroup);
    if(monster)then
        return true;
    end
    return false;
end
--处理目标格子上的道具
function this:TryHandleProp(targetGridId)
    local gridProp = self:GetUnitOnGrid(targetGridId,eDungeonCharType.Prop);
    if(gridProp)then

        local data = {index = self:GetDungeonIndex(),oid = self.moveCtrlTargetId,desID = gridProp.GetId()};

        if(gridProp.IsCanDestroy())then--可破坏的道具           
            Log( "申请破坏道具========================================");
            Log( data);
            FightProto:DestroyProp(data);            

            return true;
        elseif(gridProp.IsCanPush())then--可推动的道具
            Log( "申请推动道具========================================");
            Log( data);
            FightProto:PushBox(data);            

            return true;
        end
    end
    return false;
end

--获取目标格子上的单位列表
function this:GetUnitOnGrid(targetGridId,unitType)
    local allCharacters = BattleCharacterMgr:GetAll();
    if(allCharacters)then
        for _,tmpCharacter in pairs(allCharacters)do
            local gridId = tmpCharacter.GetCurrGridId();

            if(gridId == targetGridId)then                
                if(tmpCharacter.GetType() == unitType)then
                    return tmpCharacter;
                end
            end
        end
    end
end

function this:GetPropData(propId)
    if(self.ground)then
        self.ground.GetPropData(propId);
    end
end
--获取坑洞格子
function this:GetHoleGrids()
    if(self.ground)then
        return self.ground.GetHoleGrids();
    end
end

--寻找路径（新）
function this:FindPathIDs(character,targetId,customCost,customIgnoreGridType)
    local path = self:FindPathNew(character,targetId,customCost,customIgnoreGridType);
    local pathIDs = {};

    if(path)then
        for _,grid in ipairs(path)do
            table.insert(pathIDs,grid.GetID());
        end
    end

    return pathIDs;
end

--寻找路径（新）
function this:FindPathNew(character,targetId,customCost,customIgnoreGridType)
    local startId = character.GetCurrGridId();
    local bans = self:GetGridBans(character);
    
--    LogError("角色" .. character.cfg.name .. "寻路到" .. tostring(targetId) .. "，飞行：" .. tostring(character.CanFly()));
--    LogError(character.cfg);
--    LogError(bans);

    local cost = customCost or character.GetMoveStep();
    local height = character.GetJumpStep();
    local ignoreWaterCost = character.IsIgonreWaterCost();
    local ignoreGridType = customIgnoreGridType or character.GetType() == eDungeonCharType.MonsterGroup;
    return self.ground.FindPath(startId,targetId,bans,cost,height,ignoreWaterCost,ignoreGridType);
end
function this:GetPath(from,to)
    return self.ground.FindPath(from,to);
end

--获取指定格子范围内给子（新）
function this:GetGridsInRange(targetId,passBans,targetBans,cost,height)
    return self.ground.GetGridsInRange(targetId,passBans,targetBans,cost,height);
end
--获取寻路时格子禁用状态
function this:GetGridBans(mainCharacter)
    local passBans = {};--不可通过格子
    local targetBans = {};--不可作为目标格子
    
    --地图单位（友军，怪物，道具）
    local characters = BattleCharacterMgr:GetAll();
    if(characters)then
        for id,character in pairs(characters)do
            if(not character.IsDead())then
                local characterType = character.GetType();
                local characterGridId = character.GetCurrGridId();
                
                local canPass = self:IsCanPass(mainCharacter,character);
                if(not canPass)then
                    passBans[characterGridId] = 1;
                end

                if(characterType == eDungeonCharType.MyCard)then
                    --不可与友军单位重叠
                    targetBans[characterGridId] = 1;
                elseif(characterType == eDungeonCharType.Prop)then              
                    
                    --不可穿过道具
                    if(character.IsBlockCharacter(mainCharacter))then
                        targetBans[characterGridId] = 1;
                    elseif(character.IsOneWay())then
                        targetBans[characterGridId] = 1;
                    end
                end
            end
        end
    end
  

     local holeGrids = self:GetHoleGrids();
    
     if(holeGrids)then
        for _,grid in ipairs(holeGrids)do
            local holeType = grid.GetHoleType();
            if(holeType == eMapGridHoleType.Deep or (holeType == eMapGridHoleType.Shallow and not grid.IsHoleActive()))then
                local gridId = grid.GetID();
                passBans[gridId] = 1;
                targetBans[gridId] = 1;
            end
        end
     end


    return passBans,targetBans;
end



--创建副本特效
function this:CreateEff(effName,gridId,callBack)
    if(not effName)then
        return;
    end

    effName = "battle/" .. effName;
    local grid = self:GetGrid(gridId);
    ResUtil:CreateEffect(effName, 0,0.5,0,grid.gameObject,callBack);

    self.aiMoveList = nil;
end




--是否可以穿过
function this:IsCanPass(character1,character2)   
    local type1 = character1.GetType();
    local type2 = character2.GetType();

    --目标隐身，显示可以通过
    if(character2.IsInviside and character2.IsInviside())then
        return true;
    end

    if(self.passArr == nil)then
        self.passArr = {};
        self.passArr[eDungeonCharType.MyCard] = {[eDungeonCharType.MyCard] = 1};
        --self.passArr[eDungeonCharType.MyCard] = {[eDungeonCharType.MyCard] = 1,[eDungeonCharType.NpcCard] = 1};
        --self.passArr[eDungeonCharType.NpcCard] = {[eDungeonCharType.MyCard] = 1,[eDungeonCharType.NpcCard] = 1};
        self.passArr[eDungeonCharType.MonsterGroup] = {[eDungeonCharType.MonsterGroup] = 1};
    end
    
    if(type2 == eDungeonCharType.Prop)then--可穿过的道具       
        if(character2.IsCanPass(character1))then
            --LogError(character2.cfg);
            if(not character2.IsBlockCharacter(character1))then            
                return true;
            end
        end
    end

    if(self.passArr[type1] and self.passArr[type1][type2])then
        return true;
    end

    return false;
end

function this:GetDungeonIndex()
    return 1;
end

--结算时需要展示的卡牌数据
function this:SetShowCardData(data)
    self.overShowCards=data;
end

--结算时需要展示的卡牌数据
function this:GetShowCardData()
    return self.overShowCards and self.overShowCards or nil;
end

--清除结算时需要展示的卡牌数据
function this:ClearShowCardData()
    self.overShowCards=nil;
end

--设置地图操作模式 
function this:SetMapState(state)
    self.dungeonMapState=state;
end

function this:GetMapState()
    return self.dungeonMapState and self.dungeonMapState or eDungeonMapState.Normal; 
end

--返回当前步数
function this:GetStepNum()
    return self.battleData and self.battleData.nStep or 0;
end

function this:SetStepNum(num)
    if self.battleData then
        self.battleData.nStep=num;
    end
end

--返回宝箱数量
function this:GetBoxNum()
    return self.battleData and self.battleData.nBox or 0;
end

--返回击杀怪物数量
function this:GetKillCount()
    return self.battleData and self.battleData.nKillCount or 0;
end

--返回结束时间
function this:GetEndTime()
    local time=0;
    if self.battleData and self.battleData.nEndTime and self.battleData.nEndTime>0 then
        time=self.battleData.nEndTime-TimeUtil:GetTime();
    end
    return time;
end

--获取队伍数量
function this:GetTeamCount()
    local count = 0;
    if(self.battleData)then
        for _,charData in ipairs(self.battleData.arrChar)do
            if(charData.type == eDungeonCharType.MyCard and charData.state ~= eDungeonCharState.Death)then
                count = count + 1;
            end
        end
    end
    return count;
end

--返回己方队伍的角色数据 死亡的队伍不会返回
function this:GetMineTeams()
    local teams=nil;
    if(self.battleData)then
        for _,charData in ipairs(self.battleData.arrChar)do
            if(charData.type == eDungeonCharType.MyCard and charData.state ~= eDungeonCharState.Death)then
                teams=teams or {}
                table.insert(teams,charData)
            end
        end
    end
    return teams;
end

function this:SetBattleData(battleData)
    self.battleData = battleData;

--    LogError("当前副本数据");
--    LogError(battleData);
end
function this:GetBattleData()
    return self.battleData;
end

function this:Clear()
    self.clearFlag = 1;
end

function this:CheckClickGridTime()
    self.clickGridTime = self.clickGridTime or 0;

    local currTime = CSAPI.GetTime();
    local isCheck = math.abs(currTime - self.clickGridTime) >= 0.1;

    if(isCheck)then
        self.clickGridTime = currTime;
    end
    --LogError(tostring(isCheck));
    return isCheck;
end

function this:SetFightAuto(state,startId)
    _G.Fight_Auto = state;
    _G.Fight_Auto_Target = startId;
    if(state)then
        self:SetAIMoveState(true);
    end

    self:ApplyFightAuto();
end

function this:ApplyFightAuto()
    if(_G.Fight_Auto)then
        if(not _G.Fight_Auto_Target)then
            _G.Fight_Auto_Target = 1001;
        end
        local targetDungeonId = _G.Fight_Auto_Target;
        _G.Fight_Auto_Target = nil;
        local cfgs = Cfgs.MainLine:GetAll();
        for _,cfg in pairs(cfgs)do
            if((cfg.type == 1 or cfg.type == 2) and cfg.id > targetDungeonId and cfg.group <= 2)then   
                if(not _G.Fight_Auto_Target or cfg.id < _G.Fight_Auto_Target)then             
                    _G.Fight_Auto_Target = cfg.id;               
                end
            end
        end

        DungeonMgr:ApplyEnterByDefault(targetDungeonId);
    end
end


function this:SetAIMoveState(aiMoveState)
    local isPass = self:IsCurrDungeonPass();
    if(not isPass and aiMoveState)then
        Tips.ShowTips("通关后生效");
    end

--    FightClient:SetAutoFight(aiMoveState);
    if(aiMoveState)then
        FightClient:SetAutoFight(aiMoveState);
    end

    self.aiMoveState = aiMoveState;    
    self:ApplyAICtrl(0,true);
end
function this:GetAIMoveState()
    local isPass = self:IsCurrDungeonPass();
    return isPass and self.aiMoveState;
end

function this:IsCurrDungeonPass()
    local currId = DungeonMgr:GetCurrId();
    local isPass = DungeonMgr:CheckDungeonPass(currId);
    return isPass;
end

function this:ApplyAICtrl(delay,force)
    if(not self:GetAIMoveState())then
        return;
    end
    --限制连续发送
    local aiCtrlTime = CSAPI.GetTime();
    local isCtrl = not self.aiCtrlTime or aiCtrlTime > self.aiCtrlTime + 0.5;    
    --LogError("self.aiCtrlTime:" .. tostring(self.aiCtrlTime) .. "，aiCtrlTime:" .. tostring(aiCtrlTime));
    if(isCtrl or force)then       
        if(not force)then
            self.aiCtrlTime = aiCtrlTime;
        end
        FuncUtil:Call(self.ApplyAIMove,self,delay or 1000);
    end
end

--AI移动
function this:ApplyAIMove()    
    if(self.datas and #self.datas > 0)then       
        return;
    end
    local ctrlCharacter = self:GetCtrlCharacter();
    if(not ctrlCharacter or ctrlCharacter.IsFighting())then
        return;
    end  
    if(self.isFighting)then
        return;       
    end
    --LogError("AI 行动");
    --AI策略设置
    local bossFirst = false;--优先boss
    local t1Setting,t2Setting;
    local naviData = DungeonMgr:LoadNaviConfig();
    if(naviData)then
        t1Setting = naviData[FightNaviObjType.Team1];
        t2Setting = naviData[FightNaviObjType.Team2];     
        local attackSetting = naviData[FightNaviObjType.Attack];   
        if(attackSetting)then
            bossFirst = attackSetting[1] ~= 1; 
        end
    end
--    LogError(t1Setting);
--    LogError(t2Setting);

    local t1Character,t1PathProp,t1PathMonster,t1PathBoss,t1PathTrigger;
    local t2Character,t2PathProp,t2PathMonster,t2PathBoss,t2PathTrigger;

    local characters = BattleCharacterMgr:GetAll();
    if(characters)then
        local teamCount = 0;
        for id,character in pairs(characters)do
            if(character.GetType() == eDungeonCharType.MyCard and not character.IsDead())then 
                teamCount = teamCount + 1;
            end
        end

        for id,character in pairs(characters)do
            if(character.GetType() == eDungeonCharType.MyCard)then                
                local propPath,monsterPath,bossPath,triggerPath = self:TargetAIMove(character);
               
                if(character.GetTeamNO() == 2)then
                    t2Character = character;
                    t2PathProp,t2PathMonster,t2PathBoss,t2PathTrigger = propPath,monsterPath,bossPath,triggerPath;
                    if(t2Setting and teamCount >= 2)then
                        local value = t2Setting[1];
                        if(value == 1)then--打小怪
                            t2PathBoss = nil;
                        elseif(value == 2)then--打Boss
                            t2PathMonster = nil;
                        elseif(value == 4)then--发呆
                            t2PathMonster = nil;
                            t2PathBoss = nil;
                        end
                    end
                else
                    t1Character = character;
                    t1PathProp,t1PathMonster,t1PathBoss,t1PathTrigger = propPath,monsterPath,bossPath,triggerPath;
                    if(t1Setting and teamCount >= 2)then
                        local value = t1Setting[1];
                        if(value == 1)then--打小怪
                            t1PathBoss = nil;
                        elseif(value == 2)then--打Boss
                            t1PathMonster = nil;
                        elseif(value == 4)then--发呆
                            t1PathMonster = nil;
                            t1PathBoss = nil;
                        end
                    end                    
                end
            end
        end
    end

    --先去宝箱、增益道具
    if(t1PathProp or t2PathProp)then
        if(t1PathProp and t2PathProp)then
            if(#t1PathProp <= #t2PathProp)then
                self:ApplyCharacterMoveTo(t1Character,t1PathProp);
            else
                self:ApplyCharacterMoveTo(t2Character,t2PathProp);
            end
        elseif(t1PathProp)then
            self:ApplyCharacterMoveTo(t1Character,t1PathProp);
        else
            self:ApplyCharacterMoveTo(t2Character,t2PathProp);
        end
        return;
    end

    
    if((bossFirst or (not t1PathMonster and not t2PathMonster)) and (t1PathBoss or t2PathBoss))then        
        if(t1PathBoss)then
            self:ApplyCharacterMoveTo(t1Character,t1PathBoss);
            return;
        elseif(t2PathBoss)then
            self:ApplyCharacterMoveTo(t2Character,t2PathBoss);
            return;
        end
    else
        if(t1PathMonster)then
            self:ApplyCharacterMoveTo(t1Character,t1PathMonster);
            return;
        elseif(t2PathMonster)then
            self:ApplyCharacterMoveTo(t2Character,t2PathMonster);
            return;
        end
    end

    if(t1PathTrigger)then
        self:ApplyCharacterMoveTo(t1Character,t1PathTrigger);
        return;
    end
    if(t2PathTrigger)then
        self:ApplyCharacterMoveTo(t1Character,t2PathTrigger);
        return;
    end

    CSAPI.OpenView("Prompt", {content = LanguageMgr:GetTips(8005), okCallBack = function()            
    end})  
    EventMgr.Dispatch(EventType.Battle_AIMove_UI_Update, false) --更新AI寻路UI
end

function this:AIGetPropState()
    local getBox = true;--获取宝箱
    local getUsefull = true;--获取增益道具
    

    local naviData = DungeonMgr:LoadNaviConfig();

    if(naviData)then
        local getSetting = naviData[FightNaviObjType.Get];    
        getBox = false;
        getUsefull = false;

        --获取策略
        if(getSetting)then  
            for _,v in ipairs(getSetting)do
                if(v == 1)then
                    getBox = true;
                end
                if(v == 2)then
                    getUsefull = true;
                end              
            end            
        end        
    end

    return getBox,getUsefull;
end

function this:TargetAIMove(ctrlCharacter)
    ctrlCharacter = ctrlCharacter or self:GetCtrlCharacter();
    if(not ctrlCharacter)then
        return;
    end
    local gridId = ctrlCharacter.GetCurrGridId();

    local targetPath = nil;

    local propPath = nil;
    local monsterPath = nil;
    local bossPath = nil;
    local triggerPath = nil;

    local getBox,getUsefull = self:AIGetPropState();

--    local getBox = true;--获取宝箱
--    local getUsefull = true;--获取增益道具    

--    local naviData = DungeonMgr:LoadNaviConfig();

--    if(naviData)then
--        local getSetting = naviData[FightNaviObjType.Get];    
--        getBox = false;
--        getUsefull = false;

--        --获取策略
--        if(getSetting)then  
--            for _,v in ipairs(getSetting)do
--                if(v == 1)then
--                    getBox = true;
--                end
--                if(v == 2)then
--                    getUsefull = true;
--                end              
--            end            
--        end
--    end

    local characters = BattleCharacterMgr:GetAll();
    if(characters)then        
        for id,character in pairs(characters)do
            local characterType = character.GetType();

            if(characterType == eDungeonCharType.MonsterGroup or 
            (characterType == eDungeonCharType.Prop and ((getUsefull and character.IsUsefull()) or (getBox and character.IsBox()) or  character.IsTrigger())  ))then  
                local characterGridId = character.GetCurrGridId();              
                --local path = self:FindPathIDs(ctrlCharacter,characterGridId,1000);               
                local path = self:GetPath_new(ctrlCharacter, characterGridId);                
                --LogError("目标位置：" .. tostring(characterGridId) .. "，寻得路径：\n" .. table.tostring(path));
                if(path and #path > 0)then
                    if(characterType == eDungeonCharType.Prop)then
                        if(character.IsTrigger())then
                            triggerPath = path;
                            --LogError(path);
                        elseif(not propPath or #propPath > #path)then
                            propPath = path;
                        end  
                    elseif(character.IsBoss())then
                        bossPath = path;
                    else
                        if(not monsterPath or #monsterPath > #path)then
                            monsterPath = path;
                        end  
                    end                                 
                end
            end
        end
    end    

    if(bossFirst)then
        targetPath = propPath or bossPath or monsterPath;
    else
        targetPath = propPath or monsterPath or bossPath;
    end

    return propPath,monsterPath,bossPath,triggerPath;

--    if(targetPath)then      
--        if(self:ApplyCharacterMoveTo(ctrlCharacter,targetPath))then
--            return;
--        end
--    else
--        CSAPI.OpenView("Prompt", {content = LanguageMgr:GetTips(8005), okCallBack = function()            
--        end})
--        EventMgr.Dispatch(Battle_AIMove_UI_Update, false) --更新AI寻路UI
--        if(true)then
--            return;
--        end        
--    end
    

end

function this:ApplyCharacterMoveTo(ctrlCharacter,targetPath)

    if(not ctrlCharacter)then
        return;
    end
    if(ctrlCharacter.GetId() ~= self.moveCtrlTargetId)then
        self:SetMoveCtrlTarget(ctrlCharacter.GetId());
    end


    if(targetPath)then
        local cost = ctrlCharacter.GetMoveStep();  
        local targetGridId = nil;
        for i,gridId in ipairs(targetPath)do
            if(i > 1)then
                local targetGrid = self:GetGrid(gridId);
                if(targetGrid:IsCanPass())then
                    targetGridId = gridId;
                    cost = cost - 1;
                    if(cost == 0)then
                        break;
                    end
                else
                    targetGridId = gridId;
                    break;
                end
            end
        end
        
        --LogError("AI寻得路径：\n" .. table.tostring(targetPath) .. "\n下一个目标：" .. tostring(targetGridId)); 

        local moveTargetGridId = targetGridId;--targetPath[index];


        if(moveTargetGridId)then
            --LogError("moveTargetGridId:" .. moveTargetGridId);
            self:ApplyMove(moveTargetGridId,ctrlCharacter,true);
            return true;
        end
    end
end


function this:RecordAIMove(gridId)
    self.aiMoveList = self.aiMoveList or {};

    local count = 0;
    for k,v in pairs (self.aiMoveList)do
        count = count + 1;
        if(count > 2)then
            self.aiMoveList = {};
        end
    end
    self.aiMoveList[gridId] = 1;
end


function this:GetAITargetGrid(ctrlCharacter)
    if(not ctrlCharacter)then
        return;
    end

   local list = self.ground.GetLightRange(ctrlCharacter);
   if(list)then
      for gridId,_ in pairs(list)do
         local path = self:GetNearestTargetPath(ctrlCharacter,gridId);
      end
   end
end

--获取角色在指定位置最近目标
function this:GetNearestTargetPath(ctrlCharacter,startId)
    
    local bans = self:GetGridBans(ctrlCharacter);
    local height = ctrlCharacter.GetJumpStep();

    local targetPath = nil;
    local characters = BattleCharacterMgr:GetAll();
    if(characters)then
        for id,character in pairs(characters)do
            local characterType = character.GetType();
            if(characterType == eDungeonCharType.MonsterGroup)then  
                local characterGridId = character.GetCurrGridId();    
                
                if(characterGridId == startId)then
                    return {};
                end
                          
                local path = self.ground.FindPath(startId,characterGridId,bans,100,height,true,true);
                if(path)then
                    if(not targetPath or #targetPath > #path)then
                        targetPath = path;
                    end
                end
            end
        end
    end

    local pathIDs = nil;

    if(targetPath)then
        pathIDs = {};
        for _,grid in ipairs(targetPath)do
            table.insert(pathIDs,grid.GetID());
        end
    end

    return pathIDs;
end

--获取目标角色下一步可到达的位置
function this:GetNextGridIds(ctrlCharacter,onlySlide,customCost)
   if(not ctrlCharacter)then
        return;
   end
   local gridIds = {};
   local gridDic = {};
   local list = self.ground.GetLightRange(ctrlCharacter,customCost);
   if(list)then
      for gridId,_ in pairs(list)do      
        if(gridId ~= ctrlCharacter.GetCurrGridId())then
            local targetGrid = self:GetGrid(gridId);
            if(targetGrid:IsCanPass())then
                if(not onlySlide)then
                    table.insert(gridIds,gridId);
                    gridDic[gridId] = gridId;
                end
            else
                --冰面、定向滑动
                local path = self:FindPathIDs(ctrlCharacter,gridId,customCost);
                local targetGridId = self:GetPathDesGridId(ctrlCharacter,path);
                table.insert(gridIds,targetGridId);
                gridDic[gridId] = targetGridId;
            end
          end
      end
   end
 
   return gridIds,gridDic;
end
--获取路径终点
function this:GetPathDesGridId(ctrlCharacter,path)
    if(not path)then
        return;    
    end
    local len = #path;
    local gridId1 = path[len - 1];
    local gridId2 = path[len];
    if(not gridId1 or not gridId2)then
        return;
    end

    local grid1 = self:GetGrid(gridId1);
    local grid2 = self:GetGrid(gridId2);

    local xDir = grid2.x - grid1.x;
    local yDir = grid2.y - grid1.y;

    return self:HandleSlide(ctrlCharacter,grid2,xDir,yDir,grid2.GetType() == eMapGridType.Ice);
end


--处理滑动
--xDir:1上，-1下
--yDir:1右，-1左
--iceSlide：冰面滑动
function this:HandleSlide(character,startGrid,xDir,yDir,iceSlide)
    local currGrid = startGrid;   

    local slidePathGrid = {};
    local targetGridId = nil;
    local bans,targetBans = BattleMgr:GetGridBans(character);   

    local monsterGrids = {};

    --剔除可破坏、可推动的道具
    local allCharacters = BattleCharacterMgr:GetAll();       
    if(allCharacters)then           
        for _,tmpCharacter in pairs(allCharacters)do
           if(tmpCharacter.GetType() == eDungeonCharType.MonsterGroup)then
                if(tmpCharacter.IsFighting())then
                    targetBans = targetBans or {};
                    targetBans[tmpCharacter.GetCurrGridId()] = 1;
                end
                monsterGrids[tmpCharacter.GetCurrGridId()] = 1;
           end
           if(tmpCharacter.GetType() == eDungeonCharType.Prop)then    
                monsterGrids[tmpCharacter.GetCurrGridId()] = 1;            
                if(tmpCharacter.IsCanDestroy() or tmpCharacter.IsCanPush())then
                    targetBans = targetBans or {};
                    targetBans[tmpCharacter.GetCurrGridId()] = 1;
                end
            end

        end
    end

  
    for i = 1,100 do
        if(not currGrid)then
            break;
        end

        local gridId = currGrid.GetID();
        
        if((not targetBans or not targetBans[gridId]) or currGrid == startGrid)then--该格不可作为目标，滑动中不可通过，滑动结束
            table.insert(slidePathGrid,targetGridId);
            targetGridId = gridId;
        else
            --LogError("不可作为目标" .. gridId);
            break;
        end

        if(monsterGrids and monsterGrids[targetGridId])then--遇怪，滑动结束                
            --LogError("遇怪" .. gridId);     
            slideHitMonster = 1;       
            break;
        end 

        if((not bans or not bans[gridId]) or currGrid == startGrid)then--该格不可通过，滑动结束
            
        else
            --LogError("不可通过" .. gridId);
            break;
        end 

        if(iceSlide and currGrid.GetType() ~= eMapGridType.Ice)then--冰面滑动，当前的格子已不是冰面，滑动结束
            --LogError("非冰面单位" .. gridId);
            break;
        end

        --刷新滑动方向
        if(currGrid.GetType() == eMapGridType.Slide)then
            local dir = currGrid.GetDir();           
            if(dir == 1)then
                xDir = 1;
                yDir = 0;
            elseif(dir == 2)then
                xDir = 0;
                yDir = 1;
            elseif(dir == 3)then
                xDir = -1;
                yDir = 0;
            elseif(dir == 4)then
                xDir = 0;
                yDir = -1;
            end
        end

        --滑动下一格
        local nextGrid = currGrid.GetNearGrid(xDir,yDir);  
        if(not nextGrid)then
            --LogError("没有下一格" .. gridId);
            break;
        elseif(currGrid.Height() ~= nextGrid.Height())then--高度不满足
            --LogError("高度不一致" .. gridId);
            break;
        elseif(not nextGrid.GetValidState())then--无效格子
            break;
        end      
        currGrid = nextGrid;
    end
       
    
    return targetGridId;
end


function this:GetSubMaps()
    return self.ground and self.ground.GetSubMaps();
end
-------------------------------------------------------------------------------------------------
----以下是AI寻路算法-----
-- 生成新的出口
function this:GenNewExit(girdNode, key, mapData, blocks, isnotfist)

    local exitID = girdNode[key]
    -- LogDebugEx("this:GenNewExit ", girdNode.id, key, isnotfist, exitID, blocks[exitID] )
    local exitGrid = mapData[exitID]
    local block = blocks[exitID]
    if block then
        if block == 0 then
            if isnotfist then
                return girdNode.id
            end
            return  -- 这个方向的下一步不可停留
        else
            return exitID
        end
    elseif exitGrid.ice then 
        if exitGrid[key] then 
            exitID = self:GenNewExit(exitGrid, key, mapData, blocks, true)
        end
    end

    -- LogDebugEx("GenNewExit end ", girdNode.id, key, isnotfist, exitID)

    return exitID
end

-- 生成新的地图数据
function this:GenNewMapData(obj, pos2)
    LogDebugEx("目标：" .. tostring(pos2));
    local mapData = MapTranslator:Get(BattleMgr:GetSubMaps()) -- 地图数据
    local newMapData = table.copy(mapData) -- 新的地图数据
    -- LogTable(mapData, "oldmapData = ")
    local allCharacters = BattleCharacterMgr:GetAll() -- 所有角色
    local blocks = {} -- 寻路是否作为障碍
    local getBox,getUsefull = self:AIGetPropState();--道具、增益获取状态
    --LogError("getBox:" .. tostring(getBox) .. ",getUsefull:" .. tostring(getUsefull));
    for i,character in pairs(allCharacters) do
        local characterGridId = character.GetCurrGridId(); 
        local characterType = character.GetType();
        local getProp = characterType == eDungeonCharType.Prop and ((getUsefull and character.IsUsefull()) or (getBox and character.IsBox()) or character.IsTrigger() or character.IsTriggerActive());
        -- LogDebugEx("GenNewMapData", characterType, characterGridId, character.IsTriggerBlock and character.IsTriggerBlock() or "x")
        -- if character == obj then ASSERT() end
        --LogError("characterGridId:" .. characterGridId);
        if((characterType == eDungeonCharType.MonsterGroup and character.GetCurrGridId() == pos2) or 
        getProp)then
            --LogError("characterGridId:aaa" .. characterGridId);
            blocks[characterGridId] = 1 -- 可以停到当前位置
        elseif characterType == eDungeonCharType.Prop and getProp and not character.IsBlockCharacter(obj) then 
            --LogError("characterGridId:bbb" .. characterGridId);
            -- 非激活状态的障碍,不用处理
        else
            --LogError("characterGridId:ccc" .. characterGridId);
            blocks[characterGridId] = 0 -- 不可以停到道具上
        end
    end
    --LogError(blocks);
    local ctrlCharacter = self:GetCtrlCharacter();
    if ctrlCharacter then
        local characterGridId = ctrlCharacter.GetCurrGridId(); 
        blocks[characterGridId] = nil
    end

    LogTable(blocks, "blocks = ")
    local keys = {"up", "right", "down", "left"}

    for i,girdNode in pairs(newMapData) do
        -- local girdNode = newMapData[10105]
        for i,key in ipairs(keys) do
            -- LogDebugEx("girdNode", i, key, girdNode[key])
            if girdNode[key] then
                local exitID = self:GenNewExit(girdNode, key, newMapData, blocks)
                -- LogDebugEx("exitID", exitID, key)
                if exitID then
                    girdNode.old = girdNode.old or {}
                    girdNode.old[key] = girdNode[key]
                    girdNode[key] = exitID
                    table.insert(girdNode.exits, exitID)
                end
            end
        end
    end

    LogTable(newMapData, "newMapData = ")
    return newMapData
end

-- 获取路径(障碍要配成可路过, 否则要配置阻挡, 不然寻路还是会寻过去的)
function this:GetPath_new(obj, pos2)
    LogDebugEx("GetPath_new", obj.GetCurrGridId(), pos2)

    local mapData = self:GenNewMapData(obj, pos2)

    -- 道具也要做成阻挡
    local used = nil
    used = self:AStarNew(mapData, obj, pos2, {}, nil, nil, obj.GetMoveStep())

    -- local cost = customCost or character.GetMoveStep();
    -- local height = character.GetJumpStep();

    -- LogTable(self.arrBlocks, "self.arrBlocks")
    -- LogTable(used, "used = "..table.size(used))
    if not used then
        return
    end

    local pos = pos2
    local path = {} -- 完整的移动路径

    while pos and pos ~= 0 do
        LogTable(mapData[pos], "map"..pos)
        table.insert(path, 1, pos)
        --LogDebugEx("path", pos, used[pos].pos)
        pos = used[pos].pos
    end
    local keys = {"up", "right", "down", "left"}
    for i = #path, 2, -1 do
        local grid2 = mapData[path[i]]
        local grid1 = mapData[path[i-1]]
        local key = ""
        for k,v in ipairs(keys) do
            if grid1[v] == grid2.id then
                key = v
                break
            end
        end
        if grid1.old and grid1.old[key] then
            path[i] = grid1.old[key]
        end
    end

    LogTable(path, "full path = ")
    return path
end

-- 新版A星算法
function this:AStarNew(mapData, obj, p2, blok, used, periphery, nStep)
    local p1 = obj.GetCurrGridId()
    LogDebugEx("Duplicate:AStarNew", p1, p2)
    if not p1 or not p2 then
        return
    end
    if p1 == p2 then
        return
    end

    -- local nObjStep = obj.nStep
    local nJump = obj.GetJumpStep();

    periphery = periphery or {p1} -- 最外面一层
    blok = blok or {} -- 阻挡
    if not used then
        used = {}
        used[p1] = {weight = 0, id = p1, nStep = nStep}
    end

    -- 已经找到了退出
    if used[p2] then
        return used
    end

    --LogTable(periphery, "最外层")

    local newperiphery = {}
    for i, v in ipairs(periphery) do
        local config = mapData[v]
        ASSERT(config)

        for iexit, exitID in ipairs(config.exits) do
            --LogTable(config.exits, "config.exits")
            -- LogDebugEx("exitID = ", exitID)

            local nTarHeight = mapData[exitID].height or 0
            local nSrcHeight = config.height or 0
            -- 由陆地到水中需要多消耗一个步数
            -- nCosts = nCosts - self:GetMoveWeight(obj.nMoveType, srcpos, v)
            local weight = used[v].weight + self:GetMoveWeight(mapData, obj.GetMoveType(), v, exitID) -- 移动步数

            if math.abs(nSrcHeight - nTarHeight) <= nJump then
                if blok[exitID] then
                    -- 阻挡
                elseif exitID == p2 then
                    -- 到终点了
                    used[exitID] = {pos = config.id, id = exitID, weight = weight}
                    return used
                elseif used[exitID] then
                    -- -- 有更优解
                    if weight < used[exitID].weight then
                        table.insert(newperiphery, exitID)
                        used[exitID] = {pos = config.id, id = exitID, weight = weight}
                    end
                elseif not used[exitID] then
                    table.insert(newperiphery, exitID)
                    used[exitID] = {pos = config.id, id = exitID, weight = weight}
                end
            end
        end
    end

    --LogTable(newperiphery, "新的最外层")
    if #newperiphery == 0 then
        return
    end

    local ret = self:AStarNew(mapData, obj, p2, blok, used, newperiphery, nStep)
    if not ret then
        return
    end

    return used
end

-- 计算移动消耗(水中消耗+1)
function this:GetMoveWeight(mapData, nMoveType, pos1, pos2)
    local cfg2 = mapData[pos2]
    if cfg2.ice then
        return 0
    elseif cfg2.gravity then
        return cfg2.nGravity -- 重力区返回重力 为负时增加距离
    end -- 冰面
    if not cfg2.water then
        return 1
    end -- 目标点不是水中

    local cfg1 = mapData[pos1]
    -- if cfg1.water then return 1 end -- 起点在水中

    -- 飞行/陆地/浮游单位+1
    if nMoveType == eMoveType.Fly or nMoveType == eMoveType.Land or nMoveType == eMoveType.Float then
        return 2
    end

    -- 其他情况
    return 1
end


function this:SetMistDis(mistDis)
    self.mistDis = mistDis;
end

function this:UpdateMistEff()
    if(self.mistDis)then
        if(not self.mistEff)then
            local parentGO = self.ground and self.ground.gameObject;
            ResUtil:CreateEffect("battle/sandStorm_v3", 0,11.5,0,parentGO,function(go)
                if(IsNil(parentGO))then
                    CSAPI.RemoveGO(go);
                    return;
                end

                self.mistEffGO = go;
                CSAPI.SetScale(go,30,30,1);
                CSAPI.SetAngle(go,90,0,0);
                self.mistEff = ComUtil.GetCom(go,"SetMaterialUV");   
            end);
        end

        if(self.mistEffGO)then
            CSAPI.SetGOActive(self.mistEffGO,true);
            local character = self:GetCtrlCharacter();
            if(not character)then
                local defaultCtrlId = self:GetDefaultCtrlId();
                --LogError("设置默认跟谁角色" .. tostring(defaultCtrlId));
                character = BattleCharacterMgr:GetCharacter(defaultCtrlId);
            end
            if(character and character.GetType() == eDungeonCharType.MyCard)then
                self.mistEff.target = character.gameObject;
            end
        end
    else
        if(self.mistEffGO)then
            CSAPI.SetGOActive(self.mistEffGO,false);
        end    
    end    
end
--- 更新迷雾角色显示状态
---@param gridId any
---@param dis any
function this:UpdateCharactersMistState(targetGridId,dis)
    self:UpdateMistEff();

    local gridIds = self:GetMistOuterGridIds(targetGridId);
    if(not gridIds)then
        return;
    end   
    
    local allCharacters = BattleCharacterMgr:GetAll();
    if(allCharacters)then
        for id,character in pairs(allCharacters)do
            if(not character.IsDead())then
                local gridId = character.GetCurrGridId();
                local state = gridIds[gridId] and true or false;
                character.SetMistState(state);

                if(character.UpdateWarningEffsShowState)then
                    --LogError(targetGridId);
                    character.UpdateWarningEffsShowState(targetGridId);
                end
            end
        end
    end
end

function this:IsInMist(gridId,mistGridId)
    local gridIds = self:GetMistOuterGridIds(mistGridId);
    return gridIds and not gridIds[gridId];
end

function this:GetMistOuterGridIds(gridId)
    local dis = self.mistDis;
    if(not dis or dis <= 0)then
        return;
    end

    if(not gridId)then
        local character = self:GetCtrlCharacter();
        if(not character)then
            local defaultCtrlId = self:GetDefaultCtrlId();
            character = BattleCharacterMgr:GetCharacter(defaultCtrlId);
        end
        gridId = character and character.GetCurrGridId();
        if(not gridId)then
            return;
        end
    end
    
    local gridIds = {};

    for i = -dis,dis do
        for j = -dis,dis do
            local targetGridId = gridId + i * 100 + j;
            gridIds[targetGridId] = 1;
        end
    end

    return gridIds;
end

function this:UpdateMistViewDis()
    local currRound = self:GetStepNum() or 0;
    local battleDungeonData = self.ground and self.ground.GetBattleDungeonData();
    local mists = battleDungeonData and battleDungeonData.mists;
    --mists = {{round = 0,view = 1}};
    if(not mists)then
        return;
    end
    local viewDis = nil;
    local tmpRound = -1;
    for _,mistData in ipairs(mists)do
        --LogError(mistData);
        --LogError("currRound:" .. tostring(currRound));LogError("tmpRound:" .. tostring(tmpRound));
        if(mistData.round <= currRound and mistData.round > tmpRound)then
            tmpRound = mistData.round;
            viewDis = mistData.view;
        end
    end
    self:SetMistDis(viewDis);
    self:UpdateCharactersMistState();
end

-- BattleMgr:ApplyAIMove
-- BattleMgr:GetSubMaps()--获取地图数据
-- BattleCharacterMgr:GetAll()--获取角色、怪物、道具
return this;