-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mofang/controller/MofangController.lua

module("logic.extensions.mofang.controller.MofangController", package.seeall)

local MofangController = class("MofangController", BaseController)

function MofangController:ctor()
	MofangController.super.ctor(self)
end

function MofangController:onReset()
	self.hasInit = false
end

function MofangController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.onMaterialChange, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialInited, self.onMaterialInited, self)

	self.hasInit = false
	self.level = MofangModel.instance:getCurLv()
end

function MofangController:onMaterialChange()
	local newLv = MofangModel.instance:getCurLv()

	if newLv > self.level then
		self.level = newLv

		GlobalDispatcher:dispatch(GlobalNotify.OnMofangLvUp, newLv)

		if self.hasInit then
			SDKGameRoleInfoController.instance:onRoleLevelUp()
			UIStateManager.instance:open(ViewName.LeveUpView, newLv)
			GlobalDispatcher:dispatch(GlobalNotify.OnMofangDoLvUp, newLv)
		end
	end
end

function MofangController:dequeueNeedLevelUp()
	if self._needShowLvUp == true then
		self._needShowLvUp = false

		return true
	end

	return false
end

function MofangController:onMaterialInited(mat)
	if not self.hasInit then
		self.level = MofangModel.instance:getCurLv()
		self.hasInit = true
	end
end

function MofangController:onReset()
	self.hasInit = false
	self._needShowLvUp = false
end

MofangController.instance = MofangController.New()

return MofangController
