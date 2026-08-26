-- chunkname: @modules/logic/gm/view/GM_VersionActivity1_6EnterView.lua

module("modules.logic.gm.view.GM_VersionActivity1_6EnterView", package.seeall)

local GM_VersionActivity1_6EnterView = class("GM_VersionActivity1_6EnterView", GM_VersionActivity_EnterView)

function GM_VersionActivity1_6EnterView.register()
	GM_VersionActivity_EnterView.VersionActivityX_XEnterView(VersionActivity1_6EnterView)
	GM_VersionActivity_EnterView.VersionActivityEnterViewTabItem_register(VersionActivityEnterViewTabItem)
end

return GM_VersionActivity1_6EnterView
