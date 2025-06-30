-- chunkname: @IQIGame\\UI\\Maze\\MazeUISenroTalentElement.lua

local CommonTipsHelper = require("IQIGame.UI.CommonTips.CommonTipsHelper")
local TalentLvPointItem = {}

function TalentLvPointItem.New(view)
	local obj = Clone(TalentLvPointItem)

	obj:__Init(view)

	return obj
end

function TalentLvPointItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function TalentLvPointItem:Show()
	self.gameObject:SetActive(true)
end

function TalentLvPointItem:RefreshShow(activited, isUpgrade)
	LuaUtility.SetGameObjectShow(self.activedImg, activited and isUpgrade)
	LuaUtility.SetGameObjectShow(self.activedNotUpgradeImg, activited)
	LuaUtility.SetGameObjectShow(self.notActivedImg, not activited)
end

function TalentLvPointItem:Hide()
	self.gameObject:SetActive(false)
end

function TalentLvPointItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local TalentTipView = {
	talentCid = 0,
	conditionItems = {}
}

function TalentTipView.New(view)
	local obj = Clone(TalentTipView)

	obj:__Init(view)

	return obj
end

function TalentTipView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnActiveBtnClick()
		self:__OnActiveBtnClick()
	end

	self.activeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnActiveBtnClick)

	function self.__delegateOnLevelUpBtnClick()
		self:__OnLevelUpBtnClick()
	end

	function self.__delegateOnCloseBtnClick()
		self:__OnCloseBtnClick()
	end

	ForTransformChild(self.conditionRoot.transform, function(_trans, _index)
		table.insert(self.conditionItems, _trans)
	end)
	self.levelUpBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnLevelUpBtnClick)
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
end

function TalentTipView:Show(talentCid, position)
	self:__ResetPosition(position)
	self.gameObject:SetActive(true)

	self.talentCid = talentCid

	local talentCfg = CfgLabyrinthSenrotalentTable[self.talentCid]

	AssetUtil.LoadImage(self, talentCfg.Icon, self.iconRoot:GetComponent("Image"))

	self.talentLv = 1

	local UpgradeLevel = 1
	local talentData = MazeModule.GetSenroTalentData(self.talentCid)

	if talentData ~= nil then
		self.talentLv = talentData.level
	end

	self.nameRoot:GetComponent("Text").text = talentCfg.Name
	self.descRoot:GetComponent("Text").text = talentCfg.TalentTips[self.talentLv]

	local talentState = MazeModule.GetSenroTalentState(self.talentCid)

	if talentState == Constant.MazeSenroTalenState.Locked or talentState == Constant.MazeSenroTalenState.CanUnlock then
		self:__ShowLocked(talentState, talentCfg)

		UpgradeLevel = 1
	else
		self:__ShowUnLocked(talentState, talentCfg)

		UpgradeLevel = self.talentLv + 1
	end

	ForArray(talentCfg.UnlockConditionIds, function(_index, _conditionCid)
		local conditionItem = self.conditionItems[_index]

		if conditionItem == nil then
			return
		end

		conditionItem:GetComponent("Text").text = MazeApi:UpgradeConditionTitle() .. ConditionModule.GetDesc(_conditionCid)

		conditionItem.gameObject:SetActive(true)
	end)

	local beginIndex = #talentCfg.UnlockConditionIds + 1

	ForArrayByCount(beginIndex, #self.conditionItems, 1, function(_index)
		self.conditionItems[_index].gameObject:SetActive(false)
	end)

	if talentState == Constant.MazeSenroTalenState.MaxLevel then
		LuaUtility.SetGameObjectShow(self.consumeRoot, false)
	else
		LuaUtility.SetGameObjectShow(self.consumeRoot, true)
		UGUIUtil.SetText(self.consumeText, talentCfg.UpgradeCost[UpgradeLevel][2])
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[talentCfg.UpgradeCost[UpgradeLevel][1]].Icon), self.consumeImg:GetComponent("Image"))
	end
end

function TalentTipView:__ResetPosition(worldPosition)
	local contentRectTrans = self.contentRoot:GetComponent("RectTransform")
	local localPosition = CommonTipsHelper.CalculationRTSLocalPositionByWorldPosition(contentRectTrans, worldPosition, Vector2.New(1334, 750), Vector4.New(0, 0, 0, 0))

	contentRectTrans.localPosition = localPosition
end

