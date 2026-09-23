local fillExpBar = nil
local expBar = nil
local layout = nil
local data = nil
local elseData = nil
local items = nil
local cardCount = 0
local stages = {}
local rewards = nil
local gridLayout = nil
local sliderTotal = nil

local soundIds = {} -- 声音id
local isSoundPlay = false

-- boss
local addDamage = 0
local damageTime = 0.5 -- 动效时间
local curDamage = 0
local targetDamage = 0

-- pvp
local fillExerBar = nil
local exerBar = nil
local currRankLv = 0
local isStartPvpExp = false

-- 扫荡
local isSweep = false
local isGlobalSweep = false
local sweepView = nil

-- buff
local isHasBuff = false

-- 模拟
local isDirll = false
local isBossDirll = false

-- anim
local isJumpToEnd = false
local actions = {}

local isMultTeam = false;
local hpSlider = nil;

function Awake()
    fillExpBar = ComUtil.GetCom(expSlider, "Slider")
    fillExerBar = ComUtil.GetCom(exerSlider, "Slider")
    hpSlider = ComUtil.GetCom(sliderHp, "Slider");

    expBar = ExpBar.New();
    exerBar = ExpBar.New();

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.Fight_Over_Reward, OnShowReward)
    eventMgr:AddListener(EventType.Equip_SetLock_Ret, OnLockRet)

    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/FightOver/FightOverGridItem", LayoutCallBack, true)

    local anims = ComUtil.GetComsInChildren(gameObject, "ActionBase")
    for i = 0, anims.Length - 1 do
        table.insert(actions, anims[i])
    end

    sliderTotal = ComUtil.GetCom(totalSlider, "Slider")
    CSAPI.SetText(txt_topDamage, LanguageMgr:GetByID(20022));
    InitPanel()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = rewards[index]
        lua.Refresh(_data)
    end
end

function OnViewClosed(viewKey)
    if viewKey == "RewardPanel" then
        CSAPI.SetGOActive(node, true)
        RefreshPanel()
    end
end

function OnShowReward(index)
    if isJumpToEnd then
        return
    end

    if index and index < cardCount then
        return
    end

    if isSweep and sweepView and not sweepView.IsAnimEnd() then -- 如果是扫荡先播放扫荡动效
        sweepView.PlayAnim()
        return
    end

    ShowRewardAnim() -- 奖励动效
end

function OnLockRet()
    layout:UpdateList()
end

function InitPanel()
    local topTrans = topObj.transform
    if topTrans.childCount > 0 then
        for i = 0, topTrans.childCount - 1 do
            CSAPI.SetGOActive(topTrans:GetChild(i).gameObject, false)
        end
    end
    CSAPI.SetGOActive(buttonObj, false)
end

function OnDestroy()
    eventMgr:ClearListener();

    ActivityMgr:CheckRedPointData(ActivityListType.Exchange)
end

function Update()
    if isJumpToEnd then
        return
    end

    if expBar then
        expBar:Update()
    end

    if exerBar then
        exerBar:Update()
    end

    UpdateBossDamage()
end

function Refresh(_data, _elseData)
    data = _data
    elseData = _elseData
    isSweep = elseData and elseData.isSweep
    isDirll = elseData and elseData.isDirll
    isBossDirll = elseData and elseData.isBossDirll
    isGlobalSweep = elseData and elseData.isGlobalSweep
    isMultTeam = elseData and elseData.isMultTeam
    if data then
        -- reward
        rewards = data.rewards or nil
        -- if DungeonMgr:CurrSectionIsMainLine() then -- 自动奖励
        --     DungeonMgr:AddAIFightRewards(rewards);
        -- end

        if IsCardShow(rewards) then -- 卡牌展示
            return
        end

        if rewards ~= nil and #rewards > 0 and TowerMgr:IsCurrTower() and not isSweep then -- 爬塔特殊显示
            CSAPI.SetGOActive(node, false)
            UIUtil:OpenReward({rewards}, {
                isTower = true
            });
        else
            RefreshPanel()
        end
    end
end

function RefreshPanel()
    sceneType = data.sceneType
    SetTitleIcon()
    SetPlayer()
    SetRewards()
    SetCards()
    if isSweep then
        SetSweepPanel()
    elseif isGlobalSweep then
        SetGlobalBossSweepPanel()
    elseif isMultTeam then
        SetMultTeam()
    elseif isDirll then
        SetDirllPanel()
    elseif isBossDirll then
        SetDirllBossPanel()
    elseif sceneType == SceneType.PVPMirror or IsPvpSceneType(sceneType) then
        SetPVPPanel()
    elseif sceneType == SceneType.BOSS then
        SetFiledBossPanel()
    elseif sceneType == SceneType.Rogue then
        SetRoguePanel()
    elseif sceneType == SceneType.RogueS then
        SetRogueSPanel()
    elseif sceneType == SceneType.GlobalBoss then
        SetGlobalBossPanel()
    elseif sceneType == SceneType.RogueT then
        SetRogueTPanel()
    elseif sceneType == SceneType.BuffBattle then
        SetBuffBattlePanel()
    elseif sceneType == SceneType.RogueMap or sceneType == SceneType.RogueMapSup then
        SetRogueMapPanel()
    elseif sceneType == SceneType.TowerDeep then
        SetTowerDeepPanel()
    elseif sceneType == SceneType.ChainFront then
        ShowTrials2Panel()
    elseif sceneType == SceneType.PeriodicBoss then
        ShowPeriodicBossPanel()
    elseif sceneType == SceneType.CrossBoss then
        ShowVirCatPanel()
    else
        SetPVEPanel()
    end
end

function SetTitleIcon()
    local imgName = "win"
    if elseData then
        if isSweep or isGlobalSweep then
            imgName = "sweep"
        elseif isMultTeam then
            imgName = "14_01"
        elseif isDirll then
            imgName = "dirll_win"
        elseif isBossDirll then
            imgName = "end"
        end
    end
    if sceneType == SceneType.PVE then -- 十二星宫
        local cfg = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
        if cfg then
            if cfg.type == eDuplicateType.StarPalace and TotalBattleMgr:IsFighting() then
                imgName = isDirll and "dirll_end" or "lose"
            elseif cfg.type == eDuplicateType.StoryActive and cfg.diff and cfg.diff == 4 then
                -- imgName = "dirll_end"
            end
        end
    elseif sceneType == SceneType.GlobalBoss or sceneType == SceneType.TowerDeep or sceneType == SceneType.ChainFront 
    or sceneType == SceneType.RogueMap or sceneType ==  SceneType.RogueMapSup then
        imgName = "end"
    elseif sceneType == SceneType.PVPMirror or IsPvpSceneType(sceneType)  then
        imgName = elseData.bIsWin and imgName or "lose"
    elseif sceneType == SceneType.RogueT then
        imgName = "32_01"
    end
    CSAPI.LoadImg(topImg, "UIs/FightOver/img_" .. imgName .. ".png", true, nil, true)
