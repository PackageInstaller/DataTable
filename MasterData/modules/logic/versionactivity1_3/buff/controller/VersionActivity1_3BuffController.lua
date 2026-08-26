-- chunkname: @modules/logic/versionactivity1_3/buff/controller/VersionActivity1_3BuffController.lua

module("modules.logic.versionactivity1_3.buff.controller.VersionActivity1_3BuffController", package.seeall)

local VersionActivity1_3BuffController = class("VersionActivity1_3BuffController", BaseController)

function VersionActivity1_3BuffController:onInit()
	return
end

function VersionActivity1_3BuffController:reInit()
	return
end

function VersionActivity1_3BuffController:openBuffView()
	ViewMgr.instance:openView(ViewName.VersionActivity1_3BuffView)
end

function VersionActivity1_3BuffController:openFairyLandView(param)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3FairyLandView, param)
end

VersionActivity1_3BuffController.instance = VersionActivity1_3BuffController.New()

return VersionActivity1_3BuffController
