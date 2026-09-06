-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wushenshou/controller/WushenViewController.lua

module("logic.extensions.wushenshou.controller.WushenViewController", package.seeall)

local WushenViewController = class("WushenViewController", BaseController)

WushenViewController.IS_NEED_SHOW_GAS = false

function WushenViewController:ctor()
	WushenViewController.super.ctor(self)

	self._pveId = 0
end

function WushenViewController:onInit()
	return
end

function WushenViewController:onReset()
	return
end

function WushenViewController:setPveId(pveId)
	self._pveId = pveId
end

function WushenViewController:openMissionView(pveId)
	local _shenshouType = pveId or 1

	if WuShenConfig.NEED_CLEAR[_shenshouType] then
		FormationController.instance:ResetCurFormation()
		FormationController.instance:SaveFormationEx()
		FormationController.instance:ResetHasPet()
	end

	self:setPveId(_shenshouType)
	UIStateManager.instance:push(ViewName.WuShenPrePareView, _shenshouType)
end

WushenViewController.instance = WushenViewController.New()

return WushenViewController
