-- chunkname: @IQIGame\\UI\\DiySkill\\Strengthen\\DiySkillBreachView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local BreachStartItem = {}

function BreachStartItem.New(view)
	local obj = Clone(BreachStartItem)

	obj:__Init(view)

	return obj
end

function BreachStartItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function BreachStartItem:Show(isOn)
	self.gameObject:SetActive(true)
	self.on:SetActive(isOn)
end

function BreachStartItem:Hide()
	self.gameObject:SetActive(false)
end

function BreachStartItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local PreviewBreachStartItem = {}

function PreviewBreachStartItem.New(view)
	local obj = Clone(PreviewBreachStartItem)

	obj:__Init(view)

	return obj
end

function PreviewBreachStartItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function PreviewBreachStartItem:Show(isOn, isPreview)
	self.gameObject:SetActive(true)

	if not isOn then
		self.on:SetActive(false)
		self.preview:SetActive(false)
	else
		self.on:SetActive(not isPreview)
		self.preview:SetActive(isPreview)
	end
end

function PreviewBreachStartItem:Hide()
	self.gameObject:SetActive(false)
end

function PreviewBreachStartItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local MaterialItemCell = {}

function MaterialItemCell.New(view)
	local obj = Clone(MaterialItemCell)

	obj:__Init(view)

	return obj
end

function MaterialItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.itemCell = ItemCell.New(self.materialPrefab, true, true, false)
end

function MaterialItemCell:Show(cid, needCount)
	self.gameObject:SetActive(true)
	self.itemCell:SetItemByCid(cid, 0)

	local isEnough = self.itemCell:SetCustomNum(needCount, nil)

	self.greyImg:SetActive(not isEnough)

	return isEnough
end

function MaterialItemCell:Hide()
	self.gameObject:SetActive(false)
end

function MaterialItemCell:Dispose()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local DiySkillBreachView = {
	SkillAttributes = {}
}

function DiySkillBreachView.New(view)
	local obj = Clone(DiySkillBreachView)

	obj:__Init(view)

	return obj
end

function DiySkillBreachView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.presentStars1:SetActive(false)

	self.curStartItemPool = UIViewObjectPool.New(self.presentStars1, nil, function(_view)
		return BreachStartItem.New(_view)
	end)

	self.nextStars1:SetActive(false)

	self.previewStartItemPool = UIViewObjectPool.New(self.nextStars1, nil, function(_view)
		return PreviewBreachStartItem.New(_view)
	end)

	self.materialPrefab:SetActive(false)

	self.matItemCellPool = UIViewObjectPool.New(self.materialPrefab, nil, function(_view)
		return MaterialItemCell.New(_view)
	end)

	function self.__onBreachBtnClickEventProxy()
		self:__OnBreachBtnClickEventHandler()
	end

	function self.__onRoleSkillBreachSucessEventProxy()
		self:__OnRoleSkillBreachSucessEventHandler()
	end

	function self.__delegateOnUpdateItem()
		self:__OnUpdateItem()
	end

	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)

	self.moneyCell:RefreshItem(Constant.TopMoneyType.DiySkillStrengthUI)

	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)

	self.consumeGoldCell:InitIconImg(Constant.ItemCid.GOLD)
	self:__AddListeners()
end

function DiySkillBreachView:__AddListeners()
	self.breachBtn:GetComponent("Button").onClick:AddListener(self.__onBreachBtnClickEventProxy)
	EventDispatcher.AddEventListener(EventID.RoleSkillBreachSucess, self.__onRoleSkillBreachSucessEventProxy)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.__delegateOnUpdateItem)
end

function DiySkillBreachView:__RemoveListeners()
	self.breachBtn:GetComponent("Button").onClick:RemoveListener(self.__onBreachBtnClickEventProxy)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillBreachSucess, self.__onRoleSkillBreachSucessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.__delegateOnUpdateItem)
end

