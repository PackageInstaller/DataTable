---@class SeaMapPanel : SeaMapPanel_Generate
---##################### 【SeaMapPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SeaMapPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SeaMapPanel = require "SeaMapPanel_Generate"

function SeaMapPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.FunctionOpenMapUpdate, self.__CheckFunctionOpen},
        {GameMsgType.RedPointRefresh, function()
            self:refreshRed()
        end},
        {GameMsgType.ChapterRewardGet, function()
            self:RefreshAllChapterRed()
        end},
        {GameMsgType.RefreshMainPanel, function()
            self:RefreshAllChapterPointsState()
        end},
	}
    self.CanClick = true
    self.MapList = {}            --map列表
    self.AllMapObjList = {}         --所有map预制体列表
    self.NowMapObj = nil           --当前map预制体
    self.NowMapIndex = 1           --当前mapIndex
    self.NewObj = nil               --即将切换过去的新map
    self.nowSelectPoint = nil       --当前选中节点的id
    self.pointSeedObjList = {}
    self.nowDifficulty = 1        --当前难度模式 1 普通 2 困难
    self.CanClick = true

    self.nowMapPanel = nil              --当前map所在的mapPanel

    self.nowSelectMode = nil          --当前界面模式
    self.ToggleOn = UnityEngine.PlayerPrefs.GetInt("TaskToggleState")               --是否默认收起
    self.nowToggle = false          -- 当前toggle状态
    self.initFinish = false
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.autoJumpTimer = nil        -- 自动跳转定时器

    self:SetUpdateInterval(0)

    self.effect_Ui_StoryHard_1:SetActive(false)
    self.effect_Ui_StoryHard_2:SetActive(false)
end

--function SeaMapPanel:StartCreating(time)
--
--end

--function SeaMapPanel:StartEnter(time)
--
--end

--function SeaMapPanel:StartRemoving(time)
--
--end

--function SeaMapPanel:StartExit(time)
--
--end

--@param {
--     targetMapIndex = int    目标跳转地图id
--     targetToggleIndex
-- }

function SeaMapPanel:OnOpen(data, initiative)
    UIMgr.uiCamera.orthographic = self.nowSelectMode == GE.SeaMapToggleType.residentStory
    --UIMgr:popUI("SeaMapScenesPanel", {})
    if initiative then
        --导航栏
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.SeaMapPanel, self)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            LoadingMgr:SetUISwitchStart(function()
                UIMgr:closeSpecificUI(self, nil, function ()
                    LoadingMgr:SetUISwitchOver()
                end)
            end)
            -- self.customBackPanel.customBackPanel:ClearBackFunc()
        end)
    end
    -- LuaLogger.ds("SeaMapPanel:OnOpen", tablex.dump(data))
    self:__CheckFunctionOpen()
    self:showExtraRewards()

    if tablex.size(self.pointSeedObjList) > 0 then
        GuideMgr:StartGuideTrigger("SeaMapPanel")
    end
    self:refreshRed()

    
end

--function SeaMapPanel:OnClose(initiative)
--
--end

function SeaMapPanel:OnDestroy()
	--self.super:OnDestroy(self)
    if self.simulatedCountDownTimer then
        DLuaTimer:RemoveTimer(self.simulatedCountDownTimer)
    end
    if self.weeklyBossCountDownTimer then
        DLuaTimer:RemoveTimer(self.weeklyBossCountDownTimer)
    end
    if self.autoJumpTimer then
        DLuaTimer:RemoveTimer(self.autoJumpTimer)
        self.autoJumpTimer = nil
    end
    self.super:OnDestroy(self)
end

function SeaMapPanel:__CheckFunctionOpen()
    --常规清缴开放判断
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.RegularClearance)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.nomalLevelBtn.lock,
        entryObj = self.nomalLevelBtn,
        newObj = self.nomalLevelBtn.isNew,
        showNew = true,
        lockShowType = lockShowType,
        state = state
    })
    --活动页签开放判断
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.PeriodicEvent)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.acitiveLevelBtn.lock,
        entryObj = self.acitiveLevelBtn,
        newObj = self.acitiveLevelBtn.isNew,
        showNew = true,
        lockShowType = lockShowType,
        state = state
    })
    --经验材料开放判断
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.ExperienceMaterial)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.exptBtn.lock,
        entryObj = self.exptBtn,
        newObj = self.exptBtn.isNew,
        showNew = true,
        lockShowType = lockShowType,
        state = state
    })
    self.exptBtn.lockMsgTxt.text.text = tips or ""
    self.exptBtn.lock:SetActive(state == GE.FunctionOpenState.Lock)
    self.exptBtn.openState:SetActive(state ~= GE.FunctionOpenState.Lock)
    self.exptBtn.arrow:SetActive(state ~= GE.FunctionOpenState.Lock)

    --科技材料开放判断
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.TechTreeMaterial)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.techBtn.lock,
        entryObj = self.techBtn,
        newObj = self.techBtn.isNew,
        showNew = true,
        lockShowType = lockShowType,
        state = state
    })
    self.techBtn.lockMsgTxt.text.text = tips or ""
    self.techBtn.lock:SetActive(state == GE.FunctionOpenState.Lock)
    self.techBtn.openState:SetActive(state ~= GE.FunctionOpenState.Lock)
    self.techBtn.arrow:SetActive(state ~= GE.FunctionOpenState.Lock)

    --天赋材料开放判断
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.TalentTreeMaterial)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.talentBtn.lock,
        entryObj = self.talentBtn,
        newObj = self.talentBtn.isNew,
        showNew = true,
        lockShowType = lockShowType,
        state = state
    })
    self.talentBtn.lockMsgTxt.text.text = tips or ""
    self.talentBtn.lock:SetActive(state == GE.FunctionOpenState.Lock)
    self.talentBtn.openState:SetActive(state ~= GE.FunctionOpenState.Lock)
    self.talentBtn.arrow:SetActive(state ~= GE.FunctionOpenState.Lock)

    --装备材料开放判断
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.EquipmentMaterial)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.equipBtn.lock,
        entryObj = self.equipBtn,
        newObj = self.equipBtn.isNew,
        showNew = true,
        lockShowType = lockShowType,
        state = state
    })
    self.equipBtn.lockMsgTxt.text.text = tips or ""
    self.equipBtn.lock:SetActive(state == GE.FunctionOpenState.Lock)
    self.equipBtn.openState:SetActive(state ~= GE.FunctionOpenState.Lock)
    self.equipBtn.arrow:SetActive(state ~= GE.FunctionOpenState.Lock)

    --模拟演习开放判断
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.SimulationDrill)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.activityLevel.weeklyActBtn.lock,
        entryObj = self.activityLevel.weeklyActBtn,
        newObj = self.activityLevel.weeklyActBtn.isNew,
        showNew = true,
        lockShowType = lockShowType,
        state = state
    })
    self.activityLevel.weeklyActBtn.lock:SetActive(state == GE.FunctionOpenState.Lock)
    self.activityLevel.weeklyActBtn.unlockMsg.text.text = tips or ""

    --危境攻坚开放判断
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.WeeklyBossChallenges)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.bossActBtn.lock,
        entryObj = self.bossActBtn,
        newObj = self.bossActBtn.isNew,
        showNew = true,
        lockShowType = lockShowType,
        state = state
    })
    self.bossActBtn.lock:SetActive(state == GE.FunctionOpenState.Lock)
    self.bossActBtn.unlockMsg.text.text = tips or ""
end

function SeaMapPanel:OnRefresh(data)
    if not self.initFinish then
        -- 首次刷新：SetViewInfo 内部使用 FillTemplateContent 异步创建地图、坐标格和章节节点，
        -- 所有对象就绪后才能执行模式设置和节点选中，因此通过 onComplete 回调链式完成初始化。
        -- 初始化期间直接 return，避免后续逻辑在对象未就绪时访问 nowMapPanel / mapChaterList 等字段。
        self:SetViewInfo(function()
            -- 章节节点已全部创建完毕，此后可安全刷新章节红点
            self.initFinish = true
            self:SetModeView(GE.SeaMapToggleType.mainStory)
            if self.ToggleOn == 1 then
                self.isOpenBtn.animation:Play("LoopOn")
                self.taskPanel.animator:SetTrigger("Off")
                self.nowToggle = false
            else
                self.isOpenBtn.animation:Play("LoopOff")
                self.taskPanel.animator:SetTrigger("On")
                self.nowToggle = true
            end
        end)
        return  -- 等待异步初始化完成，后续刷新逻辑在 onComplete 回调中执行
    end
    if data and data.mode then
        self:SetModeView(data.mode)
    end
    self:__CheckFunctionOpen()

    --材料关卡额外掉落判断及显示
    self:showExtraRewards()
    
    --自动跳转到指定材料本（只执行一次）
    if data and data.materialType then
        local materialType = data.materialType
        data.materialType = nil  -- 立即清空，防止重复执行
        self:AutoJumpToMaterialLevel(materialType)
    end
    self:JumpToLatestProgressMap()
    self:SetSelectPointInfo()

end