end

------------------------------------玩家------------------------------------
function SetPlayer()
    CSAPI.SetText(txtName, PlayerClient:GetName())

    -- 先配置好防止跳过没配置
    SetExp(0)

    FuncUtil:Call(function()
        if gameObject and not isJumpToEnd then
            SetExp(data.nPlayerExp)
        end
    end, nil, 1000)
end

-- 玩家升级动画效果
function SetExp(addExp)
    local maxLv = PlayerClient:GetMaxLv();
    if maxLv == PlayerClient:GetLv() then
        RefreshTextLv(maxLv)
        RefreshTextExp("MAX", "MAX")
        SetProgress(1)
    elseif (addExp <= 0) then
        local curExp = PlayerClient:GetExp()
        local maxExp = GetLvExp(PlayerClient:GetLv())
        RefreshTextLv(PlayerClient:GetLv())
        RefreshTextExp(curExp, maxExp)
        SetProgress(curExp / maxExp)
    else
        local oldLv = PlayerClient:GetLv()
        local oldExp = PlayerClient:GetExp() - addExp
        while oldExp < 0 do
            oldLv = oldLv - 1
            local cfg = Cfgs.CfgPlrUpgrade:GetByID(oldLv)
            if cfg then
                oldExp = cfg.nNextExp + oldExp
            end
        end
        local maxExp = GetLvExp(oldLv)
        RefreshTextLv(oldLv)
        RefreshTextExp(oldExp, maxExp)
        SetProgress(oldExp / maxExp)
        expBar:Begin(oldLv, oldExp, PlayerClient:GetLv(), PlayerClient:GetExp(), addExp, maxLv, SetProgress, GetLvExp,
            RefreshTextLv, RefreshTextExp);
    end
end

function RefreshTextLv(lv)
    local lvStr = LanguageMgr:GetByID(26020)
    CSAPI.SetText(txtLv, lvStr .. lv)
end

function RefreshTextExp(currExp, nextExp)
    CSAPI.SetText(txtExpPrograss, string.format("%s/%s", currExp, nextExp))
end

function GetLvExp(lv)
    local exp = 0
    local cfg = Cfgs.CfgPlrUpgrade:GetByID(lv);
    if cfg then
        exp = cfg.nNextExp;
    end
    return exp;
end

function SetProgress(val)
    fillExpBar.value = val
