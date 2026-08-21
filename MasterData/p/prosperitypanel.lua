---@class ProsperityPanel : ProsperityPanel_Generate
---##################### 【ProsperityPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ProsperityPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ProsperityPanel = require "ProsperityPanel_Generate"

function ProsperityPanel:InitLogic(data)
    self.nowSelectMode = 1	                    -- 当前模式页签：1主界面 2建造 3散步
    self.prosperityInfo = {}	                -- 家园繁荣度运行数据快照（currentLevel/globalConditionProgress等）
    self.mainModeLevelCfgList = {}	            -- 主模式繁荣等级配置列表（按等级排序后缓存）
    self.prosperityLevelBoxList = {}	        -- 繁荣等级按钮格子实例缓存
    self.selectedProsperityLevel = 0	        -- 当前选中的繁荣等级id
    self.selectedProsperityLevelTaskId = 0	    -- 当前选中等级对应的主任务id（用于领取按钮）
    self.prosperityTaskBoxList = {}	            -- 子任务格子实例缓存
    self.pendingProsperityTaskIds = {}	        -- 待展示子任务id列表（用于复用格子时刷新）
    self.prosperityRewardBoxList = {}	        -- 奖励格子实例缓存
    self.pendingProsperityRewardList = {}	    -- 待展示奖励数据列表（用于复用格子时刷新）
    self.prosperityLevelEffectBoxList = {}	    -- 等级效果格子实例缓存
    self.prosperityBuildCfgList = {}	        -- 当前建造页签展示的建筑配置列表
    self.prosperityBuildBoxList = {}	        -- 建筑格子实例缓存
    self.prosperityBuildRuntimeList = {}	    -- 建筑运行时数据缓存（等级/是否建成/产出等）
    self.selectedBuildGroup = 1	                -- 当前建造分组：1功能建筑 2产出建筑
    self.buildIconLoadTokenMap = {}	            -- 建筑图标异步加载令牌（防旧回调覆盖）
    self.buildOutputIconLoadTokenMap = {}	    -- 建筑产出图标异步加载令牌（防旧回调覆盖）
    self.walkPointList = {}	                    -- 散步点位列表缓存（Point_1 ~ Point_10）
    self.walkRoleBoxList = {}	                -- 散步角色格子实例缓存
    self.walkRoleLoadTokenMap = {}	            -- 散步角色立绘异步加载令牌（防旧回调覆盖）
    self.keepCurrentModeOnNextOpen = false	    -- 下次打开是否保留当前页签
    -------------------动画相关------------------------------
    self.bgOpenCurveTween = nil	                -- 面板打开动画：曲线移动Tween
    self.bgOpenScaleTween = nil	                -- 面板打开动画：缩放Tween
    self.bgOpenRotateTween = nil	            -- 面板打开动画：旋转Tween
    self.openBgCricleTween = nil	            -- 面板打开动画：背景圆环Tween
    self.openBgIconTween = nil	                -- 面板打开动画：背景图标Tween
    self.openBgFadeOutTween = nil	            -- 面板打开动画：背景淡出Tween
    self.bgCloseMoveTween = nil	                -- 面板关闭动画：位移Tween
    self.bgCloseScaleTween = nil	            -- 面板关闭动画：缩放Tween
    self.bgCloseRotateTween = nil	            -- 面板关闭动画：旋转Tween
    self.bgCloseFadeTween = nil	                -- 面板关闭动画：透明度Tween
    self.isClosingPanel = false	                -- 是否正在执行关闭流程（防重复关闭）
    self._bgCloseStartPos = nil	                -- 关闭动画起点：位置
    self._bgCloseStartScale = nil	            -- 关闭动画起点：缩放
    self._bgCloseStartEuler = nil	            -- 关闭动画起点：旋转角
    self._bgCloseStartAlpha = nil	            -- 关闭动画起点：透明度
    self._bgDefaultPos = nil	                -- 背景默认位置（用于开关动画复位）
    self._bgDefaultScale = nil	                -- 背景默认缩放（用于开关动画复位）
    self._bgDefaultEuler = nil	                -- 背景默认旋转角（用于开关动画复位）
    self._bgDefaultAlpha = nil	                -- 背景默认透明度（用于开关动画复位）
    self.modeSwitchTween = nil	                -- 主/建造/散步模式切换Tween
    self.currentModeVisual = nil	            -- 当前视觉上激活的模式（用于切页过渡）
    self.buildGroupSwitchTween = nil	        -- 建造模式内分组切换Tween
    -------------------刷新相关------------------------------
    GameMsgMgr:regEvent(GameMsgType.RoleWalkChange, self, self.OnRoleWalkChange)
    GameMsgMgr:regEvent(GameMsgType.RefreshHomeland, self, self.OnRefreshHomeland)
    GameMsgMgr:regEvent(GameMsgType.HomelandOneKeyCollected, self, self.OnHomelandOneKeyCollected)
    GameMsgMgr:regEvent(GameMsgType.MissionRefresh, self, self.OnMissionRefresh)
    GameMsgMgr:regEvent(GameMsgType.ProsperityInfoUpdate, self, self.OnProsperityInfoUpdate)
end

--function ProsperityPanel:StartCreating(time)
--
--end

--function ProsperityPanel:StartEnter(time)
--
--end

--function ProsperityPanel:StartRemoving(time)
--
--end

--function ProsperityPanel:StartExit(time)
--
--end

function ProsperityPanel:OnOpen(data, initiative)
    local homeland = Me and Me:getHomeland()
    if not homeland then
        LuaLogger.ds("[ProsperityPanel] Me:getHomeland() nil")
        return
    end

    local info = homeland.prosperityInfo
    if not info then
        LuaLogger.ds("[ProsperityPanel] prosperityInfo nil")
        return
    end

    self.prosperityInfo = info

    self.canvasGroup.interactable = false
    local totalProsperity = (info.globalConditionProgress and info.globalConditionProgress[GE.MissionFinishType.Prosperity]) or 0
    local keepCurrentMode = self.keepCurrentModeOnNextOpen == true
    self.keepCurrentModeOnNextOpen = false
    self:SetView(keepCurrentMode)
    self:PlayBgOpenAnim()
end

---关闭并清理面板打开动画Tween
function ProsperityPanel:KillBgOpenAnimTweens()
    if self.bgOpenCurveTween then
        self.bgOpenCurveTween:Kill()
        self.bgOpenCurveTween = nil
    end
    if self.bgOpenScaleTween then
        self.bgOpenScaleTween:Kill()
        self.bgOpenScaleTween = nil
    end
    if self.bgOpenRotateTween then
        self.bgOpenRotateTween:Kill()
        self.bgOpenRotateTween = nil
    end
    if self.openBgCricleTween then
        self.openBgCricleTween:Kill()
        self.openBgCricleTween = nil
    end
    if self.openBgIconTween then
        self.openBgIconTween:Kill()
        self.openBgIconTween = nil
    end
    if self.openBgFadeOutTween then
        self.openBgFadeOutTween:Kill()
        self.openBgFadeOutTween = nil
    end
end

---关闭并清理面板关闭动画Tween
function ProsperityPanel:KillBgCloseAnimTweens()
    if self.bgCloseMoveTween then
        self.bgCloseMoveTween:Kill()
        self.bgCloseMoveTween = nil
    end
    if self.bgCloseScaleTween then
        self.bgCloseScaleTween:Kill()
        self.bgCloseScaleTween = nil
    end
    if self.bgCloseRotateTween then
        self.bgCloseRotateTween:Kill()
        self.bgCloseRotateTween = nil
    end
    if self.bgCloseFadeTween then
        self.bgCloseFadeTween:Kill()
        self.bgCloseFadeTween = nil
    end
end

---请求关闭界面（先播放整页关闭动画，再真正关闭UI）
---@param onClosed fun()?
function ProsperityPanel:RequestCloseWithAnim(onClosed)
    if self.isClosingPanel then
        return
    end
    if not self.bg or not self.bg.rectTransform then
        UIMgr:closeUI(self)
        if onClosed then
            onClosed()
        end
        return
    end

    self.isClosingPanel = true
    self:KillBgOpenAnimTweens()
    self:KillBgCloseAnimTweens()

    if self.openBg then
        self.openBg:SetActive(false)
    end

    local rect = self.bg.rectTransform
    local startPos = rect.anchoredPosition
    local startScale = rect.localScale
    local startEuler = rect.localEulerAngles
    local startAlpha = (self.bg.canvasGroup and self.bg.canvasGroup.alpha) or 1

    self._bgCloseStartPos = startPos
    self._bgCloseStartScale = startScale
    self._bgCloseStartEuler = startEuler
    self._bgCloseStartAlpha = startAlpha

    local endPos = Vector2.New(startPos.x - 220, startPos.y - 150)
    local endScale = Vector3.New(startScale.x * 0.92, startScale.y * 0.92, startScale.z)
    local endEuler = Vector3.New(startEuler.x, startEuler.y, startEuler.z - 8)

    self.bgCloseMoveTween = DG.Tweening.DOVirtual.Float(0, 1, 0.24, function(t)
        local x = startPos.x + (endPos.x - startPos.x) * t
        local y = startPos.y + (endPos.y - startPos.y) * t
        rect.anchoredPosition = Vector2.New(x, y)
    end):SetEase(DG.Tweening.Ease.InCubic):OnComplete(function()
        self.bgCloseMoveTween = nil
    end)

    self.bgCloseScaleTween = rect:DOScale(endScale, 0.24):SetEase(DG.Tweening.Ease.InCubic):OnComplete(function()
        self.bgCloseScaleTween = nil
    end)

    self.bgCloseRotateTween = rect:DOLocalRotate(endEuler, 0.22):SetEase(DG.Tweening.Ease.InCubic):OnComplete(function()
        self.bgCloseRotateTween = nil
    end)

    if self.bg.canvasGroup then
        self.bgCloseFadeTween = self.bg.canvasGroup:DOFade(0, 0.24):SetEase(DG.Tweening.Ease.InCubic):OnComplete(function()
            self.bgCloseFadeTween = nil
            self.isClosingPanel = false
            UIMgr:closeUI(self)
            if onClosed then
                onClosed()
            end
        end)
    else
        -- 没有canvasGroup时，按位移动画结束即关闭
        self.bgCloseMoveTween:OnComplete(function()
            self.bgCloseMoveTween = nil
            self.isClosingPanel = false
            UIMgr:closeUI(self)
            if onClosed then
                onClosed()
            end
        end)
    end
