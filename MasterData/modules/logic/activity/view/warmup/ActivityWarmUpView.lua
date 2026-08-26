-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpView.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpView", package.seeall)

local ActivityWarmUpView = class("ActivityWarmUpView", BaseView)

function ActivityWarmUpView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagebg3 = gohelper.findChildSingleImage(self.viewGO, "#go_main/#simage_bg3")
	self._simagebg4 = gohelper.findChildSingleImage(self.viewGO, "#go_main/#simage_bg4")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_main/#go_btns")
	self._simagemap = gohelper.findChildSingleImage(self.viewGO, "#go_main/#simage_map")
	self._godayitem = gohelper.findChild(self.viewGO, "#go_main/#scroll_daylist/Viewport/Content/#go_dayitem")
	self._gochangllenitem = gohelper.findChild(self.viewGO, "#go_main/#go_area/#go_changllenitem")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_main/#btn_extra/#go_reddot")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#btn_extra/#btn_task")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "#go_main/#txt_remaintime")
	self._gowelcome = gohelper.findChild(self.viewGO, "#go_welcome")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_welcome/#btn_start")
	self._gomain = gohelper.findChild(self.viewGO, "#go_main")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWarmUpView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
end

function ActivityWarmUpView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btntask:RemoveClickListener()
end

ActivityWarmUpView.OrderMaxPos = 4

function ActivityWarmUpView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getActivityWarmUpBg("full/bj003"))
	self._simagebg3:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi6"))

	self._bgMaterial = MonoHelper.addNoUpdateLuaComOnceToGo(self._simagebg3.gameObject, SingleBgToMaterial)

	self._bgMaterial:loadMaterial(self._simagebg3, "ui_black2transparent")
	self._simagebg4:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi7"))

	self._animtorSelf = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._posListX = {}
	self._posListY = {}

	for i = 1, ActivityWarmUpView.OrderMaxPos do
		local go = gohelper.findChild(self.viewGO, "#go_main/#go_area/#go_pos" .. i)
		local x, y = recthelper.getAnchor(go.transform)

		self._posListX[i], self._posListY[i] = x, y
	end

	self._tabItems = {}
	self._orderItems = {}

	gohelper.setActive(self._gowelcome, false)
	gohelper.setActive(self._gomain, true)

	self._imageBossFrameTab = self:getUserDataTb_()
end

function ActivityWarmUpView:onDestroyView()
	for _, item in pairs(self._tabItems) do
		item.btn:RemoveClickListener()
	end

	for _, item in pairs(self._orderItems) do
		item.btnDetail:RemoveClickListener()
		item.btnPlay:RemoveClickListener()
		item.btnGoto:RemoveClickListener()
		item.btnFinishInfo:RemoveClickListener()
	end

	for _, icon in pairs(self._imageBossFrameTab) do
		icon:UnLoadImage()
	end

	self._simagebg:UnLoadImage()
	self._simagebg3:UnLoadImage()
	self._bgMaterial:dispose()
	self._simagebg4:UnLoadImage()
end

function ActivityWarmUpView:onOpen()
	local parentGO = self.viewParam.parent
	local actId = self.viewParam.actId

	gohelper.addChild(parentGO, self.viewGO)
	self.addEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, self.refreshUI, self)
	self.addEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, self.refreshUI, self)
	self.addEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderFinish, self.onPlayOrderFinish, self)
	self.addEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderCancel, self.onPlayOrderCancel, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinishCall, self)
	ActivityWarmUpController.instance:init(actId)
	Activity106Rpc.instance:sendGet106InfosRequest(actId)

	local reddotId, reddotUid = ActivityWarmUpController.instance:getRedDotParam()

	if reddotId ~= nil then
		RedDotController.instance:addRedDot(self._goreddot, reddotId, reddotUid)
	end

	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
	self:checkFirstShowHelp(actId)
end

