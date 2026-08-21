---@class MainPanel : MainPanel_Generate
---##################### 【MainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【MainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class MainPanel : MainPanel_Generate
---##################### 【MainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【MainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class MainPanel : MainPanel_Generate
---##################### 【MainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【MainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local MainPanel = require "MainPanel_Generate"
local ProsperityPanel = require "ProsperityPanel"
require "UICommonUtils"

local timeIconType = -1
local charMap = {
        ["0"] = 0, ["1"] = 1, ["2"] = 2, ["3"] = 3, ["4"] = 4,
        ["5"] = 5, ["6"] = 6, ["7"] = 7, ["8"] = 8, ["9"] = 9,
        [":"] = 10
}
function MainPanel:InitLogic(data)
    LuaLogger.ds("CoveManager:MainPanel:InitLogic")
    self.msgEventHandler = {
        {GameMsgType.RefreshMainPanel, self.RefreshUesrData},
        {GameMsgType.RefreshTopResource, self.RefreshTopResource},
        {GameMsgType.RefreshPoster, self.RefreshPoster},
        {GameMsgType.FunctionOpenMapUpdate, self.__CheckFunctionOpen},
        {GameMsgType.UpdateSceneTime, self.UpdateSceneTime},
        {GameMsgType.RefreshHomeland, self.RefreshHomeland},
        {GameMsgType.RefreshCoveBattleInfo, self.RefreshCoveBattleInfo},
        {GameMsgType.FriendListChange, self.RefreshFriendRedPoint},
        {GameMsgType.FriendPointChange, self.RefreshFriendRedPoint},
        {GameMsgType.BulidingLvChange, self.OnBulidingLvChange},
        {GameMsgType.RoleDisposeChange, self.RefreshHomelandFunctionRedPoint},
        --问卷完成后通知
        {GameMsgType.QnaireMapDataUpdate, self.__CheckFunctionOpen},
        {GameMsgType.PlayGetRewardEffect, self.PlayGetRewardEffect},
        {GameMsgType.RefreshEventMsg, self.__CheckFunctionOpen},
        {GameMsgType.MissionRefresh, self.OnMissionRefresh},
        {GameMsgType.ProsperityInfoUpdate, self.RefreshProsperityBtnRedPoint},
        {GameMsgType.Add3DMark, self.Add3DMark},
	    {GameMsgType.Remove3DMark, self.Remove3DMark},
        {GameMsgType.ChangeMainPanelMode, self.changeNowMode},
        {GameMsgType.HomelandOneKeyCollected, self.RefreshHomeland},
    }
    self.BannerList = {}
    self.currLookerIndex = 1
    self.nowBannerId = nil
    self.pointObjList = {}
    self.nowMode = 1
    self.nowPosterState = true
    self.size = 1
    self.isHide = false
    self.spriteCache = {}       --banner图片缓存
    self.lookerList = {}        --banner数据
    UIMgr:depositUI(self)
    

    self.modeList = {
        office = 1,     --办公室模式d
        home = 2,       --家园模式
    }
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    if GV.GlobalConfig.ShowMainPanelTestBtn and  EngineGlobal.CheckInEditor() == true then
        local longPressListener = self.configBtn.clickLongPressListener
        longPressListener.onLongpress = function ()
            UIMgr:popUI("GmPanel", {})
        end
    end

    ---@type table<integer, MainPanel_Generate_resBox>
    self.resourceItems = {}

    self.getRewardEffect.mainPane_RewardEffect:SetParentUI(self)

    self.needPopUpPanelFuncList = {}    --登录弹窗界面方法队列
    self.popUpFuncIndex = 1  --登录弹窗队列执行索引
    self.lastProsperityTotal = nil
    self.prosperityValueTween = nil
end

--function MainPanel:StartCreating(time)
--
--end

--function MainPanel:StartEnter(time)
--
--end

--function MainPanel:StartRemoving(time)
--
--end

--function MainPanel:StartExit(time)
--
--end

function MainPanel:OnOpen(data, initiative)
    LuaLogger.ds("MainPanel:OnOpen")
    self:HideAll(false)
    self._redTest = {}
    if initiative then
        --活动红点注册
        RedPointMgr:Register("ActivityPanelRedPoint", self, function(bool)
            self.activityBtn.red:SetActive(bool)
        end)
        --任务红点注册
        RedPointMgr:Register("TaskBtnRedJudge", self, function(bool)
            self.taskBtn.red:SetActive(bool and self.taskBtn.isNew.activeSelf == false)
        end)
        --船坞按钮红点注册
        RedPointMgr:Register("DockBtnRedJudge", self, function(bool)
            self.dockBtn.red:SetActive(bool)
        end)
        --展开按钮红点注册
        RedPointMgr:Register("ChangeBtnRedJudge", self, function(bool)
            self.changeBtn.red:SetActive(bool)
        end)
        --派遣按钮红点注册
        RedPointMgr:Register("DispatchBtnRedJudge", self, function(bool)
            self.dispatchBtn.red:SetActive(bool and self.dispatchBtn.isNew.activeSelf == false)
        end)
        --武器制作按钮红点注册
        RedPointMgr:Register("GraphPaperRedJudge", self, function(bool)
            self.makeWeaponBtn.red:SetActive(bool and self.makeWeaponBtn.isNew.activeSelf == false)
        end)
        --邮箱按钮红点注册
        RedPointMgr:Register("MailBtnRedJudge", self, function(bool)
            self.mailBtn.red:SetActive(bool and self.mailBtn.isNew.activeSelf == false)
        end)
        --家按钮红点注册
        RedPointMgr:Register("HomeBtnRedJudge", self, function(bool)
            self.homeBtn.red:SetActive(bool)
        end)
        --仓库按钮红点注册
        RedPointMgr:Register("WarehouseBtnRedJudge", self, function(bool)
            self.warehouseBtn.red:SetActive(bool)
        end)
        --通知按钮红点注册
        RedPointMgr:Register("NoticeRedJudge", self, function(bool)
            self.msgBtn.red:SetActive(bool)
        end)
        --科技树按钮红点注册
        RedPointMgr:Register("ScienceTreeBtnRedJudge", self, function(bool)
            self.scienceTreeBtn.red:SetActive(bool and self.scienceTreeBtn.isNew.activeSelf == false)
        end)
        --问卷调查按钮红点注册
        RedPointMgr:Register("QuestionRedJudge", self, function(bool)
            self.questionBtn.red:SetActive(bool)
        end)
        --刷新通行证显示
        self:RefreshPassActivity()
        self:SetView()
        if CoveManager.instance() then
            CoveManager.instance():SetGameSceneInfoShowOrHide(true)
            self.nowMode = CoveManager.instance():GetDefaultSceneType()
        end
        local uidText = GameObject.Find("GlobalCanvas/UIDText"):GetComponent("Text")
        uidText.text = Me.uid
        -- self:CreateRT()
        -- self:loadRoleModel()
    else
        self:SetView(true)
    end
    if data and data.mode then
        self.nowMode = data.mode
        CoveManager.instance():SetTempSceneType(self.nowMode)
    end
    self:InitBanner()
    self:RefreshNowMode()
    self:RefreshAngleDisplay()
    -- GuideMgr:StartGuideTrigger("MainPanel")
    --主界面无引导
    -- if GuideMgr:GetGuideOnCurrPanel() == false then
        --主界面弹窗相关内容都放进该方法(会按顺序执行)
        self:setneedPopUpPanelFuncList()
        self:doPopUpPanelFunc()
    -- else
    --     ClientData:SetIsPlaySpineIntoAni(true)--有引导则算播放过放看板娘进入动画
    -- end

    UIMgr:resetDepositToast()
    self:UpdateGetHomelandRewardBtnActive()

    self:RefreshCoveBattleInfo()
    timeIconType = -1
    if self.nowMode == 2 then
        self:UpdateSceneTime()
    end

    self:RefreshFriendRedPoint()
    self:RefreshHomelandFunctionRedPoint()
    UIMgr:PlayBasalBgm()
    --公告 - 渠道包（所有）入口隐藏公告按钮
    --self.msgBtn:SetActive(false)
end

