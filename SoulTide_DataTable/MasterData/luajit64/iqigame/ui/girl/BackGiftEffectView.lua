-- chunkname: @IQIGame\\UI\\Girl\\BackGiftEffectView.lua

local BackGiftEffectView = {}

function BackGiftEffectView.__New(ui)
	local o = Clone(BackGiftEffectView)

	o:InitView(ui)

	return o
end

function BackGiftEffectView:InitView(ui)
	self.goView = ui

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.tweenPosition = self.FlyEffect:GetComponent("TweenPosition")
	self.tweenSpeed = self.tweenPosition.duration
	self.startPos = self.StartPos.transform.anchoredPosition
	self.endPos = self.EndPos.transform.anchoredPosition

	function self.delegatePositionTween()
		self:OnFinishedTweenPosition()
	end
end

function BackGiftEffectView:OnFinishedTweenPosition()
	self.tweenPosition:RemoveOnFinished(self.delegatePositionTween)

	if self.flyEndCallBack then
		self.flyEndCallBack()
	end

	self:Close()
end

function BackGiftEffectView:AddEventListener()
	return
end

function BackGiftEffectView:RemoveEventListener()
	return
end

function BackGiftEffectView:Open()
	self:AddEventListener()

	self.FlyEffect.transform.anchoredPosition = self.startPos

	self.goView:SetActive(true)

	self.tweenPosition = TweenPosition.Begin(self.FlyEffect, self.tweenSpeed, self.endPos)

	self.tweenPosition:SetOnFinished(self.delegatePositionTween)
end

function BackGiftEffectView:Close()
	self.goView:SetActive(false)
	self:RemoveEventListener()
end

function BackGiftEffectView:Dispose()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.flyEndCallBack = nil
	self.goView = nil
end

return BackGiftEffectView
