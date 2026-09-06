-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/view/KingKaYaNorView.lua

module("logic.extensions.kingkaya.view.KingKaYaNorView", package.seeall)

local KingKaYaNorView = class("KingKaYaNorView", ViewComponent)

function KingKaYaNorView:buildUI()
	KingKaYaNorView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tips/txt")
	self._partCol = goutil.findChild(self.mainGO, "partCol")
	self._partView = goutil.findChild(self.mainGO, "partCol/view")
	self._partCell = goutil.findChild(self.mainGO, "partCol/cell")
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/scrView")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/scrCell")
	self._progressBar = goutil.findChild(self.mainGO, "prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = goutil.findChild(self.mainGO, "prizeCol/total")
	self._prizeCol_total_txtNum = goutil.findChildTextComponent(self.mainGO, "prizeCol/total/txtNum")
	self._prizeCol_total_icon = goutil.findChild(self.mainGO, "prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function KingKaYaNorView:bindEvents()
	KingKaYaNorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function KingKaYaNorView:unbindEvents()
	KingKaYaNorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function KingKaYaNorView:onEnter()
	KingKaYaNorView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = KingKaYaController.instance:getActivityType()

	local isInTime = KingKaYaController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._kingKaYaMo = KingKaYaController.instance:getKingKaYaMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_KingKaYaGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingKaYaGainProgressPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_Notify_KingKaYaNormalChallengeEndRes, self._onUpdate, self)

	self._txtTips.text = KingKaYaConfig.instance:getCommonValue(self._activityId, "norClgTips")

	self:_sendInfoReq()
end

function KingKaYaNorView:onExit()
	KingKaYaNorView.super.onExit(self)
	self:_onClearPartCol()
	self:_onClearPrizeCol()
end

function KingKaYaNorView:_sendInfoReq()
	KingKaYaController.instance:sendPM_KingKaYaGetInfoReq(self._activityId)
end

function KingKaYaNorView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KingKaYaNorView:_onUpdateData()
	return
end

function KingKaYaNorView:_onUpdateUI()
	self:_onUpdatePartColUI()
	self:_onUpdatePrizeCol()
end

function KingKaYaNorView:_onUpdatePartColUI()
	local stageIdList = self._kingKaYaMo:getStageIdListInNor()
	local cfg = KingKaYaConfig.instance:getNorDiffCfg(self._activityId)

	GameUtil.updateCellsList(self._partView, self._partCell, stageIdList, self._updatePartCell, self)
end

function KingKaYaNorView:_onClearPartCol()
	GameUtil.clearCells(self._partView, self._clearPartCell, self)
end

function KingKaYaNorView:_updatePartCell(mainGo, stageId, index)
	local stageData = KingKaYaConfig.instance:getNorStageData(self._activityId, stageId)
	local diffData = KingKaYaConfig.instance:getNorDiffData(self._activityId, stageData.difficulty)
	local isPass = self._kingKaYaMo:isPassStageInNor(stageId)
	local btn = goutil.findChild(mainGo, "btn")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
	local imgPass = goutil.findChild(mainGo, "btn/imgPass")

	GameUtil.setUIGroupIdx(mainGo, index - 1)
	GameUtil.SetActive(imgPass, isPass)

	if not diffData.pos then
		if not diffData.pos[3] then
			local x, y, scale = checknumber(diffData.pos[1]), checknumber(diffData.pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, diffData.pos[3])

			txtName.text = diffData.name

			local UIGradient = txtName.gameObject:GetComponent(ComponentType.UIGradient)
			local color = txtName.color

			UIGradient.TopColor = UnityEngine.Color32.New(color.r * 255, color.g * 255, color.b * 255, color.a * 255)

			GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickPartCell, self, stageId))
		end
	end
end

function KingKaYaNorView:_clearPartCell(mainGo)
	local btn = goutil.findChild(mainGo, "btn")

	GameUtil.rmClickHandler(btn)
end

function KingKaYaNorView:_onClickPartCell(stageId)
	local result, tips = self:getTryStartStageClgResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.KingKaYaMainView, nil, self._activityId)
	UIJumper.instance:pushOneStack(ViewName.KingKaYaNorView, nil, self._activityId)
	KingKaYaController.instance:enterBattleInNor(self._activityId, stageId)
end

function KingKaYaNorView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function KingKaYaNorView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function KingKaYaNorView:_getProgressDataList()
	return KingKaYaConfig.instance:getNorProgressCfg(self._activityId)
end

function KingKaYaNorView:_getSliderComp()
	return self._sliderComp
end

function KingKaYaNorView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function KingKaYaNorView:_getCurProgress()
	return self._kingKaYaMo:getTotalScoreInNor()
end

function KingKaYaNorView:_getProgressByData(data)
	return data.needScore
end

function KingKaYaNorView:_getPrizeIdByData(data)
	return data.prizeId
end

function KingKaYaNorView:_getPrizeStrByData(data)
	return data.prize
end

function KingKaYaNorView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._kingKaYaMo:isHasGainPrizeInNor(prizeId)
end

function KingKaYaNorView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._kingKaYaMo:isEnoughGetPrizeInNor(prizeId)
end

function KingKaYaNorView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._kingKaYaMo:_isCanGetPrizeInNor(prizeId)
end

function KingKaYaNorView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = progress
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	self._prizeEffPool = self._prizeEffPool or {}

	UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(scrollRect)
			eff:setParent(effectRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._prizeEffPool[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectRoot, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function KingKaYaNorView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

function KingKaYaNorView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	KingKaYaController.instance:sendPM_KingKaYaGainProgressPrizeReq(self._activityId, prizeId)
end

function KingKaYaNorView:_onClickBtnTip()
	local key = KingKaYaConfig.instance:getCommonValue(self._activityId, "ruleKeyNor")

	TipsFacade.instance:openRulesView(key)
end

function KingKaYaNorView:getTryStartStageClgResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = KingKaYaController.instance:getKingKaYaMo(activityId)

	if not KingKaYaController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在开启期限内"
	elseif mo:isPassStageInNor(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	end

	return result, tips
end

return KingKaYaNorView
