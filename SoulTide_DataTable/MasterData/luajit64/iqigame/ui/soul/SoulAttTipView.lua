-- chunkname: @IQIGame\\UI\\Soul\\SoulAttTipView.lua

local SoulAttTipView = {
	attCellPool = {},
	growUpCellPool = {},
	featureCellPool = {}
}

function SoulAttTipView.New(view, mainView)
	local obj = Clone(SoulAttTipView)

	obj:Init(view, mainView)

	return obj
end

function SoulAttTipView:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.attCellPool[1] = self.goAttCell
	self.growUpCellPool[1] = self.goGrowUpCell
	self.linkTipCell = LinkTipCell.New(self.goLinkCell)
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self:OnAddListener()

	self.goTitle1:GetComponent("Text").text = SoulUIApi:GetString("attTipViewTitle1")
	self.goTitle2:GetComponent("Text").text = SoulUIApi:GetString("attTipViewTitle2")
	self.goTitle3:GetComponent("Text").text = SoulUIApi:GetString("attTipViewTitle3")
end

function SoulAttTipView:OnHide()
	return
end

function SoulAttTipView:OnDestroy()
	self:OnRemoveListener()
	self.linkTipCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SoulAttTipView:Open(soulData, viewType)
	self.soulData = soulData
	self.viewType = viewType
	self.cfgQualityData = self.soulData:GetCfgSoulQuality()

	self.View:SetActive(true)
	self:RefreshAtt()
	self:RefreshGrowUp()
	self:RefreshFeature()
end

function SoulAttTipView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function SoulAttTipView:OnAddListener()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function SoulAttTipView:OnRemoveListener()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function SoulAttTipView:OnClickBtnClose()
	self.View:SetActive(false)
end

