-- chunkname: @modules/logic/partygame/view/common/PartyGameHelpView.lua

module("modules.logic.partygame.view.common.PartyGameHelpView", package.seeall)

local PartyGameHelpView = class("PartyGameHelpView", BaseView)

function PartyGameHelpView:onInitView()
	self._toggleoption = gohelper.findChildToggle(self.viewGO, "#toggle_option")
	self._txtoption = gohelper.findChildText(self.viewGO, "#toggle_option/#txt_option")
end

function PartyGameHelpView:addEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.onViewClose, self)
end

function PartyGameHelpView:removeEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onViewClose, self)
end

function PartyGameHelpView:onViewClose(viewName)
	if viewName == ViewName.HelpView then
		self:closeThis()
	end
end

function PartyGameHelpView:onOpen()
	self._toggleoption.isOn = false
	self._txtoption.text = luaLang("messageoptionbox_daily")

	local time = PartyGameConfig.instance:getConstValue(28)

	time = tonumber(time) or 5

	TaskDispatcher.runDelay(self.closeHelpView, self, time)
end

function PartyGameHelpView:closeHelpView()
	ViewMgr.instance:closeView(ViewName.HelpView)
end

function PartyGameHelpView:onClose()
	TaskDispatcher.cancelTask(self.closeHelpView, self)

	if self._toggleoption.isOn then
		TimeUtil.setDayFirstLoginRed("PartyGame_HelpView")
	else
		PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginTodayRed .. "_" .. "PartyGame_HelpView")
	end
end

return PartyGameHelpView
