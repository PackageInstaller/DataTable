-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/versiongift/VersionGiftView.lua

module("logic.extensions.bonus.view.versiongift.VersionGiftView", package.seeall)

local VersionGiftView = class("VersionGiftView", ViewComponent)

function VersionGiftView:ctor()
	VersionGiftView.super.ctor(self)

	self._curCellData = nil
	self._curBtnData = nil
end

function VersionGiftView:onExit()
	VersionGiftView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(ClockMgr.TickDailyRefresh, self._updateAllBtnItemShow, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._updateAllBtnItemShow, self)
	GlobalDispatcher:removeListener(PayShopController.GetAllPayShopBuyTimesRes, self._updateAllBtnItemShow, self)

	self._curCellData = nil
	self._curBtnData = nil
end

function VersionGiftView:destroyUI()
	VersionGiftView.super.destroyUI(self)
end

function VersionGiftView:buildUI()
	VersionGiftView.super.buildUI(self)

	self._timeTxt = self:getTxt("timeGo/timeTxt")
	self._cellListSR = self:getGo("cellListSR"):GetComponent("UITableview")
	self._cellItem = self:getGo("cellItem")
	self._btnListSR = self:getGo("btnListSR"):GetComponent("UITableview")
	self._btnItem = self:getGo("btnItem")
	self._goldBarCon = self:getGo("goldBarCon")
	self._timeTxt.text = ""

	GameUtil.SetActive(self._cellItem, false)
	GameUtil.SetActive(self._btnItem, false)
	self._cellListSR:RegisterCallback(self._CellInView, function()
		return 186, 236
	end, self._CellAtIndex, self)
	self._cellListSR:RegisterUpdateCellCallback(self._OnCellItemUpdate)
	self._btnListSR:RegisterCallback(self._BtnInView, function()
		return 138, 40
	end, self._BtnAtIndex, self)
	self._btnListSR:RegisterUpdateCellCallback(self._OnBtnItemUpdate)
end

function VersionGiftView:_CellInView()
	if not self._curCellData then
		return 0
	end

	return #self._curCellData
end

