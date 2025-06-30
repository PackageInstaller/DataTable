-- chunkname: @IQIGame\\UI\\Soul\\SoulInfoView.lua

local SoulInfoView = {
	attCellPool = {},
	btnClassPool = {},
	featureCellPool = {},
	classType1CellPool = {},
	curClassTypes = {}
}

function SoulInfoView.New(view, mainView)
	local obj = Clone(SoulInfoView)

	obj:Init(view, mainView)

	return obj
end

function SoulInfoView:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.featureCellPool[1] = self.goFeatureCell
	self.startComp = self.goStarParent:GetComponent("SimpleStarComponent")
	self.tfName = self.goName:GetComponent("Text")
	self.tfEnglishName = self.goEnglishName:GetComponent("Text")
	self.tfMaxLv = self.goMaxLv:GetComponent("Text")
	self.tfExpProgress = self.goExpProgress:GetComponent("Text")
	self.tfCv = self.goCv:GetComponent("Text")
	self.tfTalentProgress = self.goBtnTalent.transform:Find("Text_02"):GetComponent("Text")
	self.imgLv10 = self.goImgLv10:GetComponent("Image")
	self.imgLv1 = self.goImgLv1:GetComponent("Image")

	for i = 1, 8 do
		self.attCellPool[i] = self.goAttBlock.transform:Find("Mould_" .. i).gameObject
	end

	for i = 1, 2 do
		self.btnClassPool[i] = self.goSoulClassParent.transform:Find("Button_Type_0" .. i):GetComponent("Button")
	end

	self.classType1CellPool[1] = self.goClassTipCell_1
	self.btnGirl = self.goBtnGirl:GetComponent("Button")
	self.btnLockDetail = self.goBtnLockDetail:GetComponent("Button")
	self.btnMemory = self.goBtnMemory:GetComponent("Button")
	self.btnFeature = self.goBtnFeature:GetComponent("Button")
	self.btnLv = self.goBtnLv:GetComponent("Button")
	self.btnStar = self.goBtnStar:GetComponent("Button")
	self.btnSkill = self.goBtnSkill:GetComponent("Button")
	self.btnTalent = self.goBtnTalent:GetComponent("Button")
	self.btnClass = self.goSoulClassParent.transform:Find("Button_01"):GetComponent("Button")
	self.btnCloseClassTip = self.goBtnCloseClassTip:GetComponent("Button")
	self.btnSpiritLock = self.goBtnSpiritLock:GetComponent("Button")
	self.btnSpiritUnlock = self.goBtnSpiritUnlock:GetComponent("Button")

	function self.onClickBtnCloseClassTipDelegate()
		self:OnClickBtnCloseClassTip()
	end

	function self.onClickBtnClassTipDelegate()
		self:OnClickBtnClassTip()
	end

	function self.onClickBtnTalentDelegate()
		self:OnClickBtnTalent()
	end

	function self.onClickBtnSkillDelegate()
		self:OnClickBtnSkill()
	end

	function self.onClickBtnStarDelegate()
		self:OnClickBtnStar()
	end

	function self.onClickBtnLockDetailDelegate()
		self:OnClickBtnLockDetail()
	end

	function self.onClickBtnFeatureDelegate()
		self:OnClickBtnFeature()
	end

	function self.onClickBtnLvDelegate()
		self:OnClickBtnLv()
	end

	function self.onClickBtnClass1Delegate()
		self:OnClickBtnClass1()
	end

	function self.onClickBtnClass2Delegate()
		self:OnClickBtnClass2()
	end

	function self.onClickBtnMemoryDelegate()
		self:OnClickBtnMemory()
	end

	function self.onClickBtnGirlDelegate()
		self:OnClickBtnGirl()
	end

	function self.onMemoryGetRewardSuccessDelegate(fashionID)
		self:OnMemoryGetRewardSuccess(fashionID)
	end

	function self.onClickBtnSpiritLockDelegate()
		self:OnClickBtnSpiritLock()
	end

	function self.onClickBtnSpiritUnlockDelegate()
		self:OnClickBtnSpiritUnlock()
	end

	function self.onClickBtnJewelryDelegate()
		self:OnClickBtnJewelry()
	end

	function self.DelegateOnUpdateJewelryEvent(soulCid)
		self:OnUpdateJewelryEvent(soulCid)
	end

	function self.DelegateOnUnlockNotify()
		self:OnUnlockFunction()
	end

	self.goLvTitle:GetComponent("Text").text = SoulUIApi:GetString("infoViewLvTitle")
	self.goStarTitle:GetComponent("Text").text = SoulUIApi:GetString("infoViewStarTitle")
	self.goFeatureTitle:GetComponent("Text").text = SoulUIApi:GetString("infoViewFeatureTitle")
	self.goBtnSkill.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("infoViewBtnSkillTxt")
	self.goBtnTalent.transform:Find("Text_01"):GetComponent("Text").text = SoulUIApi:GetString("infoViewBtnTalentTitle_1")
	self.goBtnTalent.transform:Find("Text_03"):GetComponent("Text").text = SoulUIApi:GetString("infoViewBtnTalentTitle_2")
	self.goBtnMemory.transform:Find("Text_Unlock"):GetComponent("Text").text = SoulUIApi:GetString("infoViewMemoryDesc")
	self.goBtnSpiritLock.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("infoViewBtnSpiritTxt")
	self.goBtnSpiritUnlock.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("infoViewBtnSpiritTxt")
	self.goCvDesc:GetComponent("Text").text = SoulUIApi:GetString("infoViewCvDesc")

	UGUIUtil.SetText(self.goBtnJewelryLabel, SoulUIApi:GetString("infoViewBtnJewelryLabel"))

	self.jewelryItemCell = ItemCell.New(self.jewelryItem.transform:GetChild(0).gameObject, false, false)

	self.goBtnJewelry:SetActive(false)