end
------------------------------------角色------------------------------------
function SetCards()
    local teams = {data.team}
    if not teams then
        LogError("没有队伍数据！")
        return
    end
    if sceneType == SceneType.PVE and IsTowerComplete() then -- 爬塔特殊处理
        teams = TeamMgr:GetFightTeam()
    elseif sceneType == SceneType.RogueMap and RogueMapMgr:IsDungeonOver() then -- 秘境探索副本完成
        teams = TeamMgr:GetFightTeam()
    end
    local cardSkinIDs = {}
    local hasAssit = false -- 有助战
    cardCount = 0
    items = items or {}
    local favors = GetFavors()
    for _, team in ipairs(teams) do
        for i = 1, 6 do
            local v = team:GetItemByIndex(i);
            if v ~= nil then
                if v.index == 6 then -- 有助战
                    hasAssit = true
                end
                local prefabs = "FightOver/FightOverCardItem";
                local parent = teamObj;
                ResUtil:CreateUIGOAsync(prefabs, parent, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.SetIndex(cardCount + 1)
                    local _exp = 0;
                    local _favor = favors and favors[v.cid] or 0;
                    if sceneType == SceneType.PVE or sceneType == SceneType.PVEBuild or isSweep then
                        _exp = data.exp[v.cid] or 0;
                    else
                        _exp = data.exp[1]
                    end
                    lua.Refresh(v, {
                        exp = _exp,
                        favor = _favor,
                        teamIndex = team:GetIndex(),
                        isDirll = isDirll
                    })
                    if isJumpToEnd then
                        lua.JumpToComplete()
                    else
                        lua.PlayStartAnim(1000 + ((cardCount % 5) * 100))
                    end
                    table.insert(items, lua)
                end)
                table.insert(cardSkinIDs, v:GetCard():GetSkinID())
                cardCount = cardCount + 1
            end
        end
    end

    local actionWH1 = ComUtil.GetCom(p1, "ActionWH")
    local actionWH2 = ComUtil.GetCom(p2, "ActionWH")
    if hasAssit and cardCount > 5 then
        CSAPI.SetRTSize(rewardNode, 875, 299)
        CSAPI.SetAnchor(p1, 68, 0)
        CSAPI.SetRTSize(teamObj, 920, 164)
        if actionWH1 then
            actionWH1.scaleW = 940
        end
        if actionWH2 then
            actionWH2.scaleW = 940
        end
    else
        -- 超过5个卡牌往上移
        CSAPI.SetAnchor(playerObj, 0, cardCount > 5 and 137 or 0)
    end

    if actionWH1 then
        actionWH1:Play()
    end
    if actionWH2 then
        actionWH2:Play()
    end

    local modelId = nil
    if g_FightMgr then -- 战斗后
        local mvpInfo = g_FightMgr:GetMvp(TeamUtil.myNetTeamId);
        modelId = mvpInfo and mvpInfo.model or nil
    end
    if modelId == nil and #cardSkinIDs > 0 then
        local index = CSAPI.RandomInt(1, #cardSkinIDs)
        modelId = cardSkinIDs[index]
    end
    SetRole(modelId)
end

function GetFavors()
    local favors = {}
    if data.favor then
        for k, v in ipairs(data.favor) do
            favors[v.id] = v.num
        end
    end
    return favors
end

-- 设置角色
function SetRole(_id)
    if (_id) then
        RoleTool.LoadImg(icon, _id, LoadImgType.Main) -- 立绘
        UIUtil:SetLiveBroadcast(icon)
        if (sceneType == SceneType.PVPMirror or IsPvpSceneType(sceneType)) and not elseData.bIsWin then -- pvp战斗失败不播放语音
            return
        end

        local cfgModel = Cfgs.character:GetByID(_id);
        if (cfgModel.s_mvp) then
            if (cfgModel.id == 8011001) then
                local soundId = cfgModel.s_mvp[PlayerClient:GetSex()]
                if (soundId) then
                    soundIds = {soundId}
                    -- CSAPI.PlayRandSound({soundId}, true);
                end
            else
                soundIds = cfgModel.s_mvp
                -- CSAPI.PlayRandSound(cfgModel.s_mvp, true);
            end
            FuncUtil:Call(function()
                if gameObject and not isJumpToEnd then
                    PlayRoleSound()
                end
            end, nil, 400)
        end
    end
end

-- 播放人物声音
function PlayRoleSound()
    if TotalBattleMgr:IsFighting() then
        return
    end
    if soundIds and #soundIds > 0 and not isSoundPlay then
        CSAPI.PlayRandSound(soundIds, true);
        isSoundPlay = true
    end
end

-- 角色动效
function IsCardAnimEnd()
    if items and #items > 0 then
        for i, v in ipairs(items) do
            if not v.IsAnimComplete() then
                return false
            end
        end
    end
    return true
end

-- 跳过动效
function CardAnimComplete()
    if items and #items > 0 then
        for i, v in ipairs(items) do
            if not v.IsAnimComplete() then
                v.JumpToComplete()
            end
        end
    end
end

------------------------------------物品------------------------------------
function IsCardShow(_rewards)
    local showList = {};
    if _rewards and #_rewards > 0 then
        for k, v in ipairs(_rewards) do
            if v.type == RandRewardType.CARD then
                local card = RoleMgr:GetData(v.c_id);
                if card == nil then
                    LogError("未获得卡牌数据：" .. v.c_id);
                elseif card:GetQuantity() < 2 then
                    table.insert(showList, {
                        id = v.c_id,
                        num = card:GetQuantity()
                    });
                elseif card:GetQuality() == CardQuality.SSR or card:GetQuality() == CardQuality.SR then
                    table.insert(showList, {
                        id = v.c_id,
                        num = card:GetQuantity()
                    });
                end
            elseif v.type == RandRewardType.ITEM then
                local cfg = Cfgs.ItemInfo:GetByID(v.id);
                if cfg.type == ITEM_TYPE.CARD and v.c_id then
                    local card = RoleMgr:GetData(v.c_id);
                    if card == nil then
                        LogError("未获得卡牌数据：" .. v.c_id);
                    elseif card:GetQuantity() < 2 then
                        table.insert(showList, {
                            id = v.c_id,
                            num = card:GetQuantity()
                        });
                    elseif card:GetQuality() == CardQuality.SSR or card:GetQuality() == CardQuality.SR then
                        table.insert(showList, {
                            id = v.c_id,
                            num = card:GetQuantity()
                        });
                    end
                end
            end
        end
        if showList and #showList >= 1 then
            CSAPI.SetGOActive(node, false)
            CSAPI.OpenView("CreateShowView", {showList}, 2, function(go)
                local lua = ComUtil.GetLuaTable(go);
                lua.SetShowRewardPanel(function()
                    CSAPI.SetGOActive(node, true)
                    RefreshPanel()
                    CSAPI.PlayBGM("Sys_Victory")
                end)
            end);
            return true
        end
    end
    return false
end

function SetRewards()
    if not rewards or #rewards < 1 then
        CSAPI.SetGOActive(rewardObj, false)
        return
    end

    rewards = RewardUtil.SetShrink(rewards)
    local chipExpInfo, hasExp = RewardUtil.CheckChipExpInfo(rewards);
    if chipExpInfo~=nil then
        FuncUtil:Call(function ()
            Tips.ShowEquipExpTips(chipExpInfo)
        end,nil,500)
    end
    layout:IEShowList(#rewards)
    CSAPI.SetGOActive(rewardObj, false)

    SetBuffs()

    -- --卡牌动效播放时间
    -- local cardTime = DungeonMgr:GetCurrDungeonType() == eDuplicateType.Teaching and 800 or 2400

    -- --延迟播放时间
    -- local delayTime =1000 + (((cardCount - 1) % 5) * 100) + cardTime + 200
    -- FuncUtil:Call(function()
    --     if gameObject then
    --         OnShowReward()
    --     end
    -- end, nil, delayTime)
end

function IsRewardAnimEnd()
    if rewards and #rewards > 0 then
        for i, v in ipairs(rewards) do
            local lua = layout:GetItemLua(i)
            if lua and not lua.IsAnimComplete() then
                return false
            end
        end
    end
    return true
end

function RewardAnimComplete()
    if rewards and #rewards > 0 then
        for i, v in ipairs(rewards) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.JumpToAnimComplete()
            end
        end
    end
end
------------------------------------rogue------------------------------------
function SetRogueSPanel()
    CSAPI.SetGOActive(rogueSObj1, true)
    local cfg = Cfgs.DungeonGroup:GetByID(elseData.group)
    CSAPI.SetText(txtRogueS1, cfg.name)
    CSAPI.SetText(txtRogueS2, "0" .. elseData.round)
    LanguageMgr:SetText(txtRogueS3, 50023, elseData.steps or 0)
    -- 
    local infos = DungeonUtil.GetStarInfo3(cfg.stars, elseData.star_data)
    targetItems = targetItems or {}
    ItemUtil.AddItems("FightTaskItem/RogueSTaskItem", targetItems, infos, rogueSVert)
    --
    local len = RogueSMgr:GetLen(elseData.group)
    CSAPI.SetGOActive(rogueSObj2, elseData.round < len)
end
-- 重新挑战
function OnClickRogueS1()
    FightClient:Clean()
    FightProto:EnterRogueSFight(elseData.round, CloseParent)
end
-- 下一轮
function OnClickRogueS2()
    FightClient:Clean()
    FightProto:EnterRogueSFight(elseData.round + 1, CloseParent)
end
function CloseParent()
    local _view = CSAPI.GetView("FightOverResult")
    if (_view) then
        local lua = ComUtil.GetLuaTable(_view)
        lua.view:Close()
    end
end

------------------------------------rogue------------------------------------
function SetRoguePanel()
    CSAPI.SetGOActive(rogueObj, true)
    local section = DungeonMgr:GetActivitySectionDatas(SectionActivityType.Rogue)
    local cfg = Cfgs.DungeonGroup:GetByID(elseData.group)
    CSAPI.SetText(txtRogue1, string.format("%s  %s", section[1]:GetName(), cfg.name))
    LanguageMgr:SetText(txtRogue2, 65010, elseData.steps or 0)
    -- buffs
    if (elseData.selectBuffs) then
        items2 = items2 or {}
        ItemUtil.AddItems("Rogue/RogueBuffSelectItem2", items2, elseData.selectBuffs, buffPoints, ItemSelectCB2)
    end
end
function ItemSelectCB2(item)
    CSAPI.OpenView("RogueBuffDetail")
end
------------------------------------主线/副本------------------------------------
function SetPVEPanel()
    local dungeonType = DungeonMgr:GetCurrDungeonType()
    local cfgDungeon = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    local isSpecial = cfgDungeon and cfgDungeon.diff and cfgDungeon.diff == 4
    if dungeonType == eDuplicateType.Tower then
        if DungeonMgr:IsCurrDungeonComplete() then
            CSAPI.SetGOActive(titleObj, true)
            CSAPI.SetGOActive(stepObj, true)
            CSAPI.SetGOActive(towerObj, true)
            SetTowerPanel()
        end
        return
    elseif dungeonType == eDuplicateType.NewTower or (cfgDungeon and dungeonType == eDuplicateType.EternalBattle) then
        CSAPI.SetGOActive(titleObj, dungeonType == eDuplicateType.NewTower)
        CSAPI.SetRTSize(bottomObj, 0, 447)
        CSAPI.SetGOActive(buttonObj, dungeonType == eDuplicateType.NewTower)
        CSAPI.SetGOActive(newTowerObj, true)
        CSAPI.SetGOActive(taskObj, true)
        SetNewTowerPanel()
        return
    elseif dungeonType == eDuplicateType.StarPalace then
        local isFight = TotalBattleMgr:IsFighting()
        CSAPI.SetGOActive(roundObj, true)
        CSAPI.SetGOActive(titleObj, not isFight)
        CSAPI.SetGOActive(damageObj, not isFight)
        CSAPI.SetGOActive(totalObj, isFight)
        SetTotalBattlePanel()
        return
    elseif dungeonType == eDuplicateType.StoryActive and isSpecial then
        CSAPI.SetGOActive(titleObj, true)
        CSAPI.SetGOActive(damageObj, true)
        SetPlotSpecialPanle()
        return
    elseif dungeonType == eDuplicateType.SkinPass then
        return        
    end

    local isDanger = cfgDungeon and cfgDungeon.diff and cfgDungeon.diff == 3
    CSAPI.SetGOActive(titleObj, true)
    CSAPI.SetGOActive(starObj, dungeonType ~= eDuplicateType.TaoFa and not isDanger)
    CSAPI.SetGOActive(taskObj, dungeonType ~= eDuplicateType.TaoFa and not isDanger)

    SetPVETitle()
    SetStarInfo()
    if dungeonType == eDuplicateType.BattleField then
        BattleFieldMgr:AddRewardCur(1)
    end

    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        if cfgDungeon then
            if cfgDungeon.id == 1001 then
                BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_01_FINISH)
            elseif cfgDungeon.id == 1002 then
                BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_02_FINISH)
            end
        end
    end
