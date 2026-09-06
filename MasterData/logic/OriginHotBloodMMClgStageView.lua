-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/view/OriginHotBloodMMClgStageView.lua

module("logic.extensions.originhotbloodmmclg.view.OriginHotBloodMMClgStageView", package.seeall)

local OriginHotBloodMMClgStageView = class("OriginHotBloodMMClgStageView", ViewComponent)

function OriginHotBloodMMClgStageView:ctor()
	OriginHotBloodMMClgStageView.super.ctor(self)

	self._nodePosList = {
		Vector2(-15, 156),
		Vector2(18, -28),
		Vector2(25, 155),
		Vector2(60, -27),
		Vector2(60, 155),
		Vector2(100, -27),
		Vector2(100, 155),
		Vector2(135, -27),
		(Vector2(135, 155))
	}
	self._cycleCount = #self._nodePosList
end

function OriginHotBloodMMClgStageView:unbindEvents()
	OriginHotBloodMMClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginHotBloodMMClgStageView:bindEvents()
	OriginHotBloodMMClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function OriginHotBloodMMClgStageView:buildUI()
	OriginHotBloodMMClgStageView.super.buildUI(self)

	self._btnChallenge = self:getBtn("info/btnChallenge")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._prizeTableView = self:getGo("info/prizeTableView")
	self._prizeTableCell = self:getGo("info/prizeTableCell")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._tableList = ScrollerList.New()
	self._teamEnemy = self:getGo("info/teamEnemy")
	self._enemyList = {}

	for i = 1, 9 do
		self._enemyList[i] = {
			go = goutil.findChild(self._teamEnemy, "cell_" .. i),
			con = goutil.findChild(self._teamEnemy, "cell_" .. i)
		}
	end

	self._prizeTableList = ScrollerList.create(self._prizeTableView, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeTableList:setCenterMode(true)
end

function OriginHotBloodMMClgStageView:onExit()
	OriginHotBloodMMClgStageView.super.onExit(self)
	self._prizeTableList:dispose()
	self._tableList:dispose()

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end
end

function OriginHotBloodMMClgStageView:onEnter()
	OriginHotBloodMMClgStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginHotBloodMMClgGetInfoRes, self._refreshStageProgress, self)
	self.addGEvent(self, GlobalNotify.PM_Notify_OriginHotBloodMMClgChallengeResultRes, self._refreshStageProgress, self)

	self._activityId = checknumber(self:getFirstParam())

	self._tableList:init(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableList:regValueChanged(function(view)
		self:_onUpdatePosition(view)
	end)
	self:_initView()
	self:_refreshView()
	OriginHotBloodMMClgController.instance:sendInfoReq(self._activityId)
end

function OriginHotBloodMMClgStageView:_initView()
	self._actCfg = OriginHotBloodMMClgConfig.instance:getActivity(self._activityId)
	self._stageCfgs = OriginHotBloodMMClgConfig.instance:getStages(self._activityId)
	self._curStageId = OriginHotBloodMMClgModel.instance:getPassStage(self._activityId)

	if checknumber(self._curStageId) > 0 then
		if #self._stageCfgs > self._curStageId then
			self._curStageId = self._curStageId + 1
		end
	else
		self._curStageId = 1
	end

	self._firstEnter = true
end

function OriginHotBloodMMClgStageView:_refreshView()
	local list = {}

	for i, v in ipairs(self._stageCfgs) do
		table.insert(list, {
			cfg = v,
			index = i
		})
	end

	self._tableList:reloadData(list)

	if self._firstEnter then
		self._tableList:MoveCellToCenter(self._curStageId - 1)
	end

	local curCfg = self._stageCfgs[self._curStageId]

	self._txtDesc.text = curCfg.desc

	local creepsCfg = OriginHotBloodMMClgConfig.instance:getCreeps(curCfg.creepsMasterId)

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end

	for i, v in ipairs(creepsCfg) do
		if self._enemyList[v.posId] then
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

function OriginHotBloodMMClgStageView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local enemyIcon = goutil.findChild(go, "node/enemyIcon")
	local txtName = goutil.findChildTextComponent(go, "node/txtName")
	local lockGo = goutil.findChild(go, "node/imgLocked")
	local bg1 = goutil.findChild(go, "node/bg1")
	local bg2 = goutil.findChild(go, "node/bg2")
	local btnClick = goutil.findChild(go, "node/btnClick")
	local selectGo = goutil.findChild(go, "node/imgSelect")
	local passGo = goutil.findChild(go, "node/passGo")
	local node = goutil.findChild(go, "node")
	local cfg = data.cfg
	local index = data.index % self._cycleCount

	if index == 0 then
		index = self._cycleCount
	end

	GameUtil.setAnchoredPos(node, self._nodePosList[index].x, self._nodePosList[index].y)

	txtName.text = langPara("第%d关", cfg.stageId)

	if cfg.enemyRaceId then
		MaterialMgr.resetAll(enemyIcon)

		local proxy = MaterialMgr.setCell(MatType.Pet, cfg.enemyRaceId, enemyIcon)

		if proxy then
			proxy.binder:setAutoTips(false)
		end

		GameUtil.setLocalScale(enemyIcon, 1.2, 1.2, 1.2)
	end

	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickStage(cfg.stageId)
	end)

	local isReachLevel = OriginHotBloodMMClgModel.instance:getPassStage(self._activityId) + 1 >= cfg.stageId
	local isLock = not isReachLevel

	GameUtil.SetActive(selectGo, cfg.stageId == self._curStageId)
	GameUtil.SetActive(lockGo, isLock)
	GameUtil.SetActive(bg1, not isLock and cfg.stageId == self._curStageId)
	GameUtil.SetActive(bg2, isLock or cfg.stageId ~= self._curStageId)
	GameUtil.SetActive(passGo, cfg.stageId <= OriginHotBloodMMClgModel.instance:getPassStage(self._activityId))
