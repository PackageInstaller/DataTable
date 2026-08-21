-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamAttrSpeController.lua

local m = {
	IsShow = false,
	SoulCid = 0,
	AttrItems = {},
	FeatureItems = {}
}
local SoulAttrItem = require("IQIGame.UI.Soul.SoulAttrItem")
local SoulFeatureItem = require("IQIGame.UI.Soul.SoulFeatureItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickFeatureDetailBtn()
		self:OnClickFeatureDetailBtn()
	end

	local displayAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #displayAttrIds do
		local go = UnityEngine.Object.Instantiate(self.AttrItemPrefab)

		go.transform:SetParent(self.AttrGrid.transform, false)

		local item = SoulAttrItem.New(go, true)

		self.AttrItems[i] = item
	end

	for i = 1, 4 do
		local go = UnityEngine.Object.Instantiate(self.FeatureItemPrefab)

		go.transform:SetParent(self.FeatureGrid.transform, false)

		local item = SoulFeatureItem.New(go)

		self.FeatureItems[i] = item
	end

	UGUIUtil.SetText(self.FeatureDetailLabel, SoulUIApi:GetString("attTipViewTitle3"))
end

function m:SetData(dollPOD)
	self.SoulCid = dollPOD.soulCid

	local displayAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]
		local attrId = displayAttrIds[i]
		local attrValue = dollPOD.finalAttributes[attrId]

		item:SetData(attrId, attrValue)
	end

	local unlockFeatures, allFeatures, featureUnlockQuality = SoulModule.GetFeatures(dollPOD.soulCid, dollPOD.soulQualityCid)

	for i = 1, #self.FeatureItems do
		local item = self.FeatureItems[i]

		item:SetData(allFeatures[i], table.indexOf(unlockFeatures, allFeatures[i]) ~= -1, featureUnlockQuality[allFeatures[i]])
	end
end

function m:AddListeners()
	self.FeatureDetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFeatureDetailBtn)
end

function m:RemoveListeners()
	self.FeatureDetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFeatureDetailBtn)
end

function m:OnClickFeatureDetailBtn()
	UIModule.Open(Constant.UIControllerName.SoulEvolutionInfoUI, Constant.UILayer.UI, MazeDataModule.GetSoulData(self.SoulCid))
end

function m:Dispose()
	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]

		item:Dispose()
	end

	for i = 1, #self.FeatureItems do
		local item = self.FeatureItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