end

function SetPVETitle()
    local cfgDungeon = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    if cfgDungeon then
        local sectionData = DungeonMgr:GetSectionData(cfgDungeon.group)
        local sectionType = sectionData:GetSectionType()
        local str = ""
        if sectionType == SectionType.MainLine then
            local isHard = cfgDungeon.type == eDuplicateType.MainElite
            str = isHard and LanguageMgr:GetByID(15016) or LanguageMgr:GetByID(15015) .. "  "
            str = str .. LanguageMgr:GetByID(34005) .. " "
            str = cfgDungeon.chapterID and str .. cfgDungeon.chapterID or str
        elseif sectionType == SectionType.Activity then
            local diff = cfgDungeon.diff or 1
            if diff == 1 then
                str = cfgDungeon.name
            elseif diff == 2 then
                str = cfgDungeon.name .. " (" .. LanguageMgr:GetByID(15016) .. ")"
            else
                str = cfgDungeon.name .. " " .. LanguageMgr:GetByID(15127, " " .. cfgDungeon.chapterID)
            end
        else
            str = cfgDungeon.name
        end
        CSAPI.SetText(txtTitle, str)
    end
end

function SetStarInfo()
    local dungeonData = DungeonMgr:GetDungeonData(DungeonMgr:GetCurrId())
    local star = 0
    local completeInfo = nil
    if dungeonData and dungeonData.data then
        completeInfo = dungeonData:GetNGrade()
        star = dungeonData.data.star or 0
    end
    local starInfos = DungeonUtil.GetStarInfo2(DungeonMgr:GetCurrId(), completeInfo);
    for i = 1, 3 do
        -- star
        local go = starObj.transform:GetChild(i - 1).gameObject
        CSAPI.SetGOActive(go, star >= i)
        -- CSAPI.SetImgColor(go, 255, 255, 255, star < i and 178 or 255)

        -- task  
        local taskGO = taskObj.transform:GetChild(i - 1).gameObject
        if starInfos[i] then
            local img = ComUtil.GetComInChildren(taskGO, "Image")
            CSAPI.SetImgColor(img.gameObject, 255, 255, 255, starInfos[i].isComplete and 255 or 178)

            local text = ComUtil.GetComInChildren(taskGO, "Text")
            text.text = starInfos[i].tips
            local color = starInfos[i].isComplete and {255, 193, 70, 255} or {255, 255, 255, 255}
            CSAPI.SetTextColor(text.gameObject, color[1], color[2], color[3], color[4])
        else
            CSAPI.SetGOActive(taskGO, false)
        end
    end
end

------------------------------------爬塔------------------------------------
-- 设置塔副本界面
function SetTowerPanel()
    CSAPI.SetText(txtStep, BattleMgr:GetStepNum() .. "")

    local cfg = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    if cfg then
        CSAPI.SetText(txtTitle, cfg.name or "")

        local missionDatas = MissionMgr:GetActivityDatas(eTaskType.TmpDupTower, cfg.missionID)
        -- prograss
        local cur, max = GetTowerPrograss(missionDatas)
        if max > 0 then
            for i = 1, max do
                ShowPrograss(i, cur)
                ShowStage(i, missionDatas[i])
            end
        end
    else
        LogError("未找到配置表数据！ID:" .. DungeonMgr:GetCurrId())
    end
end

-- 获取塔副本任务进度
function GetTowerPrograss(missionDatas)
    local cur, max = 0, 0
    if missionDatas then
        max = #missionDatas
        for _, missData in ipairs(missionDatas) do
            if missData:IsFinish() then
                cur = cur + 1
            end
        end
    end
    return cur, max
end

-- 显示进度
function ShowPrograss(i, cur)
    if i == 1 then
        local color = i <= cur and {255, 183, 38, 255} or {255, 255, 255, 255}
        CSAPI.SetImgColor(pImg.gameObject, color[1], color[2], color[3], color[4])
        local fadeT = ComUtil.GetCom(pImg.gameObject, "ActionFadeT")
        fadeT:Play()
    else
        local go = CSAPI.CloneGO(pImg.gameObject)
        CSAPI.SetParent(go, pImgObj)

        local color = i <= cur and {255, 183, 38, 255} or {255, 255, 255, 255}
        CSAPI.SetImgColor(go, color[1], color[2], color[3], color[4])

        local fadeT = ComUtil.GetCom(go, "ActionFadeT")
        fadeT.delay = i * 100
        fadeT:Play()
    end
end

