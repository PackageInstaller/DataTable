-- chunkname: @IQIGame\\UI\\SoulSpecialSpiritUI.lua

local SoulSpecialSpiritUI = {
	attCellPool = {},
	skillCellPool = {},
	stageCellPool = {}
}

SoulSpecialSpiritUI = Base:Extend("SoulSpecialSpiritUI", "IQIGame.Onigao.UI.SoulSpecialSpiritUI", SoulSpecialSpiritUI)

local SoulSpSkillCell = require("IQIGame.UI.SoulSpecialSpirit.SoulSpSkillCell")

function SoulSpecialSpiritUI:OnInit()
	self:Initialize()
end

function SoulSpecialSpiritUI:GetPreloadAssetPaths()
	return nil
end

function SoulSpecialSpiritUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulSpecialSpiritUI:IsManualShowOnOpen(userData)
	return false
end

function SoulSpecialSpiritUI:GetBGM(userData)
	return nil
end

function SoulSpecialSpiritUI:OnOpen(userData)
	self:Refresh(userData)
end

function SoulSpecialSpiritUI:OnClose(userData)
	self:OnHide()
end

function SoulSpecialSpiritUI:OnPause()
	return
end

function SoulSpecialSpiritUI:OnResume()
	return
end

function SoulSpecialSpiritUI:OnCover()
	return
end

function SoulSpecialSpiritUI:OnReveal()
	return
end

function SoulSpecialSpiritUI:OnRefocus(userData)
	return
end

function SoulSpecialSpiritUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulSpecialSpiritUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulSpecialSpiritUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulSpecialSpiritUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulSpecialSpiritUI:Initialize()
	self.tfSpName = self.goSpName:GetComponent("Text")
	self.tfSpName2 = self.goSpName2:GetComponent("Text")
	self.tfSpDesc = self.goSpDesc:GetComponent("Text")
	self.tfSoulName = self.goSoulName:GetComponent("Text")
	self.imgHead = self.goHead:GetComponent("Image")
	self.imgSoul = self.goSoul:GetComponent("Image")

	for i = 1, self.goStageRoot.transform.childCount do
		self.stageCellPool[#self.stageCellPool + 1] = self.goStageRoot.transform:Find("Star_0" .. i).gameObject
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnEnter = self.goBtnEnter:GetComponent("Button")

	function self.onClickBtnEnterDelegate()
		self:OnClickBtnEnter()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.btnLeft = self.goBtnLeft:GetComponent("Button")
	self.btnRight = self.goBtnRight:GetComponent("Button")

	function self.onClickBtnLeftDelegate()
		self:OnClickBtnLeft()
	end

	function self.onClickBtnRightDelegate()
		self:OnClickBtnRight()
	end

	function self.onSpActiveSuccessDelegate(cfgSpData)
		self:OnSpActiveSuccess(cfgSpData)
	end

	self.skillCellPool[1] = SoulSpSkillCell.New(self.goSkillCell)
	self.attCellPool[1] = self.goAttCell
	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = SoulSpecialSpiritUIApi:GetString("goTitle")
	self.goAttBlockTitle:GetComponent("Text").text = SoulSpecialSpiritUIApi:GetString("goAttBlockTitle")
	self.goSkillBlockTitle:GetComponent("Text").text = SoulSpecialSpiritUIApi:GetString("goSkillBlockTitle")
	self.goBtnEnterTxt:GetComponent("Text").text = SoulSpecialSpiritUIApi:GetString("goBtnEnterTxt")
	self.goBtnEnterTxtEng:GetComponent("Text").text = SoulSpecialSpiritUIApi:GetString("goBtnEnterTxtEng")
end

function SoulSpecialSpiritUI:Refresh(userData)
	self.soulData = userData[1]
	self.switchListOriginal = userData[2]
	self.cfgSoulData = self.soulData:GetCfgSoul()
	self.switchList = {}

	for i, v in ipairs(self.switchListOriginal) do
		if v:GetCfgSoul().UnlockSpecialSpirit and v.lv >= v:GetCfgSoul().UnlockSpecialSpiritLv then
			self.switchList[#self.switchList + 1] = v
		end
	end

	for i, v in ipairs(self.switchList) do
		if v.soulCid == self.soulData.soulCid then
			self.curSoulIndex = i

			break
		end
	end

	self:StopNextStageEffect()
	self:RefreshMisc()
	self:RefreshAttBlock()
	self:RefreshSkillBlock()
	self:RefreshTurnPageBtn()
	self:RefreshRedPointEnter()
end

function SoulSpecialSpiritUI:OnHide()
	self:StopNextStageEffect()

	for i, v in pairs(self.skillCellPool) do
		v:OnHide()
	end

	AssetUtil.UnloadAsset(self)
end

function SoulSpecialSpiritUI:OnDestroy()
	for i, v in pairs(self.skillCellPool) do
		v:OnDestroy()
	end
end

function SoulSpecialSpiritUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnLeft.onClick:AddListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:AddListener(self.onClickBtnRightDelegate)
	self.btnEnter.onClick:AddListener(self.onClickBtnEnterDelegate)
	EventDispatcher.AddEventListener(EventID.SoulSpiritActiveSuccess, self.onSpActiveSuccessDelegate)
end

function SoulSpecialSpiritUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnLeft.onClick:RemoveListener(self.onClickBtnLeftDelegate)
	self.btnRight.onClick:RemoveListener(self.onClickBtnRightDelegate)
	self.btnEnter.onClick:RemoveListener(self.onClickBtnEnterDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulSpiritActiveSuccess, self.onSpActiveSuccessDelegate)
end

function SoulSpecialSpiritUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function SoulSpecialSpiritUI:OnClickBtnLeft()
	if self.curSoulIndex == 1 then
		return
	end

	self.curSoulIndex = self.curSoulIndex - 1
	self.curSoulIndex = math.max(0, self.curSoulIndex)

	self:RefreshTurnPageBtn()
	self:SwitchSoul()
end

function SoulSpecialSpiritUI:OnClickBtnRight()
	if self.curSoulIndex == #self.switchList then
		return
	end

	self.curSoulIndex = self.curSoulIndex + 1
	self.curSoulIndex = math.min(self.curSoulIndex, #self.switchList)

	self:RefreshTurnPageBtn()
	self:SwitchSoul()
end

function SoulSpecialSpiritUI:OnClickBtnEnter()
	UIModule.Open(Constant.UIControllerName.SpecialSpiritUI, Constant.UILayer.UI, self.soulData)
end

function SoulSpecialSpiritUI:OnSpActiveSuccess(cfgSpData)
	self:StopNextStageEffect()
	self:RefreshAttBlock()
	self:RefreshSkillBlock()
	self:RefreshRedPointEnter()
end

function SoulSpecialSpiritUI:RefreshMisc()
	self.tfSpDesc.text = SoulSpecialSpiritUIApi:GetString("goSpDesc", self.cfgSoulData.SpecialSpiritDesc)
	self.tfSpName.text = SoulSpecialSpiritUIApi:GetString("goSpName", self.cfgSoulData.SpecialSpiritName)
	self.tfSpName2.text = self.tfSpName.text
	self.tfSoulName.text = SoulSpecialSpiritUIApi:GetString("goSoulName", self.cfgSoulData.Name)

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.soulData:GetCfgSoulRes2D().SoulSpecialSpiritImage), self.imgSoul)
	AssetUtil.LoadImage(self, SoulUIApi:GetString("SoulHeadIcon", self.soulData.soulCid), self.imgHead)
end

function SoulSpecialSpiritUI:RefreshAttBlock()
	for i, v in pairs(self.attCellPool) do
		v:SetActive(false)
	end

	local allSpAttTypes = SoulSpecialSpiritModule.GetAddAttrTypes(self.soulData.soulCid)

	for i, v in ipairs(allSpAttTypes) do
		local type = v
		local value = 0
		local cell = self:GetAttCell(i)

		if self.soulData.cfgSoulSpDataAtt ~= nil then
			for m, n in pairs(self.soulData.cfgSoulSpDataAtt.AttType) do
				if n == type then
					value = self.soulData.cfgSoulSpDataAtt.AttValue[m]

					break
				end
			end
		end

		cell.transform:Find("Sort/Text_01"):GetComponent("Text").text = SoulSpecialSpiritUIApi:GetString("attName", AttributeModule.GetAttName(type))
		cell.transform:Find("Sort/Text_02"):GetComponent("Text").text = SoulSpecialSpiritUIApi:GetString("attValue", AttributeModule.GetAttShowValue(type, value))
	end

	local lastOverStage

	if self.soulData.cfgSoulSpDataAttToActive == nil then
		lastOverStage = self.soulData.cfgSoulSpDataAtt.Stage
	else
		lastOverStage = self.soulData.cfgSoulSpDataAttToActive.Stage - 1
	end

	if self.soulData.cfgSoulSpDataAttToActive == nil then
		lastOverStage = SoulSpecialSpiritModule.GetMaxAttrSpiritStage(self.soulData.soulCid)
	end

	for i, v in ipairs(self.stageCellPool) do
		v.transform:Find("Image_01").gameObject:SetActive(i <= lastOverStage)
	end

	local targetStageCell = self.stageCellPool[lastOverStage + 1]

	if targetStageCell ~= nil then
		self:PlayNextStageEffect(targetStageCell)
	end
end

function SoulSpecialSpiritUI:RefreshSkillBlock()
	for i, v in pairs(self.skillCellPool) do
		v:SetActive(false)
	end

	for i = 1, SoulSpecialSpiritModule.GetSpSkillNum() do
		local skillCell = self:GetSkillCell(i)
		local cfgSkillData = self.soulData:GetSpSkillByIndex(i)

		skillCell:Refresh(i, cfgSkillData, self.soulData)
	end
end

function SoulSpecialSpiritUI:RefreshTurnPageBtn()
	self.goBtnLeft:SetActive(self.curSoulIndex > 1)
	self.goBtnRight:SetActive(self.curSoulIndex < #self.switchList)
end

function SoulSpecialSpiritUI:SwitchSoul()
	self:Refresh({
		self.switchList[self.curSoulIndex],
		self.switchListOriginal
	})
	EventDispatcher.Dispatch(EventID.SoulLeftRightSwitch, self.switchList[self.curSoulIndex], self.switchListOriginal)
end

function SoulSpecialSpiritUI:PlayNextStageEffect(parent)
	return
end

function SoulSpecialSpiritUI:StopNextStageEffect()
	if self.nextStageEffectOpid ~= nil then
		GameEntry.Effect:StopEffect(self.nextStageEffectOpid)
	end
end

function SoulSpecialSpiritUI:RefreshRedPointEnter()
	self.goRedPointEnter:SetActive(SoulModule.CheckSpRedPoint(self.soulData))
end

function SoulSpecialSpiritUI:GetAttCell(index)
	local ret = self.attCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goAttCell)

		ret.transform:SetParent(self.goAttCell.transform.parent, false)

		self.attCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

function SoulSpecialSpiritUI:GetSkillCell(index)
	local ret = self.skillCellPool[index]

	if ret == nil then
		local goClone = UnityEngine.Object.Instantiate(self.goSkillCell)

		goClone.transform:SetParent(self.goSkillCell.transform.parent, false)

		ret = SoulSpSkillCell.New(goClone)
		self.skillCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

return SoulSpecialSpiritUI