--设置模式显示 右下角Toggle
function SeaMapPanel:SetModeView(mode)
    if mode == self.nowSelectMode then
        UIMgr.uiCamera.orthographic = mode == GE.SeaMapToggleType.residentStory
        return
    end
    self.nowSelectMode = mode
    if self.nowSelectMode == GE.SeaMapToggleType.mainStory then
        self.NowMapObj:SetParent(self.nowMapPanel.mask.transform)
        self.level2001:SetParent(self.levelPool.transform)
        self.activityLevel:SetParent(self.levelPool.transform)
        self:getChangeBtnCanOpen()
    elseif self.nowSelectMode == GE.SeaMapToggleType.residentStory then
        self.NowMapObj:SetParent(self.mapPool.transform)
        self.level2001:SetParent(self.nowMapPanel.mask.transform)
        self.activityLevel:SetParent(self.levelPool.transform)
        self.lastBtn:SetActive(false)
        self.nextBtn:SetActive(false)
        --UIMgr:popUI("RegularLevelPanel",{})
    elseif self.nowSelectMode == GE.SeaMapToggleType.activityStory then
        self.NowMapObj:SetParent(self.mapPool.transform)
        self.level2001:SetParent(self.levelPool.transform)
        self.activityLevel:SetParent(self.nowMapPanel.mask.transform)
        self.lastBtn:SetActive(false)
        self.nextBtn:SetActive(false)
        self:setActiveCountdown()
        
    end
    self.difficultyBtn:SetActive(self.nowSelectMode == GE.SeaMapToggleType.mainStory)
    self.difficultyBtn.difficultyLockImg:SetActive((UICommonUtils.CheckFunctionOpen(1)) == GE.FunctionOpenState.Lock)

    self.difficultyBtn.storyMode.gameObject:SetActive((UICommonUtils.CheckFunctionOpen(1)) ~= GE.FunctionOpenState.Lock and self.nowDifficulty == 1)
    self.difficultyBtn.difficultMode.gameObject:SetActive((UICommonUtils.CheckFunctionOpen(1)) ~= GE.FunctionOpenState.Lock and self.nowDifficulty == 2)

    self.acitiveLevelBtn.typeIcon.canvasGroup.alpha = self.nowSelectMode == GE.SeaMapToggleType.activityStory and 1 or 0.3
    self.acitiveLevelBtn.txt.canvasGroup.alpha = self.nowSelectMode == GE.SeaMapToggleType.activityStory and 1 or 0.3
    self.nomalLevelBtn.typeIcon.canvasGroup.alpha = self.nowSelectMode == GE.SeaMapToggleType.residentStory and 1 or 0.3
    self.nomalLevelBtn.txt.canvasGroup.alpha = self.nowSelectMode == GE.SeaMapToggleType.residentStory and 1 or 0.3
    self.mainLevelBtn.typeIcon.canvasGroup.alpha = self.nowSelectMode == GE.SeaMapToggleType.mainStory and 1 or 0.3
    self.mainLevelBtn.txt.canvasGroup.alpha = self.nowSelectMode == GE.SeaMapToggleType.mainStory and 1 or 0.3
    self.nowLevelPanel:SetActive(self.nowSelectMode == GE.SeaMapToggleType.mainStory)
    self:__CheckFunctionOpen()
    self:refreshRed()
    UIMgr.uiCamera.orthographic = self.nowSelectMode == GE.SeaMapToggleType.residentStory
end

function SeaMapPanel:refreshRed()
    if self.acitiveLevelBtn.redPoint and UICommonUtils.Checkobj(self.acitiveLevelBtn.redPoint) then
        local showRed = self:canShowFunctionEntryRedPoint(GE.FunctionOpenModule.PeriodicEvent)
            and RedPointMgr:SeaMapPanelActivityLevelRedJudge()
        self.acitiveLevelBtn.redPoint:SetActive(showRed)
    end
    if self.bossActBtn.redPoint and UICommonUtils.Checkobj(self.bossActBtn.redPoint) then
        local showRed = self:canShowFunctionEntryRedPoint(GE.FunctionOpenModule.WeeklyBossChallenges)
            and RedPointMgr:SeaMapPanelBossActBtnRedJudge()
        self.bossActBtn.redPoint:SetActive(showRed)
    end
    -- RedPointRefresh 也需要同步刷新章节节点红点
    self:RefreshAllChapterRed()
end

---功能入口是否可显示红点（已解锁且未处于 New 标签展示状态）
---@param functionModule integer
---@return boolean
function SeaMapPanel:canShowFunctionEntryRedPoint(functionModule)
    local state = Me:getFunctionOpenStateById(functionModule)
    if state == GE.FunctionOpenState.Lock then
        return false
    end
    -- 与 FunctionOpenDis 一致：Open 且配置 isNew 时展示 New，不展示红点
    if state == GE.FunctionOpenState.Open then
        local cfg = Config.GetFunctionOpenInfo(functionModule)
        if cfg and cfg.isNew == 1 then
            return false
        end
    end
    return true
end

function SeaMapPanel:Update()
    if Input.GetKeyDown(KeyCode.LeftArrow) or Input.GetKeyDown(KeyCode.A) then
        self:MoveBtnOnClick(1)
    end
    if Input.GetKeyDown(KeyCode.RightArrow) or Input.GetKeyDown(KeyCode.D) then
        self:MoveBtnOnClick(2)
    end

    if Input.GetKeyDown(KeyCode.P) then
        self:PlayNewChapterAnima(2001, 2002)
    end
end

---判断指定地图页是否有可进入的困难章节
---@param mapIndex integer 地图索引
---@return boolean
function SeaMapPanel:getMapHasEnterableHardChapter(mapIndex)
    local mapData = self.MapList and self.MapList[mapIndex]
    if not mapData or not mapData.mapChaterList or not mapData.mapChaterList[2] then
        return false
    end
    for _, chapterInfo in pairs(mapData.mapChaterList[2]) do
        if chapterInfo.data and self:isChapterPointCanShowRed(chapterInfo.data) then
            return true
        end
    end
    return false
end

---切换当前难度
---@param mode integer 难度模式 1 普通 2 困难
function SeaMapPanel:ChangeNowDifficulty(mode, refresh)
    if self.CanClick == false then
        return
    end

    if self.nowDifficulty == mode and not refresh then
        return
    end
    self:JumpToLatestProgressMap()
    self:setNowDifficulty(mode)

    -- 切换困难模式时，若当前页无可进入的困难节点，跳转至最后一个有可进入困难节点的页
    if mode == 2 then
        if not self:getMapHasEnterableHardChapter(self.NowMapIndex) then
            local targetIndex = nil
            for i = tablex.size(self.MapList), 1, -1 do
                if self:getMapHasEnterableHardChapter(i) then
                    targetIndex = i
                    break
                end
            end
            if targetIndex then
                self:JumpToMapByIndex(targetIndex)
            end
        end
    end

    self.CanClick = false
    --按钮显示状态修改
    if self.nowDifficulty == 1 then
        self.difficultyBtn.imgPointer.animation:Play("ToStory")
        self.difficultyBtn.storyMode:SetActive(true)
        self.difficultyBtn.difficultMode.animation:Play("DiffOut")
        self.difficultyBtn.difficultMode.animOverCallBack:SetCallBack(function()
            self.difficultyBtn.difficultMode:SetActive(false)
            self.CanClick = true
        end)
    elseif self.nowDifficulty == 2 then
        self.difficultyBtn.imgPointer.animation:Play("ToDiff")
        self.difficultyBtn.difficultMode:SetActive(true)
        self.difficultyBtn.storyMode.animation:Play("StoryOut")
        self.difficultyBtn.storyMode.animOverCallBack:SetCallBack(function()
            self.difficultyBtn.storyMode:SetActive(false)
            self.CanClick = true
        end)  
    end
    self:ChangeNowDifficultyView()
    self:SetSelectPointInfo()
end

---切换当前难度视图
function SeaMapPanel:ChangeNowDifficultyView()
    local mode = self:getNowDifficulty()
    for _, mapObj in pairs(self.AllMapObjList) do
        mapObj.pointList:SetActive(mode == 1)
        mapObj.pointListDifficult:SetActive(mode == 2)
        mapObj.hardMode:SetActive(mode == 2)
    end
    self.nowLevelPanel.story:SetActive(mode == 1)
    self.nowLevelPanel.difficult:SetActive(mode == 2)
    
    --刷新难度按钮红点
    self:RefreshDifficultyBtnRed()
end

---设置当前难度
function SeaMapPanel:setNowDifficulty(mode)
    self.nowDifficulty = mode
end

---获取当前难度
function SeaMapPanel:getNowDifficulty()
    return self.nowDifficulty
end

---章节节点是否已显示且可进入（可显示章节红点）
---@param chapterData table
---@return boolean
function SeaMapPanel:isChapterPointCanShowRed(chapterData)
    if not chapterData then
        return false
    end
    return self:getChapterOpenByData(chapterData) and self:getChapterCanEnterByData(chapterData)
end

---刷新难度按钮红点显示
function SeaMapPanel:RefreshDifficultyBtnRed()
    if not self.difficultyBtn or not self.difficultyBtn.red then
        return
    end

    -- 展示时显示相反难度的红点信息：当前为普通(1)时检查困难(2)，反之亦然
    local displayMode = self:getNowDifficulty()
    local checkMode = (displayMode == 1) and 2 or 1
    local hasReward = RedPointMgr:DifficultModeRedJudge(checkMode)
    self.difficultyBtn.red:SetActive(hasReward)
end