-- 显示阶段
function ShowStage(i, missionData)
    local text1, text2 = nil, nil
    local parentGO = nil
    if i == 1 then
        parentGO = stageItem.transform:GetChild(0).gameObject
        text1 = ComUtil.GetCom(parentGO.transform:GetChild(0).gameObject, "Text")
        text2 = ComUtil.GetCom(parentGO.transform:GetChild(1).gameObject, "Text")
    else
        local go = CSAPI.CloneGO(stageItem.gameObject)
        CSAPI.SetParent(go, stageObj)
        parentGO = go.transform:GetChild(0).gameObject
        text1 = ComUtil.GetCom(parentGO.transform:GetChild(0).gameObject, "Text")
        text2 = ComUtil.GetCom(parentGO.transform:GetChild(1).gameObject, "Text")
    end
    text1.text = LanguageMgr:GetByID(2008) .. i .. ":"
    text2.text = missionData:GetDesc()
    -- len
    local len = GLogicCheck:GetStringLen(text2.text)
    local count = math.modf(len / 23)
    CSAPI.SetRTSize(parentGO.transform.parent.gameObject, 665, 41 + 39 * count)
    -- color
    local isFinish = missionData:IsFinish()
    local color = isFinish and {255, 193, 70, 255} or {255, 255, 255, 255}
    CSAPI.SetTextColor(text1.gameObject, color[1], color[2], color[3], color[4])
    CSAPI.SetTextColor(text2.gameObject, color[1], color[2], color[3], color[4])
    -- anim
    local move = ComUtil.GetCom(parentGO, "ActionMoveByCurve")
    move.delay = (5 - i) * 100
    move:Play()

    local fade = ComUtil.GetCom(parentGO, "ActionFade")
    fade:Play(0, 1, 200, (5 - i) * 100)
end

-- 爬塔boss结算
function IsTowerComplete()
    local dungeonType = DungeonMgr:GetCurrDungeonType()
    return dungeonType == eDuplicateType.Tower and DungeonMgr:IsCurrDungeonComplete()
end

------------------------------------异构空间------------------------------------
function SetNewTowerPanel()
    local cfg = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    LanguageMgr:SetText(txtTowerPass, 49018, StringUtil:SetByColor(cfg.chapterID, "ffc146"))
    LanguageMgr:SetText(txtTitle, 49008)
    -- CSAPI.SetGOAlpha(btnNext, cfg.lasChapterID ~= nil and 1 or 0.3)
    CSAPI.SetGOActive(btnNext, cfg.lasChapterID ~= nil)
    SetTargetInfo(cfg)
end

function SetTargetInfo(cfg)
    for i = 1, 3 do
        local taskGO = taskObj.transform:GetChild(i - 1).gameObject
        CSAPI.SetGOActive(taskGO, false)
    end
    if cfg and cfg.teamLimted then
        local teamCond = TeamCondition.New()
        teamCond:Init(cfg.teamLimted)
        local list = teamCond:GetDesc()
        if cfg.tacticsSwitch then
            table.insert(list, LanguageMgr:GetByID(49028))
        end
        if list and #list > 0 then
            for i, v in ipairs(list) do
                local taskGO = taskObj.transform:GetChild(i - 1).gameObject
                if taskGO == nil then
                    taskGO = CSAPI.CloneGO(taskObj.transform:GetChild(0).gameObject)
                else
                    CSAPI.SetGOActive(taskGO, true)
                end

                local img = ComUtil.GetComInChildren(taskGO, "Image")
                CSAPI.LoadImg(img.gameObject, "UIs/FightOver/img_17_01.png", true, nil, true)

                local text = ComUtil.GetComInChildren(taskGO, "Text")
                text.text = v
            end
        end
    end
end

function OnClickNext()
    CleanTeamData()
    UIUtil:AddFightTeamState(2, "FightOverResult:ApplyQuit()")
    DungeonMgr:Quit(false, 7)
end

function CleanTeamData()
    FightClient:Clean()
    FriendMgr:ClearAssistData();
    TeamMgr:ClearAssistTeamIndex();
    TeamMgr:ClearFightTeamData();
end
------------------------------------十二星宫------------------------------------
function SetTotalBattlePanel()
    -- round
    local turn = data.bIsWin and FightClient:GetTurn() + 1 or FightClient:GetTurn()
    CSAPI.SetText(txtRound, turn .. "")
    local cfg = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    if not TotalBattleMgr:IsFighting() then
        -- title
        LanguageMgr:SetText(txtTitle, 25036)
        -- score
        if cfg then
            local cur, max = TotalBattleMgr:GetScore(cfg.group, cfg.id)
            CSAPI.SetGOActive(txt_topDamage, cur >= max)
            CSAPI.SetText(txtDamage, cur .. "")
        end
    else
        if cfg then
            CSAPI.SetText(txtTotalName, cfg.name)
            local max = cfg.hp or 1
            local cur = TotalBattleMgr:GetFightBossHp()
            sliderTotal.value = cur / max
            CSAPI.SetText(txtTotalNum, cur .. "/" .. max)
        end
    end
end
------------------------------------钓鱼佬------------------------------------
function SetPlotSpecialPanle()
    local turn = data.bIsWin and FightClient:GetTurn() + 1 or FightClient:GetTurn()
    CSAPI.SetText(txtRound, turn .. "")
    -- title
    LanguageMgr:SetText(txtTitle, 25036)
    local score = FightClient:GetTotalDamage() or 0
    CSAPI.SetText(txtDamage, score .. "")
    local maxScore = data.totalDamage or 0
    CSAPI.SetGOActive(txt_topDamage, score >= maxScore)
end
------------------------------------军演------------------------------------
function SetPVPPanel()
    -- CSAPI.SetGOActive(roundObj, true)

    -- -- round
    -- CSAPI.SetText(txtRound, FightClient:GetTurn() .. "")
    -- CSAPI.SetGOActive(btnPVPDetail, IsPvpSceneType(sceneType))
    if IsPvpSceneType(sceneType) and elseData.type == RealArmyType.Friend then
        return
    end
    pvpData = {}
    if(IsPvpSceneType(sceneType))then 
        --自由匹配
        pvpData.dwIcon = ExerciseRMgr:GetDwIcon()
        pvpData.rank = ExerciseRMgr:GetRank()
        pvpData.isRankUP = ExerciseRMgr:IsRankUp()
        pvpData.rankLv = ExerciseRMgr:GetRankLevel()
        pvpData.score = ExerciseRMgr:GetScore()
        pvpData.cfg = "CfgPvpRankLevel"
    else 
        --军演
        pvpData.dwIcon = ExerciseMgr:GetDwIcon()
        pvpData.rank = ExerciseMgr:GetRank()
        pvpData.isRankUP = ExerciseMgr:IsRankUp()
        pvpData.rankLv = ExerciseMgr:GetRankLevel()
        pvpData.score = ExerciseMgr:GetScore()
        pvpData.cfg = "CfgPracticeRankLevel"
    end
    CSAPI.SetGOActive(exerObj, true)
    CSAPI.SetGOActive(pvpEffect, false)

    -- icon
    local iconName = pvpData.dwIcon
    if iconName and iconName ~= "" then
        ResUtil.ExerciseGrade:Load(exerIcon, iconName, true)
    end

    local rankStr = pvpData.rank > 0 and pvpData.rank or "--"
    CSAPI.SetText(txtRank2, LanguageMgr:GetByID(33000) .. ":" .. rankStr)
    CSAPI.SetGOActive(rankUp, pvpData.isRankUP)

    FuncUtil:Call(function()
        if gameObject and not isJumpToEnd then
            isStartPvpExp = true
            SetPVPScore(data.jf)
        end
    end, nil, 300)
