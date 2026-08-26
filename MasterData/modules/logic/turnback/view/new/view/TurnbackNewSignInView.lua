-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewSignInView.lua

module("modules.logic.turnback.view.new.view.TurnbackNewSignInView", package.seeall)

local TurnbackNewSignInView = class("TurnbackNewSignInView", BaseView)

function TurnbackNewSignInView:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackNewSignInView:addEvents()
	TurnbackController.instance:registerCallback(TurnbackEvent.RefreshView, self.refreshItem, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.refreshItem, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function TurnbackNewSignInView:removeEvents()
	TurnbackController.instance:unregisterCallback(TurnbackEvent.RefreshView, self.refreshItem, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.refreshItem, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function TurnbackNewSignInView:_editableInitView()
	self._signItems = {}

	for day = 1, 7 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self._gocontent, "node" .. day)
		item.cls = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, TurnbackNewSignInItem)

		table.insert(self._signItems, item)
		item.cls:initItem(day)
	end
end

function TurnbackNewSignInView:onUpdateParam()
	return
end

function TurnbackNewSignInView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_04)
end

function TurnbackNewSignInView:refreshItem()
	for day, item in ipairs(self._signItems) do
		item.cls:initItem(day)
	end
end

function TurnbackNewSignInView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		local day = TurnbackModel.instance:getLastGetSigninReward()

		if day then
			ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
				isNormal = true,
				day = day
			})
		end
	end
end

function TurnbackNewSignInView:onClose()
	return
end

function TurnbackNewSignInView:onDestroyView()
	return
end

return TurnbackNewSignInView