---刷新所有章节红点显示
function SeaMapPanel:RefreshAllChapterRed()
    if not self.initFinish or not self.MapList then
        return
    end
    -- 刷新难度按钮红点
    self:RefreshDifficultyBtnRed()
    
    -- 刷新所有地图中所有章节的红点
    for _, mapInfo in pairs(self.MapList) do
        if mapInfo.mapChaterList then
            for mode = 1, 2 do
                if mapInfo.mapChaterList[mode] then
                    for _, chapterInfo in pairs(mapInfo.mapChaterList[mode]) do
                        if chapterInfo.obj and chapterInfo.data
                            and UICommonUtils.Checkobj(chapterInfo.obj)
                            and chapterInfo.obj.red and UICommonUtils.Checkobj(chapterInfo.obj.red) then
                            local hasReward = RedPointMgr:ChapterRewardRedJudge(chapterInfo.data.id)
                            local canShow = self:isChapterPointCanShowRed(chapterInfo.data)
                            chapterInfo.obj.red:SetActive(hasReward and canShow)
                            if chapterInfo.obj.redOut and UICommonUtils.Checkobj(chapterInfo.obj.redOut) then
                                chapterInfo.obj.redOut:SetActive(hasReward and canShow)
                            end
                        end
                    end
                end
            end
        end
    end
end

---刷新所有章节节点的开放状态（玩家升级后调用）
function SeaMapPanel:RefreshAllChapterPointsState()
    if not self.initFinish then
        return
    end
    for _, mapInfo in pairs(self.MapList) do
        if mapInfo.mapChaterList then
            for mode = 1, 2 do
                if mapInfo.mapChaterList[mode] then
                    for _, chapterInfo in pairs(mapInfo.mapChaterList[mode]) do
                        if chapterInfo.obj and chapterInfo.data then
                            self:RefreshChapterPointState(chapterInfo, mode)
                        end
                    end
                end
            end
        end
    end
    self:getChangeBtnCanOpen()
    self:SetSelectPointInfo()
end

---刷新单个章节节点的开放/可进入状态
---@param chapterInfo table mapChaterList中的单个节点信息
---@param mode integer 难度模式 1 普通 2 困难
function SeaMapPanel:RefreshChapterPointState(chapterInfo, mode)
    local pointObj = chapterInfo.obj
    local chapterData = chapterInfo.data

    local isOpen = self:getChapterOpenByData(chapterData)
    local canEnter = self:getChapterCanEnterByData(chapterData)

    pointObj:SetActive(isOpen)
    if not isOpen then
        return
    end

    pointObj.lockBg:SetActive(not canEnter)
    pointObj.chapterBg:SetActive(mode == 1 and canEnter)
    pointObj.chapterDiffBg:SetActive(mode == 2 and canEnter)
    pointObj.stateBg.story:SetActive(mode == 1 and canEnter)
    pointObj.stateBg.difficult:SetActive(mode == 2 and canEnter)
    pointObj.stateBg.lock:SetActive(not canEnter)
    pointObj.lockBtn:SetActive(not canEnter)
    pointObj.initBtn:SetActive(canEnter)

    if pointObj.red then
        local hasReward = RedPointMgr:ChapterRewardRedJudge(chapterData.id)
        pointObj.red:SetActive(hasReward and canEnter)
        if pointObj.redOut then
            pointObj.redOut:SetActive(hasReward and canEnter)
        end
    end

    -- canEnter可能变化，重新绑定按钮回调
    pointObj.btn.button.onClick:RemoveAllListeners()
    pointObj.btn.button.onClick:AddListener(function()
        self:play2DSound(self.btnSoundPath)
        self:DoSelectPointMove(chapterData.id, not canEnter)
    end)
    pointObj.initBtn.button.onClick:RemoveAllListeners()
    pointObj.initBtn.button.onClick:AddListener(function()
        self:play2DSound(self.btnSoundPath)
        self:DoSelectPointMove(chapterData.id, not canEnter)
    end)
end

--设置显示初始化
---@param onComplete function 所有对象异步创建完毕后的回调
function SeaMapPanel:SetViewInfo(onComplete)
    self:SetAnimCallBack()
    local Map = tablex.clone(Config.GetAllConfig("MapTable"))
    self.MapList = {}
    self.NowMapObj = {}
    for _, v in pairs(Map) do
        self.MapList[v.order] = v
    end

    -- FillTemplateContent 存在异步路径（池中对象不足时走 InstantiateAsync），
    -- 使用计数器在所有对象回调完成后统一执行初始化后续逻辑
    local totalMapCount = tablex.size(Map)
    local createdMapCount = 0
    self:FillTemplateContent(self.mapObj, self.mapPool, totalMapCount, function(index, mapObj)
        mapObj:SetActive(true)
        mapObj.name = self.MapList[index].resource
        --加背景图加载
        local path = string.format(Config.SpritePath.SeaMapBgImgPath, self.MapList[index].resource)
        mapObj.mapBg:SetActive(true)
        self:LoadSpriteAsync(path, mapObj.mapBg.image)
        self[self.MapList[index].resource] = mapObj
        self.AllMapObjList[self.MapList[index].resource] = mapObj

        createdMapCount = createdMapCount + 1
        if createdMapCount == totalMapCount then
            self.NowMapObj = self[self.MapList[self.NowMapIndex].resource]
            -- LuaLogger.ds("self.MapList", tablex.dump(self.MapList))
            self.NowMapObj:SetParent(self.mapPanel_M.mask.transform)
            self.nowMapPanel = self.mapPanel_M
            self.NowMapObj.transform.localPosition = Vector3.New(0, 0, 0)
            self.NowMapObj:SetActive(true)
            self.NowMapObj.mask:SetActive(false)

            self:getChangeBtnCanOpen()

            --将difficultyBtn放置到当前地图的HardPoint下
            if self.NowMapObj.HardPoint then
                self.difficultyBtn:SetParent(self.NowMapObj.HardPoint.transform)
                self.difficultyBtn.transform.localPosition = Vector3.zero
            end

            -- 回调链：等坐标格全部就绪 → 创建章节节点 → 节点全部就绪后翻页/选中/刷新new标记 → 初始化完成
            self:CreatePointSeed(function()
                self:CreateMapPoint(function()
                    self:refreshNewView()
                    if onComplete then
                        onComplete()
                    end
                end)
            end)

            --刷新难度按钮红点
            self:RefreshDifficultyBtnRed()
            local LevelMainMax = Me:getLevelMainMax()
            local levelconfig = Config.GetPveLevelInfo(LevelMainMax)

            local nowChapterConfig = Config.GetChapterInfo(levelconfig.page)
            self.nowLevelPanel.story.nowLevelDataTxt.text.text = levelconfig.nameKey
            if nowChapterConfig then
                self.nowLevelPanel.story.nowChapterName.text.text = nowChapterConfig.name
            end
            local LevelDifficultMax = Me:getLevelDifficultMax()
            local levelDifficultConfig = Config.GetPveLevelInfo(LevelDifficultMax)
            if levelDifficultConfig then
                local nowDifficultChapterConfig = Config.GetChapterInfo(levelDifficultConfig.page)
                self.nowLevelPanel.difficult.nowLevelDataTxt.text.text = levelDifficultConfig.nameKey
                if nowDifficultChapterConfig then
                    self.nowLevelPanel.difficult.nowChapterName.text.text = nowDifficultChapterConfig.name
                end
            end

            self:ChangeNowDifficultyView()
        end
    end)
end

function SeaMapPanel:getChangeBtnCanOpen()
    --先判断last的
    if self.NowMapIndex - 1 <= 0 then
        self.lastBtn:SetActive(false)
    else
        local lastMapId = self.MapList[self.NowMapIndex - 1].id
        local lastChapterCfg = Config.GetChapterInfoByMap(lastMapId)
        local canEnterLastMap = false
        for _, chapterData in pairs(lastChapterCfg) do
            if self:getChapterIsOpenById(chapterData.id) then
                canEnterLastMap = true
                break
            end
        end
        self.lastBtn:SetActive(canEnterLastMap)
    end

    --再判断next的
    if self.NowMapIndex + 1 > tablex.size(self.MapList) then
        self.nextBtn:SetActive(false)
    else
        local nextMapId = self.MapList[self.NowMapIndex + 1].id
        local nextChapterCfg = Config.GetChapterInfoByMap(nextMapId)
        local canEnterNextMap = false
        for _, chapterData in pairs(nextChapterCfg) do
            if self:getChapterIsOpenById(chapterData.id) then
                canEnterNextMap = true
                break
            end
        end
        self.nextBtn:SetActive(canEnterNextMap)
    end
end

-- --设置相机的后处理
-- function SeaMapPanel:SetPostProcessing()
--     --特效相关
--     local UICamera = UIMgr.uiCamera
    
--     local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
--     if cameraData then
--         cameraData.renderPostProcessing = true                      --后处理
--         cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
--         cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
--     end
-- end