end

-- 军演升级动画效果
function SetPVPScore(addScore)
    local maxRankLv = GetMaxRankLv()
    if maxRankLv == pvpData.rankLv then
        RefreshTextRank(maxRankLv)
        RefreshTextScore(pvpData.score)
        SetPVPProgress(1)
    elseif (addScore <= 0) then
        local curScore = pvpData.score
        local maxScroe = GetMaxScore(pvpData.rankLv)
        RefreshTextRank(pvpData.rankLv)
        RefreshTextScore(curScore, maxScroe)
        SetPVPProgress(curScore / maxScroe)
    else
        local oldLv, oldScore = GetOldRankLvAndScore(addScore)
        currRankLv = oldLv
        local maxScore = GetMaxScore(oldLv)
        RefreshTextRank(oldLv)
        RefreshTextScore(oldScore, maxScore)
        SetPVPProgress(oldScore / maxScore)
        exerBar:Begin(oldLv, oldScore, pvpData.rankLv, pvpData.score, addScore, maxRankLv, SetPVPProgress, GetMaxScore,
            RefreshTextRank, RefreshTextScore);
    end
end

function RefreshTextRank(rankLv)
    local cfg = Cfgs[pvpData.cfg]:GetByID(rankLv)
    local name = cfg and cfg.name or ""
    if currRankLv > 0 and currRankLv ~= rankLv then
        currRankLv = rankLv
        CSAPI.SetText(txtRank1, name)
        -- 特效
        CSAPI.SetGOActive(pvpEffect, false)
        CSAPI.SetGOActive(pvpEffect, true)
    else
        CSAPI.SetText(txtRank1, name)
    end
end

function RefreshTextScore(currScore, nextScroe)
    if not nextScroe or nextScroe == "" then
        CSAPI.SetText(txtRankNum, currScore .. "")
    else
        CSAPI.SetText(txtRankNum, string.format("%s/%s", currScore, nextScroe))
    end
end

-- 获取段位所需积分
function GetMaxScore(rankLv)
    local score = 0
    local cfg = Cfgs[pvpData.cfg]:GetByID(rankLv)
    if cfg then
        score = cfg.nScore;
    end
    return score;
end

-- 获取最高段位
function GetMaxRankLv()
    local cfg = Cfgs[pvpData.cfg]:GetAll()
    local rankLv = 0
    if cfg then
        for k, v in pairs(cfg) do
            rankLv = rankLv < v.id and v.id or rankLv
        end
    end
    return rankLv
end

-- slider
function SetPVPProgress(val)
    fillExerBar.value = val
end

-- 获取未增加积分前的信息
function GetOldRankLvAndScore(scoreAdd)
    local lv = pvpData.rankLv
    local score = 0;
    local currentScore = pvpData.score;
    if currentScore >= scoreAdd then
        score = currentScore - scoreAdd;
    else
        scoreAdd = scoreAdd - currentScore;
        while (lv > 1) do
            lv = lv - 1;
            local maxExp = GetMaxScore(lv)
            if scoreAdd > maxExp then
                scoreAdd = scoreAdd - maxExp;
            else
                score = maxExp - scoreAdd;
                break
            end
        end
    end
    return lv, score;
end

------------------------------------战场boss------------------------------------
function SetFiledBossPanel()
    BattleFieldMgr:AddBossChangeCount(1)

    CSAPI.SetGOActive(roundObj, true)
    CSAPI.SetGOActive(titleObj, true)
    CSAPI.SetGOActive(damageObj, true)

    LanguageMgr:SetText(txtTitle, 25036)

    CSAPI.SetText(txtRound, FightClient:GetTurn() + 1 .. "")

    targetDamage = data.damage or 0
    addDamage = math.floor(targetDamage / damageTime * Time.deltaTime)
    curDamage = 0

    CSAPI.SetText(txtDamage, curDamage .. "")
    CSAPI.SetGOActive(txt_topDamage, false)
end

function UpdateBossDamage()
    if curDamage >= targetDamage then
        return
    end

    curDamage = curDamage + addDamage

    if curDamage >= targetDamage then
        curDamage = targetDamage
        CSAPI.SetGOActive(txt_topDamage, data.hDamage and targetDamage >= data.hDamage)
    end

    CSAPI.SetText(txtDamage, curDamage .. "")
end
----------------------------------能力测验--------------------------------------
function SetRogueTPanel()
    CSAPI.SetGOActive(damageObj, true)
    CSAPI.SetGOActive(txt_topDamage, false)
    CSAPI.SetGOActive(titleObj, true)
    local lanID, num = 54050, elseData.score or 0
    if (RogueTMgr:IsInfinity(elseData.nDuplicateID)) then
        lanID = 54051
        num = elseData.damage or 0
    end
    CSAPI.SetText(txtDamage, num .. "")
    LanguageMgr:SetText(txtTitle, lanID)
end

----------------------------------世界boss--------------------------------------
function SetGlobalBossPanel()
    CSAPI.SetGOActive(roundObj, true)
    CSAPI.SetGOActive(titleObj, true)
    CSAPI.SetGOActive(damageObj, true)
    local turn = data.bIsWin and FightClient:GetTurn() + 1 or FightClient:GetTurn()
    CSAPI.SetText(txtRound, turn .. "")
    -- title
    LanguageMgr:SetText(txtTitle, 25036)
    local score = data.damage or 0
    CSAPI.SetText(txtDamage, score .. "")
    local maxScore = data.hDamage or 0
    CSAPI.SetGOActive(txt_topDamage, score > 0 and score >= maxScore)
end

function SetGlobalBossSweepPanel()
    CSAPI.SetGOActive(titleObj, true)
    CSAPI.SetGOActive(damageObj, true)
    -- title
    LanguageMgr:SetText(txtTitle, 25036)
    local maxScore = data.hDamage or 0
    CSAPI.SetText(txtDamage, maxScore .. "")
    CSAPI.SetGOActive(txt_topDamage, false)
