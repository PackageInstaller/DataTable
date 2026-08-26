-- chunkname: @modules/logic/versionactivity1_2/yaxian/model/game/YaXianGameSkillMo.lua

module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameSkillMo", package.seeall)

local YaXianGameSkillMo = pureTable("YaXianGameSkillMo")

function YaXianGameSkillMo:init(actId, serverData)
	self.actId = actId

	self:updateMO(serverData)
end

function YaXianGameSkillMo:updateMO(serverData)
	self.id = serverData.skillId
	self.canUseCount = serverData.canUseCount
	self.config = YaXianConfig.instance:getSkillConfig(self.actId, self.id)
end

return YaXianGameSkillMo
