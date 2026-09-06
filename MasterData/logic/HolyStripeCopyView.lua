-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/view/HolyStripeCopyView.lua

module("logic.extensions.holystripecopy.view.HolyStripeCopyView", package.seeall)

local HolyStripeCopyView = class("HolyStripeCopyView", ViewComponent)

function HolyStripeCopyView:buildUI()
	HolyStripeCopyView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtGameTime = self:getTxt("gameTime/txt")
	self._markGameTime = self:getGo("gameTime/markDouble")
	self._btnTip = self:getGo("btnTip")
	self._btnToggle = self:getGo("toggle/Background")
	self._imgCheckmark = self:getGo("toggle/Background/Checkmark")
end

function HolyStripeCopyView:bindEvents()
	HolyStripeCopyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnToggle, self._onClickBtnToggle, self)
end

function HolyStripeCopyView:unbindEvents()
	HolyStripeCopyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function HolyStripeCopyView:onEnter()
	HolyStripeCopyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandleUpdatePlayerSettingsRes, self._onPlayerSettingOpenRes, self)
	HolyStripeCopyController.instance:getInfo()
	HolyStripeExploreController.instance:getInfo()

	self._cfgs = HolyStripeCopyConfig.instance:getTabCfgs()
	self._trigExEventGame = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.LING_WEN_STOP_TRIGGER)

	self:_updataList()
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor)
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeCopyInfoUpdate, self._onRefreshByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeExploreInfoUpdate, self._updataList, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onDailyRefresh, self)
	GameUtil.SetActive(self._imgCheckmark, self._trigExEventGame)
end

function HolyStripeCopyView:onExit()
	HolyStripeCopyView.super.onExit(self)
	self._tableView:dispose()
	removetimer(self._onCountDown, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeCopyInfoUpdate, self._onRefreshByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeExploreInfoUpdate, self._updataList, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._onDailyRefresh, self)
end

function HolyStripeCopyView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if data.redPoint then
		local arr = string.split(data.redPoint .. "", "#")

		if #arr > 0 then
			RedPointController.instance:regRedPoint(cell.redPoint, unpack(arr))
		end
	end

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickTab, self, data))

	cell.txtName.text = data.name
	cell.txtLock.text = data.openDesc

	local isOpen = GameUtil.checkTimeStr(data.openTime)

	goutil.setActive(cell.maskLock, not isOpen)

	if not string.nilorempty(data.bgPath) then
		local path = GameUrl.getCopyChapterBgUrl(data.bgPath)

		uGuiUtil.setSpriteToImage(cell.imgBg, uGuiUtil.SpriteType.BigBg, path)
	end

	MaterialMgr.setCellListByCfg(data.showPrize, cell.showPrize)

	if data.topTip then
		goutil.setActive(cell.countdown, true)

		cell.txtcountdown.text = data.topTip
	end

	if data.timeEnd then
		self._countDownGoList[cell.txtcountdown] = data.timeEnd

		goutil.setActive(cell.countdown, true)

		cell.txtcountdown.text = langPara("倒计时：%s", GameUtil.FormatTimeWords(data.timeEnd - ServerTime.now()))
	end
end

function HolyStripeCopyView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.imgBg = goutil.findChild(cell.go, "imgBg")

	uGuiUtil.clearImage(cell.imgBg)

	cell.showPrize = goutil.findChild(cell.go, "showPrize")

	MaterialMgr.resetAll(cell.showPrize)

	cell.maskLock = goutil.findChild(cell.go, "maskLock")

	goutil.setActive(cell.maskLock, true)

	cell.txtLock = goutil.findChildTextComponent(cell.maskLock, "txt")
	cell.txtLock.text = ""
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.countdown = goutil.findChild(cell.go, "countdown")

	goutil.setActive(cell.countdown, false)

	cell.redPoint = goutil.findChild(cell.go, "redPoint")

	goutil.setActive(cell.redPoint, false)
	RedPointController.instance:unregRedPoint(cell.redPoint)

	cell.txtcountdown = goutil.findChildTextComponent(cell.countdown, "txt")

	GameUtil.rmClickHandler(cell.go)

	self._countDownGoList[cell.txtcountdown] = nil

	return cell
end

function HolyStripeCopyView:_onClickTab(data)
	local isOpen = GameUtil.checkTimeStr(data.openTime)

	if isOpen then
		if data.isExplore then
			UIStateManager.instance:push(ViewName.HolyStripeExploreView)

			return
		end

		if data.isAssistBox then
			UIStateManager.instance:push(ViewName.AssistanceboxView)

			return
		end

		UIStateManager.instance:push(ViewName.HolyStripeCopyChallengeView, data.tabId)
	else
		FloatWordMgr.instance:show(data.openDesc)
	end
end

