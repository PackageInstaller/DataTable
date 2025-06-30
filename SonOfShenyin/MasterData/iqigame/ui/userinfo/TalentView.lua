-- chunkname: @IQIGame\\UI\\UserInfo\\TalentView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local talentItemCell = require("IQIGame.UI.UserInfo.ItemCell.TalentItemCell")
local talentLineItemCell = require("IQIGame.UI.UserInfo.ItemCell.TalentLineItemCell")
local m = {
	talentItemList = {},
	talentLineItemList = {}
}

function m.New(view, resetView, mainView)
	local obj = Clone(m)

	obj:Init(view, resetView, mainView)

	return obj
end

function m:Init(view, resetView, mainView)
	self.View = view
	self.resetView = resetView
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.talentItemCellPool = UIViewObjectPool.New(self.talentItem, self.talentItemPanel.transform, function(_view)
		return talentItemCell.New(_view, function(talentId)
			self:SelectEvent(talentId)
		end)
	end)
	self.talentLineItemCellPool = UIViewObjectPool.New(self.lineItem, self.linePanel.transform, function(_view)
		return talentLineItemCell.New(_view)
	end)

	function self.DelegateOnClickUnlockBtn()
		self:OnClickUnlockBtn()
	end

	function self.DelegateOnClickResetBtn()
		self:OnClickResetBtn()
	end

	function self.DelegateOnActiveTalentSuccess()
		self:OnActiveTalentSuccess()
	end

	function self.DelegateOnResetTalentSuccess()
		self:OnResetTalentSuccess()
	end

	function self.DelegateOnClickTalentInfoPanelBtn()
		self:SetTalentInfoPanelState(false)
	end

	function self.DelegateUpdateItem()
		self:RefreshTalentItemInfo()
	end

	self.resetBtnCom = self.resetBtn:GetComponent("Button")
	self.resetBtnGrayCom = self.resetBtn:GetComponent("GrayComponent")
	self.TalenScrollViewCom = self.TalenScrollView:GetComponent("ScrollRect")
	self.TalentContentItemRectCom = self.TalentContentItem:GetComponent("RectTransform")
	self.mainViewCanvasRectCom = self.mainView.UIController.transform:GetComponent("RectTransform")

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemCid.TALENT].Icon), self.talentPointImg:GetComponent("Image"))
	self:CreateTalentItem()
	self:AddListeners()
end

function m:AddListeners()
	self.unlockBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnlockBtn)
	self.resetBtnCom.onClick:AddListener(self.DelegateOnClickResetBtn)
	self.closeTalentInfoPanelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTalentInfoPanelBtn)
	EventDispatcher.AddEventListener(EventID.ActiveTalentSuccess, self.DelegateOnActiveTalentSuccess)
	EventDispatcher.AddEventListener(EventID.ResetTalentSuccess, self.DelegateOnResetTalentSuccess)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function m:RemoveListeners()
	self.unlockBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnlockBtn)
	self.resetBtnCom.onClick:RemoveListener(self.DelegateOnClickResetBtn)
	self.closeTalentInfoPanelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTalentInfoPanelBtn)
	EventDispatcher.RemoveEventListener(EventID.ActiveTalentSuccess, self.DelegateOnActiveTalentSuccess)
	EventDispatcher.RemoveEventListener(EventID.ResetTalentSuccess, self.DelegateOnResetTalentSuccess)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function m:CreateTalentItem()
	self:CalculationContentSize()

	self.talentItemList = {}

	for k, v in pairsCfg(CfgPlayerTalentTable) do
		self.talentItemList[v.Id] = self.talentItemCellPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		self.talentItemList[v.Id]:Show()
		self.talentItemList[v.Id]:SetData(v)
		self.talentItemList[v.Id]:UnSelect()
	end

	self.talentLineItemList = {}

	for k, v in pairsCfg(CfgPlayerTalentTable) do
		self:DrawLine(v)
	end
end

function m:DrawLine(talentCfg)
	local talentId = talentCfg.Id

	for k, v in pairs(talentCfg.Precondition) do
		local lineItem = self.talentLineItemCellPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		lineItem:SetData(v, self.talentItemList[talentId].View, self.talentItemList[v].View)
		table.insert(self.talentLineItemList, lineItem)
	end
