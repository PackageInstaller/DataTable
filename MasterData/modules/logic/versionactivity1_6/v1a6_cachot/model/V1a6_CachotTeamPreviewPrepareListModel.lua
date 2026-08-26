-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotTeamPreviewPrepareListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotTeamPreviewPrepareListModel", package.seeall)

local V1a6_CachotTeamPreviewPrepareListModel = class("V1a6_CachotTeamPreviewPrepareListModel", ListScrollModel)

function V1a6_CachotTeamPreviewPrepareListModel:onInit()
	return
end

function V1a6_CachotTeamPreviewPrepareListModel:reInit()
	self:onInit()
end

function V1a6_CachotTeamPreviewPrepareListModel:initList()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local teamInfo = rogueInfo.teamInfo
	local heroList = teamInfo:getSupportHeros()
	local pageNum = math.ceil(#heroList / 4)

	pageNum = math.max(pageNum, 1)

	for i = #heroList + 1, pageNum * 4 do
		table.insert(heroList, HeroSingleGroupMO.New())
	end

	self:setList(heroList)
end

V1a6_CachotTeamPreviewPrepareListModel.instance = V1a6_CachotTeamPreviewPrepareListModel.New()

return V1a6_CachotTeamPreviewPrepareListModel
