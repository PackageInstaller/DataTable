-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\DiySkillTrainingView.lua

local m = {
	isSelectSkill = false,
	isCanBreach = false,
	heroLvIsAchieve = false,
	SkillItemList = {},
	AttrItems = {},
	ConditionObjList = {}
}
local diySelectSkillItem = require("IQIGame.UI.RoleDevelopment.ItemCell.DiySelectSkillItem")
local DropDownUI = require("IQIGame.UI.Common.DropDownUI")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickStrengthBtn()
		self:OnClickStrengthBtn()
	end

	function self.DelegateOnClickBreachBtn()
		self:OnClickBreachBtn()
	end

	function self.DelegateOnClickUnLoadBtn()
		self:OnClickUnLoadBtn()
	end

	function self.DelegateWearSkillSucessEvent()
		self:OnWearSkillSuccess()
	end

	function self.DelegateCloseSkillTipsEvent()
		self:CloseSkillTipsEvent()
	end

	function self.DelegateOnAllClick(isOn)
		self:OnClickTab(isOn, 1)
	end

	function self.DelegateOnEquipedClick(isOn)
		self:OnClickTab(isOn, 2)
	end

	function self.DelegateOnLockBtnClick()
		self:OnClickLockButton()
	end

	function self.DelegateOnLockSuccessEvent()
		self:OnLockSuccessEvent()
	end

	function self.DelegateOnClickExChangeBtn()
		self:OnClickExChangeBtn()
	end

	function self.DelegateOnCloseSkillBagBtnClick()
		self:OnCloseSkillBagBtnClick()
	end

	self.wrapContent = self.SkillItemsScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.wrapContent.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	self.ApStarCom = self.ApStar:GetComponent("SimpleStarComponent")
	self.TypeDropdownItem = DropDownUI.New(self.TypeDropdown, function(sortType)
		self:OnDropDownCallBack(sortType)
	end, function(count)
		self:OnScreenCallBack(count)
	end)
	self.breachStarCom = self.BreachStar:GetComponent("SimpleStarComponent")
	self.skillBagTweenPos = self.SkillBag:GetComponent("TweenPosition")
	self.skillDiyImgTweenAlpha = self.DiyImgParent:GetComponent("TweenAlpha")

	self.TypeDropdownItem:InitDropdownData(RoleDevelopmentApi:GetSkillScreenTextList())

	self.CurDropDownType = 1
	self.CurScreenClickCount = 1

	self:InigStaticText()
end

function m:AddListeners()
	self.StrengthenBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStrengthBtn)
	self.BreachBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBreachBtn)
	self.UnLoadBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnLoadBtn)
	self.AllToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnAllClick)
	self.EquipedToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnEquipedClick)
	self.LockBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnLockBtnClick)
	self.ExchangeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExChangeBtn)
	self.CloseSkillBagBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseSkillBagBtnClick)
	EventDispatcher.AddEventListener(EventID.WearSkillSucess, self.DelegateWearSkillSucessEvent)
	EventDispatcher.AddEventListener(EventID.CloseSkillTipsEvent, self.DelegateCloseSkillTipsEvent)
	EventDispatcher.AddEventListener(EventID.LockSkillSucess, self.DelegateOnLockSuccessEvent)
end

function m:RemoveListeners()
	self.StrengthenBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStrengthBtn)
	self.BreachBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBreachBtn)
	self.UnLoadBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnLoadBtn)
	self.AllToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnAllClick)
	self.EquipedToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnEquipedClick)
	self.LockBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnLockBtnClick)
	self.ExchangeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExChangeBtn)
	self.CloseSkillBagBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseSkillBagBtnClick)
	EventDispatcher.RemoveEventListener(EventID.WearSkillSucess, self.DelegateWearSkillSucessEvent)
	EventDispatcher.RemoveEventListener(EventID.CloseSkillTipsEvent, self.DelegateCloseSkillTipsEvent)
	EventDispatcher.RemoveEventListener(EventID.LockSkillSucess, self.DelegateOnLockSuccessEvent)
end