------------------------------------地图相关-------------------------------------------
-- 遍历所有地图，为普通和困难两种难度的章节分别用 FillTemplateContent 创建节点预制体
---@param onComplete function 所有章节节点异步创建完毕后的回调
function SeaMapPanel:CreateMapPoint(onComplete)
    -- 先统计所有地图的章节总数，用于判断全部异步回调何时完成
    local totalItems = 0
    for _, v in pairs(self.MapList) do
        local chapterCfg = Config.GetChapterInfoByMap(self.MapList[v.order].id)
        for _, value in pairs(chapterCfg) do
            if value.Type == GE.ChapterType.MainStory or value.Type == GE.ChapterType.MainDifficult then
                totalItems = totalItems + 1
            end
        end
    end

    local createdItems = 0
    -- 每个章节节点创建完成时调用，所有节点就绪后统一执行翻页和选中逻辑
    local function onItemCreated()
        createdItems = createdItems + 1
        if createdItems == totalItems then
            self:JumpToLatestProgressMap()
            self:SetSelectPointInfo()
            if onComplete then
                onComplete()
            end
        end
    end

    for _,v in pairs(self.MapList) do
        local chapterCfg = Config.GetChapterInfoByMap(self.MapList[v.order].id)
        local chapterList = {}
        local difficultChapterList = {}
        for _, value in pairs(chapterCfg) do
            if value.Type == GE.ChapterType.MainStory then
                table.insert(chapterList, value)

            elseif  value.Type == GE.ChapterType.MainDifficult then
                table.insert(difficultChapterList, value)
            end
        end
        table.sort(chapterList, function(a, b)
            if a.number ~= b.number then
                return a.number < b.number
            end
            return a.id < b.id
        end)
        table.sort(difficultChapterList, function(a, b)
            if a.number ~= b.number then
                return a.number < b.number
            end
            return a.id < b.id
        end)

        local chapterCount = tablex.size(chapterList)
        v.mapChaterList = {}
        local pointList = self[self.MapList[v.order].resource].pointList
        self:FillTemplateContent(self.levelPointBox, pointList, chapterCount, function(index, levelPointBox)
            local mapChaterList = self:UpdatePointModeView(index,1, levelPointBox, chapterList, pointList)
            if not v.mapChaterList[1] then
                v.mapChaterList[1] = {}
            end
            table.insert(v.mapChaterList[1], mapChaterList)
            onItemCreated()
        end)

        local difficultChapterCount = tablex.size(difficultChapterList)
        local difficultPointList = self[self.MapList[v.order].resource].pointListDifficult
        self:FillTemplateContent(self.levelPointBox, difficultPointList, difficultChapterCount, function(index, levelPointBox)
            local mapChaterList = self:UpdatePointModeView(index, 2, levelPointBox, difficultChapterList, difficultPointList)
            if not v.mapChaterList[2] then
                v.mapChaterList[2] = {}
            end
            table.insert(v.mapChaterList[2], mapChaterList)
            onItemCreated()
        end)
    end
end

---根据章节配置判断节点是否显示（Condition）
---@param chapterData table
---@return boolean
function SeaMapPanel:getChapterOpenByData(chapterData)
    if not chapterData then
        return false
    end
    local isOpen = true
    if next(chapterData.Coordinate) then
        for _, levelData in pairs(chapterData.Condition) do
            if levelData[1] == GE.CommonLockJudgeType.Level then
                local condition = Me:getLevelDataByid(levelData[2])
                if condition == nil or condition.state ~= GE.LevelStateType.Finish then
                    isOpen = false
                end
            elseif levelData[1] == GE.CommonLockJudgeType.UserLevel then
                local userLevel = Me:getUserLevel()
                if userLevel < levelData[2] then
                    isOpen = false
                end
            else --无条件直接显示
                isOpen = true
            end
        end
    end
    return isOpen
end

---根据章节配置判断节点是否可进入（chaCondition）
---@param chapterData table
---@return boolean
function SeaMapPanel:getChapterCanEnterByData(chapterData)
    if not chapterData then
        return false
    end
    local canEnter = true
    if chapterData.chaCondition and next(chapterData.chaCondition) then
        for _, levelData in pairs(chapterData.chaCondition) do
            if levelData[1] == GE.CommonLockJudgeType.Level then
                local condition = Me:getLevelDataByid(levelData[2])
                if condition == nil or condition.state ~= GE.LevelStateType.Finish then
                    canEnter = false
                end
            elseif levelData[1] == GE.CommonLockJudgeType.UserLevel then
                local userLevel = Me:getUserLevel()
                if userLevel < levelData[2] then
                    canEnter = false
                end
            else --无条件直接可进入
                canEnter = true
            end
        end
    end
    return canEnter
end

---根据章节id判断章节是否解锁
---@param chapterId integer 章节id
function SeaMapPanel:getChapterIsOpenById(chapterId)
    local chapterCfg = Config.GetChapterInfo(chapterId)
    if not chapterCfg then
        return false
    end
    return self:getChapterOpenByData(chapterCfg)
end

---根据难度模式和预制体，修改对应预制体的显示
---@param index integer 章节索引
---@param mode integer 难度模式 1 普通 2 困难
---@param pointObj table 章节预制体
---@param chapterList table 章节列表
---@param parent table 父节点
function SeaMapPanel:UpdatePointModeView(index, mode, pointObj, chapterList, parent)
    --节点颜色处理
    --判断是否关卡全清显示ClearPoint 与isOn互斥
    local allFinish = true
    local isNew = false
    for _, levelInfo in pairs(chapterList[index].PveLevel) do
        local levelData = Me:getLevelDataByid(levelInfo[1])
        if levelData == nil then            --关卡数据不存在，说明关卡是没打过的新关卡
            isNew = true
        end
        if not levelData or levelData.state ~= GE.LevelStateType.Finish then  --如果有一个关卡未完成，则说明章节未全部完成
            allFinish = false
            break
        end
    end

    --判断章节解锁条件是否满足，未解锁需要改变节点颜色
    local isOpen = self:getChapterOpenByData(chapterList[index])
    
    --判断节点是否可以进入（chaCondition控制可进入性）
    local canEnter = self:getChapterCanEnterByData(chapterList[index])
    
    --如果节点不应该显示，设置完所有的数据和显示后隐藏该节点
    pointObj:SetActive(true)
    pointObj.name = "levelPointBox"..chapterList[index].id
    pointObj.transform:SetParent(self.pointSeedObjList[chapterList[index].Coordinate[1]].obj.transform)
    pointObj.transform.localPosition = Vector3.New(0 + chapterList[index].Coordinate[2][1], 0 + chapterList[index].Coordinate[2][2], 0)
    pointObj.transform:SetParent(parent.transform, true)
    pointObj.transform.localPosition = Vector3.New(pointObj.transform.localPosition.x, pointObj.transform.localPosition.y, 0)

    pointObj.clearPoint:SetActive(allFinish and canEnter)
    pointObj.isOn:SetActive(not allFinish and canEnter)
    pointObj.isNew:SetActive(isNew and canEnter)
    pointObj.nameTxt.text.text = chapterList[index].name
    pointObj.isSelect:SetActive(false)
    --Line和view节点翻转，适应边缘位置显示
    local xScale = 1
    local yScale = 1
    if pointObj.transform.localPosition.x > 0 then
        xScale = -1
    else
        xScale = 1
    end
    if pointObj.transform.localPosition.y > 0 then
        yScale = -1
    else
        yScale = 1
    end
    pointObj.line.rectTransform.localScale = Vector3.New(xScale, yScale, 1)
    pointObj.view.rectTransform.localScale = Vector3.New(xScale, yScale, 1)

    --获取当前完成进度
    local hadPassedPveLevelCount = Me:getChapterHadPassedLevelCount(chapterList[index].id)
    local allPveLevelCount = tablex.size(chapterList[index].PveLevel)
    local scheduleStr = hadPassedPveLevelCount / allPveLevelCount

    -- 追加当前章节是否可以进入的判断，不可进入需要显示Lock面板，并且修改点击方法
    -- isOpen控制节点是否显示，canEnter控制节点是否可以进入
    pointObj.lockBg:SetActive(not canEnter)
    pointObj.chapterBg:SetActive(mode == 1 and canEnter)
    pointObj.chapterDiffBg:SetActive(mode == 2 and canEnter)
    pointObj.stateBg.story:SetActive(mode == 1 and canEnter)
    pointObj.stateBg.difficult:SetActive(mode == 2 and canEnter)

    pointObj.unlockMsgTxt.text.text = chapterList[index].chaDesc

    pointObj.stateBg.lock:SetActive(not canEnter)
    pointObj.lockBtn:SetActive(not canEnter)
    pointObj.initBtn:SetActive(canEnter)

    pointObj.lockBg.chapterName.text.text = chapterList[index].name
    pointObj.chapterBg.chapterName.text.text = chapterList[index].name
    pointObj.chapterDiffBg.chapterName.text.text = chapterList[index].name

    pointObj.stateBg.story.clearCountTxt.text.text = hadPassedPveLevelCount
    pointObj.stateBg.story.maxCountTxt.text.text = allPveLevelCount
    pointObj.stateBg.story.clearValue.slider.value = scheduleStr
    pointObj.stateBg.difficult.clearCountTxt.text.text = hadPassedPveLevelCount
    pointObj.stateBg.difficult.maxCountTxt.text.text = allPveLevelCount
    pointObj.stateBg.difficult.clearValue.slider.value = scheduleStr

    --红点显示
    local hasReward = RedPointMgr:ChapterRewardRedJudge(chapterList[index].id)
    if pointObj.red then
        pointObj.red:SetActive(hasReward and canEnter)
    end
    if pointObj.redOut then
        pointObj.redOut:SetActive(hasReward and canEnter)
    end

    --星级显示
    local nowStar = 0
    local nowRewardCount = 0
    local maxRewardCount = 0
    for _, levelInfo in pairs(chapterList[index].PveLevel) do
        local levelData = Me:getLevelDataByid(levelInfo[1])
        local levelCfg = Config.GetPveLevelInfo(levelInfo[1])
        if levelData and levelCfg.type == GE.LevelType.Battle then
            nowStar = nowStar + levelData.star
            local finishTask = levelData.achieveList
            nowRewardCount = nowRewardCount + tablex.size(finishTask)
        end
        maxRewardCount = maxRewardCount + tablex.size(levelCfg.achieve)
    end

    local starCfgList = Config.GetChapterStarInfoByChapterId(chapterList[index].id)
    local num = chapterList[index].number
    local idStr = (num < 10) and ("0"..num) or tostring(num)

    --完美通关检测：当前星星数 = 章节最大星星数
    local maxStar = 0
    if starCfgList ~= nil and next(starCfgList) then
        maxStar = starCfgList[tablex.size(starCfgList)].complete[2]
    end
    local starPerfect = maxStar > 0 and nowStar >= maxStar
    -- 困难模式额外要求：隐藏成就也达到最大值
    local isPerfect
    if mode == 2 then
        isPerfect = starPerfect and maxRewardCount > 0 and nowRewardCount >= maxRewardCount
    else
        isPerfect = starPerfect
    end
    pointObj.isPerfect:SetActive(isPerfect and canEnter)

    if mode == 1 then
        pointObj.chapterBg.chapterId.text.text = idStr
        pointObj.chapterBg.starBox.nowStarTxt.text.text = nowStar
        if starCfgList ~= nil and next(starCfgList) then
            pointObj.chapterBg.starBox.maxStarTxt.text.text = starCfgList[tablex.size(starCfgList)].complete[2]
        end
        pointObj.chapterBg.isPerfectSide:SetActive(isPerfect)
        pointObj.chapterBg.rectTransform.sizeDelta = Vector2.New(pointObj.chapterBg.rectTransform.sizeDelta.x, isPerfect and 171 or 153)
    elseif mode == 2 then
        pointObj.chapterDiffBg.chapterId.text.text = idStr
        pointObj.chapterDiffBg.msgDataBox.nowStarTxt.text.text = nowStar
        if starCfgList ~= nil and next(starCfgList) then
            pointObj.chapterDiffBg.msgDataBox.maxStarTxt.text.text = starCfgList[tablex.size(starCfgList)].complete[2]
        end
        --困难模式隐藏奖励显示
        pointObj.chapterDiffBg.msgDataBox.nowRewardTxt.text.text = nowRewardCount
        pointObj.chapterDiffBg.msgDataBox.maxRewardTxt.text.text = maxRewardCount
        pointObj.chapterDiffBg.isPerfectSide:SetActive(isPerfect)
        pointObj.chapterDiffBg.rectTransform.sizeDelta = Vector2.New(pointObj.chapterDiffBg.rectTransform.sizeDelta.x, isPerfect and 171 or 153)
    end

    pointObj.btn.button.onClick:RemoveAllListeners()
    pointObj.btn.button.onClick:AddListener(function()
        self:play2DSound(self.btnSoundPath)
        self:DoSelectPointMove(chapterList[index].id, not canEnter)
    end)

    pointObj.initBtn.button.onClick:RemoveAllListeners()
    pointObj.initBtn.button.onClick:AddListener(function()
        self:play2DSound(self.btnSoundPath)
        self:DoSelectPointMove(chapterList[index].id, not canEnter)
    end)

    local mapChaterList = {
        obj = pointObj,
        data = chapterList[index],
        isNew = isNew,
        isPerfect = isPerfect,
    }

    -- 如果节点不应该显示，设置完所有的数据和显示后隐藏该节点
    if not isOpen then
        pointObj:SetActive(false)
    end

    return mapChaterList
