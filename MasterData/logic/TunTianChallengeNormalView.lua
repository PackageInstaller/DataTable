-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/view/TunTianChallengeNormalView.lua

module("logic.extensions.tuntianchallenge.view.TunTianChallengeNormalView", package.seeall)

local TunTianChallengeNormalView = class("TunTianChallengeNormalView", ViewComponent)

function TunTianChallengeNormalView:buildUI()
	TunTianChallengeNormalView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnRefresh = goutil.findChild(self.mainGO, "btnRefresh")
	self._txtLeftClgTimes = goutil.findChildTextComponent(self.mainGO, "txtLeftClgTimes")
	self._txtLeftRefreshTimes = goutil.findChildTextComponent(self.mainGO, "txtLeftRefreshTimes")
	self._partCol = goutil.findChild(self.mainGO, "partCol")
	self._partView = goutil.findChild(self.mainGO, "partCol/partView")
	self._partCell = goutil.findChild(self.mainGO, "partCol/partCell")

	GameUtil.SetActive(self._partCell, false)

	self._ruleCol = goutil.findChild(self.mainGO, "ruleCol")
	self._ruleScrollerview = goutil.findChild(self.mainGO, "ruleCol/ruleScrollerview")
	self._ruleScrollercell = goutil.findChild(self.mainGO, "ruleCol/ruleScrollercell")
	self._ruleScrollList = ScrollerList.create(self._ruleScrollerview, self._ruleScrollercell, GameUtil.handler(self._updateRuleCell, self), GameUtil.handler(self._clearRuleCell, self))

	local worldRoot = self:getGo("worldRoot")

	self._worldSliderMo = WorldSliderMo.New(worldRoot)
	self._partFlashEffPool = {}
end

function TunTianChallengeNormalView:bindEvents()
	TunTianChallengeNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	self._worldSliderMo:bindEvents()
end

function TunTianChallengeNormalView:unbindEvents()
	TunTianChallengeNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRefresh)
	self._worldSliderMo:unbindEvents()
end

function TunTianChallengeNormalView:onEnter()
	TunTianChallengeNormalView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityType = TunTianChallengeController.instance:getActivityType()

	local isInTime = TunTianChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.TunTianClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TunTianRefreshNormalClgMonsterRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TunTianNormalClgFightRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TunTianNotifyNormalClgFightResultRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TunTianGainNormalClgProgressPrizeRes, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function TunTianChallengeNormalView:onExit()
	TunTianChallengeNormalView.super.onExit(self)
	self:_onClearSliderCol()
	self:_onClearPartCol()
	self:_onClearRuleCol()
	TunTianChallengeModel.instance:clearPartNeedFlashEffList()
	self:_clearAllPartFlashEff()
end

function TunTianChallengeNormalView:_sendInfoReq()
	TunTianChallengeController.instance:sendPM_TunTianClgGetInfoReq(self._activityId)
end

function TunTianChallengeNormalView:_onSetUI()
	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	self:_initScoreSlider()
end

function TunTianChallengeNormalView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TunTianChallengeNormalView:_onUpdateData()
	return
end

function TunTianChallengeNormalView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateSliderColUI()
	self:_onUpdatePartColUI()
	self:_onUpdateRuleColUI()
end

function TunTianChallengeNormalView:_onUpdatePlaneUI()
	local leftCount = TunTianChallengeController.instance:getLeftFightCountOfNorClg()
	local maxCount = TunTianChallengeController.instance:getMaxFightCountOfNorClg(self._activityId)

	self._txtLeftClgTimes.text = string.format("剩余挑战次数：%s/%s", leftCount, maxCount)

	local leftCount = TunTianChallengeController.instance:getLeftRefreshMonsterCountOfNorClg()
	local maxCount = TunTianChallengeController.instance:getMaxRefreshMonsterCountOfNorClg(self._activityId)

	self._txtLeftRefreshTimes.text = string.format("剩余刷新次数：%s/%s", leftCount, maxCount)
end

function TunTianChallengeNormalView:_onUpdateSliderColUI()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
end

function TunTianChallengeNormalView:_onClearSliderCol()
	self._worldSliderMo:onExit()
end

