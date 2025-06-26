-- chunkname: @IQIGame\\UI\\Battle\\RoundBannerModeController.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.LabelPart1:GetComponent("TextMeshProUGUI").text = BattleRoundUIApi:GetString("RushModeLabelPart1")
	self.LabelPart2:GetComponent("TextMeshProUGUI").text = BattleRoundUIApi:GetString("RushModeLabelPart2")
	self.DescText:GetComponent("Text").text = BattleRoundUIApi:GetString("RushModeDescText")
end

function m:Play()
	self.View:SetActive(false)
	self.View:SetActive(true)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
