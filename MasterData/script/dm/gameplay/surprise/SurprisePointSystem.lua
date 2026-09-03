-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/surprise/SurprisePointSystem.lua

require("dm.gameplay.surprise.SurprisePoint")

SurprisePointSystem = class("SurprisePointSystem", legs.Actor)

SurprisePointSystem:has("_surprisePointService", {
	is = "r"
}):injectWith("SurprisePointService")
SurprisePointSystem:has("_surprisePoint", {
	is = "r"
})

function SurprisePointSystem:initialize()
	super.initialize(self)

	self._surprisePoint = SurprisePoint:new()
end

function SurprisePointSystem:getSurpriseById(id)
	return self._surprisePoint:getSurprisePointById(id)
end

function SurprisePointSystem:syncSurprisePoints(data)
	self._surprisePoint:sync(data)
end

function SurprisePointSystem:requestContinueReward(id, callback)
	local params = {
		continueId = id
	}

	self._surprisePointService:requestContinueReward(params, false, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end)
end