end

---播放背景面板打开动画（左下掏出平板感）
function ProsperityPanel:PlayBgOpenAnim()
    if not self.bg or not self.bg.rectTransform then
        return
    end

    self.isClosingPanel = false
    self:KillBgOpenAnimTweens()
    self:KillBgCloseAnimTweens()

    if self.bg.canvasGroup then
        self.bg.canvasGroup.alpha = 1
    end

    if self.openBg then
        self.openBg:SetActive(true)
        if self.openBg.canvasGroup then
            self.openBg.canvasGroup.alpha = 1
        end
        if self.openBg.cricle then
            self.openBg.cricle:SetActive(false)
        end
        if self.openBg.icon then
            self.openBg.icon:SetActive(false)
            if self.openBg.icon.canvasGroup then
                self.openBg.icon.canvasGroup.alpha = 0
            end
        end
    end

    local rect = self.bg.rectTransform
    if not self._bgDefaultPos then
        self._bgDefaultPos = rect.anchoredPosition
        self._bgDefaultScale = rect.localScale
        self._bgDefaultEuler = rect.localEulerAngles
        self._bgDefaultAlpha = (self.bg.canvasGroup and self.bg.canvasGroup.alpha) or 1
    end
    local targetPos = self._bgDefaultPos
    local targetScale = self._bgDefaultScale
    local targetEuler = self._bgDefaultEuler

    local startPos = Vector2.New(targetPos.x - 420, targetPos.y - 260)
    local controlPos = Vector2.New(targetPos.x - 170, targetPos.y + 120)
    local startScale = Vector3.New(targetScale.x * 0.68, targetScale.y * 0.68, targetScale.z)
    local startEuler = Vector3.New(targetEuler.x, targetEuler.y, targetEuler.z - 14)

    rect.anchoredPosition = startPos
    rect.localScale = startScale
    rect.localEulerAngles = startEuler

    self.bgOpenCurveTween = DG.Tweening.DOVirtual.Float(0, 1, 0.44, function(t)
        local oneMinus = 1 - t
        local x = oneMinus * oneMinus * startPos.x + 2 * oneMinus * t * controlPos.x + t * t * targetPos.x
        local y = oneMinus * oneMinus * startPos.y + 2 * oneMinus * t * controlPos.y + t * t * targetPos.y
        rect.anchoredPosition = Vector2.New(x, y)
    end):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
        rect.anchoredPosition = targetPos
        self.bgOpenCurveTween = nil
        if self.openBg then
            if self.openBg.cricle and self.openBg.cricle.rectTransform then
                self.openBg.cricle:SetActive(true)
                self.openBg.cricle.rectTransform.localScale = Vector3.New(1.7, 1.7, 1)
                self.openBgCricleTween = self.openBg.cricle.rectTransform:DOScale(Vector3.New(1, 1, 1), 0.68):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
                    self.openBgCricleTween = nil
                end)
            end

            if self.openBg.icon then
                self.openBg.icon:SetActive(true)
                if self.openBg.icon.rectTransform then
                    self.openBg.icon.rectTransform.localScale = Vector3.New(1, 1, 1)
                end
                if self.openBg.icon.canvasGroup then
                    self.openBg.icon.canvasGroup.alpha = 0
                    self.openBgIconTween = self.openBg.icon.canvasGroup:DOFade(1, 0.5):SetDelay(0.16):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
                        self.openBgIconTween = nil
                    end)
                end
            end

            local hasIconCg = self.openBg.icon and self.openBg.icon.canvasGroup
            local hasOpenBgCg = self.openBg.canvasGroup ~= nil
            if hasIconCg or hasOpenBgCg then
                self.openBgFadeOutTween = DG.Tweening.DOTween.Sequence()
                self.openBgFadeOutTween:AppendInterval(0.72)
                if hasIconCg then
                    self.openBgFadeOutTween:Append(self.openBg.icon.canvasGroup:DOFade(0, 0.22):SetEase(DG.Tweening.Ease.OutCubic))
                elseif hasOpenBgCg then
                    -- 没有icon透明组件时，仍然给OpenBg一个总淡出
                    self.openBgFadeOutTween:AppendInterval(0.22)
                end
                if self.openBg.icon and self.openBg.icon.rectTransform then
                    self.openBgFadeOutTween:Join(self.openBg.icon.rectTransform:DOScale(Vector3.New(1.2, 1.2, 1), 0.24):SetEase(DG.Tweening.Ease.OutBack))
                end
                if self.openBg.cricle and self.openBg.cricle.rectTransform then
                    self.openBgFadeOutTween:Join(self.openBg.cricle.rectTransform:DOScale(Vector3.New(1.7, 1.7, 1), 0.3):SetEase(DG.Tweening.Ease.OutSine))
                end
                if hasOpenBgCg then
                    self.openBgFadeOutTween:Join(self.openBg.canvasGroup:DOFade(0, 0.24):SetEase(DG.Tweening.Ease.OutCubic))
                end
                self.openBgFadeOutTween:OnComplete(function()
                    if self.openBg.cricle then
                        self.openBg.cricle:SetActive(false)
                    end
                    if self.openBg.icon then
                        self.openBg.icon:SetActive(false)
                    end
                    self.openBg:SetActive(false)
                    self.openBgFadeOutTween = nil
                    self.canvasGroup.interactable = true
                    GuideMgr:StartGuideTrigger("ProsperityPanel")
                end)
            else
                if self.openBg.cricle then
                    self.openBg.cricle:SetActive(false)
                end
                if self.openBg.icon then
                    self.openBg.icon:SetActive(false)
                end
                self.openBg:SetActive(false)
            end
        end
    end)

    self.bgOpenScaleTween = rect:DOScale(targetScale, 0.52):SetEase(DG.Tweening.Ease.OutBack):OnComplete(function()
        rect.localScale = targetScale
        self.bgOpenScaleTween = nil
    end)

    self.bgOpenRotateTween = rect:DOLocalRotate(targetEuler, 0.45):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
        rect.localEulerAngles = targetEuler
        self.bgOpenRotateTween = nil
    end)
end

-------------------模式切换通用------------------------------
---关闭并清理页签切换动画Tween
function ProsperityPanel:KillModeSwitchTween()
    if self.modeSwitchTween then
        self.modeSwitchTween:Kill()
        self.modeSwitchTween = nil
    end
end

---@return table[]
function ProsperityPanel:GetModePanelList()
    return { self.mainMode, self.buildMode, self.walkMode }
end

---@return table[]
function ProsperityPanel:GetModeBtnList()
    return { self.mainBtn, self.buildBtn, self.walkBtn }
end

---@param panel table
---@param active boolean
---@param alpha number
function ProsperityPanel:SetModePanelState(panel, active, alpha)
    if not panel then
        return
    end
    panel:SetActive(active)
    if panel.canvasGroup then
        panel.canvasGroup.alpha = alpha
        panel.canvasGroup.interactable = active
        panel.canvasGroup.blocksRaycasts = active
    end
end

---@param mode integer
function ProsperityPanel:ApplyModeBtnSelect(mode)
    local btnList = self:GetModeBtnList()
    for i, btn in ipairs(btnList) do
        local isSelect = i == mode
        btn.isSelect:SetActive(isSelect)
    end
end

---@param mode integer
function ProsperityPanel:SetModeDirect(mode)
    self:KillModeSwitchTween()
    local modeList = self:GetModePanelList()
    for i, panel in ipairs(modeList) do
        self:SetModePanelState(panel, i == mode, i == mode and 1 or 0)
    end
    self.currentModeVisual = mode
end

---初始化
---@param keepCurrentMode boolean
function ProsperityPanel:SetView(keepCurrentMode)
    -- 默认回到MainMode，仅在从Walk编辑页返回时保留当前页签
    local mode = 1
    if keepCurrentMode then
        mode = self.nowSelectMode or 1
        if mode < 1 or mode > 3 then
            mode = 1
        end
    end
    self:SelectToggle(mode, true)
    self.confirmBtn:SetActive(false)
    self:SetMainModeView()
    self:SetBuildModeView()
    self:SetWalkModeView()
end

