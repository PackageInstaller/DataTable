-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/view/DragonKingARuiShiClgLevelView.lua

module("logic.extensions.dragonkingaruishiclg.view.DragonKingARuiShiClgLevelView", package.seeall)

local DragonKingARuiShiClgLevelView = class("DragonKingARuiShiClgLevelView", ViewComponent)

function DragonKingARuiShiClgLevelView:ctor()
	DragonKingARuiShiClgLevelView.super.ctor(self)

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

function DragonKingARuiShiClgLevelView:unbindEvents()
	DragonKingARuiShiClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DragonKingARuiShiClgLevelView:bindEvents()
	DragonKingARuiShiClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function DragonKingARuiShiClgLevelView:buildUI()
	DragonKingARuiShiClgLevelView.super.buildUI(self)

	self._btnChallenge = self:getGo("info/btnChallenge")
	self._txtLimit = self:getTxt("info/txtLimit")
	self._txtDamage = self:getTxt("info/txtDamage")
	self._imgCompleteGo = self:getGo("info/txtDamage/imgComplete")
	self._changeComplete = self._imgCompleteGo:GetComponent(ComponentType.UIImageSpriteChange)
	self._txtDesc = self:getTxt("info/txtDesc")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.New()
	self._teamReviveTime = self:getGo("info/teamEnemy")
	self._teamReviveList = {}

	for i = 1, 9 do
		local go = goutil.findChild(self._teamReviveTime, "cell_" .. i)

		self._teamReviveList[i] = goutil.findChildTextComponent(go, "txt")
	end

	self._prize = self:getGo("info/prize")
	self._txtPrizeNum = self:getTxt("info/prize/txtNum")
end

function DragonKingARuiShiClgLevelView:onExit()
	DragonKingARuiShiClgLevelView.super.onExit(self)
	self._tableList:dispose()
end

function DragonKingARuiShiClgLevelView:onEnter()
	DragonKingARuiShiClgLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DragonKingARuiShiClgGetInfo, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.DragonKingARuiShiClgChallengeEnd, self._PM_DragonKingARuiShiClgChallengeEnd, self)
	self._tableList:init(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableList:regValueChanged(function(view)
		self:_onUpdatePosition(view)
	end)
	self:_initView()
	DragonKingARuiShiClgAgent.instance:sendPM_DragonKingARuiShiClgInfoReq(self._activityId)
end

function DragonKingARuiShiClgLevelView:_initView()
	self._activityId = self:getFirstParam()
	self._stageCfgs = DragonKingARuiShiClgConfig.instance:getStageCfgs(self._activityId)
	self._curStageId = DragonKingARuiShiClgModel.instance:getPassStage(self._activityId)

	if checknumber(self._curStageId) > 0 then
		if #self._stageCfgs > self._curStageId then
			self._curStageId = self._curStageId + 1
		end
	else
		self._curStageId = 1
	end

	self._firstEnter = true
end

function DragonKingARuiShiClgLevelView:_refreshView()
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

	self._txtDamage.text = DragonKingARuiShiClgConfig.instance:getDamage(curCfg.creepsMasterId)
	self._txtDesc.text = curCfg.desc
	self._txtLimit.text = langPara("本关可上阵精灵数：<color=#FFFFFF>%d</color>", curCfg.limit)

	local matType, matId, matNum = MaterialMgr.getMatParams(curCfg.prize)

	self._txtPrizeNum.text = langPara("X%d", matNum)

	MaterialMgr.setIcon(self._prize, matType, matId)

	for i = 1, 9 do
		self._teamReviveList[i].text = curCfg.reviveTime[i]
	end

	GameUtil.SetActive(self._imgCompleteGo, DragonKingARuiShiClgModel:getChallengeRecord(self._activityId, self._curStageId))

	if DragonKingARuiShiClgModel.instance:getPassStage(self._activityId) >= self._curStageId then
		self._changeComplete:SetState(0)
	else
		self._changeComplete:SetState(1)
	end

	self._firstEnter = false
end

function DragonKingARuiShiClgLevelView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "node/txtName")
	local lockGo = goutil.findChild(go, "node/imgLocked")
	local bg1 = goutil.findChild(go, "node/bg1")
	local bg2 = goutil.findChild(go, "node/bg2")
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

	txtName.text = cfg.name

	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickStage(cfg.stageId)
	end)

	local isReachTime = GameUtil.string2time(cfg.startTime) <= ServerTime.now()
	local isReachLevel = DragonKingARuiShiClgModel.instance:getPassStage(self._activityId) + 1 >= cfg.stageId
	local isLock = not isReachTime or not isReachLevel

	GameUtil.SetActive(selectGo, cfg.stageId == self._curStageId)
	GameUtil.SetActive(lockGo, isLock)
	GameUtil.SetActive(bg1, not isLock and cfg.stageId == self._curStageId)
	GameUtil.SetActive(bg2, isLock or cfg.stageId ~= self._curStageId)
	GameUtil.SetActive(passGo, cfg.stageId <= DragonKingARuiShiClgModel.instance:getPassStage(self._activityId))
end

function DragonKingARuiShiClgLevelView:_clearCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "node/btnClick")

	GameUtil.rmClickHandler(btnClick)
end

function DragonKingARuiShiClgLevelView:_onClickStage(stageId)
	if stageId > DragonKingARuiShiClgModel.instance:getPassStage(self._activityId) + 1 then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	local cfg = DragonKingARuiShiClgConfig.instance:getStageCfg(self._activityId, stageId)

	if GameUtil.string2time(cfg.startTime) > ServerTime.now() then
		local date = GameUtil.string2date(cfg.startTime)

		FloatWordMgr.instance:show(langPara("关卡开启时间为：%d月%d日%d:%02d，当前未到开启时间", date.month, date.day, date.hour, date.min))

		return
	end

	self._curStageId = stageId

	self:_refreshView()
end

function DragonKingARuiShiClgLevelView:_onClickChallenge()
	if checknumber(self._curStageId) <= 0 then
		return
	end

	if DragonKingARuiShiClgModel.instance:getPassStage(self._activityId) >= self._curStageId then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	if DragonKingARuiShiClgModel.instance:getPassStage(self._activityId) + 1 < self._curStageId then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	local cfg = DragonKingARuiShiClgConfig.instance:getStageCfg(self._activityId, self._curStageId)

	if GameUtil.string2time(cfg.startTime) > ServerTime.now() then
		local date = GameUtil.string2date(cfg.startTime)

		FloatWordMgr.instance:show(langPara("关卡开启时间为：%d月%d日%d:%02d，当前未到开启时间", date.month, date.day, date.hour, date.min))

		return
	end

	local fmtMo = DragonKingARuiShiClgModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, self._curStageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DragonKingARuiShiClgLevelView:_onClickTip()
	TipsFacade.instance:openRulesView("dragon_king_aruishi_rule")
end

function DragonKingARuiShiClgLevelView:_onUpdatePosition(tableView)
	local count = tableView:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			cell.transform:SetSiblingIndex(cell.index)
		end
	end
end

function DragonKingARuiShiClgLevelView:_PM_DragonKingARuiShiClgChallengeEnd()
	self._curStageId = DragonKingARuiShiClgModel.instance:getPassStage(self._activityId)

	if checknumber(self._curStageId) > 0 then
		if #self._stageCfgs > self._curStageId then
			self._curStageId = self._curStageId + 1
		end
	else
		self._curStageId = 1
	end

	self:_refreshView()
end

return DragonKingARuiShiClgLevelView
