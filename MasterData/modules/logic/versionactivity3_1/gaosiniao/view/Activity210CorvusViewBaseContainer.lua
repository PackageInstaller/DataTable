-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/Activity210CorvusViewBaseContainer.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.Activity210CorvusViewBaseContainer", package.seeall)

local Activity210CorvusViewBaseContainer = class("Activity210CorvusViewBaseContainer", Activity210ViewBaseContainer)

function Activity210CorvusViewBaseContainer:actId()
	return (self.viewParam or nil) and (self.viewParam.actId or GaoSiNiaoController.instance:actId())
end

function Activity210CorvusViewBaseContainer:taskType()
	return (self.viewParam or nil) and (self.viewParam.taskType or GaoSiNiaoController.instance:taskType())
end

function Activity210CorvusViewBaseContainer:getPrefsKeyPrefix_episodeId(episodeId)
	return self:getPrefsKeyPrefix() .. tostring(episodeId)
end

function Activity210CorvusViewBaseContainer:getEpisodeCOList()
	return GaoSiNiaoConfig.instance:getEpisodeCOList()
end

function Activity210CorvusViewBaseContainer:isEpisodeOpen(...)
	return GaoSiNiaoSysModel.instance:isEpisodeOpen(...)
end

function Activity210CorvusViewBaseContainer:hasPassLevelAndStory(...)
	return GaoSiNiaoSysModel.instance:hasPassLevelAndStory(...)
end

function Activity210CorvusViewBaseContainer:currentPassedEpisodeId()
	return GaoSiNiaoSysModel.instance:currentPassedEpisodeId()
end

function Activity210CorvusViewBaseContainer:currentEpisodeIdToPlay()
	return GaoSiNiaoSysModel.instance:currentEpisodeIdToPlay()
end

function Activity210CorvusViewBaseContainer:enterGame(...)
	GaoSiNiaoController.instance:enterGame(...)
end

function Activity210CorvusViewBaseContainer:getPreEpisodeId(...)
	return GaoSiNiaoConfig.instance:getPreEpisodeId(...)
end

function Activity210CorvusViewBaseContainer:isSpEpisodeOpen(...)
	return GaoSiNiaoSysModel.instance:isSpEpisodeOpen(...)
end

return Activity210CorvusViewBaseContainer