--功能开启
function MainPanel:__CheckFunctionOpen()
    --抽卡
    local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.Gacha)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.drawBtn.lock,
        entryObj = self.drawBtn,
        newObj = self.drawBtn.isNew,
        redObj = self.drawBtn.red,
        lockShowType = lockShowType,
        state = state,
        showNew = showNew
    })
    --任务
    local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.Task)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.taskBtn.lock,
        entryObj = self.taskBtn,
        newObj = self.taskBtn.isNew,
        redObj = self.taskBtn.red,
        lockShowType = lockShowType,
        state = state,
        showNew = showNew
    })
    --邮箱
    local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.Mailbox)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.mailBtn.lock,
        entryObj = self.mailBtn,
        newObj = self.mailBtn.isNew,
        redObj = self.mailBtn.red,
        lockShowType = lockShowType,
        state = state,
        showNew = showNew
    })

    
    --派遣--->> 图鉴
    local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HankBook)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.hankBookBtn.lock,
        entryObj = self.hankBookBtn,
        newObj = self.hankBookBtn.isNew,
        redObj = self.hankBookBtn.red,
        lockShowType = lockShowType,
        state = state,
        showNew = showNew
    })

    --武器制造
    local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.WeaponMake)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.makeWeaponBtn.lock,
        entryObj = self.makeWeaponBtn,
        newObj = self.makeWeaponBtn.isNew,
        redObj = self.makeWeaponBtn.red,
        lockShowType = lockShowType,
        state = state,
        showNew = showNew
    })

    --跑片 同步训练-> 家园商店
    local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomelandShop)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.homelandShopBtn.lock,
        entryObj = self.homelandShopBtn,
        newObj = self.homelandShopBtn.isNew,
        redObj = self.homelandShopBtn.red,
        lockShowType = lockShowType,
        state = state,
        showNew = showNew
    })

    --活动
    Me:getFunctionDataReq({GE.PushData.missionList},function()
        --活动按钮
        LuaLogger.ds("GetFunctionDataResp 活动按钮")
        local showIdList = UICommonUtils.GetActivityShowIdList(GE.ActivityFunctionType.ActivityPanel)
        self.activityBtn:SetActive(#showIdList > 0)
    end)

    self:RefreshAffectionEventBtn()

    --科技树
    local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.TechTree)
    UICommonUtils.FunctionOpenDis({
        lockObj = self.scienceTreeBtn.lock,
        entryObj = self.scienceTreeBtn,
        newObj = self.scienceTreeBtn.isNew,
        redObj = self.scienceTreeBtn.red,
        lockShowType = lockShowType,
        state = state,
        showNew = showNew
    })

    --问卷调查
    
    Me:getFunctionDataReq({GE.PushData.qnaireMap},function()
        local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.Question)
        local  isActive  = state == GE.FunctionOpenState.Open
        local questionOpenList = UICommonUtils.QuestionOpenList()
        if isActive == true and #questionOpenList <= 0 then
            isActive = false
        end
        if EngineGlobal.PublishCode5 == 100 then
            isActive = false
        end
        self.questionBtn:SetActive(isActive)
    end)
    

    local funId = GE.FunctionOpenModule.ShipDispatch
    local isOpen = (UICommonUtils.CheckFunctionOpen(funId)) ~= GE.FunctionOpenState.Lock
    self.dispatchBtn.gameObject:SetActive(isOpen)

    local funId = GE.FunctionOpenModule.GenRoleFrag
    local isOpen = (UICommonUtils.CheckFunctionOpen(funId)) ~= GE.FunctionOpenState.Lock
    self.genRoleFragBtn.gameObject:SetActive(isOpen)

    local funId = GE.FunctionOpenModule.GameShop
    local isOpen = (UICommonUtils.CheckFunctionOpen(funId)) ~= GE.FunctionOpenState.Lock
    self.gameShopBtn.gameObject:SetActive(isOpen)

    --七日任务
    local sevenDayIsOpen = (UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.SevenDayTask)) ~= GE.FunctionOpenState.Lock
    self.sevenBtn.gameObject:SetActive(sevenDayIsOpen)

    --剧情活动
    local activityMap = Me:getActivityMap()
    local activityStoryIsOpen = false
    for activityId, activityInfo in pairs(activityMap) do
        local cfg = Config.GetActivityInfo(activityId)
        if cfg and cfg.Type == GE.ActivityType.ActivityStory and activityInfo.state == GE.ActivityState.Open then
            activityStoryIsOpen = true
            break
        end
    end

    local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.SceneSetting)
    local isShow = state ~= GE.FunctionOpenState.Lock
    self.sceneSettingBtn:SetActive(self.nowMode == self.modeList.home and isShow)

    self.activityStoryBtn.gameObject:SetActive(activityStoryIsOpen)

    --刷新通行证显示
    self:RefreshPassActivity()

    self:RefreshHomelandFunctionRedPoint()
end

function MainPanel:OnMissionRefresh()
    self:RefreshAffectionEventBtn()
    self:RefreshProsperityBtnRedPoint()
end

---繁荣度下一级（currentLevel+1）主任务可领取时显示 ProsperityBtn 红点
function MainPanel:RefreshProsperityBtnRedPoint()
    if not UICommonUtils.Checkobj(self.prosperityBtn) or not UICommonUtils.Checkobj(self.prosperityBtn.red) then
        return
    end

    local canClaim = false
    local homeland = Me and Me:getHomeland()
    local prosperityInfo = homeland and homeland.prosperityInfo
    if prosperityInfo then
        local currentLevel = prosperityInfo.currentLevel or 0
        local nextTaskId = ProsperityPanel.GetNextProsperityLevelTaskId(currentLevel)
        canClaim = ProsperityPanel.CanClaimProsperityLevelTaskStatic(nextTaskId, currentLevel)
    end
    self.prosperityBtn.red:SetActive(canClaim)
end

-- 委托列表为空时隐藏好感度委托入口按钮
function MainPanel:RefreshAffectionEventBtn()
    local hasDelegate = false
    for _, eventId in pairs(Me:getDelegateEvent()) do
        if eventId and eventId > 0 and Me:getMissionListById(eventId) then
            hasDelegate = true
            break
        end
    end
    if UICommonUtils.Checkobj(self.affectionEventBtn) then
        self.affectionEventBtn:SetActive(hasDelegate)
    end
end

function MainPanel:SetView(isRefresh)
    -- self.ticketTxt.text.text = UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength).."/"..Config.GetConfigInfo("LimitNormalTicketNum")
    -- self.moneyTxt.text.text = UICommonUtils.SetResourceFormatByType(GE.ResourceType.Gold)
    self:refreshAllRedPoint()
    self:__CheckFunctionOpen()
    self:RefreshTopResource()
    local userLevel = Me:getUserLevel()
    self.userNameTxt.text.text = Me:getUserName()
    self.userLevelTxt.text.text = tostring(userLevel)
    local levelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.user, userLevel)
    if levelData == nil then
        return
    end
    local nowExp = Me:getUserEXP() - levelData.exp_sum
    self.expSlider.slider.value = nowExp / levelData.exp

    if not isRefresh then
        self:SetPosterView()
    end
    self:RefreshProsperityDisplay(true)
end

---刷新主界面繁荣文本（总值增长时播放数字滚动）
---@param playIncreaseAnim boolean
function MainPanel:RefreshProsperityDisplay(playIncreaseAnim)
    if not self.prosperityBtn
        or not self.prosperityBtn.prosperityTxt
        or not self.prosperityBtn.prosperityTxt.text
        or not self.prosperityBtn.prosperityValueTxt
        or not self.prosperityBtn.prosperityValueTxt.text then
        return
    end

    local homeland = Me and Me:getHomeland()
    local prosperityInfo = homeland and homeland.prosperityInfo
    if not prosperityInfo then
        self:RefreshProsperityBtnRedPoint()
        return
    end

    local showLevel = (prosperityInfo.currentLevel or 0)
    self.prosperityBtn.prosperityTxt.text.text = tostring(showLevel)

    local totalProsperity = (prosperityInfo.globalConditionProgress and prosperityInfo.globalConditionProgress[GE.MissionFinishType.Prosperity]) or 0
    local lastProsperity = self.lastProsperityTotal
    local shownValue = tonumber(self.prosperityBtn.prosperityValueTxt.text.text) or 0
    local needAnim = playIncreaseAnim and lastProsperity ~= nil and totalProsperity > lastProsperity

    if self.prosperityValueTween then
        self.prosperityValueTween:Kill()
        self.prosperityValueTween = nil
    end

    self.lastProsperityTotal = totalProsperity

    if needAnim then
        local delta = totalProsperity - shownValue
        local duration = math.min(0.8, math.max(0.2, delta / 500))
        self.prosperityValueTween = DG.Tweening.DOVirtual.Int(shownValue, totalProsperity, duration, function(v)
            self.prosperityBtn.prosperityValueTxt.text.text = tostring(v)
        end):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
            self.prosperityBtn.prosperityValueTxt.text.text = tostring(totalProsperity)
            self.prosperityValueTween = nil
        end)
    else
        self.prosperityBtn.prosperityValueTxt.text.text = tostring(totalProsperity)
    end
    self:RefreshProsperityBtnRedPoint()
