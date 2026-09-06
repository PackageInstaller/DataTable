-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnView.lua

module("logic.extensions.playerreturn.view.PlayerReturnView", package.seeall)

local PlayerReturnView = class("PlayerReturnView", ViewComponent)

function PlayerReturnView:ctor()
	PlayerReturnView.super.ctor(self)

	self._tabItemList = nil
end

function PlayerReturnView:bindEvents()
	PlayerReturnView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		PlayerReturnModel.instance._mainTabIndex = 1

		UIStateManager.instance:popByName(self._viewPresentor.viewName)
	end, self)
	self._btnShare:AddClickListener(self._onClickShareURL, self)
end

function PlayerReturnView:unbindEvents()
	PlayerReturnView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for _, item in pairs(self._entranceItemList or {}) do
		if item and item.itemBtn then
			item.itemBtn:RemoveClickListener()
		end
	end

	self._btnShare:RemoveClickListener()
end

function PlayerReturnView:onExit()
	PlayerReturnView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.PR_UpdataPlayerReturnRed, self._updataTabItemRedPoint, self)

	for _, item in pairs(self._tabItemList or {}) do
		if item and item.itemGo then
			GameUtil.SetActive(item.itemGo, false)
		end
	end
end

function PlayerReturnView:destroyUI()
	PlayerReturnView.super.destroyUI(self)

	for _, item in pairs(self._tabItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._tabItemList = nil
end

function PlayerReturnView:buildUI()
	PlayerReturnView.super.buildUI(self)

	self._subParentGo = self:getGo("subParentGo")
	self._goldBarCon = self:getGo("goldBarCon")
	self._closeBtn = self:getBtn("closeBtn")
	self._viewNameTxt = goutil.findChildTextComponent(self.mainGO, "viewNameTxt")
	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "timerTxt")
	self._leftBtnTran = self:getGo("leftBtnTran").transform
	self._btnItem = self:getGo("btnItem")

	self._btnItem:SetActive(false)

	self._timerTxt.text = ""
	self._btnShare = self:getBtn("btnShare")
end

function PlayerReturnView:onEnter()
	PlayerReturnView.super.onEnter(self)

	self._tabIndex = self:getFirstParam()

	if checknumber(self._tabIndex) <= 0 then
		self._tabIndex = PlayerReturnModel.instance._mainTabIndex
	end

	self._actiInfo = PlayerReturnModel.instance:getOpenActivityInfo()
	self._tabItemList = self._tabItemList or {}

	self:_showActivityTimer()
	self:_createAllTabs()
	GlobalDispatcher:addListener(GlobalNotify.PR_UpdataPlayerReturnRed, self._updataTabItemRedPoint, self)
end

function PlayerReturnView:_onClickTabItemBtn(cfg, isForce)
	if cfg == nil then
		return
	end

	if not isForce and cfg.tabId == self._tabIndex then
		return
	end

	self._tabIndex = cfg.tabId
	self._viewNameTxt.text = cfg.tabName
	PlayerReturnModel.instance._mainTabIndex = self._tabIndex

	self:showTabAt(self._subParentGo, cfg.tabView, cfg)
	GameUtil.SetActive(self._timerTxt, cfg.tabView ~= ViewName.ReturnTask)

	if self._tabItemList == nil or #self._tabItemList == 0 then
		return
	end

	for i = 1, #self._tabItemList do
		local item = self._tabItemList[i]

		if item and item.itemGo then
			local isRed = PlayerReturnModel.instance:getTabViewRedpoint(item.tabId)

			item.pointGo:SetActive(isRed)
			item.itemGro:SetState(item.tabId == self._tabIndex and 1 or 0)
		end
	end

	if string.nilorempty(cfg.cost) then
		ViewMgr.instance:close(ViewName.MainTopGoldView)

		return
	end

	local list = string.split(cfg.cost, "#")
	local btnList = {}

	for i = 1, #list do
		table.insert(btnList, {
			showAdd = false,
			id = list[i]
		})
	end

	if #btnList == 0 then
		ViewMgr.instance:close(ViewName.MainTopGoldView)

		return
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function PlayerReturnView:_updataTabItemRedPoint(tabId)
	if self._tabItemList == nil or self._tabItemList[tabId] == nil or self._tabItemList[tabId].pointGo == nil then
		return
	end

	local isRed = PlayerReturnModel.instance:getTabViewRedpoint(tabId)

	self._tabItemList[tabId].pointGo:SetActive(isRed)
end

function PlayerReturnView:_createAllTabs()
	if self._actiInfo == nil then
		return
	end

	for i, item in ipairs(self._tabItemList) do
		GameUtil.SetActive(item.itemGo, false)
	end

	local allList = PlayerReturnConfig.instance:getReturnMainViewCfgs(self._actiInfo.actId)

	if allList == nil or #allList == 0 then
		return
	end

	local choCfg = allList[1]
	local index = 1

	for i = 1, #allList do
		local canAdd = true

		if allList[i].tabView == ViewName.ReturnTask then
			local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(RecallTaskModel.instance.openActivityType, RecallTaskModel.instance.openActivityId)

			if checknumber(etime) <= ServerTime.now() then
				canAdd = false
			end
		end

		if canAdd then
			local item = self._tabItemList[index]

			if not item or item.itemGo == nil then
				local go = UnityEngine.GameObject.Instantiate(self._btnItem, self._leftBtnTran)

				GameUtil.SetActive(go, true)

				item = {
					tabId = 0,
					itemGo = go,
					itemGro = go:GetComponent("UIChangeGroup"),
					pointGo = goutil.findChild(go, "pointGo"),
					nameTxt = goutil.findChildTextComponent(go, "nameTxt"),
					tagGo = goutil.findChild(go, "tagGo"),
					tagTxt = goutil.findChildTextComponent(go, "tagGo/tagTxt")
				}
				self._tabItemList[index] = item
			end

			item.tabId = allList[i].tabId
			index = index + 1

			item.itemGo:SetActive(true)
			GameUtil.asBtn(item.itemGo):RemoveClickListener()

			item.nameTxt.text = allList[i].tabName

			item.pointGo:SetActive(false)

			if string.nilorempty(allList[i].tagShow) then
				item.tagTxt.text = ""

				GameUtil.SetActive(item.tagGo, false)
			else
				GameUtil.SetActive(item.tagGo, true)

				item.tagTxt.text = allList[i].tagShow
			end

			GameUtil.asBtn(item.itemGo):AddClickListener(function()
				self:_onClickTabItemBtn(allList[i])
			end)

			if allList[i] and allList[i].tabId == self._tabIndex then
				choCfg = allList[i]
			end
		end
	end

	if choCfg then
		self:_onClickTabItemBtn(choCfg, true)
	end
end

function PlayerReturnView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	if self._actiInfo == nil or self._actiInfo.endTime == nil then
		self._timerTxt.text = "活动结束"

		return
	end

	if self._actiInfo.endTime <= ServerTime.now() then
		self._timerTxt.text = "活动结束"
	else
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function PlayerReturnView:_calculationSurplusTime()
	local supTime = self._actiInfo.endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = "活动结束"

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function PlayerReturnView:_onClickShareURL()
	local bgImageName = "share_01"

	UIStateManager.instance:push(ViewName.ShareQRCode, bgImageName, url)
end

return PlayerReturnView