---@param mode integer
---@param immediate? boolean
function ProsperityPanel:SelectToggle(mode, immediate)
    local modeList = self:GetModePanelList()
    if mode < 1 or mode > #modeList then
        return
    end

    local prevMode = self.currentModeVisual or self.nowSelectMode or mode
    self.nowSelectMode = mode
    self:ApplyModeBtnSelect(mode)

    if immediate or prevMode == mode then
        self:SetModeDirect(mode)
    else
        self:KillModeSwitchTween()
        local fromPanel = modeList[prevMode]
        local toPanel = modeList[mode]
    for i, panel in ipairs(modeList) do
            if i ~= prevMode and i ~= mode then
                self:SetModePanelState(panel, false, 0)
            end
        end
        self:SetModePanelState(fromPanel, true, 1)
        self:SetModePanelState(toPanel, true, 0)
        self.modeSwitchTween = DG.Tweening.DOTween.Sequence()
        local hasFadeTween = false
        if fromPanel and fromPanel.canvasGroup then
            self.modeSwitchTween:Join(fromPanel.canvasGroup:DOFade(0, 0.12):SetEase(DG.Tweening.Ease.OutCubic))
            hasFadeTween = true
        end
        if toPanel and toPanel.canvasGroup then
            self.modeSwitchTween:Join(toPanel.canvasGroup:DOFade(1, 0.16):SetEase(DG.Tweening.Ease.OutCubic))
            hasFadeTween = true
        end
        if not hasFadeTween then
            self:SetModePanelState(fromPanel, false, 0)
            self:SetModePanelState(toPanel, true, 1)
            self.currentModeVisual = mode
            self.modeSwitchTween = nil
            return
        end
        self.modeSwitchTween:OnComplete(function()
            self:SetModePanelState(fromPanel, false, 0)
            self:SetModePanelState(toPanel, true, 1)
            self.currentModeVisual = mode
            self.modeSwitchTween = nil
        end)
    end

    if mode == 3 then
        self:SetWalkModeView()
    elseif mode == 2 then
        self:SetBuildModeView()
    elseif mode == 1 then
        self:RefreshMainModeDetailOnPush()
    end
end

-------------------BuildMode：建筑展示与交互------------------------------
---获取繁荣建筑配置列表（按id升序）
---@param group integer|nil
---@return table[]
function ProsperityPanel:GetProsperityConstructionCfgList(group)
    local allCfg = Config.GetAllConfig("ProsperityConstructionTable") or {}
    local cfgList = {}
    for key, cfg in pairs(allCfg) do
        if type(cfg) == "table" then
            local cfgGroup = tonumber(cfg.group) or 0
            if (not group) or cfgGroup == group then
            table.insert(cfgList, {
                cfg = cfg,
                sortId = tonumber(cfg.id) or tonumber(key) or 0,
            })
            end
        end
    end
    table.sort(cfgList, function(a, b)
        return (a.sortId or 0) < (b.sortId or 0)
    end)
    local result = {}
    for _, item in ipairs(cfgList) do
        table.insert(result, item.cfg)
    end
    return result
end

---确保BuildBox格子已创建（仅首次或数量扩容时创建）
---@param needCount integer
function ProsperityPanel:EnsureProsperityBuildBoxList(needCount)
    if not self.prosperityBuildBoxList then
        self.prosperityBuildBoxList = {}
    end
    local currentCount = #self.prosperityBuildBoxList
    if currentCount >= needCount then
        return
    end

    self:FillTemplateContent(self.buildBox, self.buildBoxList, needCount, function(index, buildBox)
        buildBox:SetActive(true)
        if not self.prosperityBuildBoxList[index] then
            self.prosperityBuildBoxList[index] = buildBox
        end
    end)
end

---刷新BuildBox占位显示（后续按规则逐步接入）
---@param buildBox ProsperityPanel_Generate_buildBox
---@param cfg table
---@param index integer
---@param runtime table
function ProsperityPanel:RefreshProsperityBuildBox(buildBox, cfg, index, runtime)
    local buildName = cfg.name
    buildBox.buildNameTxt.text.text = buildName
    buildBox.iconImg:SetActive(false)
    local iconName = cfg and cfg.icon
    if iconName then
        local token = (self.buildIconLoadTokenMap[index] or 0) + 1
        self.buildIconLoadTokenMap[index] = token
        local imgPath = string.format(Config.SpritePath.ProsperityBuildIcon, tostring(iconName))
        self:LoadSpriteAsync(imgPath, function(s)
            if self.buildIconLoadTokenMap[index] ~= token then
                return
            end
            buildBox.iconImg.image.sprite = s
            buildBox.iconImg:SetActive(true)
        end)
    end
    local hasLockedBuild = not (runtime and runtime.isBuilt)
    local isBuildGroup = runtime and (runtime.includeBuildCount or 0) > 1
    local canShowByUpType = tonumber(cfg and cfg.upType) == 1
    local showLevel = canShowByUpType and (not isBuildGroup) and (not hasLockedBuild)
    buildBox.levelBg:SetActive(showLevel)
    if showLevel then
        local level = 0
        if runtime and runtime.includeBuildDataList and runtime.includeBuildDataList[1] then
            level = runtime.includeBuildDataList[1].level or 0
        end
        buildBox.levelTxt.text.text = string.format("LV.%s", level)
    else
        buildBox.levelTxt.text.text = ""
    end
    local showEffect = (tonumber(cfg and cfg.output) or 0) ~= 0 and (not hasLockedBuild)
    buildBox.effectBg:SetActive(showEffect)
    buildBox.effectTitleValue.text.text = showEffect and "产量" or ""
    buildBox.itemIcon:SetActive(false)
    local outputValueTextComp = self:GetBuildBoxOutputValueTextComp(buildBox)
    if outputValueTextComp then
        outputValueTextComp.text = ""
    end
    if showEffect then
        local outputData = self:GetBuildOutputDisplayData(cfg, runtime)
        local outputPerHour = outputData and outputData.perHour or 0
        if outputValueTextComp then
            outputValueTextComp.text = string.format("%s/小时", self:FormatOutputPerHour(outputPerHour))
        end
        local outputItemId = outputData and outputData.itemId or 0
        local itemCfg = outputItemId > 0 and Config.GetItemInfo(outputItemId) or nil
        if itemCfg and itemCfg.icon then
            local token = (self.buildOutputIconLoadTokenMap[index] or 0) + 1
            self.buildOutputIconLoadTokenMap[index] = token
            local iconPath = string.format(Config.SpritePath.ItemIconPathSmall, itemCfg.icon)
            self:LoadSpriteAsync(iconPath, function(s)
                if self.buildOutputIconLoadTokenMap[index] ~= token then
                    return
                end
                buildBox.itemIcon.image.sprite = s
                buildBox.itemIcon:SetActive(true)
            end)
        else
            self.buildOutputIconLoadTokenMap[index] = (self.buildOutputIconLoadTokenMap[index] or 0) + 1
        end
    else
        self.buildOutputIconLoadTokenMap[index] = (self.buildOutputIconLoadTokenMap[index] or 0) + 1
    end
    buildBox.ticketIcon:SetActive(false)
    self:RefreshBuildBoxMsgState(buildBox, cfg, hasLockedBuild)
    buildBox.noOpenMask:SetActive(hasLockedBuild)
    local canLevelUp = false
    if canShowByUpType and (not hasLockedBuild) and (not isBuildGroup) and runtime and runtime.includeBuildDataList and runtime.includeBuildDataList[1] then
        local buildInfo = runtime.includeBuildDataList[1]
        local buildId = buildInfo.buildId
        local curLevel = buildInfo.level or 0
        if curLevel > 0 and buildId then
            local maxLv = Me.getHomeBuildingMaxLevel and Me:getHomeBuildingMaxLevel(buildId) or 0
            if maxLv == 0 or curLevel < maxLv then
                local nextCfg = Config.GetConstructionLevelInfoByTypeLevel(buildId, curLevel + 1)
                if nextCfg then
                    if nextCfg.restrain and #nextCfg.restrain > 0 then
                        canLevelUp = Me.canOpenFunctionByCfg and Me:canOpenFunctionByCfg(nextCfg.restrain) or false
                    else
                        canLevelUp = true
                    end
                end
            end
        end
    end
    buildBox.canLevelUp:SetActive(canLevelUp)
    buildBox.canBuild:SetActive(hasLockedBuild)

    if buildBox.bg and buildBox.bg.scaleButton then
        buildBox.bg.scaleButton.onClick:RemoveAllListeners()
        local skipId = self:GetBuildSkipId(cfg)
        local focusBuildId = self:GetBuildBoxFocusBuildId(cfg, runtime)
        if skipId > 0 then
            buildBox.bg.scaleButton.onClick:AddListener(function()
                self:OnBuildBoxClick(skipId, focusBuildId)
            end)
        end
    end
end

---解析建筑格子的通用跳转id（配置skip）
---@param cfg table
---@return integer
function ProsperityPanel:GetBuildSkipId(cfg)
    local skip = cfg and cfg.skip
    if skip == nil then
        return 0
    end
    local t = type(skip)
    if t == "number" or t == "string" then
        return tonumber(skip) or 0
    end
    if t == "table" then
        if skip.id ~= nil then
            return tonumber(skip.id) or 0
        end
        return tonumber(skip[1]) or 0
    end
    return 0
end

