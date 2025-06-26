-- chunkname: @IQIGame\\UI\\SoulEvolutionTipUI.lua

local SoulEvolutionTipUI = Base:Extend("SoulEvolutionTipUI", "IQIGame.Onigao.UI.SoulEvolutionTipUI", {
	attCellPool = {},
	growUpCellPool = {}
})

function SoulEvolutionTipUI:OnInit()
	self:Initialize()
end

function SoulEvolutionTipUI:GetPreloadAssetPaths()
	return nil
end

function SoulEvolutionTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulEvolutionTipUI:IsManualShowOnOpen(userData)
	return false
end

function SoulEvolutionTipUI:GetBGM(userData)
	return nil
end

function SoulEvolutionTipUI:OnOpen(userData)
	self:Refresh(userData)
end

function SoulEvolutionTipUI:OnClose(userData)
	self:OnHide()
end

function SoulEvolutionTipUI:OnPause()
	return
end

function SoulEvolutionTipUI:OnResume()
	return
end

function SoulEvolutionTipUI:OnCover()
	return
end

function SoulEvolutionTipUI:OnReveal()
	return
end

function SoulEvolutionTipUI:OnRefocus(userData)
	return
end

function SoulEvolutionTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulEvolutionTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulEvolutionTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulEvolutionTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulEvolutionTipUI:Initialize()
	self.attCellPool[1] = self.goAttCell
	self.growUpCellPool[1] = self.goGrowUpCell
	self.tfFeatureLv = self.goFeatureLv:GetComponent("Text")
	self.tfFeatureName = self.goFeatureName:GetComponent("Text")
	self.tfFeatureDesc = self.goFeatureDesc:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goTitle:GetComponent("Text").text = SoulEvolutionTipUIApi:GetString("goTitle")
	self.goTitleEng:GetComponent("Text").text = SoulEvolutionTipUIApi:GetString("goTitleEng")
	self.goTitleEng2:GetComponent("Text").text = SoulEvolutionTipUIApi:GetString("goTitleEng2")
	self.goAttTitle:GetComponent("Text").text = SoulEvolutionTipUIApi:GetString("goAttTitle")
end

function SoulEvolutionTipUI:Refresh(userData)
	self.soulData = userData[1]
	self.preAtts = userData[2]
	self.cfgQualityCur = self.soulData:GetCfgSoulQuality()
	self.cfgQualityPre = CfgSoulQualityTable[self.cfgQualityCur.Id - 1]

	self:RefreshStarBlock()
	self:RefreshAttBlock()
	self:RefreshGrowUpBlock()
	self:RefreshFeatureBlock()
end

function SoulEvolutionTipUI:OnHide()
	return
end

function SoulEvolutionTipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function SoulEvolutionTipUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function SoulEvolutionTipUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function SoulEvolutionTipUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function SoulEvolutionTipUI:RefreshStarBlock()
	for i = 1, 5 do
		local transStar = self.goStarBlock.transform:Find("Star_0" .. i)
		local signEmpty = transStar:Find("Image_01").gameObject
		local signStar = transStar:Find("Image_02").gameObject

		signEmpty:SetActive(i > self.cfgQualityCur.Quality)
		signStar:SetActive(i <= self.cfgQualityCur.Quality)
	end
end

