-- chunkname: @IQIGame\\UI\\SoulEvolutionUI.lua

local SoulEvolutionUI = {}

SoulEvolutionUI = Base:Extend("SoulEvolutionUI", "IQIGame.Onigao.UI.SoulEvolutionUI", SoulEvolutionUI)

local SoulStarView = require("IQIGame.UI.SoulEvolution.SoulStarView")
local SoulAttTipView = require("IQIGame.UI.Soul.SoulAttTipView")

function SoulEvolutionUI:OnInit()
	self:Initialize()
end

function SoulEvolutionUI:GetPreloadAssetPaths()
	return nil
end

function SoulEvolutionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulEvolutionUI:IsManualShowOnOpen(userData)
	return false
end

function SoulEvolutionUI:GetBGM(userData)
	return nil
end

function SoulEvolutionUI:OnOpen(userData)
	self:Refresh(userData)
end

function SoulEvolutionUI:OnClose(userData)
	self:OnHide()
end

function SoulEvolutionUI:OnPause()
	return
end

function SoulEvolutionUI:OnResume()
	return
end

function SoulEvolutionUI:OnCover()
	return
end

function SoulEvolutionUI:OnReveal()
	return
end

function SoulEvolutionUI:OnRefocus(userData)
	return
end

function SoulEvolutionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulEvolutionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulEvolutionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulEvolutionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulEvolutionUI:Initialize()
	self.starView = SoulStarView.New(self.goStarView, self)
	self.attTipView = SoulAttTipView.New(self.goAttTipView, self)
	self.imgSoulHead = self.goBottomInfo.transform:Find("Image_Head"):GetComponent("Image")
	self.tfSoulName = self.goBottomInfo.transform:Find("Text_01"):GetComponent("Text")
	self.tfSoulEnglishName = self.goBottomInfo.transform:Find("Text_02"):GetComponent("Text")
	self.btnLeft = self.goBtnLeft:GetComponent("Button")
	self.btnRight = self.goBtnRight:GetComponent("Button")

	function self.onClickBtnLeftDelegate()
		self:OnClickBtnLeft()
	end

	function self.onClickBtnRightDelegate()
		self:OnClickBtnRight()
	end
end

function SoulEvolutionUI:Refresh(userData)
	self.soulData = userData[1]
	self.switchList = userData[2]

	for i, v in ipairs(self.switchList) do
		if v.soulCid == self.soulData.soulCid then
			self.curSoulIndex = i

			break
		end
	end

	self:RefreshMisc()
	self.starView:Open(self.soulData)
	self:RefreshTurnPageBtn()
end

function SoulEvolutionUI:OnHide()
	self.starView:OnHide()
	self.attTipView:OnHide()
end

function SoulEvolutionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.starView:OnDestroy()
	self.attTipView:OnDestroy()
end

function SoulEvolutionUI:OnAddListeners()
	self.btnLeft.onClick:AddListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:AddListener(self.onClickBtnRightDelegate)
end

function SoulEvolutionUI:OnRemoveListeners()
	self.btnLeft.onClick:RemoveListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:RemoveListener(self.onClickBtnRightDelegate)
end

function SoulEvolutionUI:OnClickBtnLeft()
	if self.curSoulIndex == 1 then
		return
	end

	self.curSoulIndex = self.curSoulIndex - 1
	self.curSoulIndex = math.max(0, self.curSoulIndex)

	self:RefreshTurnPageBtn()
	self:SwitchSoul()
end

function SoulEvolutionUI:OnClickBtnRight()
	if self.curSoulIndex == #self.switchList then
		return
	end

	self.curSoulIndex = self.curSoulIndex + 1
	self.curSoulIndex = math.min(self.curSoulIndex, #self.switchList)

	self:RefreshTurnPageBtn()
	self:SwitchSoul()
end

function SoulEvolutionUI:RefreshMisc()
	self.tfSoulName.text = SoulUIApi:GetString("goSoulName", self.soulData:GetCfgSoul().Name)
	self.tfSoulEnglishName.text = SoulUIApi:GetString("goSoulEnglishName", self.soulData:GetCfgSoul().EnglishName)

	local path = SoulUIApi:GetString("SoulHeadIcon", self.soulData.soulCid)

	if path ~= nil and path ~= "" then
		AssetUtil.LoadImage(self, path, self.imgSoulHead)
	end
end

function SoulEvolutionUI:RefreshTurnPageBtn()
	self.goBtnLeft:SetActive(self.curSoulIndex > 1)
	self.goBtnRight:SetActive(self.curSoulIndex < #self.switchList)
end

function SoulEvolutionUI:SwitchSoul()
	self:Refresh({
		self.switchList[self.curSoulIndex],
		self.switchList
	})
	EventDispatcher.Dispatch(EventID.SoulLeftRightSwitch, self.switchList[self.curSoulIndex], self.switchList)
end

return SoulEvolutionUI
