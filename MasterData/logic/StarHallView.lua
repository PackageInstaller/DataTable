-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/view/StarHallView.lua

module("logic.extensions.starhall.view.StarHallView", package.seeall)

local StarHallView = class("StarHallView", ViewComponent)

function StarHallView:ctor()
	StarHallView.super.ctor(self)
end

function StarHallView:unbindEvents()
	StarHallView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJumpRank)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnEnter)
end

function StarHallView:bindEvents()
	StarHallView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJumpRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickFight, self)
end

function StarHallView:buildUI()
	StarHallView.super.buildUI(self)

	self._powerPetMo = FightingPowerPetMo.New()
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnEnter = self:getGo("stageInfo/btnEnter")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtLvBuff = self:getTxt("buffCol/Lv/txt")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._rdGainBuff = self:getGo("buffCol/cell/rd")
	self._btnJumpRank = self:getGo("btnJumpRank")
	self._con = self:getGo("con")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnReset = self:getGo("stageInfo/btnReset")

	local tableviewGo = self:getGo("stagelist/tableview")
	local cellGo = self:getGo("stagelist/cell")

	self._tableviewStage = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updatCellStage, self), GameUtil.handler(self._clearCellStage, self))
	self._fmtView = self:getGo("stageInfo/fmt/fmtView")
	self._txtBestTotalScore = self:getTxt("txtBestTotalScore")
	self._txtCurTotalScore = self:getTxt("txtCurTotalScore")
	self._titleStage = self:getTxt("stageInfo/titleStage")
end

function StarHallView:onExit()
	StarHallView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	local childCount = self._fmtView.transform.childCount

	for posId = 1, childCount do
		local fmtCellGo = self._fmtView.transform.transform:GetChild(posId - 1)
		local fmtIcon = goutil.findChild(fmtCellGo, "icon")

		MaterialMgr.resetAll(fmtIcon)
	end

	self:_saveLastStageId()

	self._curStageId = nil

	self._tableviewStage:dispose()
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function StarHallView:onEnter()
	StarHallView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 494001
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._curStageInfoMap = {}

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.StarHallGetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.StarHallResetStage, self._updateUIByInfo, self)
	StarHallController.instance:getInfo(self._activityId)

	if self._activityId > 0 then
		SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
			self:_updateBuffUI(param)
		end)
	end

	self:_switchStage(self:_getLastStageId())
	StarHallController.instance:showCI()
end

function StarHallView:_getLastStageId()
	local key = string.format("StarHallView_LastStageId_%s", self._activityId)
	local value = checknumber(GameUtil.getUserData(key))

	return value > 0 and value or 1
end

function StarHallView:_saveLastStageId()
	if self._activityId > 0 then
		local key = string.format("StarHallView_LastStageId_%s", self._activityId)

		GameUtil.saveUserData(key, self._curStageId)
	end
end

