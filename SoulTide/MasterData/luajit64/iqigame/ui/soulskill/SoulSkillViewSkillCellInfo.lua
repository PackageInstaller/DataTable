-- chunkname: @IQIGame\\UI\\SoulSkill\\SoulSkillViewSkillCellInfo.lua

local SoulSkillViewSkillCellInfo = {
	strengthCellPool = {},
	attCellPool = {},
	sourceEffectTxtDic = {}
}

function SoulSkillViewSkillCellInfo.New(view, mainView)
	local obj = Clone(SoulSkillViewSkillCellInfo)

	obj:Init(view, mainView)

	return obj
end

function SoulSkillViewSkillCellInfo:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfLv = self.goLv:GetComponent("Text")
	self.tfName = self.goName:GetComponent("Text")
	self.tfType = self.goType:GetComponent("Text")
	self.tfSp = self.goSp:GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.icon = self.goIcon:GetComponent("Image")

	for i = 1, 3 do
		local go = self.goAttCellParent.transform:Find("Mould_" .. i).gameObject

		self.attCellPool[i] = go
	end

	self.btnChange = self.goBtnChange:GetComponent("Button")
	self.toggleSelf = self.goToggle:GetComponent("Toggle")
	self.btnlDesc = self.goBtnDesc:GetComponent("Button")

	function self.onClickToggleSelfDelegate(isOn)
		self:OnClickToggleSelf(isOn)
	end

	function self.onClickBtnChangeDelegate()
		self:OnClickBtnChange()
	end

	function self.onClickBtnlDescDelegate()
		self:OnClickBtnDesc()
	end

	function self.onClickBtnEffectTxtDelegate()
		self:OnClickBtnEffectTxt()
	end

	self.goAttBlockTitle:GetComponent("Text").text = SoulUIApi:GetString("skillViewAttBlockTitle")
	self.goSp.transform.parent:Find("Text_1").gameObject:GetComponent("Text").text = SoulUIApi:GetString("skillViewSpDesc")

	self:Reset()
end

function SoulSkillViewSkillCellInfo:Refresh(index, skillCid, groupIndex, soulData)
	self.index = index
	self.cfgSkillData = CfgSkillTable[skillCid]
	self.groupIndex = groupIndex
	self.soulData = soulData

	local groupid = CfgSoulTable[self.soulData.soulCid].DefaultSkill[self.groupIndex]

	self.isUnlock = SkillModule.CheckSkillGroupUnlock(self.soulData, groupid)
	self.cfgStrengthenDataTarget = nil
	self.cfgStrengthenDatum = SkillModule.GetStrengthen(self.cfgSkillData.Id)

	for i, v in ipairs(self.cfgStrengthenDatum) do
		if table.indexOf(self.soulData.activationSkillStrengthen, v.Id) == -1 then
			self.cfgStrengthenDataTarget = v

			break
		end
	end

	self.isMax = self.cfgStrengthenDataTarget == nil

	self:RefreshMisc()
end

function SoulSkillViewSkillCellInfo:ReRefresh()
	self:Refresh(self.index, self.cfgSkillData.Id, self.groupIndex, self.soulData)
end

function SoulSkillViewSkillCellInfo:OnHide()
	self:Reset()
end

function SoulSkillViewSkillCellInfo:OnDestroy()
	self.mainView = nil

	for i, v in pairs(self.strengthCellPool) do
		v:GetComponent("Button").onClick:RemoveListener(self.onClickBtnEffectTxtDelegate)
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
end

function SoulSkillViewSkillCellInfo:OnAddListeners()
	self.btnChange.onClick:AddListener(self.onClickBtnChangeDelegate)
	self.btnlDesc.onClick:AddListener(self.onClickBtnlDescDelegate)
	self.toggleSelf.onValueChanged:AddListener(self.onClickToggleSelfDelegate)
end

function SoulSkillViewSkillCellInfo:OnRemoveListeners()
	self.btnChange.onClick:RemoveListener(self.onClickBtnChangeDelegate)
	self.btnlDesc.onClick:RemoveListener(self.onClickBtnlDescDelegate)
	self.toggleSelf.onValueChanged:RemoveListener(self.onClickToggleSelfDelegate)
end

function SoulSkillViewSkillCellInfo:OnClickBtnDesc()
	if UIGlobalApi.CheckExistKeywordTag(self.sourceDescTxt) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			self.sourceDescTxt,
			self.goLinkTipPos
		})
	end
end

function SoulSkillViewSkillCellInfo:OnClickBtnEffectTxt()
	local insID = self.mainView.mainView.UIController:GetCurrentTarget():GetInstanceID()
	local checkTxt = self.sourceEffectTxtDic[insID]

	if UIGlobalApi.CheckExistKeywordTag(checkTxt) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			checkTxt,
			self.goLinkTipPos
		})
	end
end

function SoulSkillViewSkillCellInfo:OnClickBtnChange()
	return
end

function SoulSkillViewSkillCellInfo:OnClickToggleSelf(isOn)
	local newSize = self.View.transform.sizeDelta

	if isOn then
		newSize.x = 560
	else
		newSize.x = 120
	end

	self.View.transform.sizeDelta = newSize

	self.mainView:OnClickSkillCellInfo(isOn, self)
end