---@param cfg table
---@param runtime table
---@return integer
function ProsperityPanel:GetBuildBoxFocusBuildId(cfg, runtime)
    if runtime and runtime.includeBuildDataList then
        for _, v in pairs(runtime.includeBuildDataList) do
            if v and v.buildId and (v.level or 0) > 0 then
                return tonumber(v.buildId) or 0
            end
        end
        if runtime.includeBuildDataList[1] and runtime.includeBuildDataList[1].buildId then
            return tonumber(runtime.includeBuildDataList[1].buildId) or 0
        end
    end

    local includeBuild = cfg and cfg.includeBuild
    if type(includeBuild) == "table" and includeBuild[1] then
        return tonumber(includeBuild[1]) or 0
    end
    return 0
end

---@param buildId integer
function ProsperityPanel:FocusBuildById(buildId)
    if not buildId or buildId <= 0 then
        return
    end
    local coveMgr = CoveManager.instance()
    local buildMgr = coveMgr and coveMgr:getBuildingMgr()
    if buildMgr and buildMgr.FocusingBuild11 then
        buildMgr:FocusingBuild11(buildId)
    end
end

---@param skipId integer
---@param focusBuildId integer
function ProsperityPanel:OnBuildBoxClick(skipId, focusBuildId)
    if not skipId or skipId <= 0 then
        return
    end
    local canTurnTo = UICommonUtils.CanUseSkipJudge(skipId, true)
    if not canTurnTo then
        return
    end
    UIMgr:closeSpecificUI(self, nil, function()
        self:FocusBuildById(focusBuildId)
    end)
end

---@param value number
---@return string
function ProsperityPanel:FormatOutputPerHour(value)
    local num = tonumber(value) or 0
    if math.abs(num - math.floor(num + 0.0001)) < 0.0001 then
        return tostring(math.floor(num + 0.0001))
    end
    return string.format("%.1f", num)
end

---获取BuildBox产量文本组件（ValueTxt）
---@param buildBox ProsperityPanel_Generate_buildBox
---@return TMPro.TextMeshProUGUI|nil
function ProsperityPanel:GetBuildBoxOutputValueTextComp(buildBox)
    if buildBox._outputValueTextComp then
        return buildBox._outputValueTextComp
    end
    if not buildBox.effectBg then
        return nil
    end
    local valueTxtGo = buildBox.effectBg.transform:Find("ValueTxt")
    if not valueTxtGo then
        return nil
    end
    local textComp = valueTxtGo.gameObject:GetComponent(TypeInfo.TextMeshProUGUI)
    buildBox._outputValueTextComp = textComp
    return textComp
end

---获取BuildBox产出显示数据（道具id + 每小时产量）
---@param cfg table
---@param runtime table
---@return table|nil
function ProsperityPanel:GetBuildOutputDisplayData(cfg, runtime)
    local outputType = tonumber(cfg and cfg.output) or 0
    if outputType == 0 or not runtime or not runtime.includeBuildDataList then
        return nil
    end

    local sumByItemId = {}
    local firstItemId = nil
    for _, item in pairs(runtime.includeBuildDataList) do
        local buildId = item and item.buildId
        local level = item and (item.level or 0) or 0
        if buildId and level > 0 then
            local efficiency = Me:getHomeOutputEfficiency(buildId)
            if efficiency then
                for _, e in pairs(efficiency) do
                    local itemId = e and e[2]
                    local speed = tonumber(e and e[3]) or 0
                    if itemId and speed > 0 then
                        if not firstItemId then
                            firstItemId = itemId
                        end
                        sumByItemId[itemId] = (sumByItemId[itemId] or 0) + speed
                    end
                end
            end
        end
    end

    if not firstItemId then
        return {
            itemId = 0,
            perHour = 0
        }
    end
    return {
        itemId = firstItemId,
        perHour = sumByItemId[firstItemId] or 0
    }
end

---获取BuildBox的MsgTitle文字组件（兼容Generate未强类型声明的情况）
---@param buildBox ProsperityPanel_Generate_buildBox
---@return TMPro.TextMeshProUGUI|nil
function ProsperityPanel:GetBuildBoxMsgTitleTextComp(buildBox)
    if buildBox.msgTitleValue and buildBox.msgTitleValue.text then
        return buildBox.msgTitleValue.text
    end
    if buildBox._msgTitleTextComp then
        return buildBox._msgTitleTextComp
    end
    if not buildBox.msgBg or not buildBox.msgBg.gameObject then
        return nil
    end
    local msgTitleGo = buildBox.msgBg.gameObject.transform:Find("MsgTitleValue")
    if not msgTitleGo then
        return nil
    end
    local textComp = msgTitleGo.gameObject:GetComponent(TypeInfo.TextMeshProUGUI)
    buildBox._msgTitleTextComp = textComp
    return textComp
end

---是否存在任意可显示情报（复用情报面板的可见判定思路）
---@return boolean
function ProsperityPanel:HasAnyIntelligenceInfo()
    local intelligenceCfg = Config.GetIntelligenceTable()
    if intelligenceCfg then
        for _, v in pairs(intelligenceCfg) do
            if v.page ~= 2 and Me:canOpenFunctionByCfg(v.show) then
                local levelData = Me:getLevelDataByid(v.id)
                if levelData == nil or (levelData.completeNum or 0) <= 0 then
                    return true
                end
            end
        end
    end

    local infoData = Me:GetCombatIngelligenctInfo()
    if infoData then
        local serverTime = EngineUtil.ServerTime_Seconds()
        for _, v in pairs(infoData) do
            local infoCfg = Config.GetIntelligenceById(v.id)
            if infoCfg and not v.finish and serverTime <= (v.createTime + infoCfg.countDown) then
                return true
            end
        end
    end
    return false
end

---刷新BuildBox的MsgBg与MsgTitleValue显示
---@param buildBox ProsperityPanel_Generate_buildBox
---@param cfg table
---@param hasLockedBuild boolean
function ProsperityPanel:RefreshBuildBoxMsgState(buildBox, cfg, hasLockedBuild)
    buildBox.msgBg:SetActive(false)
    local msgTextComp = self:GetBuildBoxMsgTitleTextComp(buildBox)
    if msgTextComp then
        msgTextComp.text = ""
    end

    if hasLockedBuild then
        buildBox.msgBg:SetActive(true)
        if msgTextComp then
            msgTextComp.text = "待建设"
            msgTextComp.color = Color.NewFromStr("FFFFFF")
        end
        if buildBox.msgBg.image then
            buildBox.msgBg.image.color = Color.NewFromStr("A2B2C7")
        end
        return
    end

    if tonumber(cfg and cfg.extraFunction) == 1 then
        local openState = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.CombatIntelligenct)
        if openState ~= GE.FunctionOpenState.Open then
            buildBox.msgBg:SetActive(true)
            if msgTextComp then
                msgTextComp.text = "待建设"
                msgTextComp.color = Color.NewFromStr("FFFFFF")
            end
            if buildBox.msgBg.image then
                buildBox.msgBg.image.color = Color.NewFromStr("A2B2C7")
            end
            return
        end

        local hasInfo = self:HasAnyIntelligenceInfo()
        buildBox.msgBg:SetActive(true)
        if buildBox.msgBg.image then
            buildBox.msgBg.image.color = Color.NewFromStr(hasInfo and "FAE864" or "A2B2C7")
        end
        if msgTextComp then
            msgTextComp.text = hasInfo and "情报出现" or "暂无情报"
            msgTextComp.color = Color.NewFromStr(hasInfo and "944F1E" or "FFFFFF")
        end
    end
end

---获取家园建筑总映射
---@return table
function ProsperityPanel:GetHomelandBuildingMap()
    local homeland = Me and Me:getHomeland()
    if not homeland or not homeland.buildingList then
        return {}
    end
    return homeland.buildingList
end

---根据建筑id获取当前建筑数据（优先玩家接口，其次直接读buildingList）
---@param buildId integer
---@param buildingMap table
---@return table|nil
function ProsperityPanel:GetCurrentBuildingData(buildId, buildingMap)
    if Me.getConstructionDataById then
        local data = Me:getConstructionDataById(buildId)
        if data then
            return data
        end
    end
    return buildingMap[buildId]
end

---收集繁荣建筑格子的包含建筑当前数据（includeBuild支持建筑群）
---@param cfg table
---@return table
function ProsperityPanel:CollectProsperityBuildRuntime(cfg)
    local includeBuild = (cfg and cfg.includeBuild) or {}
    local buildingMap = self:GetHomelandBuildingMap()
    local includeBuildDataList = {}
    local totalLevel = 0
    local unlockedCount = 0

    for _, rawBuildId in pairs(includeBuild) do
        local buildId = tonumber(rawBuildId) or rawBuildId
        local buildData = self:GetCurrentBuildingData(buildId, buildingMap)
        local level = (buildData and buildData.level) or 0
        if level > 0 then
            unlockedCount = unlockedCount + 1
        end
        totalLevel = totalLevel + level
        table.insert(includeBuildDataList, {
            buildId = buildId,
            buildData = buildData,
            level = level,
        })
    end

    return {
        includeBuild = includeBuild,
        includeBuildDataList = includeBuildDataList,
        includeBuildCount = #includeBuild,
        unlockedCount = unlockedCount,
        isBuilt = unlockedCount > 0,
        totalLevel = totalLevel,
    }
end

