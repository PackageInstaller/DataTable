-- chunkname: @IQIGame\\UI\\SoulSkillUI.lua

local SoulSkillUI = {}

SoulSkillUI = Base:Extend("SoulSkillUI", "IQIGame.Onigao.UI.SoulSkillUI", SoulSkillUI)

local SoulSkillView = require("IQIGame.UI.SoulSkill.SoulSkillView")

function SoulSkillUI:OnInit()
	self:Initialize()
end

function SoulSkillUI:GetPreloadAssetPaths()
	return nil
end

function SoulSkillUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulSkillUI:IsManualShowOnOpen(userData)
	return false
end

function SoulSkillUI:GetBGM(userData)
	return nil
end

function SoulSkillUI:OnOpen(userData)
	self:Refresh(userData)
end

function SoulSkillUI:OnClose(userData)
	self:OnHide()
end

function SoulSkillUI:OnPause()
	return
end

function SoulSkillUI:OnResume()
	return
end

function SoulSkillUI:OnCover()
	return
end

function SoulSkillUI:OnReveal()
	return
end

function SoulSkillUI:OnRefocus(userData)
	return
end

function SoulSkillUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulSkillUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulSkillUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulSkillUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulSkillUI:Initialize()
	self.skillView = SoulSkillView.New(self.goSkillView, self)
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

function SoulSkillUI:Refresh(userData)
	self.soulData = userData[1]
	self.switchList = userData[2]

	for i, v in ipairs(self.switchList) do
		if v.soulCid == self.soulData.soulCid then
			self.curSoulIndex = i

			break
		end
	end

	self:RefreshMisc()
	self.skillView:Open(self.soulData)
	self:RefreshTurnPageBtn()
end

function SoulSkillUI:OnHide()
	self.skillView:OnHide()
end

function SoulSkillUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.skillView:OnDestroy()
end

function SoulSkillUI:OnAddListeners()
	self.btnLeft.onClick:AddListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:AddListener(self.onClickBtnRightDelegate)
end

function SoulSkillUI:OnRemoveListeners()
	self.btnLeft.onClick:RemoveListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:RemoveListener(self.onClickBtnRightDelegate)
end

function SoulSkillUI:OnClickBtnLeft()
	if self.curSoulIndex == 1 then
		return
	end

	self.curSoulIndex = self.curSoulIndex - 1
	self.curSoulIndex = math.max(0, self.curSoulIndex)

	self:RefreshTurnPageBtn()
	self:SwitchSoul()
end

function SoulSkillUI:OnClickBtnRight()
	if self.curSoulIndex == #self.switchList then
		return
	end

	self.curSoulIndex = self.curSoulIndex + 1
	self.curSoulIndex = math.min(self.curSoulIndex, #self.switchList)

	self:RefreshTurnPageBtn()
	self:SwitchSoul()
end

function SoulSkillUI:RefreshMisc()
	self.tfSoulName.text = SoulUIApi:GetString("goSoulName", self.soulData:GetCfgSoul().Name)
	self.tfSoulEnglishName.text = SoulUIApi:GetString("goSoulEnglishName", self.soulData:GetCfgSoul().EnglishName)

	local path = SoulUIApi:GetString("SoulHeadIcon", self.soulData.soulCid)

	if path ~= nil and path ~= "" then
		AssetUtil.LoadImage(self, path, self.imgSoulHead)
	end
end

function SoulSkillUI:RefreshTurnPageBtn()
	self.goBtnLeft:SetActive(self.curSoulIndex > 1)
	self.goBtnRight:SetActive(self.curSoulIndex < #self.switchList)
end

function SoulSkillUI:SwitchSoul()
	self:Refresh({
		self.switchList[self.curSoulIndex],
		self.switchList
	})
	EventDispatcher.Dispatch(EventID.SoulLeftRightSwitch, self.switchList[self.curSoulIndex], self.switchList)
end

return SoulSkillUI
