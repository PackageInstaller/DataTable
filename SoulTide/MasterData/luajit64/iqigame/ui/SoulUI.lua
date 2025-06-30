-- chunkname: @IQIGame\\UI\\SoulUI.lua

local SoulUI = Base:Extend("SoulUI", "IQIGame.Onigao.UI.SoulUI", {})
local SoulCenterView = require("IQIGame.UI.Soul.SoulCenterView")
local SoulInfoView = require("IQIGame.UI.Soul.SoulInfoView")

function SoulUI:OnInit()
	self:Initialize()
end

function SoulUI:GetPreloadAssetPaths()
	local ret = {}

	for i = 0, 9 do
		ret[#ret + 1] = SoulUIApi:GetString("imgLvPath", i)
	end

	return ret
end

function SoulUI:GetOpenPreloadAssetPaths(userData)
	return {}
end

function SoulUI:OnOpen(userData)
	self.soulData = userData[UIParam.soulUI.soulData]
	self.switchList = userData[UIParam.soulUI.switchList]
	self.defaultTagIndex = userData[UIParam.soulUI.tabIndex]

	if self.defaultTagIndex == nil then
		self.defaultTagIndex = 1
	end

	self:RefreshCenterBlock()
end

function SoulUI:OnClose(userData)
	self:OnHide()
end

function SoulUI:OnPause()
	return
end

function SoulUI:OnResume()
	return
end

function SoulUI:OnCover()
	return
end

function SoulUI:OnReveal()
	return
end

function SoulUI:OnRefocus(userData)
	return
end

function SoulUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulUI:Initialize()
	self.centerView = SoulCenterView.New(self.goCenterView, self)
	self.infoView = SoulInfoView.New(self.goInfoView, self)
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnLeft = self.goBtnLeft:GetComponent("Button")
	self.btnRight = self.goBtnRight:GetComponent("Button")

	function self.onClickBtnLeftDelegate()
		self:OnClickBtnLeft()
	end

	function self.onClickBtnRightDelegate()
		self:OnClickBtnRight()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onSoulExpAddSuccessDelegate()
		self:OnSoulExpAddSuccess()
	end

	function self.onActivateTalentSuccessDelegate()
		self:OnActivateTalentSuccess()
	end

	function self.onEvolveSoulSuccessDelegate(soul)
		self:OnEvolveSoulSuccess(soul)
	end

	function self.onSkillStrengthenUpSuccessDelegate()
		self:OnSkillUpSuccess()
	end

	function self.onActivateChapterSuccessDelegate()
		self:OnActivateChapterSuccess()
	end

	function self.onSoulLeftRightSwitchDelegate(curSoulData, switchList)
		self:OnSoulLeftRightSwitch(curSoulData, switchList)
	end

	function self.onSpActiveSuccessDelegate()
		self:OnSpActiveSuccess()
	end

	function self.delegateBtnGuide()
		self:onBtnGuide()
	end

	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("goViewTitle")
end

function SoulUI:Refresh(soulData)
	self.soulData = soulData

	for i, v in ipairs(self.switchList) do
		if v.soulCid == self.soulData.soulCid then
			self.curSoulIndex = i

			break
		end
	end

	self:RefreshDefaultView()
	self:RefreshTurnPageBtn()
end

function SoulUI:OnHide()
	self.centerView:OnHide()
	self.infoView:OnHide()
	EventDispatcher.Dispatch(EventID.RefreshSoulListRedPoint)
end

function SoulUI:OnDestroy()
	self.centerView:OnDestroy()
	self.infoView:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function SoulUI:OnAddListeners()
	self.btnLeft.onClick:AddListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:AddListener(self.onClickBtnRightDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.delegateBtnGuide)
	EventDispatcher.AddEventListener(EventID.SoulExpAddSuccess, self.onSoulExpAddSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.ActivateTalentSuccess, self.onActivateTalentSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.EvolveSoulSuccess, self.onEvolveSoulSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.SoulSkillStrengthenUpSuccess, self.onSkillStrengthenUpSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.ActivateGroupSuccess, self.onActivateChapterSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.SoulLeftRightSwitch, self.onSoulLeftRightSwitchDelegate)
	EventDispatcher.AddEventListener(EventID.SoulSpiritActiveSuccess, self.onSpActiveSuccessDelegate)
end

function SoulUI:OnRemoveListeners()
	self.btnLeft.onClick:RemoveListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:RemoveListener(self.onClickBtnRightDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGuide)
	EventDispatcher.RemoveEventListener(EventID.SoulExpAddSuccess, self.onSoulExpAddSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.ActivateTalentSuccess, self.onActivateTalentSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.EvolveSoulSuccess, self.onEvolveSoulSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulSkillStrengthenUpSuccess, self.onSkillStrengthenUpSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.ActivateGroupSuccess, self.onActivateChapterSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulLeftRightSwitch, self.onSoulLeftRightSwitchDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulSpiritActiveSuccess, self.onSpActiveSuccessDelegate)
end

function SoulUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function SoulUI:OnSoulLeftRightSwitch(curSoulData, switchList)
	self.centerView:Refresh(curSoulData, switchList)
end

function SoulUI:OnClickBtnLeft()
	self.centerView.scrollList:TurnToBackward()
end

function SoulUI:OnClickBtnRight()
	self.centerView.scrollList:TurnToForward()
end

function SoulUI:OnSoulExpAddSuccess()
	self:RefreshRedPoints()
	self.infoView:Open(self.soulData)
end

function SoulUI:OnSpActiveSuccess()
	self:RefreshRedPoints()
	self.infoView:Open(self.soulData)
end

function SoulUI:OnActivateTalentSuccess()
	self:RefreshRedPoints()
	self.infoView:Open(self.soulData)
end

function SoulUI:OnActivateChapterSuccess()
	self:RefreshRedPoints()
	self.infoView:Open(self.soulData)
end

function SoulUI:OnEvolveSoulSuccess(soul)
	self:RefreshRedPoints()
	self.infoView:Open(self.soulData)
end

function SoulUI:OnSkillUpSuccess()
	self:RefreshRedPoints()
	self.infoView:Open(self.soulData)
end

function SoulUI:RefreshDefaultView()
	self:RefreshView(self.defaultTagIndex)
end

function SoulUI:RefreshCenterBlock()
	self.centerView:Refresh(self.soulData, self.switchList)
end

function SoulUI:RefreshTurnPageBtn()
	self.goBtnLeft:SetActive(self.curSoulIndex > 1)
	self.goBtnRight:SetActive(self.curSoulIndex < #self.switchList)
end

function SoulUI:RefreshView(tagIndex)
	if tagIndex == 1 then
		self.infoView:Open(self.soulData)
	elseif tagIndex == 2 then
		UIModule.Open(Constant.UIControllerName.SoulLevelUpUI, Constant.UILayer.UI, {
			self.soulData,
			self.switchList
		})
	elseif tagIndex == 3 then
		UIModule.Open(Constant.UIControllerName.SoulEvolutionUI, Constant.UILayer.UI, {
			self.soulData,
			self.switchList
		})
	elseif tagIndex == 4 then
		UIModule.Open(Constant.UIControllerName.SoulTalentUI, Constant.UILayer.UI, {
			self.soulData,
			self.switchList
		})
	elseif tagIndex == 5 then
		UIModule.Open(Constant.UIControllerName.SoulSkillUI, Constant.UILayer.UI, {
			self.soulData,
			self.switchList
		})
	elseif tagIndex == 6 then
		local needLv = self.soulData:GetCfgSoul().UnlockSpecialSpiritLv

		if needLv <= self.soulData.lv then
			UIModule.Open(Constant.UIControllerName.SoulSpecialSpiritUI, Constant.UILayer.UI, {
				self.soulData,
				self.switchList
			})
		else
			NoticeModule.ShowNoticeNoCallback(21059003, needLv)
		end
	end
end

function SoulUI:RefreshRedPoints()
	self.infoView:RefreshRedPoints()
end

function SoulUI:onBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 1000)
end

return SoulUI
