-- chunkname: @modules/logic/main/controller/work/MainMailWork.lua

module("modules.logic.main.controller.work.MainMailWork", package.seeall)

local MainMailWork = class("MainMailWork", BaseWork)

function MainMailWork:onStart(context)
	MailController.instance:tryShowMailToast()
	self:onDone(true)
end

function MainMailWork:clearWork()
	return
end

return MainMailWork
