-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/MississiBuffView.lua

module("logic.extensions.timelimitedchallenge.view.mississi.MississiBuffView", package.seeall)

local MississiBuffView = class("MississiBuffView", ViewComponent)

function MississiBuffView:buildUI()
	MississiBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goCell = self:getGo("cell")
	self._goTableView = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function MississiBuffView:bindEvents()
	MississiBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MississiBuffView:unbindEvents()
	MississiBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MississiBuffView:onEnter()
	MississiBuffView.super.onEnter(self)

	self._actId = MississiModel.instance:getActId()

	local cfgs = MississiConfig.instance:getBuffCfgs(self._actId)

	self._tableView:reloadData(cfgs)
end

function MississiBuffView:onExit()
	MississiBuffView.super.onExit(self)
	self._tableView:dispose()
end

function MississiBuffView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtLv.text = langPara("LV.%s", data.level)
	cell.txtDesc.text = data.desc
end

function MississiBuffView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtLv = goutil.findChildTextComponent(cell.go, "txtLv")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")

	return cell
end

return MississiBuffView