end

function SoulInfoView:Open(soulData)
	self.soulData = soulData

	self.View:SetActive(true)
	self:OnClickBtnCloseClassTip()
	self:RefreshMisc()
	self:RefreshLvBlock()
	self:RefreshAttBlock()
	self:RefreshFeatureBlock()
	self:RefreshSpiritBlock()
	self:RefreshJewelryBlock()
	self:AddListeners()
	self:RefreshRedPoints()
end

function SoulInfoView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function SoulInfoView:OnHide()
	self:RemoveListeners()
end

function SoulInfoView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.jewelryItemCell:Dispose()

	self.mainView = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SoulInfoView:AddListeners()
	self:RemoveListeners()
	self.btnLockDetail.onClick:AddListener(self.onClickBtnLockDetailDelegate)
	self.btnMemory.onClick:AddListener(self.onClickBtnMemoryDelegate)
	self.btnFeature.onClick:AddListener(self.onClickBtnFeatureDelegate)
	self.btnLv.onClick:AddListener(self.onClickBtnLvDelegate)
	self.btnStar.onClick:AddListener(self.onClickBtnStarDelegate)
	self.btnSkill.onClick:AddListener(self.onClickBtnSkillDelegate)
	self.btnTalent.onClick:AddListener(self.onClickBtnTalentDelegate)
	self.btnClass.onClick:AddListener(self.onClickBtnClassTipDelegate)
	self.btnGirl.onClick:AddListener(self.onClickBtnGirlDelegate)
	self.btnCloseClassTip.onClick:AddListener(self.onClickBtnCloseClassTipDelegate)
	self.btnSpiritUnlock.onClick:AddListener(self.onClickBtnSpiritUnlockDelegate)
	self.btnSpiritLock.onClick:AddListener(self.onClickBtnSpiritLockDelegate)
	self.goBtnJewelry:GetComponent("Button").onClick:AddListener(self.onClickBtnJewelryDelegate)

	for i = 1, 2 do
		if i == 1 then
			self.btnClassPool[i].onClick:AddListener(self.onClickBtnClass1Delegate)
		elseif i == 2 then
			self.btnClassPool[i].onClick:AddListener(self.onClickBtnClass2Delegate)
		end
	end

	EventDispatcher.AddEventListener(EventID.MemoryGetRewardEvent, self.onMemoryGetRewardSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateJewelryEvent, self.DelegateOnUpdateJewelryEvent)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockNotify)
