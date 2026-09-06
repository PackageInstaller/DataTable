-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/view/OriginGoldenDragonClgStageView.lua

module("logic.extensions.origingoldendragonclg.view.OriginGoldenDragonClgStageView", package.seeall)

local OriginGoldenDragonClgStageView = class("OriginGoldenDragonClgStageView", ViewComponent)

function OriginGoldenDragonClgStageView:ctor()
	OriginGoldenDragonClgStageView.super.ctor(self)
end

function OriginGoldenDragonClgStageView:unbindEvents()
	OriginGoldenDragonClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnClg)
end

function OriginGoldenDragonClgStageView:bindEvents()
	OriginGoldenDragonClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function OriginGoldenDragonClgStageView:buildUI()
	OriginGoldenDragonClgStageView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnReset = self:getGo("btnReset")
	self._btnClg = self:getGo("btnClg")
	self._txtScoreMax = self:getTxt("scoreMax/txt")
	self._txttitle_2 = self:getTxt("stageInfo/txttitle_2")
	self._cell = self:getGo("stage/cell")
	self._tableview = self:getGo("stage/tableview")

	local goCellStage = self:getGo("stage/cell")
	local goTabStage = self:getGo("stage/tableview")

	self._tableviewStage = ScrollerList.create(goTabStage, goCellStage, GameUtil.handler(self._updateCellStage, self), GameUtil.handler(self._clearCellStage, self))

	local fmtview = self:getGo("stageInfo/fmt")

	self._fmtCellList = {}

	for i = 1, 9 do
		local fmtCell = {}

		fmtCell.go = goutil.findChild(fmtview, "cell_" .. i)
		fmtCell.con = goutil.findChild(fmtCell.go, "con")

		table.insert(self._fmtCellList, fmtCell)
	end

	self._powerPetMo = FightingPowerPetMo.New()
end

function OriginGoldenDragonClgStageView:onExit()
	OriginGoldenDragonClgStageView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._tableviewStage:dispose()

	for _, fmtCell in ipairs(self._fmtCellList) do
		MaterialMgr.resetAll(fmtCell.con)
	end
end

function OriginGoldenDragonClgStageView:onEnter()
	OriginGoldenDragonClgStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginGoldenDragonClgGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_OriginGoldenDragonClgResetChallengeRes, self._handleResetInfo, self)

	self._curSelectStageId = 1
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = OriginGoldenDragonClgController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	OriginGoldenDragonClgController.instance:getInfo(self._activityId)

	self._curSelectStageId = 0
	self._firstEnter = true
end