function SoulAttTipView:RefreshAtt()
	local attIds = {}
	local attId2ValueDic = {}

	if self.viewType == 1 then
		for i, v in pairs(self.cfgQualityData.AttType) do
			if v ~= 0 and self.cfgQualityData.AttValue[i] ~= 0 then
				attIds[#attIds + 1] = v
				attId2ValueDic[v] = self.cfgQualityData.AttValue[i]
			end
		end

		table.sort(attIds, function(a, b)
			return a < b
		end)
	elseif self.viewType == 2 then
		for i, v in pairs(self.soulData.talentCids) do
			local cfgTalentData = CfgSoulTalentTable[v]

			for j, k in pairs(cfgTalentData.AttType) do
				if k ~= 0 then
					if attId2ValueDic[k] == nil then
						attIds[#attIds + 1] = k
						attId2ValueDic[k] = cfgTalentData.AttValue[j]
					else
						attId2ValueDic[k] = attId2ValueDic[k] + cfgTalentData.AttValue[j]
					end
				end
			end
		end

		local cfgSoulData = self.soulData:GetCfgSoul()

		for i, v in ipairs(cfgSoulData.TalentGroupId) do
			if SoulModule.CheckTalentGroupIsActivated(self.soulData, v) then
				local cfgGroupData = CfgSoulTalentGroupTable[v]

				for m, n in ipairs(cfgGroupData.AttType) do
					if n ~= 0 and cfgGroupData.AttValue[m] ~= 0 then
						if attId2ValueDic[n] == nil then
							attIds[#attIds + 1] = n
							attId2ValueDic[n] = cfgGroupData.AttValue[m]
						else
							attId2ValueDic[n] = attId2ValueDic[n] + cfgGroupData.AttValue[m]
						end
					end
				end
			end
		end

		table.sort(attIds, function(a, b)
			return a < b
		end)
	end

	for i, v in ipairs(self.attCellPool) do
		v:SetActive(i <= #attIds)
	end

	for i, v in ipairs(attIds) do
		local cell = self:GetAttCell(i)
		local value = attId2ValueDic[v]
		local tfName = cell.transform:Find("Text_01"):GetComponent("Text")
		local tfValue = cell.transform:Find("Text_02"):GetComponent("Text")

		tfName.text = SoulUIApi:GetString("attTipViewAttName", AttributeModule.GetAttName(v))
		tfValue.text = SoulUIApi:GetString("attTipViewAttValue", AttributeModule.GetAttShowValue(v, value))
	end

	self.goAttBlock:SetActive(#attIds > 0)
end

function SoulAttTipView:RefreshGrowUp()
	local attIds = {}
	local attId2ValueDic = {}

	if self.viewType == 1 then
		local growUpValuesNow = self.soulData:GetGrowUpValues(self.cfgQualityData)

		for i = 1, 6 do
			local value = growUpValuesNow[i]

			if value ~= 0 then
				attIds[#attIds + 1] = i
				attId2ValueDic[i] = growUpValuesNow[i]
			end
		end

		for i, v in ipairs(self.growUpCellPool) do
			v:SetActive(i <= #attIds)
		end

		for i, v in ipairs(attIds) do
			local cell = self:GetGrowUpCell(i)
			local value = attId2ValueDic[v]
			local tfName = cell.transform:Find("Text_01"):GetComponent("Text")
			local tfValue = cell.transform:Find("Text_02"):GetComponent("Text")

			tfName.text = SoulUIApi:GetString("attTipViewGrowUpName", SoulUIApi:GetString("starViewGrowRateName", v))
			tfValue.text = SoulUIApi:GetString("attTipViewGrowUpValue", value)
		end

		self.goGrowUpBlock:SetActive(#attIds > 0)
	end

	self.goGrowUpBlock:SetActive(self.viewType == 1)
end

function SoulAttTipView:RefreshFeature()
	self.linkTipCell:Close()

	if self.viewType == 1 then
		for i, v in ipairs(self.featureCellPool) do
			v:SetActive(false)
		end

		local sourceTxt = ""

		for i, v in ipairs(self.cfgQualityData.ADDSkillID) do
			local cell = self:GetFeatureCell(i)
			local tfName = cell.transform:Find("Content/Text_1"):GetComponent("Text")
			local tfLockDesc = cell.transform:Find("Content/Sort_Star/Text_2"):GetComponent("Text")
			local tfEffectDesc = cell.transform:Find("Text"):GetComponent("Text")
			local signUnlock = cell.transform:Find("Content/Unlock").gameObject
			local signLock = cell.transform:Find("Content/Lock").gameObject
			local isUnlock = self.soulData:CheckFeatureUnlock(v)
			local unlockStar = self:GetFeatureUnlockStar(v)

			tfName.text = SoulUIApi:GetString("attTipViewFeatureName", CfgSkillTable[v].Name, isUnlock)
			tfLockDesc.text = SoulUIApi:GetString("attTipViewFeatureLockDesc")
			tfEffectDesc.text = SoulUIApi:GetString("attTipViewFeatureDesc", SkillModule.GetFeatureEffectDesc(self.soulData, v), isUnlock)
			sourceTxt = sourceTxt .. tfEffectDesc.text
			tfEffectDesc.text = UIGlobalApi.GetTextWithoutKeywordTag(tfEffectDesc.text)

			signUnlock:SetActive(isUnlock)
			signLock:SetActive(not isUnlock)

			for m = 1, 5 do
				local goStar = cell.transform:Find("Content/Sort_Star/Image_0" .. m).gameObject

				goStar:SetActive(m <= unlockStar)
			end

			cell.transform:Find("Content/Sort_Star").gameObject:SetActive(not isUnlock)
		end

		self.goFeatureBlock:SetActive(#self.cfgQualityData.ADDSkillID > 0)
		self.linkTipCell:Open(sourceTxt)
	end

	self.goFeatureBlock:SetActive(self.viewType == 1)
end

function SoulAttTipView:GetAttCell(index)
	local ret = self.attCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goAttCell)

		ret.transform:SetParent(self.goAttCell.transform.parent, false)

		self.attCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

function SoulAttTipView:GetGrowUpCell(index)
	local ret = self.growUpCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goGrowUpCell)

		ret.transform:SetParent(self.goGrowUpCell.transform.parent, false)

		self.growUpCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

function SoulAttTipView:GetFeatureCell(index)
	local ret = self.featureCellPool[index]

	if ret == nil then
		if index == 1 then
			ret = self.goFeatureCell
		else
			ret = UnityEngine.Object.Instantiate(self.goFeatureCell)
		end

		ret.transform:SetParent(self.goFeatureCell.transform.parent, false)

		self.featureCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

function SoulAttTipView:GetFeatureUnlockStar(featureId)
	local cfgQualityDatum = {}

	for i, v in pairsCfg(CfgSoulQualityTable) do
		if v.SoulId == self.soulData.soulCid then
			cfgQualityDatum[#cfgQualityDatum + 1] = v
		end
	end

	table.sort(cfgQualityDatum, function(a, b)
		return a.Id < b.Id
	end)

	for i, v in ipairs(cfgQualityDatum) do
		for m, n in ipairs(v.ADDSkillID) do
			if n == featureId then
				return v.Quality
			end
		end
	end

	return 0
end

return SoulAttTipView
