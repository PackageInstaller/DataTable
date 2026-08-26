-- chunkname: @modules/logic/gm/view/GM_VersionActivity1_8EnterView.lua

module("modules.logic.gm.view.GM_VersionActivity1_8EnterView", package.seeall)

local GM_VersionActivity1_8EnterView = class("GM_VersionActivity1_8EnterView", GM_VersionActivity_EnterView)

function GM_VersionActivity1_8EnterView.register()
	GM_VersionActivity1_8EnterView.VersionActivityX_XEnterView(VersionActivity1_8EnterView)
	GM_VersionActivity_EnterView.VersionActivityX_XEnterViewTabItemBase_register(VersionActivity1_8EnterViewTabItem2)
end

function GM_VersionActivity1_8EnterView.VersionActivityX_XEnterView(T)
	GM_VersionActivity_EnterView.VersionActivityX_XEnterView(T)

	function T._gm_showAllTabIdUpdate(SelfObj)
		SelfObj:refreshUI()

		for _, tabItem in ipairs(SelfObj.activityTabItemList or {}) do
			tabItem:afterSetData()
		end
	end
end

return GM_VersionActivity1_8EnterView