end
----------------------------------积分战斗--------------------------------------
function SetBuffBattlePanel()
    local cfgDungeon = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    local sectionData = DungeonMgr:GetSectionData(cfgDungeon and cfgDungeon.group)
    if sectionData and sectionData:GetType() == SectionActivityType.Trials then
        -- score
        CSAPI.SetGOActive(damageObj, true)
        CSAPI.SetText(txtDamage, TrialsMgr:GetTrialsFightOverSocre(cfgDungeon.id) .. "")
        -- LanguageMgr:SetText(txt_topDamage, 130020)
        CSAPI.SetGOActive(txt_topDamage, false)
        -- title
        CSAPI.SetGOActive(titleObj, true)
        CSAPI.SetText(txtTitle, cfgDungeon and cfgDungeon.name or "")
        return
    end
    BuffBattleMgr:ClearIDs()
    CSAPI.SetGOActive(titleObj, true)
    CSAPI.SetText(txtTitle, cfgDungeon and cfgDungeon.name or "")
end
------------------------------------扫荡------------------------------------
function SetSweepPanel()
    CSAPI.SetGOActive(roleParent, false)
    CSAPI.SetGOActive(sweepObj, true)
    CSAPI.SetGOActive(txt_sweep1, false)
    SetSweepTitle()
    ResUtil:CreateUIGOAsync("FightOver/FightOverSweep", sweepObj, function(go)
        local lua = ComUtil.GetLuaTable(go)
        lua.Refresh(elseData)
        sweepView = lua
    end)
    EventMgr.Dispatch(EventType.Sweep_Close_Panel)
end

function SweepAnimComplete()
    if sweepView and not sweepView.IsAnimEnd() then
        sweepView.JumpToAnimEnd()
    end
end

function SetSweepTitle()
    local cfgDungeon = Cfgs.MainLine:GetByID(elseData.id)
    if cfgDungeon then
        local str1 = LanguageMgr:GetByID(34005) .. " "
        str1 = cfgDungeon.chapterID and str1 .. cfgDungeon.chapterID or str1
        CSAPI.SetText(txtMopUpLv1, str1)

        local isHard = false
        if cfgDungeon.type == eDuplicateType.MainElite or cfgDungeon.type == eDuplicateType.MainNormal then
            isHard = cfgDungeon.type == eDuplicateType.MainElite
        else
            isHard = cfgDungeon.diff == 2
        end
        local str2 = isHard and LanguageMgr:GetByID(15016) or LanguageMgr:GetByID(15015)
        str2 = StringUtil:SetByColor(str2, isHard and "FF7781" or "FFFFFF")
        str2 = cfgDungeon.type == eDuplicateType.StarPalace and "" or str2
        CSAPI.SetText(txtMopUpLv2, str2)
    end
end
------------------------------------模拟------------------------------------

function SetDirllPanel()
    local cfg = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    if cfg then
        if cfg.type == eDuplicateType.NewTower or cfg.type == eDuplicateType.EternalBattle then
            CSAPI.SetGOActive(newTowerObj, true)
            CSAPI.SetGOActive(titleObj, true)
            CSAPI.SetGOActive(taskObj, cfg.type == eDuplicateType.NewTower)
            LanguageMgr:SetText(txtTowerPass, 49018, StringUtil:SetByColor(cfg.chapterID, "ffc146"))
            LanguageMgr:SetText(txtTitle, 49008)
            SetTargetInfo(cfg)
        elseif cfg.type == eDuplicateType.StarPalace then
            CSAPI.SetGOActive(roundObj, true)
            -- round
            local turn = data.bIsWin and FightClient:GetTurn() + 1 or FightClient:GetTurn()
            CSAPI.SetText(txtRound, turn .. "")
        end
    end
end

function SetDirllBossPanel()
    CSAPI.SetGOActive(roundObj, true)
    CSAPI.SetGOActive(titleObj, true)
    CSAPI.SetGOActive(damageObj, true)
    local turn = data.bIsWin and FightClient:GetTurn() + 1 or FightClient:GetTurn()
    CSAPI.SetText(txtRound, turn .. "")
    -- title
    LanguageMgr:SetText(txtTitle, 25036)
    local score = data.damage or 0
    CSAPI.SetText(txtDamage, score .. "")
    -- local maxScore = data.hDamage or 0
    CSAPI.SetGOActive(txt_topDamage, false)
end
------------------------------------秘境探索------------------------------------
function SetRogueMapPanel()
    if sceneType == SceneType.RogueMapSup or RogueMapMgr:IsDungeonOver() then
        return
    end

    if data.nExp then
        local oldLv = RogueMapMgr:GetFightLv() or 1
        local newLv, str = RogueMapMgr:GetNewLv(data.nExp)
        CSAPI.SetGOActive(rogueMapObj, oldLv < newLv)
        if oldLv < newLv then
            CSAPI.SetText(txtRogueMapLv1, "Lv." .. oldLv)
            CSAPI.SetText(txtRogueMapLv2, "Lv." .. newLv)
            CSAPI.SetText(txtRogueMapDesc, str or "")
        end
    end
end

------------------------------------递归沙盒------------------------------------
function SetMultTeam()
    CSAPI.SetGOActive(titleObj, true)
    CSAPI.SetGOActive(damageObj, true)
    CSAPI.SetGOActive(hpObj, true)
    -- title
    LanguageMgr:SetText(txtTitle, 77017)
    local score = data and data.score or 0
    CSAPI.SetText(txtDamage, score .. "")
    -- 模拟战才显示
    if elseData and elseData.isDirll == true then
        CSAPI.SetText(txt_topDamage, LanguageMgr:GetByID(77018));
        CSAPI.SetGOActive(txt_topDamage, true)
    else
        CSAPI.SetGOActive(txt_topDamage, false)
    end
    -- 设置boss血量
    local cfg = Cfgs.MainLine:GetByID(data and data.id);
    local maxHp = 0;
    local hp = 0;
    local mCfg = nil;
    local lv = 0;
    if cfg and cfg.enemyPreview then
        mCfg = Cfgs.MonsterData:GetByID(cfg.enemyPreview[1]);
        if mCfg then
            lv = tostring(mCfg.level);
        end
    end
    if data and data.dupData then
        local bossInfo = nil;
        for k, v in ipairs(data.dupData) do
            if v.dupId == data.id then
                bossInfo = v;
                break
            end
        end
        if bossInfo then
            maxHp = bossInfo.totalMaxHp or 0;
            hp = bossInfo.totalHp or 0;
        end
    end
    CSAPI.SetText(txtMaxHp, "/" .. maxHp)
    CSAPI.SetText(txtHp, "" .. hp)
    CSAPI.SetGOActive(sliderImg, hp > 0)

    local percent = maxHp > 0 and hp / maxHp or 0
    hpSlider.value = percent
    local p = math.floor(percent * 10000)
    if p <= 0 and hp > 0 then
        p = 1
    end
    CSAPI.SetText(txtHPPercent, string.format("%.2f", p / 100) .. "%")
    CSAPI.SetText(txtHPLv, tostring(lv))
