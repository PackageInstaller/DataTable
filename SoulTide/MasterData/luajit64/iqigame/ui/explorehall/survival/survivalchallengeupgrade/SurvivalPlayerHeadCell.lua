-- chunkname: @IQIGame\\UI\\ExploreHall\\Survival\\SurvivalChallengeUpgrade\\SurvivalPlayerHeadCell.lua

local m = {}

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

	self:AddListener()
	self:SetSelect(false)
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
end

function m:SetData(playerData)
	self.playerData = playerData

	local path = UIGlobalApi.GetImagePath(self.playerData:GetConfigData().HeadIcon)

	AssetUtil.LoadImage(self, path, self.PlayerIcon:GetComponent("Image"))
end

function m:SetSelect(top)
	self.ImgSelect:SetActive(top)
end

function m:SetRedPoint(top)
	return
end

function m:OnBtnSelf()
	if self.clickSelfCallBack then
		self.clickSelfCallBack(self.playerData)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.clickSelfCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
