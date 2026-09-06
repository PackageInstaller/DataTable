-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianNorView.lua

module("logic.extensions.divinetuntian.view.DivineTunTianNorView", package.seeall)

local DivineTunTianNorView = class("DivineTunTianNorView", ViewComponent)

function DivineTunTianNorView:ctor()
	DivineTunTianNorView.super.ctor(self)
end

function DivineTunTianNorView:unbindEvents()
	DivineTunTianNorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuff)
end

function DivineTunTianNorView:bindEvents()
	DivineTunTianNorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function DivineTunTianNorView:buildUI()
	DivineTunTianNorView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnBuff = self:getGo("btnBuff")
	self._txtRule = self:getTxt("tip/scrView/Viewport/Content")
	self._stageList = {}

	for i = 1, 3 do
		local challengeCell = self:getGo("challengeCells/challengeCell" .. i)

		table.insert(self._stageList, challengeCell)
	end

	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._tableview = self:getGo("scorollReward/tableview")
	self._tableviewViewport = self:getGo("scorollReward/tableview/viewport")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("total/txtProgress")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
end

function DivineTunTianNorView:onExit()
	DivineTunTianNorView.super.onExit(self)
	self._scrollList:dispose()
	self:clearStageUI()
end

function DivineTunTianNorView:onEnter()
	DivineTunTianNorView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineTunTianClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DivineTunTianClgGainNormalProgressPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 508001
	end

	self._actCfg = DivineTunTianConfig.instance:getActCfg(self._activityId)
	self._rewardCfgs = DivineTunTianConfig.instance:getNorPrizeCfgs(self._activityId)

	DivineTunTianController.instance:sendPM_DivineTunTianClgGetInfoReq(self._activityId)
	self:_onSetUI()
end

function DivineTunTianNorView:_onSetUI()
	self._txtRule.text = self._actCfg.showNorRule

	self._scrollList:reloadData(self._rewardCfgs)
end

function DivineTunTianNorView:_onUpdate()
	self._info = DivineTunTianModel.instance:getInfo(self._activityId)
	self._txtProgress.text = checknumber(self._info.normalScore)

	self._scrollList:reloadData(self._rewardCfgs)

	local scoreList = {}

	for i, v in ipairs(self._rewardCfgs) do
		table.insert(scoreList, v.progress)
	end

	local totalScore = checknumber(self._info.normalScore)

	self._scrollList:updateUnderSlider(self._progressSlider, totalScore, scoreList)
	self:_updateStageUI()
end

function DivineTunTianNorView:_updateStageUI()
	for i, stageGo in ipairs(self._stageList) do
		local pass = goutil.findChild(stageGo, "stageFmt/pass")
		local fmt = goutil.findChild(stageGo, "stageFmt/fmt")
		local btnChallenge = goutil.findChild(stageGo, "btnChallenge")
		local txtTrans = goutil.findChildTextComponent(stageGo, "txtTrans")
		local norStageCfg = DivineTunTianConfig.instance:getNorCreepCfgByIndex(self._activityId, self._info.dayId, i)

		txtTrans.text = string.format("今日最多变身次数：%d", (self._info.todayNormalMaxScores or nil) and checknumber(self._info.todayNormalMaxScores[i]))

		self:_setFmt(fmt, norStageCfg)
		GameUtil.addClickHandler(btnChallenge, function()
			DivineTunTianController.instance:enterNorBattleClg(self._activityId, self._info.dayId, i)
		end, self)
	end
end

function DivineTunTianNorView:clearStageUI()
	for i, stageGo in ipairs(self._stageList) do
		local btnChallenge = goutil.findChild(stageGo, "btnChallenge")
		local fmt = goutil.findChild(stageGo, "stageFmt/fmt")

		GameUtil.rmClickHandler(btnChallenge)
		self:_clearFmt(fmt)
	end
end

function DivineTunTianNorView:_setFmt(fmtView, cfg)
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, 9 do
		local creepsData = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)

		if creepsData then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function DivineTunTianNorView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
	end
end

function DivineTunTianNorView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local hasGet = false

	txtScore.text = data.progress

	MaterialMgr.setCellByCfg(data.prize, item)

	if self._info then
		local finishIds = checknumber(self._info.normalScore)
		local isCanGet = finishIds >= data.progress

		if not self._info.normalPrizeIds then
			local gainPrizeIds = {}

			hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false

			GameUtil.SetActive(geted, hasGet)
			GameUtil.SetActive(btnGet, isCanGet and not hasGet)
			self:_clearCellEffect(effect)

			if isCanGet and not hasGet then
				self:_playCellEffect(effect)
			end

			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
		end
	end
end

function DivineTunTianNorView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

function DivineTunTianNorView:_playCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)

	local eff = self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effGo, self._tableviewViewport.transform, true, nil, nil)
end

function DivineTunTianNorView:_clearCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)
end

function DivineTunTianNorView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyNor

	TipsFacade.instance:openRulesView(key)
end

function DivineTunTianNorView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.DivineTunTianBuffView, self._activityId)
end

function DivineTunTianNorView:_onClickGetPrize(data)
	if not self._info.normalPrizeIds then
		local gainPrizeIds = {}
		local hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false

		if not hasGet then
			local finishIds = checknumber(self._info.normalScore)
			local isCanGet = finishIds >= data.progress

			if isCanGet then
				DivineTunTianController.instance:sendPM_DivineTunTianClgGainNormalProgressPrizeReq(self._activityId, data.prizeId)
			else
				TipsFacade.instance:openCommonTips("还没达到条件哦~")
			end
		end
	end
end

return DivineTunTianNorView
