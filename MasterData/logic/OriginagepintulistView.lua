-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginagepintulistView.lua

module("logic.extensions.originage.view.OriginagepintulistView", package.seeall)

local OriginagepintulistView = class("OriginagepintulistView", ViewComponent)

function OriginagepintulistView:ctor()
	OriginagepintulistView.super.ctor(self)
end

function OriginagepintulistView:unbindEvents()
	OriginagepintulistView.super.unbindEvents(self)
end

function OriginagepintulistView:bindEvents()
	OriginagepintulistView.super.bindEvents(self)
end

function OriginagepintulistView:buildUI()
	OriginagepintulistView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginagepintulistView:onExit()
	OriginagepintulistView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginagepintulistView:onEnter()
	OriginagepintulistView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = 171001
	end

	self._activityConf = HuarongRoadConfig.instance:getActivityCfg(self._activityId)

	self.addGEvent(self, HuarongRoadController.PM_HuarongRoadGetInfoRes, self._refreshView, self)
	self.addGEvent(self, HuarongRoadController.PM_HuarongRoadPassRes, self._refreshView, self)
	self.addGEvent(self, HuarongRoadController.PM_HuarongRoadBuyQuickPassRes, self._refreshView, self)
	HuarongRoadAgent.instance:sendPM_HuarongRoadGetInfoReq(self._activityId)
	self:_refreshView()
end

