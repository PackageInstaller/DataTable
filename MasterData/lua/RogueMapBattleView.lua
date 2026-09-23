local sectionData = nil
local dungeonData = nil
local isRollRefresh = false
local items = nil
local items2 = nil
local bossItems = nil
local isSetting = false
local top = nil
local setItem = nil
local isPass = false
local currGridId = nil
local effectItems = nil
local bossItems = {}
local specTime,time,timer = 0,0,0

function Awake()
    AdaptiveConfiguration.SetLuaObjUIFit("RogueMapBattle", gameObject)
    -- 添加问号 rui 211130 --因为不是通过openview打开的，所以要手动添加
    UIUtil:AddQuestionItem("RogueMapBattle", gameObject, questionParent)

    CSAPI.SetGOActive(clickMask, false)
    CSAPI.SetGOActive(moveObj, false)
    CSAPI.SetGOActive(supObj, false)
    InitListener()
end

function InitListener()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RogueMap_Battle_View_Show, OnViewShow)
    eventMgr:AddListener(EventType.RogueMap_Battle_Grid_Click, OnGridClick) -- 点击返回
    eventMgr:AddListener(EventType.Battle_Character_Created, OnBattleCharacterCreated); -- 角色生成
    eventMgr:AddListener(EventType.RogueMap_Battle_GridEvent_Trigger, OnTipsShow) -- 显示队伍界面
    eventMgr:AddListener(EventType.RogueMap_Battle_View_Update, OnViewUpdate) -- 界面更新
    eventMgr:AddListener(EventType.RogueMap_Battle_Support_Show, OnSupportShow) -- 显示求援选择
    eventMgr:AddListener(EventType.Arachnid_Count_Refresh, OnViewUpdate) -- 购买门票后刷新
    eventMgr:AddListener(EventType.RogueMap_Battle_Pass_Show, OnPassShow)
    eventMgr:AddListener(EventType.RogueMap_Battle_Mist_Refresh,OnSupRefresh) --boss冷却显示
    eventMgr:AddListener(EventType.RogueMap_Update,OnViewUpdate)
    -- eventMgr:AddListener(EventType.RogueMap_Battle_GridInfo_Create, OnBattleGridInfoCreated)
end
 
-- 初始化界面
function OnViewShow()
    InitPanel()
end

-- 生成角色模型
function OnBattleCharacterCreated(character)
    if (character == nil) then
        return;
    end

    if (battleGround == nil) then
        return;
    end

    if (character.GetType() == eDungeonCharType.Prop) then
        return;
    end

    local go = ResUtil:CreateUIGO("RogueMapBattle/RogueMapBattleGCInfo", infos.transform);
    local goCamera = battleGround.GetCamera();
    CSAPI.AddUISceneElement(go, character.resParentGO, goCamera);

    local lua = ComUtil.GetLuaTable(go)
    if lua and character.GetMoveStep() > 0 then
        lua.SetStepShow(character.GetMoveStep())
    end
end

-- 点击格子反馈
function OnGridClick()
    CSAPI.SetGOActive(moveObj, RogueMapBattleMgr:IsMoveSetting())
end

-- 弹窗显示
function OnTipsShow(info)
    SetLeft() -- 刷新左侧
    if not info then
        return
    end
    if info.specTime and TimeUtil:GetTime() > info.specTime then --过时消失
        return
    end
    if info.type == eRogueMapPosType.Monster then
        ShowSelectTeams(info)
    elseif info.type == eRogueMapPosType.SpecialBoss or info.type == eRogueMapPosType.Boss then
        local teamNum = #TeamMgr:GetFightTeam() or 1
        local isStop = info.times and info.times[1] > TimeUtil:GetTime()
        if isStop and teamNum > 1 then
            isStop = info.times and info.times[2] > TimeUtil:GetTime()
        end
        if isStop then
            LanguageMgr:ShowTips(50011)
            return
        end
        if RogueMapBattleMgr:IsGridHasSupport(info.id) then
            ShowSupportCancelTips(info)
            return
        end
        if info.isUnLock then
            ShowSelectTeams(info)
        else
            OnSpecialBossShow(info)
        end
    elseif info.type == eRogueMapPosType.Buff then
        ShowTips("RogueMapBuffTips",{buffs = RogueMapMgr:GetBuffs(3),info = info})
    end
end