function TalentTipView:__ShowLocked(talentState, talentCfg)
	self.activeBtn.gameObject:SetActive(true)
	self.levelUpBtn.gameObject:SetActive(false)
	self.activedTag.gameObject:SetActive(false)
	self.maxLevelTag.gameObject:SetActive(false)

	self.activeBtn:GetComponent("Button").interactable = talentState == Constant.MazeSenroTalenState.CanUnlock
end

function TalentTipView:__ShowUnLocked(talentState, talentCfg)
	self.activeBtn.gameObject:SetActive(false)
	self.levelUpBtn.gameObject:SetActive(false)
	self.activedTag.gameObject:SetActive(false)
	self.maxLevelTag.gameObject:SetActive(false)

	if talentState == Constant.MazeSenroTalenState.Active then
		self.activedTag.gameObject:SetActive(true)
	elseif talentState == Constant.MazeSenroTalenState.MaxLevel then
		self.maxLevelTag.gameObject:SetActive(true)
	elseif talentState == Constant.MazeSenroTalenState.CanLevelUp then
		self.levelUpBtn.gameObject:SetActive(true)
	end
end

function TalentTipView:Hide()
	self.gameObject:SetActive(false)
end

function TalentTipView:Dispose()
	self.activeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnActiveBtnClick)
	self.levelUpBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnLevelUpBtnClick)
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)

	self.conditionItems = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function TalentTipView:__OnActiveBtnClick()
	local talentCfg = CfgLabyrinthSenrotalentTable[self.talentCid]
	local cost = talentCfg.UpgradeCost[1][2]
	local costItem = talentCfg.UpgradeCost[1][1]
	local totalItemCount = WarehouseModule.GetItemNumByCfgID(costItem)

	if totalItemCount < cost then
		NoticeModule.ShowNotice(80013)

		return
	end

	MazeModule.OnActiveSenroTalent(self.talentCid)
	self:Hide()
end

function TalentTipView:__OnLevelUpBtnClick()
	local talentCfg = CfgLabyrinthSenrotalentTable[self.talentCid]
	local cost = talentCfg.UpgradeCost[self.talentLv + 1][2] ~= nil and talentCfg.UpgradeCost[self.talentLv + 1][2] or 0
	local costItem = talentCfg.UpgradeCost[self.talentLv + 1][1]
	local totalItemCount = WarehouseModule.GetItemNumByCfgID(costItem)

	if totalItemCount < cost then
		logError("消耗不足------->>")
		NoticeModule.ShowNotice(20003)

		return
	end

	MazeModule.OnUpgradeSenroTalent(self.talentCid)
	self:Hide()
end

function TalentTipView:__OnCloseBtnClick()
	self:Hide()
end

local TalentItem = {
	talentCid = 0,
	LINE_NUM = 4,
	lvPointItemList = {},
	activitedLineItemList = {},
	notActiviteLineItemList = {}
}

function TalentItem.New(view, clickHandler)
	local obj = Clone(TalentItem)

	obj:__Init(view, clickHandler)

	return obj
end

function TalentItem:__Init(view, clickHandler)
	self.gameObject = view
	self.itemClickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnItemClick()
		self:__OnItemClick()
	end

	function self.__delegateOnActiveSenroTalentResult()
		self:__OnActiveSenroTalentResult()
	end

	ForTransformChild(self.lvUIPointParent.transform, function(_trans, _index)
		local item = TalentLvPointItem.New(_trans.gameObject)

		table.insert(self.lvPointItemList, item)
	end)
	self.buttonRoot:GetComponent("Button").onClick:AddListener(self.__delegateOnItemClick)

	for i = 1, self.LINE_NUM do
		table.insert(self.activitedLineItemList, self.activitedLineParent.transform:Find("line" .. i).gameObject)
	end

	for i = 1, self.LINE_NUM do
		table.insert(self.notActiviteLineItemList, self.notActiveLineParent.transform:Find("line" .. i).gameObject)
	end

	EventDispatcher.AddEventListener(EventID.OnActiveSenroTalentResult, self.__delegateOnActiveSenroTalentResult)
end

function TalentItem:__OnItemClick()
	if self.itemClickHandler == nil then
		return
	end

	local position = self.gameObject.transform.position

	self.itemClickHandler(self.talentCid, position)
end

function TalentItem:__OnActiveSenroTalentResult()
	if MazeModule.activeSenroTalentCid == self.talentCid then
		MazeModule.activeSenroTalentCid = nil

		self:StopEffect()

		self.effectSerialId = GameEntry.Effect:PlayUIMountPointEffect(MazeApi:GetActiveSenroTalentEffect(), 50000, 0, self.gameObject, 0)
	end
end