---刷新BuildMode列表（先生成并复用格子，后续再补具体显示规则）
function ProsperityPanel:RefreshProsperityBuildList()
    self.prosperityBuildCfgList = self:GetProsperityConstructionCfgList(self.selectedBuildGroup)
    self.prosperityBuildRuntimeList = {}
    local needCount = #self.prosperityBuildCfgList
    self:EnsureProsperityBuildBoxList(needCount)

    for index, buildBox in ipairs(self.prosperityBuildBoxList or {}) do
        local cfg = self.prosperityBuildCfgList[index]
        local needShow = cfg ~= nil
        buildBox:SetActive(needShow)
        if needShow then
            local runtime = self:CollectProsperityBuildRuntime(cfg)
            self.prosperityBuildRuntimeList[index] = runtime
            self:RefreshProsperityBuildBox(buildBox, cfg, index, runtime)
        elseif buildBox.bg and buildBox.bg.scaleButton then
            buildBox.bg.scaleButton.onClick:RemoveAllListeners()
        end
    end
    self:RefreshBuildAllGetBtnState()
end

---判断是否存在可一键领取的建筑资源
---@return boolean
function ProsperityPanel:HasAnyBuildRewardCanCollect()
    local homeland = Me and Me:getHomeland()
    if not homeland or not homeland.buildingList then
        return false
    end

    -- 与服务端 oneKeyCollectHomelandResource 保持一致：
    -- 只检查 ProsperityConstructionTable 中 output=1/2 对应 includeBuild 的建筑
    local collectBuildIdMap = {}
    local prosperityConstructionCfg = Config.GetAllConfig("ProsperityConstructionTable") or {}
    for _, cfg in pairs(prosperityConstructionCfg) do
        local outputType = tonumber(cfg.output) or 0
        if outputType == 1 or outputType == 2 then
            for _, rawBuildId in pairs(cfg.includeBuild or {}) do
                local buildId = tonumber(rawBuildId)
                if buildId then
                    collectBuildIdMap[buildId] = true
                end
            end
        end
    end

    for buildId, _ in pairs(collectBuildIdMap) do
        local buildData = homeland.buildingList[buildId]
        local output = buildData and buildData.output
        if output and #output > 0 then
            for _, reward in pairs(output) do
                if reward and (reward.num or 0) > 0 then
                    return true
                end
            end
        end
    end
    return false
end

---刷新BuildMode一键领取按钮显示
function ProsperityPanel:RefreshBuildAllGetBtnState()
    local canCollect = self:HasAnyBuildRewardCanCollect()
    self.allGetBtn.canGet:SetActive(canCollect)
    self.allGetBtn.noneBg:SetActive(not canCollect)
end

---刷新BuildMode二级toggle选中态
function ProsperityPanel:RefreshBuildModeToggleSelect()
    local isFunction = self.selectedBuildGroup == 1
    self.functionBtn.isSelect:SetActive(isFunction)
    self.outputBtn.isSelect:SetActive(not isFunction)
end

---关闭并清理BuildGroup切换动画Tween
function ProsperityPanel:KillBuildGroupSwitchTween()
    if self.buildGroupSwitchTween then
        self.buildGroupSwitchTween:Kill()
        self.buildGroupSwitchTween = nil
    end
end

---@param group integer
function ProsperityPanel:SelectBuildGroup(group)
    if group ~= 1 and group ~= 2 then
        return
    end
    if self.selectedBuildGroup == group then
        return
    end
    self:KillBuildGroupSwitchTween()
    local prevGroup = self.selectedBuildGroup
    self.selectedBuildGroup = group
    self:RefreshBuildModeToggleSelect()

    local cg = self.buildBoxList and self.buildBoxList.canvasGroup
    if not cg then
        self:RefreshProsperityBuildList()
        return
    end

    self.selectedBuildGroup = prevGroup
    cg.alpha = 1
    self.buildGroupSwitchTween = DG.Tweening.DOTween.Sequence()
    self.buildGroupSwitchTween:Append(cg:DOFade(0, 0.1):SetEase(DG.Tweening.Ease.OutCubic))
    self.buildGroupSwitchTween:AppendCallback(function()
        self.selectedBuildGroup = group
        self:RefreshProsperityBuildList()
    end)
    self.buildGroupSwitchTween:Append(cg:DOFade(1, 0.14):SetEase(DG.Tweening.Ease.OutCubic))
    self.buildGroupSwitchTween:OnComplete(function()
        self.buildGroupSwitchTween = nil
    end)
end

---设置建造模式显示
function ProsperityPanel:SetBuildModeView()
    if self.selectedBuildGroup ~= 1 and self.selectedBuildGroup ~= 2 then
        self.selectedBuildGroup = 1
    end
    self:KillBuildGroupSwitchTween()
    if self.buildBoxList and self.buildBoxList.canvasGroup then
        self.buildBoxList.canvasGroup.alpha = 1
    end
    self:RefreshBuildModeToggleSelect()
    self:RefreshProsperityBuildList()
end

---一键收集家园资源后回刷BuildMode状态
function ProsperityPanel:OnHomelandOneKeyCollected()
    if self.nowSelectMode == 2 then
        self:SetBuildModeView()
    else
        self:RefreshBuildAllGetBtnState()
    end
end

-------------------WalkMode：散步角色展示与交互------------------------------
---获取散步点位列表（Point_1 ~ Point_10）
---@return UnityEngine.GameObject[]
function ProsperityPanel:GetWalkPointList()
    if #self.walkPointList > 0 then
        return self.walkPointList
    end

    self.walkPointList = {
        self.point_1, self.point_2, self.point_3, self.point_4, self.point_5,
        self.point_6, self.point_7, self.point_8, self.point_9, self.point_10,
    }
    return self.walkPointList
end

---确保散步角色格子已挂到每个点位下（每个点位1个）
function ProsperityPanel:EnsureWalkRoleBoxList()
    if #self.walkRoleBoxList > 0 then
        return
    end

    local pointList = self:GetWalkPointList()
    for index = 1, #pointList do
        local point = pointList[index]
        if point then
            local pointIndex = index
            self:FillTemplateContent(self.walkRoleBox, point, 1, function(_, walkRoleBox)
                walkRoleBox:SetActive(false)
                self.walkRoleBoxList[pointIndex] = walkRoleBox
            end)
        end
    end
end

---获取散步模式实际展示上限（受点位和散步可上阵人数双重限制）
---@return integer
function ProsperityPanel:GetWalkDisplayMaxCount()
    local pointCount = #(self:GetWalkPointList() or {})
    local maxWalkCount = Me and Me.getMaxWalkRoleCount and Me:getMaxWalkRoleCount() or pointCount
    maxWalkCount = tonumber(maxWalkCount) or pointCount
    if maxWalkCount < 0 then
        maxWalkCount = 0
    end
    if pointCount <= 0 then
        return maxWalkCount
    end
    return math.min(pointCount, maxWalkCount)
end

---角色是否处于家园工作/部署中（工作中角色不应展示在散步列表）
---@param roleId integer
---@return boolean
function ProsperityPanel:IsRoleInHomeWork(roleId)
    if not roleId or roleId <= 0 then
        return false
    end
    if Me and Me.roleInHomeDispose and Me:roleInHomeDispose(roleId) then
        return true
    end
    if Me and Me.GetHeroWorkingRoom and (Me:GetHeroWorkingRoom(roleId) or 0) ~= 0 then
        return true
    end
    return false
end

---设置散步模式显示
function ProsperityPanel:SetWalkModeView()
    self:EnsureWalkRoleBoxList()

    local walkRoleIdList = self:GetWalkDisplayRoleIdList()
    local maxPoint = self:GetWalkDisplayMaxCount()
    local walkCount = 0
    local pointCount = #(self.walkRoleBoxList or {})
    for index = 1, pointCount do
        local roleId = walkRoleIdList[index]
        local walkRoleBox = self.walkRoleBoxList[index]
        if walkRoleBox then
            if roleId and roleId > 0 then
                walkRoleBox:SetActive(true)
                self:RefreshWalkRoleBox(index, walkRoleBox, roleId)
                walkCount = walkCount + 1
            else
                walkRoleBox:SetActive(false)
            end
        end
    end

    self.walkCountTxt.text.text = tostring(walkCount)
end

---获取散步模式展示角色列表（兼容手动散步和随机散步）
---@return integer[]
function ProsperityPanel:GetWalkDisplayRoleIdList()
    local result = {}
    local roleIdSet = {}
    local maxPoint = self:GetWalkDisplayMaxCount()
    if maxPoint <= 0 then
        return result
    end
    local homeland = Me and Me:getHomeland()
    local walkHeroList = (homeland and homeland.homeWalkHeroList) or {}

    -- 优先展示手动设置的散步列表（保留原顺序）
    for i = 1, #walkHeroList do
        local roleId = tonumber(walkHeroList[i]) or 0
        if roleId > 0 and (not roleIdSet[roleId]) and (not self:IsRoleInHomeWork(roleId)) then
            roleIdSet[roleId] = true
            table.insert(result, roleId)
            if #result >= maxPoint then
                return result
            end
        end
    end

    -- 兜底补充随机散步角色（rolePreRoom）
    local rolePreRoom = homeland and homeland.rolePreRoom or (Me and Me.getRolePreRoom and Me:getRolePreRoom()) or {}
    for roleId, _ in pairs(rolePreRoom) do
        local id = tonumber(roleId) or 0
        if id > 0 and (not roleIdSet[id]) and (not self:IsRoleInHomeWork(id)) then
            roleIdSet[id] = true
            table.insert(result, id)
            if #result >= maxPoint then
                break
            end
        end
    end

    return result
