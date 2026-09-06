-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleNormalView.lua

module("logic.extensions.kingofradiantgoldclg.view.DivineInvincibleNormalView", package.seeall)

local DivineInvincibleNormalView = class("DivineInvincibleNormalView", ViewComponent)

function DivineInvincibleNormalView:ctor()
	DivineInvincibleNormalView.super.ctor(self)
end

function DivineInvincibleNormalView:buildUI()
	DivineInvincibleNormalView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")

	local fmtScrView = self:getGo("fmtCol/scrView")
	local fmtScrCell = self:getGo("fmtCol/scrCell")

	self._fmtScrollerList = ScrollerList.create(fmtScrView, fmtScrCell, GameUtil.handler(self._updateFmtCell, self), GameUtil.handler(self._clearFmtCell, self))
	self._txtBuff = self:getTxt("tips/txtBuff")
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollerClipGo = self:getGo("prizeCol/scrView/Viewport")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._totalPrize = self:getGo("prizeCol/total")
	self._txtTotalPrize = self:getTxt("prizeCol/total/txt")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function DivineInvincibleNormalView:bindEvents()
	DivineInvincibleNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
end

function DivineInvincibleNormalView:unbindEvents()
	DivineInvincibleNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineInvincibleNormalView:onEnter()
	DivineInvincibleNormalView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = DivineInvincibleController.instance:getActivityType()

	local isInTime = DivineInvincibleController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgMo = DivineInvincibleController.instance:getClgMo(self._activityId)
	self._actData = DivineInvincibleConfig.instance:getActData(self._activityId)
	self._finishNum = 0
	self._curDay = 0
	self._creepsMasterIds = {}

	self.addGEvent(self, GlobalNotify.HandlePM_DivineInvincibleClgNormalInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineInvincibleClgNormalGainPrizeRes, self._onUpdate, self)
	DivineInvincibleController.instance:sendPM_DivineInvincibleClgNormalInfoReq(self._activityId)
	self:_onUpdate()
end

function DivineInvincibleNormalView:onExit()
	DivineInvincibleNormalView.super.onExit(self)
	self:_onClearFmtCol()
	self:_onClearPrizeCol()
end

function DivineInvincibleNormalView:_onUpdate()
	self._curDay = self._clgMo:getCurDayInNor()

	local data = DivineInvincibleConfig.instance:getNorStageData(self._activityId, self._curDay)

	if data then
		self._creepsMasterIds = data.creepsMasterIds or {}
	end

	self:_onUpdateFmtColUI()
	self:_onUpdatePrizeCol()

	self._txtBuff.text = data.buffDesc
end

function DivineInvincibleNormalView:_onUpdateFmtColUI()
	self._fmtScrollerList:reloadData(self._creepsMasterIds)
end

function DivineInvincibleNormalView:_onClearFmtCol()
	self._fmtScrollerList:dispose()
	MaterialMgr.resetAll(self._phasePrize)
end

function DivineInvincibleNormalView:_updateFmtCell(view, cell, creepsMasterId, tag)
	local stageId = cell.data
	local monsterData = DivineInvincibleConfig.instance:getMasterData(creepsMasterId)
	local creepsCfg = DivineInvincibleConfig.instance:getCreepsCfg(creepsMasterId)
	local killNum = self._clgMo:getkillNumInNor(stageId)
	local mainGo = cell.gameObject
	local btnEnter = goutil.findChild(mainGo, "btnEnter")
	local btnReset = goutil.findChild(mainGo, "btnReset")
	local fmt = goutil.findChild(mainGo, "fmt")
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local imgPass = goutil.findChild(mainGo, "fmt/imgPass")
	local txtNum = goutil.findChildTextComponent(mainGo, "num/txt")

	txtNum.text = string.format("今日最高击杀：%s", killNum)

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local mask = goutil.findChild(go, "mask")
		local icon = goutil.findChild(go, "mask/icon")
		local creepsData

		for _, cData in ipairs(creepsCfg) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		GameUtil.SetActive(mask, creepsData ~= nil)

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, icon)

			if proxy then
				local raceId = creepsData.raceId
				local level = creepsData.lv
				local awakenLv = 1

				proxy.binder:setClickCallBack(function()
					local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)

					CommonTipsMgr.instance:showPetTips(tmpMo, true)
				end)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	GameUtil.addClickHandler(btnEnter, function()
		DivineInvincibleController.instance:enterBattleNormal(self._activityId, stageId, creepsMasterId)
	end, self)
end

function DivineInvincibleNormalView:_clearFmtCell(cell)
	local mainGo = cell.gameObject
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local btnEnter = goutil.findChild(mainGo, "btnEnter")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "mask/icon")

		MaterialMgr.resetAll(icon)
	end

	GameUtil.rmClickHandler(btnEnter)
end

function DivineInvincibleNormalView:_onUpdatePrizeCol()
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

	self._txtTotalPrize.text = curProgress
end

function DivineInvincibleNormalView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function DivineInvincibleNormalView:_getProgressDataList()
	return DivineInvincibleConfig.instance:getNorPrizeCfg(self._activityId) or {}
end

function DivineInvincibleNormalView:_getSliderComp()
	return self._sliderComp
end

function DivineInvincibleNormalView:_getScrollClipGo()
	return self._prizeScrollerClipGo
end

function DivineInvincibleNormalView:_getCurProgress()
	return self._clgMo:getTotalKillNumInNor()
end

function DivineInvincibleNormalView:_getProgressByData(data)
	return data.num
end

function DivineInvincibleNormalView:_getPrizeIdByData(data)
	return data.prizeId
end

function DivineInvincibleNormalView:_getPrizeStrByData(data)
	return data.prize
end

function DivineInvincibleNormalView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._clgMo:isHasGainPrizeInNor(prizeId)
end

function DivineInvincibleNormalView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._clgMo:isEnoughPrizeInNor(prizeId)
end

function DivineInvincibleNormalView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._clgMo:isCanPrizeInNor(prizeId)
end

function DivineInvincibleNormalView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local clipGo = self:_getScrollClipGo()
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

	if isCanGet then
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, clipGo, true, nil)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function DivineInvincibleNormalView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function DivineInvincibleNormalView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	DivineInvincibleController.instance:sendPM_DivineInvincibleClgNormalGainPrizeReq(self._activityId, prizeId)
end

function DivineInvincibleNormalView:_onClikBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return DivineInvincibleNormalView
