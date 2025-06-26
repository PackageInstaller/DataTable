-- chunkname: @IQIGame\\UI\\Cooking\\CookFinishView.lua

local CookFinishView = {}

function CookFinishView.New(view, parentView)
	local obj = Clone(CookFinishView)

	obj:Init(view, parentView)

	return obj
end

function CookFinishView:Init(view, parentView)
	self.View = view
	self.parentView = parentView

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextFinish1, HomeLandCookingUIApi:GetString("TextFinish1"))

	self.btnGetFood = self.BtnGetFood:GetComponent("Button")

	function self.delegateBtnGetFood()
		self:OnBtnGetFood()
	end

	self:AddEventListener()
end

function CookFinishView:AddEventListener()
	self.btnGetFood.onClick:AddListener(self.delegateBtnGetFood)
end

function CookFinishView:RemoveEventListener()
	self.btnGetFood.onClick:RemoveListener(self.delegateBtnGetFood)
end

function CookFinishView:Open()
	self.View:SetActive(true)

	if self.parentView.queueData.cid ~= nil and self.parentView.queueData.cid ~= "" then
		local itemID = CfgCookCombinationTable[self.parentView.queueData.cid].ItemId[1]
		local itemData = CfgItemTable[itemID]

		UGUIUtil.SetText(self.TextItemName, itemData.Name)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemData.Icon), self.ItemIcon:GetComponent("Image"))
	else
		UGUIUtil.SetText(self.TextItemName, HomeLandCookingUIApi:GetString("TextItemName"))

		local path = HomeLandCookingUIApi:GetString("IconPath")

		AssetUtil.LoadImage(self, path, self.ItemIcon:GetComponent("Image"))
	end
end

function CookFinishView:OnBtnGetFood()
	HomeLandLuaModule.RewardCook(self.parentView.cfgBuildingID, self.parentView.queueData.id)
end

function CookFinishView:Close()
	self.View:SetActive(false)
end

function CookFinishView:Dispose()
	self:RemoveEventListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return CookFinishView
