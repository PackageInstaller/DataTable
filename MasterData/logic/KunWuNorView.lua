-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/view/KunWuNorView.lua

module("logic.extensions.kunwu.view.KunWuNorView", package.seeall)

local KunWuNorView = class("KunWuNorView", ViewComponent)

function KunWuNorView:buildUI()
	KunWuNorView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtBuffsGroup = self:getGo("buffs/txtBuffsGroup")
	self._txtBuffsList = {}
	self._spriteChangeList = {}

	for i = 1, 3 do
		local buff = self:getGo("buffs/buff" .. i)
		local curTxt = self:getTxt("buffs/buff" .. i .. "/txt")
		local imgBuffGo = self:getGo("buffs/buff" .. i .. "/imgBuff")
		local imgBuffChange = imgBuffGo:GetComponent(ComponentType.UIImageSpriteChange)

		table.insert(self._txtBuffsList, curTxt)
		table.insert(self._spriteChangeList, imgBuffChange)
	end

	self._challengeCellList = {}
	self._challengeCells = self:getGo("challengeCells")

	for i = 1, self._challengeCells.transform.childCount do
		local curCell = {}
		local curCellGo = goutil.findChild(self._challengeCells, "challengeCell" .. i)
		local curFmt = goutil.findChild(curCellGo, "stageFmt/fmt")

		curCell.go = curCellGo
		curCell.fmt = curFmt
		curCell.pass = goutil.findChild(curCellGo, "stageFmt/pass")
		curCell.btnChallenge = goutil.findChild(curCellGo, "btnChallenge")

		table.insert(self._challengeCellList, curCell)
	end

	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._tableview = self:getGo("scorollReward/tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("total/txtProgress")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
end

function KunWuNorView:bindEvents()
	KunWuNorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for idx, cell in ipairs(self._challengeCellList) do
		GameUtil.addClickHandler(cell.btnChallenge, GameUtil.handler(self._onClickBtnChallenge, self, idx))
	end
end

function KunWuNorView:unbindEvents()
	KunWuNorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for idx, cell in ipairs(self._challengeCellList) do
		GameUtil.rmClickHandler(cell.btnChallenge)
	end
end

function KunWuNorView:onEnter()
	KunWuNorView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_KunWuClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_KunWuClgGainProgressPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = KunWuController.instance:getActivityId()
	end

	self._info = KunWuModel.instance:getInfo(self._activityId)
	self._actCfg = KunWuConfig.instance:getKunWuActData(self._activityId)
	self._norStageCfg = KunWuConfig.instance:getKunWuNorStageData(self._activityId)
	self._norBuffCfg = KunWuConfig.instance:getKunWuNorBuffData(self._activityId)
	self._norProgressCfg = KunWuConfig.instance:getKunWuNorProgressData(self._activityId)

	local todayStageGroupId = KunWuModel.instance:getNormalClgTodayStageGroupId(self._activityId)

	self._creepsIds = self._norStageCfg[todayStageGroupId].teamIds

	self:_onSetUI()
	KunWuController.instance:sendPM_KunWuClgGetInfoReq(self._activityId)
end

function KunWuNorView:onExit()
	KunWuNorView.super.onExit(self)

	for i, cell in ipairs(self._challengeCellList) do
		self:_clearFmt(cell.fmt)
	end

	self._scrollList:dispose()
end

function KunWuNorView:_onSetUI()
	local todayStageGroupId = KunWuModel.instance:getNormalClgTodayStageGroupId(self._activityId)

	if todayStageGroupId ~= 0 and self._norStageCfg then
		local curBuffCfg = self._norBuffCfg[todayStageGroupId]
		local descStr = curBuffCfg.desc
		local descArr = string.split(descStr, "#")
		local buffStr = curBuffCfg.buffName
		local buffArr = string.split(buffStr, "#")

		for idx, word in ipairs(descArr) do
			self._txtBuffsList[idx].text = word
		end

		for idx, buffName in ipairs(buffArr) do
			local spriteIdx = GameEnum.Races[buffName]
			local spriteChange = self._spriteChangeList[idx]

			spriteChange:SetState(spriteIdx - 1)
		end
	end

	for idx, creepsId in ipairs(self._creepsIds) do
		local creepCfg = KunWuConfig.instance:getKunWuCreepsData(creepsId)
		local cell = self._challengeCellList[idx]

		if cell then
			self:_setFmt(cell.fmt, creepCfg)
		end
	end
end

function KunWuNorView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function KunWuNorView:_updateData()
	self._info = KunWuModel.instance:getInfo(self._activityId)
end

function KunWuNorView:_updateUI()
	for idx, cell in ipairs(self._challengeCellList) do
		if not self._info.normalClgDailyPassedTeamIndex then
			local passTeamIndexs = {}

			GameUtil.SetActive(cell.pass, table.indexof(passTeamIndexs, idx - 1))
		end
	end

	self._scrollList:reloadData(self._norProgressCfg)

	self._txtProgress.text = self._info.normalClgProgress

	local scoreList = {}

	for i, v in ipairs(self._norProgressCfg) do
		table.insert(scoreList, v.progress)
	end

	self._scrollList:updateUnderSlider(self._progressSlider, self._info.normalClgProgress, scoreList)
end

function KunWuNorView:_setFmt(fmtView, cfg)
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

function KunWuNorView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
	end
end

function KunWuNorView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local hasGet = false

	if not self._info.normalClgProgress then
		local finishIds = {}
		local isCanGet = finishIds >= data.progress

		if not self._info.normalClgGainedDataBitId then
			local gainPrizeIds = {}

			hasGet = table.indexof(gainPrizeIds, data.dataBitId) ~= false
			txtScore.text = data.progress

			MaterialMgr.setCellByCfg(data.prize, item)
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

function KunWuNorView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function KunWuNorView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("scorollReward/clip").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function KunWuNorView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function KunWuNorView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyNormal

	TipsFacade.instance:openRulesView(key)
end

function KunWuNorView:_onClickBtnChallenge(creepIdx)
	local isPassNor = KunWuController.instance:isPassNor(self._activityId)

	if isPassNor then
		FloatWordMgr.instance:show("挑战进度已达最大，无须进行挑战")

		return
	end

	if not self._info.normalClgDailyPassedTeamIndex then
		local teamIndexs = {}
		local curTeamIsPass = table.indexof(teamIndexs, creepIdx - 1)

		if curTeamIsPass then
			FloatWordMgr.instance:show("今日已通关该关卡，无需再次通关")

			return
		end

		KunWuController.instance:enterNorBattleClg(self._activityId, self._info.normalClgTodayStageGroupId, creepIdx)
	end
end

function KunWuNorView:_onClickGetPrize(data)
	if not self._info.normalClgGainedDataBitId then
		local gainPrizeIds = {}
		local hasGet = table.indexof(gainPrizeIds, data.dataBitId) ~= false

		if not hasGet then
			if not self._info.normalClgProgress then
				local finishIds = {}
				local isCanGet = finishIds >= data.progress

				if isCanGet then
					KunWuController.instance:sendPM_KunWuClgGainProgressPrizeReq(self._activityId, data.dataBitId)
				else
					TipsFacade.instance:openCommonTips("还没达到条件哦~")
				end
			end
		end
	end
end

return KunWuNorView
