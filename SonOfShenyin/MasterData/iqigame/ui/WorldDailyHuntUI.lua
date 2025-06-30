-- chunkname: @IQIGame\\UI\\WorldDailyHuntUI.lua

local WorldDailyHuntUI = {}

WorldDailyHuntUI = Base:Extend("WorldDailyHuntUI", "IQIGame.Onigao.UI.WorldDailyHuntUI", WorldDailyHuntUI)

local BossItemClass = require("IQIGame/UI/WorldDaily/WorldDailyHunt_BossItem")

function WorldDailyHuntUI:OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function WorldDailyHuntUI:InitMembers()
	self.bossItemArray = {}
	self.rewardItemArray = {}
end

function WorldDailyHuntUI:InitComponent()
	self.bossItemArray = {}
	self.transMonsterContent = self.monsterContent.transform

	local len = LuaUtility.GetChildCount(self.transMonsterContent)

	for i = 1, len do
		local trans = LuaUtility.GetChild(self.transMonsterContent, i - 1)
		local o = GameObject.Instantiate(self.bossItem, trans)

		LuaUtility.SetAnchoredPositionWithRectTransform(o:GetComponent("RectTransform"), 0, 0)

		local item = BossItemClass.New(o, self)

		self.bossItemArray[i] = item
	end

	self.returnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.currency = CurrencyCell.New(self.topMoney)
end

function WorldDailyHuntUI:InitDelegate()
	function self.delegateOnClickButtonGo()
		self:OnClickButtonGo()
	end

	function self.delegateOnClickButtonGet()
		self:OnClickButtonGet()
	end
end

function WorldDailyHuntUI:OnAddListeners()
	self.buttonGo:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonGo)
	self.buttonGet:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonGet)
	EventUtil.AddEventListener(self, EventID.ReceiveCrusadeResultEvent)
	EventUtil.AddEventListener(self, EventID.WorldDailyHuntUIRefresh)
end

function WorldDailyHuntUI:OnRemoveListeners()
	self.buttonGo:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonGo)
	self.buttonGet:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonGet)
	EventUtil.ClearEventListener(self)
end

function WorldDailyHuntUI:__OnWorldDailyHuntUIRefreshHandler()
	self:Refresh()
	self:RefreshDetail()
	self:RefreshDetailButtonState()
end

function WorldDailyHuntUI:__OnReceiveCrusadeResultEventHandler()
	self:Refresh()
	self:RefreshDetailButtonState()
end

function WorldDailyHuntUI:OnClickButtonGo()
	if not self.crrSelectedId then
		return
	end

	local cfgCrusade = CfgUtil.GetCfgCrusadeDupStageDataWithID(self.crrSelectedId)
	local actionData = WorldMapModule.GetComponentActionDataWithId(cfgCrusade.ActionId)
	local componentData = WorldMapModule.GetComponentDataWithId(actionData.compCid)

	if not componentData then
		logError(string.format("【RPG】角色传送没有找到行为 id = %s,所属组件id = %s的组件数据", actionData.cid, actionData.compCid))

		return
	end

	local transPos = componentData:GetCfg().TransmitPoint
	local pos

	if transPos[1] and transPos[2] and transPos[3] then
		pos = Vector3.New(transPos[1], transPos[2], transPos[3])
	else
		pos = Vector3.New(componentData.pos.x + 3, componentData.pos.y, componentData.pos.z)
	end

	WorldMapModule.EnterRoom(actionData:GetRoomId(), true, pos and WorldMapModule.PackingEnterRoomData(pos) or nil)
	UIModule.CloseSelf(self)
end

function WorldDailyHuntUI:OnClickButtonGet()
	if not self.crrSelectedItem then
		return
	end

	local cfgCrusade = CfgUtil.GetCfgCrusadeDupStageDataWithID(self.crrSelectedItem.data.crusadeCid)

	if cfgCrusade.RecieveCost[1] and cfgCrusade.RecieveCost[2] then
		local num = WarehouseModule.GetItemNumByCfgID(cfgCrusade.RecieveCost[1])

		if num < cfgCrusade.RecieveCost[2] then
			NoticeModule.ShowNotice(12003)

			return
		end
	end

	net_crusadeDup.receiveCrusade(self.crrSelectedItem.data.crusadeCid)
end

function WorldDailyHuntUI:OnOpen(userData)
	self:Refresh()
	LuaUtility.SetGameObjectShow(self.detailPanel, false)

	self.crrSelectedItem = nil
	self.crrSelectedId = nil
end

function WorldDailyHuntUI:OnClose(userData)
	self.crrSelectedItem = nil
	self.crrSelectedId = nil

	self:StopTimer()
