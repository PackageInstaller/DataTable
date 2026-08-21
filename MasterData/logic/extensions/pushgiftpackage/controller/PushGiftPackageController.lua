-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pushgiftpackage/controller/PushGiftPackageController.lua

module("logic.extensions.pushgiftpackage.controller.PushGiftPackageController", package.seeall)

local M = class("PushGiftPackageController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	return
end

M.instance = M.New()

return M