function VersionGiftView:_CellAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._cellItem)

	local data = self._curCellData[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateCellItem(view, cell, data)

	return cell
end

function VersionGiftView:_OnCellItemUpdate(view, cell)
	local index = cell.index
	local data = self._curCellData[index + 1]

	cell.data = index + 1

	self:_UpdateCellItem(view, cell, data)
end

function VersionGiftView:_BtnInView()
	if not self._curBtnData then
		return 0
	end

	return #self._curBtnData
end

function VersionGiftView:_BtnAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._btnItem)

	local data = self._curBtnData[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateBtnItem(view, cell, data)

	return cell
end

function VersionGiftView:_OnBtnItemUpdate(view, cell)
	local index = cell.index
	local data = self._curBtnData[index + 1]

	cell.data = index + 1

	self:_UpdateBtnItem(view, cell, data)
end

function VersionGiftView:onEnter()
	VersionGiftView.super.onEnter(self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateAllBtnItemShow, self)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._updateAllBtnItemShow, self)
	GlobalDispatcher:addListener(PayShopController.GetAllPayShopBuyTimesRes, self._updateAllBtnItemShow, self)

	self._chosIndex = 1

	local value = GameUtil.getUserData("VersionGiftView_OpenTab_" .. LoginModel.instance.userId)

	if checknumber(value) > 0 then
		self._chosIndex = value
	end

	if checknumber(self:getFirstParam()) > 0 then
		self._chosIndex = self:getFirstParam()
	end

	self._curBtnData = VersionGiftConfig.instance:getShowVersionGiftTables()

	if self._curBtnData == nil or #self._curBtnData == 0 then
		printError("sr---本版礼包    VersionGiftView:onEnter()     请检查配置！！")

		return
	end

	local isOpen = false

	for i = 1, #self._curBtnData do
		if self._curBtnData[i].tabId == self._chosIndex and GameUtil.checkIsInTimePeriod(self._curBtnData[i].startTime, self._curBtnData[i].endTime) then
			isOpen = true

			break
		end
	end

	if not isOpen then
		for i = 1, #self._curBtnData do
			if GameUtil.checkIsInTimePeriod(self._curBtnData[i].startTime, self._curBtnData[i].endTime) then
				self._chosIndex = self._curBtnData[i].tabId

				break
			end
		end
	end

	local btnList = {
		{
			id = "204:2"
		},
		{
			id = "8:17"
		},
		{
			id = "8:26"
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
	self:_updateAllBtnItemShow()
end

function VersionGiftView:_updateAllBtnItemShow()
	if self._btnListSR == nil then
		return
	end

	self:_onClickBtnItem(self._chosIndex, true)
end

function VersionGiftView:_onClickBtnItem(index, isForce)
	if index == self._chosIndex and not isForce then
		return
	end

	self._chosIndex = index

	self._btnListSR:ReloadData()

	local cfg = VersionGiftConfig.instance:getVersionGiftTable(self._chosIndex)

	self._curCellData = VersionGiftConfig.instance:getShowVersionGiftShopCfgs((cfg or nil) and (cfg.planId or 1))

	if self._curCellData == nil or #self._curCellData == 0 then
		printError("sr---本版礼包      VersionGiftView:_onClickBtnItem()  请检查配置！！")

		return
	end

	self._cellListSR:ReloadData()
	GameUtil.saveUserData("VersionGiftView_OpenTab_" .. LoginModel.instance.userId, self._chosIndex)
	removetimer(self._calculationSurplusTime, self)

	self._endTime = 0

	if cfg and not string.nilorempty(cfg.endTime) then
		self._endTime = GameUtil.string2time(cfg.endTime)
	end

	if self._endTime <= 0 or self._endTime <= ServerTime.now() then
		self._timeTxt.text = "活动结束"

		return
	end

	if self._endTime > ServerTime.now() then
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function VersionGiftView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timeTxt.text = "活动结束"

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timeTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function VersionGiftView:_UpdateCellItem(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, VersionGiftGoodsItem)

	component:onEnter(self, self._cellListSR, data, true)
end

function VersionGiftView:_UpdateBtnItem(view, cell, data)
	local itemChg = cell:GetComponent("UIImageSpriteChange")
	local itemTxt = goutil.findChildTextComponent(cell, "btnTxt")
	local itemTxtChg = goutil.findChild(cell, "btnTxt"):GetComponent("UITextColorChange")
	local tagGo = goutil.findChild(cell, "tagGo")
	local tagTxt = goutil.findChildTextComponent(tagGo, "tagTxt")
	local btnRedGo = goutil.findChild(cell, "btnRedGo")
	local lockGo = goutil.findChild(cell, "lockGo")

	GameUtil.asBtn(cell):RemoveClickListener()

	if data.tabId == self._chosIndex then
		itemChg:SetState(1)
		itemTxtChg:SetState(1)
	else
		itemChg:SetState(0)
		itemTxtChg:SetState(0)
	end

	local value = GameUtil.getTimePeriodType(data.startTime, data.endTime)
	local isRed = false
	local isPeriod = false

	itemTxt.text = data.tabTxt

	if value == GameUtil.beforeTimePeriod then
		GameUtil.SetActive(lockGo, true)
		uGuiUtil.setImageGrayState(cell, false)
		uGuiUtil.setTextGrayState(itemTxt.gameObject, false)
	elseif value == GameUtil.inTimePeriod then
		GameUtil.SetActive(lockGo, false)
		uGuiUtil.setImageGrayState(cell, false)
		uGuiUtil.setTextGrayState(itemTxt.gameObject, false)

		isRed = BonusController.instance:getVersionGiftRedByTableId(data.tabId)
		isPeriod = true
	elseif value == GameUtil.afterTimePeriod then
		GameUtil.SetActive(lockGo, false)
		uGuiUtil.setImageGrayState(cell, true)
		uGuiUtil.setTextGrayState(itemTxt.gameObject, true)
	end

	GameUtil.SetActive(btnRedGo, isRed)

	if string.nilorempty(data.tagTxt) then
		tagTxt.text = ""

		GameUtil.SetActive(tagGo, false)
	else
		GameUtil.SetActive(tagGo, true)

		tagTxt.text = data.tagTxt
	end

	GameUtil.asBtn(cell):AddClickListener(function()
		if not isPeriod then
			FloatWordMgr.instance:show(data.lockTips)

			return
		end

		self:_onClickBtnItem(data.tabId)
	end)
end

return VersionGiftView