function SoulEvolutionTipUI:RefreshAttBlock()
	local uppedAttids = {}

	for i, v in pairs(self.soulData.atts) do
		if v - self.preAtts[i] > 0 then
			uppedAttids[#uppedAttids + 1] = i
		end
	end

	table.sort(uppedAttids, function(a, b)
		return a < b
	end)

	for i, v in ipairs(self.attCellPool) do
		v:SetActive(i <= #uppedAttids)
	end

	for i, v in ipairs(uppedAttids) do
		local attCell = self:GetAttCell(i)
		local tfName = attCell.transform:Find("Sort/Text_01"):GetComponent("Text")
		local tfValuePre = attCell.transform:Find("Text_01"):GetComponent("Text")
		local tfValueCur = attCell.transform:Find("Text_02"):GetComponent("Text")

		tfName.text = SoulEvolutionTipUIApi:GetString("goAttName", AttributeModule.GetAttName(v))
		tfValuePre.text = SoulEvolutionTipUIApi:GetString("goAttValuePre", AttributeModule.GetAttShowValue(v, self.preAtts[v]))
		tfValueCur.text = SoulEvolutionTipUIApi:GetString("goAttValueCur", AttributeModule.GetAttShowValue(v, self.soulData.atts[v]))
	end
end

function SoulEvolutionTipUI:RefreshGrowUpBlock()
	local growUpValuesNow = self.soulData:GetGrowUpValues(self.cfgQualityCur)
	local growUpValuesPre = self.soulData:GetGrowUpValues(self.cfgQualityPre)
	local id2DeltaDic = {}
	local ids = {}

	for i = 1, 6 do
		local delta = growUpValuesNow[i] - growUpValuesPre[i]

		if delta > 0 then
			ids[#ids + 1] = i
			id2DeltaDic[i] = {
				growUpValuesPre[i],
				growUpValuesNow[i]
			}
		end
	end

	for i, v in ipairs(self.growUpCellPool) do
		v:SetActive(i <= #ids)
	end

	for i, v in ipairs(ids) do
		local growUpCell = self:GetGrowUpCell(i)
		local tfName = growUpCell.transform:Find("Sort/Text_01"):GetComponent("Text")
		local tfValuePre = growUpCell.transform:Find("Text_01"):GetComponent("Text")
		local tfValueCur = growUpCell.transform:Find("Text_02"):GetComponent("Text")

		tfName.text = SoulEvolutionTipUIApi:GetString("goGrowUpName", SoulUIApi:GetString("starViewGrowRateName", v))
		tfValuePre.text = SoulEvolutionTipUIApi:GetString("goGrowUpValuePre", id2DeltaDic[v][1])
		tfValueCur.text = SoulEvolutionTipUIApi:GetString("goGrowUpValueNow", id2DeltaDic[v][2])
	end
end

function SoulEvolutionTipUI:RefreshFeatureBlock()
	local existEffect = false
	local newFeatureid

	for i, v in ipairs(self.cfgQualityCur.ADDSkillID) do
		local isNew = true

		for m, n in ipairs(self.cfgQualityPre.ADDSkillID) do
			if v == n then
				isNew = false

				break
			end
		end

		if isNew then
			newFeatureid = v
			existEffect = true

			break
		end
	end

	self.goFeatureName.transform.parent.gameObject:SetActive(existEffect)
	self.goFeatureDesc:SetActive(existEffect)
	self.goLine:SetActive(existEffect)

	if existEffect then
		self.tfFeatureName.text = SoulEvolutionTipUIApi:GetString("goFeatureName", CfgSkillTable[newFeatureid].Name)
		self.tfFeatureLv.text = SoulEvolutionTipUIApi:GetString("goFeatureLv", #self.cfgQualityCur.ADDSkillID)
		self.tfFeatureDesc.text = SoulEvolutionTipUIApi:GetString("goFeatureDesc", UIGlobalApi.GetTextWithoutKeywordTag(CfgSkillTable[self.cfgQualityCur.ADDSkillID[#self.cfgQualityCur.ADDSkillID]].EffectText))
	end
end

function SoulEvolutionTipUI:GetAttCell(index)
	local ret = self.attCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goAttCell)

		ret.transform:SetParent(self.goAttCell.transform.parent, false)

		self.attCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

function SoulEvolutionTipUI:GetGrowUpCell(index)
	local ret = self.growUpCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goGrowUpCell)

		ret.transform:SetParent(self.goGrowUpCell.transform.parent, false)

		self.growUpCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

return SoulEvolutionTipUI