end

--设置看板娘显示
function MainPanel:SetPosterView()
    self.roleInteractionArea.roleInteractionArea:initRole()
    self.posPoint.rectTransform.anchoredPosition = Vector2.New(ClientData:GetPosterData().PosX, ClientData:GetPosterData().PosY)
    self:SetPosterSize(ClientData:GetPosterData().Size)
    self:ResetDialogBoxPosition()
end

function MainPanel:SetPosterSize(value)
    local skinConfig = Config.GetCharacterSkinInfo(ClientData:GetPosterData().SkinId)
    self.size = value
    if self.size >= 1 then
        self.posPoint.rectTransform.sizeDelta = Vector2.New(5000 * value, 3000 * value)
    else
        self.posPoint.rectTransform.sizeDelta = Vector2.New(5000, 3000)
    end
    self.roleInteractionArea.roleInteractionArea:setImagePosition(skinConfig.imgRateF * self.size, skinConfig.imgRateF * self.size)
    self.roleInteractionArea.roleInteractionArea:setSpineScale(skinConfig.spineRate * self.size, skinConfig.spineRate * self.size)
end

--重设对话框位置
function MainPanel:ResetDialogBoxPosition()
    self.roleInteractionArea.roleInteractionArea:setDialogBoxPosition(self.dialogRoot)
end

function MainPanel:RefreshUesrData()
    self:SetView(true)
end

function MainPanel:RefreshPoster()
    self:SetPosterView()
end

--Banner初始化
function MainPanel:InitBanner()
    if next(self.pointObjList) then
        local _, firstObj = next(self.pointObjList)
        -- 用 pcall 检测对象是否已被 Unity 销毁（destroyed 对象访问属性会抛异常）
        local isValid = false
        if firstObj ~= nil then
            isValid = pcall(function()
                local _ = firstObj.gameObject.activeSelf
            end)
        end
        if isValid then
            -- 对象仍然有效，只需重启计时器
            self:RestartBannerTimer()
            return
        end
        -- 对象已被销毁，清空列表重新初始化
        self.pointObjList = {}
    end

    self.lookerList = {}
    self.BannerList = Config.GetAllConfig("BannerTable")
	for i, BannerData in pairs(self.BannerList) do
        --TODO: 时间戳判断后面加
        table.insert(self.lookerList, {
            configData = BannerData,
        })
	end
    table.sort(self.lookerList, function(a, b)
		return a.configData.showPriority < b.configData.showPriority
	end)

    self:FillTemplateContent(self.pointBox, self.pointList, tablex.size(self.lookerList), function(index, pointBox)
        pointBox:SetActive(true)
        self.pointObjList[index] = pointBox
    end)
    
    local lookRectScroll = self.lookRectScroll.lookRectScroll
    lookRectScroll.uiCamera = UIMgr.uiCamera
    lookRectScroll.lookRectWidth = self.lookRectScroll.rectTransform.sizeDelta.x
    lookRectScroll.inertiaThreshhold = 0.4
	lookRectScroll.roundLerp = 0.2
	lookRectScroll.inertiaLerp = 0.2

    self:LoadBannerImage(self:GetLookerIndex(-1), lookRectScroll.lastImg)
	self:LoadBannerImage(self.currLookerIndex, lookRectScroll.currImg)
	self:LoadBannerImage(self:GetLookerIndex(1), lookRectScroll.nextImg)
    self:ChangePoint(self.currLookerIndex)
    lookRectScroll:SetClickFunc(function()
        local currLooker = self.lookerList[self.currLookerIndex]
        if currLooker and currLooker.configData and currLooker.configData.turnTo then
            local canTurnTo = UICommonUtils.CanUseSkipJudge(currLooker.configData.turnTo[1], true)
            if canTurnTo then
                UICommonUtils.CommonTurnTo(currLooker.configData.turnTo[1])
            end
        end
    end)
    lookRectScroll.onLast = function(tmpImage)
		self:OnBanner(tmpImage, -1)
	end
	lookRectScroll.onNext = function(tmpImage)
		self:OnBanner(tmpImage, 1)
	end
	lookRectScroll:Init()
    self:RestartBannerTimer()
end

--重置Banner自动轮播计时器（复用已有计时器，避免频繁销毁重建）
function MainPanel:RestartBannerTimer()
    if self.BannerNextTimer then
        DLuaTimer:RemoveTimer(self.BannerNextTimer)
    end
    self.BannerNextTimer = DLuaTimer:DoRepeatForever(5, function()
        if self.lookRectScroll == nil or self.lookRectScroll.lookRectScroll == nil then
            return
        end
        self.lookRectScroll.lookRectScroll:ShowNext()
    end)
end

--根据index修改point显示模式
function MainPanel:ChangePoint(index)
    local hasDestroyed = false
    for key, obj in pairs(self.pointObjList) do
        if obj == nil or obj.isOn == nil then
            goto continue
        end
        local ok = pcall(function()
            if key == index then
                -- 选中项：取消已有 tween 再播放扩展动画
                obj.rectTransform:DOKill()
                obj.isOn:SetActive(true)
                obj.rectTransform:DOSizeDelta(Vector2(75, obj.rectTransform.sizeDelta.y), 0.5)
            elseif obj.isOn.activeSelf then
                -- 只有之前是选中状态才需要收缩（避免对所有非选中项都调用）
                obj.rectTransform:DOKill()
                obj.isOn:SetActive(false)
                obj.rectTransform.sizeDelta = Vector2(44, obj.rectTransform.sizeDelta.y)
            end
        end)
        if not ok then
            hasDestroyed = true
        end
        ::continue::
    end
    if hasDestroyed then
        self.pointObjList = {}
    end
end

function MainPanel:OnBanner(tmpImage, value)
	self.currLookerIndex = self:GetLookerIndex(value)
    self:ChangePoint(self.currLookerIndex)
	local lookerEle = self.lookerList[self.currLookerIndex]
	self.nowBannerId = lookerEle.configData and lookerEle.configData.id or lookerEle.id
	self:LoadBannerImage(self:GetLookerIndex(value), tmpImage)
    self:RestartBannerTimer()
end

function MainPanel:GetLookerIndex(oneDeltaIndex)
	local tmpLookerIndex = self.currLookerIndex + oneDeltaIndex
	if tmpLookerIndex < 1 then
		tmpLookerIndex = #self.lookerList
	elseif tmpLookerIndex > #self.lookerList then
		tmpLookerIndex = 1
	end
	return tmpLookerIndex
end

--加载banner图片
--@param Index: 索引
--@param tmpImage: 图片对象
function MainPanel:LoadBannerImage(Index, tmpImage)
    tmpImage.color = Color(1, 1, 1, 0)
    local lookerEle = self.lookerList[Index]
    if not lookerEle or not lookerEle.configData then
        return
    end

    -- 检查是否已经缓存
    if lookerEle.IconSprite then
        tmpImage.sprite = lookerEle.IconSprite
        tmpImage.color = Color(1, 1, 1, 1)
        return
    end
    local resourceKey = string.format(Config.SpritePath.BannerIconPath, lookerEle.configData.resourceName)
    if self.spriteCache[resourceKey] then
        tmpImage.sprite = self.spriteCache[resourceKey]
        tmpImage.color = Color(1, 1, 1, 1)
    else
        self:LoadSpriteAsync(resourceKey, function(s)
            self.spriteCache[resourceKey] = s
            tmpImage.sprite = s
            tmpImage.color = Color(1, 1, 1, 1)
        end)
    end
end

function MainPanel:OnClose(initiative)
    if self.prosperityValueTween then
        self.prosperityValueTween:Kill()
        self.prosperityValueTween = nil
    end
    self.roleInteractionArea.roleInteractionArea:clearAction()
    self.roleInteractionArea.roleInteractionArea:clearUserIdleData() --清除玩家挂机数据
    if self.BannerNextTimer then
        DLuaTimer:RemoveTimer(self.BannerNextTimer)
        self.BannerNextTimer = nil
    end
    self.pointObjList = {}
end

