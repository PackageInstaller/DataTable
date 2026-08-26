-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/view/V3a1_GaoSiNiao_LevelViewFlow_WorkBase.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.view.V3a1_GaoSiNiao_LevelViewFlow_WorkBase", package.seeall)

local V3a1_GaoSiNiao_LevelViewFlow_WorkBase = class("V3a1_GaoSiNiao_LevelViewFlow_WorkBase", GaoSiNiaoWorkBase)

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:viewObj()
	return self.root:viewObj()
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:baseViewContainer()
	return self.root:baseViewContainer()
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:currentPassedEpisodeId()
	return self:baseViewContainer():currentPassedEpisodeId()
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:currentEpisodeIdToPlay()
	return self:baseViewContainer():currentEpisodeIdToPlay()
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:getEpisodeCO_disactiveEpisodeInfoDict(...)
	return self:baseViewContainer():getEpisodeCO_disactiveEpisodeInfoDict(...)
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:isSpEpisodeOpen(...)
	return self:baseViewContainer():isSpEpisodeOpen(...)
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:getPreEpisodeId(...)
	return self:baseViewContainer():getPreEpisodeId(...)
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:saveHasPlayedUnlockedAnimPath(...)
	return self:baseViewContainer():saveHasPlayedUnlockedAnimPath(...)
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:hasPlayedUnlockedAnimPath(...)
	return self:baseViewContainer():hasPlayedUnlockedAnimPath(...)
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:saveHasPlayedDisactiveAnimPath(...)
	return self:baseViewContainer():saveHasPlayedDisactiveAnimPath(...)
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:hasPlayedDisactiveAnimPath(...)
	return self:baseViewContainer():hasPlayedDisactiveAnimPath(...)
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:saveHasPlayedUnlockedEndless(...)
	return self:baseViewContainer():saveHasPlayedUnlockedEndless(...)
end

function V3a1_GaoSiNiao_LevelViewFlow_WorkBase:hasPlayedUnlockedEndless(...)
	return self:baseViewContainer():hasPlayedUnlockedEndless(...)
end

return V3a1_GaoSiNiao_LevelViewFlow_WorkBase
