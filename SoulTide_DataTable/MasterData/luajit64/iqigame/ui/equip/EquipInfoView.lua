-- chunkname: @IQIGame\\UI\\Equip\\EquipInfoView.lua

local EquipInfoView = {
	IsUsingSkin = false,
	normalStoryLockCellPool = {},
	normalStoryUnlockCellPool = {},
	goMainAttCells = {},
	goEffectDesc1Cells = {},
	goEffectDesc2Cells = {},
	goEffectDesc2CellTitles = {},
	suitCellPool = {},
	sourceTxtDic = {}
}
local EquipSuitCell = require("IQIGame.UI.Common.EquipSuitCell")

function EquipInfoView.New(go)
	local o = Clone(EquipInfoView)

	o:Initialize(go)

	return o
end

function EquipInfoView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.tfSpecialName = self.goSpecialName:GetComponent("Text")
	self.tfEquipName = self.goEquipName:GetComponent("Text")
	self.tfEquipDesc = self.goEquipDesc:GetComponent("Text")
	self.tfDialogTip = self.goDialogTip:GetComponent("Text")
	self.tfStoryTitle = self.goStoryTitle:GetComponent("Text")
	self.tfSpecialStory = self.goSpecialStory:GetComponent("Text")
	self.imgStory = self.goImgStory:GetComponent("Image")
	self.imgSpecial = self.goSpecialIcon:GetComponent("Image")
	self.goMainAttCells[1] = self.goMainAttCell
	self.goEffectDesc1Cells[1] = self.goEffectDesc1Cell
	self.goEffectDesc2CellTitles[1] = self.goEffectDesc2CellTitle
	self.normalStoryLockCellPool[1] = self.goNormalStoryLockCell
	self.normalStoryUnlockCellPool[1] = self.goNormalStoryUnlockCell
	self.toggleSwitch = self.goToggleSwitch:GetComponent("Toggle")
	self.btnDialog = self.goBtnDialog:GetComponent("Button")

	function self.onClickBtnDialogDelegate()
		self:OnClickBtnDialog()
	end

	function self.onToggleSwitchDelegate(isOn)
		self:OnToggleSwitch(isOn)
	end

	function self.onClickBtnLinkTipDelegate()
		self:OnClickBtnLinkTip()
	end

	self.goTitle1:GetComponent("Text").text = EquipUIApi:GetString("goTitle1")
	self.goTitle2:GetComponent("Text").text = EquipUIApi:GetString("goTitle2")
	self.goTitle3:GetComponent("Text").text = EquipUIApi:GetString("goTitle3")
	self.goEquipDescTitle:GetComponent("Text").text = EquipUIApi:GetString("goEquipDescTitle")
	self.goSpecialDesc:GetComponent("Text").text = EquipUIApi:GetString("goSpecialDesc")
	self.goBtnDialog.transform:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goDialogBtn")
	self.goToggleSwitch.transform:Find("goDown/Text_Name_01"):GetComponent("Text").text = EquipUIApi:GetString("goToggleSwitch", false)
	self.goToggleSwitch.transform:Find("goUp/Text_Name_01"):GetComponent("Text").text = EquipUIApi:GetString("goToggleSwitch", true)
	self.goToggleSwitch.transform:Find("goDown/Text_Name_02"):GetComponent("Text").text = EquipUIApi:GetString("goToggleSwitch", true)
	self.goToggleSwitch.transform:Find("goUp/Text_Name_02"):GetComponent("Text").text = EquipUIApi:GetString("goToggleSwitch", false)
	self.goSuitTitle:GetComponent("Text").text = EquipUIApi:GetString("goSuitTitle")
end

function EquipInfoView:Refresh(itemData, mainView)
	self.itemData = itemData
	self.mainView = mainView
	self.cfgSoulPaintingData = self.itemData:GetCfg()

	for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
		if v.PaintingId == self.cfgSoulPaintingData.Id and v.QualityLevel == self.itemData.equipData.star then
			self.cfgSoulPaintingQualityData = v

			break
		end
	end

	self:RefreshMisc()
	self:OpenAttView()
	self:AddListeners()

	self.toggleSwitch.isOn = true
end

function EquipInfoView:OnHide()
	self:RemoveListeners()
end

