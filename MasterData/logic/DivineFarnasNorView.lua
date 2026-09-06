-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasNorView.lua

module("logic.extensions.divinefarnas.view.DivineFarnasNorView", package.seeall)

local DivineFarnasNorView = class("DivineFarnasNorView", ViewComponent)

function DivineFarnasNorView:ctor()
	DivineFarnasNorView.super.ctor(self)
end

function DivineFarnasNorView:unbindEvents()
	DivineFarnasNorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineFarnasNorView:bindEvents()
	DivineFarnasNorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DivineFarnasNorView:buildUI()
	DivineFarnasNorView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
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

function DivineFarnasNorView:onExit()
	DivineFarnasNorView.super.onExit(self)
	self._scrollList:dispose()
	self:clearStageUI()
end

function DivineFarnasNorView:onEnter()
	DivineFarnasNorView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineFarnasClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DivineFarnasClgGainPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 522001
	end

	self._actCfg = DivineFarnasConfig.instance:getActCfg(self._activityId)
	self._groupId = DivineFarnasController.instance:getNorStageGroupId(self._activityId)
	self._rewardCfgs = DivineFarnasConfig.instance:getNorPrizeCfgs(self._activityId)

	self:_onSetUI()
	DivineFarnasController.instance:sendPM_DivineFarnasClgGetInfoReq(self._activityId)
end

function DivineFarnasNorView:_onSetUI()
	self._txtRule.text = self._actCfg.ruleDescNor

	self._scrollList:reloadData(self._rewardCfgs)
end

function DivineFarnasNorView:_onUpdate()
	self._info = DivineFarnasModel.instance:getInfo(self._activityId)
	self._txtProgress.text = checknumber(self._info.totalDodgeTimes)

	self._scrollList:reloadData(self._rewardCfgs)

	local scoreList = {}

	for i, v in ipairs(self._rewardCfgs) do
		table.insert(scoreList, v.dodgeTimes)
	end

	local totalScore = checknumber(self._info.totalDodgeTimes)

	self._scrollList:updateUnderSlider(self._progressSlider, totalScore, scoreList)
	self:_updateStageUI()
end

function DivineFarnasNorView:_updateStageUI()
	for i, stageGo in ipairs(self._stageList) do
		local pass = goutil.findChild(stageGo, "stageFmt/pass")
		local fmt = goutil.findChild(stageGo, "stageFmt/fmt")
		local btnChallenge = goutil.findChild(stageGo, "btnChallenge")
		local txtTrans = goutil.findChildTextComponent(stageGo, "txtTrans")
		local norStageCfg = DivineFarnasConfig.instance:getFmtCfg(self._activityId, self._groupId, i)

		txtTrans.text = string.format("今日最多闪避次数：%d", (self._info.normalStages and self._info.normalStages[i] or nil) and checknumber(self._info.normalStages[i].todayMaxDodgeTimes))

		self:_setFmt(fmt, norStageCfg)
		GameUtil.addClickHandler(btnChallenge, function()
			DivineFarnasController.instance:enterBattleClgNor(self._activityId, i)
		end, self)
	end
end

function DivineFarnasNorView:clearStageUI()
	for i, stageGo in ipairs(self._stageList) do
		local btnChallenge = goutil.findChild(stageGo, "btnChallenge")
		local fmt = goutil.findChild(stageGo, "stageFmt/fmt")

		GameUtil.rmClickHandler(btnChallenge)
		self:_clearFmt(fmt)
	end
end

function DivineFarnasNorView:_setFmt(fmtView, cfg)
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

function DivineFarnasNorView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
	end
end

function DivineFarnasNorView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local hasGet = false

	txtScore.text = data.dodgeTimes

	MaterialMgr.setCellByCfg(data.prize, item)

	if self._info then
		local finishIds = checknumber(self._info.totalDodgeTimes)
		local isCanGet = finishIds >= data.dodgeTimes

		if not self._info.gainNormalPrizeIds then
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

function DivineFarnasNorView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

function DivineFarnasNorView:_playCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)

	local eff = self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effGo, self._tableviewViewport.transform, true, nil, nil)
end

function DivineFarnasNorView:_clearCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)
end

function DivineFarnasNorView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyNor

	TipsFacade.instance:openRulesView(key)
end

function DivineFarnasNorView:_onClickGetPrize(data)
	if not self._info.gainNormalPrizeIds then
		local gainPrizeIds = {}
		local hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false

		if not hasGet then
			local finishIds = checknumber(self._info.totalDodgeTimes)
			local isCanGet = finishIds >= data.dodgeTimes

			if isCanGet then
				DivineFarnasController.instance:sendPM_DivineFarnasClgGainPrizeReq(self._activityId, data.prizeId)
			else
				TipsFacade.instance:openCommonTips("还没达到条件哦~")
			end
		end
	end
end

return DivineFarnasNorView
