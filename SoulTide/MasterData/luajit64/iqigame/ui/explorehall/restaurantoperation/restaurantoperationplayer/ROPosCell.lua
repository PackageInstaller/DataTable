-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationPlayer\\ROPosCell.lua

local m = {
	unlock = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnRest()
		self:OnBtnRest()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnRest:GetComponent("Button").onClick:AddListener(self.DelegateBtnRest)
end

function m:RemoveListener()
	self.BtnRest:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRest)
end

function m:SetData(type, position, unlock, player)
	self.type = type
	self.position = position
	self.unlock = unlock
	self.playerInformation = player

	self:UpdateView()
end

function m:UpdateView()
	self.Normal:SetActive(self.unlock and self.playerInformation.id > 0)
	self.Empty:SetActive(self.unlock and self.playerInformation.id == 0)
	self.Locked:SetActive(not self.unlock)

	if self.playerInformation and self.playerInformation.id and self.playerInformation.id > 0 then
		local path = UIGlobalApi.GetImagePath(CfgRestaurantOperationPlayerTable[self.playerInformation.id].Bust)

		AssetUtil.LoadImage(self, path, self.ImgHead:GetComponent("Image"))

		local mainAttr = CfgRestaurantOperationPostControlTable[self.type].MainAtt
		local value = self.playerInformation.att[mainAttr]

		UGUIUtil.SetText(self.TextMainAttr, RestaurantOperationPlayerUIApi:GetString("TextMainAttr", CfgRestaurantOperationAttributeTable[mainAttr].AttName, value))
	end

	local des = CfgRestaurantOperationPostControlTable[self.type].PostUnlockDesc[self.position]

	des = des or ""

	UGUIUtil.SetText(self.TextCondition, des)
end

function m:OnBtnRest()
	RestaurantOperationModule.Work(self.playerInformation.id, self.playerInformation.postType, self.playerInformation.location, 2)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
