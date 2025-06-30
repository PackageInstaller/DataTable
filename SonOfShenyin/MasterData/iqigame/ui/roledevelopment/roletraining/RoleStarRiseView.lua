-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\RoleStarRiseView.lua

local AttrItem = {}

function AttrItem.New(view)
	local obj = Clone(AttrItem)

	obj:__Init(view)

	return obj
end

function AttrItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function AttrItem:Show(attrType, curAttrValue, nextAttrValue)
	self.gameObject:SetActive(true)

	local attributeData = CfgAttributeTable[attrType]

	UGUIUtil.SetText(self.AttrName, attributeData.Name)
	UGUIUtil.SetText(self.CurAttrNumText, curAttrValue)
	UGUIUtil.SetText(self.NextAttrNumText, nextAttrValue)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attributeData.ImageUrl), self.AttrImg:GetComponent("Image"))
end

function AttrItem:Hide()
	self.gameObject:SetActive(false)
end

function AttrItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local m = {
	ObjectPool = {},
	StarObjectPool = {},
	ItemList = {},
	AttrQualityItemList = {},
	AttrTypeList = {}
}
local MONEYINDEX = 4
local PresentStarItem = require("IQIGame.UI.RoleDevelopment.RoleTraining.PresentStarItem")
local attrGrowupQualityItemCell = require("IQIGame.UI.RoleDevelopment.ItemCell.AttrGrowupQualityItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.radarManager = self.RadarManager:GetComponent("UIRadarGraphManager")
	self.radarManager._rulingCount = CfgDiscreteDataTable[83].Data[1]
	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)
	self.AttrQualityItemList[Constant.Attribute.TYPE_ATTACK_GROWUP] = attrGrowupQualityItemCell.New(self.attackItem)
	self.AttrQualityItemList[Constant.Attribute.TYPE_HP_GROWUP] = attrGrowupQualityItemCell.New(self.hpItem)
	self.AttrQualityItemList[Constant.Attribute.TYPE_DEFENSE_GROWUP] = attrGrowupQualityItemCell.New(self.defenceItem)
	self.AttrTypeList = {
		Constant.Attribute.TYPE_HP_GROWUP,
		Constant.Attribute.TYPE_ATTACK_GROWUP,
		Constant.Attribute.TYPE_DEFENSE_GROWUP
	}
	self.attViewTable = {}

	ForTransformChild(self.attRoot.transform, function(_trans, _index)
		local item = AttrItem.New(_trans.gameObject)

		table.insert(self.attViewTable, item)
	end)
	self:InitDelegation()
	self:AddListeners()
	self:InitializeStaticText()
end

function m:InitializeStaticText()
	return
end

function m:InitDelegation()
	function self.DelegateScrollChangeHeroEvent(heroCid)
		if not self.View.activeSelf then
			return
		end

		self.SelectHeroCid = heroCid

		if CfgHeroTable[self.SelectHeroCid].StarLevelSwitch > 0 then
			self:SetData(heroCid)
		end
	end

	function self.DelegateConfirmBtnClick()
		self:ConfirmBtnClick()
	end

	function self.DelegateAscendingStartSucess()
		self:AscendingStartSucess()
	end
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.ScrollChangeHeroEvent, self.DelegateScrollChangeHeroEvent)
	EventDispatcher.AddEventListener(EventID.AscendingStartSucess, self.DelegateAscendingStartSucess)
	self.confirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateConfirmBtnClick)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.ScrollChangeHeroEvent, self.DelegateScrollChangeHeroEvent)
	EventDispatcher.RemoveEventListener(EventID.AscendingStartSucess, self.DelegateAscendingStartSucess)
	self.confirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateConfirmBtnClick)
end