end

function SoulInfoView:RemoveListeners()
	self.btnLockDetail.onClick:RemoveListener(self.onClickBtnLockDetailDelegate)
	self.btnMemory.onClick:RemoveListener(self.onClickBtnMemoryDelegate)
	self.btnFeature.onClick:RemoveListener(self.onClickBtnFeatureDelegate)
	self.btnLv.onClick:RemoveListener(self.onClickBtnLvDelegate)
	self.btnStar.onClick:RemoveListener(self.onClickBtnStarDelegate)
	self.btnSkill.onClick:RemoveListener(self.onClickBtnSkillDelegate)
	self.btnTalent.onClick:RemoveListener(self.onClickBtnTalentDelegate)
	self.btnClass.onClick:RemoveListener(self.onClickBtnClassTipDelegate)
	self.btnGirl.onClick:RemoveListener(self.onClickBtnGirlDelegate)
	self.btnCloseClassTip.onClick:RemoveListener(self.onClickBtnCloseClassTipDelegate)
	self.btnSpiritUnlock.onClick:RemoveListener(self.onClickBtnSpiritUnlockDelegate)
	self.btnSpiritLock.onClick:RemoveListener(self.onClickBtnSpiritLockDelegate)
	self.goBtnJewelry:GetComponent("Button").onClick:RemoveListener(self.onClickBtnJewelryDelegate)

	for i = 1, 2 do
		if i == 1 then
			self.btnClassPool[i].onClick:RemoveListener(self.onClickBtnClass1Delegate)
		elseif i == 2 then
			self.btnClassPool[i].onClick:RemoveListener(self.onClickBtnClass2Delegate)
		end
	end

	EventDispatcher.RemoveEventListener(EventID.MemoryGetRewardEvent, self.onMemoryGetRewardSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateJewelryEvent, self.DelegateOnUpdateJewelryEvent)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockNotify)
end

function SoulInfoView:OnMemoryGetRewardSuccess(fashionID)
	self:RefreshMemoryInfo()
end

function SoulInfoView:OnClickBtnGirl()
	JumpModule.Jump(10708001, self.soulData)
end

function SoulInfoView:OnClickBtnClassTip()
	self:ShowClassTip()
end

function SoulInfoView:OnClickBtnCloseClassTip()
	self:CloseClassTip()
end

function SoulInfoView:OnClickBtnClass1()
	self:ShowClassTip2(self.curClassTypes[1])
end

function SoulInfoView:OnClickBtnClass2()
	self:ShowClassTip2(self.curClassTypes[2])
end

function SoulInfoView:OnClickBtnFeature()
	UIModule.Open(Constant.UIControllerName.SoulEvolutionInfoUI, Constant.UILayer.UI, self.soulData)
end

function SoulInfoView:OnClickBtnLockDetail()
	UIModule.Open(Constant.UIControllerName.SoulLockUI, Constant.UILayer.UI, self.soulData)
end

function SoulInfoView:OnClickBtnMemory()
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.MEMORY) then
		NoticeModule.ShowNoticeByType(1, CfgFunctionTypeTable[Constant.UnlockType.MEMORY].LockNotice)

		return
	end

	local minLv = MemoryModule.GetUnlockMemoryMinLv(self.soulData.soulCid)

	if minLv > self.soulData.favorLv then
		NoticeModule.ShowNoticeByType(1, GirlUIApi:GetString("UnlockMemoryLv", minLv))

		return
	end

	MemoryModule.OpenMemoryUI(self.soulData.soulCid)
end