end

---刷新单个散步角色格子
---@param index integer
---@param walkRoleBox ProsperityPanel_Generate_walkRoleBox
---@param roleId integer
function ProsperityPanel:RefreshWalkRoleBox(index, walkRoleBox, roleId)
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        walkRoleBox:SetActive(false)
        return
    end

    local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
    if not skinConfig then
        walkRoleBox:SetActive(false)
        return
    end

    local resourceFolder = nil
    if tonumber(skinConfig.resourceFolder) ~= nil then
        resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
    else
        resourceFolder = skinConfig.resourceFolder
    end

    walkRoleBox.roleImg:SetActive(false)
    local token = (self.walkRoleLoadTokenMap[index] or 0) + 1
    self.walkRoleLoadTokenMap[index] = token
    local imgPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
    self:LoadSpriteAsync(imgPath, function(s)
        if self.walkRoleLoadTokenMap[index] ~= token then
            return
        end
        walkRoleBox.roleImg.image.sprite = s
        walkRoleBox.roleImg:SetActive(true)
    end)

    local hasAffectionEvent = (roleData.affectionEvent or 0) ~= 0
    walkRoleBox.eventImg:SetActive(hasAffectionEvent)

    local goToBtnScale = walkRoleBox.goToBtn:GetComponent(TypeInfo.ScaleButton)
    if goToBtnScale then
        goToBtnScale.onClick:RemoveAllListeners()
        goToBtnScale.onClick:AddListener(function()
            self:OnWalkRoleGoToBtnClick(roleId, index)
        end)
    end
end

---散步角色GoTo按钮点击：关闭当前界面后聚焦并跟随角色
---@param roleId integer
---@param index integer
function ProsperityPanel:OnWalkRoleGoToBtnClick(roleId, index)
    if not roleId or roleId <= 0 then
        return
    end

    self:RequestCloseWithAnim(function()
        local coveMgr = CoveManager.instance()
        if not coveMgr then
            return
        end
        local roleMgr = coveMgr:getRoleMgr()
        local role = roleMgr and roleMgr:getRole(roleId)
        if not role or not role.modelObj or not UICommonUtils.Checkobj(role.modelObj) then
            return
        end

        local rolePos = role.modelObj.transform.position
        coveMgr:LookAtPos(GE.HomeLandPerspectiveType.Whole, rolePos, {time = 0.5}, function()
            coveMgr:SetCameraFollowRoleId(roleId)
        end)
    end)
end

---散步角色变更后回刷WalkMode显示
function ProsperityPanel:OnRoleWalkChange()
    self:SetWalkModeView()
end

---家园数据刷新后，若当前在散步页则立即回刷（覆盖随机散步角色变更场景）
function ProsperityPanel:OnRefreshHomeland()
    if self.nowSelectMode ~= 3 then
        return
    end
    self:SetWalkModeView()
end

-------------------MainMode：推送刷新与详情展示------------------------------
---同步并刷新主模式信息（推送更新后使用，避免整页重建）
function ProsperityPanel:RefreshMainModeDetailOnPush()
    local homeland = Me and Me:getHomeland()
    if homeland and homeland.prosperityInfo then
        self.prosperityInfo = homeland.prosperityInfo
    end

    if self.nowSelectMode ~= 1 then
        return
    end

    local totalProsperity = (self.prosperityInfo.globalConditionProgress and self.prosperityInfo.globalConditionProgress[GE.MissionFinishType.Prosperity]) or 0
    self.prosperityValueTxt.text.text = totalProsperity
    self:RefreshProsperityLevelSelectState()
    self:ShowProsperityLevelDetail(self.selectedProsperityLevel)
end

---任务推送后刷新主模式详情（修复领取按钮状态滞后）
function ProsperityPanel:OnMissionRefresh()
    self:RefreshMainModeDetailOnPush()
end

---繁荣度数据推送后刷新主模式详情
function ProsperityPanel:OnProsperityInfoUpdate()
    self:RefreshMainModeDetailOnPush()
end

function ProsperityPanel:SetMainModeView()
    local totalProsperity = (self.prosperityInfo.globalConditionProgress and self.prosperityInfo.globalConditionProgress[GE.MissionFinishType.Prosperity]) or 0
    self.prosperityValueTxt.text.text = totalProsperity

    local allProsperityCfg = Config.GetAllConfig("ProsperityTable") or {}
    local levelCfgList = {}
    for _, cfg in pairs(allProsperityCfg) do
        table.insert(levelCfgList, cfg)
    end
    table.sort(levelCfgList, function(a, b)
        return a.id < b.id
    end)
    self.mainModeLevelCfgList = levelCfgList

    local currentLevel = self.prosperityInfo.currentLevel or 0
    local createCount = 0
    self.prosperityLevelBoxList = {}
    self:FillTemplateContent(self.prosLevelBox, self.prosLevelList, #levelCfgList, function(index, prosLevelBox)
        prosLevelBox:SetActive(true)
        self.prosperityLevelBoxList[index] = prosLevelBox

        local levelCfg = levelCfgList[index]
        local level = levelCfg and levelCfg.id or index
        local levelTxt = tostring(level)
        prosLevelBox.prosLevel.text.text = levelTxt
        prosLevelBox.prosLevelOn.text.text = levelTxt

        local isFinished = level <= currentLevel
        local isLock = level > (currentLevel + 1)
        prosLevelBox.isOn:SetActive(isFinished)
        prosLevelBox.isLock:SetActive(isLock)
        prosLevelBox.isSelect:SetActive(false)

        prosLevelBox.btn.scaleButton.onClick:RemoveAllListeners()
        prosLevelBox.btn.scaleButton.onClick:AddListener(function()
            self:OnProsperityLevelBoxClick(level)
        end)

        createCount = createCount + 1
        if createCount >= #levelCfgList then
            LuaLogger.ds("[ProsperityPanel] MainMode等级列表创建完成，数量 = ", createCount)

            -- 默认选中“已解锁的最后一个等级”（非锁定区间中的最高等级）
            local unlockedMaxLevel = currentLevel + 1
            local selectedLevel = (levelCfgList[1] and levelCfgList[1].id) or 0
            for i = #levelCfgList, 1, -1 do
                local cfg = levelCfgList[i]
                local cfgLevel = (cfg and cfg.id) or i
                if cfgLevel <= unlockedMaxLevel then
                    selectedLevel = cfgLevel
                    break
                end
            end

            self:SelectProsperityLevel(selectedLevel)
        end
    end)
end

---点击繁荣等级格子
---@param level integer
function ProsperityPanel:OnProsperityLevelBoxClick(level)
    if self.selectedProsperityLevel == level then
        return
    end
    self:SelectProsperityLevel(level)
end

---设置当前选中繁荣等级并刷新列表显示
---@param level integer
function ProsperityPanel:SelectProsperityLevel(level)
    self.selectedProsperityLevel = level or 0
    self:RefreshProsperityLevelSelectState()
    self:ShowProsperityLevelDetail(self.selectedProsperityLevel)
end

---刷新等级格子的单选状态
function ProsperityPanel:RefreshProsperityLevelSelectState()
    local currentLevel = self.prosperityInfo.currentLevel or 0
    for index, prosLevelBox in ipairs(self.prosperityLevelBoxList or {}) do
        local levelCfg = self.mainModeLevelCfgList[index]
        local level = levelCfg and levelCfg.id or index
        local isFinished = level <= currentLevel
        local isLock = level > (currentLevel + 1)
        local isSelected = level == self.selectedProsperityLevel

        prosLevelBox.isOn:SetActive(isFinished)
        prosLevelBox.isLock:SetActive(isLock)
        prosLevelBox.isSelect:SetActive(isSelected)
    end
end

