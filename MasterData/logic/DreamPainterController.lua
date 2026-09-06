-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/controller/DreamPainterController.lua

module("logic.extensions.dreampainter.controller.DreamPainterController", package.seeall)

local DreamPainterController = class("DreamPainterController", BaseController)

function DreamPainterController:ctor()
	return
end

function DreamPainterController:onInit()
	self:onReset()
end

function DreamPainterController:onReset()
	return
end

function DreamPainterController:sendGetInfo(activityId)
	DreamPainterAgent.instance:sendPM_DreamPainterInfoReq(activityId)
end

function DreamPainterController:handleGetInfo(msg)
	DreamPainterModel.instance:handleGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DreamPainterInfoUpdate)
end

function DreamPainterController:sendPM_DreamPainterVoteReq(activityId, phaseId, workId)
	local info = DreamPainterModel.instance:getInfo(activityId) or {}
	local curPhaseId = checknumber(info.curPhaseId)
	local curPhaseTimes = checknumber(info.curPhaseTimes)

	if curPhaseTimes > 0 then
		if not info.phase then
			local wordInfo

			for i, phase in ipairs(info.phase) do
				for j, w in ipairs(phase.works) do
					if w.workId == workId then
						wordInfo = w
					end
				end
			end

			local cfg = DreamPainterConfig.instance:getWorksCfgById(activityId, workId)
			local content = langPara("是否消耗1票，投票给<color=#eb4642>%s</color>的作品？", cfg.workerName)

			TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
				DreamPainterAgent.instance:sendPM_DreamPainterVoteReq(activityId, phaseId, workId)
			end)
		end
	else
		TipsFacade.instance:openCommonTips("你现在没有投票次数了哦")
	end
end

function DreamPainterController:handlePainterVote(msg)
	DreamPainterModel.instance:handlePainterVote(msg)

	if msg.changSetId then
		MaterialFacade.instance:popAndShowChangeSetItems(msg.changSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.DreamPainterPageUpdate, msg)
end

DreamPainterController.instance = DreamPainterController.New()

return DreamPainterController
