-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedisorderdragon/view/DivinedisorderdragonlevelView.lua

module("logic.extensions.divinedisorderdragon.view.DivinedisorderdragonlevelView", package.seeall)

local DivinedisorderdragonlevelView = class("DivinedisorderdragonlevelView", ViewComponent)

function DivinedisorderdragonlevelView:ctor()
	DivinedisorderdragonlevelView.super.ctor(self)

	self._nodePosList = {
		Vector2(-30.2, 70),
		Vector2(31.3, -103.1),
		Vector2(-35.9, 167.9),
		(Vector2(-27.8, -60))
	}
	self._linePosList = {
		Vector3(181.86, -86.64, -124.36),
		Vector3(46.5, 133.98, -26.88),
		Vector3(132, -100.6, -136.1),
		(Vector3(88.3, 84.9, -55.9))
	}
	self._cycleCount = #self._nodePosList
end

function DivinedisorderdragonlevelView:unbindEvents()
	DivinedisorderdragonlevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivinedisorderdragonlevelView:bindEvents()
	DivinedisorderdragonlevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function DivinedisorderdragonlevelView:buildUI()
	DivinedisorderdragonlevelView.super.buildUI(self)

	self._btnChallenge = self:getGo("info/btnChallenge")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.New()
	self._teamEnemy = self:getGo("info/teamEnemy")
	self._enemyList = {}

	for i = 1, 9 do
		self._enemyList[i] = {
			go = goutil.findChild(self._teamEnemy, "cell_" .. i),
			con = goutil.findChild(self._teamEnemy, "cell_" .. i)
		}
	end

	self._prizeTableView = self:getGo("info/prizeTableView")
	self._prizeTableCell = self:getGo("info/prizeTableCell")
	self._prizeTableList = ScrollerList.create(self._prizeTableView, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeTableList:setCenterMode(true)

	self._title3Bg = self:getGo("info/title3Bg")
	self._txtTitle3 = self:getGo("info/txtTitle3")
	self._img9 = self:getGo("info/imgBg/img9")
	self._img8 = self:getGo("info/imgBg/img8")
end

function DivinedisorderdragonlevelView:destroyUI()
	DivinedisorderdragonlevelView.super.destroyUI(self)
	self._prizeTableList:dispose()
	self._tableList:dispose()
end

function DivinedisorderdragonlevelView:onExit()
	DivinedisorderdragonlevelView.super.onExit(self)
	self._prizeTableList:dispose()
	self._tableList:dispose()

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end
end

function DivinedisorderdragonlevelView:onEnter()
	DivinedisorderdragonlevelView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self.addGEvent(self, GlobalNotify.DivineDisorderDragonGetInfoRes, self._refreshView, self)
	self._tableList:init(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableList:regValueChanged(function(view)
		self:_onUpdatePosition(view)
	end)
	self:_initView()
	self:_refreshView()
	DivineDisorderDragonAgent.instance:sendPM_DivineDisorderDragonGetInfoReq(self._activityId)
end

function DivinedisorderdragonlevelView:_initView()
	self._actCfg = DivinedisorderdragonConfig.instance:getActivityCfg(self._activityId)
	self._stageCfgs = DivinedisorderdragonConfig.instance:getStageCfgs(self._activityId)
	self._curStageId = DivinedisorderdragonModel.instance:getPassStage(self._activityId)

	if checknumber(self._curStageId) > 0 then
		if #self._stageCfgs > self._curStageId then
			self._curStageId = self._curStageId + 1
		end
	else
		self._curStageId = 1
	end

	self._firstEnter = true

	GameUtil.SetActive(self._title3Bg, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._txtTitle3, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._prizeTableView, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._img8, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._img9, not self._isAoqiGodProcessType)
end

function DivinedisorderdragonlevelView:_refreshView()
	local list = {}

	for i, v in ipairs(self._stageCfgs) do
		table.insert(list, {
			cfg = v,
			index = i
		})
	end

	self._tableList:reloadData(list)

	if self._firstEnter == true then
		self._tableList:MoveCellToCenter(self._curStageId - 1)
	end

	local curCfg = self._stageCfgs[self._curStageId]
	local enemyCfg = DivinedisorderdragonConfig.instance:getTeamCfg(curCfg.creepsMasterId)

	self._txtDesc.text = enemyCfg.ruleDesc

	local creepCfg = DivinedisorderdragonConfig.instance:getCreepsCfg(curCfg.creepsMasterId)

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

	local prizeList = string.split(curCfg.prize, "#")

	self._prizeTableList:reloadData(prizeList)

	self._firstEnter = false
end

function DivinedisorderdragonlevelView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "node/txtName")
	local lockGo = goutil.findChild(go, "node/imgLocked")
	local bg1 = goutil.findChild(go, "node/bg1")
	local btnClick = goutil.findChild(go, "node/btnClick")
	local selectGo = goutil.findChild(go, "node/imgSelect")
	local passGo = goutil.findChild(go, "node/passGo")
	local node = goutil.findChild(go, "node")
	local line = goutil.findChild(go, "node/line")
	local cfg = data.cfg
	local index = data.index % self._cycleCount

	if index == 0 then
		index = self._cycleCount
	end

	GameUtil.setAnchoredPos(node, self._nodePosList[index].x, self._nodePosList[index].y)
	GameUtil.setAnchoredPos(line, self._linePosList[index].x, self._linePosList[index].y)
	GameUtil.setLocalRotation(line, 0, 0, self._linePosList[index].z)
	GameUtil.SetActive(line, data.index ~= #self._stageCfgs)

	txtName.text = cfg.stageId

	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickStage(cfg.stageId)
	end)

	local isReachLevel = DivinedisorderdragonModel.instance:getPassStage(self._activityId) + 1 >= cfg.stageId
	local isLock = not isReachLevel or not self:_isOpen(cfg.stageId)

	GameUtil.SetActive(selectGo, cfg.stageId == self._curStageId)
	GameUtil.SetActive(lockGo, isLock)
	GameUtil.SetActive(bg1, not isLock and cfg.stageId == self._curStageId)
	GameUtil.SetActive(passGo, cfg.stageId <= DivinedisorderdragonModel.instance:getPassStage(self._activityId))
end

function DivinedisorderdragonlevelView:_clearCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "node/btnClick")

	GameUtil.rmClickHandler(btnClick)
