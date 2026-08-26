-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/config/GaoSiNiaoConfig.lua

module("modules.logic.versionactivity3_1.gaosiniao.config.GaoSiNiaoConfig", package.seeall)

local GaoSiNiaoConfig = class("GaoSiNiaoConfig", Activity210Config)

local function _s_sort_episodeCOList(a, b)
	local a_id = a.episodeId
	local b_id = b.episodeId
	local a_preEpisodeId = a.preEpisodeId
	local b_preEpisodeId = b.preEpisodeId

	if a_preEpisodeId ~= b_preEpisodeId then
		return a_preEpisodeId < b_preEpisodeId
	end

	return a_id < b_id
end

function GaoSiNiaoConfig:getConstAsNum(id, fallback)
	local strValue = self:getConstWithActId(self:actId(), id)

	return tonumber(strValue) or fallback
end

function GaoSiNiaoConfig:getPathSpriteName(ePathSpriteId)
	return "v3a1_gaosiniao_game_piece" .. ePathSpriteId
end

function GaoSiNiaoConfig:getBloodSpriteName(ePathSpriteId)
	return "v3a1_gaosiniao_game_blood" .. ePathSpriteId
end

function GaoSiNiaoConfig:getGridSpriteName(eGridType)
	return "v3a1_gaosiniao_game_grid" .. eGridType
end

function GaoSiNiaoConfig:getEpisodeCOList()
	local episodeCOs = self.getEpisodeCOs(self, self)
	local normalCOList = {}
	local _SPCOList = {}

	for _, CO in pairs(episodeCOs) do
		if CO.type == GaoSiNiaoEnum.EpisodeType.SP then
			table.insert(_SPCOList, CO)
		else
			table.insert(normalCOList, CO)
		end
	end

	table.sort(normalCOList, _s_sort_episodeCOList)
	table.sort(_SPCOList, _s_sort_episodeCOList)

	return normalCOList, _SPCOList
end

GaoSiNiaoConfig.instance = GaoSiNiaoConfig.New()

return GaoSiNiaoConfig
