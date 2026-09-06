-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampgame/FunCampGameOverView.lua

module("logic.extensions.funcamp.view.funcampgame.FunCampGameOverView", package.seeall)

local FunCampGameOverView = class("FunCampGameOverView", ViewComponent)

function FunCampGameOverView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._goCell = self:getGo("item")
	self._goTableView = self:getGo("rewardview")
	self.scrollList = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FunCampGameOverView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function FunCampGameOverView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function FunCampGameOverView:onEnter()
	local items = MaterialController.instance:getTempItemsByChangeSetId(FunCampModel.instance:getGameChangeSetId()) or {}

	self.scrollList:reloadData(items)
end

function FunCampGameOverView:onExit()
	self.scrollList:dispose()
end

function FunCampGameOverView:_onClickClose()
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.FunCampGameEnd)
end

function FunCampGameOverView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data:toString(), cell.gameObject)
end

function FunCampGameOverView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return FunCampGameOverView
