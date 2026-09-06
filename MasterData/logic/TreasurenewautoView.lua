-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasurenew/view/TreasurenewautoView.lua

module("logic.extensions.treasurenew.view.TreasurenewautoView", package.seeall)

local TreasurenewautoView = class("TreasurenewautoView", ViewComponent)

function TreasurenewautoView:ctor()
	TreasurenewautoView.super.ctor(self)
end

function TreasurenewautoView:buildUI()
	TreasurenewautoView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTip1 = self:getTxt("bg/txtTip1")
end

function TreasurenewautoView:bindEvents()
	TreasurenewautoView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function TreasurenewautoView:unbindEvents()
	TreasurenewautoView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function TreasurenewautoView:destroyUI()
	TreasurenewautoView.super.destroyUI(self)
end

function TreasurenewautoView:onEnter()
	TreasurenewautoView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)

	local params = self:getOpenParam()

	self._data = params[1]
	self._useTotalMapNums = params[2]
	self._useCurMapNum = 0
	self._leftTimer = 0

	self:_startNextTurn()
end

function TreasurenewautoView:onEnterFinished()
	TreasurenewautoView.super.onEnterFinished(self)
end

function TreasurenewautoView:onExit()
	TreasurenewautoView.super.onExit(self)

	self._data = nil
	self._useTotalMapNums = 0
	self._useCurMapNum = 0

	removetimer(self._startNextTurn, self)
	removetimer(self._sentAutoOrder, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	GlobalDispatcher:dispatch(GlobalNotify.TreasureAutoStop)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and mainPlayer.spine then
		SceneMainPlayer.instance:forceMainPlayerIdle()
	end
end

function TreasurenewautoView:onExitFinished()
	TreasurenewautoView.super.onExitFinished(self)
end

function TreasurenewautoView:_onViewOpened(view)
	if view.viewName == ViewName.TreasurenewDigView then
		if TreasureNewModel.instance:getState() == 1 then
			removetimer(self._startNextTurn, self)
			removetimer(self._sentAutoOrder, self)
			settimer(0.5, self._sentAutoOrder, self, false)
		else
			self:close()
		end
	elseif view.viewName == ViewName.TreasurenewView or view.viewName == ViewName.ReadyforwartreasureView then
		if TreasureNewModel.instance:getState() == 2 then
			removetimer(self._startNextTurn, self)
			removetimer(self._sentAutoOrder, self)
			settimer(0.5, self._sentAutoOrder, self, false)
		else
			self:close()
		end
	elseif view.viewName == ViewName.ItemGet then
		if TreasureNewModel.instance:getState() == 0 then
			removetimer(self._sentAutoOrder, self)
			removetimer(self._startNextTurn, self)

			self._leftTimer = 3

			self:_startNextTurn()
		else
			self:close()
		end
	end
end

function TreasurenewautoView:_onViewClose(view)
	if view.viewName == ViewName.TreasurenewDigView and TreasureNewModel.instance:getState() ~= 2 then
		self:close()
	end
end

function TreasurenewautoView:_startNextTurn()
	if self._leftTimer <= 0 then
		removetimer(self._startNextTurn, self)
		UIStateManager.instance:popByName(ViewName.ItemGet)

		if self._useTotalMapNums - self._useCurMapNum > 0 then
			self._txtTip1.text = langPara("自动挖宝中，已完成挖宝（%s/%s）... ...", self._useCurMapNum, self._useTotalMapNums)
			self._useCurMapNum = self._useCurMapNum + 1

			MaterialFacade.instance:useItem(self._data.type, self._data.id, 1, TreasureNewController.instance:getlockCSceneListJson())
		else
			self:close()
		end
	else
		self._txtTip1.text = self._useTotalMapNums - self._useCurMapNum > 0 and langPara("稍候将继续下一次挖宝(%s)", self._leftTimer) or langPara("自动挖宝即将结束(%s)", self._leftTimer)
		self._leftTimer = self._leftTimer - 1

		settimer(1, self._startNextTurn, self, false)
	end
end

function TreasurenewautoView:_sentAutoOrder()
	GlobalDispatcher:dispatch(GlobalNotify.TreasureAutoNext)
end

function TreasurenewautoView:_sendAutoOrder()
	GlobalDispatcher:dispatch(GlobalNotify.TreasureAutoNext)
end

return TreasurenewautoView
