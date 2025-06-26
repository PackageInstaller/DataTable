-- chunkname: @IQIGame\\UI\\CommandChallenge\\CommandChallengeFormationCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(formationID)
	self.formationID = formationID

	self:UpdateView()
end

function m:UpdateView()
	self.NotNull:SetActive(self.formationID ~= nil)
	self.Null:SetActive(self.formationID == nil)

	if self.formationID then
		local cfgSoulPrefabData = CfgSoulPrefabDataTable[self.formationID]

		self.TagFront:SetActive(cfgSoulPrefabData.Position == 1)
		self.TagBehind:SetActive(cfgSoulPrefabData.Position == 2)

		local cfgDressData3D = CfgDressTable[cfgSoulPrefabData.Dress2DCid]
		local cfgSoulResData = CfgSoulResTable[cfgDressData3D.SoulResID]
		local path = UIGlobalApi.GetImagePath(cfgSoulResData.HeadIcon)

		AssetUtil.LoadImage(self, path, self.ImgSoulHead:GetComponent("Image"))
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