function m:InigStaticText()
	UGUIUtil.SetText(self.SkillRangeTitle, RoleDevelopmentApi:GetRangeTitle())
	UGUIUtil.SetText(self.StrengthBtnText, RoleDevelopmentApi:GetStrengthBtnTitle())
	UGUIUtil.SetText(self.BreachBtnText, RoleDevelopmentApi:GetBreachBtnTitle())
	UGUIUtil.SetText(self.UnLoadBtnText, RoleDevelopmentApi:GetUnLoadTitle())
	UGUIUtil.SetText(self.BreachTitle, RoleDevelopmentApi:GetBreachTitle())
	UGUIUtil.SetText(self.LvTitle, RoleDevelopmentApi:GetLvTitle())
	UGUIUtil.SetText(self.CDTitle, RoleDevelopmentApi:GetCDTitle())
	UGUIUtil.SetText(self.APTitle, RoleDevelopmentApi:GetAPTitle())
	UGUIUtil.SetText(self.AttrTitle, RoleDevelopmentApi:GetAttrTitle())
	UGUIUtil.SetText(self.NoneSkillTitle, RoleDevelopmentApi:GetNoneSkillTitle())
	UGUIUtil.SetText(self.ElementTitle, RoleDevelopmentApi:GetElementTitle())
	UGUIUtil.SetText(self.CostTitle, RoleDevelopmentApi:GetCostTitle())
	UGUIUtil.SetText(self.CurSkillEffectTitle, RoleDevelopmentApi:GetSkillEffectitle())
	UGUIUtil.SetText(self.CurSkillInfoTitle, RoleDevelopmentApi:GetCurEffectTitle())
	UGUIUtil.SetText(self.NextSkillInfoTitle, RoleDevelopmentApi:GetNextEffectTitle())
	UGUIUtil.SetTextsInChildren(self.MaxBtn, RoleDevelopmentApi:GetMaxText())
end