function TunTianChallengeNormalView:_initScoreSlider()
	local worldParam = {}

	worldParam.view = self
	worldParam.isShowDefaultPos = true
	worldParam.elementSpacing = 90
	worldParam.prizeCfgs = TunTianChallengeConfig.instance:getTtNorProgressDataList(self._activityId)

	local maxScore = checknumber(worldParam.prizeCfgs[#worldParam.prizeCfgs].progress)

	function worldParam.getWorldProgress()
		return TunTianChallengeController.instance:getCurProgressOfNorClg()
	end

	function worldParam.getNeedScoreByRewardCfg(data)
		return data.progress
	end

	function worldParam.isWorldRewardCanGet(data)
		return TunTianChallengeController.instance:isCanGetPrizeInProgressOfNorClg(data.activityId, data.dataBitId)
	end

	function worldParam.isWorldRewardGeted(data)
		return TunTianChallengeController.instance:isHasGainPrizeInProgressOfNorClg(data.dataBitId)
	end

	function worldParam.sendGainWorldPrizeReq(data)
		TunTianChallengeController.instance:sendPM_TunTianGainNormalClgProgressPrizeReq(self._activityId, data.dataBitId)
	end

	function worldParam.getPrizeText(rewardCfg)
		return string.format("%s", TunTianChallengeController.instance:getCurProgressOfNorClg())
	end

	self._worldSliderMo:initParam(worldParam)
	self._worldSliderMo:onEnter()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
end

function TunTianChallengeNormalView:_onUpdatePartColUI()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)
	local slotDataList = TunTianChallengeConfig.instance:getTtNorMonsterSlotDataList(self._activityId)

	for slotId, data in ipairs(slotDataList) do
		local mainGo = children[slotId]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(self._partCell, parentTran, string.format("%s_%s", self._partCell.name, slotId))

			local pos = data.pos

			if not pos[3] then
				local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

				GameUtil.setLocalPos(mainGo, x, y, 0)
				GameUtil.setLocalScale(mainGo, pos[3])
			end
		end

		self:_updatePartCell(mainGo, data)
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #slotDataList)
	end
end

function TunTianChallengeNormalView:_onClearPartCol()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		local imgHead = goutil.findChild(mainGo, "imgHead")

		GameUtil.rmClickHandler(imgHead)
	end
end

function TunTianChallengeNormalView:_updatePartCell(mainGo, slotData)
	local monsterId = TunTianChallengeModel.instance:getMonsterIdBySlotOfNorClg(slotData.slotId)
	local isHaveMaster = monsterId ~= 0

	if isHaveMaster then
		::label_23_0::

		local monsterData = TunTianChallengeConfig.instance:getTtNorMonsterData(self._activityId, monsterId)

		if monsterData then
			::label_23_1::

			local typeData = TunTianChallengeConfig.instance:getTtNorMonsterTypeData(self._activityId, monsterData.monsterTypeId)
			local imgHead = goutil.findChild(mainGo, "imgHead")
			local effRoot = goutil.findChild(mainGo, "head/effRoot")
			local txtName = goutil.findChildTextComponent(mainGo, "txtName/txt")
			local txtZdl = goutil.findChildTextComponent(mainGo, "txtZdl/txt")

			GameUtil.SetActive(mainGo, isHaveMaster)
			GameUtil.getUIImageSpriteChange(imgHead):ChangeSprite(typeData.headName)

			if typeData then
				txtName.text = typeData.name
				txtZdl.text = string.format("推荐战力：%s", typeData.zdl)
			end

			if TunTianChallengeModel.instance:isInMarkPartNeedFlashEffList(slotData.slotId) then
				TunTianChallengeModel.instance:markPartNeedFlashEff(slotData.slotId, false)
				self:_playPartFlashEff(mainGo)
			else
				self:_clearPartFlashEff(mainGo)
			end

			GameUtil.addClickHandler(imgHead, GameUtil.handler(self._onClickPartCell, self, slotData.slotId, monsterId))
		end
	end
end

function TunTianChallengeNormalView:_onClickPartCell(slotId, monsterId)
	local result, tips = TunTianChallengeController.instance:getTryFightMonsterOfNorClgResultAndTips(self._activityId, slotId, monsterId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	TunTianChallengeController.instance:enterBattleOfNorClg(self._activityId, slotId, monsterId)
end

function TunTianChallengeNormalView:_playPartFlashEff(effParent)
	self:_clearPartFlashEff(effParent)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._partFlashEffPool[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function TunTianChallengeNormalView:_clearPartFlashEff(effParent)
	UIEffectManager.instance:stopEffect(self._partFlashEffPool[effParent])
end

function TunTianChallengeNormalView:_clearAllPartFlashEff()
	for k, v in pairs(self._partFlashEffPool) do
		self:_clearPartFlashEff(k)
	end

	table.clear(self._partFlashEffPool)
end

function TunTianChallengeNormalView:_onUpdateRuleColUI()
	local cfg = TunTianChallengeConfig.instance:getTtNorMonsterTypeDataList(self._activityId)

	self._ruleScrollList:reloadData(cfg)
	self._ruleScrollList:MoveCellInView(0, true)
end

function TunTianChallengeNormalView:_onClearRuleCol()
	self._ruleScrollList:dispose()
end

function TunTianChallengeNormalView:_updateRuleCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = string.format("<color=#4EAEFFFF>%s：</color>%s", data.name, data.incProgress)
end

function TunTianChallengeNormalView:_clearRuleCell(cell)
	return
end

function TunTianChallengeNormalView:_onClickBtnTip()
	local key = TunTianChallengeConfig.instance:getTtClientCommonValue(self._activityId, "TUNTIAN_NORMAL_RULE_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

function TunTianChallengeNormalView:_onClickBtnRefresh()
	local result, tips = TunTianChallengeController.instance:getTryRefreshMonsterOfNorClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local baseData = TunTianChallengeConfig.instance:getTtBaseData(self._activityId)
	local matStr = baseData.refreshNormalClgMonsterCost
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local leftCount = TunTianChallengeController.instance:getLeftRefreshMonsterCountOfNorClg()
	local content = string.format("是否花费%s%s刷新当前所有妖灵？\n还有%s次刷新机会。", matNum, matName, leftCount)

	local function successCallBack(state)
		return
	end

	local toggleFunc, togTxt
	local alignment = UnityEngine.TextAnchor.MiddleCenter

	local function otherCallBack(state)
		if state == TipsFacade.STATE_CANCEL then
			-- block empty
		elseif state == TipsFacade.STATE_OK then
			-- block empty
		elseif state == TipsFacade.STATE_FAIL then
			FloatWordMgr.instance:show(string.format("%s数量不足", matName))
		elseif state == TipsFacade.STATE_SUCCESS then
			TunTianChallengeController.instance:sendPM_TunTianRefreshNormalClgMonsterReq(self._activityId)
		end
	end

	local autoOpenSource

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
end

return TunTianChallengeNormalView