function ActivityWarmUpView:onClose()
	self.removeEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, self.refreshUI, self)
	self.removeEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, self.refreshUI, self)
	self.removeEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderFinish, self.onPlayOrderFinish, self)
	self.removeEventCb(self, ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderCancel, self.onPlayOrderCancel, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinishCall, self)
	gohelper.setActive(self._gomain, true)
	gohelper.setActive(self._gowelcome, false)
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function ActivityWarmUpView:checkFirstShowHelp(actId)
	local key = self:getFirstHelpKey()
	local rs = PlayerPrefsHelper.getString(key, "")

	if string.nilorempty(rs) then
		gohelper.setActive(self._gomain, false)
		gohelper.setActive(self._gowelcome, true)
	end
end

function ActivityWarmUpView:onWelcomeUIClose()
	gohelper.setActive(self._gomain, true)

	local key = self:getFirstHelpKey()

	PlayerPrefsHelper.setString(key, "watched")
	HelpController.instance:showHelp(HelpEnum.HelpId.ActivityWarmUp)
end

function ActivityWarmUpView:getFirstHelpKey()
	local actId = self.viewParam.actId

	return "ActivityWarmUpViewHelp#" .. tostring(actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function ActivityWarmUpView:refreshUI()
	self:refreshAllTabBtns()
	self:refreshAllOrder()
	self:refreshRemainTime()
end

function ActivityWarmUpView:refreshAllTabBtns()
	local totalDay = ActivityWarmUpModel.instance:getTotalContentDays()
	local curDay = ActivityWarmUpModel.instance:getCurrentDay()

	for day = 1, totalDay do
		local item = self:getOrCreateTabItem(day)

		self:refreshTabBtn(item, day)
	end
end

function ActivityWarmUpView:refreshTabBtn(item, index)
	local curDay = ActivityWarmUpModel.instance:getCurrentDay()

	gohelper.setActive(item.go, true)

	local strDay = tostring(index)

	UISpriteSetMgr.instance:setActivityWarmUpSprite(item.imageUnchooseDay, "xi_0" .. index)
	UISpriteSetMgr.instance:setActivityWarmUpSprite(item.imageChooseDay, "da_0" .. index)

	local isChoosen = ActivityWarmUpModel.instance:getSelectedDay() == index

	gohelper.setActive(item.goChoose, isChoosen)
	gohelper.setActive(item.goUnchoose, not isChoosen)
	gohelper.setActive(item.goLock, curDay < index)
end

function ActivityWarmUpView:refreshRemainTime()
	local actId = ActivityWarmUpModel.instance:getActId()
	local actMO = ActivityModel.instance:getActMO(actId)

	if actMO then
		local remainTimeSec = actMO.endTime / 1000 - ServerTime.now()
		local timeStr, format = TimeUtil.secondToRoughTime2(remainTimeSec)

		self._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), timeStr .. format)
	else
		self._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), "--")
	end
end

function ActivityWarmUpView:getOrCreateTabItem(index)
	local item = self._tabItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._godayitem, "tabitem_" .. tostring(index))

		item.go = go
		item.goUnchoose = gohelper.findChild(go, "go_unselected")
		item.goChoose = gohelper.findChild(go, "go_selected")
		item.imageUnchooseDay = gohelper.findChildImage(go, "go_unselected/day")
		item.imageChooseDay = gohelper.findChildImage(go, "go_selected/day")
		item.goLock = gohelper.findChild(go, "go_lock")
		item.btn = gohelper.findChildButtonWithAudio(go, "btn_click")

		item.btn:AddClickListener(ActivityWarmUpView.onClickTabItem, {
			self = self,
			index = index
		})

		self._tabItems[index] = item
	end

	return item
end

function ActivityWarmUpView:refreshAllOrder()
	self._processedItemSet = self._processedItemSet or {}

	local orders = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if orders then
		for i, orderMO in ipairs(orders) do
			self:refreshOrder(i, orderMO)
		end
	end

	for _, item in pairs(self._orderItems) do
		if not self._processedItemSet[item] then
			gohelper.setActive(item.go, false)
		end
	end

	for k, v in pairs(self._processedItemSet) do
		self._processedItemSet[k] = nil
	end
end

