-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleCardPoolView.lua

module("logic.extensions.freescuffle.view.FreeScuffleCardPoolView", package.seeall)

local FreeScuffleCardPoolView = class("FreeScuffleCardPoolView", ViewComponent)
local Tag_WorkPet = 1
local Tag_BattlePet = 2
local Tag_Skill = 3
local ScrCellTags = {
	[FreeScuffleEnum.PoolTypes_WorkPet] = Tag_WorkPet,
	[FreeScuffleEnum.PoolTypes_BattlePet] = Tag_BattlePet,
	[FreeScuffleEnum.PoolTypes_Skill] = Tag_Skill
}

FreeScuffleCardPoolView.DefaultPoolType = nil

function FreeScuffleCardPoolView:buildUI()
	FreeScuffleCardPoolView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._goldBarCon = self:getGo("goldBarCon")

	local tabScrView = self:getGo("tabCol/scrView")
	local tabScrCell = self:getGo("tabCol/scrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	local poolScrView = self:getGo("poolCol/scrView")
	local workScrCell = self:getGo("poolCol/workScrCell")
	local battleScrCell = self:getGo("poolCol/battleScrCell")
	local skillScrCell = self:getGo("poolCol/skillScrCell")
	local scrCellList = {
		workScrCell,
		battleScrCell,
		skillScrCell
	}

	self._sizeList = {}

	for tag, go in ipairs(scrCellList) do
		local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._poolScrollerList = ScrollerList.create(poolScrView, scrCellList, GameUtil.handler(self._updatePoolCell, self), GameUtil.handler(self._clearPoolCell, self))

	self._poolScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._poolScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
	self._poolScrollerList:setCenterMode(true)

	self._btnDrawOnce = self:getGo("btnDrawOnce/btn")
	self._txtDescBtnDrawOnce = self:getTxt("btnDrawOnce/desc/txt")
	self._iconDescBtnDrawOnce = self:getGo("btnDrawOnce/desc/icon")
	self._btnDrawTen = self:getGo("btnDrawTen/btn")
	self._txtDescBtnDrawTen = self:getTxt("btnDrawTen/desc/txt")
	self._iconDescBtnDrawTen = self:getGo("btnDrawTen/desc/icon")
end

function FreeScuffleCardPoolView:bindEvents()
	FreeScuffleCardPoolView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnDrawOnce, GameUtil.handler(self._drawCard, self, 1))
	GameUtil.addClickHandler(self._btnDrawTen, GameUtil.handler(self._drawCard, self, 10))
end

function FreeScuffleCardPoolView:unbindEvents()
	FreeScuffleCardPoolView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnDrawOnce)
	GameUtil.rmClickHandler(self._btnDrawTen)
end

function FreeScuffleCardPoolView:onEnter()
	FreeScuffleCardPoolView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, true)
	FreeScuffleController.instance:enterWorkScene(self._activityId, true)

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)
	self._actData = FreeScuffleConfig.instance:getActData(self._activityId)

	if FreeScuffleCardPoolView.DefaultPoolType then
		for poolTab, poolTypes in pairs(FreeScuffleEnum.PoolTypeInTabs) do
			for _, poolType in pairs(poolTypes) do
				if poolType == FreeScuffleCardPoolView.DefaultPoolType then
					self._curPoolTab = poolTab
					self._curPoolType = FreeScuffleCardPoolView.DefaultPoolType
				end
			end
		end

		FreeScuffleCardPoolView.DefaultPoolType = nil
	end

	if self._curPoolTab == nil then
		self._curPoolTab = self._curPoolTab or FreeScuffleEnum.PoolTabs[1]
	end

	if self._curPoolType == nil then
		if self._curPoolTab then
			do
				local list = FreeScuffleEnum.PoolTypeInTabs[self._curPoolTab]

				self._curPoolType = list and list[1]
			end

			local costItem = self._subMo:getLotteryCostItem()

			MaterialMgr.setIcon(self._iconDescBtnDrawOnce, costItem.matType, costItem.matId, nil, nil)
			MaterialMgr.setIcon(self._iconDescBtnDrawTen, costItem.matType, costItem.matId, nil, nil)

			self._txtDescBtnDrawOnce.text = costItem.matNum
			self._txtDescBtnDrawTen.text = costItem.matNum * 10

			local list = {}
			local tab = {
				id = costItem.matStr
			}

			table.insert(list, tab)
			MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
			self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleGetInfoRes, self._onUpdate, self)
			self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleLotteryRes, self._handlePM_FreeScuffleLotteryRes, self)
			self:_onUpdate()
		end
	end
