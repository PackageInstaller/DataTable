-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/view/ShiZuDragonClgStageView.lua

module("logic.extensions.shizudragonclg.view.ShiZuDragonClgStageView", package.seeall)

local ShiZuDragonClgStageView = class("ShiZuDragonClgStageView", ViewComponent)

function ShiZuDragonClgStageView:ctor()
	ShiZuDragonClgStageView.super.ctor(self)
end

function ShiZuDragonClgStageView:unbindEvents()
	ShiZuDragonClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ShiZuDragonClgStageView:bindEvents()
	ShiZuDragonClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ShiZuDragonClgStageView:buildUI()
	ShiZuDragonClgStageView.super.buildUI(self)

	self._stageTableview = self:getGo("stageTableview")
	self._stageTablecell = self:getGo("stageTablecell")
	self._stageTabelList = ScrollerList.create(self._stageTableview, self._stageTablecell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	self._stageTabelList:setCenterMode(true)

	self._phaseTablecell = self:getGo("phaseTableview/phaseTablecell")
	self._phaseTableview = self:getGo("phaseTableview")
	self._phaseTableList = ScrollerList.create(self._phaseTableview, self._phaseTablecell, GameUtil.handler(self._updatePhaseCell, self), GameUtil.handler(self._clearPhaseCell, self))
	self._sliderPhaseBar = self:getSlider("phaseTableview/viewport/content/progressBar")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._prizeCon = self:getGo("buttom/prizeCon")
	self._received = self:getGo("buttom/received")
	self._txtScore = self:getTxt("buttom/txtScore")
	self._txtBuff = self:getTxt("buttom/txtBuff")
	self._txtTips = self:getTxt("buttom/txtTips")
end

function ShiZuDragonClgStageView:onExit()
	ShiZuDragonClgStageView.super.onExit(self)
end

function ShiZuDragonClgStageView:onEnter()
	self.addGEvent(self, GlobalNotify.ShiZuDragonClgGetInfo, self._refreshView, self)
	ShiZuDragonClgStageView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self:_refreshView()

	local tempInfo = ShiZuDragonClgModel.instance:getClgTempInfo()

	if tempInfo and tempInfo.changeSetId then
		MaterialController.instance:showChangeSetInTemp(tempInfo.changeSetId)
	end

	ShiZuDragonClgModel.instance:resetClgTempInfo()
end

function ShiZuDragonClgStageView:_refreshView()
	local phaseCfgs = ShiZuDragonClgConfig.instance:getPhaseCfgs(self._activityId)

	self._curPhaseId = ShiZuDragonClgModel.instance:getBestPhaseId(self._activityId) + 1

	if self._curPhaseId > #phaseCfgs then
		self._curPhaseId = #phaseCfgs
	end

	local stageCfgs = ShiZuDragonClgConfig.instance:getStageCfgs(self._activityId, self._curPhaseId)

	self._phaseTableList:reloadData(phaseCfgs)
	self._stageTabelList:reloadData(stageCfgs)

	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(phaseCfgs) do
		table.insert(scoreArr, v.phaseId)

		if self._curPhaseId == v.phaseId then
			idx = i - 1
		end
	end

	self._phaseTableList:updateUnderSlider(self._sliderPhaseBar, self._curPhaseId, scoreArr)
	self._phaseTableList:MoveCellToCenter(idx == -1 and 0 or idx)

	local curPhaseCfg = phaseCfgs[self._curPhaseId]

	MaterialMgr.setCellByCfg(curPhaseCfg.prize, self._prizeCon)

	local finishNum = 0
	local totalScore = 0

	for i, v in ipairs(stageCfgs) do
		local stageInfo = ShiZuDragonClgModel.instance:getStageInfo(self._activityId, v.stageId)

		if stageInfo ~= nil then
			finishNum = finishNum + 1
			totalScore = totalScore + stageInfo.num
		end
	end

	local buffCfg = ShiZuDragonClgConfig.instance:getBuffCfg(self._activityId, self._curPhaseId, finishNum)

	self._txtBuff.text = buffCfg and buffCfg.desc or lang("未激活任何效果")

	local contentScore = ""

	contentScore = totalScore >= curPhaseCfg.needNum and langPara("龙血%d（<color=#52FF86>%d</color>/%d）", curPhaseCfg.needNum, totalScore, curPhaseCfg.needNum) or langPara("龙血%d（<color=#FF5252>%d</color>/%d）", curPhaseCfg.needNum, totalScore, curPhaseCfg.needNum)
	self._txtScore.text = langPara("%s\n%s", contentScore, finishNum >= #stageCfgs and langPara("通关数%d（<color=#52FF86>%d</color>/%d)", #stageCfgs, finishNum, #stageCfgs) or langPara("通关数（<color=#FF5252>%d</color>/%d）", finishNum, #stageCfgs))
	self._txtTips.text = curPhaseCfg.desc

	GameUtil.SetActive(self._received, ShiZuDragonClgModel.instance:getBestPhaseId(self._activityId) >= self._curPhaseId)
end

function ShiZuDragonClgStageView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local btnChallenge = goutil.findChild(teamEnemy, "btn")
	local btnReset = goutil.findChild(go, "btnReset")
	local scoreGo = goutil.findChild(go, "score")
	local txtScore = goutil.findChildTextComponent(scoreGo, "txtScore")
	local passGo = goutil.findChild(go, "pass")
	local stageInfo = ShiZuDragonClgModel.instance:getStageInfo(self._activityId, data.stageId)
	local isPass = stageInfo ~= nil
	local teamGoMap = {}

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local cellCon = goutil.findChild(teamEnemy, "cell_" .. i .. "/icon")

		MaterialMgr.resetAll(cellCon)
		GameUtil.SetActive(cellGo, false)

		teamGoMap[i] = {
			con = cellCon,
			go = cellGo
		}
	end

	local creepCfg = ShiZuDragonClgConfig.instance:getCreepsCfg(data.creepsMasterId)

	for i, v in ipairs(creepCfg) do
		if teamGoMap[v.posId] then
			local proxy = MaterialMgr.setIcon(teamGoMap[v.posId].con, MatType.Pet, v.raceId)

			GameUtil.SetActive(teamGoMap[v.posId].go, true)
		end
	end

	GameUtil.addClickHandler(btnChallenge, function()
		self:_onClickStage(data.stageId)
	end)
	GameUtil.addClickHandler(btnReset, function()
		self:_onClickReset(data.stageId)
	end)
	GameUtil.SetActive(passGo, isPass)
	GameUtil.SetActive(btnReset, isPass)

	if stageInfo then
		if not stageInfo.num then
			local score = 0

			txtScore.text = langPara("龙血:%d", score)
		end
	end
end

function ShiZuDragonClgStageView:_clearStageCell(cell)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local btnChallenge = goutil.findChild(teamEnemy, "btn")
	local btnReset = goutil.findChild(go, "btnReset")

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local cellCon = goutil.findChild(teamEnemy, "cell_" .. i .. "/icon")

		MaterialMgr.resetAll(cellCon)
		GameUtil.SetActive(cellGo, false)
	end

	GameUtil.rmClickHandler(btnChallenge)
	GameUtil.rmClickHandler(btnReset)
end

function ShiZuDragonClgStageView:_updatePhaseCell(view, cell, data, tag)
	local go = cell.gameObject
	local passGo = goutil.findChild(go, "pass")
	local lock = goutil.findChild(go, "lock")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local bgColorChange = goutil.findChildComponent(go, "img", ComponentType.UIImageColorChange)

	GameUtil.SetActive(lock, self._curPhaseId < data.phaseId)
	GameUtil.SetActive(passGo, self._curPhaseId > data.phaseId)

	if self._curPhaseId == data.phaseId then
		bgColorChange:SetState(1)
	else
		bgColorChange:SetState(0)
	end

	txtName.text = data.name
end

function ShiZuDragonClgStageView:_clearPhaseCell(cell)
	return
end

function ShiZuDragonClgStageView:_onClickStage(stageId)
	local stageInfo = ShiZuDragonClgModel.instance:getStageInfo(self._activityId, stageId)

	if stageInfo == nil then
		ShiZuDragonClgController.instance:openMissionView(self._activityId, self._curPhaseId, stageId)
	else
		FloatWordMgr.instance:show(lang("已挑战"))
	end
end

function ShiZuDragonClgStageView:_onClickReset(stageId)
	local stageInfo = ShiZuDragonClgModel.instance:getStageInfo(self._activityId, stageId)

	if stageInfo ~= nil then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否清空龙血记录，将本关重置为未挑战"), function()
			ShiZuDragonClgAgent.instance:sendPM_ShiZuDragonClgResetReq(self._activityId, self._curPhaseId, stageId)
		end)
	else
		FloatWordMgr.instance:show(lang("关卡未挑战"))
	end
end

function ShiZuDragonClgStageView:_onClickTip()
	TipsFacade.instance:openRulesView("shi_zu_dragon_clg_rule")
end

return ShiZuDragonClgStageView
