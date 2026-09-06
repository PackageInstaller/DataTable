-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestMainView.lua

module("logic.extensions.goddesscontest.view.GoddessContestMainView", package.seeall)

local GoddessContestMainView = class("GoddessContestMainView", ViewComponent)

function GoddessContestMainView:buildUI()
	GoddessContestMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._groupCell = self:getGo("groupCom/cell")
	self._groupView = self:getGo("groupCom/view")

	goutil.setActive(self._groupCell, false)

	self._sldProgress = self:getSlider("progress/progressSlider")
	self._layoutCom = self:getGo("progress/progressSlider/layoutCom")
	self._timeCell = self:getGo("progress/progressSlider/timeCell")
	self._txtActivityTime = self:getTxt("time/txt")
	self._redpackTipsCon = self:getGo("redpackTips")
end

function GoddessContestMainView:bindEvents()
	GoddessContestMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function GoddessContestMainView:unbindEvents()
	GoddessContestMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function GoddessContestMainView:onEnter()
	GoddessContestMainView.super.onEnter(self)

	self._curActId = GoddessContestModel.instance:getCurActId()
	self._groupCfgs = GoddessContestConfig.instance:getFanGroupCfgsByActId(self._curActId)
	self._timeCfgs = GoddessContestConfig.instance:getTimeSldCfgsByActId(self._curActId)
	self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Goddess_Contest, self._curActId)

	local startTime, endTime = self._actTimeCfg.startTime, self._actTimeCfg.endTime
	local startDate, endDate = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

	self._txtActivityTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

	self:_refreshView()
	self:_refreshSldValue()
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestGetInfo, self._refreshView, self)
	GroupRedpackController.instance:setCurrContainer(self._redpackTipsCon, self._viewPresentor.viewName)
	GoddessContestController.instance:getInfo(self._curActId)
end

function GoddessContestMainView:onExit()
	GoddessContestMainView.super.onExit(self)

	for _, v in ipairs(self._groupCellList) do
		HeadItemController.instance:resetHeadCell(v.head)
	end

	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestGetInfo, self._refreshView, self)
end

function GoddessContestMainView:_refreshView()
	self._groupCellList = {}

	for id, cfg in ipairs(self._groupCfgs) do
		self._groupCellList[id] = self:_getGroupCell(id)

		self:_refreshCell(id)
	end
end

function GoddessContestMainView:_getGroupCell(id)
	local cell = {}

	cell.go = goutil.findChild(self._groupView, "cell_" .. id) or goutil.cloneAndSetParent(self._groupCell, self._groupView.transform, "cell_" .. id)
	cell.cellRoot = goutil.findChild(cell.go, "cellRoot")

	if id % 2 == 1 then
		GameUtil.setLocalPos(cell.cellRoot, 0, 0, 0)
	else
		GameUtil.setLocalPos(cell.cellRoot, 0, -11, 0)
	end

	cell.iconRank = goutil.findChildComponent(cell.cellRoot, "iconRank", "UIImageSpriteChange")
	cell.txtVoteNum = goutil.findChildTextComponent(cell.cellRoot, "voteNum/txt")
	cell.txtDeclaration = goutil.findChildTextComponent(cell.cellRoot, "declaration/txt")
	cell.btnGoto = goutil.findChild(cell.cellRoot, "btnGoTo")
	cell.txtGoto = goutil.findChildTextComponent(cell.btnGoto, "txt")
	cell.iconTitle = goutil.findChildComponent(cell.cellRoot, "title/icon", "UIImageSpriteChange")
	cell.txtTitle = goutil.findChildTextComponent(cell.cellRoot, "title/txt")
	cell.leader = goutil.findChild(cell.cellRoot, "leaderCom/leader")
	cell.empty = goutil.findChild(cell.cellRoot, "leaderCom/empty")
	cell.head = goutil.findChild(cell.leader, "head")
	cell.redPoint = goutil.findChild(cell.btnGoto, "redPoint")

	HeadItemController.instance:resetHeadCell(cell.head)

	cell.txtName = goutil.findChildTextComponent(cell.leader, "txtName")
	cell.txtArea = goutil.findChildTextComponent(cell.leader, "area/txt")

	RedPointController.instance:unregRedPoint(cell.redPoint)
	goutil.setActive(cell.redPoint, false)

	return cell
