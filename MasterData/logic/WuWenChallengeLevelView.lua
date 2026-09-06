-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/WuWenChallengeLevelView.lua

module("logic.extensions.wuwenchallenge.view.WuWenChallengeLevelView", package.seeall)

local WuWenChallengeLevelView = class("WuWenChallengeLevelView", ViewComponent)

function WuWenChallengeLevelView:ctor()
	WuWenChallengeLevelView.super.ctor(self)
end

function WuWenChallengeLevelView:unbindEvents()
	WuWenChallengeLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReset)
end

function WuWenChallengeLevelView:bindEvents()
	WuWenChallengeLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function WuWenChallengeLevelView:buildUI()
	WuWenChallengeLevelView.super.buildUI(self)

	self._btnChallenge = self:getGo("btnChallenge")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._levelTableView = self:getGo("levelTableView")
	self._levelTableCell = self:getGo("levelTableCell")
	self._stageTableView = self:getGo("stageTableView")
	self._stageTableCell = self:getGo("stageTableCell")
	self._buffTableView = self:getGo("buffTableView")
	self._buffTableCell = self:getGo("buffTableCell")
	self._txtSurvive = self:getTxt("txtSurvive")
	self._btnReset = self:getGo("btnReset")
	self._teamEnemy = self:getGo("teamEnemy")
	self._enemyList = {}

	for i = 1, 9 do
		self._enemyList[i] = {
			go = goutil.findChild(self._teamEnemy, "cell_" .. i),
			con = goutil.findChild(self._teamEnemy, "cell_" .. i .. "/icon")
		}
	end

	self._levelTableList = ScrollerList.create(self._levelTableView, self._levelTableCell, GameUtil.handler(self._updateLevelCell, self), GameUtil.handler(self._clearLevelCell, self))
	self._stageTableList = ScrollerList.create(self._stageTableView, self._stageTableCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._buffTableList = ScrollerList.create(self._buffTableView, self._buffTableCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function WuWenChallengeLevelView:onExit()
	WuWenChallengeLevelView.super.onExit(self)
end

function WuWenChallengeLevelView:onEnter()
	WuWenChallengeLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.WuWenClgRefresh, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_WuWenClgFightConfirmRes, self._PM_WuWenClgFightConfirmRes, self)

	local param = self:getOpenParam()

	self._activityId = self:getFirstParam()
	self._buffList = {}
	self._curLevel = WuWenChallengeModel.instance:getCurLevel(self._activityId)

	local levelCfg = WuWenChallengeConfig.instance:getPhaseCfg(self._activityId, self._curLevel)

	if ServerTime.now() < GameUtil.string2time(levelCfg.openTime) then
		for i, v in ipairs(WuWenChallengeConfig.instance:getPhaseCfgs(self._activityId)) do
			if ServerTime.now() >= GameUtil.string2time(v.openTime) then
				self._curLevel = v.phaseId
			end
		end
	end

	local stage = WuWenChallengeController.instance:getOnceStageId()

	if stage then
		self._curStage = stage
	else
		self._curStage = self._curStage or 1

		if self._curLevel == WuWenChallengeModel.instance:getCurLevel(self._activityId) and WuWenChallengeModel.instance:getStagePass(self._activityId, self._curStage) == true then
			local cfg = WuWenChallengeConfig.instance:getStageCfgs(self._activityId, self._curLevel) or {}

			for i, v in ipairs(cfg) do
				if not WuWenChallengeModel.instance:getStagePass(self._activityId, v.stageId) then
					self._curStage = v.stageId

					break
				end
			end
		end
	end

	WuWenClgAgent.instance:sendPM_WuWenClgGetInfoReq(self._activityId)

	if WuWenChallengeModel.instance:getFightInfo(self._activityId) then
		UIStateManager.instance:push(ViewName.WuWenChallengeResultView, self._activityId)
	end
end

function WuWenChallengeLevelView:_refreshView()
	local stageCfg = WuWenChallengeConfig.instance:getStageCfg(self._activityId, self._curLevel, self._curStage)
	local creepCfg = WuWenChallengeConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end

	for i, v in ipairs(creepCfg) do
		if self._enemyList[v.posId] then
			GameUtil.setLocalScale(self._enemyList[v.posId].con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, self._enemyList[v.posId].con)

			if proxy then
				proxy.binder:setAutoTips(false)
			end

			GameUtil.SetActive(self._enemyList[v.posId].go, true)
		end
	end

	self._levelTableList:reloadData(WuWenChallengeConfig.instance:getPhaseCfgs(self._activityId))
	self._stageTableList:reloadData(WuWenChallengeConfig.instance:getStageCfgs(self._activityId, self._curLevel))

	local levelCfg = WuWenChallengeConfig.instance:getPhaseCfg(self._activityId, self._curLevel)
	local buffList = WuWenChallengeConfig.instance:getBuffCfgs(levelCfg.buffPlanId)

	self._buffTableList:reloadData(buffList)

	if self._curLevel < WuWenChallengeModel.instance:getCurLevel(self._activityId) then
		self._txtSurvive.text = lang("已通关")

		GameUtil.SetActive(self._btnChallenge, false)
	else
		self._txtSurvive.text = string.format("%s挑战累计存活：<color=%s>%d</color>/%d", levelCfg.name, self:getSurviveColor(), WuWenChallengeModel.instance:getAlivePetCount(self._activityId), levelCfg.petAliveLimit)

		GameUtil.SetActive(self._btnChallenge, not WuWenChallengeModel.instance:getStagePass(self._activityId, self._curStage))
	end
end

function WuWenChallengeLevelView:_updateLevelCell(view, cell, data, tag)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "btnClick")
	local changeImage = goutil.findChildComponent(go, "btnClick", "UIImageSpriteChange")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local bubble = goutil.findChild(go, "bubble")
	local txtBubble = goutil.findChildTextComponent(go, "bubble/txt")
	local prizeCon = goutil.findChild(go, "bubble/con")
	local lock = goutil.findChild(go, "lock")
	local txtName = goutil.findChildTextComponent(btnClick, "txt")
	local passLevel = WuWenChallengeModel.instance:getCurLevel(self._activityId)

	txtName.text = data.name

	if changeImage then
		changeImage:SetState(self._curLevel == data.phaseId and 1 or 0)
	end

	GameUtil.SetActive(imgSelect, self._curLevel == data.phaseId)
	GameUtil.SetActive(lock, passLevel < data.phaseId or ServerTime.now() < GameUtil.string2time(data.openTime))
	GameUtil.SetActive(bubble, data.phaseId == passLevel and self._curLevel == data.phaseId)

	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)

	MaterialMgr.setCellByCfg(data.prize, prizeCon)

	txtBubble.text = langPara("通关后可获得%s*%d", MaterialMgr.getMaterialsName(matType, matId), matNum)

	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickLevel(data.phaseId)
	end, self)
