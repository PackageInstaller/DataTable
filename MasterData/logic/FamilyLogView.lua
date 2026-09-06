-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyLogView.lua

module("logic.extensions.family.view.FamilyLogView", package.seeall)

local FamilyLogView = class("FamilyLogView", TableViewComponent)

function FamilyLogView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function FamilyLogView:ctor()
	FamilyLogView.super.ctor(self)
end

function FamilyLogView:destroyUI()
	FamilyLogView.super.destroyUI(self)
end

function FamilyLogView:onExitFinished()
	FamilyLogView.super.onExitFinished(self)
end

function FamilyLogView:onEnterFinished()
	FamilyLogView.super.onEnterFinished(self)
end

function FamilyLogView:unbindEvents()
	FamilyLogView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function FamilyLogView:bindEvents()
	FamilyLogView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function FamilyLogView:onExit()
	FamilyLogView.super.onExit(self)
end

function FamilyLogView:buildUI()
	FamilyLogView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
end

function FamilyLogView:onEnter()
	FamilyLogView.super.onEnter(self)
	FamilyController.instance:getFamilyEventLogsReq(self._updateUI, self)
end

function FamilyLogView:_cellSize()
	return 590, 40
end

function FamilyLogView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "container")
	local txtTime = goutil.findChildTextComponent(container, "txtTime")
	local txtName = goutil.findChildTextComponent(container, "txtName")
	local txtContent = goutil.findChildTextComponent(txtName.gameObject, "txtContent")
	local date = GameUtil.time2date(data.eventTime / 1000)

	txtTime.text = string.format("%02d-%02d  %02d:%02d", date.month, date.day, date.hour, date.min)

	local userName, content = FamilyConfig.instance:getLogContent(data.logTypeId, data.logParam)

	txtName.text = userName
	txtContent.text = content
end

function FamilyLogView:_updateUI()
	self._curViewDatas = FamilyModel.instance:getFamilyLogs()

	self:reloadData()
end

function FamilyLogView:_onClickClose()
	self:close()
end

return FamilyLogView
