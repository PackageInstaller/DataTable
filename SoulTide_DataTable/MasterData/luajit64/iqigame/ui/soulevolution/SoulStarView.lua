-- chunkname: @IQIGame\\UI\\SoulEvolution\\SoulStarView.lua

local SoulStarView = {
	itemCellPool = {},
	attDeltaCellPool = {},
	growDeltaCellPool = {}
}
local SoulStarMap = require("IQIGame.UI.SoulEvolution.SoulStarMap")

function SoulStarView.New(view, mainView)
	local obj = Clone(SoulStarView)

	obj:Init(view, mainView)

	return obj
end

function SoulStarView:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.map = SoulStarMap.New(self.goMapParent, self.mainView)
	self.tfMoneyNum = self.goMoneyNum:GetComponent("Text")
	self.tfFeatureTitle = self.goFeatureTitle:GetComponent("Text")
	self.tfFeatureName = self.goFeatureName:GetComponent("Text")

	for i = 1, 3 do
		local go = self.goItemCellParent.transform:Find("Item_0" .. i).gameObject

		self.itemCellPool[i] = ItemCell2.New(go)
	end

	for i = 1, 3 do
		self.attDeltaCellPool[i] = self.goAttDeltaCellParent.transform:Find("Mould_" .. i).gameObject
		self.growDeltaCellPool[i] = self.goGrowDeltaCellParent.transform:Find("Mould_" .. i).gameObject
	end

	self.btnUp = self.goBtnUp:GetComponent("Button")
	self.btnDetail = self.goBtnDetail:GetComponent("Button")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnGuide = self.goTitleBlock.transform:Find("Button_02"):GetComponent("Button")

	function self.onClickBtnDetailDelegate()
		self:OnClickBtnDetail()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnGuideDelegate()
		self:OnClickBtnGuide()
	end

	function self.onClickBtnUpDelegate()
		self:OnClickBtnUP()
	end

	function self.onUpStarSuccessDelegate()
		self:OnUpStarSuccess()
	end

	function self.onUpdateItemDelegate()
		self:OnUpdateItem()
	end

	self.goBtnUp.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("starViewBtnUpTxt")
	self.goMax:GetComponent("Text").text = SoulUIApi:GetString("starViewMaxDesc")
	self.goDesc:GetComponent("Text").text = SoulUIApi:GetString("starViewDesc")
	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("Title", 3)
	self.goTitleBlock.transform:Find("Info/Text_01"):GetComponent("Text").text = SoulUIApi:GetString("TitleEng", 3)
	self.goTitleBlock.transform:Find("Info/Text_02"):GetComponent("Text").text = SoulUIApi:GetString("TitleHelp", 3)
	self.goBtnDetail.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("btnAttDetailTxt")
end

function SoulStarView:Open(soulData)
	self.soulData = soulData

	self.View:SetActive(true)
	self:RefreshMisc()
	self:RefreshDeltaBlock()
	self:RefreshCostBlock()
	self:RefreshMap()
	self:AddListeners()
end

function SoulStarView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function SoulStarView:OnHide()
	self.map:OnHide()
	self:RemoveListeners()
end