end

--处理不同方向的显示
function SeaMapPanel:MoveBtnOnClick(index)
    if not self.CanClick then
        return
    end

    if self.nowSelectMode == 1 then
        if index == 1 then --左
            if self.NowMapIndex - 1 <= 0 then
                --UICommonUtils.PopToast("到最左边了！")
                return 
            end
            self.NowMapIndex = self.NowMapIndex - 1
            self:SetMapChangeView(self.mapPanel_L)
            self.centerPoint.animator:SetTrigger("Left")
        elseif index == 2 then  --右
            if self.NowMapIndex + 1 > tablex.size(self.MapList) then
                --UICommonUtils.PopToast("到最右边了！")
                return 
            end
            self.NowMapIndex = self.NowMapIndex + 1
            self:SetMapChangeView(self.mapPanel_R)
            self.centerPoint.animator:SetTrigger("Right")
        end

        self:getChangeBtnCanOpen()
        self:refreshNewView()

        self.CanClick = false
    elseif self.nowSelectMode == 2 then
        return
        --UICommonUtils.PopToast("施工中")
    end    
    
end

---更新左右侧按钮new显示
function SeaMapPanel:refreshNewView()
    --记录当前所在页码
    MyPrefs:SetInt("SeaMapPanelNew"..self.NowMapIndex, 1)

    local lastMapIndex = self.NowMapIndex - 1
    local nextMapIndex = self.NowMapIndex + 1
    if not (lastMapIndex <= 0) then
        local isNew = false
        local lastList = self.MapList[lastMapIndex].mapChaterList
            and self.MapList[lastMapIndex].mapChaterList[self.nowDifficulty]
        for _, pointData in pairs(lastList or {}) do
            if pointData.isNew == true then
                isNew = true
                break
            end
        end

        --获取存档内该地图的新章节是否已经点击过
        local ListPrefs = MyPrefs:GetInt("SeaMapPanelNew"..lastMapIndex, 0)
        if type(ListPrefs) == "number" and ListPrefs == 1 then
            isNew = false
        end
        self.lastBtn.isNew:SetActive(isNew)
    end

    if not (nextMapIndex > tablex.size(self.MapList)) then
        local isNew = false
        local nextList = self.MapList[nextMapIndex].mapChaterList
            and self.MapList[nextMapIndex].mapChaterList[self.nowDifficulty]
        for _, pointData in pairs(nextList or {}) do
            if pointData.isNew == true then
                isNew = true
                break
            end
        end
        --获取存档内该地图的新章节是否已经点击过
        local ListPrefs = MyPrefs:GetInt("SeaMapPanelNew"..nextMapIndex, 0)
        if type(ListPrefs) == "number" and ListPrefs == 1 then
            isNew = false
        end
        self.nextBtn.isNew:SetActive(isNew)
    end
end

--切页地图显示
function SeaMapPanel:SetMapChangeView(newObj)
    self.NowMapObj.mask:SetActive(true)
    self.NowMapObj:SetParent(self.mapPanel_M.mask.transform)
    self.NowMapObj.transform.localPosition = Vector3.New(0, 0, 0)

    self.NewObj = self.AllMapObjList[self.MapList[self.NowMapIndex].resource]
    if self.NewObj then
        self.NewObj:SetActive(true)
        self.NewObj:SetParent(newObj.mask.transform)
        self.nowMapPanel = newObj
        self.NewObj.transform.localPosition = Vector3.New(0, 0, 0)
    end

    self:RefreshPointSelectState(nil, self.nowDifficulty)
    self.selectCircle:SetActive(false)
    self.difficultyBtn:SetActive(false)
end

--左右切换动画注册
function SeaMapPanel:SetAnimCallBack()
    self.centerPoint.animOverCallBack:SetCallBackOfName(function(name)
        if name == "Left" then
            self.mapPanel_L.transform:SetAsLastSibling()
        elseif name == "Right" then
            self.mapPanel_R.transform:SetAsLastSibling()
        elseif name == "Over" then
            self.NowMapObj.mask:SetActive(false)
            self.NowMapObj:SetParent(self.mapPool.transform)
            self.NowMapObj = self.NewObj
            self.NewObj = nil
            self.mapPanel_M.transform:SetAsLastSibling()
            self:SetSelectPointInfo()
            self.NowMapObj.mask:SetActive(false)
            --更新左右按钮显示
            self.CanClick = true
            
            --根据当前模式显示difficultyBtn
            self.difficultyBtn:SetActive(self.nowSelectMode == GE.SeaMapToggleType.mainStory)
            if self.nowSelectMode == GE.SeaMapToggleType.mainStory then
                self.difficultyBtn.difficultyLockImg:SetActive((UICommonUtils.CheckFunctionOpen(1)) == GE.FunctionOpenState.Lock)
                self.difficultyBtn.storyMode.gameObject:SetActive((UICommonUtils.CheckFunctionOpen(1)) ~= GE.FunctionOpenState.Lock and self.nowDifficulty == 1)
                self.difficultyBtn.difficultMode.gameObject:SetActive((UICommonUtils.CheckFunctionOpen(1)) ~= GE.FunctionOpenState.Lock and self.nowDifficulty == 2)
            end
        end
    end)
end

---直接跳转到指定索引的地图（不播放切换动画）
---@param index integer 目标地图索引
function SeaMapPanel:JumpToMapByIndex(index)
    -- 只在mainStory模式下执行
    if self.nowSelectMode ~= GE.SeaMapToggleType.mainStory then
        return
    end
    
    -- 检查index是否有效
    if not self.MapList[index] then
        LuaLogger.warn("SeaMapPanel:JumpToMapByIndex - Invalid map index: " .. tostring(index))
        return
    end
    
    -- 如果已经在目标地图，不需要切换
    if self.NowMapIndex == index then
        return
    end
    
    -- 隐藏当前地图
    if self.NowMapObj then
        self.NowMapObj:SetParent(self.mapPool.transform)
        self.NowMapObj:SetActive(true)
        self.NowMapObj.mask:SetActive(false)
    end
    
    -- 更新当前地图索引
    self.NowMapIndex = index
    
    -- 设置新地图
    self.NowMapObj = self.AllMapObjList[self.MapList[self.NowMapIndex].resource]
    self.NowMapObj:SetParent(self.nowMapPanel.mask.transform)
    self.NowMapObj.transform.localPosition = Vector3.New(0, 0, 0)
    self.NowMapObj:SetActive(true)
    self.NowMapObj.mask:SetActive(false)
    
    -- 更新difficultyBtn位置
    if self.NowMapObj.HardPoint then
        self.difficultyBtn:SetParent(self.NowMapObj.HardPoint.transform)
        self.difficultyBtn.transform.localPosition = Vector3.zero
    end
    
    -- 更新左右切换按钮状态
    self:getChangeBtnCanOpen()
    
    -- 刷新新标记显示
    self:refreshNewView()
    
    -- 刷新选中点信息
    self:SetSelectPointInfo()
