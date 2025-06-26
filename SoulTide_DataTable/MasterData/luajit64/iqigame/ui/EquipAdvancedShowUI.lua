-- chunkname: @IQIGame\\UI\\EquipAdvancedShowUI.lua

local EquipAdvancedShowUI = Base:Extend("EquipAdvancedShowUI", "IQIGame.Onigao.UI.EquipAdvancedShowUI", {
	interval = 0.1,
	goAttCells = {},
	goEffectCells = {},
	effectIds = {}
})

function EquipAdvancedShowUI:OnInit()
	self:Initialize()
end

function EquipAdvancedShowUI:GetPreloadAssetPaths()
	return nil
end

function EquipAdvancedShowUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipAdvancedShowUI:OnOpen(userData)
	self:Refresh(userData)
end

function EquipAdvancedShowUI:OnClose(userData)
	self:OnHide()
end

function EquipAdvancedShowUI:OnPause()
	return
end

function EquipAdvancedShowUI:OnResume()
	return
end

function EquipAdvancedShowUI:OnCover()
	return
end

function EquipAdvancedShowUI:OnReveal()
	return
end

function EquipAdvancedShowUI:OnRefocus(userData)
	return
end

function EquipAdvancedShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipAdvancedShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipAdvancedShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipAdvancedShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipAdvancedShowUI:Initialize()
	self.equipCell = EquipCell.New(self.goSlot.transform:GetChild(0).gameObject)
	self.equipCell.enableClick = false
	self.goAttCells[1] = self.goAttCell
	self.goEffectCells[1] = self.goEffectCell
	self.tfName = self.goName:GetComponent("Text")
	self.tfLvPre = self.goLvPre:GetComponent("Text")
	self.tfLvNow = self.goLvNow:GetComponent("Text")
	self.icon = self.goIcon:GetComponent("Image")
	self.starCompCur = self.goStarCur:GetComponent("SimpleStarComponent")
	self.tweenCell = self.goSlot:GetComponent("TweenPosition")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goBtnClose.transform:Find("Sort/Text_Name"):GetComponent("Text").text = EquipAdvancedShowUIApi:GetString("goBtnClose")
	self.goTitle:GetComponent("Text").text = EquipAdvancedShowUIApi:GetString("goTitle")
	self.timer = Timer.New(function()
		self:OnTimer()
	end, self.interval, -1)
	self.startMoveTime = EquipAdvancedShowUIApi:GetString("startMoveTime")
	self.showTime = EquipAdvancedShowUIApi:GetString("showTime")
	self.goAttBlockTitle:GetComponent("Text").text = EquipAdvancedShowUIApi:GetString("attBlockTitle")
	self.goPabBlockTitle:GetComponent("Text").text = EquipAdvancedShowUIApi:GetString("pabBlockTitle")
end

function EquipAdvancedShowUI:Refresh(userData)
	self.itemData = userData
	self.cfgSoulPaintingData = self.itemData:GetCfg()

	local retCount = 2

	for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
		if v.PaintingId == self.cfgSoulPaintingData.Id then
			if v.QualityLevel == self.itemData.equipData.star then
				self.cfgSoulPaintingQualityData = v
				retCount = retCount - 1
			end

			if v.QualityLevel == self.itemData.equipData.star - 1 then
				self.cfgSoulPaintingQualityDataPre = v
				retCount = retCount - 1
			end

			if retCount == 0 then
				break
			end
		end
	end

	self:RefreshMisc()
	self:RefreshAtt()
	self:RefreshEffect()
	self:EnableTween(false)
	self.goDetailBlock:SetActive(false)
	self:PlayEffect(9003501, self.goSlot.transform:Find("Effect_Bg").gameObject)
	self:StartTimer()
end

function EquipAdvancedShowUI:OnHide()
	self:StopAllEffect()
	self:StopTimer()
end

function EquipAdvancedShowUI:OnDestroy()
	self.equipCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function EquipAdvancedShowUI:RefreshMisc()
	self.equipCell:Refresh(self.itemData)

	self.tfName.text = EquipAdvancedShowUIApi:GetString("goName", self.cfgSoulPaintingData.Name)

	self.goLvBlock:SetActive(EquipModule.latestBreakEquipLv ~= self.itemData.equipData.lv)

	if EquipModule.latestBreakEquipLv ~= self.itemData.equipData.lv then
		self.tfLvPre.text = EquipAdvancedShowUIApi:GetString("goLv", EquipModule.latestBreakEquipLv, false)
		self.tfLvNow.text = EquipAdvancedShowUIApi:GetString("goLv", self.itemData.equipData.lv, true)
	end

	local path = UIGlobalApi.GetImagePath(self.cfgSoulPaintingData.DrawingSmallSize)

	AssetUtil.LoadImage(self, path, self.icon)
end