function DiySkillBreachView:Dispose()
	self:__RemoveListeners()
	self.moneyCell:Dispose()
	self.consumeGoldCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillBreachView:SetData(skillData)
	self.gameObject:SetActive(true)

	self.curSkillData = skillData
	self.breachBtn:GetComponent("Button").interactable = false

	local maxStrengthenLevel = DiySkillModule.GetSkillMaxStrengthenLevel(self.curSkillData.skillCid)

	self.curStartItemPool:ForItems(function(_item)
		_item:Hide()
	end)
	self.previewStartItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, self.curSkillData.strengLv do
		local presentStartItem = self.curStartItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		presentStartItem:Show(true)

		local previewStartItem = self.previewStartItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		previewStartItem:Show(true, false)
	end

	local offCount = maxStrengthenLevel - self.curSkillData.strengLv

	for i = 1, offCount do
		local presentStartItem = self.curStartItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		presentStartItem:Show(false)

		local previewStartItem = self.previewStartItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		previewStartItem:Show(i == 1, i == 1)
	end

	UGUIUtil.SetText(self.presentLevelText, self.curSkillData.lv)
	UGUIUtil.SetText(self.limitLevelText, self.curSkillData.lv)
	UGUIUtil.SetText(self.nextLevelText, self.curSkillData.lv)
	self.matItemCellPool:ForItems(function(_item)
		_item:Hide()
	end)

	local nextStrengthenLevel = self.curSkillData.strengLv + 1

	self.SkillAttributes = {}

	local baseSubAttrs = DiySkillModule.GetSkillTotalAttributes(self.curSkillData, Constant.DIYSkillDisplayAttrTable)

	LuaUtility.SetGameObjectShow(self.BottomBtn, nextStrengthenLevel <= maxStrengthenLevel)
	LuaUtility.SetGameObjectShow(self.BreachBoxGridParent, nextStrengthenLevel <= maxStrengthenLevel)

	if maxStrengthenLevel < nextStrengthenLevel then
		self.consumeGoldCell:SetData(0)
		UGUIUtil.SetText(self.nextLimitLevelText, self.curSkillData.lv)
		UGUIUtil.SetText(self.tipsText, "")
		LuaUtility.SetGameObjectShow(self.lack, false)

		return
	end

	local nextSkillData = Clone(self.curSkillData)

	nextSkillData.strengLv = nextStrengthenLevel

	local nextRankAttrs = DiySkillModule.GetSkillTotalAttributes(nextSkillData, Constant.DIYSkillDisplayAttrTable)

	for _attrType, _attrValue in pairs(baseSubAttrs) do
		local attrData = {}

		attrData.type = _attrType
		attrData.curLvValue = _attrValue
		attrData.nextLvValue = nextRankAttrs[_attrType]

		table.insert(self.SkillAttributes, attrData)
	end

	local previewMaxUpgradeLevel = DiySkillModule.GetSkillMaxUpgradeLevel(self.curSkillData.Quality, nextStrengthenLevel)

	UGUIUtil.SetText(self.nextLimitLevelText, previewMaxUpgradeLevel)

	local isEnoughMoney = true
	local isEnoughItem = true
	local skillRankData = DiySkillModule.GetSkillRankData(self.curSkillData.skillCid, nextStrengthenLevel)

	for i = 1, #skillRankData.BreakCost, 2 do
		local cid = skillRankData.BreakCost[i]
		local needCount = skillRankData.BreakCost[i + 1]

		if cid == Constant.ItemCid.GOLD then
			isEnoughMoney = self.consumeGoldCell:SetData(needCount)
		else
			local matCell = self.matItemCellPool:GetFree(function(_item)
				return not _item.gameObject.activeSelf
			end)

			if not matCell:Show(cid, needCount) then
				isEnoughItem = false
			end
		end
	end

	if not isEnoughItem or not isEnoughMoney then
		UGUIUtil.SetText(self.tipsText, DiySkillStrengthenUIApi:GetStrengthenNotEnoughText(isEnoughItem, isEnoughMoney))
		LuaUtility.SetGameObjectShow(self.lack, true)
		LuaUtility.SetGameObjectShow(self.breachBtn, false)
	else
		UGUIUtil.SetText(self.tipsText, "")
		LuaUtility.SetGameObjectShow(self.lack, false)
		LuaUtility.SetGameObjectShow(self.breachBtn, true)

		self.breachBtn:GetComponent("Button").interactable = true
	end

	EventDispatcher.Dispatch(EventID.PlayDiySkillStrengthInAnimationEvent, nil, nil, true)
end

function DiySkillBreachView:Hide()
	self.curSkillData = nil

	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function DiySkillBreachView:__OnBreachBtnClickEventHandler()
	RoleDevelopmentModule.RoleSkillBeach(self.curSkillData.id)
end

function DiySkillBreachView:__OnRoleSkillBreachSucessEventHandler()
	UIModule.Open(Constant.UIControllerName.SkillBreachTipsUI, Constant.UILayer.UI, {
		SkillAttributes = self.SkillAttributes,
		curSkillData = self.curSkillData
	})
end

function DiySkillBreachView:__OnUpdateItem()
	if self.curSkillData == nil then
		return
	end

	self:SetData(self.curSkillData)
end

return DiySkillBreachView