function ActivityWarmUpView:refreshOrder(index, orderMO)
	if index > ActivityWarmUpView.OrderMaxPos then
		logError("order config count error : " .. tostring(index) .. ", max is " .. tostring(ActivityWarmUpView.OrderMaxPos))

		return
	end

	local item = self:getOrCreateOrderItem(index)

	gohelper.setActive(item.go, true)

	item.txtName.text = tostring(orderMO.cfg.name)
	item.txtLocation.text = tostring(string.format(luaLang("activity_warmup_location"), orderMO.cfg.location))

	UISpriteSetMgr.instance:setActivityWarmUpSprite(item.imageBoss, orderMO.cfg.bossPic)

	if (item.orderActId ~= orderMO.cfg.activityId or item.orderId ~= orderMO.cfg.id) and item.animOrderFinish.isActiveAndEnabled then
		item.animOrderFinish:Play(UIAnimationName.Idle)
	end

	item.orderActId = orderMO.cfg.activityId
	item.orderId = orderMO.cfg.id

	local strPath = ActivityWarmUpEnum.Quality2FramePath[orderMO.cfg.rare]

	if not string.nilorempty(strPath) then
		gohelper.setActive(item.imageBossFrame.gameObject, true)
		item.imageBossFrame:LoadImage(ResUrl.getActivityWarmUpLangIcon(strPath))
		table.insert(self._imageBossFrameTab, item.imageBossFrame)
	else
		gohelper.setActive(item.imageBossFrame.gameObject, false)
	end

	local status = orderMO:getStatus()

	gohelper.setActive(item.btnPlay.gameObject, status == ActivityWarmUpEnum.OrderStatus.Collected)
	gohelper.setActive(item.btnGoto.gameObject, status == ActivityWarmUpEnum.OrderStatus.Accepted)
	gohelper.setActive(item.btnFinishInfo.gameObject, status == ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(item.goFinish, status == ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(item.btnDetail.gameObject, status ~= ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(item.goOrderFinish, status == ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(item.goOrderRunning, status ~= ActivityWarmUpEnum.OrderStatus.Finished)

	if status == ActivityWarmUpEnum.OrderStatus.Accepted or status == ActivityWarmUpEnum.OrderStatus.Collected then
		gohelper.setActive(item.txtProgress.gameObject, true)

		if not orderMO.progress then
			local maxProgress = orderMO.cfg.maxProgress

			item.txtProgress.text = string.format("%s/%s", orderMO.progress, maxProgress)
		end
	elseif status == ActivityWarmUpEnum.OrderStatus.Finished then
		gohelper.setActive(item.txtProgress.gameObject, true)

		item.txtProgress.text = luaLang("p_task_get")
		item.txtNewsInfo.text = GameUtil.getBriefName(orderMO.cfg.infoDesc, 96, "...")
	else
		gohelper.setActive(item.txtProgress.gameObject, false)
	end

	self._processedItemSet[item] = true
end

function ActivityWarmUpView:getOrCreateOrderItem(index)
	local item = self._orderItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gochangllenitem, "orderitem_" .. tostring(index))

		item.go = go
		item.txtName = gohelper.findChildText(go, "go_unpassgame/txt_title")
		item.txtProgress = gohelper.findChildText(go, "go_unpassgame/txt_progress")
		item.txtLocation = gohelper.findChildText(go, "go_unpassgame/txt_bossdesc")
		item.imageBoss = gohelper.findChildImage(go, "go_unpassgame/image_icon")
		item.imageBossFrame = gohelper.findChildSingleImage(go, "go_unpassgame/image_iconbg")
		item.btnPlay = gohelper.findChildButtonWithAudio(go, "go_unpassgame/btn_challenge")
		item.btnDetail = gohelper.findChildButtonWithAudio(go, "go_unpassgame/btn_detail")
		item.btnGoto = gohelper.findChildButtonWithAudio(go, "go_unpassgame/btn_goto")
		item.btnFinishInfo = gohelper.findChildButtonWithAudio(go, "go_passgame/btn_news")
		item.goFinish = gohelper.findChild(go, "go_unpassgame/go_finish")
		item.goOrderRunning = gohelper.findChild(go, "go_unpassgame")
		item.goOrderFinish = gohelper.findChild(go, "go_passgame")
		item.animOrderFinish = item.goOrderFinish:GetComponent(typeof(UnityEngine.Animator))
		item.txtBossDesc = gohelper.findChild(go, "go_unpassgame/txt_bossdesc")
		item.txtNewsInfo = gohelper.findChildText(go, "go_passgame/txt_newsinfo")

		local context = {
			self = self,
			index = index
		}

		item.btnPlay:AddClickListener(self.onClickPlayOrder, context)
		item.btnDetail:AddClickListener(self.onClickDetailOrder, context)
		item.btnGoto:AddClickListener(self.onClickGotoOrder, context)
		item.btnFinishInfo:AddClickListener(self.onClickFinishInfoOrder, context)
		recthelper.setAnchor(item.go.transform, self._posListX[index], self._posListY[index])

		self._orderItems[index] = item
	end

	return item
end

function ActivityWarmUpView.onClickTabItem(param)
	local index = param.index
	local curDay = ActivityWarmUpModel.instance:getCurrentDay()
	local isLock = curDay < index

	if ActivityWarmUpModel.instance:getSelectedDay() ~= index and not isLock then
		ActivityWarmUpController.instance:switchTab(index)
	end
end

function ActivityWarmUpView.onClickPlayOrder(param)
	local index = param.index
	local orders = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if index <= #orders then
		local orderMO = orders[index]

		ActivityWarmUpController.instance:focusOrderGame(orderMO.id)
		ActivityWarmUpGameController.instance:openGameView(orderMO.cfg.gameSetting)
	end
end

function ActivityWarmUpView.onClickDetailOrder(param)
	local index = param.index
	local orders = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if index <= #orders then
		local orderCo = orders[index].cfg

		ViewMgr.instance:openView(ViewName.ActivityWarmUpTips, {
			actId = orderCo.activityId,
			orderId = orderCo.id
		})
	end
end

function ActivityWarmUpView.onClickGotoOrder(param)
	local index = param.index
	local orders = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if index <= #orders then
		local orderCo = orders[index].cfg
		local rs, dungeonName = ActivityWarmUpController.instance:cantJumpDungeonGetName(orderCo.jumpId)

		if rs then
			GameFacade.showToast(ToastEnum.WarmUpGotoOrder, dungeonName)
		else
			JumpController.instance:jump(orderCo.jumpId)
		end
	end
end

function ActivityWarmUpView.onClickFinishInfoOrder(param)
	local index = param.index
	local orders = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if index <= #orders then
		local orderCo = orders[index].cfg

		ViewMgr.instance:openView(ViewName.ActivityWarmUpNews, {
			actId = orderCo.activityId,
			orderId = orderCo.id
		})
	end
end

function ActivityWarmUpView:onPlayOrderCancel()
	self._finishedActId, self._finishedOrderId = nil
end

function ActivityWarmUpView:onPlayOrderFinish(param)
	local actId, orderId = param.actId, param.orderId

	logNormal("onPlayOrderFinish actId = " .. tostring(actId) .. ", orderId = " .. tostring(orderId))

	self._finishedActId, self._finishedOrderId = actId, orderId
end

function ActivityWarmUpView:onCloseViewFinishCall(viewName)
	if viewName == ViewName.ActivityWarmUpGameView and self._finishedActId and self._finishedOrderId then
		for _, itemObj in pairs(self._orderItems) do
			if itemObj.orderActId == self._finishedActId and itemObj.orderId == self._finishedOrderId then
				itemObj.animOrderFinish:Play(UIAnimationName.Open, 0, 0)
			elseif itemObj.animOrderFinish.isActiveAndEnabled then
				itemObj.animOrderFinish:Play(UIAnimationName.Idle)
			end
		end
	end
end

function ActivityWarmUpView:_btntaskOnClick()
	local actId = ActivityWarmUpModel.instance:getActId()

	ViewMgr.instance:openView(ViewName.ActivityWarmUpTask, {
		actId = actId,
		index = ActivityWarmUpModel.instance:getSelectedDay()
	})
end

function ActivityWarmUpView:_btnstartOnClick()
	gohelper.setActive(self._gowelcome, false)
	self:onWelcomeUIClose()
end

return ActivityWarmUpView
