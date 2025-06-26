-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPlayerHeadCell.lua

local m = {
	IsSelect = false,
	Unlock = true,
	PlayerHeadAttrPool = {}
}
local AmusementParkAttrCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkAttrCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnSelf()
		self:OnBtnSelf()
	end

	self.PlayerHeadAttrPool = {}

	for i = 0, self.SoulAttrNode.transform.childCount - 1 do
		local obj = self.SoulAttrNode.transform:GetChild(i).gameObject
		local playerHeadAttrCell = AmusementParkAttrCell.New(obj)
		local attrID = AmusementParkModule.ParkPlayerAttr[i + 1]

		self.PlayerHeadAttrPool[attrID] = playerHeadAttrCell
	end

	self:SetSelect(false)
	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
end

function m:SetData(data, buildID, posData)
	self.ParkPlayerData = data
	self.BuildID = buildID
	self.PosData = posData

	self:UpdateView()
end

function m:UpdateView()
	self.EmptyNode:SetActive(self.ParkPlayerData == nil and self.Unlock)
	self.NormalNode:SetActive(self.ParkPlayerData ~= nil and self.Unlock)
	self.LockNode:SetActive(not self.Unlock)

	if self.ParkPlayerData then
		local path = UIGlobalApi.GetImagePath(self.ParkPlayerData:GetCfgData().HeadIcon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextLv, self.ParkPlayerData.parkRolePOD.level)
		UGUIUtil.SetText(self.TextName, self.ParkPlayerData:GetCfgData().Name)

		for i, v in pairs(self.PlayerHeadAttrPool) do
			local attrValue = self.ParkPlayerData:GetRoleAttrByAttrID(i)

			v:SetData(i, attrValue)
		end
	end
end

function m:SetSelect(top)
	self.IsSelect = top

	self.Select:SetActive(self.IsSelect)
end

function m:IsUnlock(top)
	self.Unlock = top

	self.LockNode:SetActive(not self.Unlock)
end

function m:SetUnlockLv(needBuildLV)
	UGUIUtil.SetText(self.TextLockCondition, AmusementParkMainUIApi:GetString("UnlockNeedBuildLv", needBuildLV))
end

function m:OnBtnSelf()
	if self.ClickCallBack then
		self.ClickCallBack(self.ParkPlayerData, self.BuildID, self.PosData)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.ClickCallBack = nil

	for i, v in pairs(self.PlayerHeadAttrPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
