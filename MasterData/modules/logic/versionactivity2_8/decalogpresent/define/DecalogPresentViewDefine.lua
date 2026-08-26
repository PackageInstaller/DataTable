-- chunkname: @modules/logic/versionactivity2_8/decalogpresent/define/DecalogPresentViewDefine.lua

module("modules.logic.versionactivity2_8.decalogpresent.define.DecalogPresentViewDefine", package.seeall)

local DecalogPresentViewDefine = class("DecalogPresentViewDefine")

function DecalogPresentViewDefine.init(module_views)
	DecalogPresentViewDefine.initV2a8(module_views)
end

function DecalogPresentViewDefine.initV2a8(module_views)
	module_views.V2a8DecalogPresentView = {
		destroy = 0,
		container = "V2a8DecalogPresentViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_8/v2a8_versionsummon/v2a8_versionsummon.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.V2a8DecalogPresentFullView = {
		destroy = 0,
		container = "V2a8DecalogPresentFullViewContainer",
		mainRes = "ui/viewres/versionactivity_2_8/v2a8_versionsummon/v2a8_versionsummonfull.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

return DecalogPresentViewDefine