end

function GoddessContestMainView:_refreshCell(id)
	local cell = self._groupCellList[id]

	cell.cfg = self._groupCfgs[id]
	cell.data = GoddessContestModel.instance:getFansGroupInfo(id)

	GameUtil.rmClickHandler(cell.btnGoto)
	GameUtil.addClickHandler(cell.btnGoto, GameUtil.handler(self._onClickGoto, self, id))
	cell.iconTitle:SetState(id - 1)

	cell.txtTitle.text = cell.cfg.fansGroupName
	cell.txtVoteNum.text = langPara("人气值：%s", 0)
	cell.txtDeclaration.text = cell.cfg.fansGroupDeclaration

	cell.iconRank:SetState(id - 1)

	cell.txtName.text = ""
	cell.txtArea.text = ""

	goutil.setActive(cell.empty, true)
	goutil.setActive(cell.leader, false)

	if cell.data then
		cell.txtVoteNum.text = langPara("人气值：%s", cell.data.totalPower)

		if not string.nilorempty(cell.data.declaration) then
			cell.txtDeclaration.text = cell.data.declaration
		end

		cell.iconRank:SetState(cell.data.curRank - 1)

		if cell.data.leaderHeadInfo then
			HeadItemController.instance:setHeadCellByInfo(cell.head, cell.data.leaderHeadInfo)

			cell.txtName.text = cell.data.leaderHeadInfo.userName
			cell.txtArea.text = cell.data.leaderHeadInfo.areaName

			goutil.setActive(cell.empty, false)
			goutil.setActive(cell.leader, true)
		end
	end

	if id == GoddessContestModel.instance:getCurGroupId() then
		cell.txtGoto.text = lang("进入粉丝团")

		RedPointController.instance:regRedPoint(cell.redPoint, RedPointModel.ID_GODDESS_CONTEST_VOTE_GODDESS, RedPointModel.ID_GODDESS_CONTEST_VOTE_LEADER, RedPointModel.ID_GoddessContestCardDayOnceRed)
	else
		cell.txtGoto.text = lang("查看女神")
	end

	goutil.setActive(cell.go, true)
end

function GoddessContestMainView:_refreshSldValue()
	local skinChildren = GameUtil.getChildren(self._layoutCom)

	for _, v in ipairs(skinChildren) do
		goutil.setActive(v, false)
	end

	self._timeCellList = {}

	for i = 1, #self._timeCfgs - 1 do
		local cellGo = goutil.findChild(self._layoutCom, "cell_" .. i)

		cellGo = cellGo or goutil.cloneAndSetParent(self._timeCell, self._layoutCom.transform, "cell_" .. i)
		self._timeCellList[i] = self:_getTimeCell(cellGo)
	end

	self._timeCellList[#self._timeCfgs] = self:_getTimeCell(self._timeCell)

	local sliderIndex = 1
	local timeNow = ServerTime.now()

	for i, v in ipairs(self._timeCellList) do
		local cfg = self._timeCfgs[i]

		v.txtDesc.text = cfg.desc
		v.txtTime.text = cfg.showTime

		if i > 1 and timeNow >= GameUtil.string2time(cfg.startTime) then
			sliderIndex = i
		end
	end

	local indexValue = {
		0,
		0.35,
		0.7,
		1
	}

	self._sldProgress:SetValue(indexValue[sliderIndex])
end

function GoddessContestMainView:_getTimeCell(go)
	local cell = {}

	cell.go = go
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "desc/txtDesc")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")

	goutil.setActive(cell.go, true)

	return cell
end

function GoddessContestMainView:_onClickGoto(id)
	local cell = self._groupCellList[id]

	if cell then
		if id == GoddessContestModel.instance:getCurGroupId() then
			UIStateManager.instance:push(ViewName.GoddessContestGroupView)
		else
			UIStateManager.instance:push(ViewName.GoddessContestCheckView, cell.cfg.fansGroupGoddess)
		end
	end
end

function GoddessContestMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, GoddessContestConfig.instance:getCommondValueByKey("MAIN_RULE"))
end

function GoddessContestMainView:_onError(status)
	return
end

return GoddessContestMainView
