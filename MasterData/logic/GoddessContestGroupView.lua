-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestGroupView.lua

module("logic.extensions.goddesscontest.view.GoddessContestGroupView", package.seeall)

local GoddessContestGroupView = class("GoddessContestGroupView", ViewComponent)

function GoddessContestGroupView:buildUI()
	GoddessContestGroupView.super.buildUI(self)

	self._container = self:getGo("container")
	self._goldBar = self:getGo("goldBar")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnShop = self:getBtn("btnShop")
	self._goTableView = self:getGo("tableView")
	self._goCell = self:getGo("tableCell")
	self._tableview = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._redpackTipsCon = self:getGo("redpackTips")
end

function GoddessContestGroupView:bindEvents()
	GoddessContestGroupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function GoddessContestGroupView:unbindEvents()
	GoddessContestGroupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTip)
end

function GoddessContestGroupView:onEnter()
	GoddessContestGroupView.super.onEnter(self)

	self._curIndex = nil
	self._curActId = GoddessContestModel.instance:getCurActId()
	self._actCfg = GoddessContestConfig.instance:getActCfgByActId(self._curActId)
	self._tabCfgs = GoddessContestConfig.instance:getGroupTabCfgsByActId(self._curActId)

	self._tableview:reloadData(self._tabCfgs)

	local openId = checkint(GoddessContestModel.instance:getLastOpenGroupTabId() or self:getFirstParam())

	openId = self._tabCfgs[openId] and openId or 1

	self:_onClickTab(openId)
	GoddessContestController.instance:getGroupInfo()

	local list = {
		{
			showAdd = true,
			id = self._actCfg.goddessVoteItemId
		},
		{
			showAdd = true,
			id = self._actCfg.directorVoteItemId
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, list)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestGetGroupInfo, self._onGetInfo, self)
	GroupRedpackController.instance:setCurrContainer(self._redpackTipsCon, self._viewPresentor.viewName)
end

function GoddessContestGroupView:onExit()
	GoddessContestGroupView.super.onExit(self)
	self._tableview:dispose()
	GoddessContestModel.instance:setLastOpenGroupTabId(self._curIndex)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestGetGroupInfo, self._onGetInfo, self)
end

function GoddessContestGroupView:_updateCell(view, goCell, data)
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

	if not string.nilorempty(data.redPointId) then
		RedPointController.instance:regRedPoint(cell.redPoint, unpack(string.split(data.redPointId, "#")))
	end
end

function GoddessContestGroupView:_clearCell(goCell)
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

function GoddessContestGroupView:_onClickTab(openId)
	if self._curIndex ~= openId then
		self._curIndex = openId

		self._tableview:refresh()

		local openCfg = self._tabCfgs[self._curIndex]

		self:showTabAt(self._container)
		self:showTabAt(self._container, openCfg.viewname, openCfg)
	end
end

function GoddessContestGroupView:_onClickClose()
	self:close()
	GoddessContestModel.instance:setLastOpenGroupTabId()
end

function GoddessContestGroupView:_onClickShop()
	local gotoStr = GoddessContestConfig.instance:getCommondValueByKey("SHOP_GO_TO")

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function GoddessContestGroupView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, GoddessContestConfig.instance:getCommondValueByKey("GROUP_RULE"))
end

function GoddessContestGroupView:_onGetInfo()
	if GoddessContestModel.instance:getCurLeaderInfo() and GoddessContestModel.instance:getUserIsFirstOpen(GoddessContestModel.LeaderResultTipKey) then
		UIStateManager.instance:push(ViewName.GoddessContestLeaderResultView)
	end
end

return GoddessContestGroupView