function m:SetData(curSelectHeroCid)
	local selectHeroCid = curSelectHeroCid or RoleDevelopmentModule.CurSelectHeroCid

	self.HeroSkillData = RoleDevelopmentModule.GetCurHeroSkill(selectHeroCid)[RoleDevelopmentModule.CurSelectSkillPos]

	local isEquip = self.HeroSkillData ~= nil

	LuaUtility.SetGameObjectShow(self.SkillDetails, isEquip)
	LuaUtility.SetGameObjectShow(self.RigthBottomBtnParent, isEquip)
	LuaUtility.SetGameObjectShow(self.NoneSkill, not isEquip)

	self.SelectSkillId = isEquip and self.HeroSkillData.id or nil
	self.AllToggle:GetComponent("Toggle").isOn = true
	self.AllSkillItems = RoleDevelopmentModule.GetAllSkillItems(RoleDevelopmentModule.CurSelectSkillPos, self.SelectSkillId)

	self:RefreshSkillItem()
	self:ShowSelectSkillState(false, false)

	if not isEquip then
		self:OnClickExChangeBtn()
	end

	if not isEquip then
		return
	end

	self.skillItemData = WarehouseModule.FindItem(self.HeroSkillData.id)
	self.SkillData = self.skillItemData.skillData

	local desc = ""

	for lv = 1, #self.SkillData.skillCfgsByLv do
		if lv >= self.SkillData.lv and self.SkillData.skillCfgsByLv[lv].SKillTipsAdd ~= "" then
			desc = self.SkillData.skillCfgsByLv[lv].SKillTipsAdd

			break
		end
	end

	UGUIUtil.SetText(self.SkillName, self.SkillData:GetCfg().Name)
	UGUIUtil.SetText(self.CurLevelText, self.SkillData.lv)
	UGUIUtil.SetText(self.CDText, self.SkillData.CD)
	UGUIUtil.SetText(self.CurSkillInfoDesc, self.SkillData.skillCfgsByLv[self.SkillData.lv].SkillTips)
	UGUIUtil.SetText(self.TypeText, RoleDevelopmentApi:GetSkillType(self.SkillData:GetCfg().SkillType))
	UGUIUtil.SetText(self.CostNum, self.SkillData.Cost)
	UGUIUtil.SetText(self.NextSkillInfoDesc, desc)
	self.ApStarCom:UpdateView(5, self.SkillData.AP)

	self.isMax = self.SkillData.skillCfgsByLv[self.SkillData.lv].UpgradeNeedExp == nil

	local skillRangeID = self.SkillData:GetCfg().SkillRangeID

	if skillRangeID ~= 0 then
		local path = UIGlobalApi.GetImagePath(CfgSkillRangeTable[skillRangeID].SkillRangeImg)

		self:LoadImg(path, self.SkillRangeImg)
	end

	self:LoadImg(UIGlobalApi.GetIconPath(CfgItemTable[self.SkillData.itemCid].BigIcon), self.DIYImg)
	LuaUtility.SetGameObjectShow(self.NextSkillInfo, not self.isMax and string.len(desc) > 0)
	LuaUtility.SetGameObjectShow(self.LockImg, self.SkillData.lock)
	LuaUtility.SetGameObjectShow(self.UnLockImg, not self.SkillData.lock)
	LuaUtility.SetGameObjectShow(self.CDNormalState, self.SkillData.CD > 0)
	LuaUtility.SetGameObjectShow(self.CDNoneState, not (self.SkillData.CD > 0))
	LuaUtility.SetGameObjectShow(self.RangeNormalState, skillRangeID ~= 0)
	LuaUtility.SetGameObjectShow(self.RangeNoneState, skillRangeID == 0)
	LuaUtility.SetGameObjectShow(self.CostNormalState, self.SkillData.Cost > 0)
	LuaUtility.SetGameObjectShow(self.CostNoneState, not (self.SkillData.Cost > 0))
	LuaUtility.SetGameObjectShow(self.APNormalState, self.SkillData:GetCostEnergy() > 0)
	LuaUtility.SetGameObjectShow(self.APNoneState, not (self.SkillData:GetCostEnergy() > 0))
	LuaUtility.SetGameObjectShow(self.ElementNormalState, CfgSkillDetailTable[self.SkillData.skillCid].Element > 0)
	LuaUtility.SetGameObjectShow(self.ElementNoneState, not (CfgSkillDetailTable[self.SkillData.skillCid].Element > 0))

	local cells = self.breachStarCom.cells.Count

	for i = 1, cells do
		local simpleStarCell = self.breachStarCom.cells[i - 1]

		self:LoadImg(CommonSlotUIApi:GetSkillBreachStarImg(CfgItemTable[self.skillItemData.cid].Quality), simpleStarCell.lightPart)
	end

	self.breachStarCom:UpdateView(CfgItemTable[self.skillItemData.cid].Quality, CfgItemTable[self.skillItemData.cid].Quality)

	local skillElement = CfgSkillDetailTable[self.SkillData.skillCid].Element

	if skillElement > 0 then
		self:LoadImg(CommonSlotUIApi:GetSkillElement(skillElement), self.ElementImg)
	end

	self.isCanBreach = false

	if not self.SkillData:IsMaxBreachLv() then
		self.isCanBreach = self.SkillData.lv >= self.SkillData.skillCfgsByStrengLv[self.SkillData.strengLv + 1].NeedSkillLv
		self.heroLvIsAchieve = PlayerModule.PlayerInfo.baseInfo.pLv >= self.SkillData.skillCfgsByStrengLv[self.SkillData.strengLv + 1].NeedLv
	end

	LuaUtility.SetGameObjectShow(self.BreachBtn, self.isCanBreach)
	LuaUtility.SetGameObjectShow(self.StrengthenBtn, not self.isCanBreach and not self.SkillData:IsMaxLv())
	LuaUtility.SetGameObjectShow(self.MaxBtn, not self.isCanBreach and self.SkillData:IsMaxLv())
	self:RefreshSkillAttr()
	self:GetSkillCondition()
end