end

function DivinedisorderdragonlevelView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function DivinedisorderdragonlevelView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function DivinedisorderdragonlevelView:_onClickStage(stageId)
	if stageId > DivinedisorderdragonModel.instance:getPassStage(self._activityId) + 1 then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	if not self:_isOpen(stageId) then
		self:_showStageOpenTimeTip(stageId)

		return
	end

	self._curStageId = stageId

	self:_refreshView()
end

function DivinedisorderdragonlevelView:_onClickChallenge()
	if checknumber(self._curStageId) <= 0 then
		return
	end

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineDisorderDragon, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	if DivinedisorderdragonModel.instance:getPassStage(self._activityId) >= self._curStageId then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	if DivinedisorderdragonModel.instance:getPassStage(self._activityId) + 1 < self._curStageId then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	if not self:_isOpen(self._curStageId) then
		self:_showStageOpenTimeTip(self._curStageId)

		return
	end

	local fmtMo = DivinedisorderdragonModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, self._curStageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivinedisorderdragonlevelView:_onClickTip()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(199)

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivinedisorderdragonlevelView:_onClickTransfer()
	return
end

function DivinedisorderdragonlevelView:_onUpdatePosition(tableView)
	local count = tableView:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			cell.transform:SetSiblingIndex(cell.index)
		end
	end
end

function DivinedisorderdragonlevelView:_isOpen(stageId)
	local cfg = DivinedisorderdragonConfig.instance:getStageCfg(self._activityId, stageId)
	local openTime = GameUtil.string2time(cfg.openTime)

	return openTime <= ServerTime.now()
end

function DivinedisorderdragonlevelView:_showStageOpenTimeTip(stageId)
	local cfg = DivinedisorderdragonConfig.instance:getStageCfg(self._activityId, stageId)
	local date = GameUtil.string2date(cfg.openTime)
	local str = string.format("%s-%s-%s %s点开启", date.year, date.month, date.day, date.hour)

	FloatWordMgr.instance:show(str)
end

return DivinedisorderdragonlevelView
