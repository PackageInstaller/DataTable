-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastBossView.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastBossView", package.seeall)

local DumplingFeastBossView = class("DumplingFeastBossView", ViewComponent)

function DumplingFeastBossView:buildUI()
	DumplingFeastBossView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._con = self:getGo("con")
	self._btnClg = self:getGo("prizeCol/btnClg")
	self._txtClgTimes = self:getTxt("prizeCol/txtTimes")
	self._strTxtClgTimes = self._txtClgTimes.text
	self._btnTryClg = self:getGo("prizeCol/btnTryClg")
	self._btnRank = self:getGo("btnRank")
	self._btnUpgrade = self:getGo("infoCol/btnUpgrade")
	self._redBtnUpgrade = self:getGo("infoCol/btnUpgrade/red")
	self._emptyInfo = self:getGo("infoCol/empty")

	local infoColScrView = self:getGo("infoCol/scrView")
	local infoColScrCell = self:getGo("infoCol/scrCell")

	self._infoScrollerList = ScrollerList.create(infoColScrView, infoColScrCell, GameUtil.handler(self._updateInfoCell, self), GameUtil.handler(self._clearInfoCell, self))
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = self:getGo("prizeCol/total")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txtNum")
	self._prizeCol_total_icon = self:getGo("prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function DumplingFeastBossView:bindEvents()
	DumplingFeastBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnTryClg, self._onClickBtnTryClg, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnUpgrade, self._onClickBtnUpgrade, self)
end

function DumplingFeastBossView:unbindEvents()
	DumplingFeastBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTryClg)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnUpgrade)
end

function DumplingFeastBossView:onEnter()
	DumplingFeastBossView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = DumplingFeastController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastGainDamageProgressRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
	DumplingFeastController.instance:sendPM_DumplingFeastInfoReq(self._activityId)
end

function DumplingFeastBossView:onExit()
	DumplingFeastBossView.super.onExit(self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	RedPointController.instance:unregRedPoint(self._redBtnUpgrade)
	self:_onClearInfoCol()
	self:_onClearPrizeCol()
end

function DumplingFeastBossView:_onSetUI()
	local actData = DumplingFeastConfig.instance:getActivityData(self._activityId)
	local skinId = actData.bossSkinId
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[3] then
		local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, modelCfg[3], nil, true, x, y)

		RedPointController.instance:regRedPoint(self._redBtnUpgrade, RedPointModel.ID_DUMMPLINGFEAST_INTIMACY_PRIZE)
	end
end

function DumplingFeastBossView:_onUpdate()
	local curTimes = self._subMo:getTodayBossClgTimes()
	local maxTimes = self._subMo:getDailyBossClgTimes()
	local leftTimes = maxTimes - curTimes

	self._txtClgTimes.text = string.format(self._strTxtClgTimes, leftTimes, maxTimes)

	self:_onUpdateInfoCol()
	self:_onUpdatePrizeCol()
end

function DumplingFeastBossView:_onUpdateInfoCol()
	local infoList = {}
	local supportPetDatas = DumplingFeastConfig.instance:getSupportPetDatas(self._activityId)

	for creepsId, creepsData in pairs(supportPetDatas) do
		local raceId = creepsData.raceId
		local intimacy = self._subMo:getCreepsIntimacy(raceId)
		local intimacyData = DumplingFeastConfig.instance:getIntimacyDataByIntimacy(creepsData.buffPlanId, intimacy)

		if intimacyData then
			local mo = {}

			mo.creepsData = creepsData
			mo.intimacyData = intimacyData

			table.insert(infoList, mo)
		end
	end

	self._infoScrollerList:reloadData(infoList)
	GameUtil.SetActive(self._emptyInfo, #infoList <= 0)
end

function DumplingFeastBossView:_onClearInfoCol()
	self._infoScrollerList:dispose()
end

function DumplingFeastBossView:_updateInfoCell(view, cell, info, tag)
	local creepsData = info.creepsData
	local intimacyData = info.intimacyData
	local skinId = checknumber(creepsData.faceId)

	if skinId <= 0 then
		skinId = creepsData.raceId
	end

	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)

	txtDesc.text = intimacyData.desc
end

function DumplingFeastBossView:_clearInfoCell(cell)
	return
end

function DumplingFeastBossView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = -1

	for idx, data in ipairs(dataList) do
		if not self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = MmUtil.formatNumber(curProgress, MmUtil.Units_OnlyW, 0)
end

function DumplingFeastBossView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function DumplingFeastBossView:_getProgressDataList()
	return DumplingFeastConfig.instance:getDamageProgressDatas(self._activityId) or {}
end

function DumplingFeastBossView:_getSliderComp()
	return self._sliderComp
end

function DumplingFeastBossView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function DumplingFeastBossView:_getCurProgress()
	return self._subMo:getTotalBossDamage()
end

function DumplingFeastBossView:_getProgressByData(data)
	return checknumber(data.damage)
end

function DumplingFeastBossView:_getPrizeIdByData(data)
	return data.progressId
end

function DumplingFeastBossView:_getPrizeStrByData(data)
	return data.prize
end

function DumplingFeastBossView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrizeInDamage(prizeId)
end

function DumplingFeastBossView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughGetPrizeInDamage(prizeId)
end

function DumplingFeastBossView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGetPrizeInDamage(prizeId)
end

function DumplingFeastBossView:_updatePrizeCell(view, cell, data, tag)
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
		txtScore.text = MmUtil.formatNumber(progress, MmUtil.Units_OnlyW, 0)
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		local function loadedHandler(handlerTarget, eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function DumplingFeastBossView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function DumplingFeastBossView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	DumplingFeastController.instance:sendPM_DumplingFeastGainDamageProgressReq(self._activityId)
end

function DumplingFeastBossView:_onClickBtnTryClg()
	DumplingFeastController.instance:enterBossBattle(self._activityId, true)
end

function DumplingFeastBossView:_onClickBtnClg()
	local result = self:_getTryBossClgResultAndTips(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DumplingFeastController.instance:enterBossBattle(self._activityId, false)
end

function DumplingFeastBossView:_getTryBossClgResultAndTips(isNeedTips)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success and not self._subMo:isEnoughBossClgTimes() then
		result = GameEnum.ResultCode.Error
		tips = "次数不足"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function DumplingFeastBossView:_onClickBtnTip()
	local data = DumplingFeastConfig.instance:getActivityData(self._activityId)
	local key = data and data.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DumplingFeastBossView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.DumplingFeastRankView, self._activityId)
end

function DumplingFeastBossView:_onClickBtnUpgrade()
	UIStateManager.instance:push(ViewName.DumplingFeastFeedView, self._activityId)
end

return DumplingFeastBossView
