-- chunkname: @IQIGame\\UI\\SkillTipsUI.lua

local SkillTipsUI = Base:Extend("SkillTipsUI", "IQIGame.Onigao.UI.SkillTipsUI", {
	disableSpiritShow = false,
	effectCellPool = {},
	attCellPool = {}
})

function SkillTipsUI:OnInit()
	self:Initialize()
end

function SkillTipsUI:GetPreloadAssetPaths()
	return nil
end

function SkillTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SkillTipsUI:OnOpen(userData)
	self:Refresh(userData)
end

function SkillTipsUI:OnClose(userData)
	self:OnHide()
	EventDispatcher.Dispatch(EventID.SkillTipsUIClosed)
end

function SkillTipsUI:OnPause()
	return
end

function SkillTipsUI:OnResume()
	return
end

function SkillTipsUI:OnCover()
	return
end

function SkillTipsUI:OnReveal()
	return
end

function SkillTipsUI:OnRefocus(userData)
	return
end

function SkillTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SkillTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SkillTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SkillTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SkillTipsUI:Initialize()
	self.tfName = self.goName:GetComponent("Text")
	self.tfAnger = self.goAnger:GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.linkTipCell = LinkTipCell.New(self.goLinkCell)
	self.effectCellPool[1] = self.goEffectCell

	for i = 1, 3 do
		local go = self.goAttBlock.transform:Find("Grid/Mould_" .. i).gameObject

		self.attCellPool[i] = go
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goAttBlock.transform:Find("Text_01"):GetComponent("Text").text = SkillTipApi:GetString("goAttChangeTitle")
end

function SkillTipsUI:Refresh(userData)
	self.cfgSkillData = userData.cfgSkillData
	self.soulData = userData.soulData
	self.allSkillStrengths = userData.allSkillStrengths
	self.disableSpiritShow = userData.disableSpiritShow == true
	self.cfgSkillDetailData = CfgSkillDetailTable[self.cfgSkillData.SkillDetail]
	self.showStrengthBlock = true

	if userData.showStrengthBlock ~= nil then
		self.showStrengthBlock = userData.showStrengthBlock
	end

	local allKeywordTexts = {}
	local hasKeyword, keywordTexts = self:RefreshMisc()

	if hasKeyword then
		for i = 1, #keywordTexts do
			table.insert(allKeywordTexts, keywordTexts[i])
		end
	end

	hasKeyword, keywordTexts = self:RefreshStrengthBlock()

	if hasKeyword then
		for i = 1, #keywordTexts do
			-- block empty
		end
	end

	self:RefreshAttBlock()

	if #allKeywordTexts > 0 then
		local text = ""

		for i = 1, #allKeywordTexts do
			text = text .. allKeywordTexts[i]
		end

		self.linkTipCell:Open(text)
	else
		self.linkTipCell:Open("")
	end
end

function SkillTipsUI:OnHide()
	return
end

function SkillTipsUI:OnDestroy()
	self.linkTipCell:OnDestroy()
end

function SkillTipsUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function SkillTipsUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function SkillTipsUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function SkillTipsUI:RefreshMisc()
	local hasKeyword = false
	local keywordTexts = {}

	self.tfName.text = SkillTipApi:GetString("goName", self.cfgSkillData.Name)
	self.tfDesc.text = SkillTipApi:GetString("goEffect", self.cfgSkillData.EffectText)

	local cfgStrengthenDatum = SkillModule.GetStrengthen(self.cfgSkillData.Id)
	local value = 0

	for i, v in ipairs(cfgStrengthenDatum) do
		local isUnlock = false

		if self.soulData ~= nil then
			isUnlock = table.indexOf(self.soulData.activationSkillStrengthen, v.Id) ~= -1
		end

		if self.allSkillStrengths ~= nil then
			isUnlock = table.indexOf(self.allSkillStrengths, v.Id) ~= -1
		end

		if isUnlock then
			self.tfDesc.text = SkillTipApi:GetString("goEffect", v.Describe)

			for m, n in ipairs(v.SkillSlotEffect) do
				if n == 11 then
					value = value + v.SkillSlotEffectParam[m][1]
				end
			end
		end
	end

	local chapterTypeTemp = MazeDataModule.ChapterType == Constant.Maze.ChapterTypeRpg or MazeDataModule.ChapterType == Constant.Maze.ChapterTypeHorizontalRPG or MazeDataModule.ChapterType == Constant.Maze.ChapterTypeHorizontalChallenge

	if (not PlayerModule.InMaze or not chapterTypeTemp) and not self.disableSpiritShow then
		self.tfDesc.text = SkillTipApi:GetString("goEffect", SkillModule.GetValidSkillDesc(self.cfgSkillData, self.tfDesc.text, self.soulData))
	end

	self.tfAnger.text = SkillTipApi:GetString("goAnger", self.cfgSkillDetailData.CostEnergy + value)

	if UIGlobalApi.CheckExistKeywordTag(self.tfDesc.text) then
		table.insert(keywordTexts, self.tfDesc.text)

		self.tfDesc.text = UIGlobalApi.GetTextWithoutKeywordTag(self.tfDesc.text)
		hasKeyword = true
	end

	return hasKeyword, keywordTexts
end

function SkillTipsUI:RefreshAttBlock()
	local existAtt = #self.cfgSkillData.AttrChangeType ~= 0

	self.goAttBlock:SetActive(existAtt)

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

		txt.text = SkillTipApi:GetString("skillViewAttChangeDesc", AttributeModule.GetAttName(v), value, v)

		self.attCellPool[i]:SetActive(value ~= 0)

		if value ~= 0 then
			allZero = false
		end
	end

	self.goAttBlock:SetActive(not allZero)
end

function SkillTipsUI:RefreshStrengthBlock()
	local cfgStrengthenDatum = SkillModule.GetStrengthen(self.cfgSkillData.Id)

	for i, v in pairs(self.effectCellPool) do
		v:SetActive(false)
	end

	local hasKeyword = false
	local keywordTexts = {}

	if self.showStrengthBlock then
		for i, v in ipairs(cfgStrengthenDatum) do
			local goCell = self:GetStrengthEffectCell(i)
			local signLock = goCell.transform:Find("Lock").gameObject
			local signUnlock = goCell.transform:Find("Unlock").gameObject
			local tfEffect = goCell.transform:Find("Text_01"):GetComponent("Text")
			local isUnlock = false

			if self.soulData ~= nil then
				isUnlock = table.indexOf(self.soulData.activationSkillStrengthen, v.Id) ~= -1
			end

			if self.allSkillStrengths ~= nil then
				isUnlock = table.indexOf(self.allSkillStrengths, v.Id) ~= -1
			end

			signLock:SetActive(not isUnlock)
			signUnlock:SetActive(isUnlock)

			local effectText = SkillTipApi:GetString("goStrengthenTypeDesc", v.Name, v.EffectText, isUnlock)

			if UIGlobalApi.CheckExistKeywordTag(effectText) then
				table.insert(keywordTexts, effectText)

				effectText = UIGlobalApi.GetTextWithoutKeywordTag(effectText)
				hasKeyword = true
			end

			tfEffect.text = effectText
		end
	end

	return hasKeyword, keywordTexts
end

function SkillTipsUI:GetStrengthEffectCell(index)
	local ret = self.effectCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectCell)

		ret.transform:SetParent(self.goEffectCell.transform.parent, false)

		self.effectCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

return SkillTipsUI