end

------------------------------------节点相关-------------------------------------------
-- 创建地图坐标格
---@param onComplete function 所有坐标格异步创建完毕后的回调
function SeaMapPanel:CreatePointSeed(onComplete)
    local totalSeeds = 78
    local createdSeeds = 0
    self:FillTemplateContent(self.pointSeed, self.pointPoolList, totalSeeds, function(index, pointSeed)
        pointSeed:SetActive(true)
        pointSeed.name = "point_"..index
        local temp = {
            index = index,
            obj = pointSeed
        }
        self.pointSeedObjList[index] = temp

        createdSeeds = createdSeeds + 1
        if createdSeeds == totalSeeds then
            -- 所有坐标格就绪后再做布局重建和禁用 GridLayout
            UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.pointPoolList.transform)
            if self.pointPoolList then
                self.pointPoolList.gridLayoutGroup.enabled = false
                GuideMgr:StartGuideTrigger("SeaMapPanel")
            end
            if onComplete then
                onComplete()
            end
        end
    end)
end

--根据节点ID获取节点信息(只能获取当前地图)
function SeaMapPanel:GetPointDataById(pointId)
    local nowMode = self:getNowDifficulty()
    for _, value in pairs(self.MapList[self.NowMapIndex].mapChaterList[nowMode]) do
        if value.data.id == pointId then
            return value
        end
    end
    return nil
end

--刷新章节节点选中态（保证同一时间仅一个节点高亮）
---@param selectId number|nil 选中章节ID，nil表示全部取消选中
---@param mode number|nil 难度模式，不传则使用当前模式
function SeaMapPanel:RefreshPointSelectState(selectId, mode)
    mode = mode or self:getNowDifficulty()
    local nowMapData = self.MapList and self.MapList[self.NowMapIndex]
    local chapterList = nowMapData and nowMapData.mapChaterList and nowMapData.mapChaterList[mode]
    if not chapterList then
        return
    end

    for _, value in pairs(chapterList) do
        local hasObj = value and value.obj
        if hasObj then
            local isCurrent = selectId ~= nil and value.data.id == selectId
            value.obj.isSelect:SetActive(isCurrent)
            value.obj.line:SetActive(isCurrent)
            value.obj.nullPoint:SetActive(not isCurrent)
            value.obj.nameBg:SetActive(not isCurrent)
            value.obj.isPerfect:SetActive(not isCurrent and (value.isPerfect or false))
        end
    end
end

------------------------------------选中相关-------------------------------------------
--选中显示移动
function SeaMapPanel:DoSelectPointMove(endIndex, isLock)
    local endPoint = self:GetPointDataById(endIndex)
    local nowMode = self:getNowDifficulty()
    if self.nowSelectPoint == endIndex and not isLock then
        ClientData:SetNowSelectChatperId(endPoint.data.id)
        LoadingMgr:SetLoadingStart(function()
            UIMgr:popUI("LevelMapPanel")
        end, nil, true, "SeaMapPanel")
        return
    end
    self.selectEffect:SetActive(false and nowMode == 1)
    self.selectEffectHard:SetActive(false and nowMode == 2)
    --self.selectCircle.animator:SetTrigger("Move")
    local nowPos = self.selectCircle.rectTransform
    local endPos = endPoint.obj.rectTransform
    local distance = self:CalculateDistance(nowPos.position, endPos.position)
    local time = self:CalculateSmoothMoveTime(distance, 20)
    local tween = nowPos:DOMove(endPos.position, time)
    tween:SetAutoKill(true)
    tween:OnComplete(function()
        --self.selectCircle.animator:SetTrigger("MoveEnd")
        self.nowSelectPoint = endIndex
        self:RefreshPointSelectState(self.nowSelectPoint, nowMode)
        self.NowMapObj.mask:SetActive(false)
        self.selectEffect:SetActive(true and nowMode == 1)
        self.selectEffectHard:SetActive(true and nowMode == 2)
    end)
    tween:Play()
    self.NowMapObj.mask:SetActive(true)
    self:RefreshPointSelectState(nil, nowMode)
end

--设置选中初始化
function SeaMapPanel:SetSelectPointInfo()
    local nowMode = self:getNowDifficulty()
    if not self.selectCircle then
        return
    end

    -- 如果没有现在地图或 selectPoint 节点，安全返回
    if not self.NowMapObj or not self.NowMapObj.selectPoint then
        self.selectCircle:SetActive(false)
        return
    end

    self.selectCircle:SetParent(self.NowMapObj.selectPoint.transform)
    self.selectCircle:SetActive(true)
    self.selectCircle.circle:SetActive(nowMode == 1)
    self.selectCircle.cube:SetActive(nowMode == 2)

    self.selectEffect:SetActive(nowMode == 1)
    self.selectEffectHard:SetActive(nowMode == 2)

    -- 默认选择第一个节点，其他节点的line隐藏，isSelect隐藏，nameBg显示
    local nowMapData = self.MapList[self.NowMapIndex]
    if not nowMapData or not nowMapData.mapChaterList or not nowMapData.mapChaterList[nowMode] or #nowMapData.mapChaterList[nowMode] == 0 then
        -- 没有节点可选，隐藏选择圈
        self.selectCircle:SetActive(false)
        return
    end

    table.sort(nowMapData.mapChaterList[nowMode], function(a, b)
        return a.data.number < b.data.number
    end)
    self.nowSelectPoint = nowMapData.mapChaterList[nowMode][1].data.id

    local chapterList = nowMapData.mapChaterList[nowMode]
    for i = #chapterList, 1, -1 do
        local id = chapterList[i].data.id
        local hadPassedPveLevelCount = Me:getChapterHadPassedLevelCount(id)
        local allPveLevelCount = tablex.size(chapterList[i].data.PveLevel)

        if hadPassedPveLevelCount >= allPveLevelCount then

            if i == #chapterList then
                self.nowSelectPoint = chapterList[i].data.id
            else
                self.nowSelectPoint = chapterList[i + 1].data.id
            end
            break
        end
    end

    
    --刷新所有章节红点
    for _, value in pairs(nowMapData.mapChaterList[nowMode]) do
        if value.obj.red then
            local hasReward = RedPointMgr:ChapterRewardRedJudge(value.data.id)
            value.obj.red:SetActive(hasReward)
        end
    end
    
    for _, value in pairs(nowMapData.mapChaterList[nowMode]) do
        local hasObj = value and value.obj
        local hasRect = hasObj and value.obj.rectTransform
        if value.data.id == self.nowSelectPoint then
            if self.selectCircle.rectTransform and hasRect then
                self.selectCircle.rectTransform.anchoredPosition = value.obj.rectTransform.anchoredPosition
            elseif self.selectCircle.transform and hasRect then
                self.selectCircle.transform.position = value.obj.rectTransform.position
            end
            break
        end
    end
    self:RefreshPointSelectState(self.nowSelectPoint, nowMode)

    --获取当前完成进度
    local str = MyPrefs:GetString("PlayNewChapterAnima", "")
    local ss = string.split(str, ",")
    local chapterList = nowMapData.mapChaterList[nowMode]
    for i = #chapterList - 1, 1, -1 do
        local id = chapterList[i].data.id
        local nextId = chapterList[i+1].data.id
        local hadPassedPveLevelCount = Me:getChapterHadPassedLevelCount(id)
        local allPveLevelCount = tablex.size(chapterList[i].data.PveLevel)

        if hadPassedPveLevelCount >= allPveLevelCount then
            if tablex.indexof(ss, tostring(id)) < 0 then
                self:PlayNewChapterAnima(id,  nextId)
                str = str .. tostring(id) .. ","
                MyPrefs:SetString("PlayNewChapterAnima", str)
            end
            break
        end
    end
    

end

