-- chunkname: @modules/logic/versionactivity1_2/yaxian/model/YaXianEpisodeMo.lua

module("modules.logic.versionactivity1_2.yaxian.model.YaXianEpisodeMo", package.seeall)

local YaXianEpisodeMo = pureTable("YaXianEpisodeMo")

function YaXianEpisodeMo:init(actId, serverData)
	self.actId = actId

	self:updateMO(serverData)
end

function YaXianEpisodeMo:updateMO(serverData)
	self.id = serverData.id
	self.star = serverData.star
	self.totalCount = serverData.totalCount
	self.config = YaXianConfig.instance:getEpisodeConfig(YaXianEnum.ActivityId, self.id)
end

function YaXianEpisodeMo:updateData(serverData)
	self.star = serverData.star
	self.totalCount = serverData.totalCount
end

return YaXianEpisodeMo
