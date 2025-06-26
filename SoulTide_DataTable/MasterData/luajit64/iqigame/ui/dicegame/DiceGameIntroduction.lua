-- chunkname: @IQIGame\\UI\\DiceGame\\DiceGameIntroduction.lua

local m = {
	TargetDiceImages = {},
	GroupItems = {}
}
local DiceGameIntroductionGroupItem = require("IQIGame.UI.DiceGame.DiceGameIntroductionGroupItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 5 do
		local image = self.TargetGrid.transform:Find("Image_" .. i):GetComponent("Image")

		self.TargetDiceImages[i] = image
	end

	local groupNames = DiceGameUIApi:GetString("GroupNames")
	local groupDescriptions = DiceGameUIApi:GetString("GroupDescriptions")
	local groupPoints = DiceGameUIApi:GetString("GroupPoints")

	for i = 1, #groupNames do
		local go = UnityEngine.Object.Instantiate(self.DiceGroupItemPrefab)

		go.transform:SetParent(self.DiceGroupGrid.transform, false)

		local item = DiceGameIntroductionGroupItem.New(go)

		item:SetData(groupNames[i], groupDescriptions[i], groupPoints[i])

		self.GroupItems[i] = item
	end

	UGUIUtil.SetText(self.TargetLabel, DiceGameUIApi:GetString("IntroductionTargetLabel"))
	UGUIUtil.SetText(self.WinConditionLabel, DiceGameUIApi:GetString("IntroductionWinConditionLabel"))
	UGUIUtil.SetText(self.DiceGroupLabel, DiceGameUIApi:GetString("IntroductionDiceGroupLabel"))
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(cfgMazeJudgeData)
	for i = 1, #self.TargetDiceImages do
		local image = self.TargetDiceImages[i]
		local point = cfgMazeJudgeData.TargetPoints[i]

		AssetUtil.LoadImage(self, DiceGameUIApi:GetString("DiceImagePath", point), image)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.GroupItems do
		local item = self.GroupItems[i]

		item:Dispose()
	end

	for i = 1, #self.TargetDiceImages do
		self.TargetDiceImages[i] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
