-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_BombSkillRange.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_BombSkillRange", package.seeall)

local MatchGameSkillEffect_BombSkillRange = class("MatchGameSkillEffect_BombSkillRange")

function MatchGameSkillEffect_BombSkillRange:init(viewContent)
	self.viewContent = viewContent
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_BombSkillRange:progressEffect_1010(effectCoData, targetInfoList, skillData)
	local rangeId = effectCoData[2]

	if rangeId then
		::label_2_0::

		local rangeConfig = MatchGameFightConfig.instance:getSkillRangeConfig(rangeId)

		if not rangeConfig then
			return
		end

		local rangeDataList = GameUtil.splitString2(rangeConfig.range, true)

		if rangeConfig.rangeType == MatchGameFightEnum.SkillRangeType.Bomb then
			self.sceneView:setBombRangeOffsetList(rangeDataList)
		end
	end
end

return MatchGameSkillEffect_BombSkillRange