function OriginGoldenDragonClgStageView:_updateUIByCfg()
	self._actCfg = OriginGoldenDragonClgConfig.instance:getActCfgByActId(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_updatePetInfo()

	self._stageCfgs = OriginGoldenDragonClgConfig.instance:getAllStageCfgsByActId(self._activityId) or {}

	local firstProCfg = OriginGoldenDragonClgConfig.instance:getProphecyCfgById(self._activityId, 1)

	if firstProCfg then
		self._baseScore = firstProCfg.baseScore or 0
	end
end

function OriginGoldenDragonClgStageView:_handleResetInfo()
	self:_updateUIByInfo()
	self:_switchShowStage(1, true)
end

function OriginGoldenDragonClgStageView:_updatePetInfo()
	self._curSkinId = self._actCfg.skinId or 0
	self._curRaceId = 0

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	if petSkinCfg then
		self._curRaceId = petSkinCfg.raceId or 0

		local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", self._curSkinId)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
	end
end

function OriginGoldenDragonClgStageView:_updateUIByInfo()
	self._curStageId = 0

	if not self._stageCfgs then
		return
	end

	if #self._stageCfgs == 0 then
		return
	end

	for _, cfg in ipairs(self._stageCfgs) do
		if not cfg.stageId then
			local stageInfo = OriginGoldenDragonClgModel.instance:getStageInfo(self._activityId, cfg.stageId) or {}

			if stageInfo.score and stageInfo.score > 0 then
				self._curStageId = cfg.stageId
			end
		end
	end

	if self._firstEnter then
		self._firstEnter = false

		local enterSelectId = Mathf.Min(self._curStageId + 1, #self._stageCfgs)

		self:_switchShowStage(enterSelectId, true)
	else
		self._curSelectStageId = self._curSelectStageId or 1

		self:_switchShowStage(self._curSelectStageId, true)
	end

	local showIndex = Mathf.Min(self._curSelectStageId - 1, #self._stageCfgs - 1)

	self._tableviewStage:MoveCellToBegin(showIndex)
end

function OriginGoldenDragonClgStageView:_switchShowStage(stageId, isForce)
	if isForce == true then
		self._curSelectStageId = nil
	end

	if self._curSelectStageId == stageId then
		return
	end

	self._curSelectStageId = stageId

	self._tableviewStage:reloadData(self._stageCfgs)

	local isCanClg = stageId == self._curStageId + 1

	goutil.setActive(self._btnClg, isCanClg)

	local preStageId = stageId - 1
	local rate = OriginGoldenDragonClgConfig.instance:getScoreRateByHitCount(self._activityId, preStageId)
	local scoreMax = self._baseScore * rate

	self._txtScoreMax.text = langPara("本关可得最高分数：%s", scoreMax)
	self._txttitle_2.text = langPara("第%s关敌阵预览", stageId)

	for i, fmtCell in ipairs(self._fmtCellList) do
		MaterialMgr.resetAll(fmtCell.con)
		goutil.setActive(fmtCell.go, false)
	end

	if not self._stageCfgs[stageId] then
		if not self._stageCfgs[stageId].creepsMasterId then
			local creepsMasterId = 0
			local creepCfgs = OriginGoldenDragonClgConfig.instance:getCreepCfgs(creepsMasterId) or {}

			for _, cfg in pairs(creepCfgs) do
				local posId = cfg.posId

				if posId < 1 or posId > 9 then
					-- block empty
				else
					local fmtCell = self._fmtCellList[posId]

					if fmtCell then
						goutil.setActive(fmtCell.go, true)
						self._powerPetMo:fromChallengeCreepCo(cfg)

						local petMo = self._powerPetMo:toBaseBagPetMo()
						local proxy = MaterialMgr.setCellByMo(petMo, fmtCell.con)

						if proxy then
							proxy.binder:setAutoTips(false)
							proxy:setCallBack(function()
								CommonTipsMgr.instance:showPetTips(petMo)
							end)
						end
					end
				end
			end
		end
	end
end

function OriginGoldenDragonClgStageView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function OriginGoldenDragonClgStageView:_updateCellStage(view, cell, data)
	local go = cell.gameObject

	if not data.stageId then
		local stageId = 0
		local stageInfo = OriginGoldenDragonClgModel.instance:getStageInfo(self._activityId, stageId) or {}

		if stageInfo then
			if not stageInfo.score then
				local score = 0

				if stageInfo then
					if not stageInfo.prophecyId then
						local prophecyId = 0
						local isPass = score > 0
						local isCurClgStage = self._curStageId + 1 == stageId
						local isTimeUnlock = true

						if not data.openTime then
							local openTimeStr = ""

							if not GameUtil.isEmptyString(openTimeStr) then
								local unlockTime = GameUtil.string2time(openTimeStr)

								isTimeUnlock = unlockTime <= ServerTime.now()
							end

							local isPreUnlock = stageId <= self._curStageId + 1
							local markSelect = goutil.findChild(go, "select")
							local btn = goutil.findChild(go, "btn")
							local txtStage = goutil.findChildTextComponent(go, "txtStage")
							local conLock = goutil.findChild(go, "lock")
							local conScore = goutil.findChild(go, "score")
							local txtScore = goutil.findChildTextComponent(conScore, "txt")
							local txtLock = goutil.findChildTextComponent(conLock, "txt")
							local txtType = goutil.findChildTextComponent(go, "txtType")

							GameUtil.addClickHandler(btn, GameUtil.handler(function()
								if self._curSelectStageId == stageId then
									return
								end

								if not isTimeUnlock then
									TipsFacade.instance:openCommonTips(lang("关卡未开放~"))

									return
								end

								if not isPreUnlock then
									TipsFacade.instance:openCommonTips(lang("请先完成前置关卡~"))

									return
								end

								self:_switchShowStage(stageId)
							end, self))

							txtStage.text = string.format("%02d", stageId)
							txtScore.text = langPara("获得积分：%s", score)

							goutil.setActive(conScore, isPass)
							goutil.setActive(markSelect, stageId == self._curSelectStageId)
							goutil.setActive(conLock, not isTimeUnlock or not isPreUnlock)

							if not isTimeUnlock then
								local unlockDate = GameUtil.string2date(openTimeStr)

								txtLock.text = langPara("%s.%s 5点后解锁", unlockDate.month, unlockDate.day)
							elseif not isPreUnlock then
								txtLock.text = lang("未解锁")
							end

							if isPass then
								local prophecyCfg = OriginGoldenDragonClgConfig.instance:getProphecyCfgById(self._activityId, prophecyId)

								if prophecyCfg then
									if not prophecyCfg.name then
										local prophecyName = ""

										txtType.text = langPara("预言类型：%s", prophecyName)
									end
								end
							else
								txtType.text = isCurClgStage and lang("预言类型：待选择") or ""
							end
						end
					end
				end
			end
		end
	end
end

function OriginGoldenDragonClgStageView:_clearCellStage(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function OriginGoldenDragonClgStageView:_onClickBtnReset()
	if self._curStageId == 0 then
		TipsFacade.instance:openCommonTips(lang("当前无须重置"))

		return
	end

	local tips = lang("是否重置所有挑战数据?")

	TipsFacade.instance:openPopupWindow(lang("提示"), tips, function()
		OriginGoldenDragonClgController.instance:resetChallenge(self._activityId)
	end)
end

function OriginGoldenDragonClgStageView:_onClickBtnClg()
	if self._curSelectStageId == 0 then
		TipsFacade.instance:openCommonTips(lang("请先选择关卡"))

		return
	end

	local isCanClg = self._curSelectStageId == self._curStageId + 1

	if not isCanClg then
		TipsFacade.instance:openCommonTips(lang("当前关卡无法挑战"))
		self:_switchShowStage(self._curSelectStageId, true)

		return
	end

	if not self._stageCfgs[self._curSelectStageId] then
		local stageCfg = {}

		if not stageCfg.openTime then
			local openTimeStr = ""

			if not GameUtil.isEmptyString(openTimeStr) then
				local unlockTime = GameUtil.string2time(openTimeStr)

				if unlockTime > ServerTime.now() then
					TipsFacade.instance:openCommonTips(lang("关卡未开放~"))

					return
				end
			end

			UIStateManager.instance:push(ViewName.OriginGoldenDragonClgSelectView, self._activityId, self._curSelectStageId, false)
		end
	end
end

return OriginGoldenDragonClgStageView
