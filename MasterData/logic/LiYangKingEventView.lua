-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingEventView.lua

module("logic.extensions.liyangking.view.LiYangKingEventView", package.seeall)

local LiYangKingEventView = class("LiYangKingEventView", ViewComponent)

function LiYangKingEventView:ctor()
	LiYangKingEventView.super.ctor(self)
end

function LiYangKingEventView:unbindEvents()
	LiYangKingEventView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPre)
	GameUtil.rmClickHandler(self._btnAfter)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnResultSure)
end

function LiYangKingEventView:bindEvents()
	LiYangKingEventView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPre, self._onClickBtnPre, self)
	GameUtil.addClickHandler(self._btnAfter, self._onClickBtnAfter, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnResultSure, self._onClickBtnResultSure, self)
end

function LiYangKingEventView:buildUI()
	LiYangKingEventView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtDescript = self:getTxt("select/txtDescript")
	self._btnSure = self:getGo("select/btnSure")
	self._btnResultSure = self:getGo("result/btnResultSure")
	self._txtResultDescript = self:getTxt("result/txtDescript")
	self._btnAfter = self:getGo("select/btnAfter")
	self._btnPre = self:getGo("select/btnPre")
	self._result = self:getGo("result")
	self._select = self:getGo("select")
	self._txtNeed = self:getTxt("cost/txtNeed")
	self._txtHas = self:getTxt("cost/txtHas")
	self._cost = self:getGo("cost")
	self._imgCostNeed = self:getGo("cost/imgCostNeed")
	self._imgCostHas = self:getGo("cost/imgCostHas")
	self._txtTitle = self:getTxt("txtTitle")
	self._tableviewSelect = self:getGo("select/tableviewSelect")
	self._tablecell = self:getGo("select/tableviewSelect/tablecell")
	self._scrollList = ScrollerList.create(self._tableviewSelect, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableviewResult = self:getGo("result/tableview")
	self._tablecellResult = self:getGo("result/tableview/tablecell")
	self._scrollListResult = ScrollerList.create(self._tableviewResult, self._tablecellResult, GameUtil.handler(self._updateResultCell, self), GameUtil.handler(self._clearResultCell, self))
end

function LiYangKingEventView:onExit()
	LiYangKingEventView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgCostNeed)
	MaterialMgr.clearIcon(self._imgCostHas)
	self._scrollList:dispose()
	self._scrollListResult:dispose()
end

function LiYangKingEventView:onEnter()
	LiYangKingEventView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangHandleEventRes, self._onHandleEventRes, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyPrinceLiyangChangeRes, self._onAttrChangeRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 509001
	end

	self._buildId = checknumber(params[2])
	self._actCfg = LiYangKingConfig.instance:getActCfg(self._activityId)
	self._info = LiYangKingModel.instance:getInfo(self._activityId)
	self._attributesMap = self._info.attributesMap
	self._eventConfigMap = LiYangKingConfig.instance:getEventIdMap(self._activityId)
	self._attrConfigMap = LiYangKingConfig.instance:getAttrMap(self._activityId)
	self._eventIdConfigList = self._eventConfigMap[self._buildId]
	self._curEventIdQueue = self:_getCurEventIdQueue()
	self._curEventIdIndex = 1
	self._curEventId = self._curEventIdQueue[self._curEventIdIndex]
	self._isDealingEvent = true
	self._curSelectOptionIdx = 0

	self:_onSetUI()
	self:_onUpdate()
end

function LiYangKingEventView:_onSetUI()
	MaterialMgr.setIcon(self._imgCostHas, MatType.ACTIVITY_ITEM, self._actCfg.itemId, nil, nil)
	MaterialMgr.setIcon(self._imgCostNeed, MatType.ACTIVITY_ITEM, self._actCfg.itemId, nil, nil)
end

