-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventCameraTrace.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventCameraTrace", package.seeall)

local FightTLEventCameraTrace = class("FightTLEventCameraTrace", FightTimelineTrackItem)
local TraceType = {
	Attacker = 1,
	Defender = 2,
	Reset = 0,
	PosAbsDistRelateAtk = 4,
	PosAbs = 3
}

function FightTLEventCameraTrace:onTrackStart(fightStepData, duration, paramsArr)
	local sceneCameraComp = GameSceneMgr.instance:getCurScene().camera

	sceneCameraComp:setEaseTime(duration)
	sceneCameraComp:setEaseType(EaseType.Str2Type(paramsArr[5]))

	local traceType = tonumber(paramsArr[1]) or 0

	if traceType == TraceType.Reset then
		sceneCameraComp:resetParam()
	else
		local distance = tonumber(paramsArr[2]) or 0

		if distance > 0 then
			local cameraCO = sceneCameraComp:getCurCO()

			if traceType == TraceType.PosAbsDistRelateAtk then
				local entity = FightHelper.getEntity(fightStepData.fromId)
				local _, _, entityZ = transformhelper.getPos(entity.go.transform)

				sceneCameraComp:setDistance(distance - entityZ)
			else
				sceneCameraComp:setDistance(distance)
			end
		else
			sceneCameraComp:resetDistance(distance)
		end

		local isFocus = paramsArr[3] == "1"

		if isFocus then
			local focusOffset = string.split(paramsArr[4], ",")
			local focusOffsetX = tonumber(focusOffset[1]) or 0
			local focusOffsetY = tonumber(focusOffset[2]) or 0
			local focusOffsetZ = tonumber(focusOffset[3]) or 0
			local x, y, z = 0, 0, 0

			if traceType == TraceType.Attacker or traceType == TraceType.Defender then
				if traceType == TraceType.Attacker then
					if not fightStepData.fromId then
						local entityId = fightStepData.toId
						local entity = FightHelper.getEntity(entityId)

						if entity then
							x, y, z = FightHelper.getEntityWorldCenterPos(entity)

							if not entity:isMySide() then
								focusOffsetX = -focusOffsetX
							end
						end
					end
				end
			elseif traceType == TraceType.PosAbs or traceType == TraceType.PosAbsDistRelateAtk then
				local entity = FightHelper.getEntity(fightStepData.fromId)

				if entity and not entity:isMySide() then
					focusOffsetX = -focusOffsetX
				end
			end

			sceneCameraComp:setFocus(x + focusOffsetX, y + focusOffsetY, z + focusOffsetZ)
		else
			local cameraCO = sceneCameraComp:getCurCO()

			sceneCameraComp:setFocus(0, cameraCO.yOffset, cameraCO.focusZ)
		end
	end
end

return FightTLEventCameraTrace
