-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\SubPanel\\DiySkillInfoPanelNew.lua

local DiySkillAttrPopItemCell = {}

function DiySkillAttrPopItemCell.New(view)
	local obj = Clone(DiySkillAttrPopItemCell)

	obj:Init(view)

	return obj
end

function DiySkillAttrPopItemCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function DiySkillAttrPopItemCell:SetData(attrTable)
	local attributeData = CfgAttributeTable[attrTable.type]

	UGUIUtil.SetText(self.propertyNameText, attributeData.Name)
	UGUIUtil.SetText(self.propertyValueText, attrTable.value == nil and 0 or attrTable.value)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attributeData.ImageUrl), self.attrImg:GetComponent("Image"))
end

function DiySkillAttrPopItemCell:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function DiySkillAttrPopItemCell:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function DiySkillAttrPopItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
end

local DiySkillAttrPopView = {
	ItemCellList = {}
}

DiySkillAttrPopView.BaseAttrEnum = {
	41,
	42,
	43
}

function DiySkillAttrPopView.New(view)
	local obj = Clone(DiySkillAttrPopView)

	obj:Init(view)

	return obj
end

function DiySkillAttrPopView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.warpContent = self.attributeItems:GetComponent("ScrollAreaList")

	function self.warpContent.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	self:AddListeners()
end

function DiySkillAttrPopView:AddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
end

function DiySkillAttrPopView:RemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
end

function DiySkillAttrPopView:InitAttrTable()
	self.attrsCollections = {}

	for k, v in pairs(Constant.DIYSkillDisplayAttrTable) do
		self.attrsCollections[k] = {
			value = 0,
			type = v
		}
	end
end

function DiySkillAttrPopView:SetData(skillDataList)
	self:InitAttrTable()
	ForPairs(skillDataList, function(_, _skillData)
		local isValid = false

		ForPairs(Constant.DIYSkillPosMapping, function(_, _skillType)
			isValid = _skillData.heroPos == _skillType

			return isValid
		end)

		if not isValid then
			return
		end

		local attrTable = DiySkillModule.GetSkillTotalAttributes(_skillData, Constant.DIYSkillDisplayAttrTable)

		ForPairs(self.attrsCollections, function(_, _attrData)
			local value = attrTable[_attrData.type]

			if value == nil then
				return
			end

			_attrData.value = _attrData.value + value
		end)
	end)
	self.warpContent:Refresh(#self.attrsCollections)
end

function DiySkillAttrPopView:OnRenderCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.ItemCellList[instanceID]

	if itemCell == nil then
		itemCell = DiySkillAttrPopItemCell.New(cell.gameObject)
		self.ItemCellList[instanceID] = itemCell
	end

	local attrTable = self.attrsCollections[cell.index + 1]

	itemCell:Show()
	itemCell:SetData(attrTable)
end

function DiySkillAttrPopView:OnClickCloseBtn()
	self:Hide()
end

function DiySkillAttrPopView:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function DiySkillAttrPopView:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function DiySkillAttrPopView:Dispose()
	for k, v in pairs(self.ItemCellList) do
		v:Dispose()
	end

	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
end

local DiySkillItem = {}

function DiySkillItem.New(view, clickHandler)
	local obj = Clone(DiySkillItem)

	obj:Init(view, clickHandler)

	return obj
end

function DiySkillItem:Init(view, clickHandler)
	self.View = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickItem()
		self:OnClickItem()
	end

	self.startsComponent = self.starComponent:GetComponent("SimpleStarComponent")

	self:AddListeners()
end

function DiySkillItem:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateOnClickItem)
end

function DiySkillItem:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickItem)
end

function DiySkillItem:SetData(skillData, skillType, roleCid)
	self.isEquip = skillData ~= nil
	self.skillData = skillData
	self.skillType = skillType

	local index = RoleDevelopmentModule.GetIndexByDiySkillType(skillType)
	local needLV = CfgHeroTable[roleCid].DiyField[index]

	self.isUnLock = needLV <= WarlockModule.WarlockDataDic[roleCid].lv

	LuaUtility.SetGameObjectShow(self.lockedParent, not self.isUnLock)
	LuaUtility.SetGameObjectShow(self.emptyParent, not self.isEquip and self.isUnLock)
	LuaUtility.SetGameObjectShow(self.fullParent, self.isEquip)
	self:RefreshSkillInfo()

	if not self.isUnLock then
		UGUIUtil.SetText(self.unlockText, RoleDevelopmentApi:GetSkillOpenConditionText(needLV))
	end
end

