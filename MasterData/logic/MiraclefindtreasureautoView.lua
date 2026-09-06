-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/view/MiraclefindtreasureautoView.lua

module("logic.extensions.miraclefindtreasure.view.MiraclefindtreasureautoView", package.seeall)

local MiraclefindtreasureautoView = class("MiraclefindtreasureautoView", ViewComponent)

function MiraclefindtreasureautoView:buildUI()
	MiraclefindtreasureautoView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTip1 = self:getTxt("bg/txtTip1")
end

function MiraclefindtreasureautoView:bindEvents()
	MiraclefindtreasureautoView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function MiraclefindtreasureautoView:unbindEvents()
	MiraclefindtreasureautoView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MiraclefindtreasureautoView:onEnter()
	MiraclefindtreasureautoView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._data = params[2]
	self._useTotalMapNums = params[3] or 1
	self._useCurMapNum = 0
	self._leftTimer = 0

	self:_startNextTurn()
end

function MiraclefindtreasureautoView:onExit()
	MiraclefindtreasureautoView.super.onExit(self)

	self._data = nil
	self._useTotalMapNums = 0
	self._useCurMapNum = 0

	removetimer(self._startNextTurn, self)
	removetimer(self._sentAutoOrder, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	GlobalDispatcher:dispatch(GlobalNotify.MiracleFindTreasureAutoStop)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and mainPlayer.spine then
		SceneMainPlayer.instance:forceMainPlayerIdle()
	end
end

function MiraclefindtreasureautoView:_onViewOpened(view)
	if view.viewName == ViewName.MiraclefindtreasuredigView then
		if TreasureNewModel.instance:getState(self._activityId) == 1 then
			removetimer(self._startNextTurn, self)
			removetimer(self._sentAutoOrder, self)
			settimer(0.5, self._sentAutoOrder, self, false)
		else
			self:close()
		end
	elseif view.viewName == ViewName.MiraclefindtreasureView then
		if TreasureNewModel.instance:getState(self._activityId) == 2 then
			removetimer(self._startNextTurn, self)
			removetimer(self._sentAutoOrder, self)
			settimer(0.5, self._sentAutoOrder, self, false)
		else
			self:close()
		end
	elseif view.viewName == ViewName.ItemGet then
		if TreasureNewModel.instance:getState(self._activityId) == 0 then
			removetimer(self._sentAutoOrder, self)
			removetimer(self._startNextTurn, self)

			self._leftTimer = 3

			self:_startNextTurn()
		else
			self:close()
		end
	end
end

function MiraclefindtreasureautoView:_onViewClose(view)
	if view.viewName == ViewName.MiraclefindtreasuredigView and TreasureNewModel.instance:getState() ~= 2 then
		self:close()
	end
end

function MiraclefindtreasureautoView:_startNextTurn()
	if self._leftTimer <= 0 then
		removetimer(self._startNextTurn, self)
		UIStateManager.instance:popByName(ViewName.ItemGet)

		if self._useTotalMapNums - self._useCurMapNum > 0 then
			self._txtTip1.text = langPara("自动挖宝中，已完成挖宝（%s/%s）... ...", self._useCurMapNum, self._useTotalMapNums)
			self._useCurMapNum = self._useCurMapNum + 1

			FloatWordMgr.instance:show("todotodo")
		else
			self:close()
		end
	else
		self._txtTip1.text = self._useTotalMapNums - self._useCurMapNum > 0 and langPara("稍候将继续下一次挖宝(%s)", self._leftTimer) or langPara("自动挖宝即将结束(%s)", self._leftTimer)
		self._leftTimer = self._leftTimer - 1

		settimer(1, self._startNextTurn, self, false)
	end
end

function MiraclefindtreasureautoView:_sentAutoOrder()
	GlobalDispatcher:dispatch(GlobalNotify.MiracleFindTreasureAutoNext)
end

function MiraclefindtreasureautoView:_sendAutoOrder()
	GlobalDispatcher:dispatch(GlobalNotify.MiracleFindTreasureAutoNext)
end

return MiraclefindtreasureautoView
