-- chunkname: @modules/logic/versionactivity2_5/act187/view/Activity187View.lua

module("modules.logic.versionactivity2_5.act187.view.Activity187View", package.seeall)

local Activity187View = class("Activity187View", BaseView)
local SWITCH_VIEW_TIME = 0.5
local REWARD_HAS_GET_ANIM_TIME = 1

function Activity187View:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "#go_title/image_TimeBG/#txt_remainTime")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_lantern/#txt_index")
	self._btnleft = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_lantern/#btn_left")
	self._golowribbon = gohelper.findChild(self.viewGO, "#go_lantern/#go_decorationLower")
	self._simagelantern = gohelper.findChildSingleImage(self.viewGO, "#go_lantern/#simage_lantern/#simage_lantern1")
	self._btnlantern = gohelper.findChildClick(self.viewGO, "#go_lantern/#simage_lantern/#btn_click")
	self._goupribbon = gohelper.findChild(self.viewGO, "#go_lantern/#go_decorationUpper")
	self._simagepicture = gohelper.findChildSingleImage(self.viewGO, "#go_lantern/#simage_lantern/#simage_picture")
	self._gotail = gohelper.findChild(self.viewGO, "#go_lantern/#simage_lantern/#go_tail")
	self._goincomplete = gohelper.findChild(self.viewGO, "#go_lantern/#simage_lantern/#go_tail/#go_incomplete")
	self._btnshowRiddles = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_lantern/#simage_lantern/#go_tail/#btn_showRiddles")
	self._goriddles = gohelper.findChild(self.viewGO, "#go_lantern/#simage_lantern/#go_riddles")
	self._btncloseRiddles = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#btn_closeRiddles")
	self._txtriddles = gohelper.findChildText(self.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#txt_riddles")
	self._goriddlesRewards = gohelper.findChild(self.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#go_riddlesRewards")
	self._goriddlesRewardItem = gohelper.findChild(self.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#go_riddlesRewards/#go_riddlesRewardItem")
	self._btnright = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_lantern/#btn_right")
	self._btnpaint = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_paint")
	self._gopaintreddot = gohelper.findChild(self.viewGO, "#btn_paint/#go_reddot")
	self._gobegin = gohelper.findChild(self.viewGO, "#btn_paint/#go_begin")
	self._txtpaintTimes = gohelper.findChildText(self.viewGO, "#btn_paint/#go_begin/#txt_paintTimes")
	self._gonoPaint = gohelper.findChild(self.viewGO, "#btn_paint/#go_noPaint")
	self._gorewardBarBg = gohelper.findChild(self.viewGO, "#go_rewards/#go_grayLine")
	self._gorewardBar = gohelper.findChild(self.viewGO, "#go_rewards/#go_grayLine/#go_highLine")
	self._gorewardItemLayout = gohelper.findChild(self.viewGO, "#go_rewards/#go_rewardLayout")
	self._gorewardItem = gohelper.findChild(self.viewGO, "#go_rewards/#go_rewardLayout/#go_rewardItem")
	self._gopaintingview = gohelper.findChildClick(self.viewGO, "v2a5_lanternfestivalpainting")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity187View:addEvents()
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnlantern:AddClickListener(self._btnlanternOnClick, self)
	self._btnshowRiddles:AddClickListener(self._btnshowRiddlesOnClick, self)
	self._btncloseRiddles:AddClickListener(self._btncloseRiddlesOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnpaint:AddClickListener(self._btnpaintOnClick, self)
	self._lanternAnimationEvent:AddEventListener("left", self._onLeftRefresh, self)
	self._lanternAnimationEvent:AddEventListener("right", self._onRightRefresh, self)
	NavigateMgr.instance:addEscape(self.viewName, self.onBtnEsc, self)
	self.addEventCb(self, Activity187Controller.instance, Activity187Event.GetAct187Info, self.onGetActInfo, self)
	self.addEventCb(self, Activity187Controller.instance, Activity187Event.FinishPainting, self.onFinishPainting, self)
	self.addEventCb(self, Activity187Controller.instance, Activity187Event.GetAccrueReward, self.onGetAccrueReward, self)
	self.addEventCb(self, Activity187Controller.instance, Activity187Event.RefreshAccrueReward, self.onRefreshAccrueReward, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.checkActivityInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.checkActivityInfo, self)
end

function Activity187View:removeEvents()
	self._btnleft:RemoveClickListener()
	self._btnlantern:RemoveClickListener()
	self._btnshowRiddles:RemoveClickListener()
	self._btncloseRiddles:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnpaint:RemoveClickListener()
	self._lanternAnimationEvent:RemoveAllEventListener()
	self.removeEventCb(self, Activity187Controller.instance, Activity187Event.GetAct187Info, self.onGetActInfo, self)
	self.removeEventCb(self, Activity187Controller.instance, Activity187Event.FinishPainting, self.onFinishPainting, self)
	self.removeEventCb(self, Activity187Controller.instance, Activity187Event.GetAccrueReward, self.onGetAccrueReward, self)
	self.removeEventCb(self, Activity187Controller.instance, Activity187Event.RefreshAccrueReward, self.onRefreshAccrueReward, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, self.checkActivityInfo, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.checkActivityInfo, self)
end

function Activity187View:_btnleftOnClick()
	if self._curIndex <= 1 then
		return
	end

	self:refreshLanternIndex()

	self._curIndex = self._curIndex - 1

	self._lanternAnimator:Play("left", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
end

function Activity187View:_onLeftRefresh()
	self:refreshLanternIndex()
end

function Activity187View:_btnlanternOnClick()
	local finishPaintIndex = Activity187Model.instance:getFinishPaintingIndex()
	local rewardId = Activity187Model.instance:getPaintingRewardId(self._curIndex)

	if finishPaintIndex < self._curIndex and not rewardId then
		self:_btnpaintOnClick()
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function Activity187View:_btnshowRiddlesOnClick()
	self:setRiddlesShow(true)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_mln_page_turn)
end

function Activity187View:_btncloseRiddlesOnClick()
	self:setRiddlesShow(false)
end

function Activity187View:_btnrightOnClick()
	if self._curIndex >= self._maxIndex then
		return
	end

	self:refreshLanternIndex()

	self._curIndex = self._curIndex + 1

	self._lanternAnimator:Play("right", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
end

function Activity187View:_onRightRefresh()
	self:refreshLanternIndex()
end

function Activity187View:_btnpaintOnClick()
	local count = Activity187Model.instance:getRemainPaintingCount() or 0
	local hasCount = count > 0

	if not hasCount then
		return
	end

	local finishPaintIndex = Activity187Model.instance:getFinishPaintingIndex()

	if finishPaintIndex == self._maxIndex then
		return
	end

	self._curIndex = self._maxIndex

	self:refreshLanternIndex()
	self:setPaintingViewDisplay(true)
end

function Activity187View:onBtnEsc()
	if self.isShowPaintView then
		self:setPaintingViewDisplay(false)
	else
		self:closeThis()
	end
end

function Activity187View:onGetActInfo()
	self:setLanternIndex()
	self:setAccrueReward()
	self:refresh()
end

function Activity187View:onFinishPainting(finishIndex)
	self:setLanternIndex(finishIndex)
	self:refresh()
	self:refreshAccrueRewardItem()
	self:setRiddlesShow(true)
end

function Activity187View:onGetAccrueReward(materialMOList)
	self._rewardsMaterials = materialMOList

	self:refreshAccrueRewardItem(true)
end

function Activity187View:onRefreshAccrueReward()
	self:refreshAccrueProgress()

	if self._accrueRewardItemList then
		for _, rewardItem in ipairs(self._accrueRewardItemList) do
			rewardItem:refreshStatus()
		end
	end
end

function Activity187View:checkActivityInfo(argsActId)
	local actId = Activity187Model.instance:getAct187Id()

	if argsActId and argsActId ~= actId then
		return
	end

	local isOpen = Activity187Model.instance:isAct187Open(true)

	if isOpen then
		Activity187Controller.instance:getAct187Info()
	else
		self:closeThis()
	end
end

function Activity187View:_editableInitView()
	self._lowRibbonDict = self:getUserDataTb_()
	self._upRibbonDict = self:getUserDataTb_()

	self:_fillRibbonDict(self._golowribbon.transform, self._lowRibbonDict)
	self:_fillRibbonDict(self._goupribbon.transform, self._upRibbonDict)

	local golantern = gohelper.findChild(self.viewGO, "#go_lantern")

	self._lanternAnimationEvent = golantern:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._lanternAnimator = golantern:GetComponent(typeof(UnityEngine.Animator))
	self._barBgWidth = recthelper.getWidth(self._gorewardBarBg.transform)
	self._riddlesRewardItemList = {}

	gohelper.setActive(self._goriddlesRewardItem, false)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.isShowPaintView = false
end

function Activity187View:_fillRibbonDict(parentTrans, dict)
	local childCount = parentTrans.childCount

	for i = 1, childCount do
		local child = parentTrans:GetChild(i - 1)

		dict[child.name] = child
	end
end

function Activity187View:onUpdateParam()
	return
end

function Activity187View:onOpen()
	self:setLanternIndex()
	self:setAccrueReward()
	self:refresh()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(self._gopaintreddot, RedDotEnum.DotNode.V2a5_Act187CanPaint)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_tangren_yuanxiao_open)
end

function Activity187View:setLanternIndex(index)
	local finishPaintIndex = Activity187Model.instance:getFinishPaintingIndex()
	local nextIndex = finishPaintIndex
	local count = Activity187Model.instance:getRemainPaintingCount() or 0

	if count > 0 then
		nextIndex = finishPaintIndex + 1
	end

	local cfgMaxIndex = Activity187Config.instance:getAct187Const(Activity187Enum.ConstId.MaxLanternCount)

	cfgMaxIndex = tonumber(cfgMaxIndex) or 0

	if cfgMaxIndex < 0 then
		cfgMaxIndex = nextIndex
	end

	self._maxIndex = math.min(nextIndex, cfgMaxIndex)
	self._curIndex = index or self._maxIndex
end

local function _sortFunc(a, b)
	return a < b
end

function Activity187View:setAccrueReward()
	self._accrueRewardItemList = {}

	local actId = Activity187Model.instance:getAct187Id()
	local idList = Activity187Config.instance:getAccrueRewardIdList(actId)

	table.sort(idList, _sortFunc)

	local rewardList = {}

	for _, id in ipairs(idList) do
		local rewards = Activity187Config.instance:getAccrueRewards(actId, id)

		rewardList[#rewardList + 1] = rewards[1]
	end

	gohelper.CreateObjList(self, self._onSetAccrueRewardItem, rewardList, self._gorewardItemLayout, self._gorewardItem, Activity187AccrueRewardItem)
end

function Activity187View:_onSetAccrueRewardItem(obj, data, index)
	obj:setData(data)

	self._accrueRewardItemList[index] = obj
end

function Activity187View:setRiddlesShow(isShow)
	gohelper.setActive(self._gotail, not isShow)
	gohelper.setActive(self._goriddles, isShow)
end

function Activity187View:setPaintingViewDisplay(isShow)
	if self.isShowPaintView == isShow then
		return
	end

	self.isShowPaintView = isShow

	if self.isShowPaintView then
		self.animator:Play("MainToDraw", 0, 0)
	else
		self.animator:Play("DrawToMain", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_tangren_yuanxiao_pop)
	UIBlockMgr.instance:startBlock(Activity187Enum.BlockKey.SwitchView)
	TaskDispatcher.cancelTask(self._endBlock, self)
	TaskDispatcher.runDelay(self._endBlock, self, SWITCH_VIEW_TIME)
	Activity187Controller.instance:dispatchEvent(Activity187Event.PaintViewDisplayChange, self.isShowPaintView, self._maxIndex)
end

function Activity187View:_endBlock()
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.SwitchView)
end

function Activity187View:refresh()
	self:refreshLanternIndex()
	self:refreshPaintingCount()
	self:refreshAccrueProgress()
	self:refreshRemainTime()
end

function Activity187View:refreshLanternIndex()
	local lang = luaLang("room_wholesale_weekly_revenue")

	self._txtindex.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, self._curIndex, self._maxIndex)

	self:refreshLantern()
	self:refreshArrow()
end

function Activity187View:refreshLantern()
	self:hideAllRiddlesRewardItem()

	local lantern = Activity187Enum.EmptyLantern
	local ribbonIndex
	local rewardId = Activity187Model.instance:getPaintingRewardId(self._curIndex)

	if rewardId then
		local actId = Activity187Model.instance:getAct187Id()

		lantern = Activity187Config.instance:getLantern(actId, rewardId)
		ribbonIndex = Activity187Config.instance:getLanternRibbon(actId, rewardId)

		local lanternImg = Activity187Config.instance:getLanternImg(actId, rewardId)

		self._simagepicture:LoadImage(ResUrl.getAct184LanternIcon(lanternImg))

		self._txtriddles.text = Activity187Config.instance:getBlessing(actId, rewardId)

		local rewardList = Activity187Model.instance:getPaintingRewardList(self._curIndex)

		for i, matMO in ipairs(rewardList) do
			local rewardItem = self:getRiddlesRewardItem(i)

			rewardItem.itemIcon:onUpdateMO(matMO)
		end
	end

	self._simagelantern:LoadImage(ResUrl.getAct184LanternIcon(lantern))

	for index, go in pairs(self._lowRibbonDict) do
		gohelper.setActive(go, index == ribbonIndex)
	end

	for index, go in pairs(self._upRibbonDict) do
		gohelper.setActive(go, index == ribbonIndex)
	end

	gohelper.setActive(self._simagepicture, rewardId)
	gohelper.setActive(self._btnshowRiddles, rewardId)
	gohelper.setActive(self._goincomplete, not rewardId)
	self:setRiddlesShow(false)
end

function Activity187View:hideAllRiddlesRewardItem()
	self._riddlesRewardItemList = self._riddlesRewardItemList or {}

	for _, riddlesRewardItem in ipairs(self._riddlesRewardItemList) do
		gohelper.setActive(riddlesRewardItem.go, false)
	end
end

function Activity187View:getRiddlesRewardItem(index)
	self._riddlesRewardItemList = self._riddlesRewardItemList or {}

	local rewardItem = self._riddlesRewardItemList[index]

	if not rewardItem then
		rewardItem = self:getUserDataTb_()
		rewardItem.go = gohelper.clone(self._goriddlesRewardItem, self._goriddlesRewards, index)

		local itemGo = gohelper.findChild(rewardItem.go, "#go_item")

		rewardItem.itemIcon = IconMgr.instance:getCommonItemIcon(itemGo)

		rewardItem.itemIcon:setCountFontSize(40)

		self._riddlesRewardItemList[index] = rewardItem
	end

	gohelper.setActive(rewardItem.go, true)

	return rewardItem
end

function Activity187View:refreshArrow()
	gohelper.setActive(self._btnleft, self._curIndex > 1)
	gohelper.setActive(self._btnright, self._curIndex < self._maxIndex)
end

function Activity187View:refreshPaintingCount()
	local count = Activity187Model.instance:getRemainPaintingCount() or 0
	local hasCount = count > 0

	self._txtpaintTimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act187_painting_count"), count)

	gohelper.setActive(self._gobegin, hasCount)
	gohelper.setActive(self._gonoPaint, not hasCount)
end

function Activity187View:refreshAccrueProgress()
	local actId = Activity187Model.instance:getAct187Id()
	local idList = Activity187Config.instance:getAccrueRewardIdList(actId)

	table.sort(idList, _sortFunc)

	local curIndex = 0
	local accrueRewardIndex = Activity187Model.instance:getAccrueRewardIndex()

	for i, id in ipairs(idList) do
		if id <= accrueRewardIndex then
			curIndex = i - 1
		end
	end

	local totalRewardCount = #idList
	local deltaDistance = 1 / (totalRewardCount - 1)
	local progress = curIndex * deltaDistance

	recthelper.setWidth(self._gorewardBar.transform, progress * self._barBgWidth)
end

function Activity187View:refreshRemainTime()
	self._txtremainTime.text = Activity187Model.instance:getAct187RemainTimeStr()
end

function Activity187View:refreshAccrueRewardItem(isPlayAnim)
	if self._accrueRewardItemList then
		for _, rewardItem in ipairs(self._accrueRewardItemList) do
			rewardItem:refreshStatus(isPlayAnim)
		end
	end

	if self._rewardsMaterials then
		UIBlockMgr.instance:startBlock(Activity187Enum.BlockKey.GetAccrueReward)
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
		TaskDispatcher.cancelTask(self._showMaterials, self)
		TaskDispatcher.runDelay(self._showMaterials, self, REWARD_HAS_GET_ANIM_TIME)
	end
end

function Activity187View:_showMaterials()
	RoomController.instance:popUpRoomBlockPackageView(self._rewardsMaterials)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, self._rewardsMaterials)

	self._rewardsMaterials = nil

	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetAccrueReward)
end

function Activity187View:onClose()
	self._simagepicture:UnLoadImage()
	self._simagelantern:UnLoadImage()
	TaskDispatcher.cancelTask(self._endBlock, self)
	TaskDispatcher.cancelTask(self._showMaterials, self)
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.SwitchView)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetAccrueReward)

	self._rewardsMaterials = nil
end

function Activity187View:onDestroyView()
	return
end

return Activity187View
