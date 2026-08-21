-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityMain\\FishingActivityMainEndView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function m:OnBtnClose()
	if self.OnCloseCallBack then
		self.OnCloseCallBack()
	end

	self:Close()
end

function m:SetData(success, data)
	self.Success:SetActive(success)
	self.Lose:SetActive(not success)
	UGUIUtil.SetText(self.TextEnd, FishingActivityMainUIApi:GetString("TextEnd", success))

	if success then
		local cfgFish = CfgFishActiveFishListTable[data.fishId]

		UGUIUtil.SetText(self.TextFishName, cfgFish.Name)
		UGUIUtil.SetText(self.TextWeight, FishingActivityMainUIApi:GetString("TextWeight", data.weight))
		UGUIUtil.SetText(self.TextPrice, FishingActivityMainUIApi:GetString("TextPrice", cfgFish.Price))
		UGUIUtil.SetText(self.TextRewardNum, math.floor(cfgFish.Price * data.weight / 1000))
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgFish.Icon), self.ImgFish:GetComponent("Image"))
	end
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	self:Close()

	self.OnCloseCallBack = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