-- 显示特殊战斗动效
function OnSpecialBossShow(info)
    effectItems = effectItems or {}
    local type = eRogueMapEffectType[eRogueMapPosType.SpecialBoss]
    if effectItems[type] then
        CSAPI.SetGOActive(effectItems[type], true)
        FuncUtil:Call(function()
            CSAPI.SetGOActive(effectItems[type], false)
            ShowSelectTeams(info)
        end, this, 1800)
    else
        ResUtil:CreateUIGOAsync("RogueMapBattle/Danger", effectParent, function(go)
            effectItems[type] = go
            FuncUtil:Call(function()
                CSAPI.SetGOActive(go, false)
                ShowSelectTeams(info)
            end, this, 1800)
        end)
    end
end

-- 显示正常战斗选择界面
function ShowSelectTeams(info)
    info = info or {}
    currGridId = info.id
    ShowTips("RogueMapTeamTips",info)
end

--取消求援协议弹窗
function ShowSupportCancelTips(info)
    local dialogData = {}
    dialogData.content = LanguageMgr:GetByID(76075)
    dialogData.okCallBack = function()
        if not info.supIndex then
            LogError("该格子没有s_ix数据")
            return
        end
        if info.supTime and info.supTime <= TimeUtil:GetTime() then
            return
        end
        FightProto:RogueMapSupportCancel(info.supIndex,function ()
            OnTipsShow(info)
        end)
    end
    CSAPI.OpenView("Dialog",dialogData)
end

-- 显示求援界面
function OnSupportShow()
    ShowTips("RogueMapSupTips")
end

function OnPassShow()
    if isPass and not RogueMapMgr:IsShowPassView() then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(50009)
        dialogData.okCallBack = function()
            FightProto:RogueMapPassWindow()
            RogueMapMgr:ApplyQuit()
        end
        dialogData.cancelCallBack = function()
            FightProto:RogueMapPassWindow()
        end
        CSAPI.OpenView("Dialog", dialogData)
    end
end

function OnSupRefresh()
    SetLeft()
end

function OnViewUpdate()
    RefreshPanel()
end

function OnBattleGridInfoCreated()
    if (battleGround == nil) then
        return;
    end

    local dis = RogueMapBattleMgr:GetMistDis()
    if dis then
        local go, lua = nil, nil
        local goCamera = battleGround.GetCamera();
        for k, v in pairs(dis) do
            if v.times and (v.times[1] > 0 or v.times[2] > 0) then
                if v.times[1] > TimeUtil:GetTime() or v.times[2] > TimeUtil:GetTime() then
                    go = ResUtil:CreateUIGO("RogueMapBattle/RogueMapBattleGridInfo", gridInfos.transform);
                    local grid = battleGround.GetGrid(v.id)
                    if grid then
                        CSAPI.AddUISceneElement(go, grid.node, goCamera);
                    end
                    lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(v)
                end
            end
        end
    end
end

function OnDestroy()
    CSAPI.SetGOActive(top.btn_home, true)
    eventMgr:ClearListener()
    if (battleGround) then
        battleGround.Remove();
    end
end

function OnInit()
    top = UIUtil:AddTop2("RogueMapBattle", topParent, OnClickBack);
    CSAPI.SetGOActive(top.btn_home, false)
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = specTime - TimeUtil:GetTime()
        LanguageMgr:SetText(txtSpecTime, 76082, TimeUtil:GetTimeStr(time))
        if time <= 0 then
            LanguageMgr:SetText(txtSpecTime, 76083)
            SetLeft()
            EventMgr.Dispatch(EventType.RogueMap_Battle_Mist_Refresh)
            EventMgr.Dispatch(EventType.RogueMap_Boss_UI_State_Update)
        end
    end
end

function OnOpen()
    InitBattleGround()
    InitDatas()
    InitDungeon()
    InitCtrlType()
end

function InitDatas()
    local id = RogueMapMgr:GetDungeonId()
    if id == nil then
        return
    end
    dungeonData = DungeonMgr:GetDungeonData(id)
    if dungeonData == nil then
        dungeonData = DungeonData.New()
        dungeonData:SetData({
            id = id
        })
    end

    sectionData = DungeonMgr:GetSectionData(dungeonData:GetCfg().group)
end

-- 初始化战场
function InitBattleGround()
    if (battleGround) then
        return;
    end

    local go = CSAPI.CreateGO("RogueMap/RogueMapBattleGround");
    battleGround = ComUtil.GetLuaTable(go);
end

-- 初始化战斗场景
function InitDungeon()
    if (battleGround) then
        if (dungeonData) then
            battleGround.InitDungeon(dungeonData:GetID(), OnBattleGroundInited);
        else
            LogError("初始化副本失败！副本数据错误");
            LogError(dungeonData);
        end
    end
