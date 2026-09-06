-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtBuff.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtBuff", package.seeall)

local HurtEvtBuff = class("HurtEvtBuff", HurtEvtBase)

function HurtEvtBuff:getEvtType()
	return HurtEvtType.EvtBuff
end

function HurtEvtBuff:handleEvt(hurtData)
	if self.displayType == 0 then
		hurtData.target:removeBuffById(self.buffId)
	else
		hurtData.target:addBuff(self.buffId)
	end

	HurtEvtBuff.super.handleEvt(self, hurtData)
end

function HurtEvtBuff:getDesc(hurtData)
	if hurtData.target then
		local targetColor = hurtData:getColorByTeamId(hurtData.target.teamId)
		local petCo = CharacterConfig.instance:getPetCo(hurtData.target.raceId)
		local buffCo = BattleConfig.instance:getBuffCo(self.buffId)

		if buffCo then
			local targetName = petCo.name

			if self.displayType == 0 then
				printInfo(string.format(lang("battlerecord_buff_remove"), targetColor, buffCo.name .. "(" .. self.buffId .. ")", targetColor, targetName) .. " <color=#cccccc>" .. string.sub(buffCo.desc, 1, math.min(250, string.len(buffCo.desc))) .. "</color>")

				return string.format(lang("battlerecord_buff_remove"), targetColor, buffCo.name, targetColor, targetName)
			else
				printInfo(string.format(lang("battlerecord_buff_add"), targetColor, targetName, targetColor, buffCo.name .. "(" .. self.buffId .. ")") .. " <color=#00ff00>" .. string.sub(buffCo.desc, 1, math.min(250, string.len(buffCo.desc))) .. "</color>")

				return string.format(lang("battlerecord_buff_add"), targetColor, targetName, targetColor, buffCo.name)
			end
		else
			printInfo("buff 不存在，检查客户端是不是没导表，ID=" .. self.buffId)
		end
	end
end

return HurtEvtBuff