function m:SetData(heroCid)
	self.SelectHeroCid = heroCid or self.SelectHeroCid
	self.ObjectPool = self.ObjectPool or {}
	self.objectPoolIndex = 0
	self.IsCellNumZero = true
	self.MoneyNum = 0
	self.HeroData = WarlockModule.WarlockDataDic[heroCid]
	self.LastHeroData = Clone(self.HeroData)
	self.IsMaterialsEnough = true
	self.CfgHeroStarLevelDatas = RoleDevelopmentModule.GetHeroStarLvCfgs(heroCid)
	self.CfgHeroStarLevelData = RoleDevelopmentModule.GetNextStarCfg(self.CfgHeroStarLevelDatas, self.HeroData.starLevel, self.HeroData.starTime)
	self.CurrentCfgHeroStarLevelData = RoleDevelopmentModule.GetCurrentStarCfg(self.CfgHeroStarLevelDatas, self.HeroData.starLevel, self.HeroData.starTime)
	self.isMaxStar = RoleDevelopmentModule.GetStarRiseCount(self.CfgHeroStarLevelDatas, self.HeroData.starLevel, self.HeroData.starTime) >= CfgHeroTable[self.SelectHeroCid].StarLevelSwitch

	LuaUtility.SetGameObjectShow(self.RefineMaxState, false)
	LuaUtility.SetGameObjectShow(self.confirmBtn, true)
	LuaUtility.SetGameObjectShow(self.confirmBtn, true)
	LuaUtility.SetGameObjectShow(self.consumptionMaterial, true)
	self:SetHeroStarLevelData()
	self:__RefreshAttrs()
end

function m:__RefreshAttrs()
	if self.CfgHeroStarLevelData == nil or self.isMaxStar then
		ForPairs(self.attViewTable, function(_, _attrCell)
			_attrCell:Hide()
		end)

		return
	end

	self.cacheAttrData = {}

	ForPairs(self.attViewTable, function(_index, _attrCell)
		local attrType = self.CurrentCfgHeroStarLevelData.AttrType[_index]
		local curAttrValue = self.CurrentCfgHeroStarLevelData.AttrValue[_index]
		local nextAttrValue = self.CfgHeroStarLevelData.AttrValue[_index]

		self.cacheAttrData[attrType] = {
			value = curAttrValue,
			nextValue = nextAttrValue
		}

		_attrCell:Show(attrType, curAttrValue, nextAttrValue)
	end)
end

function m:RefreshRadarInfo()
	if self.CfgHeroStarLevelData == nil or self.isMaxStar then
		LuaUtility.SetGameObjectShow(self.NextRadar, false)
	else
		LuaUtility.SetGameObjectShow(self.NextRadar, true)
		self:RefreshRadarData(self.radarManager.RadarDatas[0], self.CfgHeroStarLevelData)
	end

	self:RefreshRadarData(self.radarManager.RadarDatas[1], self.CurrentCfgHeroStarLevelData)
	self:RefreshAttrQuality()
end

