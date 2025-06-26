-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPlayer\\AmusementParkPlayerRecruitCell.lua

local m = {
	PlayerAttrPool = {}
}
local AmusementParkPlayerData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkPlayerData")
local AmusementParkAttrRender = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayer.AmusementParkAttrRender")

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

	self.PlayerAttrPool = {}

	for i = 0, self.AttSort.transform.childCount - 1 do
		local obj = self.AttSort.transform:GetChild(i).gameObject
		local playerAttrCell = AmusementParkAttrRender.New(obj)
		local attrID = AmusementParkModule.ParkPlayerAttr[i + 1]

		self.PlayerAttrPool[attrID] = playerAttrCell
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnRest:GetComponent("Button").onClick:AddListener(self.DelegateBtnRest)
end

function m:RemoveListener()
	self.BtnRest:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRest)
end

function m:SetData(data)
	self.PlayerData = AmusementParkPlayerData.New(data.id, data)

	self:UpDateView()
end

function m:UpDateView()
	if self.PlayerData then
		local path = UIGlobalApi.GetImagePath(self.PlayerData:GetCfgData().Bust)

		AssetUtil.LoadImage(self, path, self.ImgHead:GetComponent("Image"))
		UGUIUtil.SetText(self.TextSoulName, self.PlayerData:GetCfgData().Name)
		UGUIUtil.SetText(self.TextSoulLv, AmusementParkPlayerUIApi:GetString("TextSoulLv", self.PlayerData.parkRolePOD.level))

		for i, v in pairs(self.PlayerAttrPool) do
			local attrValue = self.PlayerData:GetRoleAttrByAttrID(i)

			v:SetData(i, attrValue)
		end
	end
end

function m:OnBtnRest()
	AmusementParkModule.Recruit(self.PlayerData.cid)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.PlayerAttrPool) do
		v:Dispose()
	end

	self.PlayerData = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
