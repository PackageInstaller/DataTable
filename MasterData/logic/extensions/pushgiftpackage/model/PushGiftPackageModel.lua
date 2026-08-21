-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pushgiftpackage/model/PushGiftPackageModel.lua

module("logic.extensions.pushgiftpackage.model.PushGiftPackageModel", package.seeall)

local M = class("PushGiftPackageModel", BaseModel)

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