end

function FreeScuffleCardPoolView:onExit()
	FreeScuffleCardPoolView.super.onExit(self)
	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, false)
	FreeScuffleController.instance:enterWorkScene(self._activityId, false)
	self._tabScrollerList:dispose()
	self._poolScrollerList:dispose()
	MaterialMgr.clearIcon(self._iconDescBtnDrawOnce)
	MaterialMgr.clearIcon(self._iconDescBtnDrawTen)
end

function FreeScuffleCardPoolView:_handlePM_FreeScuffleLotteryRes(msg)
	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	UIStateManager.instance:push(ViewName.FreeScuffleCardResultView, msg)
end

function FreeScuffleCardPoolView:_onUpdate()
	self._tabScrollerList:reloadData(FreeScuffleEnum.PoolTabs)

	if self._curPoolTab then
		if not FreeScuffleEnum.PoolTypeInTabs[self._curPoolTab] then
			local poolTypeList = {}

			self._poolScrollerList:reloadData(poolTypeList)

			local onceResult = self._subMo:getTryLotteryResultAndTips(false, self._curPoolType, 1)
			local tenResult = self._subMo:getTryLotteryResultAndTips(false, self._curPoolType, 10)

			GameUtil.SetGray(self._btnDrawOnce, onceResult ~= GameEnum.ResultCode.Success)
			GameUtil.SetGray(self._btnDrawTen, tenResult ~= GameEnum.ResultCode.Success)
		end
	end
end

function FreeScuffleCardPoolView:_updateTabCell(view, cell, poolTab, tag)
	local mainGo = cell.gameObject
	local btn = goutil.findChild(mainGo, "btn")
	local txtName = goutil.findChildTextComponent(mainGo, "btn/txtName")
	local red = goutil.findChild(mainGo, "btn/red")

	txtName.text = FreeScuffleEnum.PoolTabNames[poolTab]

	GameUtil.setUIGroupIdx(mainGo, self._curPoolTab == poolTab and 1 or 0)
	btn:GetComponent(goutil.Type_UIImage):SetNativeSize()
	GameUtil.addClickHandler(btn, function()
		self._curPoolTab = poolTab

		if self._curPoolTab then
			self._curPoolType = self._curPoolTab and self._curPoolTab[1]

			self:_onUpdate()
		end
	end)
end

function FreeScuffleCardPoolView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local btn = goutil.findChild(mainGo, "btn")

	GameUtil.rmClickHandler(btn)
end

function FreeScuffleCardPoolView:_updatePoolCell(view, cell, poolType, tag)
	local mainGo = cell.gameObject
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = FreeScuffleEnum.PoolTypeNames[poolType]

	GameUtil.SetActive(tagSelect, self._curPoolType == poolType)
	GameUtil.addClickHandler(mainGo, function()
		self._curPoolType = poolType

		self:_onUpdate()
	end)
end

function FreeScuffleCardPoolView:_clearPoolCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function FreeScuffleCardPoolView:_getTagByIdx(data, idx)
	return ScrCellTags[data]
end

function FreeScuffleCardPoolView:_getCellSize(view, idx)
	local list = self._unitScrollerList:getData()
	local data = list[idx + 1]
	local tag = self:_getTagByIdx(data, idx)

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

function FreeScuffleCardPoolView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function FreeScuffleCardPoolView:_drawCard(lotteryTimes)
	local result = self._subMo:getTryLotteryResultAndTips(true, self._curPoolType, lotteryTimes)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	FreeScuffleController.instance:sendPM_FreeScuffleLotteryReq(self._activityId, lotteryTimes, self._curPoolType)
end

return FreeScuffleCardPoolView
