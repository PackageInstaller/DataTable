-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownRewardView.lua

module("logic.extensions.showdown.view.ShowDownRewardView", package.seeall)

local ShowDownRewardView = class("ShowDownRewardView", ViewComponent)

function ShowDownRewardView:ctor()
	ShowDownRewardView.super.ctor(self)
end

function ShowDownRewardView:unbindEvents()
	ShowDownRewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ShowDownRewardView:bindEvents()
	ShowDownRewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ShowDownRewardView:buildUI()
	ShowDownRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ShowDownRewardView:onExit()
	ShowDownRewardView.super.onExit(self)
	self._tableview:dispose()
end

function ShowDownRewardView:onEnter()
	ShowDownRewardView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local prizeCfgs = ShowDownConfig.instance:getFinalMatchPrizeCfg(self._activityId)

	self._tableview:reloadData(prizeCfgs)
end

function ShowDownRewardView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	cell.txtRank.text = langPara("第%s名", data.rankId)

	MaterialMgr.setCellListByCfg(data.prize, cell.prizeCom)
end

function ShowDownRewardView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.txtRank = goutil.findChildTextComponent(cell.go, "txtRank")
	cell.prizeCom = goutil.findChild(cell.go, "prizeCom")

	MaterialMgr.resetAll(cell.prizeCom)

	return cell
end

return ShowDownRewardView
