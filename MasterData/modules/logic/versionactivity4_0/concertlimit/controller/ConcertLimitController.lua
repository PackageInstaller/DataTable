-- chunkname: @modules/logic/versionactivity4_0/concertlimit/controller/ConcertLimitController.lua

module("modules.logic.versionactivity4_0.concertlimit.controller.ConcertLimitController", package.seeall)

local ConcertLimitController = class("ConcertLimitController", BaseController)

function ConcertLimitController:onInit()
	return
end

function ConcertLimitController:reInit()
	return
end

function ConcertLimitController:onInitFinish()
	return
end

function ConcertLimitController:addConstEvents()
	return
end

function ConcertLimitController:openConcertLimitMainView()
	ViewMgr.instance:openView(ViewName.ConcertLimitMainView)
end

function ConcertLimitController:openSelfSelectView()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertSelfSelect

	ViewMgr.instance:openView(ViewName.GoldenMilletPresent, {
		actId = actId
	})
end

function ConcertLimitController:openActFlipView()
	ActFlipController.instance:openActFlipView()
end

function ConcertLimitController:openCandyRoomView()
	CandyRoomController.instance:openCandyRoomMainView()
end

function ConcertLimitController:openMusicNoteGameView()
	MusicGameController.instance:openMusicGameEnterView()
end

ConcertLimitController.instance = ConcertLimitController.New()

return ConcertLimitController
