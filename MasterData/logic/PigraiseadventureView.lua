-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraiseadventureView.lua

module("logic.extensions.pigraise.view.PigraiseadventureView", package.seeall)

local PigraiseadventureView = class("PigraiseadventureView", ViewComponent)

function PigraiseadventureView:ctor()
	PigraiseadventureView.super.ctor(self)
end

function PigraiseadventureView:buildUI()
	PigraiseadventureView.super.buildUI(self)

	self._btnClose = self:getBtn("BG/btnClose")
	self._pig = self:getGo("BG/pig")
	self._btnTake = self:getBtn("BG/btnTake")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "BG/imgTime/txtTip/txt")
	self._txtTipGo = self:getGo("BG/txtTip")
	self._prizeTable = self:getGo("BG/prize/tableShow")
	self._itemGo = self:getGo("BG/prize/itemGo")
	self._tableview = ScrollerList.create(self._prizeTable, self._itemGo, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function PigraiseadventureView:bindEvents()
	PigraiseadventureView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTake:AddClickListener(self._onClickBtnTake, self)
end

function PigraiseadventureView:unbindEvents()
	PigraiseadventureView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTake:RemoveClickListener()
end

function PigraiseadventureView:destroyUI()
	PigraiseadventureView.super.destroyUI(self)
end

function PigraiseadventureView:onEnter()
	PigraiseadventureView.super.onEnter(self)
	PigraiseModelMgr.instance:pushViewWithModel(self._pig, self._viewPresentor.viewName, 0.7, 210)
	GlobalDispatcher:addListener(GlobalNotify.PigRaiseAdventureStateUpdate, self._refreshPrize, self)
	PigraiseController.instance:getAdventureInfoReq()
	removetimer(self._updateTime, self)
	settimer(1, self._updateTime, self)
end

function PigraiseadventureView:onEnterFinished()
	PigraiseadventureView.super.onEnterFinished(self)
end

function PigraiseadventureView:onExit()
	PigraiseadventureView.super.onExit(self)
	PigraiseModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	self._tableview:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PigRaiseAdventureStateUpdate, self._refreshPrize, self)
	removetimer(self._updateTime, self)
end

function PigraiseadventureView:onExitFinished()
	PigraiseadventureView.super.onExitFinished(self)
end

function PigraiseadventureView:_onClickBtnTake()
	if self._isReadyGet then
		PigraiseController.instance:getAdventurePrizeReq()
	else
		FloatWordMgr.instance:show("遛遛宠冒险还没获取收益，过一会再来")
	end
end

function PigraiseadventureView:_refreshPrize()
	local time = PigraiseModel.instance:getAdventureTime()
	local hour, min, sec = GameUtil.getTimeHHMMSS(time)

	self._txtTime.text = string.format("%02d:%02d:%02d", hour, min, sec)

	local dataList = PigraiseModel.instance:getAdventurePrizeList()

	if dataList == nil or #dataList == 0 then
		self._tableview:regGetDataLen(function()
			return 0
		end)

		self._isReadyGet = false
	else
		self._tableview:regGetDataLen(function()
			return math.max(#dataList, 12)
		end)

		self._isReadyGet = true
	end

	self._tableview:reloadData(dataList)
	goutil.setActive(self._txtTipGo, not self._isReadyGet)
end

function PigraiseadventureView:_clearPrizeCell(cell)
	local point = goutil.findChild(cell, "point")

	MaterialMgr.resetAll(point)
end

function PigraiseadventureView:_updatePrizeCell(view, cell, data)
	local point = goutil.findChild(cell, "point")

	if data then
		MaterialMgr.setCellByCfg(data, point)
	else
		MaterialMgr.resetAll(point)
	end
end

function PigraiseadventureView:_updateTime()
	local isUpdatetime, isUpdatePirze = PigraiseModel.instance:isupdateAdventure()

	if isUpdatetime then
		local time = PigraiseModel.instance:getAdventureTime()
		local hour, min, sec = GameUtil.getTimeHHMMSS(time)

		self._txtTime.text = string.format("%02d:%02d:%02d", hour, min, sec)
	end
end

return PigraiseadventureView