function LiYangKingEventView:_updateCell(view, cell, data)
	local imgGouXuan = goutil.findChild(cell, "btnSelect/imgGouXuan")
	local imgSelect = goutil.findChild(cell, "btnSelect/imgSelect")
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local txtSelect = goutil.findChildTextComponent(cell, "btnSelect/txtSelect")

	txtSelect.text = data.content

	GameUtil.addClickHandler(btnSelect, function()
		self._curSelectOptionIdx = data.optionId

		self:_onUpdate()
	end, self)
	GameUtil.SetActive(imgGouXuan, self._curSelectOptionIdx == data.optionId)
	GameUtil.SetActive(imgSelect, self._curSelectOptionIdx == data.optionId)
end

function LiYangKingEventView:_clearCell(cell)
	local btnSelect = goutil.findChild(cell, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

function LiYangKingEventView:_updateResultCell(view, cell, data)
	local imgLevelUp = goutil.findChild(cell, "imgLevelUp")
	local imgHead = goutil.findChild(cell, "imgHead")
	local levelGo = goutil.findChild(cell, "level")
	local sliderPre = goutil.findChild(cell, "sliderPre"):GetComponent("Slider")
	local sliderAfter = goutil.findChild(cell, "sliderAfter"):GetComponent("Slider")
	local txtProgress = goutil.findChildTextComponent(cell, "txtProgress")
	local txtUp = goutil.findChildTextComponent(cell, "txtUp")
	local txtLevel = goutil.findChildTextComponent(cell, "level/txtLevel")
	local attrCfg = self._attrConfigMap[data.left]
	local attrId = attrCfg.id
	local preAttrInfo = self._attributesMap[attrId]
	local curProgress = preAttrInfo.progress
	local addNum = data.right
	local curHasProgressPre, needProgressPre = LiYangKingController.instance:getCurAttrLevelProgressAndNeed(self._activityId, attrId, curProgress - addNum)
	local curHasProgressAfter, needProgressAfter = LiYangKingController.instance:getCurAttrLevelProgressAndNeed(self._activityId, attrId, curProgress)
	local level = LiYangKingController.instance:getCurLevel(self._activityId, attrId, curProgress)
	local preLevel = LiYangKingController.instance:getCurLevel(self._activityId, attrId, curProgress - addNum)
	local isLevelUp = checknumber(level) > checknumber(preLevel)
	local attrName = attrCfg.attrName

	txtUp.text = string.format("+%d", addNum)
	txtProgress.text = curHasProgressAfter == -1 and needProgressAfter == -1 and "已满级" or string.format("%d/%d", curHasProgressAfter, needProgressAfter)
	txtLevel.text = string.format("%s等级:%d", attrName, level)
	sliderPre.value = curHasProgressPre / needProgressPre
	sliderAfter.value = curHasProgressAfter / needProgressAfter

	GameUtil.SetActive(imgLevelUp, isLevelUp)
	MaterialMgr.setIcon(imgHead, MatType.ACTIVITY_ITEM, attrCfg.itemId)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(levelGo.transform)
end

function LiYangKingEventView:_clearResultCell(cell)
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local imgHead = goutil.findChild(cell, "imgHead")

	MaterialMgr.clearIcon(imgHead)
	GameUtil.rmClickHandler(btnSelect)
end

function LiYangKingEventView:_getCurEventIdQueue()
	local curHasEventIds = {}
	local eventIds = self._info.eventIds

	for i, eventId in ipairs(self._eventIdConfigList) do
		if table.indexof(eventIds, eventId) then
			table.insert(curHasEventIds, eventId)
		end
	end

	return curHasEventIds
end

function LiYangKingEventView:_onUpdate()
	self._info = LiYangKingModel.instance:getInfo(self._activityId)
	self._attributesMap = self._info.attributesMap

	local curEventId = self._curEventIdQueue[self._curEventIdIndex]

	self._optionCfgs = LiYangKingConfig.instance:getBuildingEventOptionCfgByEventId(self._activityId, self._curEventId)

	local preOptionCfgs = LiYangKingConfig.instance:getBuildingEventOptionCfgByEventId(self._activityId, self._preEventId)

	if self._optionCfgs then
		if not self._optionCfgs[self._curSelectOptionIdx] then
			local curOptionCfg = {}

			if preOptionCfgs then
				if not preOptionCfgs[self._preSelectOptionIdx] then
					local preOptionCfg = {}
					local cost = checknumber(curOptionCfg.cost)

					if curEventId then
						local eventCfg = LiYangKingConfig.instance:getBuildingEventCfgByEventId(self._activityId, curEventId)

						self._txtDescript.text = eventCfg.content

						self._scrollList:reloadData(self._optionCfgs)
					end

					self._txtNeed.text = cost
					self._txtHas.text = self._info.curScore

					local curTitleStr = "处理结果"

					if self._isDealingEvent then
						curTitleStr = "政务处理"
					else
						self._txtResultDescript.text = preOptionCfg.resultContent
					end

					self._txtTitle.text = curTitleStr

					GameUtil.SetActive(self._btnPre, self._curEventIdIndex > 1)
					GameUtil.SetActive(self._btnAfter, self._curEventIdIndex < #self._curEventIdQueue)
					GameUtil.SetActive(self._select, self._isDealingEvent)
					GameUtil.SetActive(self._cost, self._isDealingEvent)
					GameUtil.SetActive(self._result, not self._isDealingEvent)
				end
			end
		end
	end
end

function LiYangKingEventView:_onHandleEventRes(activityId, eventId, optionId)
	self._isDealingEvent = false
	self._curEventIdIndex = 1
	self._info = LiYangKingModel.instance:getInfo(activityId)
	self._curEventIdQueue = self:_getCurEventIdQueue()
	self._curEventId = self._curEventIdQueue[self._curEventIdIndex]
	self._curSelectOptionIdx = 0
	self._preEventId = eventId
	self._preSelectOptionIdx = optionId

	self:_onUpdate()

	local nextCreateEventTimeMillis = self._info.nextCreateEventTimeMillis

	if nextCreateEventTimeMillis == -1 then
		LiYangKingController.instance:sendPM_PrinceLiyangInfoReq(self._activityId)
	end
end

function LiYangKingEventView:_onAttrChangeRes(msg)
	if not msg.addValues then
		self._scrollListResult:reloadData(msg.addValues)
		self:_onUpdate()
	end
end

function LiYangKingEventView:_onClickBtnPre()
	self._curEventIdIndex = math.max(self._curEventIdIndex - 1, 1)
	self._curEventId = self._curEventIdQueue[self._curEventIdIndex]
	self._curSelectOptionIdx = 0

	self:_onUpdate()
end

function LiYangKingEventView:_onClickBtnAfter()
	local curEventNum = #self._curEventIdQueue

	self._curEventIdIndex = math.min(self._curEventIdIndex + 1, curEventNum)
	self._curEventId = self._curEventIdQueue[self._curEventIdIndex]
	self._curSelectOptionIdx = 0

	self:_onUpdate()
end

function LiYangKingEventView:_onClickBtnSure()
	if self._curSelectOptionIdx == 0 then
		FloatWordMgr.instance:show("尚未选择选项")

		return
	end

	local curEventOptionCfg = self._optionCfgs[self._curSelectOptionIdx]
	local cost = curEventOptionCfg.cost
	local curScore = checknumber(self._info.curScore)

	if curScore < cost then
		FloatWordMgr.instance:show("代币不足，无法选择此选项")

		return
	end

	LiYangKingController.instance:sendPM_PrinceLiyangHandleEventReq(self._activityId, self._curEventId, self._curSelectOptionIdx)
end

function LiYangKingEventView:_onClickBtnResultSure()
	if #self._curEventIdQueue == 0 then
		self:close()
	end

	self._isDealingEvent = true

	self:_onUpdate()
end

return LiYangKingEventView
