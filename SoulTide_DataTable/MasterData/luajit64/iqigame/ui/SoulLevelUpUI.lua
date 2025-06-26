-- chunkname: @IQIGame\\UI\\SoulLevelUpUI.lua

local SoulLevelUpUI = {}

SoulLevelUpUI = Base:Extend("SoulLevelUpUI", "IQIGame.Onigao.UI.SoulLevelUpUI", SoulLevelUpUI)

local SoulLevelView = require("IQIGame.UI.SoulLevelUp.SoulLevelView")

function SoulLevelUpUI:OnInit()
	self:Initialize()
end

function SoulLevelUpUI:GetPreloadAssetPaths()
	return nil
end

function SoulLevelUpUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulLevelUpUI:IsManualShowOnOpen(userData)
	return false
end

function SoulLevelUpUI:GetBGM(userData)
	return nil
end

function SoulLevelUpUI:OnOpen(userData)
	self:Refresh(userData)
end

function SoulLevelUpUI:OnClose(userData)
	self:OnHide()
end

function SoulLevelUpUI:OnPause()
	return
end

function SoulLevelUpUI:OnResume()
	return
end

function SoulLevelUpUI:OnCover()
	return
end

function SoulLevelUpUI:OnReveal()
	return
end

function SoulLevelUpUI:OnRefocus(userData)
	return
end

function SoulLevelUpUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.levelView ~= nil then
		self.levelView:OnUpdate(elapseSeconds, realElapseSeconds)
	end
end

function SoulLevelUpUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulLevelUpUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulLevelUpUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulLevelUpUI:Initialize()
	self.levelView = SoulLevelView.New(self.goLevelView, self)
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

function SoulLevelUpUI:Refresh(userData)
	self.soulData = userData[1]
	self.switchList = userData[2]

	for i, v in ipairs(self.switchList) do
		if v.soulCid == self.soulData.soulCid then
			self.curSoulIndex = i

			break
		end
	end

	self:RefreshMisc()
	self.levelView:Open(self.soulData)
	self:RefreshTurnPageBtn()
end

function SoulLevelUpUI:OnHide()
	self.levelView:OnHide()
end

function SoulLevelUpUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.levelView:OnDestroy()
end

function SoulLevelUpUI:OnAddListeners()
	self.btnLeft.onClick:AddListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:AddListener(self.onClickBtnRightDelegate)
end

function SoulLevelUpUI:OnRemoveListeners()
	self.btnLeft.onClick:RemoveListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:RemoveListener(self.onClickBtnRightDelegate)
end

function SoulLevelUpUI:OnClickBtnLeft()
	if self.curSoulIndex == 1 then
		return
	end

	self.curSoulIndex = self.curSoulIndex - 1
	self.curSoulIndex = math.max(0, self.curSoulIndex)

	self:RefreshTurnPageBtn()
	self:SwitchSoul()
end

function SoulLevelUpUI:OnClickBtnRight()
	if self.curSoulIndex == #self.switchList then
		return
	end

	self.curSoulIndex = self.curSoulIndex + 1
	self.curSoulIndex = math.min(self.curSoulIndex, #self.switchList)

	self:RefreshTurnPageBtn()
	self:SwitchSoul()
end

function SoulLevelUpUI:RefreshMisc()
	self.tfSoulName.text = SoulUIApi:GetString("goSoulName", self.soulData:GetCfgSoul().Name)
	self.tfSoulEnglishName.text = SoulUIApi:GetString("goSoulEnglishName", self.soulData:GetCfgSoul().EnglishName)

	local path = SoulUIApi:GetString("SoulHeadIcon", self.soulData.soulCid)

	if path ~= nil and path ~= "" then
		AssetUtil.LoadImage(self, path, self.imgSoulHead)
	end
end

function SoulLevelUpUI:RefreshTurnPageBtn()
	self.goBtnLeft:SetActive(self.curSoulIndex > 1)
	self.goBtnRight:SetActive(self.curSoulIndex < #self.switchList)
end

function SoulLevelUpUI:SwitchSoul()
	self:Refresh({
		self.switchList[self.curSoulIndex],
		self.switchList
	})
	EventDispatcher.Dispatch(EventID.SoulLeftRightSwitch, self.switchList[self.curSoulIndex], self.switchList)
end

return SoulLevelUpUI