function SoulSkillViewSkillCellInfo:RefreshMisc()
	self.tfLv.text = SoulUIApi:GetString("skillViewSkillLv", SkillModule.GetSkillLv(self.cfgSkillData.Id, self.soulData))
	self.tfName.text = SkillTipApi:GetString("goName", self.cfgSkillData.Name)

	local cfgSkillDetailData = CfgSkillDetailTable[self.cfgSkillData.SkillDetail]
	local cfgStrengthenDatum = SkillModule.GetStrengthen(self.cfgSkillData.Id)
	local value = 0

	for i, v in ipairs(cfgStrengthenDatum) do
		local isUnlock = false

		if self.soulData ~= nil then
			isUnlock = table.indexOf(self.soulData.activationSkillStrengthen, v.Id) ~= -1
		end

		if isUnlock then
			for m, n in ipairs(v.SkillSlotEffect) do
				if n == 11 then
					value = value + v.SkillSlotEffectParam[m][1]
				end
			end
		end
	end

	self.tfSp.text = SoulUIApi:GetString("skillViewSkillSp", cfgSkillDetailData.CostEnergy + value)

	local skillTypeDesc = ""
	local isShow = SkillTipApi:GetString("showSkillType", self.cfgSkillData.ShowType)

	if isShow then
		skillTypeDesc = SkillTipApi:GetString("goSkillTypeTxtInCellInfo", self.cfgSkillData.ShowType, true)
	end

	self.tfType.text = skillTypeDesc
	self.tfDesc.text = SkillTipApi:GetString("goEffect", self.cfgSkillData.EffectText)

	for i, v in ipairs(self.cfgStrengthenDatum) do
		if table.indexOf(self.soulData.activationSkillStrengthen, v.Id) ~= -1 then
			self.tfDesc.text = SkillTipApi:GetString("goEffect", v.Describe)
		end
	end

	self.tfDesc.text = SkillTipApi:GetString("goEffect", SkillModule.GetValidSkillDesc(self.cfgSkillData, self.tfDesc.text))
	self.sourceDescTxt = self.tfDesc.text
	self.tfDesc.text = UIGlobalApi.GetTextWithoutKeywordTag(self.sourceDescTxt)

	self.goSpTag:SetActive(SoulSpecialSpiritModule.CheckSpAllActive(self.cfgSkillData.Id))
	self.goBtnChange:SetActive(self.groupIndex == 3)

	local groupid = CfgSoulTable[self.soulData.soulCid].DefaultSkill[self.groupIndex]

	self.goRedPoint:SetActive(self.groupIndex ~= 3 and SoulModule.CheckSkillUpRedPoint(self.soulData, self.cfgSkillData, groupid))
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.cfgSkillData.Icon), self.icon)
	self:RefreshStrengthBlock()
	self:RefreshAttBlock()
end

function SoulSkillViewSkillCellInfo:RefreshAttBlock()
	local existAtt = #self.cfgSkillData.AttrChangeType ~= 0

	self.goAttCellParent.transform.parent.gameObject:SetActive(existAtt)

	if not existAtt then
		return
	end

	for i, v in ipairs(self.attCellPool) do
		v:SetActive(i <= #self.cfgSkillData.AttrChangeType)
	end

	local allZero = true

	for i, v in pairs(self.cfgSkillData.AttrChangeType) do
		local value = self.cfgSkillData.AttrChangeValue[i]
		local txt = self.attCellPool[i].transform:Find("Text_01"):GetComponent("Text")

		txt.text = SoulUIApi:GetString("skillViewAttChangeDesc", AttributeModule.GetAttName(v), value, v)

		self.attCellPool[i]:SetActive(value ~= 0)

		if value ~= 0 then
			allZero = false
		end
	end

	self.goAttCellParent.transform.parent.gameObject:SetActive(not allZero)
end

function SoulSkillViewSkillCellInfo:RefreshStrengthBlock()
	self.sourceEffectTxtDic = {}

	for i, v in pairs(self.strengthCellPool) do
		v:SetActive(false)
	end

	for i, v in ipairs(self.cfgStrengthenDatum) do
		local cell = self:GetStrengthCell(i)
		local SignLock = cell.transform:Find("Lock").gameObject
		local SignUnlock = cell.transform:Find("Unlock").gameObject
		local tfDesc = cell.transform:Find("Text_01").gameObject:GetComponent("Text")
		local isUnlock = table.indexOf(self.soulData.activationSkillStrengthen, v.Id) ~= -1

		tfDesc.text = SkillTipApi:GetString("goStrengthenTypeDesc", v.Name, v.EffectText, isUnlock)
		self.sourceEffectTxtDic[cell.gameObject:GetInstanceID()] = tfDesc.text
		tfDesc.text = UIGlobalApi.GetTextWithoutKeywordTag(tfDesc.text)

		SignLock:SetActive(not isUnlock)
		SignUnlock:SetActive(isUnlock)
	end
end

function SoulSkillViewSkillCellInfo:GetStrengthCell(index)
	local ret = self.strengthCellPool[index]

	if ret == nil then
		if index == 1 then
			ret = self.goStrengthCell
		else
			ret = UnityEngine.Object.Instantiate(self.goStrengthCell)
		end

		ret.transform:SetParent(self.goStrengthCell.transform.parent, false)

		self.strengthCellPool[index] = ret

		ret:GetComponent("Button").onClick:AddListener(self.onClickBtnEffectTxtDelegate)
	end

	ret:SetActive(true)

	return ret
end

function SoulSkillViewSkillCellInfo:Reset()
	self.toggleSelf.isOn = false

	local newSize = self.View.transform.sizeDelta

	newSize.x = 120
	self.View.transform.sizeDelta = newSize
end

return SoulSkillViewSkillCellInfo
