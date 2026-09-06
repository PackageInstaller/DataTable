-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestWinnerView.lua

module("logic.extensions.goddesscontest.view.GoddessContestWinnerView", package.seeall)

local GoddessContestWinnerView = class("GoddessContestWinnerView", ViewComponent)

function GoddessContestWinnerView:buildUI()
	GoddessContestWinnerView.super.buildUI(self)

	self._container = self:getGo("container")
	self._bg = self:getGo("bg")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnShop = self:getBtn("btnShop")
	self._goTableView = self:getGo("tableView")
	self._goCell = self:getGo("tableCell")
	self._tableview = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtActivityTime = self:getTxt("time/txt")
end

function GoddessContestWinnerView:bindEvents()
	GoddessContestWinnerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function GoddessContestWinnerView:unbindEvents()
	GoddessContestWinnerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTip)
end

function GoddessContestWinnerView:onEnter()
	GoddessContestWinnerView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	if params[1] then
		self._curActId = checkint(params[1]) or GoddessContestModel.instance:getCurActId()
	end

	self._tabCfgs = GoddessContestConfig.instance:getWinnerTabCfgsByActId(self._curActId)
	self._timeCfgs = GoddessContestConfig.instance:getTimeSldCfgsByActId(self._curActId)
	self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Goddess_Contest, self._curActId)

	local startTime, endTime = self._actTimeCfg.startTime, self._actTimeCfg.endTime
	local startDate, endDate = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

	self._txtActivityTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

	self._tableview:reloadData(self._tabCfgs)

	local openId = checkint(GoddessContestModel.instance:getLastOpenWinnerTabId() or params[2])

	openId = self._tabCfgs[openId] and openId or 1
	self._curIndex = nil

	self:_onClickTab(openId)
	GoddessContestController.instance:getInfo(self._curActId)
end

function GoddessContestWinnerView:onExit()
	GoddessContestWinnerView.super.onExit(self)
	self._tableview:dispose()
	GoddessContestModel.instance:setLastOpenWinnerTabId(self._curIndex)
end

function GoddessContestWinnerView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtName.text = data.name

	GameUtil.SetActive(cell.select, self._curIndex == data.id)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickTab, self, data.id))

	if string.nilorempty(data.tag) then
		goutil.setActive(cell.tag, false)
	else
		goutil.setActive(cell.tag, true)

		cell.txtTag.text = data.showTab
	end

	if not string.nilorempty(data.redPoint) then
		RedPointController.instance:regRedPoint(cell.redPoint, unpack(string.split(data.redPointId, "#")))
	end
end

function GoddessContestWinnerView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtName = goutil.findChildTextComponent(cell.go, "name/txtName")
	cell.select = goutil.findChild(cell.go, "select")
	cell.tag = goutil.findChild(cell.go, "tag")
	cell.redPoint = goutil.findChild(cell.go, "redPoint")
	cell.txtTag = goutil.findChildTextComponent(cell.tag, "txt")

	goutil.setActive(cell.redPoint, false)
	RedPointController.instance:unregRedPoint(cell.redPoint)
	GameUtil.rmClickHandler(cell.go)

	return cell
end

function GoddessContestWinnerView:_onClickTab(openId)
	if self._curIndex ~= openId then
		self._curIndex = openId

		self._tableview:refresh()

		local openCfg = self._tabCfgs[self._curIndex]

		goutil.setActive(self._bg, not openCfg.isHideBG)
		self:showTabAt(self._container)
		self:showTabAt(self._container, openCfg.viewname, openCfg)
	end
end

function GoddessContestWinnerView:_onClickClose()
	self:close()
	GoddessContestModel.instance:setLastOpenWinnerTabId()
end

function GoddessContestWinnerView:_onClickShop()
	local gotoStr = GoddessContestConfig.instance:getCommondValueByKey("SHOP_GO_TO")

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function GoddessContestWinnerView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, GoddessContestConfig.instance:getCommondValueByKey("MAIN_RULE"))
end

return GoddessContestWinnerView
