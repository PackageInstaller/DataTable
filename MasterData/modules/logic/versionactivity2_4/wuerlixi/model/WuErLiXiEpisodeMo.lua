-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/model/WuErLiXiEpisodeMo.lua

module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiEpisodeMo", package.seeall)

local WuErLiXiEpisodeMo = class("WuErLiXiEpisodeMo")

function WuErLiXiEpisodeMo:ctor()
	self.episodeId = 0
	self.isFinished = false
	self.status = WuErLiXiEnum.EpisodeStatus.BeforeStory
	self.gameString = ""
end

function WuErLiXiEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.gameString = info.gameString
end

function WuErLiXiEpisodeMo:update(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.gameString = info.gameString
end

function WuErLiXiEpisodeMo:updateGameString(str)
	self.gameString = str
end

return WuErLiXiEpisodeMo
