-- chunkname: @IQIGame\\UI\\SpecialSpiritUI.lua

local SpecialSpiritUI = {
	SkillBtnList = {},
	starCellPool = {}
}

SpecialSpiritUI = Base:Extend("SpecialSpiritUI", "IQIGame.Onigao.UI.SpecialSpiritUI", SpecialSpiritUI)

local SpAttActiveView = require("IQIGame.UI.SpecialSpirit.SpAttActiveView")
local SpSkillView = require("IQIGame.UI.SpecialSpirit.SpSkillView")
local SpecialSpiritUISkillCell = require("IQIGame.UI.SpecialSpirit.SpecialSpiritUISkillCell")
local SpEnhanceLvOverviewController = require("IQIGame.UI.SpecialSpirit.SpEnhanceLvOverviewController")

function SpecialSpiritUI:OnInit()
	self:Initialize()
end

function SpecialSpiritUI:GetPreloadAssetPaths()
	return nil
end

function SpecialSpiritUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SpecialSpiritUI:IsManualShowOnOpen(userData)
	return false
end

function SpecialSpiritUI:GetBGM(userData)
	return nil
end

function SpecialSpiritUI:OnOpen(userData)
	self:Refresh(userData)
end

function SpecialSpiritUI:OnClose(userData)
	self:OnHide()
end

function SpecialSpiritUI:OnPause()
	return
end

function SpecialSpiritUI:OnResume()
	return
end

function SpecialSpiritUI:OnCover()
	return
end

function SpecialSpiritUI:OnReveal()
	return
end

function SpecialSpiritUI:OnRefocus(userData)
	return
end

function SpecialSpiritUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SpecialSpiritUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SpecialSpiritUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SpecialSpiritUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SpecialSpiritUI:Initialize()
	function self.onClickBtnSkillDelegate(skillCidIndex)
		self:OnClickBtnSkill(skillCidIndex)
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onSpActiveSuccessDelegate(cfgSpData)
		self:OnSpActiveSuccess(cfgSpData)
	end

	function self.delegateOnSkillTypeToggleValueChanged(isOn)
		self:onSkillTypeToggleValueChanged(isOn)
	end

	self.attActiveView = SpAttActiveView.New(self.goAttActiveView)
	self.skillView = SpSkillView.New(self.goSkillView, self)
	self.EnhanceLvOverview = SpEnhanceLvOverviewController.New(self.EnhanceLvOverviewGO)

	for i = 1, self.goStarRoot.transform.childCount do
		if i < 10 then
			self.starCellPool[#self.starCellPool + 1] = self.goStarRoot.transform:Find("Star_0" .. i).gameObject
		else
			self.starCellPool[#self.starCellPool + 1] = self.goStarRoot.transform:Find("Star_" .. i).gameObject
		end
	end

	self.skillBtnPrefab:SetActive(true)

	for i = 1, SoulSpecialSpiritModule.GetSpSkillNum() do
		local pointTrans = self.skillBtnPointContainer.transform:Find("Point" .. i)

		if pointTrans ~= nil then
			local skillBtnGo = UnityEngine.Object.Instantiate(self.skillBtnPrefab)

			skillBtnGo.transform:SetParent(pointTrans, false)

			self.SkillBtnList[i] = SpecialSpiritUISkillCell.New(skillBtnGo, i, self.onClickBtnSkillDelegate)
		else
			logError("UI上的魂芯按钮数量小于[" .. SoulSpecialSpiritModule.GetSpSkillNum() .. "]。")
		end
	end

	self.skillBtnPrefab:SetActive(false)

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.goTitle:GetComponent("Text").text = SpecialSpiritUIApi:GetString("goTitle")
end

function SpecialSpiritUI:Refresh(userData)
	self.soulData = userData

	self:StopNextStarEffect()
	self:StopActiveStarEffect()
	self:StopLineEffect()
	self:RefreshOnAtt()

	for i = 1, #self.SkillBtnList do
		self.SkillBtnList[i]:SetData(self.soulData)
	end

	for i = 3, #self.SkillBtnList do
		local group = SoulSpecialSpiritModule.GetSpiritGroup(i)
		local isReleased = SoulSpecialSpiritModule.GetCfgData(self.soulData.soulCid, group, 1) ~= nil

		self["skillNormalEffect" .. i]:SetActive(isReleased)
		self["skillUnreleasedEffect" .. i]:SetActive(not isReleased)
	end

	self.EnhanceLvOverview:SetData(self.soulData)
	self:ToggleSkillTypeToggleListener(false)

	self.SkillTypeToggle:GetComponent(typeof(UnityEngine.UI.Toggle)).isOn = true

	self:ToggleSkillShow(true)
	self:ToggleSkillTypeToggleListener(true)
end

function SpecialSpiritUI:OnHide()
	self.attActiveView:OnHide()
	self.skillView:OnHide()
	self:StopNextStarEffect()
	self:StopActiveStarEffect()
	self:StopLineEffect()
end

function SpecialSpiritUI:OnDestroy()
	self.attActiveView:OnDestroy()
	self.skillView:OnDestroy()
	self.EnhanceLvOverview:Dispose()

	for i = 1, #self.SkillBtnList do
		self.SkillBtnList[i]:Dispose()
	end
end

function SpecialSpiritUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self:ToggleSkillTypeToggleListener(true)
	EventDispatcher.AddEventListener(EventID.SoulSpiritActiveSuccess, self.onSpActiveSuccessDelegate)
end

function SpecialSpiritUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self:ToggleSkillTypeToggleListener(false)
	EventDispatcher.RemoveEventListener(EventID.SoulSpiritActiveSuccess, self.onSpActiveSuccessDelegate)
end

function SpecialSpiritUI:ToggleSkillTypeToggleListener(isAdd)
	if isAdd then
		self.SkillTypeToggle:GetComponent(typeof(UnityEngine.UI.Toggle)).onValueChanged:AddListener(self.delegateOnSkillTypeToggleValueChanged)
	else
		self.SkillTypeToggle:GetComponent(typeof(UnityEngine.UI.Toggle)).onValueChanged:RemoveListener(self.delegateOnSkillTypeToggleValueChanged)
	end
end

function SpecialSpiritUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function SpecialSpiritUI:OnClickBtnSkill(skillCidIndex)
	self.attActiveView:Close()
	self.skillView:Open(self.soulData, skillCidIndex)
end

function SpecialSpiritUI:OnSpActiveSuccess(cfgSpData)
	if cfgSpData.Group == 1 then
		self:RefreshOnAtt()

		local starDatum = self.soulData.curAttStageStarDatum

		for i, v in ipairs(self.starCellPool) do
			if starDatum[i].cid == cfgSpData.Id then
				self:PlayActiveStarEffect(v)
			end
		end

		self:PlayLineEffect()
	else
		local btn = self.SkillBtnList[SoulSpecialSpiritModule.GetSpSkillIndex(cfgSpData.Group)]

		btn:RefreshRedPoint()
	end

	self.EnhanceLvOverview:Refresh()
end

function SpecialSpiritUI:OnSpSkillViewClose()
	if self.soulData.cfgSoulSpDataAttToActive then
		self.attActiveView:Open(self.soulData.cfgSoulSpDataAttToActive, self.soulData)
	end
end

function SpecialSpiritUI:RefreshOnAtt()
	local starDatum = self.soulData.curAttStageStarDatum

	for i, v in ipairs(self.starCellPool) do
		for m = 0, v.transform.childCount - 1 do
			local findRet = v.transform:GetChild(m)

			if findRet.gameObject.name == "Image_02" then
				findRet.gameObject:SetActive(starDatum[i].isUnlock)

				break
			end
		end

		if self.soulData.cfgSoulSpDataAttToActive ~= nil and starDatum[i].cid == self.soulData.cfgSoulSpDataAttToActive.Id then
			self:PlayNextStarEffect(v)
		end
	end

	if self.soulData.cfgSoulSpDataAttToActive then
		self.attActiveView:Open(self.soulData.cfgSoulSpDataAttToActive, self.soulData)
	else
		self.attActiveView:Close()
	end
end

function SpecialSpiritUI:PlayNextStarEffect(parent)
	self:StopNextStarEffect()

	self.nextStarEffectOpid = GameEntry.Effect:PlayUIMountPointEffect(9003904, 50000, 0, parent, self.UIController:GetComponent("Canvas").sortingOrder + 5)
end

function SpecialSpiritUI:StopNextStarEffect()
	if self.nextStarEffectOpid ~= nil then
		GameEntry.Effect:StopEffect(self.nextStarEffectOpid)

		self.nextStarEffectOpid = nil
	end
end

function SpecialSpiritUI:PlayActiveStarEffect(parent)
	self:StopActiveStarEffect()

	self.activeStarEffectOpid = GameEntry.Effect:PlayUIMountPointEffect(9003902, 50000, 0, parent, self.UIController:GetComponent("Canvas").sortingOrder + 5)
end

function SpecialSpiritUI:StopActiveStarEffect()
	if self.activeStarEffectOpid ~= nil then
		GameEntry.Effect:StopEffect(self.activeStarEffectOpid)

		self.activeStarEffectOpid = nil
	end
end

function SpecialSpiritUI:PlayLineEffect()
	self:StopLineEffect()
	self.goEffectLineRoot:SetActive(true)
end

function SpecialSpiritUI:StopLineEffect()
	self.goEffectLineRoot:SetActive(false)
end

function SpecialSpiritUI:onSkillTypeToggleValueChanged(isOn)
	self:ToggleSkillShow(isOn)
end

function SpecialSpiritUI:ToggleSkillShow(showUltimate)
	for i = 1, #self.SkillBtnList do
		local pointTrans = self.skillBtnPointContainer.transform:Find("Point" .. i)
		local optionalSkillIndex = SoulSpecialSpiritModule.GetOptionalSkillIndexBySpSkillIndex(i)
		local isUltimate = optionalSkillIndex == -1

		pointTrans.gameObject:SetActive(showUltimate and isUltimate or not showUltimate and not isUltimate)
	end

	self.skillView:Close()
end

return SpecialSpiritUI