end

function OnBattleGroundInited()
    EventMgr.Dispatch(EventType.RogueMap_Ground_Inited, battleGround);
end

function InitCtrlType()
    if (battleGround) then
        battleGround.SetCtrlState(0); -- 固定默认移动
    end
end

function InitPanel()
    SetLeft()
    RefreshPanel()
end

function RefreshPanel()
    SetRollButton()
    SetLevel()
    SetAction()
    SetBuffs()
    SetTouchTips()
end

function SetRollButton()
    isRollRefresh = false
    CSAPI.SetGOAlpha(btnRoll, RogueMapMgr:IsCanRoll() and 1 or 0.5)
end

function SetLevel()
    local curLv, maxLv = RogueMapMgr:GetFightLv() or 1, RogueMapMgr:GetLvLimit(dungeonData:GetID()) or 1
    local isMax = curLv >= maxLv
    curLv = curLv >= maxLv and maxLv or curLv
    CSAPI.SetText(txtLv, curLv .. "")

    local cur, max = RogueMapMgr:GetFightExp()
    if isMax then
        LanguageMgr:SetText(txtLevel,76080)
    else
        CSAPI.SetText(txtLevel,LanguageMgr:GetByID(76079) .. (max - cur))
    end

    local cfgLevel = Cfgs.CfgRogueMapLevel:GetByID(curLv)
    CSAPI.SetGOActive(levelEffect, cfgLevel and cfgLevel.showEffect ~= nil)
    CSAPI.SetGOActive(levelEffect2, cfgLevel and cfgLevel.showEffect and cfgLevel.showEffect > 1)
end

function SetAction()
    local cur, max = RogueMapMgr:GetRollNum()
    CSAPI.SetText(txtAction1, cur .. "")
    CSAPI.SetText(txtAction2, "/" .. max)
end

function SetBuffs()
    local buffs = RogueMapMgr:GetBuffs(3)
    CSAPI.SetGOActive(buffObj,#buffs >0)
    if buffs and #buffs > 0 then
        items2 = items2 or {}
        ItemUtil.AddItems("RogueMapBattle/RogueMapBattleBuff", items2, buffs, itemParent2)
    end
    CSAPI.SetText(txtCur2,#buffs .. "")
end

function SetTouchTips()
    CSAPI.SetGOActive(touchMask, RogueMapMgr:IsCanRoll())
end

function SetLeft()
    local info, cur, max = GetMistInfo()
    local needNum = RogueMapMgr:GetGlobal("passNeedNum") or 3
    max = max > needNum and needNum or max
    CSAPI.SetText(txtCur1, cur > max and max .. "" or cur .. "")
    CSAPI.SetText(txtMax, "/" .. max)
    isPass = cur >= max

    bossItems = bossItems or {}
    ItemUtil.AddItems("RogueMapBattle/RogueMapBossItem", bossItems, info, itemParent)
end

function GetMistInfo()
    local mistData = RogueMapBattleMgr:GetMistDis()
    local cur, max = 0, 1
    local info = {}
    if mistData then
        local isCool = false
        local isLost = false
        local teamNum = #TeamMgr:GetFightTeam() or 1
        for _, v in pairs(mistData) do
            if v.type ~= nil then
                if v.type == eRogueMapPosType.Boss or v.type == eRogueMapPosType.SpecialBoss then
                    if v.state == eDungeonCharState.Death then
                        cur = cur + 1
                    end
                    max = max + 1
                    isCool = v.supTime ~= nil and v.supTime > TimeUtil:GetTime()
                    isLost = v.specTime and v.specTime < TimeUtil:GetTime()
                    table.insert(info, {
                        id = v.id,
                        isPass = v.state == eDungeonCharState.Death,
                        isCool = isCool,
                        isLost = isLost,
                    })
                end
                if v.type == eRogueMapPosType.SpecialBoss then
                    CSAPI.SetGOActive(specialBossObj,v.state == eDungeonCharState.Active)
                    SetSpecTime(v)
                end
            end
        end
    end
    if #info > 0 then
        table.sort(info, function(a, b)
            return a.id < b.id
        end)
    end
    return info, cur, max
end

function SetSpecTime(v)
    if v.specTime then
        specTime = v.specTime
        time = specTime - TimeUtil:GetTime()
        SetMonsterIcon(v.specGroupId)
        if time <= 0 then
            LanguageMgr:SetText(txtSpecTime, 76083)
            RogueMapBattleMgr:CheckBossTimeEnd()
            -- EventMgr.Dispatch(EventType.RogueMap_Battle_Mist_Refresh)
        end
    end
end

function SetMonsterIcon(monsterGroupId)
    local cfgMonsterGroup = Cfgs.MonsterGroup:GetByID(monsterGroupId)
    if cfgMonsterGroup and cfgMonsterGroup.monster then
        local cfgMonster = Cfgs.MonsterData:GetByID(cfgMonsterGroup.monster)
        if cfgMonster and cfgMonster.model then
            local cfgModel = Cfgs.character:GetByID(cfgMonster.model)
            if cfgModel and cfgModel.List_head then
                ResUtil.RogueMapBoss:Load(specIcon, cfgModel.List_head)
            end
        end
    end
end

function OnClickRoll()
    if not RogueMapMgr:IsCanRoll() then
        return
    end
    if RogueMapMgr:GetRollNum() <= 0 and IsShowBuy() then
        return
    end
    if isRollRefresh then
        return
    end
    isRollRefresh = true

    FightProto:RogueMapRoll()

    -- 副本消息超时提示
    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "rogueMap_roll",
        time = 5000,
        timeOutCallBack = function()
            isRollRefresh = false
        end
    });
