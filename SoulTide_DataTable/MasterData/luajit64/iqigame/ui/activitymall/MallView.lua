-- chunkname: @IQIGame\\UI\\ActivityMall\\MallView.lua

local MallView = {
	tabTopDatum = {},
	tabLeftDatum = {},
	cellOnePool = {}
}
local MallCellOne = require("IQIGame.UI.Mall.MallCellOne")

function MallView.New(view, mainView)
	local obj = Clone(MallView)

	obj:Init(view, mainView)

	return obj
end

function MallView:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tabLeftList = self.goTabLeftList:GetComponent("ScrollAreaList")

	function self.tabLeftList.onRenderCell(cell)
		self:OnRenderTabLeft(cell)
	end

	function self.tabLeftList.onSelectedCell(cell)
		self:OnSelectTabLeft(cell)
	end

	self.shortList = self.goShortList:GetComponent("ScrollAreaList")

	function self.shortList.onRenderCell(cell)
		self:OnRenderItemCellOne(cell)
	end

	function self.shortList.onSelectedCell(cell)
		self:OnSelectItemCellOne(cell)
	end

	self.tabTopList = self.goTabTopList:GetComponent("ScrollAreaList")

	function self.tabTopList.onRenderCell(cell)
		self:OnRenderTabTop(cell)
	end

	function self.tabTopList.onSelectedCell(cell)
		self:OnSelectTabTop(cell)
	end

	function self.onBuyGoodsSuccessDelegate(id)
		self:OnBuyGoodsSuccess(id)
	end

	function self.onUpdateMallDelegate()
		self:OnUpdateMall()
	end

	function self.onTaskCommitResponseDelegate(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	function self.onNotifyPayInfoDelegate()
		self:OnNotifyPayInfo()
	end
end

function MallView:Refresh(entranceType, customMallCids)
	self.entranceType = entranceType
	self.customMallCids = customMallCids

	self:OnRemoveListener()
	self:OnAddListener()
	self:RefreshDatum()
	self:RefreshTabTopBlock()
end

function MallView:OnUpdate(elapseSeconds, realElapseSeconds)
	for i, v in pairs(self.cellOnePool) do
		v:OnUpdate(elapseSeconds, realElapseSeconds)
	end

	if self.needEnableLeftTabTimer and self.tabLeftList ~= nil and self.curCfgMallType ~= nil then
		self.leftTabTimer = self.leftTabTimer + realElapseSeconds

		if self.leftTabTimer >= 1 then
			self.leftTabTimer = 0

			if self.resetTab then
				local tabLeftDatum = self:GetTabLeftDatum(self.curCfgMallType.Type)

				if #tabLeftDatum == 0 then
					self:Refresh(self.entranceType, self.customMallCids)
				else
					self:RefreshTabLeftBlock(self.curCfgMallType.Type)
				end
			else
				self.tabLeftList:RenderCells()
			end
		end
	end
end

function MallView:OnHide()
	self:OnRemoveListener()

	for i, v in pairs(self.cellOnePool) do
		v:OnHide()
	end
end

function MallView:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.cellOnePool) do
		v:OnDestroy()
	end

	self.mainView = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function MallView:OnAddListener()
	EventDispatcher.AddEventListener(EventID.BuyGoodsSuccess, self.onBuyGoodsSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateMall, self.onUpdateMallDelegate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
	EventDispatcher.AddEventListener(EventID.NotifyPayInfo, self.onNotifyPayInfoDelegate)
end

function MallView:OnRemoveListener()
	EventDispatcher.RemoveEventListener(EventID.BuyGoodsSuccess, self.onBuyGoodsSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateMall, self.onUpdateMallDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
	EventDispatcher.RemoveEventListener(EventID.NotifyPayInfo, self.onNotifyPayInfoDelegate)
end

function MallView:OnNotifyPayInfo()
	self.goodDatum = self:GetTabLeftGoodsDatum(self.curCfgMallType)

	self:RefreshContentOnCurState()
end

function MallView:OnBuyGoodsSuccess(id)
	self.goodDatum = self:GetTabLeftGoodsDatum(self.curCfgMallType)

	self:RefreshContentOnCurState()
end

function MallView:OnUpdateMall()
	if not MallModule.CheckExistGoods(self.entranceType) then
		UIModule.CloseSelf(self)

		return
	end

	self:RefreshContentOnCurState()
end

function MallView:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function MallView:OnRenderTabTop(cell)
	local luaIndex = cell.index + 1
	local type = self.tabTopDatum[luaIndex]
	local icon = cell.transform:Find("goUp/Image_02"):GetComponent("Image")
	local helperComp = cell.gameObject:GetComponent("ToggleHelperComponent")
	local redPointDown = cell.transform:Find("goDown/Tag/RedPoint").gameObject
	local redPointUp = cell.transform:Find("goUp/Tag/RedPoint").gameObject

	redPointDown:SetActive(false)
	redPointUp:SetActive(false)

	helperComp.text = MallUIApi:GetString("tabTopName", type, self.entranceType)

	AssetUtil.LoadImage(self, MallUIApi:GetString("tabTopIcon", type), icon)
end

function MallView:OnSelectTabTop(cell)
	local luaIndex = cell.index + 1
	local type = self.tabTopDatum[luaIndex]

	self:RefreshTabLeftBlock(type)
end

function MallView:OnRenderTabLeft(cell)
	local luaIndex = cell.index + 1
	local cfgMallTypeData = self.tabLeftDatum[luaIndex]
	local tfDown = cell.transform:Find("goDown/Text_01"):GetComponent("Text")
	local tfUp = cell.transform:Find("goUp/Text_01"):GetComponent("Text")
	local redPointDown = cell.transform:Find("goDown/Tag/RedPoint").gameObject
	local redPointUp = cell.transform:Find("goUp/Tag/RedPoint").gameObject
	local tfResidueTime = cell.transform:Find("Text"):GetComponent("Text")
	local signTime = cell.transform:Find("Image_Icon").gameObject

	signTime:SetActive(cfgMallTypeData.TimeLimitType ~= 0)
	redPointDown:SetActive(false)
	redPointUp:SetActive(false)

	tfDown.text = MallUIApi:GetString("tabLeftName", cfgMallTypeData.TabName)
	tfUp.text = tfDown.text

	tfResidueTime.gameObject:SetActive(cfgMallTypeData.TimeLimitType ~= 0)

	if cfgMallTypeData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		local residueTime = math.max(0, cfgDateTimeToTimeStamp(cfgMallTypeData.TimeLimitEnd, PlayerModule.TimeZone) - self:GetServerTime())

		tfResidueTime.text = MallUIApi:GetString("tabResidueTime", residueTime)

		if residueTime == 0 then
			self.resetTab = true
		end
	end

	local showLeftTab = #self.tabLeftDatum ~= 1

	self.goTabLeftList:SetActive(showLeftTab)
	self.goLeftBox:SetActive(showLeftTab)
end

function MallView:OnSelectTabLeft(cell)
	local luaIndex = cell.index + 1
	local cfgMallType = self.tabLeftDatum[luaIndex]

	self.goodDatum = self:GetTabLeftGoodsDatum(cfgMallType)

	self:RefreshContent(cfgMallType)
	self.mainView:RefreshMoneyCells(self.goodDatum)
end

function MallView:OnRenderItemCellOne(grid)
	local luaIndex = grid.index + 1
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.cellOnePool[insID]
	local cfgMallData = self.goodDatum[luaIndex]

	if cell == nil then
		cell = MallCellOne.New(grid.gameObject)
		self.cellOnePool[insID] = cell
	end

	cell:Refresh(cfgMallData)
end

function MallView:OnSelectItemCellOne(grid)
	local luaIndex = grid.index + 1
	local cfgMallData = self.goodDatum[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.cellOnePool[insID]

	if cell.isSellOut or not cell.isConditionOk then
		NoticeModule.ShowNoticeNoCallback(21040055)

		return
	end

	UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
		mallCid = cfgMallData.Id
	})
end

function MallView:RefreshDatum()
	if self.customMallCids ~= nil then
		self.cfgMallDatum = {}

		for i, v in ipairs(self.customMallCids) do
			self.cfgMallDatum[#self.cfgMallDatum + 1] = CfgMallTable[v]
		end
	else
		self.cfgMallDatum = {}

		for i, v in pairsCfg(CfgMallTable) do
			local cfgMallTypeData = CfgMallTypeTable[v.MallType]

			if cfgMallTypeData.FunctionButton == self.entranceType then
				self.cfgMallDatum[#self.cfgMallDatum + 1] = v
			end
		end
	end

	local defaultTabTopType

	self.defaultTableLeftID = nil

	if userData ~= nil then
		defaultTabTopType = userData[1]
		self.defaultTableLeftID = userData[2]
	end

	self.tabTopDatum = {}

	local tempTypeDic = {}

	for i, v in pairsCfg(CfgMallTypeTable) do
		if v.FunctionButton == self.entranceType and tempTypeDic[v.Type] == nil and #self:GetTabLeftDatum(v.Type) ~= 0 then
			self.tabTopDatum[#self.tabTopDatum + 1] = v.Type
			tempTypeDic[v.Type] = v.Type
		end
	end

	table.sort(self.tabTopDatum, function(a, b)
		return a < b
	end)

	local type2IndexDic = {}

	for i, v in ipairs(self.tabTopDatum) do
		type2IndexDic[v] = i
	end

	if defaultTabTopType == nil then
		self.defaultTabTopIndex = 1
	else
		self.defaultTabTopIndex = type2IndexDic[defaultTabTopType]
	end
end

function MallView:RefreshTabTopBlock()
	self.tabTopList.defaultSelectedToggle = self.defaultTabTopIndex - 1

	self.tabTopList:Refresh(#self.tabTopDatum)
	self.tabTopList.gameObject:SetActive(#self.tabTopDatum ~= 1 or self.tabTopDatum[1] ~= 0)
end

function MallView:RefreshTabLeftBlock(type)
	self:StopLeftTabTimer()

	self.tabLeftDatum = self:GetTabLeftDatum(type)

	local defaultIndex = 1

	if self.defaultTableLeftID ~= nil then
		for i, v in ipairs(self.tabLeftDatum) do
			if v.Id == self.defaultTableLeftID then
				defaultIndex = i

				break
			end
		end
	end

	self.tabLeftList.defaultSelectedToggle = defaultIndex - 1

	self.tabLeftList:Refresh(#self.tabLeftDatum)
end

function MallView:RefreshContent(cfgMallType)
	self.curCfgMallType = cfgMallType

	local isShort = cfgMallType.ShowType == 1

	self.shortList.gameObject:SetActive(isShort)

	if isShort then
		self.shortList:Refresh(#self.goodDatum)
	end
end

function MallView:RefreshContentOnCurState()
	local isShort = self.curCfgMallType.ShowType == 1

	if isShort then
		if self.shortList.dataCount ~= #self.goodDatum then
			self.shortList:RenderCellsDynamic(#self.goodDatum)
		else
			self.shortList:RenderCells()
		end

		if #self.goodDatum == 0 then
			self:RefreshDatum()
			self:RefreshTabTopBlock()
		end
	end
end

function MallView:GetTabLeftDatum(mallType)
	local tabLeftDatum = {}

	for i, v in pairsCfg(CfgMallTypeTable) do
		if v.FunctionButton == self.entranceType and v.Type == mallType then
			local isValid = true

			if v.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
				if self:GetServerTime() < cfgDateTimeToTimeStamp(v.TimeLimitOpen, PlayerModule.TimeZone) or self:GetServerTime() > cfgDateTimeToTimeStamp(v.TimeLimitEnd, PlayerModule.TimeZone) then
					isValid = false
				else
					self:StartLeftTabTimer()
				end
			end

			if isValid and #self:GetTabLeftGoodsDatum(v) == 0 then
				isValid = false
			end

			if isValid then
				tabLeftDatum[#tabLeftDatum + 1] = v
			end
		end
	end

	table.sort(tabLeftDatum, function(a, b)
		return a.Tab < b.Tab
	end)

	return tabLeftDatum
end

function MallView:GetTabLeftGoodsDatum(cfgMallType)
	local goodDatum = {}
	local getMallGroup = {}

	for i, v in ipairs(self.cfgMallDatum) do
		if v.MallType == cfgMallType.Id then
			local isValid = true
			local realCfgData = v

			if cfgMallType.RefreshType > 0 and v.RandomGroup > 0 then
				local index = table.indexOf(getMallGroup, v.RandomGroup)

				if index == -1 then
					table.insert(getMallGroup, v.RandomGroup)

					local mallID = MallModule.GetGuildRandomMall(v.RandomGroup)

					if mallID then
						realCfgData = CfgMallTable[mallID]
					else
						isValid = false

						if GameEntry.Base.DevMode then
							log("公会商城随机商品组没有商品..RefreshType = " .. cfgMallType.RefreshType .. " 随机商品组 RandomGroup = " .. v.RandomGroup)
						end
					end
				else
					isValid = false
				end
			end

			if v.LimitType == Constant.Mall_LimitType.Life and MallModule.GetResidueBuyTimes(v.Id) == 0 then
				isValid = false
			end

			if isValid and v.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
				if cfgDateTimeToTimeStamp(v.TimeLimitOpen, PlayerModule.TimeZone) > self:GetServerTime() then
					isValid = false
				end

				if cfgDateTimeToTimeStamp(v.TimeLimitEnd, PlayerModule.TimeZone) < self:GetServerTime() then
					isValid = false
				end
			end

			if isValid and v.ShowConditionId ~= 0 and not ConditionModule.Check(v.ShowConditionId) then
				isValid = false
			end

			isValid = isValid and MallModule.CheckIsRightChannel(v)

			if isValid then
				goodDatum[#goodDatum + 1] = realCfgData
			end
		end
	end

	table.sort(goodDatum, function(a, b)
		return a.Sort < b.Sort
	end)

	return goodDatum
end

function MallView:GetServerTime()
	return math.floor(PlayerModule.GetServerTime())
end

function MallView:StartLeftTabTimer()
	self.needEnableLeftTabTimer = true
	self.leftTabTimer = 0
	self.resetTab = false
end

function MallView:StopLeftTabTimer()
	self.needEnableLeftTabTimer = false
	self.leftTabTimer = 0
end

return MallView
