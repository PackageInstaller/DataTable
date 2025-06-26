-- chunkname: @IQIGame\\UI\\GlobalNotice\\RollNoticeElement.lua

local RollNoticeElement = {
	step = 0,
	scrollSpeed = 100
}

function RollNoticeElement.New(view)
	local obj = Clone(RollNoticeElement)

	obj:__Init(view)

	return obj
end

function RollNoticeElement:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.contentRectTrans = self.ContentText.gameObject:GetComponent("RectTransform")

	local rectTrans = self.MaskRoot.gameObject:GetComponent("RectTransform")

	self.contentWidth = rectTrans.rect.w
	self.scrollSpeed = UIGlobalApi.GetRollNoticeScrollSpeed()
end

function RollNoticeElement:Show(noticeData, completeCall)
	self:__StopCountdown()

	self.__completeCall = completeCall

	LuaCodeInterface.SetGameObjectShow(self.gameObject, true)

	self.contentRectTrans.anchoredPosition = Vector2.New(10, 0)
	self.ContentText:GetComponent("Text").text = noticeData.content

	self:__ChangeStep(1)
	self:__StarCountdown()
end

function RollNoticeElement:Replay()
	LuaCodeInterface.SetGameObjectShow(self.gameObject, true)
	self:__ChangeStep(2)
	self:__StarCountdown()
end

function RollNoticeElement:__StarCountdown()
	self.__showTimer = Timer.New(function()
		self:__ChangeStep(0)

		if self.__completeCall == nil then
			return
		end

		self.__completeCall()
	end, UIGlobalApi.GetRollNoticeDurationTime())

	self.__showTimer:Start()
end

function RollNoticeElement:__StopCountdown()
	if self.__showTimer == nil then
		return
	end

	self.__showTimer:Stop()

	self.__showTimer = nil
end

function RollNoticeElement:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.step == 0 then
		return
	end

	if self.step == 1 then
		self:__OnPrepare()
	elseif self.step == 2 then
		self:__OnScroll()
	end
end

function RollNoticeElement:__ChangeStep(step)
	if step == 0 then
		self:Hide()
	elseif step == 1 then
		self.deltaTime = 0
	elseif step == 2 then
		self.contentRectTrans.anchoredPosition = Vector2.New(10, 0)
	end

	self.step = step
end

function RollNoticeElement:__OnPrepare()
	self.deltaTime = self.deltaTime + Time.unscaledDeltaTime

	if self.deltaTime < 0.5 then
		return
	end

	self.maxMoveDis = (self.contentRectTrans.rect.w + self.contentWidth) * -1

	self:__ChangeStep(2)
end

function RollNoticeElement:__OnScroll()
	local moveAmount = self.scrollSpeed * Time.unscaledDeltaTime
	local newPos = self.contentRectTrans.anchoredPosition

	newPos.x = newPos.x - moveAmount
	self.contentRectTrans.anchoredPosition = newPos

	if newPos.x > self.maxMoveDis then
		return
	end

	self:__ChangeStep(2)
end

function RollNoticeElement:Hide()
	self:__StopCountdown()
	LuaCodeInterface.SetGameObjectShow(self.gameObject, false)
end

function RollNoticeElement:Dispose()
	self:__StopCountdown()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return RollNoticeElement
