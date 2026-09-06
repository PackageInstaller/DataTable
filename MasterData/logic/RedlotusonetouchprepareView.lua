-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/view/RedlotusonetouchprepareView.lua

module("logic.extensions.redlotusdinnerparty.view.RedlotusonetouchprepareView", package.seeall)

local RedlotusonetouchprepareView = class("RedlotusonetouchprepareView", ViewComponent)

function RedlotusonetouchprepareView:ctor()
	RedlotusonetouchprepareView.super.ctor(self)
end

function RedlotusonetouchprepareView:unbindEvents()
	RedlotusonetouchprepareView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function RedlotusonetouchprepareView:bindEvents()
	RedlotusonetouchprepareView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function RedlotusonetouchprepareView:buildUI()
	RedlotusonetouchprepareView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._timeScrollerview = self:getGo("schedule/timeScrollerview")
	self._timecell = self:getGo("schedule/timecell")
	self._timeScrollerList = ScrollerList.create(self._timeScrollerview, self._timecell, GameUtil.handler(self._updateTimeCell, self), GameUtil.handler(self.clearTimeCell, self))
	self._menuview = self:getGo("menu/menuview")
	self._menuCell = self:getGo("menu/menuCell")
	self._menuScrollerList = ScrollerList.create(self._menuview, self._menuCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._txtRemain = self:getTxt("remain/txtNum")
	self._foodList = {}

	for i = 1, 3 do
		local rewardCell = self:getGo("rewardCol/rewardCell_" .. i)

		table.insert(self._foodList, rewardCell)
	end
end

function RedlotusonetouchprepareView:onExit()
	RedlotusonetouchprepareView.super.onExit(self)
	self._timeScrollerList:dispose()
	self._menuScrollerList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_RedLotusGalaGetInfoRes, self._onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_RedLotusGalaStartGameRes, self._onGoStartGame, self)
end

function RedlotusonetouchprepareView:onEnter()
	RedlotusonetouchprepareView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_RedLotusGalaStartGameRes, self._onGoStartGame, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_RedLotusGalaGetInfoRes, self._onRefreshUI, self)
	self:_getCurPerCfg()

	if self._curPerCfg then
		local activityId = RedLotusDinnerPartyModel.instance:getActivityId()

		RedLotusDinnerPartyController.instance:sendGetInfo(activityId, self._curPerCfg.gameId)
	end

	self:_onRefreshUI()
end

function RedlotusonetouchprepareView:_getCurPerCfg()
	local activityId = RedLotusDinnerPartyModel.instance:getActivityId()
	local actCfg = RedLotusDinnerPartyConfig.instance:getActivityCfgById(activityId) or {}
	local performPlanId = actCfg.performPlanId
	local performCfgList = RedLotusDinnerPartyConfig.instance:getPerformPlanCfgList(performPlanId) or {}

	self._timeScrollerList:reloadData(performCfgList)

	self._curPerCfg = nil

	local idx = 0

	for i, v in ipairs(performCfgList) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			idx = i - 1
			self._curPerCfg = v
		end
	end

	self._timeScrollerList:MoveCellToCenter(idx)
end

function RedlotusonetouchprepareView:_onRefreshUI()
	self:_getCurPerCfg()

	self._txtRemain.text = "0"

	if self._curPerCfg then
		local activityId = RedLotusDinnerPartyModel.instance:getActivityId()
		local info = RedLotusDinnerPartyModel.instance:getGalaInfo(activityId, self._curPerCfg.gameId) or {}
		local useGameTimes = checknumber(info.useGameTimes)

		self._txtRemain.text = "" .. math.max(0, self._curPerCfg.freeNum - useGameTimes)

		local stagePlanId = self._curPerCfg.stagePlanId
		local stageList = RedLotusDinnerPartyConfig.instance:getStageCfgList(stagePlanId)
		local list = {}

		for i, v in ipairs(stageList) do
			if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
				table.insert(list, v)
			end
		end

		self._menuScrollerList:reloadData(list)
	end

	for i, go in ipairs(self._foodList) do
		local itemCell = goutil.findChild(go, "itemCell")
		local str = RedLotusDinnerPartyConfig.instance:getCommonValue("PRIZE" .. i)

		MaterialMgr.setCellByCfg(str, itemCell)
	end
end

function RedlotusonetouchprepareView:_onGoStartGame(clientKey, serverKey, actId, gameId, stageId)
	if clientKey == self._clientKey then
		UIStateManager.instance:push(ViewName.RedlotusonetouchdrawView, actId, gameId, self._clientKey, serverKey, stageId)
		self:close()
	end
end

function RedlotusonetouchprepareView:_updateTimeCell(view, cell, data, tag)
	local txtTime = goutil.findChildTextComponent(cell, "time/txtTime")
	local txtTitle = goutil.findChildTextComponent(cell, "title/txtTitle")
	local startTimeD = GameUtil.string2date(data.startTime)
	local endTimeD = GameUtil.string2date(data.endTime)

	txtTime.text = langPara("%s.%s-%s.%s", startTimeD.month, startTimeD.day, endTimeD.month, endTimeD.day)
	txtTitle.text = data.name

	local idx = 0

	if GameUtil.checkIsInTimePeriod(data.startTime, data.endTime) then
		idx = 1
	end

	GameUtil.setUIImageSpriteIdx(goutil.findChild(cell, "time"), idx)
	GameUtil.setUIImageSpriteIdx(goutil.findChild(cell, "title"), idx)
	GameUtil.setUITextColorIdx(goutil.findChild(cell, "time/txtTime"), idx)
	GameUtil.setUITextColorIdx(goutil.findChild(cell, "title/txtTitle"), idx)
end

function RedlotusonetouchprepareView:clearTimeCell(cell)
	return
end

function RedlotusonetouchprepareView:_updateCell(view, cell, data, tag)
	local pass = goutil.findChild(cell, "pass")
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.pic))
	GameUtil.SetActive(pass, false)
	GameUtil.rmClickHandler(cell)

	if checknumber(data.type) > 0 then
		GameUtil.setUIImageSpriteIdx(cell, checknumber(data.type) - 1)
	end

	if self._curPerCfg then
		local activityId = RedLotusDinnerPartyModel.instance:getActivityId()
		local info = RedLotusDinnerPartyModel.instance:getGalaInfo(activityId, self._curPerCfg.gameId) or {}

		if not info.stageIds then
			local stageIds = {}

			if table.indexof(stageIds, data.stageId) ~= false then
				GameUtil.SetActive(pass, true)
			end

			GameUtil.addClickHandler(cell, function()
				if table.indexof(stageIds, data.stageId) ~= false then
					TipsFacade.instance:openCommonTips("已享用此菜品，不要太贪心哦")
				else
					self._clientKey = RedLotusDinnerPartyController.instance:sendStartGame(activityId, self._curPerCfg.gameId, data.stageId)
				end
			end)
		end
	end
end

function RedlotusonetouchprepareView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon.gameObject)
	GameUtil.rmClickHandler(cell)
end

function RedlotusonetouchprepareView:_onClickTip()
	TipsFacade.instance:openRulesView("RedlotusonetouchprepareView_rule")
end

return RedlotusonetouchprepareView