function m:RefreshSkillAttr()
	local baseSubAttrs = self.SkillData:GetSkillAttr(self.SkillCurLv)

	for i = 1, #baseSubAttrs do
		local attrItemObj = self:CreateAttrItem(i)

		UGUIUtil.SetText(attrItemObj.AttrTypeText, CfgAttributeTable[baseSubAttrs[i].attrType].Name)
		UGUIUtil.SetText(attrItemObj.AttrValue, baseSubAttrs[i].attrValue == nil and 0 or baseSubAttrs[i].attrValue)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgAttributeTable[baseSubAttrs[i].attrType].ImageUrl), attrItemObj.AttrImg:GetComponent("Image"))
	end

	for i = 1, #self.AttrItems do
		self.AttrItems[i].View:SetActive(i <= #baseSubAttrs)
	end
end

function m:CreateAttrItem(index)
	local attrItem = self.AttrItems[index]

	if attrItem == nil then
		local luaOutlet = {}
		local attrItemObj = UnityEngine.GameObject.Instantiate(self.AttrItemPrefab)

		attrItemObj.transform:SetParent(self.AttrItemsGrid.transform, false)
		LuaCodeInterface.BindOutlet(attrItemObj, luaOutlet)

		self.AttrItems[index] = luaOutlet
		attrItem = self.AttrItems[index]
	end

	return attrItem
end

function m:RefreshSkillItem(isDynamic)
	self:SortSkillItem()

	if isDynamic then
		self.wrapContent:RenderCellsDynamic(#self.AllSkillItems)
	else
		self.wrapContent:Refresh(#self.AllSkillItems)
	end

	self.NoneSkillItem:SetActive(#self.AllSkillItems <= 0)
end

function m:OnRenderGridCell(cell)
	local itemData = self.AllSkillItems[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.SkillItemList[instanceId]

	if itemCell == nil then
		itemCell = diySelectSkillItem.New(cell.gameObject)
		self.SkillItemList[instanceId] = itemCell
	end

	itemCell:SetData(itemData)
	itemCell:UnSelected()
end

function m:OnSelectedGridCell(cell)
	local itemData = self.AllSkillItems[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.SkillItemList[instanceId]

	self:CancelItemSelect()
	itemCell:Selected()
	EventDispatcher.Dispatch(EventID.ClickDiySkillItemEvent, itemData)
end

function m:CancelItemSelect()
	for _, v in pairs(self.SkillItemList) do
		v:UnSelected()
	end
end

function m:OnDropDownCallBack(index)
	self.CurDropDownType = index

	self:RefreshSkillItem()
end

function m:OnScreenCallBack(count)
	self.CurScreenClickCount = count

	self:RefreshSkillItem()
end

function m:SortSkillItem()
	if self.CurDropDownType == 1 then
		table.sort(self.AllSkillItems, function(a, b)
			return a.createTime > b.createTime
		end)
	elseif self.CurDropDownType == 2 then
		table.sort(self.AllSkillItems, function(a, b)
			return a:GetCfg().Quality > b:GetCfg().Quality
		end)
	elseif self.CurDropDownType == 3 then
		table.sort(self.AllSkillItems, function(a, b)
			if a.skillData.lv == b.skillData.lv then
				if a.skillData.strengLv == b.skillData.strengLv then
					return a.skillData.heroCid > b.skillData.heroCid
				end

				return a.skillData.strengLv > b.skillData.strengLv
			end

			return a.skillData.lv > b.skillData.lv
		end)
	end

	if self.CurScreenClickCount == 2 then
		table.reverse(self.AllSkillItems)
	end
end

function m:OnClickTab(isOn, index)
	if isOn then
		if index == 1 then
			self.AllSkillItems = RoleDevelopmentModule.GetAllSkillItems(RoleDevelopmentModule.CurSelectSkillPos, self.SelectSkillId)
		else
			self.AllSkillItems = RoleDevelopmentModule.GetAllSkillItems(RoleDevelopmentModule.CurSelectSkillPos, self.SelectSkillId, true)
		end

		self:RefreshSkillItem()
	end
end

function m:OnClickLockButton()
	RoleDevelopmentModule.RoleSkillLock({
		self.SkillData.id
	})
end

function m:OnLockSuccessEvent()
	if self.SkillData ~= nil then
		self.SkillData = WarehouseModule.FindItem(self.SkillData.id).skillData

		LuaUtility.SetGameObjectShow(self.LockImg, self.SkillData.lock)
		LuaUtility.SetGameObjectShow(self.UnLockImg, not self.SkillData.lock)
	end

	self:RefreshSkillItem(true)
end

function m:CloseSkillTipsEvent()
	self:CancelItemSelect()
end

function m:OnClickStrengthBtn()
	UIModule.Open(Constant.UIControllerName.SkillStrengthenUI, Constant.UILayer.UI, self.SkillData.id)
end

function m:OnClickBreachBtn()
	if not self.heroLvIsAchieve then
		NoticeModule.ShowNotice(44002)

		return
	end

	UIModule.Open(Constant.UIControllerName.SkillBreachUI, Constant.UILayer.UI, self.SkillData.id)
end

function m:OnClickUnLoadBtn()
	RoleDevelopmentModule.RoleSkillUnload(RoleDevelopmentModule.CurSelectHeroCid, RoleDevelopmentModule.CurSelectSkillPos)
end

function m:OnWearSkillSuccess()
	return
end

function m:OnClickExChangeBtn()
	self:ShowSelectSkillState(not self.isSelectSkill, true)
end

function m:OnCloseSkillBagBtnClick()
	self:ShowSelectSkillState(false, true)
end

function m:GetSkillCondition()
	self.ConditionDataList = {}
	self.ConditionDataList[Constant.SkillConditionType.PROFRESSION] = {}
	self.ConditionDataList[Constant.SkillConditionType.ELEMENT] = {}
	self.ConditionDataList[Constant.SkillConditionType.POWER] = {}

	local conditionCfg = self.SkillData:GetCfg()

	for i = 1, #conditionCfg.ProfessionLimit do
		table.insert(self.ConditionDataList[Constant.SkillConditionType.PROFRESSION], {
			conditionCfg.ProfessionLimit[i]
		})
	end

	for i = 1, #conditionCfg.ElementLimit do
		table.insert(self.ConditionDataList[Constant.SkillConditionType.ELEMENT], {
			conditionCfg.ElementLimit[i]
		})
	end

	for i = 1, #conditionCfg.ForceLimit do
		table.insert(self.ConditionDataList[Constant.SkillConditionType.POWER], {
			conditionCfg.ForceLimit[i]
		})
	end

	self:SetConditionItem()
end

function m:SetConditionItem()
	for i = 1, #self.ConditionObjList do
		self.ConditionObjList[i]:SetActive(false)
	end

	local length = 0

	for i = 1, #self.ConditionDataList do
		for j = 1, #self.ConditionDataList[i] do
			if self.ConditionDataList[i][j][1] ~= 0 then
				length = length + 1

				local Obj = self:CreateElementConditionItem(length)

				Obj:SetActive(true)
				UGUIUtil.SetTextsInChildren(Obj, self:GetDictText(i, self.ConditionDataList[i][j][1]))
			end
		end
	end

	self.ConditionParent:SetActive(length ~= 0)
end

function m:CreateElementConditionItem(index)
	local obj = self.ConditionObjList[index]

	if obj == nil then
		obj = UnityEngine.Object.Instantiate(self.LimitItem)

		obj.transform:SetParent(self.LimitContent.transform, false)

		self.ConditionObjList[index] = obj
	end

	return obj
end

function m:GetDictText(groupID, id)
	if groupID == 1 then
		groupID = 7
	elseif groupID == 2 then
		groupID = 8
	elseif groupID == 3 then
		groupID = 9
	end

	for k, v in pairsCfg(CfgDictTable) do
		if v.GroupId == groupID and v.TypeId == id then
			return RoleDevelopmentApi:GetItemIipsDesc(v.TipsId)
		end
	end
end

function m:LoadImg(path, imgObj)
	AssetUtil.LoadImage(self, path, imgObj:GetComponent("Image"))
end

function m:SetShowState()
	self.SkillDetails:SetActive(true)
end

function m:ShowSelectSkillState(state, isAnim)
	LuaUtility.SetGameObjectShow(self.CloseSkillBagBtn, state)
	LuaUtility.SetGameObjectShow(self.SkillBag, state)

	self.isSelectSkill = state

	if state == true then
		self.skillDiyImgTweenAlpha:PlayReverse()
	else
		self.skillDiyImgTweenAlpha:PlayForward()
	end

	local posX = state and 1180 or 0

	if not isAnim then
		self.SkillBag.transform.localPosition = Vector3.New(posX, 0, 0)

		return
	end

	local tween = TweenPosition.Begin(self.SkillBag, 0.1, Vector3.New(posX, 0, 0))

	tween:SetOnFinished(function()
		UnityEngine.Object.Destroy(tween)

		if state == false then
			LuaUtility.SetGameObjectShow(self.SkillBag, state)
		end
	end)
end

function m:InitState()
	self.isSelectSkill = false

	self.skillDiyImgTweenAlpha:PlayForward()
end

function m:Show()
	self.View:SetActive(true)
	self:InitState()
end

function m:Hide()
	self:ShowSelectSkillState(false, false)
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