--开启看板娘调整模式
function MainPanel:OpenRoleChangeMode()
    self:SetPosterState(true)
    self.roleView.scrollRect.enabled = true
    self.uiList.canvasGroup.blocksRaycasts = false
    self.uiList.canvasGroup.alpha = 0.8
end

--关闭看板娘调整模式
function MainPanel:CloseRoleChangeMode()
    self:SetPosterState(false)
    self.roleView.scrollRect.enabled = false
    self.uiList.canvasGroup.blocksRaycasts = true
    self.uiList.canvasGroup.alpha = 1
end

--开启看板娘模式
function MainPanel:PosterPanelMode(isOn)
    if isOn then
        self.roleView.scrollRect.enabled = true
        self.uiList.canvasGroup.alpha = 0
        self:SetPosterState(false)
        self.roleInteractionArea.roleInteractionArea:setClickEnabled(false)
        self.roleInteractionArea.roleInteractionArea:clearAction()
    else
        self.roleView.scrollRect.enabled = false
        self.uiList.canvasGroup.alpha = 1
        self:SetPosterState(true)
        self.roleInteractionArea.roleInteractionArea:setClickEnabled(true)
        self.roleInteractionArea.roleInteractionArea:resetUserIdleData()
    end
end

function MainPanel:SetPosterState(State)
    self.nowPosterState = State
    self.posPoint:SetActive(self.nowPosterState)
end

--获取看板娘位置信息
function MainPanel:GetPosterPosData()
    local temp = {
        x = self.posPoint.rectTransform.anchoredPosition.x,
        y = self.posPoint.rectTransform.anchoredPosition.y,
        size = self.size
    }
    return temp
end

--重置看板娘位置
function MainPanel:ResetPosterPos()
    local skinConfig = Config.GetCharacterSkinInfo(ClientData:GetPosterData().SkinId)
    if skinConfig.spineKey then
        self.posPoint.rectTransform.anchoredPosition = Vector2(0, skinConfig.spineOffset[2])
    else
        self.posPoint.rectTransform.anchoredPosition = Vector2(0, skinConfig.imgOffsetF[2])
    end
    self:SetPosterSize(1)
end

function MainPanel:GetPosterSize()
    return self.size
end

--更改当前模式显示
function MainPanel:changeNowMode(mode)
    if mode == self.nowMode then
        return
    end
    self.nowMode = mode
    CoveManager.instance():SetTempSceneType(self.nowMode)
    self:RefreshNowMode()
end

--显示隐藏家园
function MainPanel:ShowHomeland(bool)
    if CoveManager.instance() then
        CoveManager.instance():setFocusState(bool)
        CoveManager.instance():SetHomelandShowOrHide(bool)
        if bool then
            CoveManager.instance():RefreshBuilding()
        end
    end
end

function MainPanel:RefreshNowMode()
    self.switchBtn:SetActive(self.nowMode == self.modeList.office)
    self.cameraType:SetActive(self.nowMode == self.modeList.home)
    local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.SceneSetting)
    local isShow = state ~= GE.FunctionOpenState.Lock
    self.sceneSettingBtn:SetActive(self.nowMode == self.modeList.home and isShow)
    self.sceneTimeInfo.gameObject:SetActive(self.nowMode == self.modeList.home)
    self.sceneMarkView.gameObject:SetActive(self.nowMode == self.modeList.home)
    self.cameraType:SetActive(self.nowMode == self.modeList.home)   --相机角度切换按钮

     local isBattle = CoveBattleMgr.instance():IsBattle()
    self.effect_Ui_ShenHaiRuQing:SetActive(self.nowMode == self.modeList.home and isBattle)

    self.homelandFunctionBtn.gameObject:SetActive(self.nowMode == self.modeList.home)
    self.prosperityBtn:SetActive(self.nowMode == self.modeList.home)
    self:RefreshAffectionEventBtn()

    self.officeBg:SetActive(self.nowMode == self.modeList.office)
    self.officeBtn:SetActive(self.nowMode == self.modeList.home)
    self.homeBtn:SetActive(self.nowMode == self.modeList.office)
    self.roleView:SetActive(self.nowMode == self.modeList.office)
    self.roleView.scrollRect.enabled = self.nowMode ~= self.modeList.office
    -- self.changeCoveCam:SetActive(self.nowMode == self.modeList.home and GV.GlobalConfig.ShowMainPanelTestBtn)    --切换相机模式测试按钮
    self.changeCoveCam:SetActive(GV.IsEditor)
    self:UpdateGetHomelandRewardBtnActive()
    self:ShowHomeland(self.nowMode == self.modeList.home)
    if CoveManager.instance() then
        CoveManager.instance():SetGameSceneInfoShowOrHide(true)
        if self.nowMode == self.modeList.home then
            CoveManager.instance()._roleMgr:onInit()
        end
        if self.nowMode == self.modeList.office then
            self.roleInteractionArea.roleInteractionArea:resetUserIdleData() --重置玩家挂机数据
        end
    end
end

--- 是否在办公室
function MainPanel:InHome()
    if not self.gameObject.activeSelf then
       return false 
    end
    return self.nowMode == self.modeList.home 
end

function MainPanel:HideHomeLandAndGameSceneInfo()
    --if UICommonUtils.Checkobj(self.Homeland) then
    --    self:ShowHomeland(false)
    --end
end

--隐藏主界面全部按钮
---@param isHide boolean 是否隐藏
---@param ignoreShowIcon boolean 是否在全隐的情况下不显示showicon
---@param ignoreCameraType boolean 是否在全隐的情况下显示相机类型按钮
function MainPanel:HideAll(isHide, ignoreShowIcon, showCameraType)
    self.uiList:SetActive(not isHide)
    self.showIcon:SetActive(isHide and not ignoreShowIcon)
    self.hideIcon:SetActive(not isHide)
    self.cameraType:SetActive(not isHide or showCameraType)
    if not isHide and self.nowMode == self.modeList.home then
        self:RefreshProsperityDisplay(true)
    end
end

--刷新顶部资源栏
function MainPanel:RefreshTopResource()
    local targetRes = Config.GetFunctionTabInfo(GE.NavigationType.MainPanel).Resources or {}
    self:FillTemplateContent(self.resBox, self.resource, tablex.size(targetRes), function(index, box)
        local itemId = targetRes[index]
        local itemInfo = Config.GetItemInfo(itemId)
        --资源icon
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, itemInfo.icon), box.resIcon.image)
        local resBgType = GE.ResBgTYpe.normal
        --拥有数量
        if itemInfo.type == GE.ItemTypeIndex.ticket then
            box.resNumTxt.text.text = UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength)--.."/"..Config.GetConfigInfo("LimitNormalTicketNum")
        elseif itemInfo.type == GE.ItemTypeIndex.res then
            box.resNumTxt.text.text = Me:getItemCountById(itemId)
        end
        --体力特殊判断
        if itemInfo.type == GE.ItemTypeIndex.ticket then
            box.addBtn:SetActive(true)
        else
            box.addBtn:SetActive(tablex.size(itemInfo.turnTo) > 0)
        end
        --加号按钮
        box.addBtn.scaleButton.onClick:RemoveAllListeners()
        box.addBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            --体力特殊判断
            if itemInfo.type == GE.ItemTypeIndex.ticket then
                UIMgr:popUICover("BuyTicketPanel", {})
            else
                local turnto = itemInfo.turnTo
                if UICommonUtils.CanUseSkipJudge(turnto[1], true) == false then
                    return
                end
                UICommonUtils.CommonTurnTo(turnto[1])
            end
        end)

        self.resourceItems[itemId] = box
    end)
end

--刷新主界面所有红点
function MainPanel:refreshAllRedPoint()
    self:RefreshSevenDayTaskRedPoint()
    self:RefreshProsperityBtnRedPoint()
end

---刷新七日任务红点
function MainPanel:RefreshSevenDayTaskRedPoint()
    Me:getFunctionDataReq({GE.PushData.missionList}, function()
        local hasRed = false
        local nowDays = Me:getRegisteredDayCount()
        local taskList = Config.GetTaskInfoByTaskType(GE.MissionType.SevenDayTask)
        if taskList then
            for _, taskCfg in pairs(taskList) do
                -- 只有当天数已解锁（type <= nowDays）且任务可领取时才显示红点
                if taskCfg.type and taskCfg.type <= nowDays then
                    local taskData = Me:getMissionListById(taskCfg.id)
                    if taskData and taskData.state == GE.MissionState.Unclaimed then
                        hasRed = true
                        break
                    end
                end
            end
        end
        self.sevenBtn.red:SetActive(hasRed)
    end)
