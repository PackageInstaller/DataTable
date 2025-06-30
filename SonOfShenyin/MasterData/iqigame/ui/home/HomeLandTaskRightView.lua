-- chunkname: @IQIGame\\UI\\Home\\HomeLandTaskRightView.lua

local HeroItemCell = {
	cellIndex = 0,
	roleCid = 0
}

function HeroItemCell.New(gameObject, index, clickEvent)
	local obj = Clone(HeroItemCell)

	obj:__Init(gameObject, index, clickEvent)

	return obj
end

function HeroItemCell:__Init(gameObject, index, clickEvent)
	self.gameObject = gameObject
	self.cellIndex = index
	self.OnClickEvent = clickEvent

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__OnItemClickEventProxy()
		self:__OnClickEvent()
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.__OnItemClickEventProxy)
end

function HeroItemCell:Show(roleCid)
	self.gameObject:SetActive(true)

	if roleCid == nil then
		self.roleInfoRoot.gameObject:SetActive(false)
	else
		self:__OnShowRole(roleCid)
	end
end

function HeroItemCell:__OnShowRole(roleCid)
	self.heroCid = roleCid

	self.roleInfoRoot.gameObject:SetActive(true)

	local heroData = WarlockModule.GetHeroData(self.heroCid)
	local iconPath = heroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, iconPath, self.roleIcon:GetComponent("Image"))
end

function HeroItemCell:Hide()
	self.gameObject:SetActive(false)
end

function HeroItemCell:__OnClickEvent()
	if self.OnClickEvent == nil then
		return
	end

	self.OnClickEvent(self.cellIndex, self.heroCid)
end

function HeroItemCell:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.__OnItemClickEventProxy)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local ConditionItem = {
	advType = 0,
	value = 0
}

function ConditionItem.New(view)
	local obj = Clone(ConditionItem)

	obj:__Init(view)

	return obj
end

function ConditionItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function ConditionItem:Show(advType, value)
	self.advType = advType
	self.value = value

	self.gameObject:SetActive(true)

	local conditionText = HomeLandApi:GetTaskAdvText(self.advType, self.value)

	self.text1:GetComponent("Text").text = conditionText
	self.text2:GetComponent("Text").text = conditionText
end

function ConditionItem:RefreshConditionShow(isLegal)
	self.offRoot.gameObject:SetActive(not isLegal)
	self.onRoot.gameObject:SetActive(isLegal)
end

function ConditionItem:Hide()
	self.gameObject:SetActive(false)

	self.advType = 0
end

function ConditionItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local UIElement = {
	maxHeroCount = 0,
	taskCid = 0,
	needUpdateTime = false,
	heroCidList = {},
	heroViewList = {},
	rewardItemViewList = {},
	rewardExItemViewList = {},
	conditionItemViewList = {}
}

function UIElement.New(view)
	local obj = Clone(UIElement)

	obj:__Init(view)

	return obj
end

function UIElement:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__OnInitEventDelegate()
	self:__InitHeroListView()
	self:__InitRewardItemsView()
	self:__InitExConditionView()
	self:__OnAddListeners()
end

function UIElement:__OnInitEventDelegate()
	function self.__OnStartButtonClickEventProxy()
		self:__OnStartButtonClickEvent()
	end

	function self.__OnGetButtonClickEventProxy()
		self:__OnGetButtonClickEvent()
	end

	function self.__OnHeroViewItemClick(_cellIndex, _heroCid)
		self:__OnHeroItemCellClick(_cellIndex, _heroCid)
	end
end

function UIElement:__OnAddListeners()
	self.startBtn:GetComponent("Button").onClick:AddListener(self.__OnStartButtonClickEventProxy)
	self.getBtn:GetComponent("Button").onClick:AddListener(self.__OnGetButtonClickEventProxy)
end

function UIElement:__OnRemoveListeners()
	self.startBtn:GetComponent("Button").onClick:RemoveListener(self.__OnStartButtonClickEventProxy)
	self.getBtn:GetComponent("Button").onClick:RemoveListener(self.__OnGetButtonClickEventProxy)
end

