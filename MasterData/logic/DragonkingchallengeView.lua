-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonkingchallengeView.lua

module("logic.extensions.dragonking.view.DragonkingchallengeView", package.seeall)

local DragonkingchallengeView = class("DragonkingchallengeView", ViewComponent)
local MAX_SELECT_ESCORT_NUM = 2

function DragonkingchallengeView:ctor()
	DragonkingchallengeView.super.ctor(self)
end

function DragonkingchallengeView:unbindEvents()
	DragonkingchallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
end

function DragonkingchallengeView:bindEvents()
	DragonkingchallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function DragonkingchallengeView:buildUI()
	DragonkingchallengeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnRank = self:getGo("btnRank")
	self._txtTime = self:getTxt("time/txt")
	self._txtTotal = self:getTxt("progressReward/total/txt")
	self._item = self:getGo("progressReward/total/item")
	self._tableviewGo = self:getGo("progressReward/tableview")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._tableview = ScrollerList.create(self._tableviewGo, self._rewardCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local scrollerGo = self:getGo("tableview")
	local cell = self:getGo("tablecell")

	self._scrollList = ScrollerList.create(scrollerGo, cell, GameUtil.handler(self._updateFightCell, self), GameUtil.handler(self._clearFightCell, self))
end

function DragonkingchallengeView:onExit()
	DragonkingchallengeView.super.onExit(self)
	self._tableview:dispose()
	self._scrollList:dispose()
end

function DragonkingchallengeView:onEnter()
	DragonkingchallengeView.super.onEnter(self)

	self._activityId = DragonKingChallengeController.instance:getActivityId()

	if not self._activityId then
		self:close()
	end

	self._selectPetMap = {}

	self:_refreshUI()
	self.addGEvent(self, GlobalNotify.DragonKingChallengeUpdate, self._refreshUI, self)
	DragonKingChallengeController.instance:sendGetInfo(self._activityId)
end

function DragonkingchallengeView:_refreshUI()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local info = DragonKingChallengeModel.instance:getInfo(self._activityId) or {}
	local progress = checknumber(info.progress)

	self._curProgress = progress
	self._prizeGainedBitIdList = info.prizeGainedBitId or {}
	self._txtTotal.text = progress

	local progressCfgList = DragonKingChallengeConfig.instance:getProgressCfgList(self._activityId) or {}
	local scoreArr = {}

	for k, v in ipairs(progressCfgList) do
		table.insert(scoreArr, v.progress)
	end

	self._tableview:reloadData(progressCfgList)
	self._tableview:updateUnderSlider(self._progressBar, progress, scoreArr)
	self._tableview:MoveCellToCenter(Mathf.Clamp(self._curProgress, 1, #progressCfgList))

	local stageList = DragonKingChallengeConfig.instance:getStageConfigList(self._activityId) or {}

	self._scrollList:reloadData(stageList)

	for i, v in ipairs(stageList) do
		if v.stageId == DragonKingChallengeModel.instance.selectStageId then
			self._scrollList:MoveCellToCenter(i - 1)

			break
		end
	end
end

function DragonkingchallengeView:_onClickTips()
	TipsFacade.instance:openRulesView("DragonkingchallengeView_rule")
end

function DragonkingchallengeView:_onClickRank()
	UIStateManager.instance:push(ViewName.DragonkingchallengerankView)
end

function DragonkingchallengeView:_updateFightCell(view, cell, data, tag)
	local txtLevel = goutil.findChildTextComponent(cell, "level/txtLevel")
	local txtMaxScore = goutil.findChildTextComponent(cell, "txtMaxScore")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local lock = goutil.findChild(cell, "lock")
	local txtTime = goutil.findChildTextComponent(cell, "lock/txtTime")
	local select = goutil.findChild(cell, "select")
	local pass = goutil.findChild(cell, "pass")
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local formation = goutil.findChild(cell, "formation")

	GameUtil.SetActive(select, false)

	local info = DragonKingChallengeModel.instance:getStageInfo(self._activityId, data.stageId) or {}

	if not info.bestScoreGuardCreepsId then
		local bestScoreGuardCreepsId = {}

		txtLevel.text = langPara("第%s关", data.stageId)
		txtMaxScore.text = langPara("本关最高得分：%s", checknumber(info.bestScore))

		GameUtil.SetActive(pass, checknumber(info.bestScore) > 0)

		local now = ServerTime.now()
		local timeStart = GameUtil.string2time(data.openTime)

		txtTime.text = langPara("开启时间：\n%s", GameUtil.getFormatTimeByStamp(timeStart))

		GameUtil.SetActive(lock, now < timeStart)

		if not self._selectPetMap[data.stageId] then
			local list = {}

			txtNum.text = langPara("已选护卫：%s/%s", #list, MAX_SELECT_ESCORT_NUM)

			GameUtil.SetActive(btnChallenge, timeStart <= now)
			GameUtil.SetGray(btnChallenge, #list ~= MAX_SELECT_ESCORT_NUM)
			GameUtil.rmClickHandler(btnChallenge)
			GameUtil.addClickHandler(btnChallenge, GameUtil.handler(self._onClickFightBtn, self, data, #list == MAX_SELECT_ESCORT_NUM))

			local petMap = {}
			local creepsMasterId = data.creepsMasterId
			local creepcfg = DragonKingChallengeConfig.instance:getCreepsConfig(creepsMasterId) or {}

			for k, crCfg in pairs(creepcfg) do
				petMap[crCfg.posId] = crCfg
			end

			for i = 1, 9 do
				local cell = goutil.findChild(formation, "cell_" .. i)
				local con = goutil.findChild(cell, "con")
				local selectC = goutil.findChild(cell, "select")
				local mark = goutil.findChild(cell, "mark")
				local real = goutil.findChild(cell, "real")
				local escort = goutil.findChild(cell, "escort")
				local btn = goutil.findChild(cell, "btn")

				GameUtil.SetActive(selectC, false)
				GameUtil.SetActive(mark, false)
				GameUtil.SetActive(real, false)
				GameUtil.SetActive(escort, false)
				MaterialMgr.clearIcon(con)
				GameUtil.rmClickHandler(btn)

				local crCfg = petMap[i]

				GameUtil.SetActive(cell, false)

				if crCfg then
					GameUtil.SetActive(cell, true)
					GameUtil.SetActive(mark, table.indexof(bestScoreGuardCreepsId, crCfg.creepsId) ~= false)
					GameUtil.SetActive(escort, table.indexof(list, crCfg.creepsId) ~= false)
					GameUtil.SetActive(selectC, table.indexof(list, crCfg.creepsId) ~= false)
					GameUtil.SetActive(real, checkbool(crCfg.isRealBody))
					MaterialMgr.setIcon(con, MatType.Pet, crCfg.raceId)

					if timeStart <= now then
						GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickPetCell, self, data.stageId, crCfg))
					end
				end
			end
		end
	end
end

function DragonkingchallengeView:_clearFightCell(cell)
	local formation = goutil.findChild(cell, "formation")

	for i = 1, 9 do
		local cell = goutil.findChild(formation, "cell_" .. i)
		local con = goutil.findChild(cell, "con")
		local btn = goutil.findChild(cell, "btn")

		MaterialMgr.clearIcon(con)
		GameUtil.rmClickHandler(btn)
	end
end

function DragonkingchallengeView:_onClickPetCell(stageId, crCfg)
	if checkbool(crCfg.isRealBody) then
		TipsFacade.instance:openCommonTips("真身不能设置为护卫")

		return
	end

	self._selectPetMap[stageId] = self._selectPetMap[stageId] or {}

	local list = self._selectPetMap[stageId]
	local idx = table.indexof(list, crCfg.creepsId)

	if idx == false then
		if #list < MAX_SELECT_ESCORT_NUM then
			table.insert(list, crCfg.creepsId)
		else
			table.remove(list, 1)
			table.insert(list, crCfg.creepsId)
		end
	else
		table.remove(list, idx)
	end

	self._scrollList:refresh()
end

function DragonkingchallengeView:_onClickFightBtn(data, isEqual)
	if isEqual then
		local stageId = data.stageId

		self._selectPetMap[stageId] = self._selectPetMap[stageId] or {}

		local list = self._selectPetMap[stageId]

		DragonKingChallengeModel.instance.selectStageId = stageId

		DragonKingChallengeController.instance:openFmtView(self._activityId, stageId, list)
	else
		TipsFacade.instance:openCommonTips("请先选择护卫")
	end
end

function DragonkingchallengeView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	local isCanGet = self._curProgress >= data.progress
	local isGainPrize = table.indexof(self._prizeGainedBitIdList, data.dataBitId) ~= false

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data.dataBitId), self)
end

function DragonkingchallengeView:_onClickGetPrize(id)
	DragonKingChallengeController.instance:sendGetPrize(self._activityId, id)
end

function DragonkingchallengeView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function DragonkingchallengeView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progressReward/tableview/Viewport/Content").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function DragonkingchallengeView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return DragonkingchallengeView
