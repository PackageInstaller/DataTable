-- chunkname: @modules/logic/teach/controller/TeachNoteController.lua

module("modules.logic.teach.controller.TeachNoteController", package.seeall)

local TeachNoteController = class("TeachNoteController", BaseController)

function TeachNoteController:onInit()
	return
end

function TeachNoteController:onInitFinish()
	return
end

function TeachNoteController:addConstEvents()
	return
end

function TeachNoteController:reInit()
	return
end

function TeachNoteController:enterTeachNoteView(id, isJump)
	TeachNoteModel.instance:setJumpEnter(isJump)

	if not isJump then
		TeachNoteModel.instance:setJumpEpisodeId(nil)
	end

	local param = {}

	param.isJump = isJump
	param.episodeId = id

	ViewMgr.instance:openView(ViewName.TeachNoteView, param)

	return ViewName.TeachNoteView
end

function TeachNoteController:enterTeachNoteDetailView(id)
	TeachNoteModel.instance:setJumpEnter(false)
	ViewMgr.instance:openView(ViewName.TeachNoteDetailView, id)

	return ViewName.TeachNoteDetailView
end

TeachNoteController.instance = TeachNoteController.New()

return TeachNoteController
