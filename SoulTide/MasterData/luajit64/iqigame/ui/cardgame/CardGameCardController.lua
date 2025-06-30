-- chunkname: @IQIGame\\UI\\CardGame\\CardGameCardController.lua

local m = {
	IsSelect = false,
	YRange = 2,
	RevealAnimationLength = 0,
	Style = 0,
	Index = 0,
	TimeRatio = 0
}

function m.New(view, index, uiController, onClick)
	local obj = Clone(m)

	obj:Init(view, index, uiController, onClick)

	return obj
end

function m:Init(view, index, uiController, onClick)
	self.View = view
	self.Index = index
	self.UIController = uiController
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	self.AnimationCurveController = self.View:GetComponent("AnimationCurveController")

	self:CalcRevealAnimationLength()
	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
end

function m:SetData(iconPath, name, style)
	self.Style = style

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(iconPath), self.Icon:GetComponent("Image"))
	self.SuccessView:SetActive(style == 1)
	self.FailView:SetActive(style ~= 1)

	if style == 1 then
		UGUIUtil.SetTextInChildren(self.SuccessView, name)
	else
		UGUIUtil.SetTextInChildren(self.FailView, name)
	end
end

function m:MoveTo(fromPos, toPos, timeRatio, direction)
	self.TimeRatio = timeRatio

	local xCurve = self.AnimationCurveController.animationCurves[0]
	local yCurve = self.AnimationCurveController.animationCurves[1]
	local xRatio = xCurve:Evaluate(timeRatio)
	local yRatio = yCurve:Evaluate(timeRatio)
	local pos = self.View.transform.position

	pos.x = fromPos.x + (toPos.x - fromPos.x) * xRatio
	pos.y = fromPos.y + m.YRange * yRatio * direction
	self.View.transform.position = pos
end

function m:OnClickSelf()
	self.OnClickCallback(self.Index)
end

function m:SetSelect(value)
	if self.IsSelect == value then
		return
	end

	self.IsSelect = value

	if value then
		UIUtil.PlayDefaultAnim(self.View)
	else
		UIUtil.StopAnimationAt(self.View, 0)
	end
end

function m:CalcRevealAnimationLength()
	local animation = self.BackView:GetComponent(typeof(UnityEngine.Animation))
	local enumerator = animation:GetEnumerator()

	while enumerator:MoveNext() do
		local animationState = enumerator.Current

		self.RevealAnimationLength = animationState.length

		break
	end
end

function m:Reveal(immediately)
	self.IsRevealed = true

	self:StopTimer()

	if immediately then
		UIUtil.StopAnimationAt(self.BackView, 1)
	else
		UIUtil.PlayOrRewindDefaultAnim(self.BackView, false)

		self.ResultEffectTimer = Timer.New(function()
			self.ResultEffectTimer = nil

			GameEntry.Effect:PlayUIEffect(self.Style == 1 and 9001901 or 9001908, self.View.transform.position, self.UIController:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder + 1)
		end, CardGameUIApi:GetString("ResultEffectDelay"))

		self.ResultEffectTimer:Start()
	end
end

function m:Cover(immediately)
	if not self.IsRevealed then
		return
	end

	self.IsRevealed = false

	self:StopTimer()

	if immediately then
		UIUtil.StopAnimationAt(self.BackView, 0)
	else
		UIUtil.PlayOrRewindDefaultAnim(self.BackView, true)
	end
end

function m:StopTimer()
	if self.ResultEffectTimer ~= nil then
		self.ResultEffectTimer:Stop()

		self.ResultEffectTimer = nil
	end
end

function m:Dispose()
	self:StopTimer()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.AnimationCurveController = nil
	self.OnClickCallback = nil
	self.UIController = nil
end

return m