function EquipInfoView:OnDestroy()
	for i, v in pairs(self.suitCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.mainView = nil
	self.goView = nil

	AssetUtil.UnloadAsset(self)
end

function EquipInfoView:RefreshMisc()
	local equipShowInfo, isUsingSkin = EquipModule.GetEquipShowInfo(self.cfgSoulPaintingData.Id)

	self.EquipShowInfo = equipShowInfo
	self.IsUsingSkin = isUsingSkin

	self.goCard.transform:SetParent(self.goCardPoint.transform, false)

	self.tfEquipName.text = EquipUIApi:GetString("goEquipName", equipShowInfo.Name)

	self.goSpecialBlock:SetActive(isUsingSkin)

	if isUsingSkin then
		self.tfSpecialName.text = EquipUIApi:GetString("goSpecialName", self.cfgSoulPaintingData.Name)
	end
end

function EquipInfoView:OpenAttView()
	self.goInfoAttBlock:SetActive(true)
	self.goInfoStoryBlock:SetActive(false)
	self:RefreshMainAtt()
	self:RefreshEffectDesc1()
	self:RefreshEffectDesc2()
	self:RefreshSuitBlock()
end

function EquipInfoView:OpenStoryView()
	self.goInfoAttBlock:SetActive(false)
	self.goInfoStoryBlock:SetActive(true)

	self.layIndexStory = 200

	self.goEquipDescTitle.transform.parent.parent:SetSiblingIndex(self.layIndexStory)

	self.tfEquipDesc.text = EquipUIApi:GetString("goEquipDesc", self.EquipShowInfo.Desc)
	self.layIndexStory = self.layIndexStory + 1

	self.goEquipDesc.transform.parent:SetSiblingIndex(self.layIndexStory)

	local showStory = self.cfgSoulPaintingData.Position == 0
	local isSpecial = self.cfgSoulPaintingData.ExclusiveSoul ~= 0

	self.tfStoryTitle.text = EquipUIApi:GetString("goStoryTitle", isSpecial)
	self.layIndexStory = self.layIndexStory + 1

	self.goStoryTitle.transform.parent.parent:SetSiblingIndex(self.layIndexStory)
	self.goStoryTitle.transform.parent.parent.gameObject:SetActive(showStory)
	self.goSpecialStoryBlock:SetActive(isSpecial and showStory)

	for i, v in pairs(self.normalStoryLockCellPool) do
		v:SetActive(false)
	end

	for i, v in ipairs(self.normalStoryUnlockCellPool) do
		v:SetActive(false)
	end

	if isSpecial then
		if self.cfgSoulPaintingData.ExclusiveStory == 0 then
			self.goBtnDialog:SetActive(false)
			self.goDialogTip:SetActive(false)
		else
			local conditionId = CfgDialogTable[self.cfgSoulPaintingData.ExclusiveStory].openCondition
			local conditionOk = ConditionModule.Check(conditionId)

			self.goBtnDialog:SetActive(conditionOk)
			self.goDialogTip:SetActive(not conditionOk)

			if not conditionOk then
				self.tfDialogTip.text = EquipUIApi:GetString("goDialogTip", CfgConditionTab[conditionId].Name)
			end
		end

		local path = UIGlobalApi.GetImagePath(self.cfgSoulPaintingData.ExclusiveStoryPic)

		AssetUtil.LoadImage(self, path, self.imgStory)

		self.tfSpecialStory.text = EquipUIApi:GetString("goSpecialStory", self.cfgSoulPaintingData.ExclusiveStoryDesc)
		self.layIndexStory = self.layIndexStory + 1

		self.goSpecialStoryBlock.transform:SetSiblingIndex(self.layIndexStory)
	else
		local indexUnlock = 1
		local indexLock = 1

		for i, v in ipairs(self.EquipShowInfo.HiddenStory) do
			local isUnlock = i <= self.itemData.equipData.star

			if isUnlock then
				local cell = self:GetNormalStoryUnlockCell(i)

				cell.transform:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goNormalStoryContent", v)
				indexUnlock = indexUnlock + 1

				cell.gameObject:SetActive(showStory)
			else
				local cell = self:GetNormalStoryLockCell(i)

				cell.transform:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goNormalStoryLockDesc", i)
				indexLock = indexLock + 1

				cell.gameObject:SetActive(showStory)
			end
		end
	end
end

function EquipInfoView:GetNormalStoryLockCell(index)
	local cell = self.normalStoryLockCellPool[index]

	if cell == nil then
		cell = UnityEngine.Object.Instantiate(self.goNormalStoryLockCell)

		cell.transform:SetParent(self.goNormalStoryLockCell.transform.parent, false)

		self.normalStoryLockCellPool[index] = cell
	end

	cell:SetActive(true)

	self.layIndexStory = self.layIndexStory + 1

	cell.transform:SetSiblingIndex(self.layIndexStory)

	return cell
end

function EquipInfoView:GetNormalStoryUnlockCell(index)
	local cell = self.normalStoryUnlockCellPool[index]

	if cell == nil then
		cell = UnityEngine.Object.Instantiate(self.goNormalStoryUnlockCell)

		cell.transform:SetParent(self.goNormalStoryUnlockCell.transform.parent, false)

		self.normalStoryUnlockCellPool[index] = cell
	end

	cell:SetActive(true)

	self.layIndexStory = self.layIndexStory + 1

	cell.transform:SetSiblingIndex(self.layIndexStory)

	return cell
end

function EquipInfoView:RefreshMainAtt()
	self.layIndexAtt = 1

	self.goTitle1.transform.parent.parent:SetSiblingIndex(self.layIndexAtt)

	local mainId2ValueDic = EquipModule.GetMainAbilityValue(self.cfgSoulPaintingQualityData, self.itemData.equipData.lv)
	local mainShowList = {}
	local sortTable = {}

	for i, v in ipairs(self.cfgSoulPaintingQualityData.MainBility) do
		sortTable[i] = v
	end

	table.sort(sortTable, function(a, b)
		return a < b
	end)

	for i, v in ipairs(sortTable) do
		local showValue = EquipUIApi:GetString("curMainAttValue", AttributeModule.GetAttShowValue(v, mainId2ValueDic[v]))
		local name = EquipUIApi:GetString("goAttName", v, true)

		mainShowList[#mainShowList + 1] = {
			v,
			showValue,
			name
		}
	end

	for i, v in ipairs(self.goMainAttCells) do
		v:SetActive(i <= #mainShowList)
	end

	for i, v in ipairs(mainShowList) do
		local trans = self:GetGoMainAttCell(i).transform
		local tfValue = trans:Find("Text_01"):GetComponent("Text")
		local icon = trans:Find("Icon_01"):GetComponent("Image")

		tfValue.text = v[2]

		local path = SoulUIApi:GetString("soulAttIconPath", v[1])

		AssetUtil.LoadImage(self, path, icon)
	end

	self.layIndexAtt = self.layIndexAtt + 1

	self.goMainAttCell.transform.parent:SetSiblingIndex(self.layIndexAtt)
end

function EquipInfoView:RefreshEffectDesc1()
	self.layIndexAtt = 50

	self.goTitle2.transform.parent.parent:SetSiblingIndex(self.layIndexAtt)

	local ids = {}

	if #self.cfgSoulPaintingData.PabilityID[1] > 0 then
		ids[#ids + 1] = self.cfgSoulPaintingData.PabilityID[1][self.itemData.equipData.star]
	end

	if #self.cfgSoulPaintingData.PabilityID[2] > 0 then
		ids[#ids + 1] = self.cfgSoulPaintingData.PabilityID[2][self.itemData.equipData.star]
	end

	for i, v in ipairs(self.goEffectDesc1Cells) do
		v:SetActive(i <= #ids)
	end

	if #ids == 0 then
		self.goTitle2.transform.parent.parent.gameObject:SetActive(false)
	else
		self.goTitle2.transform.parent.parent.gameObject:SetActive(true)

		for i, v in ipairs(ids) do
			local trans = self:GetGoEffectDesc1Cell(i).transform

			trans:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc1", CfgPabilityTable[v].Describe)
			self.layIndexAtt = self.layIndexAtt + 1

			trans:SetSiblingIndex(self.layIndexAtt)
		end
	end
end

function EquipInfoView:RefreshEffectDesc2()
	self.layIndexAtt = 100

	self.goTitle3.transform.parent.parent:SetSiblingIndex(self.layIndexAtt)

	self.sourceTxtDic = {}

	local ids = {}

	if #self.cfgSoulPaintingData.PabilityID[3] > 0 then
		ids[#ids + 1] = self.cfgSoulPaintingData.PabilityID[3][self.itemData.equipData.star]
	end

	if #self.cfgSoulPaintingData.PabilityID[4] > 0 then
		ids[#ids + 1] = self.cfgSoulPaintingData.PabilityID[4][self.itemData.equipData.star]
	end

	for i, v in ipairs(self.goEffectDesc2Cells) do
		v:SetActive(i <= #ids)
		self.goEffectDesc2CellTitles[i]:SetActive(i <= #ids)
	end

	if #ids == 0 then
		self.goTitle3.transform.parent.parent.gameObject:SetActive(false)
	else
		self.goTitle3.transform.parent.parent.gameObject:SetActive(true)

		for i, v in ipairs(ids) do
			local trans2 = self:GetGoEffectDesc2CellTitle(i).transform

			trans2:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc2Title", i)
			trans2:Find("Text_02"):GetComponent("Text").text = EquipUIApi:GetString("goEffectDesc2Name", CfgPabilityTable[v].Name)
			self.layIndexAtt = self.layIndexAtt + 1

			trans2:SetSiblingIndex(self.layIndexAtt)

			local trans = self:GetGoEffectDesc2Cell(i).transform
			local tfDesc = trans:Find("Text_01"):GetComponent("Text")

			tfDesc.text = EquipUIApi:GetString("goEffectDesc2", CfgPabilityTable[v].Describe)
			self.sourceTxtDic[trans.gameObject:GetInstanceID()] = tfDesc.text
			tfDesc.text = UIGlobalApi.GetTextWithoutKeywordTag(tfDesc.text)
			self.layIndexAtt = self.layIndexAtt + 1

			trans:SetSiblingIndex(self.layIndexAtt)
		end
	end
end

function EquipInfoView:RefreshSuitBlock()
	local suitId = self.cfgSoulPaintingData.SoulPaintingSuitId

	self.goSuitBlock:SetActive(suitId ~= 0)

	if suitId == 0 then
		return
	end

	self.layIndexAtt = self.layIndexAtt + 1

	self.goSuitBlock.transform:SetSiblingIndex(self.layIndexAtt)

	for i, v in ipairs(self.suitCellPool) do
		v:SetActive(false)
	end

	local cfgSuitData = CfgSoulPaintingSuitTable[suitId]

	for i, v in ipairs(cfgSuitData.PabilityID) do
		if v ~= 0 then
			local cell = self.suitCellPool[i]

			if cell == nil then
				local go

				if i == 1 then
					go = self.goSuitCell
				else
					go = UnityEngine.Object.Instantiate(self.goSuitCell)
				end

				go.transform:SetParent(self.goSuitCell.transform.parent, false)

				cell = EquipSuitCell.New(go)
			end

			cell:Refresh(i, self.itemData)
		end
	end
end

function EquipInfoView:GetGoMainAttCell(index)
	local ret = self.goMainAttCells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goMainAttCell)
		self.goMainAttCells[index] = ret

		ret.transform:SetParent(self.goMainAttCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function EquipInfoView:GetGoEffectDesc1Cell(index)
	local ret = self.goEffectDesc1Cells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc1Cell)
		self.goEffectDesc1Cells[index] = ret

		ret.transform:SetParent(self.goEffectDesc1Cell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function EquipInfoView:GetGoEffectDesc2Cell(index)
	local ret = self.goEffectDesc2Cells[index]

	if ret == nil then
		if index == 1 then
			ret = self.goEffectDesc2Cell
		else
			ret = UnityEngine.Object.Instantiate(self.goEffectDesc2Cell)
		end

		self.goEffectDesc2Cells[index] = ret

		ret.transform:SetParent(self.goEffectDesc2Cell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function EquipInfoView:GetGoEffectDesc2CellTitle(index)
	local ret = self.goEffectDesc2CellTitles[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectDesc2CellTitle)
		self.goEffectDesc2CellTitles[index] = ret

		ret.transform:SetParent(self.goEffectDesc2CellTitle.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function EquipInfoView:SetActive(vs)
	if vs == false then
		self:OnHide()
	end

	self.goView:SetActive(vs)
end

function EquipInfoView:AddListeners()
	self:RemoveListeners()
	self.btnDialog.onClick:AddListener(self.onClickBtnDialogDelegate)
	self.toggleSwitch.onValueChanged:AddListener(self.onToggleSwitchDelegate)

	for i, v in pairs(self.goEffectDesc2Cells) do
		v:GetComponent("Button").onClick:AddListener(self.onClickBtnLinkTipDelegate)
	end
end

function EquipInfoView:RemoveListeners()
	self.toggleSwitch.onValueChanged:RemoveListener(self.onToggleSwitchDelegate)
	self.btnDialog.onClick:RemoveListener(self.onClickBtnDialogDelegate)

	for i, v in pairs(self.goEffectDesc2Cells) do
		v:GetComponent("Button").onClick:RemoveListener(self.onClickBtnLinkTipDelegate)
	end
end

function EquipInfoView:OnClickBtnDialog()
	DialogModule.OpenDialog(self.cfgSoulPaintingData.ExclusiveStory)
end

function EquipInfoView:OnToggleSwitch(isOn)
	if isOn then
		self:OpenAttView()
	else
		self:OpenStoryView()
	end
end

function EquipInfoView:OnClickBtnLinkTip()
	local target = self.mainView.UIController:GetCurrentTarget()
	local sourTxt = self.sourceTxtDic[target:GetInstanceID()]

	if UIGlobalApi.CheckExistKeywordTag(sourTxt) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			sourTxt,
			target.transform:Find("Text_01").gameObject
		})
	end
end

return EquipInfoView