end

function WuWenChallengeLevelView:_clearLevelCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "btnClick")
	local prizeCon = goutil.findChild(go, "bubble/con")

	MaterialMgr.setCellByCfg(data.prize, prizeCon)
	GameUtil.rmClickHandler(btnClick)
end

function WuWenChallengeLevelView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local imgPass = goutil.findChild(go, "imgPass")
	local txtStage = goutil.findChildTextComponent(go, "txtStage")

	txtStage.text = langPara("第%d关", data.stageId)

	GameUtil.SetActive(imgSelect, data.stageId == self._curStage)
	GameUtil.SetActive(imgPass, self._curLevel < WuWenChallengeModel.instance:getCurLevel(self._activityId) or WuWenChallengeModel.instance:getStagePass(self._activityId, data.stageId))
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickStage(data.stageId)
	end, self)
end

function WuWenChallengeLevelView:_clearStageCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function WuWenChallengeLevelView:_updateBuffCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgSelect = goutil.findChild(go, "imgSelect")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtIndex = goutil.findChildTextComponent(go, "txtIndex")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")

	GameUtil.SetGray(go, not self._buffList[data.buffId])

	txtDesc.text = data.desc
	txtIndex.text = data.buffId
	txtNum.text = self._curLevel < WuWenChallengeModel.instance:getCurLevel(self._activityId) and 0 or data.useCount - WuWenChallengeModel.instance:getBuffUseCount(self._activityId, data.buffId)

	GameUtil.SetActive(imgSelect, self._buffList[data.buffId])
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickBuff(data.buffId)
	end, self)