---自动跳转到指定材料本
---@param materialType integer 材料类型 GE.ChapterDeepType.Exp(经验) | Technology(科技) | Skill(天赋) | Equip(装备)
function SeaMapPanel:AutoJumpToMaterialLevel(materialType)
    -- 清理旧的定时器
    if self.autoJumpTimer then
        DLuaTimer:RemoveTimer(self.autoJumpTimer)
        self.autoJumpTimer = nil
    end
    
    -- 延迟执行，确保界面已完全初始化
    self.autoJumpTimer = DLuaTimer:DoAfter(0.2, function()
        -- 检查界面是否还存在且有效
        if not self or not UICommonUtils.Checkobj(self.moveBtn) then
            self.autoJumpTimer = nil
            return
        end
        
        -- 先检查常规关卡页签是否开放
        local regularState, regularTips, regularLockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.RegularClearance)
        if regularState == GE.FunctionOpenState.Lock then
            UICommonUtils.PopToast(regularTips)
            self.autoJumpTimer = nil
            return
        end
        
        -- 切换到常规关卡页签
        self:SetModeView(GE.SeaMapToggleType.residentStory)
        
        -- 标记常规关卡页签已读
        if regularState == GE.FunctionOpenState.Open then
            Me:readFunctionReq({functionId = GE.FunctionOpenModule.RegularClearance})
        end
        
        local btnObj = nil
        local functionModule = nil
        
        -- 根据材料类型获取对应的按钮和功能模块ID
        if materialType == GE.ChapterDeepType.Exp then
            btnObj = self.exptBtn
            functionModule = GE.FunctionOpenModule.ExperienceMaterial
        elseif materialType == GE.ChapterDeepType.Technology then
            btnObj = self.techBtn
            functionModule = GE.FunctionOpenModule.TechTreeMaterial
        elseif materialType == GE.ChapterDeepType.Skill then
            btnObj = self.talentBtn
            functionModule = GE.FunctionOpenModule.TalentTreeMaterial
        elseif materialType == GE.ChapterDeepType.Equip then
            btnObj = self.equipBtn
            functionModule = GE.FunctionOpenModule.EquipmentMaterial
        else
            LuaLogger.ds("AutoJumpToMaterialLevel", "未知的材料类型: " .. tostring(materialType))
            self.autoJumpTimer = nil
            return
        end
        
        if not btnObj then
            self.autoJumpTimer = nil
            return
        end
        
        -- 检查材料本功能开放条件
        local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(functionModule)
        if state == GE.FunctionOpenState.Lock then
            UICommonUtils.PopToast(tips)
            self.autoJumpTimer = nil
            return
        end
        
        -- 播放音效并跳转
        self:play2DSound(self.btnSoundPath)
        self:openMaterialLevelPanel(materialType, btnObj)
        
        -- 标记功能已读
        if state == GE.FunctionOpenState.Open then
            Me:readFunctionReq({functionId = functionModule})
        end
        
        -- 清理定时器引用
        self.autoJumpTimer = nil
    end)
end

--进入材料副本 GE.ChapterDeepType
function SeaMapPanel:openMaterialLevelPanel(materialType, btnObj)
    if self.moveBtn.transform.localScale ~= Vector3.one then
        return
    end
    local idList = Config.GetChapterInfoByTypeDeepType(2, materialType)

    local doTime = 0.5
    local newScale = Vector3.New(1.5,1.5,1)
    local btnPos = btnObj.transform.localPosition
    local targetPos = Vector3.New(-btnPos.x * newScale.x, -btnPos.y * newScale.y, 0)
    self.moveBtn.transform:DOScale(newScale, doTime)
    self.moveBtn.transform:DOLocalMove(targetPos, doTime):OnComplete(function()
        UIMgr:popUI("MaterialLevelPanel", {
            chapterIdList = idList,
            materialType = materialType,
            openFinishFunc = function()
                if UICommonUtils.Checkobj(self.moveBtn) then
                    self.moveBtn.transform.localScale = Vector3.one
                    self.moveBtn.transform.localPosition = Vector3.zero
                end
            end,
        })
    end)
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
end

--设置活动界面倒计时
function SeaMapPanel:setActiveCountdown()
    self.activityLevel.weeklyActBtn.activityName.text.text = LocalStrEnum.TabName_1701
    self.activityLevel.weeklyActBtn.activityNameGray.text.text = LocalStrEnum.TabName_1701
    self.bossActBtn.activityName.text.text = LocalStrEnum.TabName_2601
    self.bossActBtn.activityNameGray.text.text = LocalStrEnum.TabName_2601
    --模拟演习
    if self.simulatedCountDownTimer then
        DLuaTimer:RemoveTimer(self.simulatedCountDownTimer)
    end
    self:simulatedTimeChange()
    self.simulatedCountDownTimer = DLuaTimer:DoRepeatForever(10, function()
        self:simulatedTimeChange()
    end)
    --危境攻坚
    if self.weeklyBossCountDownTimer then
        DLuaTimer:RemoveTimer(self.weeklyBossCountDownTimer)
    end
    self:weeklyBossTimeChange()
    self.weeklyBossCountDownTimer = DLuaTimer:DoRepeatForever(10, function()
        self:weeklyBossTimeChange()
    end)
end

--模拟演习倒计时变化
function SeaMapPanel:simulatedTimeChange()
    local offsetStringMap = DLuaUtil.getNextWeekRemainingTime(Me.servertime, Me:getTimeZone())
    if offsetStringMap.day == 0 and offsetStringMap.hour == 0 and offsetStringMap.min < 10 then
        self.activityLevel.resetTimeTxt.text.text = LocalStrEnum.PveExerciseSettling
        self.simulatedIsReset = true
    elseif offsetStringMap.day == 0 then
        self.activityLevel.resetTimeTxt.text.text = string.format(LocalStrEnum.PveExerciseTimeHour, offsetStringMap.hour, offsetStringMap.min)
    else
        self.activityLevel.resetTimeTxt.text.text = string.format(LocalStrEnum.PveExerciseTimeDay, offsetStringMap.day, offsetStringMap.hour)
    end
end
--危境攻坚倒计时变化
function SeaMapPanel:weeklyBossTimeChange()
    local bossActData = Me:getBossActivityData()
    local offsetStringMap = DLuaUtil.getBossActivityRemainingTime(bossActData.closingTime)
    if offsetStringMap.day == 0 and offsetStringMap.hour == 0 and offsetStringMap.min < 10 then
        self.bossActBtn.resetTimeTxt.text.text = LocalStrEnum.PveExerciseSettling
        self.weeklyBossIsReset = true
    elseif offsetStringMap.day == 0 then
        self.bossActBtn.resetTimeTxt.text.text = string.format(LocalStrEnum.PveExerciseTimeHour, offsetStringMap.hour, offsetStringMap.min)
    else
        self.bossActBtn.resetTimeTxt.text.text = string.format(LocalStrEnum.PveExerciseTimeDay, offsetStringMap.day, offsetStringMap.hour)
    end
end

--材料关卡额外掉落
function SeaMapPanel:showExtraRewards()
    local extraRewards = Me:getExtraRewardsData()
    for _, materialType in pairs(GE.ChapterDeepType) do
        local btnObj = nil
        if materialType == GE.ChapterDeepType.Exp then
            btnObj = self.exptBtn
        elseif materialType == GE.ChapterDeepType.Technology then
            btnObj = self.techBtn
        elseif materialType == GE.ChapterDeepType.Skill then
            btnObj = self.talentBtn
        elseif materialType == GE.ChapterDeepType.Equip then
            btnObj = self.equipBtn
        end
        btnObj.double:SetActive(false)
        local isShow = false
        local idList = Config.GetChapterInfoByTypeDeepType(2, materialType)
        for _, chapterId in pairs(idList) do
            local chapterConfig = Config.GetChapterInfo(chapterId)
            for _, weekday in pairs(chapterConfig.ExtraRewardTime) do
                if weekday == DLuaUtil.getWeekDayWithOffset(Me.servertime) and extraRewards[chapterConfig.DeepType].count + (extraRewards[chapterConfig.DeepType].extraCount or 0) > 0 then
                    btnObj.double:SetActive(true)
                    btnObj.doubleTxt.text.text = LocalStrEnum.MaterialDoubleTxt
                    isShow = true
                    break
                end
            end
            if isShow then
                break
            end
        end
    end
end

------------------------------------通用-------------------------------------------
-- 计算两点之间的距离
function SeaMapPanel:CalculateDistance(point1, point2)
    local distance = math.sqrt((point2.x - point1.x) ^ 2 + (point2.y - point1.y) ^ 2)
    return distance
end

-- 计算平滑移动所需的时间
function SeaMapPanel:CalculateSmoothMoveTime(distance, speed)
    local time = distance / speed
    return time
end

-------------------------------------按钮事件----------------------------------------------

--[[
/AcitiveLevelBtn onClick 活动页签
--]]
function SeaMapPanel:acitiveLevelBtn_ScaleButton_onClick(acitiveLevelBtn)
    if not self.CanClick then return end
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.PeriodicEvent)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        self:SetModeView(GE.SeaMapToggleType.activityStory)
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.PeriodicEvent})
    end
end

--[[
/BtnBg/NomalLevelBtn onClick 常规活动页签
--]]
function SeaMapPanel:nomalLevelBtn_ScaleButton_onClick(nomalLevelBtn)
    if not self.CanClick then return end
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.RegularClearance)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        self:SetModeView(GE.SeaMapToggleType.residentStory)
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.RegularClearance})
    end
end

--[[
/BtnBg/MainLevelBtn onClick 主线页签
--]]
function SeaMapPanel:mainLevelBtn_ScaleButton_onClick(mainLevelBtn)
    if not self.CanClick then return end
    self:play2DSound(self.btnSoundPath)
    self:SetModeView(GE.SeaMapToggleType.mainStory)
end

--[[
/SeaImg/LevelPointBox onClick 
--]]
function SeaMapPanel:levelPointBox_ScaleButton_onClick(levelPointBox)
    self:play2DSound(self.btnSoundPath)
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.GameState)
    end, nil, true, "SeaMapPanel2")
end

