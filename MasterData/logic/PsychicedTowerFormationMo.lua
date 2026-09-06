-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/model/PsychicedTowerFormationMo.lua

module("logic.extensions.psychicedtower.model.PsychicedTowerFormationMo", package.seeall)

local PsychicedTowerFormationMo = class("PsychicedTowerFormationMo", FormationMO)

function PsychicedTowerFormationMo:SetPosition(pos, value, notDispatch)
	if self.fixPetIds[self._positions[pos]] and self.fixPetIds[self._positions[pos]] ~= value then
		FloatWordMgr.instance:show(lang("不可下阵"))

		return false
	end

	PsychicedTowerFormationMo.super.SetPosition(self, pos, value, notDispatch)
end

function PsychicedTowerFormationMo:setPositionForce(positions, forceDispatch)
	local isAllClean = true

	for i, v in ipairs(positions) do
		if v ~= 0 then
			isAllClean = false
		end
	end

	if isAllClean == true then
		for i, v in pairs(self._positions) do
			if self.fixPetIds[v] then
				positions[i] = v
			end
		end
	end

	local change = self:_setAllPositions(positions)

	if change or forceDispatch then
		GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged)
	end

	return change
end

function PsychicedTowerFormationMo:getFixPetsMap()
	return self.fixPetIds
end

return PsychicedTowerFormationMo