function OriginagepintulistView:_refreshView()
	self._passStageIds = HuarongRoadModel.instance:getPassStageIds(self._activityId)

	local maxLevel = HuarongRoadModel.instance:getMaxLevel(self._activityId)
	local data = HuarongRoadConfig.instance:getStage(self._activityId)

	self._scrollList:reloadData(data)
	self._scrollList:MoveCellToCenter(math.min(maxLevel + 1, #data))
end

function OriginagepintulistView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btnStart = goutil.findChildButtonComponent(go, "btns/btnBegin")
	local btnStartGo = goutil.findChild(go, "btns/btnBegin")
	local btnQuicklyComplete = goutil.findChildButtonComponent(go, "btns/btnCost")
	local btnQuicklyCompleteGo = goutil.findChild(go, "btns/btnCost")
	local imgCon = goutil.findChild(go, "imgCon")
	local iconLevel = goutil.findChildComponent(go, "iconLevel", "UIImageSpriteChange")
	local txtRule = goutil.findChildTextComponent(go, "txtRule")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtCost = goutil.findChildTextComponent(go, "btns/btnCost/cost/textNum")
	local iconCost = goutil.findChild(go, "btns/btnCost/cost/icon")
	local prizeCon1 = goutil.findChild(go, "prizeItem1")
	local prizeCon1Rev = goutil.findChild(go, "receive1")
	local prizeCon2 = goutil.findChild(go, "prizeItem2")
	local prizeCon2Rev = goutil.findChild(go, "receive2")
	local prizeCon3 = goutil.findChild(go, "prizeItem3")
	local prizeCon3Rev = goutil.findChild(go, "receive3")
	local passGo = goutil.findChild(go, "pass")
	local guideFinger = goutil.findChild(go, "btns/btnBegin/guideFinger")
	local btns = goutil.findChild(go, "btns")
	local openTimeGo = goutil.findChild(go, "openTime")
	local txtOpenTime = goutil.findChildTextComponent(go, "openTime/txt")
	local isOpen = true

	if not string.nilorempty(data.startTime) then
		isOpen = GameUtil.getTimePeriod(data.startTime, nil) == GameUtil.inTimePeriod

		local date = GameUtil.string2date(data.startTime)

		txtOpenTime.text = string.format("%d.%02d %d:%02d后开启", date.month, date.day, date.hour, date.min)
	end

	txtName.text = data.name

	uGuiUtil.clearImage(imgCon)

	if not string.nilorempty(data.picName) then
		local picPath = GameUrl.getBigbgFolderUrl("saintknight/xiaonuo", data.picName)

		uGuiUtil.setSpriteToImage(imgCon, uGuiUtil.SpriteType.BigBg, picPath)
	end

	txtRule.text = langPara("%dx%d", data.rule[1], data.rule[2])

	local levelDiff = 0

	if data.diff then
		if data.diff == "S" then
			levelDiff = 0
		elseif data.diff == "A" then
			levelDiff = 1
		elseif data.diff == "B" then
			levelDiff = 2
		elseif data.diff == "C" then
			levelDiff = 3
		elseif data.diff == "D" then
			levelDiff = 4
		end
	end

	iconLevel:SetState(levelDiff)

	local prizeGoList = {
		prizeCon1,
		prizeCon2,
		prizeCon3
	}

	for idx, prizeGo in ipairs(prizeGoList) do
		local prizeStr = ((not string.nilorempty(data.prize) or nil) and string.split(data.prize, "#"))[idx]

		if not string.nilorempty(prizeStr) then
			MaterialMgr.setCellByCfg(prizeStr, prizeGo)
			GameUtil.SetActive(prizeGo, true)
		else
			MaterialMgr.resetAll(prizeGo)
			GameUtil.SetActive(prizeGo, false)
		end
	end

	local costType, costId, costNum
	local var_8_0, var_8_1, var_8_2 = MaterialMgr.getMatParams(data.passCost)

	costId = var_8_1
	costType = var_8_0
	txtCost.text = langPara("%d", checknumber(var_8_2))

	MaterialMgr.setIcon(iconCost, var_8_0, var_8_1)
	GameUtil.addClickHandler(btnStart, function()
		if not isOpen then
			FloatWordMgr.instance:show("未开启")

			return
		end

		self:_onClickStart(data.stageId)
	end)
	GameUtil.addClickHandler(btnQuicklyComplete, function()
		if not isOpen then
			FloatWordMgr.instance:show("未开启")

			return
		end

		self:_onClickQuicklyComplete(data.stageId)
	end)

	local pass = false
	local maxLevel = HuarongRoadModel.instance:getMaxLevel(self._activityId)
	local needHide = maxLevel < 1 and data.stageId ~= 1
	local needHideQuickLy = data.stageId == 1

	for i, v in ipairs(self._passStageIds) do
		if data.stageId == v then
			pass = true
		end
	end

	if self._activityConf.isNeedPass then
		local isCanQuickly = not string.nilorempty(data.passCost)

		goutil.setActive(openTimeGo, not isOpen)
		goutil.setActive(btns, isOpen)
		goutil.setActive(guideFinger, needHideQuickLy)
		goutil.setActive(btnStartGo, not needHide and not pass)
		goutil.setActive(btnQuicklyCompleteGo, isCanQuickly and not needHide and not needHideQuickLy and not pass)
		goutil.setActive(passGo, not needHide and pass)
		goutil.setActive(prizeCon1Rev, pass and GameUtil.GetActive(prizeCon1))
		goutil.setActive(prizeCon2Rev, pass and GameUtil.GetActive(prizeCon2))
		goutil.setActive(prizeCon3Rev, pass and GameUtil.GetActive(prizeCon3))
	end
end

function OriginagepintulistView:_clearCell(cell)
	local go = cell.gameObject
	local btnStart = goutil.findChildButtonComponent(go, "btnBegin")
	local imgCon = goutil.findChild(go, "imgCon")
	local prizeCon1 = goutil.findChild(go, "prizeItem1")
	local prizeCon2 = goutil.findChild(go, "prizeItem2")
	local iconCost = goutil.findChild(go, "btnCost/cost/icon")

	uGuiUtil.clearImage(imgCon)
	MaterialMgr.resetAll(prizeCon1)
	MaterialMgr.resetAll(prizeCon2)
	MaterialMgr.clearIcon(iconCost)
	GameUtil.rmClickHandler(btnStart)
end

function OriginagepintulistView:_onClickStart(stageId)
	local totalTimes = HuarongRoadConfig.instance:challengeDailyTimes(self._activityId)
	local playTimes = HuarongRoadModel.instance:getPlayCount(self._activityId)
	local enterTimes = totalTimes - playTimes

	if enterTimes > 0 then
		UIStateManager.instance:push(ViewName.OriginagepintugameView, self._activityId, stageId)
	else
		FloatWordMgr.instance:show("今日通关次数已达上限")
	end
end

function OriginagepintulistView:_onClickQuicklyComplete(stageId)
	local totalTimes = HuarongRoadConfig.instance:challengeDailyTimes(self._activityId)
	local playTimes = HuarongRoadModel.instance:getPlayCount(self._activityId)
	local enterTimes = totalTimes - playTimes
	local cfg = HuarongRoadConfig.instance:getGameStageCfg(self._activityId, stageId)

	if enterTimes > 0 then
		local type, id, num

		type, id, num = MaterialMgr.getMatParams(cfg.passCost)

		local matName = MaterialMgr.getMaterialsName(type, id)

		TipsFacade.instance:openPopupCostMatViewNew(type, id, num, langPara("确定要花费%d%s，直接一键通过%s?", num, matName, cfg.name), function()
			self:_buyCompleteGame(stageId)
		end)
	else
		FloatWordMgr.instance:show("今日通关次数已达上限")
	end
end

function OriginagepintulistView:_buyCompleteGame(stageId)
	HuarongRoadAgent.instance:sendPM_HuarongRoadBuyQuickPassReq(self._activityId, stageId)

	local completeLevel = HuarongRoadModel.instance:getCompletLevelCount(self._activityId) + 1
	local cfg = HuarongRoadConfig.instance:getProgressCfg(self._activityId, completeLevel)
	local storyId

	if cfg then
		storyId = cfg.operaId
	end

	if storyId then
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
	end
end

return OriginagepintulistView