function EquipAdvancedShowUI:RefreshAtt()
	local mainId2ValueDic = EquipModule.GetMainAbilityValue(self.cfgSoulPaintingQualityDataPre, self.itemData.equipData.lv)
	local nextMainId2ValueDic = EquipModule.GetMainAbilityValue(self.cfgSoulPaintingQualityData, self.itemData.equipData.lv)
	local mainShowList = {}

	for i, v in pairs(nextMainId2ValueDic) do
		local nextShowValue = EquipAdvancedShowUIApi:GetString("curMainAttValue", AttributeModule.GetAttShowValue(i, v))
		local showValue = EquipAdvancedShowUIApi:GetString("preMainAttValue", 0)

		if mainId2ValueDic[i] ~= nil then
			showValue = EquipAdvancedShowUIApi:GetString("preMainAttValue", AttributeModule.GetAttShowValue(i, mainId2ValueDic[i]))
		end

		local name = EquipAdvancedShowUIApi:GetString("goAttName", i, true)

		mainShowList[#mainShowList + 1] = {
			i,
			nextShowValue - showValue,
			nextShowValue,
			name
		}
	end

	table.sort(mainShowList, function(a, b)
		return a[1] < b[1]
	end)

	local maxCount = #mainShowList

	for i, v in ipairs(self.goAttCells) do
		v:SetActive(i <= maxCount)
	end

	self.goAttBlockTitle:SetActive(maxCount ~= 0)

	for i = 1, maxCount do
		local trans = self:GetGoAttCell(i).transform
		local mould_1 = trans:Find("Mould_Cell_01")

		mould_1.gameObject:SetActive(i <= maxCount)

		if i <= maxCount then
			mould_1:Find("Text_01"):GetComponent("Text").text = mainShowList[i][4]
			mould_1:Find("Text_02"):GetComponent("Text").text = mainShowList[i][3]
			mould_1:Find("Sort_01/Text_01"):GetComponent("Text").text = mainShowList[i][2]
		end

		local path = SoulUIApi:GetString("soulAttIconPath", mainShowList[i][1])

		AssetUtil.LoadImage(self, path, mould_1:Find("Icon_01"):GetComponent("Image"))
	end

	self.starCompCur:UpdateView(self.itemData:GetCfg().StarLimit, self.itemData.equipData.star)

	for i = 1, 5 do
		local goStar = self.goStarBlue.transform:Find("Star_0" .. i).gameObject
		local show = i == self.itemData.equipData.star

		goStar:SetActive(show)
	end
end

function EquipAdvancedShowUI:RefreshEffect()
	local ids = self:GetPabilityIDList(self.cfgSoulPaintingData, self.itemData.equipData.star)
	local idsPre = self:GetPabilityIDList(self.cfgSoulPaintingData, self.itemData.equipData.star - 1)
	local maxCount = #ids

	for i, v in ipairs(self.goEffectCells) do
		v:SetActive(i <= maxCount)
	end

	self.goPabBlockTitle:SetActive(maxCount ~= 0)
	self.goEffectCellRoot:SetActive(maxCount ~= 0)

	for i = 1, maxCount do
		local goCell = self:GetGoEffectCell(i)

		if i <= #ids then
			goCell.transform:Find("Mould_Title_03/Text_01"):GetComponent("Text").text = EquipAdvancedShowUIApi:GetString("pabilityName", CfgPabilityTable[ids[i]].Name)
			goCell.transform:Find("Mould_03/Text_01"):GetComponent("Text").text = EquipAdvancedShowUIApi:GetString("pabilityDesc", UIGlobalApi.GetTextWithoutKeywordTag(CfgPabilityTable[ids[i]].Describe))
		end
	end
end

function EquipAdvancedShowUI:GetPabilityIDList(cfgSoulPaintingData, star)
	local ids = {}

	if #cfgSoulPaintingData.PabilityID[3] > 0 then
		ids[#ids + 1] = cfgSoulPaintingData.PabilityID[3][star]
	end

	if #cfgSoulPaintingData.PabilityID[4] > 0 then
		ids[#ids + 1] = cfgSoulPaintingData.PabilityID[4][star]
	end

	return ids
end

function EquipAdvancedShowUI:GetGoAttCell(index)
	local ret = self.goAttCells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goAttCell)
		self.goAttCells[index] = ret

		ret.transform:SetParent(self.goAttCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function EquipAdvancedShowUI:GetGoEffectCell(index)
	local ret = self.goEffectCells[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goEffectCell)
		self.goEffectCells[index] = ret

		ret.transform:SetParent(self.goEffectCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function EquipAdvancedShowUI:EnableTween(v)
	self.tweenCell.enabled = v

	if v == false then
		self.tweenCell:ResetToBeginning()
	else
		self.tweenCell:PlayForward()
	end
end

function EquipAdvancedShowUI:PlayEffect(effectId, goParent)
	local id = GameEntry.Effect:PlayUIMountPointEffect(effectId, 50000, 0, goParent, 0)

	self.effectIds[id] = id
end

function EquipAdvancedShowUI:StopAllEffect()
	for i, v in pairs(self.effectIds) do
		GameEntry.Effect:StopEffect(v)
	end

	self.effectIds = {}
end

function EquipAdvancedShowUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function EquipAdvancedShowUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function EquipAdvancedShowUI:OnClickBtnClose()
	if self.enableClick then
		UIModule.Close(Constant.UIControllerName.EquipAdvancedShowUI)
	end
end

function EquipAdvancedShowUI:StartTimer()
	self.timer:Start()

	self.duration = 0
	self.enableClick = false
end

function EquipAdvancedShowUI:StopTimer()
	self.timer:Stop()

	self.enableClick = true
end

function EquipAdvancedShowUI:OnTimer()
	self.duration = self.duration + self.interval

	if self.duration >= self.startMoveTime and self.duration < self.startMoveTime + self.interval then
		self:PlayEffect(9003502, self.goSlot.transform:Find("Effect_Point").gameObject)
		self:EnableTween(true)
	elseif self.duration >= self.showTime then
		self.goDetailBlock:SetActive(true)
		self:PlayEffect(9003503, self.goTitle)
		self:StopTimer()
	end
end

return EquipAdvancedShowUI
