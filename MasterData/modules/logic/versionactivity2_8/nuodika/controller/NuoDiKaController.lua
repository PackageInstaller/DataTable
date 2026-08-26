-- chunkname: @modules/logic/versionactivity2_8/nuodika/controller/NuoDiKaController.lua

module("modules.logic.versionactivity2_8.nuodika.controller.NuoDiKaController", package.seeall)

local NuoDiKaController = class("NuoDiKaController", BaseController)

function NuoDiKaController:onInit()
	return
end

function NuoDiKaController:reInit()
	return
end

function NuoDiKaController:addConstEvents()
	return
end

function NuoDiKaController:enterLevelView(data)
	self._levelData = data

	Activity180Rpc.instance:sendGet180InfosRequest(VersionActivity2_8Enum.ActivityId.NuoDiKa, self._onRecInfo, self)
end

function NuoDiKaController:_onRecInfo(cmd, resultCode, msg)
	if resultCode == 0 and msg.activityId == VersionActivity2_8Enum.ActivityId.NuoDiKa then
		NuoDiKaModel.instance:initInfos(msg.act180EpisodeNO)
		ViewMgr.instance:openView(ViewName.NuoDiKaLevelView, self._levelData)
	end
end

function NuoDiKaController:enterEpisode(data)
	self:dispatchEvent(NuoDiKaEvent.JumpToEpisode, data.episodeId)
end

function NuoDiKaController:enterGameView(data)
	ViewMgr.instance:openView(ViewName.NuoDiKaGameView, data)
end

function NuoDiKaController:enterInfosView()
	ViewMgr.instance:openView(ViewName.NuoDiKaInfosView)
end

function NuoDiKaController:enterEnemyDetailView(data)
	ViewMgr.instance:openView(ViewName.NuoDiKaGameUnitDetailView, data)
end

function NuoDiKaController:enterGameResultView(data)
	ViewMgr.instance:openView(ViewName.NuoDiKaGameResultView, data)
end

NuoDiKaController.instance = NuoDiKaController.New()

return NuoDiKaController
