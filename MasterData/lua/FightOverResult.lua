local expBar = nil;
local pos = {{-514, -7}, {-256, -7}, {3, -7}, {265, -7}, {526, -7}};
local hpBar = nil;
local fillExpBar = SetNil
local hasCallFunc = false;
local isShowLvBar = false

local bIsWin = false
local fightOverData = nil
local sceneType = nil

local viewLua = nil

-- 结算
function Awake()
    CSAPI.SetGOActive("AIMask", false)

    -- GM挂机测试用
    if (_G.Fight_Auto) then
        FuncUtil:Call(ApplyQuit, nil, 2000);
    end

    MenuBuyMgr:ConditionCheck(3) --MenuMgr:ReduceMenuBuyChangeNum()
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    FightClient.IsFightOver=true;
end

function OnViewOpened(viewKey)
    if viewKey == "Plot" then
        CSAPI.StopUISound("ui_battle_victory_settlement")
    end
end

function OnLoadComplete()
    if bIsWin then
        CSAPI.PlayUISound("ui_battle_victory_settlement")
    end
end

function OnDisable()
    FightClient.IsFightOver=false;
    eventMgr:ClearListener();
end

-- data  FightResultTool的封装
function OnOpen()
    if isFirst then
        return 
    end
    isFirst = false
    
    sceneType = data.sceneType -- 在FightActionFightEnd添加的
    --如果是肉鸽,如果是非最终轮胜利,不用显示结算
    --如果任意轮是保存进度退出，不用显示结算
    if(sceneType==SceneType.Rogue) then 
        if(data.bIsWin and data.elseData.round<RogueMgr:GetCurData2():GetLimitRound()) then 
            ClearTeamData()
            CSAPI.SetScale(gameObject,0,0,0)
            FightClient:Clean()
            RogueMgr:NeedToBuffView(true)
            RogueMgr:FightToBack(false, data.elseData.group)
            return
        elseif(data.elseData.quitType==2 and data.elseData.save)then 
            ClearTeamData()
            CSAPI.SetScale(gameObject,0,0,0)
            FightClient:Clean()
            RogueMgr:FightToBack(data.elseData.save, data.elseData.group)
            return
        end 
    elseif(IsPvpSceneType(sceneType)) then 
        if(data.elseData.isLookFriend)then 
            FightClient:Clean(true)
            ExerciseRMgr:SetIsLookFight(false)
            ExerciseRMgr:Quit(RealArmyType.Friend)
            return
        elseif(data.elseData.isThree)then 
            local winers = ExerciseRMgr3:GetFightData().winers or {}
            if(#winers==1 or (#winers==2 and winers[1]~=winers[2]))then 
                CSAPI.SetScale(gameObject,0,0,0)
                FightClient:Clean(true)
                ExerciseRMgr3:BackToVS()
                return
            end
        end 
    end 

    bIsWin = GetIsWin(sceneType)

    --FightProto:DuplicateOver整合的数据
    local fightOverData = FightProto:GetFightOverData() 
    if fightOverData then
        data.rewards = fightOverData.rewards or data.rewards
        data.nPlayerExp = fightOverData.nPlayerExp and data.nPlayerExp + fightOverData.nPlayerExp or data.nPlayerExp
        data.totalDamage = fightOverData.totalDamage
    end

    local viewPath = bIsWin and "FightOver/FightOverToWin" or "FightOver/FightOverToLose"
    ResUtil:CreateUIGOAsync(viewPath, viewParent, function(go)
        viewLua = ComUtil.GetLuaTable(go)
        viewLua.Refresh(data, data.elseData)
        -- 自动
        AI()
    end)

    EventMgr.Dispatch(EventType.Fight_Over_Panel_Show)

    local isSweep = data.elseData and data.elseData.isSweep or false
    if not isSweep then
        MenuMgr:SetFightOver(true)
    end

    --spcialGuide
    ShowSpecialGuide()
end

function GetIsWin(_sceneType)
    if (_sceneType == SceneType.BOSS or IsPvpSceneType(_sceneType) or _sceneType == SceneType.PVPMirror or _sceneType == SceneType.GlobalBoss or
     _sceneType == SceneType.RogueT or _sceneType == SceneType.RogueMap or _sceneType==SceneType.MultTeam or _sceneType==SceneType.RogueMapSup or
    _sceneType == SceneType.TowerDeep or _sceneType == SceneType.ChainFront or _sceneType == SceneType.PeriodicBoss or _sceneType == SceneType.CrossBoss) then
        return true
    elseif _sceneType == SceneType.PVE then
        local cfg = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
        if cfg then
            if cfg.type == eDuplicateType.StarPalace then
                return true       
            elseif cfg.type == eDuplicateType.StoryActive and cfg.diff and cfg.diff == 4 then
                return true   
            end
        end
        return data.bIsWin
    elseif _sceneType == SceneType.PVP3 or _sceneType==SceneType.PVPFriend3 then
        return true   
    else
        return data.bIsWin
    end
end

-- 自动过图
function AI()
    if (sceneType == SceneType.PVE and BattleMgr:GetAIMoveState()) then
        -- 缓存奖励数据
        CSAPI.SetGOActive("AIMask", true)
        FuncUtil:Call(AIClick, nil, 2000)
    end
end

function AIClick()
    OnClickMask()
    if (isClicked == 1) then
        FuncUtil:Call(OnClickMask, nil, 1500)
    end
end

-- 退出 jump:跳转方式
function ApplyQuit()
    if(not PlayerClient:GetUid())then
        return;
    end
    FightClient:Clean()
    if sceneType == SceneType.PVE or sceneType == SceneType.PVEBuild then -- 清理PVE的数据
        local dungeonId = DungeonMgr:GetCurrId();
        local isOver = DungeonMgr:IsCurrDungeonComplete();
        if isOver then
            -- 副本结束
            if sceneType == SceneType.PVE and BattleMgr:GetAIMoveState() and DungeonMgr:CurrSectionIsMainLine() and
                hasCallFunc ~= true then
                -- 记录战斗队伍信息、关卡ID
                local teams = TeamMgr:GetAutoDuplicateTeamData();
                DungeonMgr:AddAutoDungeonInfo(dungeonId, teams);
                MenuMgr:AddOpenFunc("Dungeon", function()
                    local eventMgr = ViewEvent.New();
                    eventMgr:AddListener(EventType.Loading_Complete, function()
                        if bIsWin then -- 胜利
                            CSAPI.OpenView("FightNaviReward");
                        else -- 失败
                            local dialogdata = {};
                            dialogdata.content = LanguageMgr:GetByID(25006);
                            dialogdata.okCallBack = function()
                                CSAPI.OpenView("FightNaviReward");
                            end
                            CSAPI.OpenView("Prompt", dialogdata)
                        end
                        eventMgr:ClearListener();
                    end)
                end);
                hasCallFunc = true;
            end
            ClearTeamData()
            UIUtil:AddFightTeamState(2, "FightOverResult:ApplyQuit()")
        elseif dungeonId ~= nil and dungeonId ~= "" then -- 未结束
            DungeonMgr:ApplyEnter(dungeonId);
            return;
        end
    end
    -- 基地突袭
    if (sceneType == SceneType.PVEBuild) then
        if (data.elseData and data.elseData == RealArmyType.Matrix) then
            MatrixMgr:InScene()
        else
            -- 测试用
            SceneLoader:Load("MajorCity")
        end
    elseif (IsPvpSceneType(sceneType)) then
        if(sceneType==SceneType.PVP3 or sceneType==SceneType.PVEFreeMatch3)then 
            ExerciseRMgr3:Quit(data.elseData.type)
        else 
            ExerciseRMgr:Quit(data.elseData.type)
        end 
    elseif (sceneType == SceneType.PVPMirror) then
        ExerciseMgr:Quit(data.elseData.type)
    elseif (sceneType == SceneType.BOSS) then
        BattleFieldMgr:Quit()
    elseif sceneType == SceneType.PVE then
        DungeonMgr:Quit(not bIsWin);
    elseif (sceneType == SceneType.GuildBOSS) then
        GuildFightMgr:FightQuit();
    elseif (sceneType == SceneType.Rogue) then
        ClearTeamData()
        RogueMgr:FightToBack(not data.bIsWin, data.elseData.group) --最终轮
    elseif (sceneType == SceneType.RogueS) then
        local len = RogueSMgr:GetLen(data.elseData.group)
        if(not bIsWin or data.elseData.round>= len) then 
            ClearTeamData()
            local group = data.elseData.group
            if(bIsWin) then 
                group = RogueSMgr:GetNextGroup(group)
            end
            RogueSMgr:Quit(group)
        else
            --只能重复挑战或者下一关
        end   
    elseif(sceneType == SceneType.GlobalBoss) then
        GlobalBossMgr:Quit()
    elseif (sceneType == SceneType.RogueT) then
        ClearTeamData()
        local nDuplicateID = data.elseData.nDuplicateID
        if(RogueTMgr:IsInfinity(nDuplicateID))then 
            RogueTMgr:Quit()
        else
            if(data.elseData.bIsWin and RogueTMgr:IsMainLineLast(nDuplicateID) and RogueTMgr:CheckCanSave(nDuplicateID) )then 
                --最后一关触发保存buff
                local cfg = Cfgs.MainLine:GetByID(nDuplicateID)
                CSAPI.OpenView("RogueTSaveBuff", cfg.dungeonGroup)
            else
                RogueTMgr:Quit()
            end 
        end 
    elseif (sceneType == SceneType.BuffBattle) then
        ClearTeamData()
        DungeonMgr:Quit(not bIsWin);
    elseif (sceneType == SceneType.RogueMap) then
        if RogueMapMgr:IsDungeonOver() then
            ClearTeamData()
            RogueMapMgr:SendToQuit()
        else
            local dungeonId = RogueMapMgr:GetDungeonId();
            RogueMapMgr:ApplyEnter(dungeonId)
        end
    elseif (sceneType == SceneType.RogueMapSup) then
        ClearTeamData()
        RogueMapMgr:ApplyAssistQuit()
    elseif (sceneType == SceneType.MultTeam) then
        ClearTeamData()
        DungeonMgr:Quit(not bIsWin);
    elseif (sceneType == SceneType.TowerDeep ) then
        local len = RogueSMgr:GetLen(data.elseData.group)
        if not data.elseData.bIsWin or data.elseData.round>= len then
            ClearTeamData()
            DungeonMgr:Quit(not bIsWin);
        end
    elseif sceneType == SceneType.ChainFront then --连锁
        local len = TrialsMgr:GetLen(data.elseData.group)
        if not data.elseData.bIsWin or data.elseData.round>= len then
            ClearTeamData()
            DungeonMgr:Quit(not bIsWin,5);
        end
    elseif sceneType == SceneType.PeriodicBoss then
            ClearTeamData()
            DungeonMgr:Quit(not bIsWin);
    elseif sceneType == SceneType.CrossBoss then
        local func = function()
            ClearTeamData()
            DungeonMgr:Quit(not bIsWin);
        end
        if VirCatMgr:IsSaveMax(data.elseData.nodeId) then
            local _data = {nodeId = data.elseData.nodeId}
            _data.closeCallBack = func
            CSAPI.OpenView("VirtualCataclysmArchive",_data)
        else
            func()
        end
    end
end

function OnClickMask()
    if (isClicked == 2 or isClicked == 1) then
        return;
    end
    if bIsWin and not viewLua.IsAnimEnd() then
        isClicked = 1
        viewLua.JumpToAnimEnd()
        FuncUtil:Call(function ()
            if gameObject then
                isClicked = 0
            end
        end, nil, 500)
        return
    end

    isClicked = 2;
    if data and data.elseData and (data.elseData.isSweep or data.elseData.isGlobalSweep) then --扫荡关闭
        view:Close()
        PopupPackMgr:CheckByCondition({1})
        return
    end

    local cfg = DungeonMgr:GetFightMonsterGroup();
    local isNotPvP = not IsPvpSceneType(sceneType) and sceneType ~= SceneType.PVPMirror
    if (bIsWin and cfg and cfg.storyID2 and isNotPvP) then
        PlotMgr:TryPlay(cfg.storyID2, ApplyQuit, nil, false);
    else
        ApplyQuit();
    end
end

function ClearTeamData()
    FriendMgr:ClearAssistData();
    TeamMgr:ClearAssistTeamIndex();
    TeamMgr:ClearFightTeamData();
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if  OnClickMask then
        OnClickMask();
    end
end

function OnDestroy()
    ReleaseCSComRefs();
end

function ShowSpecialGuide()
    if not DungeonMgr:IsCurrDungeonComplete() then
        return
    end
    if bIsWin then
        return
    end
    if data.team then
        local lv,count = 0,0
        for i = 1, 5 do
            local v = data.team:GetItemByIndex(i);
            if v ~= nil then
                local card = v:GetCard()
                if card then
                    lv = lv + card:GetLv()
                    count = count + 1
                end
            end
        end
        local lvAvg = lv / count
        SpecialGuideMgr:ApplyShowView(spParent,"FightOverResult",SpecialGuideType.Start,{teamlevel = lvAvg})
    end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    PlayerLv = nil;
    winObj = nil;
    titleObj = nil;
    txtTitle = nil;
    txtTitle1 = nil;
    txtName = nil;
    SliderExp = nil;
    expSlider = nil;
    Fill = nil;
    txtLv2 = nil;
    lifeBuffs = nil;
    goldAdd = nil;
    txtGoldBuff = nil;
    dropAdd = nil;
    txtDropBuff = nil;
    expAdd = nil;
    txtExpBuff = nil;
    jfObj = nil;
    txtJf1 = nil;
    txtJf2 = nil;
    hurtObj = nil;
    txtHurt1 = nil;
    txtHurt2 = nil;
    btnStatistics = nil;
    txtStatistics = nil;
    txtNone = nil;
    failObj = nil;
    txt_fail1 = nil;
    txtFail1 = nil;
    txt_fail2 = nil;
    txtFail2 = nil;
    txt_fail3 = nil;
    txtFail3 = nil;
    txt_fail4 = nil;
    txtFail4 = nil;
    bossFailObj = nil;
    SliderHP = nil;
    txtHP = nil;
    hpSlider = nil;
    Fill = nil;
    txtHPVal = nil;
    txtDamage = nil;
    txtDamageVal = nil;
    cardGrid = nil;
    txtClose = nil;
    lvFade = nil;
    AIMask = nil;
    view = nil;
end
----#End#----