end

function IsShowBuy()
    if sectionData then
        local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
        if curCount <= 0 then
            LanguageMgr:ShowTips(33005)
            return true
        end
        if sectionData:GetBuyGets() then
            UIUtil:OpenPurchaseView(LanguageMgr:GetByID(76019), LanguageMgr:GetByID(76020), curCount,
                sectionData:GetBuyCount(), sectionData:GetBuyCost(), sectionData:GetBuyGets(), OnPayFunc)
            return true
        end
    end
    return false
end

function OnPayFunc(count)
    if sectionData then
        PlayerProto:BuyArachnidCount(count, sectionData:GetID())
    end
end

function OnClickSure()
    RogueMapBattleMgr:SendToMove()
end

function OnClickClean()
    RogueMapBattleMgr:CleanMovePaths()
end

function OnClickBack()
    RogueMapMgr:SendToQuit()
end

function OnClickQuit()
    local dialogData = {}
    dialogData.content = isPass and LanguageMgr:GetTips(50004) or LanguageMgr:GetTips(50003)
    dialogData.okCallBack = function()
        RogueMapMgr:ApplyQuit()
    end
    CSAPI.OpenView("Dialog", dialogData)
end


function OnClickRequire()
    if isRequire then
        return
    end
    isRequire = true
    -- 消息超时提示
    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "rogueMap_require",
        time = 5000,
        timeOutCallBack = function()
            isRequire = false
            LanguageMgr:ShowTips(1008)
        end
    });
    FightProto:RogueMapOneSupport(PlayerClient:GetUid(), OnShowRequireView)
end

function OnShowRequireView()
    EventMgr.Dispatch(EventType.Net_Msg_Getted, "rogueMap_require")
    isRequire = false
    CSAPI.OpenView("RogueMapSup")
end

function OnClickTips()
    LanguageMgr:ShowTips(50005)
end

function OnClickBuff()
    local buffs = RogueMapMgr:GetBuffs() or {}
    if #buffs > 0 then
        CSAPI.OpenView("RogueMapBuff", buffs)
    end
    -- ShowTips("RogueMapBuffTips",buffs)
end

function OnClickLevel()
    ShowTips("RogueMapLevelTips")
end

------------------------------------tips------------------------------------
local currTips = nil
local tipsItems = {}
function ShowTips(prefabName, data)
    if currTips then
        CSAPI.SetGOActive(currTips.gameObject, false)
        currTips = nil
    end

    if battleGround ~= nil then
        battleGround.SetCtrlState(prefabName ~= nil and 99 or 0)
    end

    if prefabName then
        if tipsItems[prefabName] then
            CSAPI.SetGOActive(tipsItems[prefabName].gameObject, true)
            tipsItems[prefabName].Refresh(data)
            currTips = tipsItems[prefabName]
        else
            ResUtil:CreateUIGOAsync("RogueMapBattle/" .. prefabName,tipsParnet,function (go)
                tipsItems[prefabName] = ComUtil.GetLuaTable(go)
                tipsItems[prefabName].OnViewClose = OnTipsClose
                tipsItems[prefabName].Refresh(data)
                currTips = tipsItems[prefabName]
            end)
        end
    end
end

function IsTipsShow(prefabName)
   return currTips and currTips.gameObject.name == prefabName 
end

function OnTipsClose(item)
    if IsTipsShow("RogueMapTeamTips") then
        currGridId = nil
    end
    ShowTips()
end