end

--登录弹窗队列注册
function MainPanel:setneedPopUpPanelFuncList()
    self.popUpFuncIndex = 1
    self.needPopUpPanelFuncList = {}

    --Tips:新方法根据所需顺序添加

    --spine皮肤Into动画
    local function spineSkinIntoFunc()
        if self.nowMode == self.modeList.office and not ClientData:GetIsPlaySpineIntoAni() then
            self:ResetPosterPos()
            self:HideAll(true, true, false)
            self.roleInteractionArea.roleInteractionArea:setNeedIntoAnimation(true)
            self.roleInteractionArea.roleInteractionArea:setIntoFinishCallBack(function()
                self.whiteMask.canvasGroup:DOFade(1, 0.7):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
                    self.posPoint.rectTransform.anchoredPosition = Vector2.New(ClientData:GetPosterData().PosX, ClientData:GetPosterData().PosY)
                    self:SetPosterSize(ClientData:GetPosterData().Size)
                    self:HideAll(false, true, false)
                    self:doPopUpPanelFunc()
                    self.whiteMask.canvasGroup:DOFade(0, 0.3):SetEase(DG.Tweening.Ease.InQuart)
                end)
            end)
            ClientData:SetIsPlaySpineIntoAni(true)
        else
            self:doPopUpPanelFunc()
        end
    end
    table.insert(self.needPopUpPanelFuncList, spineSkinIntoFunc)

    --签到弹窗
    local function popSignFunc()
        local state = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.SignPop)
        local signData = Me:getSignDataById(Config.GetConfigInfo("PopSignOpen")) or {}
        if state == GE.FunctionOpenState.Open and signData and tablex.find(signData.alreadyAwards or {}, signData.signIndex) == false then
            local popSignfunc = function()
                UIMgr:popUICover("SignPopPanel", {curIndex = signData.signIndex, endCallback = function()
                    self:doPopUpPanelFunc()
                end})
            end
            if GuideMgr:GetNowGuideId() == 1060 then
                DLuaTimer:DoAfter(0.1, function()
                    popSignfunc()
                end)
            else
                popSignfunc()
            end
        else
            self:doPopUpPanelFunc()
        end
    end
    table.insert(self.needPopUpPanelFuncList, popSignFunc)

    --关卡解锁显示相关
    local typeList = {}
    local unWatchList = UICommonUtils.GetUnwatchedLevelList()
    if tablex.size(unWatchList) > 0 then
        table.insert(typeList, 1)
    end

    --功能开放显示相关
    local unWatchList = UICommonUtils.GetUnwatchedFunctionList()
    if tablex.size(unWatchList) > 0 then
        table.insert(typeList, 2)
    end

    if tablex.size(typeList) > 0 then
        local levelOpenShowFunc = function()
            LuaLogger.ds("MainPanel:功能开放显示相关")
            UIMgr:popUICover("FunctionOpenTips", {
                finishCallback = function()
                    self:doPopUpPanelFunc()
                end,
                type = typeList
            })
        end
        table.insert(self.needPopUpPanelFuncList, levelOpenShowFunc)
    end

    --最后触发引导
    local guide = function()
        GuideMgr:StartGuideTrigger("MainPanel")
    end
    table.insert(self.needPopUpPanelFuncList, guide)
end

--登录弹窗队列执行
function MainPanel:doPopUpPanelFunc()
    LuaLogger.ds("MainPanel:doPopUpPanelFunc index:" .. tostring(self.popUpFuncIndex))
    if self.popUpFuncIndex > #self.needPopUpPanelFuncList then
        return
    end
    local func = self.needPopUpPanelFuncList[self.popUpFuncIndex]
    self.popUpFuncIndex = self.popUpFuncIndex + 1
    if func then
        func()
    end
end

function MainPanel:OnDestroy()
    if self.prosperityValueTween then
        self.prosperityValueTween:Kill()
        self.prosperityValueTween = nil
    end
    self:ReleaseRT()
    if self.BannerNextTimer then
        DLuaTimer:RemoveTimer(self.BannerNextTimer)
    end

    self.super:OnDestroy(self)
end

--function MainPanel:OnRefresh(data)
--
--end

--[[
/logoutBtn onClick 
--]]
function MainPanel:logoutBtn_Button_onClick(logoutBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:clearAllUI()
    StateMgr:ChangeToState(GameFlowState.LoginState)
end

--[[
/BattleBtn onClick 
--]]
function MainPanel:battleBtn_ScaleButton_onClick(battleBtn)
    self:play2DSound(self.btnSoundPath)
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "MainPanel")
end

--[[
/DockBtn onClick 
--]]
function MainPanel:dockBtn_ScaleButton_onClick(dockBtn)
    self:play2DSound(self.btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance():SetHomelandShowOrHide(false)
    end
    UIMgr:popUI("DockRolePanel", {})
end

--[[
/FormationBtn onClick 
--]]
function MainPanel:formationBtn_ScaleButton_onClick(formationBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/WarehouseBtn onClick  仓库按钮
--]]
function MainPanel:warehouseBtn_ScaleButton_onClick(warehouseBtn)
    self:play2DSound(self.btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance():SetHomelandShowOrHide(false)
    end
    UIMgr:popUI("WarePanel", {pageIndex = GE.ItemTypeIndex.item})
end

--[[
/ItemMsgBtn onClick 
--]]
function MainPanel:itemMsgBtn_ScaleButton_onClick(itemMsgBtn)
    self:play2DSound(self.btnSoundPath)
    --UIMgr:popUI("ItemMsgPanel", {})
end

--[[
/RewardBtn onClick 
--]]
function MainPanel:rewardBtn_ScaleButton_onClick(rewardBtn)
    self:play2DSound(self.btnSoundPath)
    local temp = {
        {id = 110007, num = 10},{id = 100007, num = 20},{id = 110004, num = 1},{id = 110005, num = 1}
    }

    UIMgr:popUI("ReceiveRewardPanel", {rewardList = temp})
end

--[[
/ResDataPanel/AddTicketBtn onClick 
--]]
function MainPanel:addTicketBtn_ScaleButton_onClick(addTicketBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("BuyTicketPanel", {})
end

--[[
/FriendBtn onClick 
--]]
function MainPanel:friendBtn_ScaleButton_onClick(friendBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("FriendPanel", {})
end

--[[
/LevelBtn onClick 
--]]
function MainPanel:levelBtn_ScaleButton_onClick(levelBtn)
    local btnSoundPath = string.format(Config.AudioPath.SE, "seamap")
    self:play2DSound(btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance():SetHomelandShowOrHide(false)
    end
    UIMgr:popUI("SeaMapPanel", {})
end

--[[
/HomeDeployBtn onClick 
--]]
function MainPanel:homeDeployBtn_ScaleButton_onClick(homeDeployBtn)
    
end

--[[
/MsgBg/ExpSlider onValueChanged 
--]]
function MainPanel:expSlider_Slider_onValueChanged(expSlider,value)

end

--[[
/TaskBtn onClick 
--]]
function MainPanel:taskBtn_ScaleButton_onClick(taskBtn)
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.Task)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
        UIMgr:popUI("TaskPanel", {})
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.Task})
    end
end

--[[
/ConfigBtn onClick 
--]]
function MainPanel:configBtn_ScaleButton_onClick(configBtn)
    self:play2DSound(self.btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance():SetHomelandShowOrHide(false)
    end
    UIMgr:popUI("ConfigPanel", {})
end

--[[
/MailBtn onClick 邮箱
--]]
function MainPanel:mailBtn_ScaleButton_onClick(mailBtn)
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.Mailbox)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
        UIMgr:popUI("MailPanel", {})
    end

    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.Mailbox})
    end
end

--[[
/TopList/ActiveBtn onClick 
--]]
function MainPanel:activeBtn_ScaleButton_onClick(activeBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/TopList/MsgBtn onClick 
--]]
function MainPanel:msgBtn_ScaleButton_onClick(msgBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("NoticePanel")
end

--[[
/ButtomList/List/HankBookBtn onClick 
--]]
function MainPanel:hankBookBtn_ScaleButton_onClick(hankBookBtn)
    self:play2DSound(self.btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance():SetHomelandShowOrHide(false)
    end
    UIMgr:popUI("HandBooksPanel", {})
end

--[[
/ButtomList/List/ShopBtn onClick 
--]]
function MainPanel:shopBtn_ScaleButton_onClick(shopBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/ButtomList/List/DrawBtn onClick 抽卡
--]]
function MainPanel:drawBtn_ScaleButton_onClick(drawBtn)
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.Gacha)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        LoadingMgr:SetUISwitchStart(function()
            UIMgr:popUI("RaffleMainPanel", {}, function()
                LoadingMgr:SetUISwitchOver()
            end)
        end)
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.Gacha})
    end
