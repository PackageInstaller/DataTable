-- chunkname: @modules/logic/gm/view/GM_SettingsView.lua

module("modules.logic.gm.view.GM_SettingsView", package.seeall)

local GM_SettingsView = class("GM_SettingsView", BaseView)

function GM_SettingsView.register()
	GM_SettingsView.SettingsAccountView_register(SettingsAccountView)
end

function GM_SettingsView.SettingsAccountView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "onOpen")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_SettingsAccountViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_SettingsAccountViewContainer.removeEvents(self)
	end

	function T.onOpen(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "onOpen", ...)
		selfObj:_gm_showNodeAccountInfo()
	end

	function T._gm_showNodeAccountInfo(selfObj)
		local bActive = GM_SettingsAccountView.s_ShowNodeAccountInfo

		if bActive then
			gohelper.setActive(selfObj.goAccountContainer, true)
		else
			local isOfficial = GameChannelConfig.isXfsdk() and not SettingsModel.isBilibili()

			gohelper.setActive(selfObj.goAccountContainer, selfObj.isShowUserCenter and isOfficial)
		end

		gohelper.setActive(selfObj._currencyInfoGo, bActive)
	end
end

return GM_SettingsView