function TalentItem:StopEffect()
	if self.effectSerialId then
		GameEntry.Effect:StopEffect(self.effectSerialId)

		self.effectSerialId = nil
	end
end

function TalentItem:Show(talentCid)
	self.gameObject:SetActive(true)

	self.talentCid = talentCid

	self:RefreshShow()
end

function TalentItem:RefreshShow()
	local talentCfg = CfgLabyrinthSenrotalentTable[self.talentCid]

	AssetUtil.LoadImage(self, talentCfg.Icon, self.iconGo:GetComponent("Image"))

	local talentState = MazeModule.GetSenroTalentState(self.talentCid)

	if talentState == Constant.MazeSenroTalenState.Locked or talentState == Constant.MazeSenroTalenState.CanUnlock then
		self:__ShowLocked(talentState)
	else
		self:__ShowUnLocked(talentState)
	end

	self:__ShowLvInfo(talentState)
	self:__ShowLineInfo()
end

function TalentItem:__ShowLocked(talentState)
	LuaUtility.SetGameObjectShow(self.notActivitedParent, true)
	LuaUtility.SetGameObjectShow(self.activitedParent, false)
	self.levelUpTag.gameObject:SetActive(false)
	self.levelText.gameObject:SetActive(false)

	if talentState == Constant.MazeSenroTalenState.CanUnlock then
		local talentCfg = CfgLabyrinthSenrotalentTable[self.talentCid]
		local cost = talentCfg.UpgradeCost[1][2]
		local costItem = talentCfg.UpgradeCost[1][1]
		local totalItemCount = WarehouseModule.GetItemNumByCfgID(costItem)

		if totalItemCount < cost then
			self.activeTag.gameObject:SetActive(false)
		else
			self.activeTag.gameObject:SetActive(true)
		end
	else
		self.activeTag.gameObject:SetActive(false)
	end
end

function TalentItem:__ShowUnLocked(talentState)
	LuaUtility.SetGameObjectShow(self.notActivitedParent, false)
	LuaUtility.SetGameObjectShow(self.activitedParent, true)
	self.activeTag.gameObject:SetActive(false)
	self.levelText.gameObject:SetActive(true)

	local talentData = MazeModule.GetSenroTalentData(self.talentCid)

	self.levelText:GetComponent("Text").text = talentData.level

	if talentState == Constant.MazeSenroTalenState.CanLevelUp then
		local talentCfg = CfgLabyrinthSenrotalentTable[self.talentCid]
		local cost = talentCfg.UpgradeCost[talentData.level][2] ~= nil and talentCfg.UpgradeCost[talentData.level][2] or 0
		local costItem = talentCfg.UpgradeCost[talentData.level][1]
		local totalItemCount = WarehouseModule.GetItemNumByCfgID(costItem)

		if totalItemCount < cost then
			self.levelUpTag.gameObject:SetActive(false)
		else
			self.levelUpTag.gameObject:SetActive(true)
		end
	else
		self.levelUpTag.gameObject:SetActive(false)
	end
end

function TalentItem:__ShowLvInfo(talentState)
	local talentData = MazeModule.GetSenroTalentData(self.talentCid)
	local talentCfg = CfgLabyrinthSenrotalentTable[self.talentCid]

	if talentCfg.MaxLevel > 1 then
		LuaUtility.SetGameObjectShow(self.lvUIPointParent, true)
		ForArray(self.lvPointItemList, function(_index, _pointItem)
			if _index > talentCfg.MaxLevel then
				_pointItem:Hide()
			else
				_pointItem:Show()
			end
		end)

		for i = 1, talentCfg.MaxLevel do
			local lvPointItem = self.lvPointItemList[i]

			if lvPointItem ~= nil then
				if talentData ~= nil then
					lvPointItem:RefreshShow(talentState ~= Constant.MazeSenroTalenState.Locked, i <= talentData.level)
				else
					lvPointItem:RefreshShow(false, false)
				end
			end
		end
	else
		LuaUtility.SetGameObjectShow(self.lvUIPointParent, false)
	end
end

function TalentItem:__ShowLineInfo()
	local talentCfg = CfgLabyrinthSenrotalentTable[self.talentCid]
	local needLineNum = #talentCfg.UnlockConditionIds

	for i = 1, self.LINE_NUM do
		if needLineNum < i then
			LuaUtility.SetGameObjectShow(self.activitedLineItemList[i], false)
			LuaUtility.SetGameObjectShow(self.notActiviteLineItemList[i], false)
		elseif ConditionModule.Check(talentCfg.UnlockConditionIds[i]) then
			LuaUtility.SetGameObjectShow(self.activitedLineItemList[i], true)
			LuaUtility.SetGameObjectShow(self.notActiviteLineItemList[i], false)
		else
			LuaUtility.SetGameObjectShow(self.activitedLineItemList[i], false)
			LuaUtility.SetGameObjectShow(self.notActiviteLineItemList[i], true)
		end
	end
