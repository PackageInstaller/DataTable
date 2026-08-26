-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlWeather.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlWeather", package.seeall)

local NecrologistStoryControlWeather = class("NecrologistStoryControlWeather", NecrologistStoryControlMgrItem)

function NecrologistStoryControlWeather:onPlayControl()
	local weather = tonumber(self.controlParam)
	local mo = NecrologistStoryModel.instance:getCurStoryMO()

	mo:setWeather(weather)
	self:onPlayControlFinish()
end

return NecrologistStoryControlWeather
