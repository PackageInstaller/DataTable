-- chunkname: @modules/logic/versionactivity1_2/yaxian/model/YaXianMapMo.lua

module("modules.logic.versionactivity1_2.yaxian.model.YaXianMapMo", package.seeall)

local YaXianMapMo = pureTable("YaXianMapMo")

function YaXianMapMo:init(actId, serverData)
	self.actId = actId

	self:updateMO(serverData)
end

function YaXianMapMo:updateMO(serverData)
	self.episodeId = serverData.id
	self.currentRound = serverData.currentRound
	self.currentEvent = serverData.currentEvent

	self:updateInteractObjects(serverData.interactObjects)
	self:updateFinishInteracts(serverData.finishInteracts)

	self.episodeCo = YaXianConfig.instance:getEpisodeConfig(self.actId, self.episodeId)
	self.mapId = self.episodeCo.mapId
end

function YaXianMapMo:updateInteractObjects(interactObjs)
	self.interactObjs = {}

	for _, interactObj in ipairs(interactObjs) do
		local mo = YaXianGameInteractMO.New()

		mo:init(self.actId, interactObj)
		table.insert(self.interactObjs, mo)
	end
end

function YaXianMapMo:updateFinishInteracts(finishInteracts)
	self.finishInteracts = finishInteracts
end

return YaXianMapMo
