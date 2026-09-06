-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/view/DivineteshamuclgtipsView.lua

module("logic.extensions.divineteshamuclg.view.DivineteshamuclgtipsView", package.seeall)

local DivineteshamuclgtipsView = class("DivineteshamuclgtipsView", ViewComponent)

function DivineteshamuclgtipsView:ctor()
	DivineteshamuclgtipsView.super.ctor(self)
end

function DivineteshamuclgtipsView:unbindEvents()
	DivineteshamuclgtipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineteshamuclgtipsView:bindEvents()
	DivineteshamuclgtipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineteshamuclgtipsView:buildUI()
	DivineteshamuclgtipsView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._buffTableCell = self:getGo("buffTableCell")
	self._buffTableView = self:getGo("buffTableView")
	self._buffTabelList = ScrollerList.create(self._buffTableView, self._buffTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineteshamuclgtipsView:onExit()
	DivineteshamuclgtipsView.super.onExit(self)
end

function DivineteshamuclgtipsView:onEnter()
	DivineteshamuclgtipsView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local cfgs = DivineteshamuclgConfig.instance:getBuffCfgs(self._activityId)

	self._buffTabelList:reloadData(cfgs)
end

function DivineteshamuclgtipsView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local goBg = goutil.findChild(go, "bg")
	local nextCfg = DivineteshamuclgConfig.instance:getBuffCfg(self._activityId, data.buffId + 1)

	txtName.text = nextCfg and string.format("%s-%s", data.difference, nextCfg.difference - 1) or string.format("%s及以上", data.difference)
	txtDesc.text = data.buffDesc

	goutil.setActive(goBg, cell.data % 2 ~= 0)
end

function DivineteshamuclgtipsView:_clearCell(cell)
	return
end

return DivineteshamuclgtipsView
