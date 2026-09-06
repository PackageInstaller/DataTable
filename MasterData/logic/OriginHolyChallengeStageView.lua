-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originholychallenge/view/OriginHolyChallengeStageView.lua

module("logic.extensions.originholychallenge.view.OriginHolyChallengeStageView", package.seeall)

local OriginHolyChallengeStageView = class("OriginHolyChallengeStageView", ViewComponent)

function OriginHolyChallengeStageView:ctor()
	OriginHolyChallengeStageView.super.ctor(self)

	self._enemyBuffCellColorConfig = {
		[1] = "#475C78B2",
		[2] = "#3F6067B2"
	}
	self._powerPetMo = FightingPowerPetMo.New()
end

function OriginHolyChallengeStageView:unbindEvents()
	OriginHolyChallengeStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginHolyChallengeStageView:bindEvents()
	OriginHolyChallengeStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function OriginHolyChallengeStageView:buildUI()
	OriginHolyChallengeStageView.super.buildUI(self)

	self._btnChallenge = self:getGo("info/btnChallenge")
	self._txtDesc = self:getTxt("info/desc/viewport/txtDesc")
	self._enemyBuffTableView = self:getGo("info/enemyBuffTableView")
	self._enemyBuffTableCell = self:getGo("info/enemyBuffTableView/enemyBuffTableCell")
	self._levelTableView = self:getGo("levelTableView")
	self._levelTableCell = self:getGo("levelTableView/levelTableCell")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtOpenTime = self:getTxt("info/imgTip/txtOpenTime")
	self._teamEnemy = self:getGo("info/teamEnemy")
	self._enemyList = {}

	for i = 1, 9 do
		self._enemyList[i] = {
			go = goutil.findChild(self._teamEnemy, "cell_" .. i),
			con = goutil.findChild(self._teamEnemy, "cell_" .. i)
		}
	end

	self._enemyBuffTableList = ScrollerList.create(self._enemyBuffTableView, self._enemyBuffTableCell, GameUtil.handler(self._updateEnemyBuffTableCell, self), GameUtil.handler(self._clearEnemyBuffTableCell, self))

	self._enemyBuffTableList:setCenterMode(true)

	self._levelTableList = ScrollerList.create(self._levelTableView, self._levelTableCell, GameUtil.handler(self._updateLevelTableCell, self), GameUtil.handler(self._clearLevelTableCell, self))
	self._imgTip = self:getGo("info/imgTip")
end

function OriginHolyChallengeStageView:onExit()
	OriginHolyChallengeStageView.super.onExit(self)
	self._enemyBuffTableList:dispose()
	self._levelTableList:dispose()

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end
end

function OriginHolyChallengeStageView:onEnter()
	OriginHolyChallengeStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginHolyChallengeGetInfoRes, self._refreshStageProgress, self)
	self.addGEvent(self, GlobalNotify.PM_Notify_OriginHolyChallengeChallengeResultRes, self._refreshStageProgress, self)

	self._activityId = checknumber(self:getFirstParam())

	OriginHolyChallengeController.instance:sendInfoReq(self._activityId)
	self._levelTableList:regValueChanged(function(view)
		self:_onUpdatePosition(view)
	end)
	self:_initView()
	self:_refreshView()
end

function OriginHolyChallengeStageView:_initView()
	self._actCfg = OriginHolyChallengeConfig.instance:getActivity(self._activityId)
	self._stageCfgs = OriginHolyChallengeConfig.instance:getStages(self._activityId) or {}
	self._curStageId = OriginHolyChallengeModel.instance:getPassStage(self._activityId)

	if checknumber(self._curStageId) > 0 then
		if #self._stageCfgs > self._curStageId then
			self._curStageId = self._curStageId + 1
		end
	else
		self._curStageId = 1
	end

	self._firstEnter = true
end

