-- chunkname: @modules/logic/versionactivity1_2/yaxian/model/game/YaXianGameSkillEffectMo.lua

module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameSkillEffectMo", package.seeall)

local YaXianGameSkillEffectMo = pureTable("YaXianGameSkillEffectMo")

function YaXianGameSkillEffectMo:init(actId, serverData)
	self.actId = actId

	self:updateMO(serverData)
end

function YaXianGameSkillEffectMo:updateMO(serverData)
	self.effectType = serverData.effectType
	self.effectUid = serverData.effectUid
	self.remainRound = serverData.remainRound
	self.skillId = serverData.skillId
	self.skillMo = YaXianGameModel.instance:getSkillMo(self.skillId)
end

return YaXianGameSkillEffectMo
