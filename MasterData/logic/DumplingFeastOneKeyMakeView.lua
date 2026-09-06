-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastOneKeyMakeView.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastOneKeyMakeView", package.seeall)

local DumplingFeastOneKeyMakeView = class("DumplingFeastOneKeyMakeView", ViewComponent)

function DumplingFeastOneKeyMakeView:buildUI()
	DumplingFeastOneKeyMakeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnAdd = self:getGo("adjust/btnAdd")
	self._btnLess = self:getGo("adjust/btnLess")
	self._btnLessTen = self:getGo("adjust/btnLessTen")
	self._btnAddTen = self:getGo("adjust/btnAddTen")
	self._txtCount = self:getTxt("adjust/count/txt")
	self._txtTips = self:getTxt("txtTips")

	local itemScrView = self:getGo("itemCol/scrView")
	local itemScrCell = self:getGo("itemCol/scrCell")

	self._itemScrollerList = ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	self._itemScrollerList:setCenterMode(true)

	local txtCountTemp = self:getTxt("itemCol/scrCell/count/txt")

	self._strTxtCountTemp = txtCountTemp.text
end

function DumplingFeastOneKeyMakeView:bindEvents()
	DumplingFeastOneKeyMakeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnAdd, GameUtil.handler(self._updateSelectNum, self, 1), self)
	GameUtil.addClickHandler(self._btnLess, GameUtil.handler(self._updateSelectNum, self, -1), self)
	GameUtil.addClickHandler(self._btnLessTen, GameUtil.handler(self._updateSelectNum, self, -10), self)
	GameUtil.addClickHandler(self._btnAddTen, GameUtil.handler(self._updateSelectNum, self, 10), self)
end

function DumplingFeastOneKeyMakeView:unbindEvents()
	DumplingFeastOneKeyMakeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnLess)
	GameUtil.rmClickHandler(self._btnLessTen)
	GameUtil.rmClickHandler(self._btnAddTen)
end

function DumplingFeastOneKeyMakeView:onEnter()
	DumplingFeastOneKeyMakeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = DumplingFeastController.instance:getSubMo(self._activityId)
	self._dumplingSelectNumMap = self._dumplingSelectNumMap or {}
	self._curSelectDumplingId = self._curSelectDumplingId or 0

	if self._curSelectDumplingId <= 0 then
		local dumplingDatas = DumplingFeastConfig.instance:getDumplingDatas(self._activityId)

		if dumplingDatas and #dumplingDatas > 0 then
			self._curSelectDumplingId = dumplingDatas[1].dumplingId
		end
	end

	local goldMats = {}
	local doughMatMo = self._subMo:getRollDoughNeedItemMatMo()
	local matType, matId = doughMatMo.matType, doughMatMo.matId

	goldMats[matType .. ":" .. matId] = true

	local list = {}

	for matStr, bool in pairs(goldMats) do
		local tab = {
			showAdd = true,
			id = matStr
		}

		table.insert(list, tab)
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastOneClickMakeDumplingRes, self._handlePM_DumplingFeastOneClickMakeDumplingRes, self)
	self:_onUpdate()
end

function DumplingFeastOneKeyMakeView:onExit()
	DumplingFeastOneKeyMakeView.super.onExit(self)
	self._itemScrollerList:dispose()
end

function DumplingFeastOneKeyMakeView:_handlePM_DumplingFeastOneClickMakeDumplingRes(msg)
	local dumplingId = msg.dumplingIdToQuality.left
	local quality = msg.dumplingIdToQuality.right
	local num = msg.num
	local dumplingData = DumplingFeastConfig.instance:getDumplingData(self._activityId, dumplingId)
	local qualityData = DumplingFeastConfig.instance:getQualityData(self._activityId, quality)

	FloatWordMgr.instance:show(string.format("获得%s汤圆[%s品质]×%s", dumplingData.name, qualityData.name, num))

	self._dumplingSelectNumMap[dumplingId] = nil

	self:_onUpdate()
end

function DumplingFeastOneKeyMakeView:_onUpdate()
	local dumplingDatas = DumplingFeastConfig.instance:getDumplingDatas(self._activityId)

	self._maxQuality = DumplingFeastConfig.instance:getMaxQuality(self._activityId)

	self._itemScrollerList:reloadData(dumplingDatas)
	self:_onUpdateAdjustUI()
end

function DumplingFeastOneKeyMakeView:_updateItemCell(view, cell, data, tag)
	local index = cell.data
	local dumplingId = data.dumplingId
	local num = self._subMo:getStuffFillingNeedItemHaveNum(dumplingId)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local tagSelected = goutil.findChild(mainGo, "tagSelected")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local txtCount = goutil.findChildTextComponent(mainGo, "count/txt")

	MaterialMgr.setCellByCfg(data.stuffFillingNeedItem, item)
	GameUtil.SetActive(tagSelected, dumplingId == self._curSelectDumplingId)

	txtCount.text = string.format(self._strTxtCountTemp, num)

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickItemCell, self, index, dumplingId), self)
	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickItemCell, self, index, dumplingId), self)
