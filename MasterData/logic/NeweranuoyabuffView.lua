-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/view/NeweranuoyabuffView.lua

module("logic.extensions.neweranuoya.view.NeweranuoyabuffView", package.seeall)

local NeweranuoyabuffView = class("NeweranuoyabuffView", ViewComponent)

function NeweranuoyabuffView:ctor()
	NeweranuoyabuffView.super.ctor(self)
end

function NeweranuoyabuffView:unbindEvents()
	NeweranuoyabuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NeweranuoyabuffView:bindEvents()
	NeweranuoyabuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NeweranuoyabuffView:buildUI()
	NeweranuoyabuffView.super.buildUI(self)

	self._btnClose = self:getGo("container/btnClose")

	local goTab = self:getGo("container/desc/tableview")
	local goCell = self:getGo("container/desc/tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = self:getGo("container/desc/empty")
end

function NeweranuoyabuffView:onExit()
	NeweranuoyabuffView.super.onExit(self)
	self._tableView:dispose()
end

function NeweranuoyabuffView:onEnter()
	NeweranuoyabuffView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._floorId = params[2]
	self._stageId = params[3]

	self:_udpateUI()
end

function NeweranuoyabuffView:_udpateUI()
	local info = NeweranuoyaModel.instance:getExtStageFloorInfo(self._activityId, self._floorId, self._stageId)

	self._tableView:reloadData(info.jobIdToBuffNum)
	goutil.setActive(self._emptyGo, not info.jobIdToBuffNum or #info.jobIdToBuffNum <= 0)
end

function NeweranuoyabuffView:_updateCell(view, cell, pair, tag)
	local go = cell.gameObject
	local bg = goutil.findChild(go, "bg")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local jobId = pair.left
	local num = pair.right
	local jobCfg = NeweranuoyaConfig.instance:getJobCfg(self._activityId, jobId, num)
	local arr = string.split(jobCfg.petValidator, "$")

	goutil.setActive(bg, cell.data % 2 == 0)

	txtDesc.text = jobCfg.buffDesc
	txtName.text = arr[2]
end

function NeweranuoyabuffView:_clearCell(cell)
	return
end

return NeweranuoyabuffView