end

------------------------------------深塔计划------------------------------------
function SetTowerDeepPanel()
    -- score
    CSAPI.SetGOActive(damageObj, true)
    CSAPI.SetText(txtDamage, elseData.score .. "")
    LanguageMgr:SetText(txt_topDamage, 130020)
    CSAPI.SetGOActive(txt_topDamage, elseData.maxScore and elseData.maxScore > 0 and elseData.maxScore <= elseData.score)
    -- title
    CSAPI.SetGOActive(titleObj, true)
    LanguageMgr:SetText(txtTitle, 130019)
    -- bottom
    local len = RogueSMgr:GetLen(elseData.group)
    CSAPI.SetGOActive(towerDeepObj, elseData.round < len and elseData and elseData.bIsWin)
end

-- 重新挑战
function OnClickTowerDeep1()
    TryAgain()
end
-- 下一轮
function OnClickTowerDeep2()
    TryNext()
end

function TryAgain()
    if sceneType == SceneType.TowerDeep then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetByID(130033)
        dialogData.okCallBack = function()
            FightClient:Clean()
            FightProto:EnterTowerDeepFight(elseData.round, CloseParent)
        end
        CSAPI.OpenView("Dialog", dialogData)
    elseif sceneType == SceneType.ChainFront then
        CleanTeamData()
        DungeonMgr:Quit(false,7);
    end
end

function TryNext()
    FightClient:Clean()
    if sceneType == SceneType.TowerDeep then
        FightProto:EnterTowerDeepFight(elseData.round + 1, CloseParent)
    elseif sceneType == SceneType.ChainFront then
        FightProto:EnterChainFrontFight(elseData.round + 1, CloseParent)
    end
end
------------------------------------连锁战线------------------------------------
function ShowTrials2Panel()
    -- score
    CSAPI.SetGOActive(damageObj, true)
    CSAPI.SetText(txtDamage, elseData.score .. "")
    LanguageMgr:SetText(txt_topDamage, 130020)
    CSAPI.SetGOActive(txt_topDamage, elseData.maxScore and elseData.maxScore > 0 and elseData.maxScore <= elseData.score)
    -- title
    CSAPI.SetGOActive(titleObj, true)
    LanguageMgr:SetText(txtTitle, 130019)
    -- bottom
    -- CSAPI.SetGOActive(towerDeepObj,true)
    local len = TrialsMgr:GetLen(elseData.group)
    CSAPI.SetGOActive(towerDeepObj, elseData.round < len and elseData and elseData.bIsWin)
    LanguageMgr:SetText(txt_towerDeep1.gameObject, 37089)

    -- CSAPI.SetGOActive(btnTowerDeep1, false)
    -- CSAPI.SetAnchor(btnTowerDeep2,409,10)
end
------------------------------------周期boss------------------------------------
function ShowPeriodicBossPanel()
    CSAPI.SetGOActive(roundObj,true)
    local turn = data.bIsWin and FightClient:GetTurn() + 1 or FightClient:GetTurn()
    CSAPI.SetText(txtRound, turn .. "")
    CSAPI.SetGOActive(titleObj,true)
    LanguageMgr:SetText(txtTitle,25036)
    CSAPI.SetGOActive(damageObj,true)
    CSAPI.SetText(txt_topDamage, "")
    CSAPI.SetText(txtDamage,"" .. elseData.damage)
    CSAPI.SetGOActive(newRecordObj,tonumber(elseData.damage) > tonumber(elseData.maxDamage))
end
------------------------------------虚数天灾------------------------------------
function ShowVirCatPanel()
    CSAPI.SetGOActive(titleObj,true)
    LanguageMgr:SetText(txtTitle,elseData.isSimulated and 380082 or 380076)
    CSAPI.SetGOActive(damageObj,not elseData.isSimulated)
    if not elseData.isSimulated then
        CSAPI.SetText(txt_topDamage, "")
        CSAPI.SetText(txtDamage,"" .. elseData.damage)
    end
end
------------------------------------加成------------------------------------
function SetBuffs()
    isHasBuff = false
    local lifeBuffs = PlayerClient:GetLifeBuff()
    if lifeBuffs then
        for i, v in ipairs(lifeBuffs) do
            if v.id == 4 or v.id == 9 or v.id == 14 then
                isHasBuff = true
                break
            end
        end
    end

    -- 经验和金钱副本才会显示玩家能力加成
    local dungeonType = DungeonMgr:GetCurrDungeonType()
    if dungeonType == eDuplicateType.Exp or dungeonType == eDuplicateType.Gold then
        local abilityBuffs = PlayerAbilityMgr:GetFightOverBuff()
        if abilityBuffs and not isHasBuff then
            isHasBuff = #abilityBuffs > 0
        end
    end
    CSAPI.SetGOActive(btnBuff, isHasBuff)
end

function OnClickBuff()
    if isHasBuff then
        CSAPI.OpenView("FightOverBuff", {
            type = 1,
            id = DungeonMgr:GetCurrId()
        })
    end
end

------------------------------------anim------------------------------------

function ShowRewardAnim()
    CSAPI.SetGOActive(rewardObj, rewards and #rewards > 0)
    if rewards and #rewards > 0 then
        for i, v in ipairs(rewards) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.PlayStartAnim((i - 1) * 100)
            end
        end
    end
end

-- 动效结束
function IsAnimEnd()
    return IsRewardAnimEnd() and IsCardAnimEnd()
end

-- 跳过动效
function JumpToAnimEnd()
    CSAPI.SetGOActive(rewardObj, rewards and #rewards > 0)

    CSAPI.SetGOActive(topImgEffect, false)

    -- sound
    PlayRoleSound()

    -- exp
    if expBar.isRun then
        expBar.isRun = false
        SetExp(0)
    end

    -- card
    CardAnimComplete()

    -- rewards
    RewardAnimComplete()

    if isSweep then
        SweepAnimComplete()
    elseif sceneType == SceneType.PVPMirror then
        CSAPI.SetGOActive(pvpEffect, false)
        SetPVPScore(0)
    elseif sceneType == SceneType.BOSS then
        CSAPI.SetGOActive(topDamageEffect, false)
        curDamage = targetDamage
        CSAPI.SetText(txtDamage, curDamage .. "")
        CSAPI.SetGOActive(txt_topDamage, data.hDamage and targetDamage >= data.hDamage)
    end

    if #actions > 0 then -- 动效跳过
        for i, v in ipairs(actions) do
            if v.gameObject.activeSelf == true then
                v:SetComplete(true)
            end
        end
    end

    isJumpToEnd = true
end

function OnClickPVPDetail()
    CSAPI.OpenView("ExerciseRDetail")
end
