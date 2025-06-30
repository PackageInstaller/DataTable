-- chunkname: @IQIGame\\UI\\Lottery\\LotteryCardPoolView\\LotteryCardPoolView.lua

local LotteryCardPoolView = {
	cardJackpotID = 0
}

function LotteryCardPoolView:Init(view)
	self.view = view

	self.view.gameObject:SetActive(false)
	LuaCodeInterface.BindOutlet(self.view, self)

	self.animationCom = self.animNode.gameObject:GetComponent(typeof(UnityEngine.Animation))

	if self.animationCom == nil then
		logError("抽卡模板界面预制体错误，为正确绑定 动画组件 ‘AnimNode ’")
	end

	self:__Init()
end

function LotteryCardPoolView:__Init()
	return
end

function LotteryCardPoolView:Show(cardJackpotID, playAnim, animCallback)
	self.cardJackpotID = cardJackpotID

	self.view.gameObject:SetActive(true)
	self:__Show()

	if not playAnim then
		return
	end

	self:PlayAnim("LotteryUI_Mould_In", function()
		if animCallback ~= nil then
			animCallback()
		end
	end)
end

function LotteryCardPoolView:__Show()
	return
end

function LotteryCardPoolView:Hide(playAnim, callback)
	if not playAnim then
		self.view.gameObject:SetActive(false)

		return
	end

	if not self.view.gameObject.activeSelf then
		return
	end

	self:PlayAnim("LotteryUI_Mould_Out", function()
		self:__Hide()
		self.view.gameObject:SetActive(false)

		if callback ~= nil then
			callback()
		end
	end)
end

function LotteryCardPoolView:__Hide()
	return
end

function LotteryCardPoolView:Dispose()
	self:__ClearAnimTimer()
	self:__Dispose()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

function LotteryCardPoolView:__Dispose()
	return
end

function LotteryCardPoolView:__PlayAnim(animName)
	self.animationCom:Play(animName)
end

function LotteryCardPoolView:PlayAnim(animName, callback)
	self.animationCom:Play(animName)

	local function __frameUpdate()
		if self.animationCom.isPlaying then
			return
		end

		self:__ClearAnimTimer()

		if callback ~= nil then
			callback()
		end
	end

	self.animTimer = FrameTimer.New(__frameUpdate, 1, -1)

	self.animTimer:Start()
end

function LotteryCardPoolView:__ClearAnimTimer()
	if self.animTimer == nil then
		return
	end

	self.animTimer:Stop()

	self.animTimer = nil
end

function LotteryCardPoolView:__ClearHideTimer()
	if self.hideTimer == nil then
		return
	end

	self.hideTimer:Stop()

	self.hideTimer = nil
end

return LotteryCardPoolView