function OriginHolyChallengeStageView:_refreshView()
	self._levelTableList:reloadData(self._stageCfgs)

	if self._firstEnter then
		self._levelTableList:MoveCellToCenter(math.max(self._curStageId - 1, 0))
	end

	local curCfg = self._stageCfgs[self._curStageId]

	if not curCfg then
		return
	end

	self._txtDesc.text = curCfg.desc or ""

	self:_refreshOpenTime(curCfg)
	self:_refreshChallengeBtnState(curCfg)

	local creepsCfg = OriginHolyChallengeConfig.instance:getCreeps(curCfg.creepsMasterId) or {}

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
		GameUtil.setLocalScale(self._enemyList[i].go, 0.67, 0.67, 1)
	end

	for _, v in ipairs(creepsCfg) do
		if self._enemyList[v.posId] then
			self._powerPetMo:fromChallengeCreepCo(v, creepsCfg)

			local bagPetMo = self._powerPetMo:toBaseBagPetMo()
			local proxy = MaterialMgr.setCellByMo(bagPetMo, self._enemyList[v.posId].con)

			if proxy then
				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					CommonTipsMgr.instance:showPetTips(bagPetMo)
				end)
			end

			GameUtil.SetActive(self._enemyList[v.posId].go, true)
		end
	end

	local buffList = OriginHolyChallengeConfig.instance:getBuff(curCfg.planId) or {}

	self._enemyBuffTableList:reloadData(buffList)

	self._firstEnter = false
end

function OriginHolyChallengeStageView:_onUpdatePosition(tableView)
	local count = tableView:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			cell.transform:SetSiblingIndex(cell.index)
		end
	end
end

function OriginHolyChallengeStageView:_refreshChallengeBtnState(cfg)
	local isOpen = self:_isStageOpen(cfg)

	GameUtil.SetGray(self._btnChallenge, not isOpen)

	GameUtil.asBtn(self._btnChallenge).enabled = isOpen
end

function OriginHolyChallengeStageView:_updateCell(cell, data)
	if not cell.gameObject then
		local go = cell
		local enemyIcon = goutil.findChild(go, "enemyIcon")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local lockGo = goutil.findChild(go, "imgLocked")
		local bg1 = goutil.findChild(go, "bg1")
		local btnClick = goutil.findChild(go, "btnClick")
		local passGo = goutil.findChild(go, "passGo")
		local line = goutil.findChild(go, "line")
		local cfg = data.cfg

		GameUtil.setAnchoredPos(go, cfg.nodePos[1], cfg.nodePos[2])

		local isLastStage = data.index == #self._stageCfgs

		GameUtil.SetActive(line, not isLastStage)

		if not isLastStage then
			GameUtil.setAnchoredPos(line, cfg.linePos[1], cfg.linePos[2])
			GameUtil.setLocalScale(line, 1, 0.4, 1)
			GameUtil.setLocalRotation(line, 0, 0, cfg.lineRotation)
		end

		txtName.text = langPara("第<size=30>%d</size>关", cfg.stageId)

		if cfg.enemyRaceId then
			MaterialMgr.resetAll(enemyIcon)
			MaterialMgr.setIcon(enemyIcon, MatType.Pet, cfg.enemyRaceId)
		end

		GameUtil.rmClickHandler(btnClick)
		GameUtil.addClickHandler(btnClick, function()
			self:_onClickStage(cfg.stageId)
		end)

		local passStage = OriginHolyChallengeModel.instance:getPassStage(self._activityId)
		local isReachLevel = passStage + 1 >= cfg.stageId
		local isOpen = self:_isStageOpen(cfg)
		local isLock = not isReachLevel or not isOpen

		GameUtil.SetActive(lockGo, isLock)
		GameUtil.SetActive(bg1, not isLock and cfg.stageId == self._curStageId)
		GameUtil.SetActive(passGo, passStage >= cfg.stageId)
	end
end

function OriginHolyChallengeStageView:_isStageOpen(cfg)
	if not cfg or GameUtil.isEmptyString(cfg.openTime) then
		return true
	end

	return ServerTime.now() >= GameUtil.string2time(cfg.openTime)
end

function OriginHolyChallengeStageView:_refreshOpenTime(cfg)
	local isOpen = self:_isStageOpen(cfg)

	GameUtil.SetActive(self._imgTip.gameObject, not isOpen)

	if not isOpen then
		self._txtOpenTime.text = GameUtil.formatTimeString(lang("%Y.%m.%d %H:%M开启"), cfg.openTime)
	end
end

