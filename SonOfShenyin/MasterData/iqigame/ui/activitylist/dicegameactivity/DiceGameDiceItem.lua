-- chunkname: @IQIGame\\UI\\ActivityList\\DiceGameActivity\\DiceGameDiceItem.lua

local DiceGameDiceItem = {}
local DiceRotationGenerator = require("IQIGame/UI/ActivityList/DiceGameActivity/DiceRotationGenerator")

function DiceGameDiceItem.New(go, mainView)
	local o = Clone(DiceGameDiceItem)

	o:Initialize(go, mainView)

	return o
end

function DiceGameDiceItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function DiceGameDiceItem:InitComponent()
	return
end

function DiceGameDiceItem:InitDelegate()
	return
end

function DiceGameDiceItem:AddListener()
	return
end

function DiceGameDiceItem:RemoveListener()
	return
end

function DiceGameDiceItem:Refresh(point)
	self.point = point

	local x, y, z = DiceRotationGenerator.GetEulerByNum(point)
	local rotation = Quaternion.Euler(x, y, z)

	self.DiceCore.transform.localRotation = rotation
end

function DiceGameDiceItem:PlayRollAnimation()
	LuaUtility.PlayAnimation(self.AnimationRoot, "UI_MazeJudge_Dice_Again")
end

function DiceGameDiceItem:SetSortingOrder(order)
	LuaUtility.SetRendererSortingOrder(self.gameObject, order)
end

function DiceGameDiceItem:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return DiceGameDiceItem
