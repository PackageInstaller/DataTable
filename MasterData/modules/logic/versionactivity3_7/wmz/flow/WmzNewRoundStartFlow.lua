-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzNewRoundStartFlow.lua

module("modules.logic.versionactivity3_7.wmz.flow.WmzNewRoundStartFlow", package.seeall)

local Base = WmzFlowSequence
local WmzNewRoundStartFlow = class("WmzNewRoundStartFlow", Base)

function WmzNewRoundStartFlow:ctor(...)
	Base.ctor(self, ...)
end

function WmzNewRoundStartFlow:onStart()
	local gameCO = self.viewContainer:getGameCO()
	local guildId = gameCO.guildId

	if guildId > 0 then
		self:addWork(WmzGuideWork.s_create(guildId))
	end
end

return WmzNewRoundStartFlow