end

function WorldDailyHuntUI:GetPreloadAssetPaths()
	return nil
end

function WorldDailyHuntUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WorldDailyHuntUI:IsManualShowOnOpen(userData)
	return false
end

function WorldDailyHuntUI:GetBGM(userData)
	return nil
end

function WorldDailyHuntUI:OnPause()
	return
end

function WorldDailyHuntUI:OnResume()
	return
end

function WorldDailyHuntUI:OnCover()
	return
end

function WorldDailyHuntUI:OnReveal()
	return
end

function WorldDailyHuntUI:OnRefocus(userData)
	return
end

function WorldDailyHuntUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WorldDailyHuntUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WorldDailyHuntUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WorldDailyHuntUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WorldDailyHuntUI:Refresh()
	local data = PlayerModule.GetCrusadeData()
	local len = #data
	local index = 1

	for i = 1, len do
		self.bossItemArray[i]:Refresh(data[i])
		self.bossItemArray[i]:Show()

		index = i
	end

	for i = index + 1, #self.bossItemArray do
		self.bossItemArray[i]:Hide()
	end

	self.currency:RefreshItem(Constant.TopMoneyType.WorldHunt)
end

function WorldDailyHuntUI:OnBossItemSelected(item)
	if self.crrSelectedItem then
		self.crrSelectedItem:UnSelected()

		self.crrSelectedItem = nil
	end

	self.crrSelectedItem = item

	self.crrSelectedItem:Selected()

	self.crrSelectedId = self.crrSelectedItem.data.crusadeCid

	self:RefreshDetail()
end

function WorldDailyHuntUI:RefreshDetail()
	if not self.crrSelectedItem then
		LuaUtility.SetGameObjectShow(self.detailPanel, false)

		return
	end

	local cfgCrusade = CfgUtil.GetCfgCrusadeDupStageDataWithID(self.crrSelectedItem.data.crusadeCid)

	LuaUtility.SetText(self.textName, cfgCrusade.Name)
	LuaUtility.SetText(self.textDetail, cfgCrusade.Detail)
	LuaUtility.SetText(self.textLv, cfgCrusade.RecommonLv)
	LuaUtility.SetText(self.textCost, cfgCrusade.RecieveCost[2])
	LuaUtility.SetGameObjectShow(self.detailPanel, true)
	LuaUtility.PlayAnimation(self.detailPanel, "WorldDailyHuntUI_detailPanel_In")

	local index = 1

	for i = 1, #cfgCrusade.CrusadeReward, 2 do
		local item = self:_GetRewardItem(index)

		item:SetItemByCid(cfgCrusade.CrusadeReward[i])
		item:SetNum(cfgCrusade.CrusadeReward[i + 1])

		index = index + 1
	end

	for i = index, #self.rewardItemArray do
		self.rewardItemArray[i]:Hide()
	end

	self:StopTimer()
	self:RefreshTime()

	self.timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer:Start()
	self:RefreshDetailButtonState()
end

function WorldDailyHuntUI:RefreshDetailButtonState()
	if not self.crrSelectedItem then
		return
	end

	LuaUtility.SetGameObjectShow(self.buttonGo, self.crrSelectedItem.data.state == Constant.WorldDailyHuntState.HasGet)
	LuaUtility.SetGameObjectShow(self.buttonGet, self.crrSelectedItem.data.state == Constant.WorldDailyHuntState.Normal)
	LuaUtility.SetGameObjectShow(self.hadHunted, self.crrSelectedItem.data.state == Constant.WorldDailyHuntState.HadHunted)
end

function WorldDailyHuntUI:_GetRewardItem(index)
	if not self.rewardItemArray[index] then
		local o = GameObject.Instantiate(self.CommonSlotUI, self.rewardContent.transform)

		self.rewardItemArray[index] = ItemCell.New(o, true, true, false)
	end

	return self.rewardItemArray[index]
end

function WorldDailyHuntUI:RefreshTime()
	local seconds = self.crrSelectedItem.data.endTime - PlayerModule.GetServerTime()

	LuaUtility.SetText(self.textTime, DateStandardFormation(seconds))
end

function WorldDailyHuntUI:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function WorldDailyHuntUI:OnDestroy()
	self:StopTimer()
	self.currency:Dispose()

	self.currency = nil
	self.transMonsterContent = nil

	self.returnBtn:Dispose()

	for _, v in pairs(self.bossItemArray) do
		v:OnDestroy()
	end

	self.bossItemArray = nil

	AssetUtil.UnloadAsset(self)
end

return WorldDailyHuntUI