--[[
/WarringLookList/WarringBtn onClick 
--]]
function SeaMapPanel:warringBtn_ScaleButton_onClick(warringBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("WarringTaskPanel", {})
end

--[[
/NextBtn onClick 
--]]
function SeaMapPanel:nextBtn_ScaleButton_onClick(nextBtn)
    self:play2DSound(self.btnSoundPath)
    self:MoveBtnOnClick(2)
end

--[[
/LastBtn onClick 
--]]
function SeaMapPanel:lastBtn_ScaleButton_onClick(lastBtn)
    self:play2DSound(self.btnSoundPath)
    self:MoveBtnOnClick(1)
end

--[[    经验本
/LevelPool/Level2001/SelectPoint/ExptBtn onClick 
--]]
function SeaMapPanel:exptBtn_ScaleButton_onClick(exptBtn)
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.ExperienceMaterial)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        self:openMaterialLevelPanel(GE.ChapterDeepType.Exp, exptBtn)
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.ExperienceMaterial})
    end
end

--[[   科技树材料本
/LevelPool/Level2001/MoveBtn/SelectPoint/TechBtn onClick 
--]]
function SeaMapPanel:techBtn_ScaleButton_onClick(techBtn)
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.TechTreeMaterial)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        self:openMaterialLevelPanel(GE.ChapterDeepType.Technology, techBtn)
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.TechTreeMaterial})
    end
end

--[[    天赋树材料本
/LevelPool/Level2001/MoveBtn/SelectPoint/TalentBtn onClick 
--]]
function SeaMapPanel:talentBtn_ScaleButton_onClick(talentBtn)
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.TalentTreeMaterial)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        self:openMaterialLevelPanel(GE.ChapterDeepType.Skill, talentBtn)
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.TalentTreeMaterial})
    end
end

--[[    装备本
/LevelPool/Level2001/MoveBtn/SelectPoint/EquipBtn onClick 
--]]
function SeaMapPanel:equipBtn_ScaleButton_onClick(equipBtn)
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.EquipmentMaterial)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        self:openMaterialLevelPanel(GE.ChapterDeepType.Equip, equipBtn)
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.EquipmentMaterial})
    end
end

--[[
/TaskPanel/OpenBtn/OpenType onClick 
--]]
function SeaMapPanel:openType_ScaleButton_onClick(openType)
    self:play2DSound(self.btnSoundPath)
    if self.nowToggle then
        self.taskPanel.animator:SetTrigger("IsOff")
        self.nowToggle = false
    else
        self.taskPanel.animator:SetTrigger("IsOn")
        self.nowToggle = true
    end
end

--[[
/TaskPanel/IsOpenBtn onClick 
--]]
function SeaMapPanel:isOpenBtn_Button_onClick(isOpenBtn)
    self:play2DSound(self.btnSoundPath)
    if self.ToggleOn == 1 then
        self.isOpenBtn.animation:Play("ToggleOff")
        self.ToggleOn = 0
        UnityEngine.PlayerPrefs.SetInt("TaskToggleState", 0)
    else
        self.isOpenBtn.animation:Play("ToggleOn")
        self.ToggleOn = 1
        UnityEngine.PlayerPrefs.SetInt("TaskToggleState", 1)
    end
end

--[[
/LevelTest onClick 
--]]
function SeaMapPanel:levelTest_ScaleButton_onClick(levelTest)
    self:play2DSound(self.btnSoundPath)
end

--[[
/CustomBackPanel/BackMainlBtn onClick 
--]]
function SeaMapPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/CustomBackPanel/HelpBtn onClick 
--]]
function SeaMapPanel:helpBtn_ScaleButton_onClick(helpBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/LevelPool/ActivityLevel/WeeklyActBtn onClick 
--]]
function SeaMapPanel:weeklyActBtn_ScaleButton_onClick(weeklyActBtn)
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.SimulationDrill)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        local activityData = Me:getSimulatedActivityData()
        local levelConfigList = Config.GetPveExerciseLevelByIssueAndStorey(activityData.nowPeriod, 1)
        if self.simulatedIsReset then
            UICommonUtils.PopToast(LocalStrEnum.PveExerciseSettlingTips)
        elseif not levelConfigList or #levelConfigList == 0 then
            UICommonUtils.PopToast(LocalStrEnum.NotOpenThisWeek)
        else
            UIMgr:popUI("SimulatedLevelPanel")
        end
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.SimulationDrill})
    end
end

--[[
/AdjustRoot/LevelPool/ActivityLevel/BossActBtn onClick 
--]]
function SeaMapPanel:bossActBtn_ScaleButton_onClick(bossActBtn)
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.WeeklyBossChallenges)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        local activityData = Me:getBossActivityData()
        local bossConfigList = Config.GetPveBossBattleInfoByIssue(activityData.nowPeriod)
        if self.weeklyBossIsReset then
            UICommonUtils.PopToast(LocalStrEnum.PveBossBattleSettlingTips)
        elseif not bossConfigList then
            UICommonUtils.PopToast(LocalStrEnum.NotOpenThisWeek)
        else
            UIMgr:popUI("WeeklyBossMainPanel")
        end
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.WeeklyBossChallenges})
    end
end

--[[
/AdjustRoot/DifficultyBtn onClick 
--]]
function SeaMapPanel:difficultyBtn_ScaleButton_onClick(difficultyBtn)
    self:play2DSound(self.btnSoundPath)
    local functionOpenConfig = Config.GetFunctionOpenInfo(1)
    if (UICommonUtils.CheckFunctionOpen(1)) == GE.FunctionOpenState.Lock then
        if functionOpenConfig then
            UICommonUtils.PopToast(functionOpenConfig.unlockKey)
        end
        return
    end

    self.CanClick = false
    local a = 1
    if self.nowDifficulty == 1 then
        a = 2
    else
        a = 1
    end
    for i = 1, 2 do
        local obj = self["effect_Ui_StoryHard_"..i]
        if obj ~= nil then
            obj:SetActive(i == a)
        end
    end
    self.difficultyBtn.gameObject:SetActive(false)
    self.selectCircle.gameObject:SetActive(false)
    for _, mapObj in pairs(self.AllMapObjList) do
        mapObj.pointList:SetActive(false)
        mapObj.pointListDifficult:SetActive(false)
    end
    local seq = DOTween.Sequence()
    seq:AppendInterval(2)
    seq:AppendCallback(function()
        self.difficultyBtn.gameObject:SetActive(true)
        self.selectCircle.gameObject:SetActive(true)
        for _, mapObj in pairs(self.AllMapObjList) do
            mapObj.pointList:SetActive(true)
            mapObj.pointListDifficult:SetActive(true)
        end
        for i = 1, 2 do
            local obj = self["effect_Ui_StoryHard_"..i]
            obj:SetActive(false)
        end
        self.CanClick = true
        if self.nowDifficulty == 1 then
            self:ChangeNowDifficulty(2)
        else
            self:ChangeNowDifficulty(1)
        end
        GuideMgr:StartGuideTrigger("SeaMapPanel")
    end)
end

function SeaMapPanel:PlayNewChapterAnima(lastChapterId, chapterId)
    local endPoint = self:GetPointDataById(chapterId)
    if endPoint == nil then
       return 
    end

    local startPoint = self:GetPointDataById(lastChapterId)
    if startPoint == nil then
        return
    end

    if self.seq ~= nil then
       self.seq:Kill()
       self.seq = nil
    end

    self.CanClick = false
    local nowPoint = self:GetPointDataById(self.nowSelectPoint)
    if nowPoint ~= nil then
        nowPoint.obj.line:SetActive(false)
    end
    local endPos = endPoint.obj.rectTransform.position
    local startPos = startPoint.obj.rectTransform.position
    local trs = self.selectCircle.rectTransform
    local localPos = trs.parent:InverseTransformPoint(startPos)
    trs.anchoredPosition = localPos

    local localPos = trs.parent:InverseTransformPoint(endPos)
    local seq = DOTween.Sequence()
    seq:AppendInterval(0.5)
    seq:Append(trs:DOScale(2, 0.5))
    seq:Append(trs:DOAnchorPos(localPos, 0.5))
    seq:Join(trs:DOScale(1, 0.5))
    seq:AppendCallback(function()
        endPoint.obj.gameObject:SetActive(true)
        endPoint.obj.line:SetActive(true)
        endPoint.obj.stateBg.gameObject:SetActive(false)
        self:DoSelectPointMove(chapterId, true)
    end)
    seq:AppendInterval(0.5)
    seq:AppendCallback(function()
        endPoint.obj.stateBg.gameObject:SetActive(true)
        self.CanClick = true
    end)
    self.seq = seq
end

--- 根据玩家当前通关进度，自动跳转到最新进度所在的地图页
function SeaMapPanel:JumpToLatestProgressMap()
    local nowIndex = 1
    for i = #self.MapList, 1, -1 do
        local nowMapData = self.MapList[i]
        local nowMode = self:getNowDifficulty()
        local chapterList = nowMapData.mapChaterList[nowMode]

        local index = 0
        for j = #chapterList, 1, -1 do
            local id = chapterList[j].data.id
            local hadPassedPveLevelCount = Me:getChapterHadPassedLevelCount(id)
            local allPveLevelCount = tablex.size(chapterList[j].data.PveLevel)
            if hadPassedPveLevelCount >= allPveLevelCount then
                index = j
                break
            end
        end
        if index ~= 0 then
            if index == #chapterList then
                nowIndex = math.max(i + 1, #self.MapList)
            else
                nowIndex = i
            end
        end
    end

    if self.seq ~= nil then
       self.seq:Kill() 
       self.seq = nil
    end
    self:JumpToMapByIndex(nowIndex)
end

return SeaMapPanel