function SoulStarView:OnDestroy()
	self.map:OnDestroy()

	for i, v in pairs(self.itemCellPool) do
		v:OnDestroy()
	end

	self.mainView = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SoulStarView:AddListeners()
	self:RemoveListeners()
	self.btnUp.onClick:AddListener(self.onClickBtnUpDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnGuide.onClick:AddListener(self.onClickBtnGuideDelegate)
	self.btnDetail.onClick:AddListener(self.onClickBtnDetailDelegate)
	EventDispatcher.AddEventListener(EventID.EvolveSoulSuccess, self.onUpStarSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.onUpdateItemDelegate)
end

function SoulStarView:RemoveListeners()
	self.btnUp.onClick:RemoveListener(self.onClickBtnUpDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnGuide.onClick:RemoveListener(self.onClickBtnGuideDelegate)
	self.btnDetail.onClick:RemoveListener(self.onClickBtnDetailDelegate)
	EventDispatcher.RemoveEventListener(EventID.EvolveSoulSuccess, self.onUpStarSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.onUpdateItemDelegate)
end

function SoulStarView:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.SoulEvolutionUI)
end

function SoulStarView:OnClickBtnGuide()
	return
end

function SoulStarView:OnClickBtnDetail()
	self.mainView.attTipView:Open(self.soulData, 1)
end

function SoulStarView:OnClickBtnUP()
	if self.soulData:CheckFullQuality() then
		NoticeModule.ShowNotice(21041016)

		return
	end

	if self.soulData:CheckItemEnoughToUpQualityLv() == false then
		NoticeModule.ShowNotice(21041015)

		return
	end

	SoulModule.ReqUpQuality(self.soulData.soulCid)
end

function SoulStarView:OnUpStarSuccess()
	self:RefreshMisc()
	self:RefreshDeltaBlock()
	self:RefreshCostBlock()
	self.map:OnUpStarSuccess()
	UIModule.Open(Constant.UIControllerName.SoulEvolutionTipUI, Constant.UILayer.UI, {
		self.soulData,
		SoulModule.lastUpStarAtts
	})
end

function SoulStarView:OnUpdateItem()
	self:RefreshCostBlock()
end

function SoulStarView:RefreshMisc()
	self.isMax = self.soulData:CheckFullQuality()

	self.goMax.transform.parent.gameObject:SetActive(self.isMax)
	self.goMoneyNum.transform.parent.gameObject:SetActive(not self.isMax)
	self.goBtnUp:SetActive(not self.isMax)
	self.goItemCellParent.transform.parent.gameObject:SetActive(not self.isMax)

	local unlockCount = 0

	for i, v in ipairs(self.soulData.maxStarFeatureIds) do
		if self.soulData:CheckFeatureUnlock(v) then
			unlockCount = unlockCount + 1
		end
	end
end

function SoulStarView:RefreshDeltaBlock()
	self.goBottomInfoBlock:SetActive(not self.isMax)

	if self.isMax then
		return
	end

	local cfgQualityDataNow = self.soulData:GetCfgSoulQuality()
	local cfgQualityDataNext = self.soulData:GetCfgSoulQualityNext()

	for i = 1, 3 do
		local type = cfgQualityDataNow.AttType[i]
		local valueDelta = cfgQualityDataNext.AttValue[i] - cfgQualityDataNow.AttValue[i]
		local cell = self.attDeltaCellPool[i]

		cell.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("starViewAttDeltaDesc", AttributeModule.GetAttName(type), AttributeModule.GetAttShowValue(type, valueDelta))

		cell:SetActive(valueDelta ~= 0)
	end

	local growUpValuesNow = self.soulData:GetGrowUpValues(cfgQualityDataNow)
	local growUpValuesNext = self.soulData:GetGrowUpValues(cfgQualityDataNext)
	local types = {}

	for i, v in ipairs(growUpValuesNow) do
		if v ~= 0 then
			types[#types + 1] = i
		end
	end

	for i = 1, 3 do
		local type = types[i]
		local valueDelta = growUpValuesNext[type] - growUpValuesNow[type]
		local cell = self.growDeltaCellPool[i]

		cell.transform:Find("Text"):GetComponent("Text").text = SoulUIApi:GetString("starViewGrowDeltaDesc", SoulUIApi:GetString("starViewGrowRateName", type), valueDelta)

		cell:SetActive(valueDelta ~= 0)
	end

	local newFeatureid

	for i, v in ipairs(cfgQualityDataNext.ADDSkillID) do
		local isNew = true

		for m, n in ipairs(cfgQualityDataNow.ADDSkillID) do
			if v == n then
				isNew = false

				break
			end
		end

		if isNew then
			newFeatureid = v

			break
		end
	end

	self.goFeatureTitle:SetActive(newFeatureid ~= nil)
	self.goFeatureName:SetActive(newFeatureid ~= nil)

	if newFeatureid ~= nil then
		self.tfFeatureTitle.text = SoulUIApi:GetString("starViewFeatureTitle", #cfgQualityDataNext.ADDSkillID)
		self.tfFeatureName.text = SoulUIApi:GetString("starViewFeatureName", CfgSkillTable[newFeatureid].Name)
	end
end

function SoulStarView:RefreshCostBlock()
	if self.isMax then
		return
	end

	local ids = self.soulData:GetUpQualityLvItemIds()
	local itemCids = {}
	local costMoney = false

	for i, v in ipairs(ids) do
		if v ~= nil then
			if v ~= 1 then
				itemCids[#itemCids + 1] = v
			else
				costMoney = true
			end
		end
	end

	for i, v in ipairs(self.itemCellPool) do
		v:SetActive(i <= #itemCids)
	end

	for i, v in ipairs(self.itemCellPool) do
		local cid = itemCids[i]

		if cid ~= nil then
			local costCount = self.soulData:GetCostCountOnStageItem(cid)

			v:SetActive(true)
			v:Refresh(cid, costCount)
		end
	end

	self.goMoneyNum.transform.parent.gameObject:SetActive(not self.isMax and costMoney)

	if costMoney then
		self.tfMoneyNum.text = SoulUIApi:GetString("starViewMoneyNum", self.soulData:GetCostCountOnStageItem(1), WarehouseModule.GetItemNumByCfgID(1))
	end

	self.goBtnUp:SetActive(not self.isMax)
	self.goItemCellParent.transform.parent.gameObject:SetActive(not self.isMax)
end

function SoulStarView:RefreshMap()
	self.map:Refresh(self.soulData)
end

return SoulStarView
