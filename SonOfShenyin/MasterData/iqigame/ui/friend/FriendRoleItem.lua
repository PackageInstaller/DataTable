-- chunkname: @IQIGame\\UI\\Friend\\FriendRoleItem.lua

local m = {
	isSelf = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateFindRoleDetail()
		self:FindRoleDetail()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateFindRoleDetail)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateFindRoleDetail)
end

function m:SetData(data)
	self.heroData = data

	local cfgdata = CfgHeroTable[data.cid]

	self.Name = cfgdata.Name
	self.Lv = data.lv

	local path

	if self.heroData.skin ~= nil then
		path = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(self.heroData.skin[Constant.SkinType.StaticImage].skinCid, Constant.SkinImageType.HeroResourcesHead)
	else
		path = SkinModule.GetHeroCurrentSkinImgPath(data.cid, Constant.SkinImageType.HeroResourcesHead)
	end

	AssetUtil.LoadImage(self, path, self.RoleImg:GetComponent("Image"))
	self:RefreshData()
end

function m:RefreshData()
	self.RoleName:GetComponent("Text").text = self.Name
	self.RoleLevel:GetComponent("Text").text = "Lv" .. self.Lv
end

function m:FindRoleDetail()
	PlayerModule.GetHeroInfoAndOpenRoleDetailsUI(self.heroData.pid, self.heroData.serverId, self.heroData.cid)
end

function m:SetViewState(state)
	self.View:SetActive(state)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