end

function TalentItem:Hide()
	self.gameObject:SetActive(false)
end

function TalentItem:Dispose()
	for k, v in pairs(self.lvPointItemList) do
		v:Dispose()
	end

	self.buttonRoot:GetComponent("Button").onClick:RemoveListener(self.__delegateOnItemClick)
	EventDispatcher.RemoveEventListener(EventID.OnActiveSenroTalentResult, self.__delegateOnActiveSenroTalentResult)
	self:StopEffect()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	talentItemList = {}
}

function Element.New(view, mainView)
	local obj = Clone(Element)

	obj:__Init(view, mainView)

	return obj
end

function Element:__Init(view, mainView)
	self.gameObject = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__InitEventDelegateFun()

	self.talentTipView = TalentTipView.New(self.talentTipsRoot)

	ForTransformChild(self.talentRoot.transform, function(_trans, _index)
		local talentItem = TalentItem.New(_trans.gameObject, function(_talentCid, _itemPos)
			self.talentTipView:Show(_talentCid, _itemPos)
		end)
		local talentCid = TryToNumber(_trans.gameObject.name, 0)

		talentItem:Show(talentCid)

		self.talentItemList[talentCid] = talentItem
	end)
	self:__AddEventListener()
end

function Element:__InitEventDelegateFun()
	function self.__delegateOnMazeSenroTalentDataChange()
		self:__OnMazeSenroTalentDataChange()
	end

	function self.__delegateOnMazeSenroDataChange()
		self:__OnMazeSenroDataChange()
	end

	function self.__delegateOnResetTalentBtnClick()
		self:__OnResetTalentBtnClick()
	end

	function self.__delegateOnUpgradeBtnClick()
		self:__OnUpgradeBtnClick()
	end

	function self.__delegateOnOverviewBtnClick()
		self:__OnOverviewBtnClick()
	end
end

function Element:__AddEventListener()
	self.resetBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnResetTalentBtnClick)
	self.upgradeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnUpgradeBtnClick)
	self.overviewBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnOverviewBtnClick)
end

function Element:__RemoveEventListener()
	self.resetBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnResetTalentBtnClick)
	self.upgradeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnUpgradeBtnClick)
	self.overviewBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnOverviewBtnClick)
end

function Element:__AddEnableEventListener()
	EventDispatcher.AddEventListener(EventID.MazeSenroTalentDataChange, self.__delegateOnMazeSenroTalentDataChange)
	EventDispatcher.AddEventListener(EventID.MazeSenroDataChange, self.__delegateOnMazeSenroDataChange)
end

function Element:__RemoveEnableEventListener()
	EventDispatcher.RemoveEventListener(EventID.MazeSenroTalentDataChange, self.__delegateOnMazeSenroTalentDataChange)
	EventDispatcher.RemoveEventListener(EventID.MazeSenroDataChange, self.__delegateOnMazeSenroDataChange)
end

function Element:__OnMazeSenroTalentDataChange()
	self:__RefreshTalentShow()
end

function Element:__OnMazeSenroDataChange()
	self:__RefreshTalentShow()
end

function Element:__OnResetTalentBtnClick()
	MazeModule.OnResetSenro()
end

function Element:__OnUpgradeBtnClick()
	self.mainView:ShowLvUpView()
end

function Element:__OnOverviewBtnClick()
	self.mainView:ShowEffectOverview()
end

function Element:__RefreshTalentShow()
	ForPairs(self.talentItemList, function(_talentCid, _talentItem)
		_talentItem:RefreshShow()
	end)
	UGUIUtil.SetText(self.leTextEn, MazeApi:GetENLevelText(MazeModule.GetSenroTalentLevel()))
	UGUIUtil.SetText(self.lvTextCn, MazeApi:GetCNLevelText(MazeModule.GetSenroTalentLevel()))
end

function Element:Show()
	self.talentTipView:Hide()
	self.gameObject:SetActive(true)
	self:__RefreshTalentShow()
	self:__AddEnableEventListener()
end

function Element:Hide()
	self:__RemoveEnableEventListener()
	self.gameObject:SetActive(false)
end

function Element:Dispose()
	self:__RemoveEventListener()
	self:__RemoveEnableEventListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