end

--[[
/ButtomList/List/ScienceTreeBtn onClick 
--]]
function MainPanel:scienceTreeBtn_ScaleButton_onClick(scienceTreeBtn)
    self:play2DSound(self.btnSoundPath)
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.TechTree)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
        UIMgr:popUI("TechnologyTreePagePanel", {})
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.TechTree})
    end
end

--[[
/MoneyBg/AddMoneyBtn onClick 
--]]
function MainPanel:addMoneyBtn_ScaleButton_onClick(addMoneyBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/MainMode/OfficeBtn onClick 
--]]
function MainPanel:officeBtn_ScaleButton_onClick(officeBtn)
    self:play2DSound(self.btnSoundPath)
    LoadingMgr:SetUISwitchStart(function()
        self:changeNowMode(1)
        LoadingMgr:SetUISwitchOver()
    end)
    ---向服务器发送进入离开家园消息 
end

--[[
/MainMode/HomeBtn onClick 
--]]
function MainPanel:homeBtn_ScaleButton_onClick(homeBtn)
    self:play2DSound(self.btnSoundPath)
    local needloadData = { 
        GE.PushData.weatherForecastData,
        GE.PushData.affectionData,
        }
    LoadingMgr:SetUISwitchStart(function()
        Me:getFunctionDataReq(needloadData, function()
            self:changeNowMode(2)
            self:UpdateSceneTime()
            LoadingMgr:SetUISwitchOver()
            GuideMgr:StartGuideTrigger()
            self.roleInteractionArea.roleInteractionArea:clearUserIdleData() --清除玩家挂机数据
        end)
    end)
    
    ---向服务器发送进入离开家园消息 
end

--[[
/ListBg/HarbourBtn onClick 
--]]
function MainPanel:harbourBtn_ScaleButton_onClick(harbourBtn)
    self:play2DSound(self.btnSoundPath)
    CoveManager.instance()._roleMgr:onInit()
    UIMgr:popUI("HomeQuickDisposePanel", {})
end

--[[
/ListBg/WeaponBtn onClick 
--]]
function MainPanel:weaponBtn_ScaleButton_onClick(weaponBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/ListBg/MakeWeaponBtn onClick 
--]]
function MainPanel:makeWeaponBtn_ScaleButton_onClick(makeWeaponBtn)
    self:play2DSound(self.btnSoundPath)

    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.WeaponMake)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
        UIMgr:popUI("HomeWeaponProPanel", {})
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.WeaponMake})
    end
end

--[[
/ListBg/DispatchBtn onClick 
--]]
function MainPanel:dispatchBtn_ScaleButton_onClick(dispatchBtn)
    self:play2DSound(self.btnSoundPath)
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.ShipDispatch)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
    else
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
        UIMgr:popUI("DispatchMainPanel", {})
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.ShipDispatch})
    end
end

--[[
/ChangeBtn onClick 
--]]
function MainPanel:changeBtn_ScaleButton_onClick(changeBtn)
    local btnSoundPath = string.format(Config.AudioPath.SE, "wheel")
    self:play2DSound(btnSoundPath)
    self.changeBtn.scaleButton.interactable = false
    if self.mainMode.activeSelf then
        self.mainMode.animator:SetTrigger("Out")
        self.mainMode.animOverCallBack:SetCallBack(function()
            self.mainMode:SetActive(false)
            self.changeBtn.scaleButton.interactable = true
        end)
        self.changeBtn.isOff:SetActive(false)
        self.changeBtn.isOn:SetActive(true)
        self.listBg:SetActive(true)
    else
        self.listBg.animator:SetTrigger("Out")
        self.listBg.animOverCallBack:SetCallBack(function()
            self.listBg:SetActive(false)
            self.changeBtn.scaleButton.interactable = true
        end)
        self.changeBtn.isOff:SetActive(true)
        self.changeBtn.isOn:SetActive(false)
        self.mainMode:SetActive(true)
    end
    
end

--[[
/HideBtn onClick 
--]]
function MainPanel:hideBtn_ScaleButton_onClick(hideBtn)
    self:play2DSound(self.btnSoundPath)
    self.isHide = not self.isHide
    self:HideAll(self.isHide, false, true)
end

--[[
/SwitchBtn onClick 
--]]
function MainPanel:switchBtn_ScaleButton_onClick(switchBtn)
    self:play2DSound(self.btnSoundPath)
    self:PosterPanelMode(true)
    UIMgr:popUICover("PosterPanel", {})
end