function OriginHolyChallengeStageView:_showStageOpenTips(cfg)
	FloatWordMgr.instance:show(GameUtil.formatTimeString(lang("%Y.%m.%d %H:%M开启"), cfg.openTime))
end

function OriginHolyChallengeStageView:_clearCell(cell)
	if not cell.gameObject then
		local go = cell
		local btnClick = goutil.findChild(go, "btnClick")

		GameUtil.rmClickHandler(btnClick)

		local enemyIcon = goutil.findChild(go, "enemyIcon")

		MaterialMgr.resetAll(enemyIcon)
	end
end

function OriginHolyChallengeStageView:_updateEnemyBuffTableCell(view, cell, data, tag)
	local bg = goutil.findChild(cell.gameObject, "bg")
	local txtEnemyLiveCount = goutil.findChildTextComponent(cell.gameObject, "txtEnemyLiveCount")
	local txtEnemyBuffIntro = goutil.findChildTextComponent(cell.gameObject, "txtEnemyBuffIntro")
	local image = bg:GetComponent(ComponentType.Image)
	local colorIndex = (cell.index or 0) % #self._enemyBuffCellColorConfig + 1

	image.color = Framework.ColorUtil.ParseColor(self._enemyBuffCellColorConfig[colorIndex])
	txtEnemyLiveCount.text = tostring(data.enemyLiveNum)
	txtEnemyBuffIntro.text = data.desc
end

function OriginHolyChallengeStageView:_clearEnemyBuffTableCell(cell)
	local txtEnemyLiveCount = goutil.findChildTextComponent(cell.gameObject, "txtEnemyLiveCount")
	local txtEnemyBuffIntro = goutil.findChildTextComponent(cell.gameObject, "txtEnemyBuffIntro")

	txtEnemyLiveCount.text = ""
	txtEnemyBuffIntro.text = ""
end

function OriginHolyChallengeStageView:_updateLevelTableCell(view, cell, data, tag)
	local levelCell = goutil.findChild(cell.gameObject, "levelCell")

	if not levelCell then
		return
	end

	GameUtil.SetActive(levelCell, true)

	local var_21_1 = {
		cfg = data
	}

	var_21_1.index = (cell.index or 0) + 1

	self:_updateCell(levelCell, var_21_1)
end

function OriginHolyChallengeStageView:_clearLevelTableCell(cell)
	local levelCell = goutil.findChild(cell.gameObject, "levelCell")

	if levelCell then
		self:_clearCell(levelCell)
		GameUtil.SetActive(levelCell, false)
	end
end

function OriginHolyChallengeStageView:_onClickStage(stageId)
	if stageId > OriginHolyChallengeModel.instance:getPassStage(self._activityId) + 1 then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	local cfg = OriginHolyChallengeConfig.instance:getStage(self._activityId, stageId)

	self._curStageId = stageId

	self:_refreshView()

	if not self:_isStageOpen(cfg) then
		self:_showStageOpenTips(cfg)

		return
	end
end

function OriginHolyChallengeStageView:_onClickChallenge()
	if OriginHolyChallengeModel.instance:getPassStage(self._activityId) >= self._curStageId then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	if OriginHolyChallengeModel.instance:getPassStage(self._activityId) + 1 < self._curStageId then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	local cfg = OriginHolyChallengeConfig.instance:getStage(self._activityId, self._curStageId)

	if not self:_isStageOpen(cfg) then
		self:_showStageOpenTips(cfg)

		return
	end

	OriginHolyChallengeController.instance:openMissionView(self._activityId, self._curStageId)
end

function OriginHolyChallengeStageView:_refreshStageProgress()
	self._curStageId = OriginHolyChallengeModel.instance:getPassStage(self._activityId)

	if checknumber(self._curStageId) > 0 then
		if #self._stageCfgs > self._curStageId then
			self._curStageId = self._curStageId + 1
		end
	else
		self._curStageId = 1
	end

	self:_refreshView()

	if OriginHolyChallengeController.instance:isAllStagePassed(self._activityId) then
		UIStateManager.instance:popByName(ViewName.OriginHolyChallengeStageView)
	end
end

function OriginHolyChallengeStageView:_onClickTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return OriginHolyChallengeStageView