function HolyStripeCopyView:_onClickTip()
	local ruleKey = HolyStripeCopyConfig.instance:getCommonValue("RULE")

	UIStateManager.instance:open(ViewName.RulesView, ruleKey)
end

function HolyStripeCopyView:_getCurDataList()
	local dataList = {}
	local backList = {}
	local tampData = {}

	tampData.name = lang("助力宝箱")
	tampData.openTime = "全天"
	tampData.bgPath = AssistanceBoxConfig.instance:getParamValue("ENTER_PATH")
	tampData.showPrize = AssistanceBoxConfig.instance:getParamValue("ENTER_PRIZE")
	tampData.isAssistBox = true
	tampData.redPoint = RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX_PRIZE .. "#" .. RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX_HELP

	if RedPointModel.instance:isActive(RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX) and not RedPointModel.instance:isActive(RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX_PRIZE) then
		tampData.timeEnd = AssistanceBoxModel.instance:getCurBoxEndTime()
	elseif RedPointModel.instance:isActive(RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX_PRIZE) then
		tampData.topTip = nil
	else
		tampData.topTip = lang("未触发")
	end

	if RedPointModel.instance:isActive(RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX) or RedPointModel.instance:isActive(RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX_PRIZE) then
		table.insert(dataList, tampData)
	else
		table.insert(backList, tampData)
	end

	if HolyStripeExploreModel.instance:getCurInfo() then
		local data = {}

		data.name = lang("灵纹探险")
		data.openTime = "全天"
		data.bgPath = HolyStripeExploreConfig.instance:getCommonValue("ENTER_PATH")
		data.showPrize = HolyStripeExploreConfig.instance:getCommonValue("ENTER_PRIZE")
		data.redPoint = RedPointModel.ID_HOLY_STRIPE_EXPLORE_EXIT_TIME
		data.isExplore = true
		data.timeEnd = HolyStripeExploreModel.instance:getCurEndTime()

		table.insert(dataList, data)
	end

	for k, v in ipairs(self._cfgs) do
		table.insert(dataList, v)
	end

	for k, v in ipairs(backList) do
		table.insert(dataList, v)
	end

	return dataList
end

function HolyStripeCopyView:_onRefreshByInfo()
	self:_updataList()

	local leaveTime = HolyStripeCopyModel.instance:getLeftSoloTime()

	self._txtGameTime.text = leaveTime > 0 and langPara("<color=#20B376FF>%s</color>次", leaveTime) or langPara("<color=#ff0000ff>%s</color>次", leaveTime)

	goutil.setActive(self._markGameTime, HolyStripeCopyModel.instance:isDoubleTime())
end

function HolyStripeCopyView:_updataList()
	local dataList = self:_getCurDataList()

	self:_setCountDown(dataList)
	self._tableView:reloadData(dataList)
end

function HolyStripeCopyView:_onDailyRefresh()
	HolyStripeCopyController.instance:getInfo()
end

function HolyStripeCopyView:_setCountDown(dataList)
	removetimer(self._onCountDown, self)

	self._countDownDataList = {}
	self._countDownGoList = {}

	local timeNow = ServerTime.now()

	for k, v in ipairs(dataList) do
		if v.timeEnd and timeNow < v.timeEnd then
			table.insert(self._countDownDataList, v.timeEnd)
		end
	end

	if #self._countDownDataList > 0 then
		settimer(1, self._onCountDown, self)
	end
end

function HolyStripeCopyView:_onCountDown()
	local timeNow = ServerTime.now()

	for k, v in ipairs(self._countDownDataList) do
		if v < timeNow then
			self:_updataList()

			return
		end
	end

	for txt, timeEnd in pairs(self._countDownGoList) do
		txt.text = langPara("倒计时：%s", GameUtil.FormatTimeWords(timeEnd - timeNow))
	end
end

function HolyStripeCopyView:_onPlayerSettingOpenRes()
	self._trigExEventGame = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.LING_WEN_STOP_TRIGGER)

	GameUtil.SetActive(self._imgCheckmark, self._trigExEventGame)
end

function HolyStripeCopyView:_onClickBtnToggle()
	self._trigExEventGame = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.LING_WEN_STOP_TRIGGER)

	local settingSwitch = RoleModel.instance:getSettingSwitch()
	local setNum = self._trigExEventGame and 0 or 1
	local curSettingSwitch = MmUtil.setBitSetAndGetReturnNum(settingSwitch, GameEnum.PlayerSettingSwitchBitPos.LING_WEN_STOP_TRIGGER, setNum)

	RoleModel.instance:setSettingSwitch(curSettingSwitch)

	local playerSettings = RoleModel.instance:getSettings()

	RoleController.instance:sendUpdatePlayerSettingsReq(playerSettings)
	self:_onDailyRefresh()
end

return HolyStripeCopyView
