-- chunkname: @IQIGame\\UI\\LunaBattleLine\\DetailUI\\LunaBattleGarrisonNoticeItem.lua

local m = {
	MoveDuration = 0.3,
	AlphaStayDuration = 2.5,
	FadeDuration = 3
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.CanvasGroup = self.View:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function m:OnUpdate()
	if not self.Playing then
		return
	end

	local elapsedTime = UnityEngine.Time.realtimeSinceStartup - self.StartMoveTime
	local moveLerpValue = math.min(elapsedTime / self.MoveDuration, 1)
	local anchoredPosition = self.View.transform.anchoredPosition

	anchoredPosition.y = self.StartY + (self.TargetY - self.StartY) * moveLerpValue
	self.View.transform.anchoredPosition = anchoredPosition
	elapsedTime = UnityEngine.Time.realtimeSinceStartup - self.StartFadeTime

	local fadeLerpValue = math.min(math.max(elapsedTime - self.AlphaStayDuration, 0) / (self.FadeDuration - self.AlphaStayDuration), 1)

	self.CanvasGroup.alpha = 1 - fadeLerpValue

	if moveLerpValue >= 1 and fadeLerpValue >= 1 then
		self:ClearTweenData()
	end
end

function m:SetData(pName, soulCid)
	local cfgSoulData = CfgSoulTable[soulCid]

	UGUIUtil.SetText(self.Text, LunaBattleLineDetailUIApi:GetString("GarrisonNoticeText", pName, cfgSoulData.Name))
end

function m:Play(addY, startY)
	self.Playing = true
	self.TargetY = self.View.transform.anchoredPosition.y + addY
	self.StartMoveTime = UnityEngine.Time.realtimeSinceStartup

	if self.StartFadeTime == nil then
		self.StartFadeTime = UnityEngine.Time.realtimeSinceStartup
	end

	if startY ~= nil then
		self.View.transform.anchoredPosition = Vector2(0, startY)
	end

	self.StartY = self.View.transform.anchoredPosition.y
end

function m:GetHeight()
	return self.View.transform.sizeDelta.y
end

function m:ClearTweenData()
	self.Playing = false
	self.TargetY = nil
	self.StartY = nil
	self.StartMoveTime = nil
	self.StartFadeTime = nil
end

function m:Reset()
	self.CanvasGroup.alpha = 1
	self.View.transform.anchoredPosition = Vector2.zero

	self:ClearTweenData()
end

function m:IsMoveComplete()
	return UnityEngine.Time.realtimeSinceStartup - self.StartMoveTime >= self.MoveDuration
end

function m:IsExpired()
	return not self.Playing
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CanvasGroup = nil
end

return m