end

function DumplingFeastOneKeyMakeView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	GameUtil.rmClickHandler(mainGo)
	MaterialMgr.resetAll(item)
end

function DumplingFeastOneKeyMakeView:_onClickItemCell(index, dumplingId)
	if self._curSelectDumplingId == dumplingId then
		return
	end

	local lastSelectDumplingId = self._curSelectDumplingId

	self._curSelectDumplingId = dumplingId

	local list = self._itemScrollerList:getData()

	if list then
		for i, v in ipairs(list) do
			if v.dumplingId == lastSelectDumplingId then
				self._itemScrollerList:updateCellInViewByIndex(i - 1)

				break
			end
		end
	end

	self:_onUpdateAdjustUI()
	self._itemScrollerList:updateCellInViewByIndex(index - 1)
end

function DumplingFeastOneKeyMakeView:_updateSelectNum(delta)
	if self._curSelectDumplingId <= 0 then
		return
	end

	if not self._dumplingSelectNumMap[self._curSelectDumplingId] then
		local count = 0
		local needPerOne = self._subMo:getStuffFillingNeedItemNum(self._curSelectDumplingId)
		local haveTotal = self._subMo:getStuffFillingNeedItemHaveNum(self._curSelectDumplingId)
		local maxCount = needPerOne > 0 and math.floor(haveTotal / needPerOne) or 0
		local newCount = Mathf.Clamp(count + delta, 0, maxCount)

		if newCount ~= count then
			self._dumplingSelectNumMap[self._curSelectDumplingId] = newCount

			self:_onUpdateAdjustUI()
		end
	end
end

function DumplingFeastOneKeyMakeView:_getTryMakeResultAndTips(isShowTips, dumplingId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self._dumplingSelectNumMap[dumplingId] then
		local count = 0

		if result == GameEnum.ResultCode.Success then
			local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

			if not isInTime then
				result = GameEnum.ResultCode.Error
				tips = "不在活动时间范围内"
			end
		end

		if result == GameEnum.ResultCode.Success then
			local isCanOpenOneClickMake = self._subMo:isCanOpenOneClickMake()

			if not isCanOpenOneClickMake then
				result = GameEnum.ResultCode.Error
				tips = "需要达到最优品质汤圆次数才能一键制作"
			end
		end

		if result == GameEnum.ResultCode.Success and (dumplingId <= 0 or count <= 0) then
			result = GameEnum.ResultCode.Error
			tips = "请选择要制作的汤圆数量"
		end

		local doughMatMo = self._subMo:getRollDoughNeedItemMatMo()
		local withNum = MaterialModel.instance:getMaterialsNumber(doughMatMo.matType, doughMatMo.matId)

		if withNum < doughMatMo.matNum then
			result = GameEnum.ResultCode.Error
			tips = string.format("%s不足，先去购买再进行制作吧", doughMatMo.matName)
		end

		if result == GameEnum.ResultCode.Success then
			local needPerOne = self._subMo:getStuffFillingNeedItemNum(dumplingId)
			local haveTotal = self._subMo:getStuffFillingNeedItemHaveNum(dumplingId)
			local needTotal = needPerOne * count

			if haveTotal < needTotal then
				result = GameEnum.ResultCode.Error

				local matMo = self._subMo:getStuffFillingMatMo(dumplingId)

				tips = string.format("%s不足", matMo.matName)
			end
		end

		if isShowTips then
			FloatWordMgr.instance:show(tips)
		end

		return result
	end
end

function DumplingFeastOneKeyMakeView:_onUpdateAdjustUI()
	if not self._dumplingSelectNumMap[self._curSelectDumplingId] then
		local count = 0
		local needPerOne = self._subMo:getStuffFillingNeedItemNum(self._curSelectDumplingId)
		local haveTotal = self._subMo:getStuffFillingNeedItemHaveNum(self._curSelectDumplingId)
		local maxCount = needPerOne > 0 and math.floor(haveTotal / needPerOne) or 0

		self._txtCount.text = string.format("%s/%s", count, maxCount)

		local result = self:_getTryMakeResultAndTips(false, self._curSelectDumplingId)

		GameUtil.SetGray(self._btnSure, result ~= GameEnum.ResultCode.Success)
	end
end

function DumplingFeastOneKeyMakeView:_onClickBtnSure()
	local result = self:_getTryMakeResultAndTips(true, self._curSelectDumplingId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if not self._dumplingSelectNumMap[self._curSelectDumplingId] then
		local count = 0

		DumplingFeastController.instance:sendPM_DumplingFeastOneClickMakeDumplingReq(self._activityId, count, self._curSelectDumplingId)
	end
end

return DumplingFeastOneKeyMakeView
