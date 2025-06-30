-- chunkname: @IQIGame\\UI\\Soul\\SoulFeatureTipController.lua

local m = {
	goCellPool = {},
	goDescPool = {},
	cfgQualityDatum = {},
	DelegateOnClickDescBtnMap = {}
}

function m.New(view, onClickDescCallback)
	local obj = Clone(m)

	obj:Init(view, onClickDescCallback)

	return obj
end

function m:Init(view, onClickDescCallback)
	self.View = view
	self.OnClickDescCallback = onClickDescCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	self.goTitle:GetComponent("Text").text = SoulUIApi:GetString("infoViewFeatureTipTitle")
end

function m:SetData(soulData, customFeatureSkills)
	self.soulData = soulData
	self.cfgQualityData = self.soulData:GetCfgSoulQuality()

	for i, v in pairsCfg(CfgSoulQualityTable) do
		if v.SoulId == self.soulData.soulCid then
			self.cfgQualityDatum[#self.cfgQualityDatum + 1] = v
		end
	end

	table.sort(self.cfgQualityDatum, function(a, b)
		return a.Id < b.Id
	end)
	self:RefreshItems(customFeatureSkills)
end

function m:RefreshItems(customFeatureSkills)
	for i, v in ipairs(self.goCellPool) do
		v:SetActive(i <= #self.soulData.maxStarFeatureIds)
	end

	local sourceTxt = ""

	self.layIndex = 1

	for i, skillCid in ipairs(self.soulData.maxStarFeatureIds) do
		local cfgSkillData = CfgSkillTable[skillCid]
		local cell = self:GetCell(i)
		local goDesc = self:GetDesc(i)
		local tfName = cell.transform:Find("Content/Text_1"):GetComponent("Text")
		local tfUnlockDesc = cell.transform:Find("Content/Sort_Star/Text_2"):GetComponent("Text")
		local isUnlock = self:GetFeatureUnlock(skillCid, customFeatureSkills)
		local unlockStar = self:GetFeatureUnlockStar(skillCid)
		local signUnlock = cell.transform:Find("Content/Unlock").gameObject
		local signLock = cell.transform:Find("Content/Lock").gameObject

		signUnlock:SetActive(isUnlock)
		signLock:SetActive(not isUnlock)

		tfName.text = SoulUIApi:GetString("featureInfoViewFeatureName", cfgSkillData.Name, isUnlock)
		tfUnlockDesc.text = SoulUIApi:GetString("infoViewFeatureUnlockDesc", isUnlock)

		for i2 = 1, 5 do
			local goStar = cell.transform:Find("Content/Sort_Star/Image_0" .. i2).gameObject

			goStar:SetActive(i2 <= unlockStar)
		end

		cell.transform:Find("Content/Sort_Star").gameObject:SetActive(not isUnlock and customFeatureSkills == nil)

		local srcDescText = SoulUIApi:GetString("infoViewFeatureDesc", SkillModule.GetFeatureEffectDesc(self.soulData, cfgSkillData.Id), isUnlock)

		sourceTxt = sourceTxt .. srcDescText

		local descBtn = goDesc:GetComponent("Button")

		if descBtn ~= nil then
			local function delegateOnClickDescBtn()
				self:OnClickDescBtn(srcDescText, goDesc)
			end

			self.DelegateOnClickDescBtnMap[goDesc:GetInstanceID()] = delegateOnClickDescBtn

			descBtn.onClick:AddListener(delegateOnClickDescBtn)
		end

		UGUIUtil.SetTextInChildren(goDesc, UIGlobalApi.GetTextWithoutKeywordTag(srcDescText))

		self.layIndex = self.layIndex + 1

		cell.transform:SetSiblingIndex(self.layIndex)

		self.layIndex = self.layIndex + 1

		goDesc.transform:SetSiblingIndex(self.layIndex)
	end

	self.SourceTxt = sourceTxt
end

function m:GetCell(index)
	local ret = self.goCellPool[index]

	if ret == nil then
		if index == 1 then
			ret = self.goCell
		else
			ret = UnityEngine.Object.Instantiate(self.goCell)
		end

		self.goCellPool[index] = ret

		ret.transform:SetParent(self.goCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function m:GetDesc(index)
	local ret = self.goDescPool[index]

	if ret == nil then
		if index == 1 then
			ret = self.goDesc
		else
			ret = UnityEngine.Object.Instantiate(self.goDesc)
		end

		self.goDescPool[index] = ret

		ret.transform:SetParent(self.goDesc.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function m:GetFeatureUnlock(skillCid, customFeatureSkills)
	if customFeatureSkills ~= nil then
		return table.indexOf(customFeatureSkills, skillCid) ~= -1
	end

	return self.soulData:CheckFeatureUnlock(skillCid)
end

function m:GetFeatureUnlockStar(featureId)
	for i, cfgSoulQualityData in ipairs(self.cfgQualityDatum) do
		for i2, skillCid in ipairs(cfgSoulQualityData.ADDSkillID) do
			if skillCid == featureId then
				return cfgSoulQualityData.Quality
			end
		end
	end

	return 0
end

function m:OnClickDescBtn(descText, goDesc)
	if self.OnClickDescCallback ~= nil then
		self.OnClickDescCallback(descText, goDesc)
	end
end

function m:Dispose()
	for i, v in pairs(self.goCellPool) do
		self.goCellPool[i] = nil
	end

	for i, goDesc in pairs(self.goDescPool) do
		local instanceId = goDesc:GetInstanceID()
		local delegateOnClickDescBtn = self.DelegateOnClickDescBtnMap[instanceId]

		if delegateOnClickDescBtn ~= nil then
			goDesc:GetComponent("Button").onClick:RemoveListener(delegateOnClickDescBtn)

			self.DelegateOnClickDescBtnMap[instanceId] = nil
		end

		self.goDescPool[i] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickDescCallback = nil
end

return m
