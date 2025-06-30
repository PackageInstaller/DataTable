-- chunkname: @IQIGame\\UI\\Maze\\IllusionMazeEmotionBar.lua

local m = {
	OverloadValue = 0,
	OVERLOAD_UI_RATIO = 0.7,
	ParamId = 0
}

function m.New(view, paramId, overloadValue, iconSprite)
	local obj = Clone(m)

	obj:Init(view, paramId, overloadValue, iconSprite)

	return obj
end

function m:Init(view, paramId, overloadValue, iconSprite)
	self.View = view
	self.ParamId = paramId
	self.OverloadValue = overloadValue

	LuaCodeInterface.BindOutlet(self.View, self)

	self.EmotionIcon:GetComponent("Image").sprite = iconSprite
end

function m:UpdateBar()
	local isOverload, overloadRatio = self:IsOverload()
	local barRatio = math.min(overloadRatio * m.OVERLOAD_UI_RATIO, 1)

	self.NormalBar:SetActive(not isOverload)
	self.OverloadBar:SetActive(isOverload)

	if not isOverload then
		self.NormalBar:GetComponent("Image").fillAmount = barRatio
	else
		self.OverloadBar:GetComponent("Image").fillAmount = barRatio
	end
end

function m:IsOverload()
	local paramValue = MazeDataModule.PlayerInfo.PlayerParams[self.ParamId] or 0
	local overloadRatio = paramValue / self.OverloadValue

	return overloadRatio >= 1, overloadRatio
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
