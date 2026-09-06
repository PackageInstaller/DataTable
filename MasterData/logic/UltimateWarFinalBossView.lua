-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarFinalBossView.lua

module("logic.extensions.ultimatewar.view.UltimateWarFinalBossView", package.seeall)

local UltimateWarFinalBossView = class("UltimateWarFinalBossView", ViewComponent)

function UltimateWarFinalBossView:buildUI()
	UltimateWarFinalBossView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnRank = self:getGo("btnRank")
	self._btnVote = self:getGo("btnVote")
	self._con = self:getGo("con")
	self._btnBuff = self:getGo("btnBuff")
	self._txtDescBuff = self:getTxt("btnBuff/txtDesc")
	self._fullTagBuff = self:getGo("btnBuff/fullTag")
	self._redPointBuff = self:getGo("btnBuff/redPoint")
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txtNum")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._bossView = self:getGo("bossCol/bossView")
	self._bossCell = self:getGo("bossCol/bossCell")
end

function UltimateWarFinalBossView:bindEvents()
	UltimateWarFinalBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnVote, self._onClickBtnVote, self)
end

function UltimateWarFinalBossView:unbindEvents()
	UltimateWarFinalBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnVote)
end

function UltimateWarFinalBossView:onEnter()
	UltimateWarFinalBossView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._rankType = UltimateWarEnum.RankType_TowerBoss
	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._actData = UltimateWarConfig.instance:getActData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGetMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarThirdStepInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarThirdStepGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarThirdStepCheckInRes, self._onUpdate, self)
	UltimateWarController.instance:sendPM_UltimateWarThirdStepInfoReq(self._activityId)
end

function UltimateWarFinalBossView:onExit()
	UltimateWarFinalBossView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	RedPointController.instance:unregRedPoint(self._redPointBuff)
	self:_onClear()
end

function UltimateWarFinalBossView:_onSetUI()
	RedPointController.instance:regRedPoint(self._redPointBuff, RedPointModel.ID_ULTIMATEWAR_THIRDSTEP_BUFF)

	local skinId = 18021

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
end

function UltimateWarFinalBossView:_onUpdate()
	local day = self._ultimateWarMo:getCheckInDays()
	local buffData = UltimateWarConfig.instance:getBossBuffDataByDay(self._activityId, day)

	if buffData then
		self._txtDescBuff.text = buffData.buffDesc or "无"
	end

	GameUtil.SetActive(self._fullTagBuff, self._ultimateWarMo:isFullDay())
	self:_onUpdatePrizeCol()
	self:_onUpdateBossCol()
end

function UltimateWarFinalBossView:_onClear()
	self:_onClearPrizeCol()
	self:_onClearBossCol()
end

function UltimateWarFinalBossView:_onUpdateBossCol()
	local cfg = UltimateWarConfig.instance:getBossCfg(self._activityId) or {}

	GameUtil.updateCellsList(self._bossView, self._bossCell, cfg, self._updateBossCell, self)
end

function UltimateWarFinalBossView:_onClearBossCol()
	GameUtil.clearCells(self._bossView, self._clearBossCell, self)
end

function UltimateWarFinalBossView:_updateBossCell(mainGo, data, index)
	local bossId = data.bossId
	local skinId = data.skinId
	local isPass = self._ultimateWarMo:isPassBossInFinal(bossId)
	local mask = goutil.findChild(mainGo, "mask")
	local con = goutil.findChild(mainGo, "con")
	local imgPass = goutil.findChild(mainGo, "imgPass")

	if not data.pos then
		if not data.pos[3] then
			local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, data.pos[3], data.pos[3], data.pos[3])
			GameUtil.SetActive(imgPass, isPass)
			MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
			GameUtil.addClickHandler(mainGo, function()
				if self._ultimateWarMo:isPassBossInFinal(bossId) then
					FloatWordMgr.instance:show("已通关")

					return
				end

				UltimateWarController.instance:enterBattleFinalBoss(self._activityId, bossId)
			end)
		end
	end
end

function UltimateWarFinalBossView:_clearBossCell(mainGo)
	local con = goutil.findChild(mainGo, "con")

	GameUtil.rmClickHandler(mainGo)
	MaterialMgr.clearIcon(con)
end

function UltimateWarFinalBossView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isCanGetPrize(data) then
			index = idx

			break
		elseif self:_isHasGainPrize(data) then
			index = idx
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function UltimateWarFinalBossView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function UltimateWarFinalBossView:_getProgressDataList()
	return UltimateWarConfig.instance:getBossPrizeCfg(self._activityId) or {}
end

function UltimateWarFinalBossView:_getSliderComp()
	return self._sliderComp
end

function UltimateWarFinalBossView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function UltimateWarFinalBossView:_getCurProgress()
	return self._ultimateWarMo:getBeatBossCount()
end

function UltimateWarFinalBossView:_getProgressByData(data)
	return data.beatBossCount
end

function UltimateWarFinalBossView:_getPrizeIdByData(data)
	return data.prizeId
end

function UltimateWarFinalBossView:_getPrizeStrByData(data)
	return data.prize
end

function UltimateWarFinalBossView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._ultimateWarMo:isHasGainPrizeInFinalBoss(prizeId)
end

function UltimateWarFinalBossView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._ultimateWarMo:isEnoughPrizeInFinalBoss(prizeId)
end

function UltimateWarFinalBossView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._ultimateWarMo:isCanGetPrizeInFinalBoss(prizeId)
end

function UltimateWarFinalBossView:_updatePrizeCell(view, cell, data, tag)
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

function UltimateWarFinalBossView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

function UltimateWarFinalBossView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	UltimateWarController.instance:sendPM_UltimateWarThirdStepGainPrizeReq(self._activityId, prizeId)
end

function UltimateWarFinalBossView:_onClickBtnBuff()
	local result = UltimateWarController.instance:getTryGetBuffInFInalBossResultAndTips(true, self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UltimateWarController.instance:sendPM_UltimateWarThirdStepCheckInReq(self._activityId)
end

function UltimateWarFinalBossView:_onClickBtnTip()
	local key = self._actData.thirdStepRule

	TipsFacade.instance:openRulesView(key)
end

function UltimateWarFinalBossView:_onClickBtnRank()
	UltimateWarController.instance:openCommonTabRank(self._activityId, ViewName.UltimateWarTowerFinalBossRankChildView)
end

function UltimateWarFinalBossView:_onClickBtnVote()
	local voteId = self._ultimateWarMo:getSelectVoteId()

	if voteId > 0 then
		UIStateManager.instance:push(ViewName.UltimateWarVoteResultView, self._activityId)
	else
		UIStateManager.instance:push(ViewName.UltimateWarVoteView, self._activityId)
	end
end

return UltimateWarFinalBossView
