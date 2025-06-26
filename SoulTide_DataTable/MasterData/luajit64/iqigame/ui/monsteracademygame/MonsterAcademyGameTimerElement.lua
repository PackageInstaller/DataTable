-- chunkname: @IQIGame\\UI\\MonsterAcademyGame\\MonsterAcademyGameTimerElement.lua

local m = {
	totalTime = 0,
	lastTime = 0,
	IsPaused = false
}

function m.New(viewRoot, api)
	local obj = Clone(m)

	obj:__Init(viewRoot, api)

	return obj
end

function m:__Init(viewRoot, api)
	self.ViewRoot = viewRoot
	self.langApi = api

	LuaCodeInterface.BindOutlet(self.ViewRoot, self)

	self.timeProcessImage = self.goProcessImage:GetComponent("UnityEngine.UI.Image")
	self.timeProcessText = self.goProcessText:GetComponent("UnityEngine.UI.Text")
	self.goProcessTitleText:GetComponent("UnityEngine.UI.Text").text = self.langApi:GetString("GetTimeCountDownTitleText")
end

function m:OnDestroy()
	self:StopTime()
	LuaCodeInterface.ClearOutlet(self.ViewRoot, self)

	self.ViewRoot = nil
	self.onTimeOverEvent = nil
end

function m:SetTotalTime(totalTime, overCall)
	self.totalTime = totalTime
	self.lastTime = totalTime
	self.IsPaused = false

	self:__RefreshTimeShow()

	self.onTimeOverEvent = overCall
end

function m:StartTime()
	self.IsPaused = false
	self.timer = Timer.New(function()
		self:__OnTimeCountDown()
	end, 1, -1)

	self.timer:Start()
end

function m:StopTime()
	if self.timer == nil then
		return
	end

	self.timer:Stop()

	self.timer = nil
end

function m:__OnTimeCountDown()
	if self.IsPaused then
		return
	end

	self.lastTime = self.lastTime - 1 > 0 and self.lastTime - 1 or 0

	self:__RefreshTimeShow()

	if self.lastTime == 0 then
		self:StopTime()
		self.onTimeOverEvent()
	end
end

function m:__RefreshTimeShow()
	self.timeProcessImage.fillAmount = self.lastTime / self.totalTime
	self.timeProcessText.text = self.langApi:GetString("GetTimeCountDownText", self.lastTime)
end

return m