end

function OriginHotBloodMMClgStageView:_clearCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "node/btnClick")

	GameUtil.rmClickHandler(btnClick)

	local enemyIcon = goutil.findChild(go, "node/enemyIcon")

	MaterialMgr.resetAll(enemyIcon)
end

function OriginHotBloodMMClgStageView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function OriginHotBloodMMClgStageView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function OriginHotBloodMMClgStageView:_onClickStage(stageId)
	if stageId > OriginHotBloodMMClgModel.instance:getPassStage(self._activityId) + 1 then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	self._curStageId = stageId

	self:_refreshView()
end

function OriginHotBloodMMClgStageView:_onClickChallenge()
	if OriginHotBloodMMClgModel.instance:getPassStage(self._activityId) >= self._curStageId then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	if OriginHotBloodMMClgModel.instance:getPassStage(self._activityId) + 1 < self._curStageId then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	OriginHotBloodMMClgController.instance:openMissionView(self._activityId, self._curStageId)
end

function OriginHotBloodMMClgStageView:_onUpdatePosition(tableView)
	local count = tableView:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			cell.transform:SetSiblingIndex(cell.index)
		end
	end
end

function OriginHotBloodMMClgStageView:_refreshStageProgress()
	self._curStageId = OriginHotBloodMMClgModel.instance:getPassStage(self._activityId)

	if checknumber(self._curStageId) > 0 then
		if #self._stageCfgs > self._curStageId then
			self._curStageId = self._curStageId + 1
		end
	else
		self._curStageId = 1
	end

	self:_refreshView()

	if OriginHotBloodMMClgController.instance:isAllStagePassed(self._activityId) then
		UIStateManager.instance:popByName(ViewName.OriginHotBloodMMClgStageView)
	end
end

function OriginHotBloodMMClgStageView:_onClickTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return OriginHotBloodMMClgStageView
