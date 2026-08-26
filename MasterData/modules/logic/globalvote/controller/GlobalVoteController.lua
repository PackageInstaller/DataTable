-- chunkname: @modules/logic/globalvote/controller/GlobalVoteController.lua

module("modules.logic.globalvote.controller.GlobalVoteController", package.seeall)

local GlobalVoteController = class("GlobalVoteController", BaseController)

function GlobalVoteController:ctor(...)
	GlobalVoteController.super.ctor(self, ...)
end

function GlobalVoteController:onInit()
	self:reInit()
end

function GlobalVoteController:reInit()
	GlobalVoteController.super.reInit(self)
end

function GlobalVoteController:addConstEvents()
	return
end

GlobalVoteController.instance = GlobalVoteController.New()

return GlobalVoteController