end

function m:SetData()
	self:SetTalentInfoPanelState(false)
	self:SetCountDownTime()
	self:RefreshResetTalentInfo()
	self:RefreshLineInfo()
	self:RefreshTalentItemInfo()
	self:HideTalentItemSelect()
end

function m:RefreshResetTalentInfo()
	local isCanReset = UserInfoModule.ResetTimeCd - PlayerModule.GetServerTime() <= 0 and table.len(UserInfoModule.Talents) > 0

	self.resetBtnCom.enabled = isCanReset

	self.resetBtnGrayCom:SetGray(not isCanReset)
	LuaUtility.SetGameObjectShow(self.timeImg, UserInfoModule.ResetTimeCd - PlayerModule.GetServerTime() > 0)

	if UserInfoModule.ResetTimeCd > 0 then
		self:ResetTimer()

		self.countDownTimer = Timer.New(function()
			self:SetCountDownTime()
		end, 1, -1)

		self.countDownTimer:Start()
	end

	LuaUtility.SetGameObjectShow(self.resetTimeText, UserInfoModule.ResetTimeCd > 0)
end

function m:SetCountDownTime()
	if UserInfoModule.ResetTimeCd - PlayerModule.GetServerTime() <= 0 then
		UGUIUtil.SetText(self.resetTimeText, "")
	else
		local second = UserInfoModule.ResetTimeCd - PlayerModule.GetServerTime()

		UGUIUtil.SetText(self.resetTimeText, DateTimeFormat(second, self:GetTimeSurplusState(second)))
	end
end

function m:GetTimeSurplusState(second)
	if second <= 3600 then
		return UserInfoApi:GetTimeFormat(1)
	elseif second <= 86400 then
		return UserInfoApi:GetTimeFormat(2)
	else
		return UserInfoApi:GetTimeFormat(3)
	end
end

function m:RefreshTalentInfo(talentId)
	if talentId == nil then
		return
	end

	self.selectTalentId = talentId

	local talentCfg = CfgPlayerTalentTable[talentId]

	UGUIUtil.SetText(self.talentNameText, talentCfg.TalentStory)
	UGUIUtil.SetText(self.talentEffectText, talentCfg.Talent1Story)

	local isUnlock = UserInfoModule.GetTalentIsActive(talentId)

	LuaUtility.SetGameObjectShow(self.costImg, not isUnlock)
	LuaUtility.SetGameObjectShow(self.costNumText, not isUnlock)
	LuaUtility.SetGameObjectShow(self.unlockBtn, not isUnlock)
	AssetUtil.LoadImage(self, talentCfg.TalentIcon, self.talentImg:GetComponent("Image"), function()
		return
	end)

	if not isUnlock then
		UGUIUtil.SetText(self.costNumText, talentCfg.TalentCost[2])
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[talentCfg.TalentCost[1]].Icon), self.costImg:GetComponent("Image"))
	end
end

function m:RefreshLineInfo()
	for k, v in pairs(self.talentLineItemList) do
		v:SetState()
	end
end

function m:RefreshTalentItemInfo()
	UGUIUtil.SetText(self.talentPointNumText, WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.TALENT))
end

function m:HideTalentItemSelect()
	for k, v in pairs(self.talentItemList) do
		v:UnSelect()
	end
end

function m:SelectEvent(talentId)
	self:HideTalentItemSelect()
	self.talentItemList[talentId]:Select()
	self:LocationTalentInfoPanel(self.talentItemList[talentId].View)
	self:SetTalentInfoPanelState(true)
	self:RefreshTalentInfo(talentId)
end

function m:SetTalentInfoPanelState(state)
	LuaUtility.SetGameObjectShow(self.closeTalentInfoPanelBtn, state)
	LuaUtility.SetGameObjectShow(self.TalentContentItem, state)
end

