-- chunkname: @IQIGame\\UI\\PlaceGamePlayerSkillUI.lua

local PlaceGamePlayerSkillUI = {}

PlaceGamePlayerSkillUI = Base:Extend("PlaceGamePlayerSkillUI", "IQIGame.Onigao.UI.PlaceGamePlayerSkillUI", PlaceGamePlayerSkillUI)

require("IQIGame.UIExternalApi.PlaceGamePlayerSkillUIApi")

local PlaceGamePlayerSkillView = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerSkill.PlaceGamePlayerSkillView")

function PlaceGamePlayerSkillUI:OnInit()
	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateBtnRight()
		self:OnBtnRight()
	end

	function self.DelegateBtnLeft()
		self:OnBtnLeft()
	end

	self.placeGamePlayerSkillView = PlaceGamePlayerSkillView.New(self.goSkillView)
end

function PlaceGamePlayerSkillUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGamePlayerSkillUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGamePlayerSkillUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGamePlayerSkillUI:GetBGM(userData)
	return nil
end

function PlaceGamePlayerSkillUI:OnOpen(userData)
	self.placeGameSoulList = userData.PlaceGameSoulList
	self.selectPlaceGameSoulData = userData.SelectPlaceGameSoul

	for i = 1, #self.placeGameSoulList do
		if self.placeGameSoulList[i].cid == self.selectPlaceGameSoulData.cid then
			self.index = i

			break
		end
	end

	self:UpdateView()
end

function PlaceGamePlayerSkillUI:OnClose(userData)
	return
end

function PlaceGamePlayerSkillUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.DelegateBtnRight)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.DelegateBtnLeft)
end

function PlaceGamePlayerSkillUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRight)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnLeft)
end

function PlaceGamePlayerSkillUI:OnPause()
	return
end

function PlaceGamePlayerSkillUI:OnResume()
	return
end

function PlaceGamePlayerSkillUI:OnCover()
	return
end

function PlaceGamePlayerSkillUI:OnReveal()
	return
end

function PlaceGamePlayerSkillUI:OnRefocus(userData)
	return
end

function PlaceGamePlayerSkillUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGamePlayerSkillUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGamePlayerSkillUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGamePlayerSkillUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGamePlayerSkillUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.placeGamePlayerSkillView:Dispose()
end

function PlaceGamePlayerSkillUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function PlaceGamePlayerSkillUI:OnBtnRight()
	if self.index < #self.placeGameSoulList then
		self.index = self.index + 1
		self.selectPlaceGameSoulData = self.placeGameSoulList[self.index]

		self:RefreshSelectSoul()
	end
end

function PlaceGamePlayerSkillUI:OnBtnLeft()
	if self.index > 1 then
		self.index = self.index - 1
		self.selectPlaceGameSoulData = self.placeGameSoulList[self.index]

		self:RefreshSelectSoul()
	end
end

function PlaceGamePlayerSkillUI:RefreshSelectSoul()
	self.BtnLeft:SetActive(self.index > 1)
	self.BtnRight:SetActive(self.index < #self.placeGameSoulList)
	UGUIUtil.SetText(self.TextName, self.selectPlaceGameSoulData:GetCfgPlaceGameSoulData().Name)
	UGUIUtil.SetText(self.TextEngName, self.selectPlaceGameSoulData:GetCfgSoulData().EnglishName)

	local path = PlaceGamePlayerSkillUIApi:GetString("SoulHeadIcon", self.selectPlaceGameSoulData:GetCfgPlaceGameSoulData().SoulID)

	AssetUtil.LoadImage(self, path, self.ImgSoulHead:GetComponent("Image"))
	self.placeGamePlayerSkillView:SetData(self.selectPlaceGameSoulData)
end

function PlaceGamePlayerSkillUI:UpdateView()
	self:RefreshSelectSoul()
end

return PlaceGamePlayerSkillUI
