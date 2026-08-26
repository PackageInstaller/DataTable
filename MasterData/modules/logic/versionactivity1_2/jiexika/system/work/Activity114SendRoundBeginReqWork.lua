-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114SendRoundBeginReqWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114SendRoundBeginReqWork", package.seeall)

local Activity114SendRoundBeginReqWork = class("Activity114SendRoundBeginReqWork", Activity114ReqBaseWork)

function Activity114SendRoundBeginReqWork:onStart()
	if Activity114Model.instance.serverData.day ~= self.context.day or Activity114Model.instance.serverData.round ~= self.context.round then
		self:onDone(true)

		return
	end

	Activity114Rpc.instance:markRoundStory(Activity114Model.instance.id, self.onReply, self)
end

function Activity114SendRoundBeginReqWork:onReply(cmd, resultCode, msg)
	if resultCode == 0 then
		local roundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, self.context.day, self.context.round)

		if roundCo and roundCo.isSkip == 1 then
			local newRoundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, self.context.day, self.context.round + 1)

			newRoundCo = newRoundCo or Activity114Config.instance:getRoundCo(Activity114Model.instance.id, self.context.day + 1, 1)

			if newRoundCo then
				Activity114Model.instance.serverData.day = newRoundCo.day
				Activity114Model.instance.serverData.round = newRoundCo.id
			else
				logError("没有下回合配置？" .. self.context.day .. "  #  " .. self.context.round)
			end
		else
			Activity114Model.instance.serverData.isReadRoundStory = true
		end
	end

	Activity114SendRoundBeginReqWork.super.onReply(self, cmd, resultCode, msg)
end

return Activity114SendRoundBeginReqWork