function UIElement:Show(taskCid)
	self.taskCid = taskCid

	self.gameObject:SetActive(true)

	local taskCfg = CfgHomeDispTaskTable[self.taskCid]
	local taskData = HomeModule.GetDispTask(self.taskCid)

	self.heroCidList = Clone(taskData.heroCids)
	self.maxHeroCount = taskCfg.HeroLimit

	self:__ShowExConditionView(taskCfg)
	self:__InitHeroListShow(taskCfg.HeroLimit)
	self:__RefreshHeroListShow()
	self:__RefreshRewardsShow(taskCfg.CommonReward, self.rewardItemViewList)
	self:__RefreshRewardsShow(taskCfg.ExtraReward, self.rewardExItemViewList)

	self.taskNameText:GetComponent("Text").text = taskCfg.TaskInitiator
	self.taskDescText:GetComponent("Text").text = taskCfg.TaskDesc
	self.costNum:GetComponent("Text").text = HomeLandApi:GetReceiveTaskCostText(taskCfg.Cost[2])
	self.needHeroNum:GetComponent("Text").text = HomeLandApi:GetReceiveTaskNeedHeroNumText(taskCfg.HeroLimit)

	if not LuaUtility.StrIsNullOrEmpty(taskCfg.MiniMapRes) then
		AssetUtil.LoadImage(self, taskCfg.MiniMapRes, self.areaImg:GetComponent("Image"))
	end

	self.areaName:GetComponent("Text").text = taskCfg.MapName

	if taskData.status == Constant.HomeLandDispTaskType.Ready then
		self.workingState.gameObject:SetActive(false)
		self.startBtn.gameObject:SetActive(true)
		self.getBtn.gameObject:SetActive(false)
		self.needHeroNum.gameObject:SetActive(true)
		self.needTimeText.gameObject:SetActive(true)
		self:__ShowNeedTime(taskCfg.Time)
	elseif taskData.status == Constant.HomeLandDispTaskType.Running then
		self.needTimeText.gameObject:SetActive(true)
		self:__StartTime(taskData.executeTime, taskCfg.Time)
		self.workingState.gameObject:SetActive(true)
		self.startBtn.gameObject:SetActive(false)
		self.getBtn.gameObject:SetActive(false)
		self.needHeroNum.gameObject:SetActive(false)
	elseif taskData.status == Constant.HomeLandDispTaskType.Finish then
		self.workingState.gameObject:SetActive(false)
		self.startBtn.gameObject:SetActive(false)
		self.getBtn.gameObject:SetActive(true)
		self.needHeroNum.gameObject:SetActive(false)
		self.needTimeText.gameObject:SetActive(false)
	elseif taskData.status == Constant.HomeLandDispTaskType.Receive then
		self.workingState.gameObject:SetActive(false)
		self.startBtn.gameObject:SetActive(false)
		self.getBtn.gameObject:SetActive(false)
		self.needHeroNum.gameObject:SetActive(false)
		self.needTimeText.gameObject:SetActive(false)
	end
end

function UIElement:__OnStartButtonClickEvent()
	local taskCfg = CfgHomeDispTaskTable[self.taskCid]

	if #self.heroCidList ~= taskCfg.HeroLimit then
		NoticeModule.ShowNotice(53005)

		return
	end

	local ownerNum = WarehouseModule.GetItemNumByCfgID(taskCfg.Cost[1])

	if ownerNum < taskCfg.Cost[2] then
		NoticeModule.ShowNotice(53006)

		return
	end

	HomeModule.ExecuteDispTask(self.taskCid, self.heroCidList)
end

function UIElement:__OnGetButtonClickEvent()
	HomeModule.SubmitDispTask(self.taskCid)
end

function UIElement:Hide()
	self.gameObject:SetActive(false)
end

function UIElement:Dispose()
	self:__OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function UIElement:OnTimeUpdate()
	if not self.needUpdateTime then
		return
	end

	self.lastTime = self.lastTime - 1

	if self.lastTime <= 0 then
		self.lastTime = 0
	end

	self:__RefreshTimeText()
end

function UIElement:__StartTime(executeTime, totalTime)
	local serverTime = PlayerModule.GetServerTime()

	self.lastTime = totalTime - (serverTime - executeTime)

	self:__RefreshTimeText()

	self.needUpdateTime = true
end

function UIElement:__RefreshTimeText()
	local timeStr = DateTimeFormat(self.lastTime, "hh:mm:ss")

	self.needTimeText:GetComponent("Text").text = HomeLandApi:GetCompleteTaskTimeText(timeStr)
end

function UIElement:__ShowNeedTime(totalTime)
	self.needUpdateTime = false

	local timeStr = DateTimeFormat(totalTime, "hh:mm:ss")

	self.needTimeText:GetComponent("Text").text = HomeLandApi:GetReceiveTaskNeedTimeText(timeStr)
end

function UIElement:__InitHeroListView()
	for i = 0, self.roleGrid.transform.childCount - 1 do
		local childTrans = self.roleGrid.transform:GetChild(i)
		local index = i + 1
		local itemCell = HeroItemCell.New(childTrans.gameObject, index, self.__OnHeroViewItemClick)

		table.insert(self.heroViewList, itemCell)
	end
end

function UIElement:__InitHeroListShow(roleCount)
	ForArray(self.heroViewList, function(_index, _heroCell)
		local needShow = _index <= roleCount

		if not needShow then
			_heroCell:Hide()
		else
			local roleCid = self.heroCidList[_index]

			_heroCell:Show(roleCid)
		end
	end)
end

function UIElement:__RefreshHeroListShow()
	ForArray(self.heroViewList, function(_index, _heroCell)
		if not _heroCell.gameObject.activeSelf then
			return
		end

		local roleCid = self.heroCidList[_index]

		_heroCell:Show(roleCid)
	end)

	local active = #self.heroCidList == self.maxHeroCount

	self.rewardTag.gameObject:SetActive(active)
	self:__RefreshExConditionState()
end

