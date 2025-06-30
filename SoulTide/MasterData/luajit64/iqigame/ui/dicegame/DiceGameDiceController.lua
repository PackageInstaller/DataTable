-- chunkname: @IQIGame\\UI\\DiceGame\\DiceGameDiceController.lua

local m = {
	IsSelect = false
}
local DiceRotationGenerator = require("IQIGame.UI.DiceGame.DiceRotationGenerator")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetActive(value)
	self.View:SetActive(value)
end

function m:SetPoint(point)
	local x, y, z = DiceRotationGenerator.GetEulerByNum(point)
	local rotation = Quaternion.Euler(x, y, z)

	self.DiceCore.transform.localRotation = rotation
end

function m:Play(point)
	self:SetPoint(point)
	UIUtil.PlayDefaultAnim(self.AnimationRoot)
end

function m:SetSelect(value)
	self.IsSelect = value

	self.SelectEffect:SetActive(value)
end

function m:SetSortingOrder(order)
	setRendererSortingOrder(self.View, order)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
