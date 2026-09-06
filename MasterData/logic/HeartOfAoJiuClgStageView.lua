-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/view/HeartOfAoJiuClgStageView.lua

module("logic.extensions.heartofaojiuclg.view.HeartOfAoJiuClgStageView", package.seeall)

local HeartOfAoJiuClgStageView = class("HeartOfAoJiuClgStageView", ViewComponent)

function HeartOfAoJiuClgStageView:buildUI()
	HeartOfAoJiuClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnReset = self:getGo("btnReset")

	local stageScrView = self:getGo("stageCol/scrView")
	local stageScrCell = self:getGo("stageCol/scrCell")

	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._txtMaxScore = self:getTxt("txtMaxScore")
	self._itemPrize = self:getGo("info/prize/item")
	self._tagHasGain = self:getGo("info/prize/tagHasGain")

	local prizeScrView = self:getGo("info/prize/scrView")
	local prizeScrCell = self:getGo("info/prize/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function HeartOfAoJiuClgStageView:bindEvents()
	HeartOfAoJiuClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function HeartOfAoJiuClgStageView:unbindEvents()
	HeartOfAoJiuClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
end

function HeartOfAoJiuClgStageView:onEnter()
	HeartOfAoJiuClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = HeartOfAoJiuClgController.instance:getSubMo(self._activityId)
	self._actData = HeartOfAoJiuClgConfig.instance:getActivityData(self._activityId)
	self._curStageId = self._curStageId or 0

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_HeartOfAoJiuClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HeartOfAoJiuClgResetRes, self._handlePM_HeartOfAoJiuClgResetRes, self)

	if not self._subMo:isInOpenTime() then
		self:close()

		local tipsContent = string.format("挑战关闭时间：%s", self._actData.challengeClosedTimeRange)
		local okFunc
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", tipsContent, okFunc, "确定", alignment)

		return
	end

	self:_sendGetInfoReq()
end

function HeartOfAoJiuClgStageView:onExit()
	HeartOfAoJiuClgStageView.super.onExit(self)
	self:_onClearStageCol()
	self:_onClearPrizeCol()
end

function HeartOfAoJiuClgStageView:_sendGetInfoReq()
	HeartOfAoJiuClgController.instance:sendPM_HeartOfAoJiuClgGetInfoReq(self._activityId)
end

function HeartOfAoJiuClgStageView:_handlePM_HeartOfAoJiuClgResetRes()
	self:_sendGetInfoReq()
end

function HeartOfAoJiuClgStageView:_onUpdate()
	local passCount = self._subMo:getPassStageCount()

	GameUtil.SetGray(self._btnReset, passCount <= 0)

	self._txtMaxScore.text = string.format("历史最高击杀数：%s", self._subMo:getBestScore())

	self:_onUpdateStageColUI()
	self:_onUpdatePrizeColUI()
end

function HeartOfAoJiuClgStageView:_onUpdateStageColUI()
	local datas = HeartOfAoJiuClgConfig.instance:getStageDatas(self._activityId) or {}

	self._curStageId = Mathf.Clamp(self._curStageId, 0, #datas)

	self._stageScrollerList:reloadData(datas)

	local index = 1

	for idx, data in ipairs(datas) do
		if not self._subMo:isPassStage(data.stageId) then
			index = idx

			break
		end
	end

	self._stageScrollerList:MoveCellToCenter(index - 1)
end

function HeartOfAoJiuClgStageView:_onClearStageCol()
	self._stageScrollerList:dispose()
end

function HeartOfAoJiuClgStageView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local isPass = self._subMo:isPassStage(stageId)
	local score = self._subMo:getScoreInStage(stageId)
	local mainGo = cell.gameObject
	local root = goutil.findChild(mainGo, "root")
	local btn = goutil.findChild(root, "btn")
	local tagSelect = goutil.findChild(root, "btn/tagSelect")
	local txtName = goutil.findChildTextComponent(root, "btn/txtName")
	local scoreGo = goutil.findChild(root, "score")
	local txtScore = goutil.findChildTextComponent(root, "score/txt")

	txtName.text = string.format("%s", data.name)
	txtScore.text = string.format("击杀：%s", score)

	GameUtil.SetActive(scoreGo, isPass)
	GameUtil.SetActive(tagSelect, self._curStageId == stageId)

	local index = cell.data % 2

	if index == 1 then
		GameUtil.setLocalPos(root, 0, 70, 0)
	else
		GameUtil.setLocalPos(root, 0, -91.5, 0)
	end

	GameUtil.addClickHandler(btn, function()
		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		end

		local lastCellIndex = self._curStageId - 1

		if lastCellIndex >= 0 then
			self._stageScrollerList:updateCellInViewByIndex(lastCellIndex)
		end

		self._curStageId = stageId

		GameUtil.SetActive(tagSelect, true)
		HeartOfAoJiuClgController.instance:enterBattle(self._activityId, stageId)
	end)
end

function HeartOfAoJiuClgStageView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local root = goutil.findChild(mainGo, "root")
	local btn = goutil.findChild(root, "btn")

	GameUtil.rmClickHandler(btn)
end

function HeartOfAoJiuClgStageView:_onUpdatePrizeColUI()
	local list = string.split(self._actData.dailyRankPrize, "#")

	self._prizeScrollerList:reloadData(list)
end

function HeartOfAoJiuClgStageView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function HeartOfAoJiuClgStageView:_updatePrizeCell(view, cell, data, tag)
	local isHasGain = self._subMo:isHasGainDailyPrize()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local tagHasGain = goutil.findChild(mainGo, "tagHasGain")

	GameUtil.SetActive(tagHasGain, isHasGain)
	MaterialMgr.setCellByCfg(data, item)
end

function HeartOfAoJiuClgStageView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function HeartOfAoJiuClgStageView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function HeartOfAoJiuClgStageView:_onClickBtnReset()
	local passCount = self._subMo:getPassStageCount()

	if passCount <= 0 then
		FloatWordMgr.instance:show("未通关任何关卡")

		return
	end

	local tipsContent = "是否确定重置当前所有关卡？"

	local function okFunc()
		HeartOfAoJiuClgController.instance:sendPM_HeartOfAoJiuClgResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

return HeartOfAoJiuClgStageView
