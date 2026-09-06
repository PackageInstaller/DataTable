-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/view/GroupRechargeMainView.lua

module("logic.extensions.grouprecharge.view.GroupRechargeMainView", package.seeall)

local GroupRechargeMainView = class("GroupRechargeMainView", ViewComponent)

function GroupRechargeMainView:buildUI()
	GroupRechargeMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self.container = self:getGo("container")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GroupRechargeMainView:bindEvents()
	GroupRechargeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function GroupRechargeMainView:unbindEvents()
	GroupRechargeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
end

function GroupRechargeMainView:onEnter()
	GroupRechargeMainView.super.onEnter(self)

	self._tabConfigs = GroupRechargeConfig.instance:getTabConfigs()

	local selectId = checkint(self:getFirstParam())

	if selectId <= 0 then
		selectId = GroupRechargeModel.instance:getLastOpenTagId()
	end

	self:_onClickTab(selectId)

	self._viewPresentor._openParam = nil

	GroupRechargeAgent.instance:sendPM_GroupRechargeInfoReq()
	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_GROUP_RECHARGE_ONCE, true)
end

function GroupRechargeMainView:onExit()
	GroupRechargeMainView.super.onExit(self)
	self._tableview:dispose()

	if self._curSelectData then
		GroupRechargeModel.instance:setLastOpenTagId(self._curSelectData.id)
	end

	self._curSelectData = nil
end

function GroupRechargeMainView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.imgChange:SetState(data == self._curSelectData and 1 or 0)
	cell.txtChange:SetState(data == self._curSelectData and 1 or 0)

	cell.txt.text = data.name

	if not string.nilorempty(data.showTag) then
		cell.txtTag.text = data.showTag

		goutil.setActive(cell.goTag, true)
	end

	RedPointController.instance:regRedPoint(cell.redpoint, unpack(string.split(data.redpointId or "", "#")))
	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickTab, self, data.id))
end

function GroupRechargeMainView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.imgChange = goutil.findChildComponent(cell.go, "bg", "UIImageSpriteChange")
	cell.txtChange = goutil.findChildComponent(cell.go, "txt", "UITextColorChange")
	cell.goTag = goutil.findChild(cell.go, "tag")
	cell.txtTag = goutil.findChildTextComponent(cell.goTag, "txt")
	cell.btn = goutil.findChild(cell.go, "btn")
	cell.redpoint = goutil.findChild(cell.go, "redpoint")
	cell.txt = goutil.findChildTextComponent(cell.go, "txt")

	GameUtil.rmClickHandler(cell.btn)
	goutil.setActive(cell.redpoint, false)
	goutil.setActive(cell.goTag, false)
	RedPointController.instance:unregRedPoint(cell.redpoint)

	return cell
end

function GroupRechargeMainView:_onClickTab(showId)
	local showData
	local dataList = {}

	for k, v in ipairs(self._tabConfigs) do
		table.insert(dataList, v)

		if showId == k then
			showData = v
		end
	end

	table.sort(dataList, function(a, b)
		return a.sort < b.sort
	end)

	showData = showData or self._curSelectData and self._curSelectData or dataList[1]

	if self._curSelectData ~= showData then
		self._curSelectData = showData

		self:showTabAt(self.container)
		self:showTabAt(self.container, self._curSelectData.viewname, showData, self._curSelectData.parameter)
		SurveyController.instance:reportBehavior(checknumber(self._curSelectData.reportBehavior))
	end

	self._tableview:reloadData(dataList)
end

function GroupRechargeMainView:_onClickClose()
	self._curSelectData = nil

	GroupRechargeModel.instance:setLastOpenTagId(0)
	self:close()
end

function GroupRechargeMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "grouprecharge_rule")
end

return GroupRechargeMainView
