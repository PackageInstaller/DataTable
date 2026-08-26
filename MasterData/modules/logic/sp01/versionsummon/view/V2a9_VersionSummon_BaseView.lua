-- chunkname: @modules/logic/sp01/versionsummon/view/V2a9_VersionSummon_BaseView.lua

module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummon_BaseView", package.seeall)

local V2a9_VersionSummon_BaseView = class("V2a9_VersionSummon_BaseView", Activity101SignViewBase)

function V2a9_VersionSummon_BaseView:onStart()
	return
end

function V2a9_VersionSummon_BaseView:onRefresh()
	assert(false, "please override this method in the subclass")
end

function V2a9_VersionSummon_BaseView:addEvents()
	V2a9_VersionSummon_BaseView.super.addEvents(self)
end

function V2a9_VersionSummon_BaseView:removeEvents()
	V2a9_VersionSummon_BaseView.super.removeEvents(self)
end

return V2a9_VersionSummon_BaseView