function m:LocationTalentInfoPanel(gameObject)
	local screenPos = GameEntry.UICamera:WorldToScreenPoint(gameObject.transform.position)
	local isRect, resultPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.mainViewCanvasRectCom, screenPos, GameEntry.UICamera, nil)
	local maxWidth = self.mainViewCanvasRectCom.sizeDelta.x
	local maxHeight = self.mainViewCanvasRectCom.sizeDelta.y
	local posx = resultPos.x + self.TalentContentItemRectCom.sizeDelta.x / 2 + 40
	local posy = resultPos.y

	if posx + self.TalentContentItemRectCom.sizeDelta.x / 2 > maxWidth / 2 then
		posx = maxWidth / 2 - self.TalentContentItemRectCom.sizeDelta.x / 2
	elseif posx - self.TalentContentItemRectCom.sizeDelta.x / 2 < -(maxWidth / 2) then
		posx = -(maxWidth / 2) + self.TalentContentItemRectCom.sizeDelta.x / 2
	end

	if posy + self.TalentContentItemRectCom.sizeDelta.y / 2 > maxHeight / 2 then
		posy = maxHeight / 2 - self.TalentContentItemRectCom.sizeDelta.y / 2
	elseif posy - self.TalentContentItemRectCom.sizeDelta.y / 2 < -(maxHeight / 2) then
		posy = -(maxHeight / 2) + self.TalentContentItemRectCom.sizeDelta.y / 2
	end

	LuaUtility.SetAnchoredPositionWithRectTransform(self.TalentContentItemRectCom, posx, posy)
end

function m:LocationTalentItem(talentId)
	local item = self.talentItemList[talentId].View
	local screenPos = GameEntry.UICamera:WorldToScreenPoint(item.transform.position)
	local isRect, resultPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.TalenScrollViewCom.content, screenPos, GameEntry.UICamera, nil)

	if isRect then
		local contentRectTransform = self.TalenScrollViewCom.content
		local contentRect = contentRectTransform.rect
		local viewRect = self.TalenScrollViewCom:GetComponent("RectTransform").rect
		local normalizedPoint = Vector2.New((resultPos.x - contentRect.x) / (contentRect.x - viewRect.x / 2), (resultPos.y - contentRect.y) / (contentRect.y - viewRect.y / 2))

		self.TalenScrollViewCom.normalizedPosition = normalizedPoint
	end
end

function m:OnClickUnlockBtn()
	if UserInfoModule.GetTalentIsCanActive(self.selectTalentId) == false then
		NoticeModule.ShowNotice(20039)

		return
	end

	local cfg = CfgPlayerTalentTable[self.selectTalentId]
	local allCount = WarehouseModule.GetItemNumByCfgID(cfg.TalentCost[1])

	if allCount < cfg.TalentCost[2] then
		NoticeModule.ShowNotice(12003)

		return
	end

	UserInfoModule.ActiveTalent(self.selectTalentId)
end

function m:OnClickResetBtn()
	self.resetView:Show()
end

function m:OnActiveTalentSuccess()
	self:RefreshResetTalentInfo()
	self:RefreshTalentInfo(self.selectTalentId)
	self:RefreshLineInfo()
end

function m:OnResetTalentSuccess()
	self:RefreshResetTalentInfo()
	self:RefreshTalentInfo(self.selectTalentId)
	self:RefreshLineInfo()
end

function m:ResetTimer()
	if self.countDownTimer then
		self.countDownTimer:Stop()

		self.countDownTimer = nil
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
	self:SetData()
end

function m:Hide()
	self:ResetTimer()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:CalculationContentSize()
	local minX = 0
	local maxX = 0
	local minY = 0
	local maxY = 0

	for k, v in pairsCfg(CfgPlayerTalentTable) do
		minX = math.min(minX, v.Coordinate[1])
		maxX = math.max(maxX, v.Coordinate[1])
		minY = math.min(minY, v.Coordinate[2])
		maxY = math.max(maxY, v.Coordinate[2])
	end

	local tempX = maxX - minX + 150
	local tempY = maxY - minY + 150

	LuaUtility.SetSizeDeltaWithRectTransform(self.ItemContent:GetComponent("RectTransform"), tempX, tempY)
end

function m:Dispose()
	self:RemoveListeners()
	self:ResetTimer()
	self.talentItemCellPool:Dispose(function(_item)
		_item:Dispose()
	end)
	self.talentLineItemCellPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.talentItemList = nil
	self.talentLineItemList = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