--[[
/MsgBg onClick 
--]]
function MainPanel:msgBg_ScaleButton_onClick(msgBg)
    self:play2DSound(self.btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance():SetHomelandShowOrHide(false)
    end
    UIMgr:popUICover("UserPanel", {mode = self.nowMode})
end

--[[
/AdjustRoot/UiList/Right/AffectionEventBtn onClick 
--]]
function MainPanel:affectionEventBtn_ScaleButton_onClick(affectionEventBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("AffectionEventListPanel", {})
end

--[[
/AdjustRoot/UiList/Right/DayNightBtn onClick 
--]]
function MainPanel:dayNightBtn_Button_onClick(dayNightBtn)
    -- print("dayNightBtn_Button_onClick",CoveManager.instance())
    -- self:play2DSound(self.btnSoundPath)
    -- if CoveManager.instance() then
    --     -- print("dayNightBtn_Button_onClick _coveScene",CoveManager.instance()._coveScene)
    --     CoveManager.instance()._coveScene:RealtimeDayNight()
    -- end

    UIMgr:popUICover("SceneSettingPanel")

end

--[[
/AdjustRoot/UiList/Right/QuickDayNightBtn onClick 
--]]
function MainPanel:quickDayNightBtn_Button_onClick(quickDayNightBtn)
    self:play2DSound(self.btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance()._coveScene:QuickDayNight()
    end
end

--[[
/AdjustRoot/UiList/Right/DayBtn onClick 
--]]
function MainPanel:dayBtn_Button_onClick(dayBtn)
    self:play2DSound(self.btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance()._coveScene:DayMode()
    end
end

--[[
/AdjustRoot/UiList/Right/NightBtn onClick 
--]]
function MainPanel:nightBtn_Button_onClick(nightBtn)
    self:play2DSound(self.btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance()._coveScene:NightMode()
    end
end

--[[
/AdjustRoot/UiList/Right/SunsetBtn onClick 
--]]
function MainPanel:sunsetBtn_Button_onClick(sunsetBtn)
    self:play2DSound(self.btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance()._coveScene:SunsetMode()
    end
end

--[[
/AdjustRoot/UiList/Right/QuestionBtn onClick 
--]]
function MainPanel:questionBtn_ScaleButton_onClick(questionBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("QuestionPanel", {})
end

--[[
/AdjustRoot/UiList/Left/SceneSettingBtn onClick 
--]]
function MainPanel:sceneSettingBtn_ScaleButton_onClick(sceneSettingBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("SceneSettingPanel")
    --TODO
end

function MainPanel:UpdateSceneTime()
    if self.sceneTimeInfo == nil or self.sceneTimeInfo.gameObject == nil or not self.sceneTimeInfo.gameObject.activeSelf then
        return
    end
    if CoveManager.instance() == nil then
        return
    end
    local coveManager = CoveManager.instance()
    local curHomeWeatherCfg = coveManager.curHomeWeatherCfg
    if curHomeWeatherCfg == nil then
        return
    end

    local curTime = coveManager.curSceneTime
    if curTime == nil then
       return 
    end
    local type = 0
    local paramId = coveManager.weatherParamId
    ---@type WeatherParameterTable
    local weatherCfg = Config.GetWeatherParameterById(paramId)
    if weatherCfg ~= nil then
       type = weatherCfg.icon 
    end

    if timeIconType ~= type then
        timeIconType = type
        self:LoadSpriteAsync(string.format(string.format(Config.SpritePath.timeOfDayIcon, tostring(type))), self.sceneTimeInfo.timeIconImg.image)
    end

    local h = math.floor(curTime / (60 * 60))
	local m = math.floor((curTime - h * 60 * 60) / 60)
    local timeStr = string.format("%02d", h) .. ":" .. string.format("%02d", m)
    local result = ""
    for i = 1, #timeStr do
        local char = timeStr:sub(i, i)
        local spriteIndex = charMap[char]
        -- 只处理已映射的字符
        if spriteIndex then
            result = result .. string.format("<sprite=%d>", spriteIndex)
        end
    end
    self.sceneTimeInfo.timeNumText.text.text = result
end

--[[
/AdjustRoot/UiList/Right/gethomelandRewardBtn onClick 
--]]
function MainPanel:gethomelandRewardBtn_ScaleButton_onClick(gethomelandRewardBtn)
    Me:ReportHomelandGetEarningRewardReq(
        BindSelf(self, self.UpdateGetHomelandRewardBtnActive)
    )
end

function MainPanel:UpdateGetHomelandRewardBtnActive()
    if self.nowMode == self.modeList.office then
        self.gethomelandRewardBtn:SetActive(false)
        return
    end
    local itemList = Me:getHomeland().earningsItemList
    local customRewardItemCfg = Me:GetCustomRewardItemCfg()
    local hasReward = false
    if itemList ~= nil then
        for i = 1, #itemList do
            local item = itemList[i]
            if item.num <= 0 then
                goto continue 
            end
            local id = item.id
            local cusCfg = tablex.findSingle(customRewardItemCfg, function(cfg)
                return cfg[1] == id
            end)
            if cusCfg ~= nil then
                local minCount = cusCfg[#cusCfg][4]
                if item.num >= minCount then
                    hasReward = true
                    break
                end
            else
                hasReward = true
                break
            end
            ::continue::
        end
    end
    self.gethomelandRewardBtn:SetActive(hasReward)
end

function MainPanel:RefreshHomeland()
    self:UpdateGetHomelandRewardBtnActive()
    self:RefreshHomelandFunctionRedPoint()
    self:RefreshProsperityDisplay(true)
end

function MainPanel:OnBulidingLvChange()
    self:RefreshHomelandFunctionRedPoint()
    self:RefreshProsperityDisplay(true)
end

--[[
/AdjustRoot/UiList/Buttom/ButtomList/List/HomelandShopBtn onClick 
--]]
function MainPanel:homelandShopBtn_ScaleButton_onClick(homelandShopBtn)
    local btnSoundPath = string.format(Config.AudioPath.SE, "shop")
    self:play2DSound(btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomelandShop)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
        return
    end
    UIMgr:popUI("HomelandShopPanel", nil)
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.HomelandShop})
    end
end

--[[
/AdjustRoot/UiList/Left/ChangeCoveCam onClick  切换相机模式测试按钮
--]]
function MainPanel:changeCoveCam_Button_onClick(changeCoveCam)
    -- if CoveManager.instance() then
    --     -- CoveManager.instance():ChangeNextCameraMode()
    --     -- CoveManager.instance():setCameraPositionByFuncId(10003)
    --     --测试角色跟随
    --     local followId = CoveManager.instance()._coveScene._cameraFollowRoleId
    --     if followId then
    --         CoveManager.instance():ClearCameraFollowRoleId()
    --     else
    --         local roleList = CoveManager.instance():getRoleMgr()._roleList
    --         if roleList and tablex.size(roleList) > 0 then
    --             for k, v in pairs(roleList) do
    --                 LuaLogger.ds("roleList id:", tostring(v.roleData.id))
    --             end
    --             local randomId = roleList[math.random(1, tablex.size(roleList))].roleData.id
    --             CoveManager.instance():SetCameraFollowRoleId(randomId)
    --         end
    --     end
    -- end
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.SurvivalState)
    end, nil, nil, "MainPanel2")
end

--[[
/AdjustRoot/UiList/Right/ListBg/GenRoleFragBtn onClick 
--]]
function MainPanel:genRoleFragBtn_ScaleButton_onClick(genRoleFragBtn)
    self:play2DSound(self.btnSoundPath)
    --开放条件拦截
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.GenRoleFrag)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
        return
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.GenRoleFrag})
    end
    LoadingMgr:SetUISwitchStart(function()
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
        -- local asyncOperation = UnityEngine.SceneManagement.SceneManager.LoadSceneAsync("GenRoleFrag",UnityEngine.SceneManagement.LoadSceneMode.Additive)
        -- if self.loadSceneTimer then
        --     DLuaTimer:RemoveTimer(self.loadSceneTimer)
        -- end
        -- self.loadSceneTimer = DLuaTimer:DoRepeatForever(0.1, function()
        --     if (asyncOperation.isDone) then
        --         DLuaTimer:RemoveTimer(self.loadSceneTimer)
        --         ResMgr:LoadPrefabAsync(Config.PrefabPath.GenRoleFragRoot, function (obj)
        --             self.battleRoot = Instantiate(obj).gameObject
        --             local targetScene = UnityEngine.SceneManagement.SceneManager.GetSceneByName("GenRoleFrag");
        --             UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(self.battleRoot, targetScene);
        --              UIMgr:popUI("GenRoleFragPanel", {}, function()
        --                 LoadingMgr:SetUISwitchOver()
        --             end)
        --         end)
        --     end
        -- end)

        ResMgr:LoadSceneAsyncLua(Config.ScenePath.GenRoleFragScene, true, function(sceneName)
            ResMgr:LoadPrefabAsync(Config.PrefabPath.GenRoleFragRoot, function (obj)
                self.battleRoot = Instantiate(obj).gameObject
                local targetScene = UnityEngine.SceneManagement.SceneManager.GetSceneByName("GenRoleFrag");
                UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(self.battleRoot, targetScene);
                 UIMgr:popUI("GenRoleFragPanel", {}, function()
                    LoadingMgr:SetUISwitchOver()
                end)
            end)
        end)
    end)
end

--[[
/AdjustRoot/UiList/Left/leftCenterVer/passBtn onClick 
--]]
function MainPanel:passBtn_ScaleButton_onClick(passBtn)
    if self.m_mainPanelPassAcitveId > 0 then
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
        UIMgr:popUI("PassPanel", {activityId = self.m_mainPanelPassAcitveId})
    end

end

function MainPanel:RefreshPassActivity()
    local funcPassDataMap = function()
        local passdataMap = Me:getPassDataMap()
        self.m_mainPanelPassAcitveId = 0
        self.m_secondPassActiveID = 0
        for key, value in pairs(passdataMap) do
            if value.isClosed == 0 or value.isClosed == nil then
                local activityData = Config.GetActivityInfo(value.id)
                if activityData.FunctionType == GE.ActivityFunctionType.MainPanel then
                    self.m_mainPanelPassAcitveId = activityData.id
                elseif activityData.FunctionType == GE.ActivityFunctionType.Activity then
                    self.m_secondPassActiveID = activityData.id
                end
            end
        end

        local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.PASSPORT)

        local  isActive  = state == GE.FunctionOpenState.Open

        if isActive and self.m_mainPanelPassAcitveId > 0 then
            self.passBtn:SetActive(true)
        else
            self.passBtn:SetActive(false)
        end

    
        if isActive and self.m_secondPassActiveID > 0 then
            self.pass2Btn:SetActive(true)
        else
            self.pass2Btn:SetActive(false)
        end

        self.passBtn.red:SetActive(RedPointMgr:PassPanelRedJudge(self.m_mainPanelPassAcitveId))
        self.pass2Btn.red:SetActive(RedPointMgr:PassPanelRedJudge(self.m_secondPassActiveID))
    end
    Me:getFunctionDataReq({GE.PushData.passDataMap},funcPassDataMap)
end

--[[
/AdjustRoot/UiList/Left/leftCenterVer/gameShopBtn onClick 
--]]
function MainPanel:gameShopBtn_ScaleButton_onClick(gameShopBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("GameShopPanel", nil)
end

--[[
/AdjustRoot/UiList/Left/leftCenterVer/pass2Btn onClick 
--]]
function MainPanel:pass2Btn_ScaleButton_onClick(pass2Btn)
    if self.m_secondPassActiveID > 0 then
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
        UIMgr:popUI("PassPanel", {activityId = self.m_secondPassActiveID})
    end
end

--[[
/AdjustRoot/UiList/Top/homeBattleBtn onClick 
--]]
function MainPanel:homeBattleBtn_ScaleButton_onClick(homeBattleBtn)
    CoveBattleMgr.instance():FocusingBattle()
end

function MainPanel:RefreshCoveBattleInfo()
    local isBattle = CoveBattleMgr.instance():IsBattle()
    self.effect_Ui_ShenHaiRuQing:SetActive(self.nowMode == self.modeList.home and isBattle)
end

--[[
/Effect_Ui_ShenHaiRuQing/Effect/main_btn05_deepsea_word onClick 
--]]
function MainPanel:main_btn05_deepsea_word_ScaleButton_onClick(main_btn05_deepsea_word)

end

---刷新好友红点
function MainPanel:RefreshFriendRedPoint()
    local isActive = tablex.size(Me.requestFriends) > 0 or 
    Me:GetReceivableFriendPoints() > 0
    self.friendBtn.red:SetActive(isActive)
end

--[[
/AdjustRoot/UiList/Left/leftCenterVer/ActivityBtn onClick 
--]]
function MainPanel:activityBtn_ScaleButton_onClick(activityBtn)
    if CoveManager.instance() then
        CoveManager.instance():SetHomelandShowOrHide(false)
    end
    UIMgr:popUI("ActivityPanel", {mode = self.nowMode})
end

--[[
/AdjustRoot/UiList/Right/MainMode/Change/homelandFunctionBtn onClick 
--]]
function MainPanel:homelandFunctionBtn_ScaleButton_onClick(homelandFunctionBtn)

    UIMgr:popUICover("HomelandFunctionQuickPositioningPanel")

end

--[[
/AdjustRoot/UiList/Left/Layout/CameraType onClick 相机角度切换按钮
--]]
function MainPanel:cameraType_ScaleButton_onClick(cameraType)
    local typeList = Config.GetConfigInfo("HomeCameraType")
    local max = tablex.size(typeList)
    local index = MyPrefs:GetInt(GE.LocalCustomDataKey.CoveCameraAngle)
    index = index + 1 > max and 1 or index + 1
    MyPrefs:SetInt(GE.LocalCustomDataKey.CoveCameraAngle, index)
    if CoveManager.instance() then
        CoveManager.instance():RefreshCameraAngle(true)
    end
    self:RefreshAngleDisplay()
end

---刷新相机角度显示
function MainPanel:RefreshAngleDisplay()
    local index = MyPrefs:GetInt(GE.LocalCustomDataKey.CoveCameraAngle)
    -- self.cameraTypeText.text.text = "x"..index
end

function MainPanel:RefreshHomelandFunctionRedPoint()
    
    local funCfg = {
        GE.CoustructionEnum.CommandRoom,
        GE.CoustructionEnum.Armory,
        GE.CoustructionEnum.WS2,
        GE.CoustructionEnum.Aluminum,
        GE.CoustructionEnum.Steel,
        GE.CoustructionEnum.OilWell,
        GE.CoustructionEnum.Shop,
    }
    local isShow = false
    for i = 1, #funCfg do
        local id = funCfg[i]
        isShow = RedPointMgr:HomeBulidRedJudge(id)
        if isShow then
           break 
        end
    end
    self.homelandFunctionBtn.red:SetActive(isShow)
end

---@param itemId integer
---@return Vector3?
function MainPanel:GetResrouceItemPos(itemId)

    ---@type Vector3?
    local wPos = nil 
    if self.resourceItems[itemId] ~= nil then
        local box = self.resourceItems[itemId]
        local rTrs = box.resIcon.image.rectTransform
        local pos = box.resIcon.image.rectTransform.localPosition
        pos = Vector2.New(pos.x, pos.y)
        local w = rTrs.sizeDelta.x
        pos.x = pos.x + w / 2
        wPos = box.gameObject.transform:TransformPoint(pos.x, pos.y, 0)
    else
        local trs = self.userLevelTxt.gameObject.transform
        wPos = trs.position
    end
    local lPos = self.transform:InverseTransformPoint(wPos)
    return lPos
end

function MainPanel:PlayGetRewardEffect(data)

    local worldPos = data.worldPos
    local rewards = data.rewards
    self.getRewardEffect.mainPane_RewardEffect:PlayEffect(worldPos, rewards)
    if true then
       return 
    end
    local showEffect = true
    for i = 1, #rewards do
        local id = rewards[i].id
        local pos = self:GetResrouceItemPos(id)
        if pos == nil then
            showEffect = false
            break 
        end
    end
    if showEffect then
        self.getRewardEffect.mainPane_RewardEffect:PlayEffect(worldPos, rewards)
    else
        Me:ReceiveReward(rewards)
    end

end

-- function MainPanel:CreateRT(width, height, depth)
--     width = width or 1024
--     height = height or 1024
--     depth = depth or 24
--     Debugger.Log("[resetRenderTexture] MainPanel:CreateRT")
--     local rt = UnityEngine.RenderTexture(width, height, depth)
--     rt.name = "MainPanelRT"
--     local camera = GameObject.Find("RoleCamera"):GetComponent(typeof(UnityEngine.Camera))
--     if camera then
--         -- 让相机渲染到这张 RT
--         camera.targetTexture = rt
--     end
--     self.roleRI.rawImage.texture = rt
--     self.rt = rt
-- end

function MainPanel:loadRoleModel()
    self.roleDisRoot = GameObject.Find("RoleDisRoot")
    PoolMgr:Get("Prefabs/Character/ATest/TestMod.prefab", function (roleObj)
		self._roleObj = roleObj
        roleObj.transform:SetParent(self.roleDisRoot.transform)
        roleObj.transform.localPosition = Vector3.New(0,0,-4.86)
        roleObj.transform.localRotation = Quaternion.Euler(0,180,0)
    end)
end

function MainPanel:ReleaseRT()
    if self.rt then
        local camera = GameObject.Find("RoleCamera")
        if camera then
            camera = camera:GetComponent(typeof(UnityEngine.Camera))
            -- 让相机渲染到这张 RT
            camera.targetTexture = nil
        end
        self.rt:Release()
        self.rt = nil
    end
end

function MainPanel:Add3DMark(...)
    self.sceneMarkView.mainPanel_SceneMarkViwe:Add3DMark(...)
end

function MainPanel:Remove3DMark(...)
    self.sceneMarkView.mainPanel_SceneMarkViwe:Remove3DMark(...)
end
--[[
/test/b1b onClick 
--]]
function MainPanel:b1b_ScaleButton_onClick(b1b)

end

--[[
/test/b21b onClick 
--]]
function MainPanel:b21b_ScaleButton_onClick(b21b)

end

--[[
/test/b22b onClick 
--]]
function MainPanel:b22b_ScaleButton_onClick(b22b)

end

--[[
/test/b31b onClick 
--]]
function MainPanel:b31b_ScaleButton_onClick(b31b)

end

--[[
/test/b32b onClick 
--]]
function MainPanel:b32b_ScaleButton_onClick(b32b)

end

--[[
/test/b33b onClick 
--]]
function MainPanel:b33b_ScaleButton_onClick(b33b)

end

--[[
/test/b34b onClick 
--]]
function MainPanel:b34b_ScaleButton_onClick(b34b)

end

--[[
/test/b35b onClick 
--]]
function MainPanel:b35b_ScaleButton_onClick(b35b)

end

--[[
/AdjustRoot/UiList/Left/leftCenterVer/SevenBtn onClick 
--]]
function MainPanel:sevenBtn_ScaleButton_onClick(sevenBtn)
    self:play2DSound(self.btnSoundPath)
    if CoveManager.instance() then
        CoveManager.instance():SetHomelandShowOrHide(false)
    end
    UIMgr:popUI("SevenDaysTaskPanel", {})
end

--[[
/AdjustRoot/UiList/Right/ActivityStoryBtn onClick 
--]]
function MainPanel:activityStoryBtn_ScaleButton_onClick(activityStoryBtn)
    self:play2DSound(self.btnSoundPath)
    local activityMap = Me:getActivityMap()
    local activityCfg = nil
    for activityId, activityInfo in pairs(activityMap) do
        local cfg = Config.GetActivityInfo(activityId)
        if cfg and cfg.Type == GE.ActivityType.ActivityStory and activityInfo.state == GE.ActivityState.Open then
            activityCfg = cfg
            break
        end
    end
    if activityCfg == nil then return end
    if CoveManager.instance() then
        CoveManager.instance():SetHomelandShowOrHide(false)
    end
    UIMgr:popUI(activityCfg.panelName, {groupList = activityCfg.activityPara})
end

--[[
/AdjustRoot/UiList/Right/ProsperityBtn onClick 
--]]
function MainPanel:prosperityBtn_ScaleButton_onClick(prosperityBtn)
    UIMgr:popUICover("ProsperityPanel", {})
end






return MainPanel
