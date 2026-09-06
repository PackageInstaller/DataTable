-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtTransPosition.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtTransPosition", package.seeall)

local HurtEvtTransPosition = class("HurtEvtTransPosition", HurtEvtBase)

function HurtEvtTransPosition:getEvtType()
	return HurtEvtType.TransPosition
end

function HurtEvtTransPosition:handleEvt(hurtData)
	local scene = SceneMgr.instance:getCurScene()
	local targetTeamId = self.positionChange.target.targetTeamId

	if self.positionChange.skillId > 0 and self.positionChange:HasField("trigger") then
		local unit = scene.unitFactory:getUnit(self.positionChange.trigger.targetTeamId, self.positionChange.trigger.targetCharacterId)

		unit:onTriggerTransPosition(self.positionChange.skillId, targetTeamId, self.positionChange.changes)
	elseif self.positionChange.changes and #self.positionChange.changes > 0 then
		local posArrs = {}
		local pets = {}

		for _, v in ipairs(self.positionChange.changes) do
			local id = checknumber(v.id)

			posArrs[id] = posArrs[id] or {}

			table.insert(posArrs[id], {
				v.newX,
				v.newY
			})

			if table.indexof(pets, id) == false then
				pets[#pets + 1] = id
			end
		end

		for index, id in ipairs(pets) do
			local posArr = posArrs[id]
			local unit = scene.unitFactory:getUnit(targetTeamId, id)

			if unit then
				if #posArr > 1 then
					unit:onTransPositionList(posArr)
				else
					unit:onTransPosition(posArr[1][1], posArr[1][2])
				end
			end
		end
	end

	HurtEvtTransPosition.super.handleEvt(self, hurtData)
end

function HurtEvtTransPosition:getDesc(hurtData)
	return
end

return HurtEvtTransPosition
