-- chunkname: @modules/logic/activity/view/VersionSummon_BaseView.lua

module("modules.logic.activity.view.VersionSummon_BaseView", package.seeall)

local VersionSummon_BaseView = class("VersionSummon_BaseView", Activity101SignViewBase)

function VersionSummon_BaseView:onStart()
	return
end

function VersionSummon_BaseView:onRefresh()
	assert(false, "please override this method in the subclass")
end

function VersionSummon_BaseView:addEvents()
	VersionSummon_BaseView.super.addEvents(self)
end

function VersionSummon_BaseView:removeEvents()
	VersionSummon_BaseView.super.removeEvents(self)
end

return VersionSummon_BaseView
