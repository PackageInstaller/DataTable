-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinaljumpView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinaljumpView", package.seeall)

local MartialcontestfinaljumpView = class("MartialcontestfinaljumpView", ViewComponent)

function MartialcontestfinaljumpView:ctor()
	MartialcontestfinaljumpView.super.ctor(self)
end

function MartialcontestfinaljumpView:unbindEvents()
	MartialcontestfinaljumpView.super.unbindEvents(self)
	self._btnJump:RemoveClickListener()
end

function MartialcontestfinaljumpView:bindEvents()
	MartialcontestfinaljumpView.super.bindEvents(self)
	self._btnJump:AddClickListener(self._onClickbtnJump, self)
end

function MartialcontestfinaljumpView:buildUI()
	MartialcontestfinaljumpView.super.buildUI(self)

	self._txtName = self:getTxt("btnJump/TxtName")
	self._txtTime = self:getTxt("btnJump/imgTime/txtTime")
	self._btnJump = self:getBtn("btnJump")
end

function MartialcontestfinaljumpView:onExit()
	MartialcontestfinaljumpView.super.onExit(self)
	removetimer(self._tick, self)
end

function MartialcontestfinaljumpView:onEnter()
	MartialcontestfinaljumpView.super.onEnter(self)

	local msg = MartialContestModel.instance:getFinalsInfoMsg()

	if msg then
		local activityId = msg.activityId
		local stepId = msg.info.curStepId
		local stepCfg = MartialContestConfig.instance:getStepCfg(activityId, stepId)

		if stepCfg then
			local roundDesc = MartialContestController:getFinalsRoundDesc(activityId, stepId, stepCfg.roundId)

			self._txtName.text = string.format("比武争锋 %s", roundDesc)
		end
	end

	self._targetTime = 0

	local info = RedPointModel.instance:getRedPoingInfo(-490)

	if info and checknumber(info.endTime) > 0 then
		self._targetTime = math.floor(checknumber(info.endTime) / 1000)
	end

	if self._targetTime > 0 then
		settimer(1, self._tick, self, true)
	end
end

function MartialcontestfinaljumpView:_onClickbtnJump()
	GotoMgr.gotoByString("ui#martialcontestfinalview")
end

function MartialcontestfinaljumpView:_tick()
	local leftTime = self._targetTime - ServerTime.now()

	if leftTime <= 0 then
		leftTime = 0
	end

	if leftTime >= 3600 then
		local hour = math.floor(leftTime / 3600)
		local min = math.floor(leftTime % 3600 / 60)

		self._txtTime.text = string.format("准备剩余时间:%s小时%s分", hour, min)
	elseif leftTime >= 60 then
		local min = math.floor(leftTime / 60)
		local sec = leftTime % 60

		self._txtTime.text = string.format("准备剩余时间:%s分%s秒", min, sec)
	else
		self._txtTime.text = string.format("准备剩余时间:%s秒", leftTime)
	end
end

return MartialcontestfinaljumpView
