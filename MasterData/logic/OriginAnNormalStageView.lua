-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnNormalStageView.lua

module("logic.extensions.originan.view.OriginAnNormalStageView", package.seeall)

local OriginAnNormalStageView = class("OriginAnNormalStageView", ViewComponent)

function OriginAnNormalStageView:buildUI()
	OriginAnNormalStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTips = self:getTxt("tips/scrView/Viewport/Content")
	self._fmtScrView = self:getGo("fmtCol/scrView")
	self._fmtScrCell = self:getGo("fmtCol/scrCell")
	self._fmtScrollerList = ScrollerList.create(self._fmtScrView, self._fmtScrCell, GameUtil.handler(self._updateFmtCell, self), GameUtil.handler(self._clearFmtCell, self))
	self._progressScrView = self:getGo("progressCol/scrView")
	self._progressScrCell = self:getGo("progressCol/scrCell")
	self._sliderComp = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._txtTotalScore = self:getTxt("progressCol/total/txtScore")
	self._progressScrollerList = ScrollerList.create(self._progressScrView, self._progressScrCell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
end

function OriginAnNormalStageView:bindEvents()
	OriginAnNormalStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
end

function OriginAnNormalStageView:unbindEvents()
	OriginAnNormalStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginAnNormalStageView:onEnter()
	OriginAnNormalStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = OriginAnController.instance:getSubMo(self._activityId)
	self._actData = OriginAnConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_OriginAnInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginAnNotifyNormalClgRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginAnGainNormalProgressRes, self._onUpdateProgressCol, self)

	self._txtTips.text = self._actData.normalRuleTips

	self:_onUpdate()
end

function OriginAnNormalStageView:onExit()
	OriginAnNormalStageView.super.onExit(self)
	self:_onClearFmtCol()
	self:_onClearProgressCol()
end

function OriginAnNormalStageView:_onUpdate()
	self:_onUpdateFmtCol()
	self:_onUpdateProgressCol()
end

function OriginAnNormalStageView:_onUpdateFmtCol()
	local groupId = OriginAnController.instance:getCurNormalStageGroupId(self._activityId)
	local stageDatas = OriginAnConfig.instance:getNormalStageDatas(self._activityId, groupId) or {}

	self._fmtScrollerList:reloadData(stageDatas)
end

function OriginAnNormalStageView:_onClearFmtCol()
	self._fmtScrollerList:dispose()
end

function OriginAnNormalStageView:_updateFmtCell(view, cell, stageData, tag)
	local groupId = stageData.groupId
	local stageId = stageData.stageId
	local creepsMasterId = stageData.creepsMasterId
	local score = self._subMo:getNormalStageMaxBlockHealTimes(stageId)
	local creepsCfg = OriginAnConfig.instance:getCreepsDatas(creepsMasterId)
	local mainGo = cell.gameObject
	local fmt = goutil.findChild(mainGo, "fmt")
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local txtTips = goutil.findChildTextComponent(mainGo, "tips/txt")

	txtTips.text = string.format("今日最多禁疗：%s", score)

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

	GameUtil.addClickHandler(fmt, function()
		OriginAnController.instance:enterBattleNormal(self._activityId, groupId, stageId)
	end, self)
end

function OriginAnNormalStageView:_clearFmtCell(cell)
	local mainGo = cell.gameObject
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local fmt = goutil.findChild(mainGo, "fmt")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "mask/icon")

		MaterialMgr.resetAll(icon)
	end

	GameUtil.rmClickHandler(fmt)
end

function OriginAnNormalStageView:_onUpdateProgressCol()
	local dataList = OriginAnConfig.instance:getProgressDatas(self._activityId) or {}
	local curProgress = self._subMo:getNormalTotalBlockHealTimes()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, checknumber(data.progress))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		index = idx - 1

		if not self._subMo:isNormalProgressGained(data.progressId) then
			break
		end
	end

	self._progressScrollerList:reloadData(dataList)
	self._progressScrollerList:updateUnderSlider(self._sliderComp, curProgress, scoreList)
	self._progressScrollerList:MoveCellToCenter(index)

	if self._txtTotalScore then
		self._txtTotalScore.text = curProgress
	end
end

function OriginAnNormalStageView:_onClearProgressCol()
	self._progressScrollerList:dispose()
end

function OriginAnNormalStageView:_isCanGetProgress(data)
	local progressId = data.progressId

	if self._subMo:isNormalProgressGained(progressId) then
		return false
	end

	return self._subMo:getNormalTotalBlockHealTimes() >= checknumber(data.progress)
end

function OriginAnNormalStageView:_updateProgressCell(view, cell, data, tag)
	local progressId = data.progressId
	local isHasGain = self._subMo:isNormalProgressGained(progressId)
	local isCanGet = self:_isCanGetProgress(data)
	local progress = checknumber(data.progress)
	local prizeStr = data.prize
	local scrollRect = self._progressScrView:GetComponent(ComponentType.ScrollRect)
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
		local function loadedHandler(handlerTarget, eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data), self)
end

function OriginAnNormalStageView:_clearProgressCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function OriginAnNormalStageView:_onClickPrizeGet(data)
	local progressId = data.progressId

	if self._subMo:isNormalProgressGained(progressId) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isCanGetProgress(data) then
		FloatWordMgr.instance:show("禁疗次数不足")

		return
	end

	OriginAnController.instance:sendPM_OriginAnGainNormalProgressReq(self._activityId, progressId)
end

function OriginAnNormalStageView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return OriginAnNormalStageView