---显示选中等级对应详情
---@param level integer
function ProsperityPanel:ShowProsperityLevelDetail(level)
    local levelCfg = self:GetProsperityLevelCfg(level)
    if not levelCfg or not levelCfg.levelTask then
        self:RefreshProsperityConfirmBtn(0)
        self:RefreshProsperityLevelEffectList({}, false, true)
        self:RefreshProsperityTaskList({})
        self:RefreshProsperityRewardList({})
        return
    end

    self:RefreshProsperityConfirmBtn(levelCfg.levelTask)

    local effectShowList = levelCfg.effectShow
    local hasEffectShow = type(effectShowList) == "table" and #effectShowList > 0
    local isLevelReached = (self.prosperityInfo.currentLevel or 0) >= (levelCfg.id or 0)
    if hasEffectShow then
        self:RefreshProsperityLevelEffectList(effectShowList, isLevelReached, false)
    else
        self:RefreshProsperityLevelEffectList({}, false, true)
    end

    local levelTaskCfg = Config.GetTaskTableInfo(levelCfg.levelTask)
    if not levelTaskCfg or type(levelTaskCfg.complete) ~= "table" then
        self:RefreshProsperityTaskList({})
        self:RefreshProsperityRewardList({})
        return
    end

    local subTaskIds = levelTaskCfg.complete[2]
    local levelTaskData = Me:getMissionListById(levelCfg.levelTask)
    local isRewardGet = levelTaskData and levelTaskData.state == GE.MissionState.Received
    if type(subTaskIds) ~= "table" then
        self:RefreshProsperityTaskList({})
        self:RefreshProsperityRewardList(levelTaskCfg.Award or {}, isRewardGet)
        return
    end

    local showTaskIds = {}
    local canPreviewTask = (levelCfg.id or 0) <= ((self.prosperityInfo.currentLevel or 0) + 1)
    if canPreviewTask then
        for i = 1, #subTaskIds do
            showTaskIds[#showTaskIds + 1] = subTaskIds[i]
        end
    end
    self:RefreshProsperityTaskList(showTaskIds)
    self:RefreshProsperityRewardList(levelTaskCfg.Award or {}, isRewardGet)
end

---获取等级配置
---@param level integer
---@return ProsperityTable?
function ProsperityPanel:GetProsperityLevelCfg(level)
    local targetLevel = tonumber(level) or 0
    for _, cfg in ipairs(self.mainModeLevelCfgList or {}) do
        if cfg.id == targetLevel then
            return cfg
        end
    end
    return nil
end

---获取当前选中等级的剧情id
---@return integer
function ProsperityPanel:GetSelectedProsperityStoryId()
    local levelCfg = self:GetProsperityLevelCfg(self.selectedProsperityLevel)
    local storyId = tonumber(levelCfg and levelCfg.storyId) or 0
    return storyId
end

---确保等级效果格子已创建（仅首次或数量扩容时创建）
---@param needCount integer
function ProsperityPanel:EnsureProsperityLevelEffectBoxList(needCount)
    if not self.prosperityLevelEffectBoxList then
        self.prosperityLevelEffectBoxList = {}
    end
    local currentCount = #self.prosperityLevelEffectBoxList
    if currentCount >= needCount then
        return
    end

    self:FillTemplateContent(self.levelEffectBox, self.levelEffectList, needCount, function(index, effectBox)
        effectBox:SetActive(true)
        if not self.prosperityLevelEffectBoxList[index] then
            self.prosperityLevelEffectBoxList[index] = effectBox
        end
    end)
end

---刷新等级效果列表
---@param effectShowList string[]
---@param isLevelReached boolean
---@param forceShowNone boolean
function ProsperityPanel:RefreshProsperityLevelEffectList(effectShowList, isLevelReached, forceShowNone)
    local showNone = forceShowNone or not effectShowList or #effectShowList == 0
    local needCount = showNone and 1 or #effectShowList
    self:EnsureProsperityLevelEffectBoxList(needCount)

    for index, effectBox in ipairs(self.prosperityLevelEffectBoxList or {}) do
        local needShow = index <= needCount
        effectBox:SetActive(needShow)
        if needShow then
            if showNone then
                self:RefreshProsperityLevelEffectBoxNone(effectBox)
            else
                self:RefreshProsperityLevelEffectBox(effectBox, effectShowList[index], isLevelReached)
            end
        end
    end
end

---刷新单个等级效果格子
---@param effectBox ProsperityPanel_Generate_levelEffectBox
---@param effectShowKey string
---@param isLevelReached boolean
function ProsperityPanel:RefreshProsperityLevelEffectBox(effectBox, effectShowKey, isLevelReached)
    effectBox.noneBg:SetActive(false)
    effectBox.taskBg:SetActive(true)
    effectBox.isGet:SetActive(isLevelReached)

    local showText = ""
    if effectShowKey and LocalStrEnum and LocalStrEnum[effectShowKey] then
        showText = LocalStrEnum[effectShowKey]
    elseif effectShowKey then
        showText = tostring(effectShowKey)
    end
    effectBox.taskMsgTxt.text.text = showText
end

---刷新空等级效果格子（显示NoneBg）
---@param effectBox ProsperityPanel_Generate_levelEffectBox
function ProsperityPanel:RefreshProsperityLevelEffectBoxNone(effectBox)
    effectBox.noneBg:SetActive(true)
    effectBox.taskBg:SetActive(false)
    effectBox.isGet:SetActive(false)
    effectBox.taskMsgTxt.text.text = ""
end

---确保任务格子已创建（仅首次创建）
function ProsperityPanel:EnsureProsperityTaskBoxList()
    if self.prosperityTaskBoxList and #self.prosperityTaskBoxList > 0 then
        return
    end

    self.prosperityTaskBoxList = {}
    self:FillTemplateContent(self.taskBox, self.taskList, 3, function(index, taskBox)
        taskBox:SetActive(true)
        self.prosperityTaskBoxList[index] = taskBox

        -- 首次创建时也立即应用当前待展示数据，避免默认选中首帧空文案
        local taskId = self.pendingProsperityTaskIds and self.pendingProsperityTaskIds[index]
        if taskId then
            self:RefreshProsperityTaskBox(taskBox, taskId)
        else
            self:RefreshProsperityTaskBoxEmpty(taskBox)
        end
    end)
end

---刷新繁荣度任务列表（仅更新已有格子数据）
---@param taskIds integer[]
function ProsperityPanel:RefreshProsperityTaskList(taskIds)
    self.pendingProsperityTaskIds = taskIds or {}
    self:EnsureProsperityTaskBoxList()

    for index, taskBox in ipairs(self.prosperityTaskBoxList or {}) do
        local taskId = self.pendingProsperityTaskIds[index]
        local needShow = taskId ~= nil
        taskBox:SetActive(true)

        if needShow then
            self:RefreshProsperityTaskBox(taskBox, taskId)
        else
            self:RefreshProsperityTaskBoxEmpty(taskBox)
        end
    end
end

---刷新单个任务格子
---@param taskBox ProsperityPanel_Generate_taskBox
---@param taskId integer
function ProsperityPanel:RefreshProsperityTaskBox(taskBox, taskId)
    local taskCfg = Config.GetTaskTableInfo(taskId)
    local taskData = Me:getMissionListById(taskId)
    if not taskCfg or not taskData then
        self:RefreshProsperityTaskBoxEmpty(taskBox)
        return
    end

    taskBox.noneBg:SetActive(false)
    taskBox.taskBg:SetActive(true)

    local progressTarget = Me:getTaskProgressTarget(taskId, GE.MissionSystemType.task)
    local progress = taskData.progress or 0
    local showProgress = progressTarget > 0 and math.min(progress, progressTarget) or progress
    local taskName = taskCfg.taskName or ""
    if taskCfg.complete
        and taskCfg.complete[1] == GE.MissionFinishType.Prosperity
        and progressTarget > 0 then
        taskBox.taskMsgTxt.text.text = string.format("%s(<color=#f26018>%s</color>/%s)", taskName, showProgress, progressTarget)
    else
        taskBox.taskMsgTxt.text.text = taskName
    end

    -- 已完成：待领取/已领取都算完成
    local isCompleted = taskData.state == GE.MissionState.Unclaimed or taskData.state == GE.MissionState.Received
    taskBox.isGet:SetActive(isCompleted)

    local canJump = (taskCfg.TurnTo ~= nil and taskCfg.TurnTo ~= 0) and (not isCompleted)
    taskBox.jumpToBtn:SetActive(canJump)
    taskBox.jumpToBtn.scaleButton.onClick:RemoveAllListeners()
    if canJump then
        taskBox.jumpToBtn.scaleButton.onClick:AddListener(function()
            local canTurnTo = UICommonUtils.CanUseSkipJudge(taskCfg.TurnTo, true)
            if canTurnTo then
                UICommonUtils.CommonTurnTo(taskCfg.TurnTo)
            end
        end)
    end
end

---刷新空任务格子（显示NoneBg，关闭TaskBg）
---@param taskBox ProsperityPanel_Generate_taskBox
function ProsperityPanel:RefreshProsperityTaskBoxEmpty(taskBox)
    taskBox.noneBg:SetActive(true)
    taskBox.taskBg:SetActive(false)
    taskBox.isGet:SetActive(false)
    taskBox.jumpToBtn:SetActive(false)
    taskBox.jumpToBtn.scaleButton.onClick:RemoveAllListeners()
end

---确保奖励格子已创建（仅首次或数量扩容时创建）
---@param needCount integer
function ProsperityPanel:EnsureProsperityRewardBoxList(needCount)
    if not self.prosperityRewardBoxList then
        self.prosperityRewardBoxList = {}
    end
    local currentCount = #self.prosperityRewardBoxList
    if currentCount >= needCount then
        return
    end

    self:FillTemplateContent(self.customBox, self.rewardList, needCount, function(index, rewardBox)
        rewardBox:SetActive(true)
        if not self.prosperityRewardBoxList[index] then
            self.prosperityRewardBoxList[index] = rewardBox
        end

        -- 首次创建时也立即应用当前待展示奖励，避免默认选中首帧空内容
        local rewardData = self.pendingProsperityRewardList and self.pendingProsperityRewardList[index]
        if rewardData then
            if not rewardBox._prosperityMonoSet then
                rewardBox.customBox:setMono(self)
                rewardBox._prosperityMonoSet = true
            end
            rewardBox._lastRewardType = rewardData[1]
            rewardBox._lastRewardId = rewardData[2]
            rewardBox._lastRewardCount = rewardData[3]
            rewardBox.customBox:SetUIData(rewardData, {navType = GE.NavigationType.TaskPanel, isGet = self.pendingProsperityRewardIsGet})
        else
            rewardBox:SetActive(false)
        end
    end)
end

---刷新繁荣等级奖励列表（复用已生成格子，仅改数据）
---@param rewardList RewardInfo[]|integer[][]
---@param isGet boolean?
function ProsperityPanel:RefreshProsperityRewardList(rewardList, isGet)
    self.pendingProsperityRewardList = rewardList or {}
    self.pendingProsperityRewardIsGet = isGet
    local count = #self.pendingProsperityRewardList
    self:EnsureProsperityRewardBoxList(count)

    for index, rewardBox in ipairs(self.prosperityRewardBoxList or {}) do
        local rewardData = self.pendingProsperityRewardList[index]
        local needShow = rewardData ~= nil
        rewardBox:SetActive(needShow)

        if needShow then
            if not rewardBox._prosperityMonoSet then
                rewardBox.customBox:setMono(self)
                rewardBox._prosperityMonoSet = true
            end

            local changed = rewardBox._lastRewardType ~= rewardData[1]
                or rewardBox._lastRewardId ~= rewardData[2]
                or rewardBox._lastRewardCount ~= rewardData[3]
                or rewardBox._lastRewardIsGet ~= isGet
            if changed then
                rewardBox._lastRewardType = rewardData[1]
                rewardBox._lastRewardId = rewardData[2]
                rewardBox._lastRewardCount = rewardData[3]
                rewardBox._lastRewardIsGet = isGet
                rewardBox.customBox:SetUIData(rewardData, {navType = GE.NavigationType.TaskPanel, isGet = isGet})
            end
        end
    end
end

---获取下一级繁荣等级主任务 id（currentLevel + 1）
---@param currentLevel integer
---@return integer
function ProsperityPanel.GetNextProsperityLevelTaskId(currentLevel)
    local targetLevel = (currentLevel or 0) + 1
    local levelCfg = Config.GetProsperityInfoBylevelTask(targetLevel)
    return levelCfg and levelCfg.levelTask or 0
end

---判断繁荣等级任务是否可领取（静态，主界面红点等复用）
---@param levelTaskId integer
---@param currentLevel integer
---@return boolean
function ProsperityPanel.CanClaimProsperityLevelTaskStatic(levelTaskId, currentLevel)
    local taskId = tonumber(levelTaskId) or 0
    if taskId <= 0 then
        return false
    end

    local level = currentLevel or 0
    local levelCfg = Config.GetProsperityInfoBylevelTask(taskId)
    if not levelCfg or levelCfg.id ~= (level + 1) then
        return false
    end

    local taskData = Me:getMissionListById(taskId)
    if not taskData then
        return false
    end

    if taskData.state == GE.MissionState.Unclaimed then
        return true
    end
    if taskData.state == GE.MissionState.Received or taskData.state == GE.MissionState.Lock then
        return false
    end
    if taskData.state ~= GE.MissionState.Progress then
        return false
    end

    local taskCfg = Config.GetTaskTableInfo(taskId)
    local completeCfg = taskCfg and taskCfg.complete
    local subTaskIds = completeCfg and completeCfg[2]
    if type(subTaskIds) ~= "table" or #subTaskIds <= 0 then
        return false
    end

    for i = 1, #subTaskIds do
        local subTaskData = Me:getMissionListById(subTaskIds[i])
        local subTaskState = subTaskData and subTaskData.state
        local isCompleted = subTaskState == GE.MissionState.Unclaimed or subTaskState == GE.MissionState.Received
        if not isCompleted then
            return false
        end
    end
    return true
end

---判断繁荣等级任务是否可领取
---@param levelTaskId integer
---@return boolean
function ProsperityPanel:CanClaimProsperityLevelTask(levelTaskId)
    local currentLevel = self.prosperityInfo.currentLevel or 0
    return ProsperityPanel.CanClaimProsperityLevelTaskStatic(levelTaskId, currentLevel)
end

---刷新确认领取按钮显示状态
---@param levelTaskId integer
function ProsperityPanel:RefreshProsperityConfirmBtn(levelTaskId)
    self.selectedProsperityLevelTaskId = levelTaskId or 0
    local canClaim = self:CanClaimProsperityLevelTask(self.selectedProsperityLevelTaskId)
    self.confirmBtn:SetActive(canClaim)
end

function ProsperityPanel:OnClose(initiative)
end

function ProsperityPanel:OnDestroy()
    self:KillBgOpenAnimTweens()
    self:KillBgCloseAnimTweens()
    self:KillModeSwitchTween()
    self:KillBuildGroupSwitchTween()
	GameMsgMgr:unRegEvent(GameMsgType.RoleWalkChange, self, self.OnRoleWalkChange)
    GameMsgMgr:unRegEvent(GameMsgType.RefreshHomeland, self, self.OnRefreshHomeland)
    GameMsgMgr:unRegEvent(GameMsgType.HomelandOneKeyCollected, self, self.OnHomelandOneKeyCollected)
    GameMsgMgr:unRegEvent(GameMsgType.MissionRefresh, self, self.OnMissionRefresh)
    GameMsgMgr:unRegEvent(GameMsgType.ProsperityInfoUpdate, self, self.OnProsperityInfoUpdate)
    self.super:OnDestroy(self)
end

--function ProsperityPanel:OnRefresh(data)
--
--end

-------------------UI按钮回调------------------------------
--[[
/Mask onClick 
--]]
function ProsperityPanel:mask_Button_onClick(mask)
    self:RequestCloseWithAnim()
end

--[[
/bg/ToggleList/MainBtn onClick 
--]]
function ProsperityPanel:mainBtn_ScaleButton_onClick(mainBtn)
    if self.nowSelectMode == 1 then
        return
    end
    self:SelectToggle(1)
end

--[[
/bg/ToggleList/BuildBtn onClick 
--]]
function ProsperityPanel:buildBtn_ScaleButton_onClick(buildBtn)
    if self.nowSelectMode == 2 then
        return
    end
    self:SelectToggle(2)
end

--[[
/bg/ToggleList/WalkBtn onClick 
--]]
function ProsperityPanel:walkBtn_ScaleButton_onClick(walkBtn)
    if self.nowSelectMode == 3 then
        return
    end
    self:SelectToggle(3)
end

--[[
/bg/CloseBtn onClick 
--]]
function ProsperityPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:RequestCloseWithAnim()
end

--[[
/bg/MainMode/Top/HelpBtn onClick 
--]]
function ProsperityPanel:helpBtn_ScaleButton_onClick(helpBtn)
    UIMgr:popUICover("ProsperityMsgPanel", {})
end

--[[
/bg/MainMode/ConfirmBtn onClick 
--]]
function ProsperityPanel:confirmBtn_ScaleButton_onClick(confirmBtn)
    if not self.selectedProsperityLevelTaskId or self.selectedProsperityLevelTaskId <= 0 then
        self.confirmBtn:SetActive(false)
        return
    end

    local taskId = self.selectedProsperityLevelTaskId
    if not self:CanClaimProsperityLevelTask(taskId) then
        self:RefreshProsperityConfirmBtn(taskId)
        return
    end

    local storyId = self:GetSelectedProsperityStoryId()
    Me:GetMissionRewardReq({taskId}, function(data)
        local homeland = Me and Me:getHomeland()
        if homeland.prosperityInfo then
            self.prosperityInfo = homeland.prosperityInfo
        end
        self:RefreshProsperityLevelSelectState()
        self:ShowProsperityLevelDetail(self.selectedProsperityLevel)
        local function closePanelAndPlayStory()
            self:RequestCloseWithAnim(function()
                local currentProsperityLevel = 0
                local currentHomeland = Me and Me:getHomeland()
                local homeInfo = currentHomeland and currentHomeland.prosperityInfo
                if homeInfo then
                    currentProsperityLevel = homeInfo.currentLevel or 0
                end
                local function showLevelUpPanel()
                    UIMgr:popUICover("ProsperityLevelUpPanel", {level = currentProsperityLevel})
                end
                if storyId > 0 then
                    StoryMgr:playHomeStory(storyId, showLevelUpPanel)
                else
                    showLevelUpPanel()
                end
            end)
        end

        local rewardList = data and data.rewardList
        if rewardList and next(rewardList) then
            Me:ReceiveReward(rewardList, closePanelAndPlayStory)
        else
            closePanelAndPlayStory()
        end
    end, true)
end

--[[
/bg/WalkMode/ChangeWalkBtn onClick 
--]]
function ProsperityPanel:changeWalkBtn_ScaleButton_onClick(changeWalkBtn)
    self.keepCurrentModeOnNextOpen = true
    UIMgr:popUI("HomeWalkPanel", {})
end

--[[
/bg/BuildMode/ListBg/AllGetBtn onClick 
--]]
function ProsperityPanel:allGetBtn_ScaleButton_onClick(allGetBtn)
    if not self:HasAnyBuildRewardCanCollect() then
        self:RefreshBuildAllGetBtnState()
        return
    end
    Me:OneKeyCollectHomelandResourceReq(function()
        self:SetBuildModeView()
    end)
end

--[[
/bg/BuildMode/TopBg/FunctionBtn onClick 
--]]
function ProsperityPanel:functionBtn_ScaleButton_onClick(functionBtn)
    self:SelectBuildGroup(1)
end

--[[
/bg/BuildMode/TopBg/OutputBtn onClick 
--]]
function ProsperityPanel:outputBtn_ScaleButton_onClick(outputBtn)
    self:SelectBuildGroup(2)
end


return ProsperityPanel
