-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/gfxgrade/GfxGradeSetting.lua

module("logic.common.gfxgrade.GfxGradeSetting", package.seeall)

local M = class("GfxGradeSetting")

function M:ctor()
	self.name = nil
	self.resolution = 0
	self.vSyncCount = 0
	self.frameRate = 0
	self.effectQuality = GfxGrade.MIDDLE_QUALITY
end

function M:clone(setting)
	self.name = setting.name
	self.vSyncCount = setting.vSyncCount
	self.resolution = setting.resolution
	self.frameRate = setting.frameRate
	self.effectQuality = setting.effectQuality
end

function M:equal(setting)
	return self.name == setting.name
end

return M