function StarHallView:_updateUIByCfg()
	self._actCfg = StarHallConfig.instance:getActCfgById(self._activityId)
	self._stageCfgs = StarHallConfig.instance:getStageCfgsById(self._activityId)
	self._settlementCfgs = StarHallConfig.instance:getSettlementCfgsById(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	if self._actCfg then
		if not self._actCfg.skinId then
			local skinId = 0

			self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
		end
	end
end

function StarHallView:_updateUIByInfo()
	local info = StarHallModel.instance:getBaseInfo(self._activityId)

	if info then
		self._txtCurTotalScore.text = string.format("当前总积分：%s", StarHallModel.instance:getCurTotalSocre(self._activityId))
		self._txtBestTotalScore.text = string.format("历史最高积分：%s", info.bestTotalScore)
		self._curStageInfoMap = StarHallModel.instance:getCurStageInfoMap(self._activityId)

		self:_updateStageInfo()
	end
end

function StarHallView:_updateBuffUI(param)
	goutil.setActive(self._rdGainBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	self._txtLvBuff.text = string.format("Lv.%s", param.buffLevel)

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

function StarHallView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function StarHallView:_onClickBtnRank()
	if self._activityId == 494001 then
		UIStateManager.instance:push(ViewName.FinalEchoRankMainView, 1)
	elseif self._activityId == 494002 then
		UIStateManager.instance:push(ViewName.FinalEchoRankMainView, 2)
	end
end

function StarHallView:_updatCellStage(view, cell, data)
	local select = goutil.findChild(cell.gameObject, "select")
	local lock = goutil.findChild(cell.gameObject, "lock")
	local txtLock = goutil.findChildTextComponent(lock, "txt")
	local txtStage = goutil.findChildTextComponent(cell.gameObject, "txt")
	local btn = goutil.findChild(cell.gameObject, "btn")
	local score = goutil.findChild(cell.gameObject, "score")
	local txtScore = goutil.findChildTextComponent(score, "txt")
	local txtSettle = goutil.findChildTextComponent(cell.gameObject, "txtSettle")
	local txtDiff = goutil.findChildTextComponent(cell.gameObject, "txtDiff")
	local txtNumber = goutil.findChildTextComponent(cell.gameObject, "txtNumber")

	goutil.setActive(select, data.stageId == self._curStageId)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickStage, self, data))

	txtStage.text = string.format("第%s关", data.stageId)

	local timeStamp = GameUtil.string2time(data.openTime)
	local timeDate = GameUtil.string2date(data.openTime)

	txtLock.text = string.format("%02d.%02d 5点后解锁", timeDate.month, timeDate.day)

	local isLock = timeStamp >= ServerTime.now()

	goutil.setActive(lock, isLock)
	goutil.setActive(score, not isLock)
	goutil.setActive(txtNumber.gameObject, not isLock)
	goutil.setActive(txtSettle.gameObject, not isLock)
	goutil.setActive(txtDiff.gameObject, not isLock)

	local info = self._curStageInfoMap[data.stageId]

	if info then
		txtDiff.text = info.difficultId == -1 and "星级难度：待挑战" or string.format("星级难度：%s星", info.difficultId)

		if info.settlementId ~= -1 then
			txtNumber.text = string.format("目标：%s", info.number)

			local settleCfg = self._settlementCfgs[info.settlementId]

			txtSettle.text = string.format("结算方式：%s", settleCfg.typeName)
		else
			txtSettle.text = "结算：待挑战"
			txtNumber.text = "目标：待挑战"
		end

		txtScore.text = StarHallModel.instance:getScoreByStage(self._activityId, data.stageId)
	else
		txtSettle.text = "结算方式：待挑战"
		txtDiff.text = "星级难度：待挑战"
		txtNumber.text = "投注点数：待挑战"
		txtScore.text = 0
	end
end

function StarHallView:_clearCellStage(cell)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)
end

function StarHallView:_switchStage(stageId)
	self._curStageId = stageId

	self:_updateStageInfo()
end

function StarHallView:_updateStageInfo()
	if self._curStageId then
		self._titleStage.text = string.format("第%s关敌阵预览", GameUtil.getChineseNumber(self._curStageId))

		self._tableviewStage:reloadData(self._stageCfgs)
		self._tableviewStage:MoveCellToBegin(self._curStageId - 1)

		local childCount = self._fmtView.transform.childCount

		for posId = 1, childCount do
			local fmtCellGo = self._fmtView.transform.transform:GetChild(posId - 1)
			local fmtIcon = goutil.findChild(fmtCellGo, "icon")

			MaterialMgr.resetAll(fmtIcon)
		end

		local difficultyCfgs = StarHallConfig.instance:getStageDifficultyCfgsById(self._activityId, self._curStageId) or {}

		if difficultyCfgs[1] then
			local creepsMasterId = difficultyCfgs[1].creepsMasterId
			local creepCfgs = StarHallConfig.instance:getCreepCfgs(creepsMasterId) or {}

			for _, cfg in pairs(creepCfgs) do
				local posId = cfg.posId

				if posId < 1 or posId > 9 then
					-- block empty
				else
					local fmtCellGo = self._fmtView.transform:GetChild(posId - 1)

					if fmtCellGo then
						local fmtIcon = goutil.findChild(fmtCellGo, "icon")

						self._powerPetMo:fromChallengeCreepCo(cfg)

						local bagPetMo = self._powerPetMo:toBaseBagPetMo()
						local proxy = MaterialMgr.setCellByMo(bagPetMo, fmtIcon)

						if proxy then
							proxy.binder:setAutoTips(false)
							proxy:setCallBack(function()
								CommonTipsMgr.instance:showPetTips(bagPetMo)
							end)
						end
					end
				end
			end
		end
	end
end

function StarHallView:_onClickStage(cfg)
	local timeStamp = GameUtil.string2time(cfg.openTime)

	if timeStamp >= ServerTime.now() then
		local timeDate = GameUtil.string2date(cfg.openTime)

		FloatWordMgr.instance:show(string.format("%02d.%02d 5点后开启", timeDate.month, timeDate.day))

		return
	end

	self:_switchStage(cfg.stageId)
end

function StarHallView:_onClickFight()
	if self._curStageId then
		StarHallController.instance:openMissionview(self._activityId, self._curStageId)
	end
end

function StarHallView:_onClickReset()
	if self._curStageId then
		TipsFacade.instance:openPopupWindow("提示", "是否重置当前关卡数据?", function()
			StarHallController.instance:resetStage(self._activityId, self._curStageId)
		end)
	end
end

return StarHallView