function UIElement:__OnHeroItemCellClick(cellIndex, roleCid)
	local taskData = HomeModule.GetDispTask(self.taskCid)

	if taskData.status ~= Constant.HomeLandDispTaskType.Ready then
		return
	end

	if self.OnShowHeroBagEvent == nil then
		return
	end

	self.selectRoleCellIndex = cellIndex

	self.OnShowHeroBagEvent(roleCid)
end

function UIElement:OnHeroSelected(roleCid)
	local indexOff = 0

	ForArray(self.heroCidList, function(_index, _roleCid)
		if _roleCid == roleCid then
			indexOff = _index
			isInSelect = true

			return true
		end
	end)

	if indexOff ~= 0 then
		table.remove(self.heroCidList, indexOff)
		self:__RefreshHeroListShow()

		return
	end

	if self.maxHeroCount == #self.heroCidList then
		if self.maxHeroCount > 1 then
			return
		end

		self.heroCidList = {
			roleCid
		}
	else
		table.insert(self.heroCidList, roleCid)
	end

	self:__RefreshHeroListShow()
end

function UIElement:__InitRewardItemsView()
	for i = 0, self.rewardGrid.transform.childCount - 1 do
		local childTrans = self.rewardGrid.transform:GetChild(i)
		local itemCell = ItemCell.New(childTrans.gameObject, true, true, true)

		table.insert(self.rewardItemViewList, itemCell)
	end

	for i = 0, self.rewardExGrid.transform.childCount - 1 do
		local childTrans = self.rewardExGrid.transform:GetChild(i)
		local itemCell = ItemCell.New(childTrans.gameObject, true, true, true)

		table.insert(self.rewardExItemViewList, itemCell)
	end
end

function UIElement:__RefreshRewardsShow(rewardCfg, cellTable)
	ForArray(cellTable, function(_, _itemCell)
		_itemCell:Hide()
	end)

	local cellIndex = 1

	ForArrayCustomStep(rewardCfg, function(_index, _)
		local itemCid = rewardCfg[_index]
		local cnt = rewardCfg[_index + 1]
		local itemCell = cellTable[cellIndex]

		itemCell.showMoneyNum = true

		itemCell:SetItemByCid(itemCid, cnt)
		itemCell:Show()

		cellIndex = cellIndex + 1
	end, 2)
end

function UIElement:__InitExConditionView()
	for i = 0, self.conditionGrid.transform.childCount - 1 do
		local childTrans = self.conditionGrid.transform:GetChild(i)
		local itemCell = ConditionItem.New(childTrans.gameObject)

		table.insert(self.conditionItemViewList, itemCell)
	end
end

function UIElement:__ShowExConditionView(taskCfg)
	local index = self:__ShowExConditionItem(Constant.HomeLandDispTaskAdvType.Profession, taskCfg.ProfessionAdv, 1)

	index = self:__ShowExConditionItem(Constant.HomeLandDispTaskAdvType.Elemental, taskCfg.ElementalAdv, index)
	index = self:__ShowExConditionItem(Constant.HomeLandDispTaskAdvType.Level, taskCfg.LevelAdv, index)

	for i = index, #self.conditionItemViewList do
		self.conditionItemViewList[i]:Hide()
	end
end

function UIElement:__ShowExConditionItem(advType, value, index)
	if value == nil then
		return index
	end

	if #value == 0 then
		return index
	end

	self.conditionItemViewList[index]:Show(advType, value)

	index = index + 1

	return index
end

function UIElement:__RefreshExConditionState()
	local cnt = 0

	ForPairs(self.conditionItemViewList, function(_, _item)
		local isLegal = self:__CheckCondition(_item.advType, _item.value)

		_item:RefreshConditionShow(isLegal)

		if isLegal then
			cnt = cnt + 1
		end
	end)

	if cnt > 0 then
		self.exRewardCount.transform.parent.gameObject:SetActive(true)

		self.exRewardCount:GetComponent("Text").text = HomeLandApi:GetTaskExRewardNumText(cnt)

		self.rewardExTag.gameObject:SetActive(true)
	else
		self.exRewardCount.transform.parent.gameObject:SetActive(false)
		self.rewardExTag.gameObject:SetActive(false)
	end
end

function UIElement:__CheckCondition(advType, values, _heroCid)
	local isLegal = false

	ForArray(self.heroCidList, function(_, _heroCid)
		local heroCfg = CfgHeroTable[_heroCid]

		if advType == Constant.HomeLandDispTaskAdvType.Profession then
			isLegal = self:__CheckValueInArray(values, heroCfg.Profession)
		elseif advType == Constant.HomeLandDispTaskAdvType.Elemental then
			isLegal = self:__CheckValueInArray(values, heroCfg.Elements)
		elseif advType == Constant.HomeLandDispTaskAdvType.Level then
			local heroData = WarlockModule.GetHeroData(_heroCid)

			isLegal = heroData.lv >= values[1]
		end

		return isLegal
	end)

	return isLegal
end

function UIElement:__CheckValueInArray(values, value)
	local isLegal = false

	ForArray(values, function(_, _value)
		isLegal = _value == value

		return isLegal
	end)

	return isLegal
end

return UIElement