function SoulInfoView:OnClickBtnLv()
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_UP_LV) then
		NoticeModule.ShowNoticeNoCallback(21045013)

		return
	end

	self.mainView:RefreshView(2)
end

function SoulInfoView:OnClickBtnStar()
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_UP_STAR) then
		NoticeModule.ShowNoticeNoCallback(21045013)

		return
	end

	self.mainView:RefreshView(3)
end

function SoulInfoView:OnClickBtnSkill()
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_SKILL) then
		NoticeModule.ShowNoticeNoCallback(21045013)

		return
	end

	self.mainView:RefreshView(5)
end

function SoulInfoView:OnClickBtnTalent()
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_TALENT) then
		NoticeModule.ShowNoticeNoCallback(21045013)

		return
	end

	self.mainView:RefreshView(4)
end

function SoulInfoView:OnClickBtnSpiritLock()
	NoticeModule.ShowNoticeNoCallback(21059001)
end

function SoulInfoView:OnClickBtnSpiritUnlock()
	self.mainView:RefreshView(6)
end

function SoulInfoView:RefreshMisc()
	self.tfName.text = SoulUIApi:GetString("goSoulName", self.soulData:GetCfgSoul().Name)
	self.tfEnglishName.text = SoulUIApi:GetString("goSoulEnglishName", self.soulData:GetCfgSoul().EnglishName)
	self.tfCv.text = SoulUIApi:GetString("goCv", self.soulData:GetCfgSoul().CVName)
	self.tfTalentProgress.text = SoulUIApi:GetString("infoViewTalentProgress", #self.soulData.talentCids, self.soulData.totalTalentCount)

	local isHide = self.soulData:GetCfgSoul().HideCVName or false

	self.cvNode:SetActive(not isHide)

	local classTypes = self.soulData:GetCfgSoul().SoulClass

	self.curClassTypes = {}

	for i, v in ipairs(self.btnClassPool) do
		v.gameObject:SetActive(i <= #classTypes)
	end

	for i, v in ipairs(classTypes) do
		local path = MiscApi:GetString("SoulClassMixIconPath", v)

		AssetUtil.LoadImage(self, path, self.btnClassPool[i].transform:Find("Soul_Type_0" .. i):GetComponent("Image"))

		self.curClassTypes[i] = v
	end

	local curStar = self.soulData:GetCfgSoulQuality().Quality

	self.startComp:UpdateView(5, curStar)
	self:RefreshMemoryInfo()
end

function SoulInfoView:RefreshSpiritBlock()
	local isUnlockSpiritFun = self.soulData:GetCfgSoul().UnlockSpecialSpirit

	self.goBtnSpiritUnlock:SetActive(isUnlockSpiritFun)
	self.goBtnSpiritLock:SetActive(not isUnlockSpiritFun)

	if isUnlockSpiritFun then
		self.goSpRedPoint:SetActive(SoulModule.CheckSpRedPoint(self.soulData))
	end
end

function SoulInfoView:RefreshMemoryInfo()
	local unlockCount = 0
	local infos = MemoryModule.GetSoulMemoryChaptersBySoulID(self.soulData.soulCid)

	for i, v in ipairs(infos) do
		if v.isGetReward then
			unlockCount = unlockCount + 1
		end
	end

	local totalCount = 0

	for i, v in pairsCfg(CfgSoulMemoryChapterTable) do
		if v.SoulId == self.soulData.soulCid then
			totalCount = totalCount + 1
		end
	end

	local tfUnlockIndex = self.goBtnMemory.transform:Find("Sort/Text_01"):GetComponent("Text")
	local tfTotalCount = self.goBtnMemory.transform:Find("Sort/Text_02"):GetComponent("Text")

	tfUnlockIndex.text = SoulUIApi:GetString("infoViewMemoryUnlockDesc", unlockCount)
	tfTotalCount.text = SoulUIApi:GetString("infoViewMemoryTotalCount", totalCount)
end

function SoulInfoView:RefreshLvBlock()
	local curExp = self.soulData.exp
	local cfgData = CfgSoulLevelTable[self.soulData.lv]
	local needExp = cfgData.NextEXP

	self.goImgLv10:SetActive(self.soulData.lv > 9)

	if self.soulData.lv > 9 then
		AssetUtil.LoadImage(self, SoulUIApi:GetString("imgLvPath", math.floor(self.soulData.lv / 10)), self.imgLv10)
	end

	AssetUtil.LoadImage(self, SoulUIApi:GetString("imgLvPath", self.soulData.lv % 10), self.imgLv1)

	self.tfMaxLv.text = SoulUIApi:GetString("maxLv", SoulModule.GetMaxSoulLv())
	self.tfExpProgress.text = SoulUIApi:GetString("infoViewExpProgress", curExp, needExp)
end

function SoulInfoView:RefreshAttBlock()
	local idToValueDic = {}
	local attrs = self.soulData.atts
	local ids = SoulUIApi:GetString("fightAttSort")

	for i, v in ipairs(ids) do
		idToValueDic[v] = 0

		if attrs[v] ~= nil then
			idToValueDic[v] = attrs[v]
		end
	end

	for i, v in ipairs(self.attCellPool) do
		v:SetActive(i <= #ids)
	end

	for i, v in ipairs(ids) do
		local cell = self.attCellPool[i]
		local tfValue = cell.transform:Find("Text_03"):GetComponent("Text")
		local tfName = cell.transform:Find("Text_02"):GetComponent("Text")
		local icon = cell.transform:Find("Icon_01"):GetComponent("Image")

		tfValue.text = SoulUIApi:GetString("attViewAttValue", AttributeModule.GetAttShowValue(v, idToValueDic[v]))
		tfName.text = SoulUIApi:GetString("infoViewAttName", AttributeModule.GetAttName(v))

		local path = SoulUIApi:GetString("soulAttIconPath", v)

		AssetUtil.LoadImage(self, path, icon)
	end
end

function SoulInfoView:RefreshFeatureBlock()
	for i, v in ipairs(self.featureCellPool) do
		v:SetActive(i <= #self.soulData.maxStarFeatureIds)
	end

	for i, v in ipairs(self.soulData.maxStarFeatureIds) do
		local cfgSkillData = CfgSkillTable[v]
		local cell = self:GetFeatureCell(i)
		local tfNameUnlock = cell.transform:Find("Feature_Off/Text_01"):GetComponent("Text")
		local tfNameUnlock2 = cell.transform:Find("Feature_Off/Text_02"):GetComponent("Text")
		local tfNameLock = cell.transform:Find("Feature_On/Text"):GetComponent("Text")
		local isUnlock = self.soulData:CheckFeatureUnlock(v)
		local unlockStar = self:GetFeatureUnlockStar(v)

		tfNameUnlock.text = SoulUIApi:GetString("infoViewFeatureName", cfgSkillData.Name, isUnlock, unlockStar)
		tfNameLock.text = SoulUIApi:GetString("infoViewFeatureName", cfgSkillData.Name, isUnlock, unlockStar)
		tfNameUnlock2.text = SoulUIApi:GetString("infoViewFeatureName2")

		cell.transform:Find("Feature_Off").gameObject:SetActive(not isUnlock)
		cell.transform:Find("Feature_On").gameObject:SetActive(isUnlock)
	end

	local unlockCount = 0

	for i, v in ipairs(self.soulData.maxStarFeatureIds) do
		if self.soulData:CheckFeatureUnlock(v) then
			unlockCount = unlockCount + 1
		end
	end
end

function SoulInfoView:GetFeatureCell(index)
	local ret = self.featureCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goFeatureCell)
		self.featureCellPool[index] = ret

		ret.transform:SetParent(self.goFeatureCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function SoulInfoView:GetFeatureUnlockStar(featureId)
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

function SoulInfoView:RefreshRedPoints()
	self:RefreshRedPointUpLv()
	self:RefreshRedPointUpStar()
	self:RefreshTalentRedPoint()
	self:RefreshSkillRedPoint()
	self:RefreshJewelryRedPoint()
end

function SoulInfoView:RefreshRedPointUpLv()
	local ret = SoulModule.CheckSoulLvUpRedPoint(self.soulData)

	self.goBtnLv.transform:Find("RedPoint").gameObject:SetActive(ret)
end

function SoulInfoView:RefreshRedPointUpStar()
	local ret = SoulModule.CheckSoulStarUpRedPoint(self.soulData)

	self.goBtnStar.transform:Find("RedPoint").gameObject:SetActive(ret)
end

function SoulInfoView:RefreshTalentRedPoint()
	local ret = SoulModule.CheckTalentTabRedPoint(self.soulData)

	self.goBtnTalent.transform:Find("RedPoint").gameObject:SetActive(ret)
end

function SoulInfoView:RefreshSkillRedPoint()
	local ret = SoulModule.CheckSkillTabRedPoint(self.soulData)

	self.goBtnSkill.transform:Find("RedPoint").gameObject:SetActive(ret)
end

function SoulInfoView:RefreshJewelryRedPoint()
	local ret = false

	self.goJewelryRed:SetActive(ret)
end

function SoulInfoView:ShowClassTip()
	self.goClassTip:SetActive(true)
	self.goClassTip1View:SetActive(true)
	self.goClassTip2View:SetActive(false)

	local classTypes = {
		1,
		2,
		3
	}

	for i, v in ipairs(self.classType1CellPool) do
		v:SetActive(false)
	end

	for i, v in ipairs(classTypes) do
		local classTipCell = self.classType1CellPool[i]

		if classTipCell == nil then
			classTipCell = UnityEngine.Object.Instantiate(self.goClassTipCell_1)

			classTipCell.transform:SetParent(self.goClassTipCell_1.transform.parent, false)

			self.classType1CellPool[i] = classTipCell
		end

		classTipCell:SetActive(true)

		classTipCell.transform:Find("Text_01"):GetComponent("Text").text = SoulUIApi:GetString("infoViewClassTipContent", v)

		AssetUtil.LoadImage(self, MiscApi:GetString("SoulClassMixIconPath", v), classTipCell.transform:Find("Image_Type"):GetComponent("Image"))
	end
end

function SoulInfoView:CloseClassTip()
	self.goClassTip:SetActive(false)
end

function SoulInfoView:ShowClassTip2(type)
	self.goClassTip:SetActive(true)
	self.goClassTip1View:SetActive(false)
	self.goClassTip2View:SetActive(true)

	self.goClassTipCell_2.transform:Find("Text_01"):GetComponent("Text").text = SoulUIApi:GetString("infoViewClassTipContent", type)
end

function SoulInfoView:OnUnlockFunction()
	if self.soulData then
		self:RefreshJewelryBlock()
	end
end

function SoulInfoView:OnUpdateJewelryEvent(soulCid)
	if self.soulData.soulCid == soulCid then
		self:RefreshAttBlock()
		self:RefreshJewelryBlock()
	end
end

function SoulInfoView:RefreshJewelryBlock()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.JEWELRY)

	self.jewelryNode:SetActive(true)
	self.jewelryItem:SetActive(false)

	if result then
		if #self.soulData:GetJewelryIds() > 0 then
			self.jewelryItem:SetActive(true)

			local jewelryID = self.soulData:GetJewelryIds()[1]

			self.jewelryItemCell:SetItemByCID(jewelryID)
			self.goBtnJewelryLabel:SetActive(false)
		else
			self.jewelryItem:SetActive(false)
			self.goBtnJewelryLabel:SetActive(true)
		end
	end
end

function SoulInfoView:OnClickBtnJewelry()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.JEWELRY)

	if not result then
		NoticeModule.ShowNoticeNoCallback(21045085)

		return
	end
end

return SoulInfoView