function DiySkillItem:RefreshSkillInfo()
	if self.isEquip then
		local quality = self.skillData:GetCfg().Quality

		UGUIUtil.SetText(self.nameText, RoleDevelopmentApi:GetSkillNameByQuality(self.skillData:GetCfg().Name, quality))
		UGUIUtil.SetText(self.lvText, self.skillData.lv)
		UGUIUtil.SetText(self.skillDescText, self.skillData:GetCfg().EffectText)
		UGUIUtil.SetText(self.refineText, self.skillData.purifyLv)
		LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.skillData:GetCfg().Icon), self.skillIcon:GetComponent("Image"))
		LuaUtility.LoadImage(self, RoleDevelopmentApi:GetSkillNameBGByQuality(quality), self.nameBG:GetComponent("Image"))
		LuaUtility.LoadImage(self, RoleDevelopmentApi:GetSkillTagBGByQuality(quality), self.tagImg:GetComponent("Image"))

		local itemCfg = DiySkillModule.GetItemCfgWithDiySkill(self.skillData)

		self.startsComponent:UpdateView(itemCfg.Quality, itemCfg.Quality)
		self:RefreshRefineEffect()
	end
end

function DiySkillItem:RefreshRefineEffect()
	local refineCfg = DiySkillModule.GetSkillRefineCfg(self.skillData.skillCid, self.skillData.purifyLv)

	if refineCfg == nil then
		return
	end

	UGUIUtil.SetText(self.skillDescText, refineCfg.SkillTips)
end

function DiySkillItem:OnClickItem()
	if not self.isUnLock then
		NoticeModule.ShowNotice(51011)

		return
	end

	if self.clickHandler ~= nil then
		self.clickHandler(self.skillType)
	end
end

function DiySkillItem:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function DiySkillItem:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function DiySkillItem:Dispose()
	self.startsComponent = nil

	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
end

local m = {
	diySkillItemList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.__OnDelegateWearSkillEvent()
		self:__OnDelegateWearSkill()
	end

	function self.delegateOnClickAttrDetailsBtn()
		self:OnClickAttrDetailsBtn()
	end

	function self.DelegateSkillUpSucessEvent()
		self:OnSkillUpSucessEvent()
	end

	ForTransformChild(self.diySkillItemParent.transform, function(_trans, _index)
		self.diySkillItemList[Constant.DIYSkillPosMapping[_index + 1]] = DiySkillItem.New(_trans.gameObject, function(skillType)
			self:DiySkillItemClick(skillType)
		end)
	end)

	self.skillAttrPopView = DiySkillAttrPopView.New(self.AttributePopUpPanel)

	self:AddListeners()
end

function m:AddListeners()
	self.attributeDetailBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickAttrDetailsBtn)
end

function m:RemoveListeners()
	self.attributeDetailBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickAttrDetailsBtn)
end

function m:SetData(roleCid, changeHero)
	self.roleCid = roleCid

	if changeHero then
		self.skillAttrPopView:Hide()
	end

	self:RefreshSkillItem()
end

function m:RefreshSkillItem()
	self.SkillDataList = RoleDevelopmentModule.GetCurHeroSkill(self.roleCid)

	for k, v in pairs(self.diySkillItemList) do
		v:SetData(self.SkillDataList[k], k, self.roleCid)
	end
end

function m:OnSkillUpSucessEvent()
	self:RefreshSkillItem()
end

function m:DiySkillItemClick(skillType)
	UIModule.Open(Constant.UIControllerName.DiySkillInfoUI, Constant.UILayer.UI, {
		roleCid = self.roleCid,
		skillType = skillType
	})
end

function m:__OnDelegateWearSkill()
	self:RefreshSkillItem()
end

function m:OnClickAttrDetailsBtn()
	self.skillAttrPopView:Show()
	self.skillAttrPopView:SetData(self.SkillDataList)
end

function m:Show()
	EventDispatcher.AddEventListener(EventID.WearSkillSucess, self.__OnDelegateWearSkillEvent)
	EventDispatcher.AddEventListener(EventID.RemoveSkillSucess, self.__OnDelegateWearSkillEvent)
	EventDispatcher.AddEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	LuaUtility.SetGameObjectShow(self.View, true)
	self.skillAttrPopView:Hide()
end

function m:Hide()
	EventDispatcher.RemoveEventListener(EventID.WearSkillSucess, self.__OnDelegateWearSkillEvent)
	EventDispatcher.RemoveEventListener(EventID.RemoveSkillSucess, self.__OnDelegateWearSkillEvent)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	LuaUtility.SetGameObjectShow(self.View, false)
	self.skillAttrPopView:Hide()
end

function m:Dispose()
	self:Hide()
	self:RemoveListeners()

	for k, v in pairs(self.diySkillItemList) do
		v:Dispose()
	end

	self.skillAttrPopView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
