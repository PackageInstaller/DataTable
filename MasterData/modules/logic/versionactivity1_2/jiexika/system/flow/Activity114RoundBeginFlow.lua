-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/flow/Activity114RoundBeginFlow.lua

module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114RoundBeginFlow", package.seeall)

local Activity114RoundBeginFlow = class("Activity114RoundBeginFlow", FlowSequence)

function Activity114RoundBeginFlow:beginFlow()
	local context = {}

	context.day = Activity114Model.instance.serverData.day
	context.round = Activity114Model.instance.serverData.round

	local roundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, context.day, context.round)

	if not roundCo then
		logError("没有回合配置：" .. self.context.day .. "#" .. self.context.round)

		return
	end

	if string.nilorempty(roundCo.preStoryId) then
		return
	end

	if Activity114Model.instance.serverData.week ~= 1 then
		return
	end

	if GuideController.instance:isForbidGuides() then
		logError("当前设置禁用引导，无法播放引导，请在GM中开启引导然后重新打开界面！！！")

		return
	end

	local info = string.splitToNumber(roundCo.preStoryId, "#")

	if #info == 1 then
		info[2] = info[1]
		info[1] = Activity114Enum.PlayStartRoundType.Story
	end

	if info[1] == Activity114Enum.PlayStartRoundType.Story then
		self:addWork(Activity114StoryWork.New(info[2], Activity114Enum.StoryType.RoundStart))
	elseif info[1] == Activity114Enum.PlayStartRoundType.Guide then
		self:addWork(Activity114GuideWork.New(info[2]))
	else
		logError("回合开始配置错误" .. roundCo.preStoryId)

		return
	end

	self:addWork(Activity114SendRoundBeginReqWork.New())
	self:addWork(Activity114ChangeEventWork.New())
	self:start(context)

	return true
end

return Activity114RoundBeginFlow