end

function WuWenChallengeLevelView:_clearBuffCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function WuWenChallengeLevelView:_resetBuff()
	self._buffList = {}
end

function WuWenChallengeLevelView:_onClickLevel(level)
	if level == self._curLevel then
		return
	end

	local levelCfg = WuWenChallengeConfig.instance:getPhaseCfg(self._activityId, level)

	if level > WuWenChallengeModel.instance:getCurLevel(self._activityId) then
		FloatWordMgr.instance:show(lang("请先通关前面的关卡"))

		return
	elseif ServerTime.now() < GameUtil.string2time(levelCfg.openTime) then
		local openDate = GameUtil.string2date(levelCfg.openTime)

		FloatWordMgr.instance:show(langPara("关卡开启时间为%d.%d %d:%02d", openDate.month, openDate.day, openDate.hour, openDate.min))

		return
	elseif level < WuWenChallengeModel.instance:getCurLevel(self._activityId) then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	else
		self._curLevel = level
		self._curStage = 1

		if WuWenChallengeModel.instance:getStagePass(self._activityId, self._curStage) == true then
			for i, v in ipairs(WuWenChallengeConfig.instance:getStageCfgs(self._activityId, self._curLevel)) do
				if not WuWenChallengeModel.instance:getStagePass(self._activityId, v.stageId) then
					self._curStage = v.stageId

					break
				end
			end
		end

		self:_resetBuff()
		self:_refreshView()
	end
end

function WuWenChallengeLevelView:_onClickStage(stageId)
	if self._curStage == stageId then
		return
	end

	self._curStage = stageId

	self:_resetBuff()
	self:_refreshView()
end

function WuWenChallengeLevelView:_onClickBuff(buffId)
	if WuWenChallengeModel.instance:getCurLevel(self._activityId) > self._curLevel then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	local cfg = WuWenChallengeConfig.instance:getBuffCfg(self._activityId, self._curLevel, buffId)

	if self._buffList[buffId] then
		self._buffList[buffId] = nil
	elseif cfg.useCount - WuWenChallengeModel.instance:getBuffUseCount(self._activityId, buffId) > 0 then
		self._buffList[buffId] = true
	else
		FloatWordMgr.instance:show(lang("已无可选次数"))

		return
	end

	self:_refreshView()
end

function WuWenChallengeLevelView:_onClickChallenge()
	WuWenChallengeController.instance:openMissionView(self._activityId, self._curLevel, self._curStage, self._buffList)
end

function WuWenChallengeLevelView:_onClickReset()
	if WuWenChallengeModel.instance:getAlivePetCount(self._activityId) > 0 then
		UIStateManager.instance:push(self:getCurResetViewName(), self._activityId, self._curLevel)
	else
		FloatWordMgr.instance:show(lang("请先通关任意关卡"))
	end
end

function WuWenChallengeLevelView:_PM_WuWenClgFightConfirmRes(isPassLevel)
	if isPassLevel == true then
		local curPassLevel = WuWenChallengeModel.instance:getCurLevel(self._activityId)
		local levelCfg = WuWenChallengeConfig.instance:getPhaseCfg(self._activityId, curPassLevel)

		if levelCfg then
			if ServerTime.now() < GameUtil.string2time(levelCfg.openTime) then
				self:_resetBuff()
				self:_refreshView()
			else
				self:_onClickLevel(curPassLevel)
			end
		else
			FloatWordMgr.instance:show(lang("已通关全部关卡"))
			self:close()

			return
		end
	else
		if WuWenChallengeModel.instance:getStagePass(self._activityId, self._curStage) == true then
			for i, v in ipairs(WuWenChallengeConfig.instance:getStageCfgs(self._activityId, self._curLevel)) do
				if not WuWenChallengeModel.instance:getStagePass(self._activityId, v.stageId) then
					self._curStage = v.stageId

					break
				end
			end
		end

		self:_resetBuff()
		self:_refreshView()
	end
end

function WuWenChallengeLevelView:getSurviveColor()
	return "#FCFD9BFF"
end

function WuWenChallengeLevelView:getCurResetViewName()
	return ViewName.WuWenChallengeResetView
end

return WuWenChallengeLevelView
