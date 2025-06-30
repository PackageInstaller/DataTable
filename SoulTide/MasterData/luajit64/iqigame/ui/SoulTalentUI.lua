-- chunkname: @IQIGame\\UI\\SoulTalentUI.lua

local SoulTalentUI = {}

SoulTalentUI = Base:Extend("SoulTalentUI", "IQIGame.Onigao.UI.SoulTalentUI", SoulTalentUI)

local SoulTalentView = require("IQIGame.UI.SoulTalent.SoulTalentView")
local SoulAttTipView = require("IQIGame.UI.Soul.SoulAttTipView")

function SoulTalentUI:OnInit()
	self:Initialize()
end

function SoulTalentUI:GetPreloadAssetPaths()
	return nil
end

function SoulTalentUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulTalentUI:IsManualShowOnOpen(userData)
	return false
end

function SoulTalentUI:GetBGM(userData)
	return nil
end

function SoulTalentUI:OnOpen(userData)
	self:Refresh(userData)
end

function SoulTalentUI:OnClose(userData)
	self:OnHide()
end

function SoulTalentUI:OnPause()
	return
end

function SoulTalentUI:OnResume()
	return
end

function SoulTalentUI:OnCover()
	return
end

function SoulTalentUI:OnReveal()
	return
end

function SoulTalentUI:OnRefocus(userData)
	return
end

function SoulTalentUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.talentView ~= nil then
		self.talentView:OnUpdate(elapseSeconds, realElapseSeconds)
	end
end

function SoulTalentUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulTalentUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulTalentUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulTalentUI:Initialize()
	self.talentView = SoulTalentView.New(self.goTalentView, self)
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

function SoulTalentUI:Refresh(userData)
	self.soulData = userData[1]
	self.switchList = userData[2]

	for i, v in ipairs(self.switchList) do
		if v.soulCid == self.soulData.soulCid then
			self.curSoulIndex = i

			break
		end
	end

	self:RefreshMisc()
	self.talentView:Open(self.soulData)
	self:RefreshTurnPageBtn()
end

function SoulTalentUI:OnHide()
	self.talentView:OnHide()
	self.attTipView:OnHide()
end

function SoulTalentUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.talentView:OnDestroy()
	self.attTipView:OnDestroy()
end

function SoulTalentUI:OnAddListeners()
	self.btnLeft.onClick:AddListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:AddListener(self.onClickBtnRightDelegate)
end

function SoulTalentUI:OnRemoveListeners()
	self.btnLeft.onClick:RemoveListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:RemoveListener(self.onClickBtnRightDelegate)
end

function SoulTalentUI:OnClickBtnLeft()
	if self.curSoulIndex == 1 then
		return
	end

	self.curSoulIndex = self.curSoulIndex - 1
	self.curSoulIndex = math.max(0, self.curSoulIndex)

	self:RefreshTurnPageBtn()
	self:SwitchSoul()
end

function SoulTalentUI:OnClickBtnRight()
	if self.curSoulIndex == #self.switchList then
		return
	end

	self.curSoulIndex = self.curSoulIndex + 1
	self.curSoulIndex = math.min(self.curSoulIndex, #self.switchList)

	self:RefreshTurnPageBtn()
	self:SwitchSoul()
end

function SoulTalentUI:RefreshMisc()
	self.tfSoulName.text = SoulUIApi:GetString("goSoulName", self.soulData:GetCfgSoul().Name)
	self.tfSoulEnglishName.text = SoulUIApi:GetString("goSoulEnglishName", self.soulData:GetCfgSoul().EnglishName)

	local path = SoulUIApi:GetString("SoulHeadIcon", self.soulData.soulCid)

	if path ~= nil and path ~= "" then
		AssetUtil.LoadImage(self, path, self.imgSoulHead)
	end
end

function SoulTalentUI:RefreshTurnPageBtn()
	self.goBtnLeft:SetActive(self.curSoulIndex > 1)
	self.goBtnRight:SetActive(self.curSoulIndex < #self.switchList)
end

function SoulTalentUI:SwitchSoul()
	self:Refresh({
		self.switchList[self.curSoulIndex],
		self.switchList
	})
	EventDispatcher.Dispatch(EventID.SoulLeftRightSwitch, self.switchList[self.curSoulIndex], self.switchList)
end

return SoulTalentUI