function m:RefreshRadarData(radarDataCom, starLvCfg)
	for j = 0, radarDataCom.Datas.Length - 1 do
		local type = self:GetCurrentAttrTypeWithIndex(j)

		radarDataCom.Datas[j]._value = self:GetAttrGrowupValue(starLvCfg, type)

		if type == Constant.Attribute.TYPE_HP_GROWUP then
			radarDataCom.Datas[j]._MaxValue = CfgDiscreteDataTable[80].Data[#CfgDiscreteDataTable[80].Data] / 100
		elseif type == Constant.Attribute.TYPE_DEFENSE_GROWUP then
			radarDataCom.Datas[j]._MaxValue = CfgDiscreteDataTable[82].Data[#CfgDiscreteDataTable[82].Data] / 100
		elseif type == Constant.Attribute.TYPE_ATTACK_GROWUP then
			radarDataCom.Datas[j]._MaxValue = CfgDiscreteDataTable[81].Data[#CfgDiscreteDataTable[81].Data] / 100
		end
	end

	self.radarManager:RefeshRadarGraph()
end

function m:RefreshAttrQuality()
	for k, v in pairs(self.AttrTypeList) do
		local curValue = self:GetAttrGrowupValue(self.CurrentCfgHeroStarLevelData, v)
		local nextValue

		if self.CfgHeroStarLevelData ~= nil then
			nextValue = self:GetAttrGrowupValue(self.CfgHeroStarLevelData, v)
		end

		self.AttrQualityItemList[v]:SetData(curValue, nextValue, v)
	end
end

function m:GetAttrGrowupValue(starLvCfg, type)
	local attrValue = self:GetCurrentAttrValueWithType(starLvCfg, type)
	local baseAttrValue = RoleDevelopmentModule.GetHeroBaseAttrData(self.HeroData.cid, type)
	local breakAttrValue = RoleDevelopmentModule.GetHeroBreakAttrValueByType(self.HeroData.cid, type)

	return attrValue + baseAttrValue + breakAttrValue
end

function m:GetCurrentAttrTypeWithIndex(index)
	local type

	if index == 0 then
		type = Constant.Attribute.TYPE_HP_GROWUP
	elseif index == 1 then
		type = Constant.Attribute.TYPE_DEFENSE_GROWUP
	elseif index == 2 then
		type = Constant.Attribute.TYPE_ATTACK_GROWUP
	end

	return type
end

function m:GetCurrentAttrValueWithType(starCfg, type)
	return RoleDevelopmentModule.GetAttrDataByStarCfg(starCfg, type)
end

function m:SetHeroStarLevelData()
	if self.CfgHeroStarLevelData == nil or self.isMaxStar then
		self:SetLevelMax()
	else
		self:SetCellData()
		self:CheckObjectPoolEmpty()
		self:CheckCellNumIsZero()
		self:SetButtonState()
		self:SetNeedMoney()
		self:SetStarItems()

		self.objectPoolIndex = 0
		self.IsCellNumZero = true
	end
end

function m:SetCellData()
	if not self.CfgHeroStarLevelData or not self.CfgHeroStarLevelData.StarCost then
		return
	end

	for i, v in ipairs(self.CfgHeroStarLevelData.StarCost) do
		if i % 2 == 1 then
			if v == Constant.ItemCid.GOLD then
				self.MoneyNum = self.CfgHeroStarLevelData.StarCost[i + 1]
			elseif i == 1 then
				local itemCell = ItemCell.New(self.CommonSlotUI, true, false)
				local itemData = ItemData.CreateByCIDAndNumber(v)

				itemCell:SetItem(itemData)

				local isEnough = itemCell:SetCustomNum(self.CfgHeroStarLevelData.StarCost[i + 1])

				if self.IsMaterialsEnough and not isEnough then
					self.IsMaterialsEnough = false
				end

				self.IsCellNumZero = false
			else
				self.objectPoolIndex = self.objectPoolIndex + 1

				self:InstantiateCellObject(v, self.CfgHeroStarLevelData.StarCost[i + 1])
			end
		end
	end
end

function m:InstantiateCellObject(id, num)
	local gameObject

	if self.ObjectPool[self.objectPoolIndex] then
		gameObject = self.ObjectPool[self.objectPoolIndex]
	else
		gameObject = UnityEngine.GameObject.Instantiate(self.CommonSlotUI, self.consumptionMaterial.transform)
		self.ObjectPool[self.objectPoolIndex] = gameObject
	end

	gameObject:SetActive(true)

	local itemCell = ItemCell.New(gameObject, true, false)
	local itemData = ItemData.CreateByCIDAndNumber(id)

	itemCell:SetItem(itemData)

	local isEnough = itemCell:SetCustomNum(num)

	if self.IsMaterialsEnough and not isEnough then
		self.IsMaterialsEnough = false
	end

	self.IsCellNumZero = false
end

function m:CheckObjectPoolEmpty()
	local poolLength = #self.ObjectPool

	if poolLength > self.objectPoolIndex then
		for i = self.objectPoolIndex + 1, poolLength do
			UnityEngine.GameObject.Destroy(self.ObjectPool[i])

			self.ObjectPool[i] = nil
		end
	end
end

function m:CheckCellNumIsZero()
	if self.IsCellNumZero then
		self.CommonSlotUI:SetActive(false)
	end
end

function m:SetButtonState()
	local grayCom = self.confirmBtn:GetComponent("GrayComponent")

	if not self.IsMaterialsEnough or WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.GOLD) < self.MoneyNum then
		grayCom:SetGray(true)
	else
		grayCom:SetGray(false)
	end
end

function m:SetNeedMoney()
	self.consumeGoldCell:Hide()
	self.MonetCostRoot.gameObject:SetActive(false)
end

function m:SetStarItems()
	self.StarObjectPool = self.StarObjectPool or {}

	local starTime = self.HeroData.starTime
	local starLevel = self.HeroData.starLevel
	local starNum = math.max(starTime, starLevel)
	local firstPresentStarItem = PresentStarItem.New(self.presentStarItemPrefab)

	self.presentStarItemPrefab:SetActive(true)

	if starTime >= 1 then
		firstPresentStarItem:SetData(starLevel + 1)
	else
		firstPresentStarItem:SetData(starLevel)
	end

	for i = 1, starNum - 1 do
		local starGameObject

		if self.StarObjectPool[i] then
			starGameObject = self.StarObjectPool[i]
		else
			starGameObject = UnityEngine.GameObject.Instantiate(self.presentStarItemPrefab, self.presentStarGird.transform)
			self.StarObjectPool[i] = starGameObject
		end

		starGameObject:SetActive(true)

		local presentStarItem = PresentStarItem.New(starGameObject)

		if i <= starTime - 1 then
			presentStarItem:SetData(starLevel + 1)
		else
			presentStarItem:SetData(starLevel)
		end
	end

	self:CheckStarObjectPoolEmpty(starNum)
end

function m:CheckStarObjectPoolEmpty(starAllNum)
	local starGameObjectLength = #self.StarObjectPool

	if starGameObjectLength > starAllNum - 1 then
		for i = starAllNum, starGameObjectLength do
			UnityEngine.GameObject.Destroy(self.StarObjectPool[i])

			self.StarObjectPool[i] = nil
		end
	end
end

function m:SetLevelMax()
	for i = 1, #self.ObjectPool do
		self.ObjectPool[i]:SetActive(false)
	end

	LuaUtility.SetGameObjectShow(self.RefineMaxState, true)
	LuaUtility.SetGameObjectShow(self.confirmBtn, false)
	LuaUtility.SetGameObjectShow(self.CommonSlotUI, false)
	LuaUtility.SetGameObjectShow(self.consumptionMaterial, false)
	self.consumeGoldCell:Hide()
	self:SetStarItems()
end

function m:ConfirmBtnClick()
	if not self.IsMaterialsEnough or WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.GOLD) < self.MoneyNum then
		NoticeModule.ShowNotice(20003)

		return
	end

	RoleDevelopmentModule.AscendingStart(self.SelectHeroCid)
end

function m:AscendingStartSucess()
	UIModule.Open(Constant.UIControllerName.RoleStarsUpgradeTipsUI, Constant.UILayer.UI, {
		lastHeroData = self.LastHeroData,
		newHeroData = self.HeroData,
		lastStarLevelCfg = self.CurrentCfgHeroStarLevelData,
		nextStarLevelCfg = self.CfgHeroStarLevelData
	})
	self:SetData(self.SelectHeroCid)
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	for i, v in pairs(self.ObjectPool) do
		UnityEngine.GameObject.Destroy(v)
	end

	for i, v in pairs(self.StarObjectPool) do
		UnityEngine.GameObject.Destroy(v)
	end

	for k, v in pairs(self.AttrQualityItemList) do
		v:Dispose()
	end

	self.ObjectPool = nil

	self.consumeGoldCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
