-- chunkname: @IQIGame\\UI\\Cooking\\HomeLandCookPanView.lua

local HomeLandCookPanView = {
	isPlayEffect = false
}
local CookPutOnEffect = require("IQIGame.UI.Cooking.CookPutOnEffect")

function HomeLandCookPanView.New(view)
	local obj = Clone(HomeLandCookPanView)

	obj:Init(view)

	return obj
end

function HomeLandCookPanView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegatePlayCookPutOnEffect(data)
		self:OnPlayCookEffect(data)
	end

	function self.delegateBtnMenu()
		self:OnBtnMenu()
	end

	self:AddListener()
end

function HomeLandCookPanView:AddListener()
	self.Ready:GetComponent("Button").onClick:AddListener(self.delegateBtnMenu)
	EventDispatcher.AddEventListener(EventID.PlayCookPutOnEffect, self.delegatePlayCookPutOnEffect)
end

function HomeLandCookPanView:RemoveListener()
	self.Ready:GetComponent("Button").onClick:RemoveListener(self.delegateBtnMenu)
	EventDispatcher.RemoveEventListener(EventID.PlayCookPutOnEffect, self.delegatePlayCookPutOnEffect)
end

function HomeLandCookPanView:UpdateSate(queueData)
	if self.time then
		self.time:Stop()
	end

	self.time = nil

	if self.putOnEffect then
		self.putOnEffect:Dispose()
	end

	self.putOnEffect = nil
	self.queueData = queueData

	if self.isPlayEffect then
		self:PlayEffect(queueData)
	else
		self.Ready:SetActive(false)
		self.Now:SetActive(false)
		self.Finish:SetActive(false)

		if self.queueData.status == 0 then
			self.Ready:SetActive(true)
		elseif self.queueData.status == 1 then
			self.Now:SetActive(true)
		elseif self.queueData.status == 2 then
			self.Finish:SetActive(true)
		end

		for i = 1, #self.queueData.items do
			local itemID = self.queueData.items[i]

			if itemID > 0 then
				local cfgItemData = CfgItemTable[itemID]

				if self["ImgNow" .. i] then
					AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self["ImgNow" .. i]:GetComponent("Image"))
				end
			end
		end
	end
end

function HomeLandCookPanView:ShowRewardIcon(menuData)
	self.menuData = menuData

	if menuData then
		local path
		local str = ""

		if menuData.unlock then
			local itemData = CfgItemTable[menuData.cfgInfo.ItemId[1]]

			str = itemData.Name
			path = UIGlobalApi.GetIconPath(itemData.Icon)
		end

		if self.ImgRewardNow then
			AssetUtil.LoadImage(self, path, self.ImgRewardNow:GetComponent("Image"))
		end

		if self.TextReward then
			UGUIUtil.SetText(self.TextReward, str)
		end
	end
end

function HomeLandCookPanView:OnPlayCookEffect(data)
	self.isPlayEffect = true
end

function HomeLandCookPanView:OnBtnMenu()
	UIModule.Open(Constant.UIControllerName.HomeLandCookingListUI, Constant.UILayer.UI, self.queueData)
end

function HomeLandCookPanView:PlayEffect(queueData)
	self.isPlayEffect = false

	local goEff = UnityEngine.Object.Instantiate(self.PutOnEffectMould)

	goEff.transform:SetParent(self.View.transform, false)

	self.putOnEffect = CookPutOnEffect.New(goEff)

	self.putOnEffect:UpdateSate(self.queueData)
	self.putOnEffect:ShowRewardIcon(self.menuData)
	goEff:SetActive(true)

	self.time = Timer.New(function()
		self.putOnEffect:Dispose()

		self.putOnEffect = nil

		self:UpdateSate(queueData)
	end, 3.5)

	self.time:Start()
end

function HomeLandCookPanView:Dispose()
	AssetUtil.UnloadAsset(self)

	if self.time then
		self.time:Stop()
	end

	self.time = nil

	self:RemoveListener()

	if self.putOnEffect then
		self.putOnEffect:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandCookPanView
