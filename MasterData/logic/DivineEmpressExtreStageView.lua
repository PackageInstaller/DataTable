-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressExtreStageView.lua

module("logic.extensions.divineempress.view.DivineEmpressExtreStageView", package.seeall)

local DivineEmpressExtreStageView = class("DivineEmpressExtreStageView", ViewComponent)
local reverseBgIndex = {
	nil,
	true,
	nil,
	nil,
	nil,
	true,
	true
}

function DivineEmpressExtreStageView:ctor()
	DivineEmpressExtreStageView.super.ctor(self)
end

function DivineEmpressExtreStageView:unbindEvents()
	DivineEmpressExtreStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnCardInfo)
	GameUtil.rmClickHandler(self._btnResult)
end

function DivineEmpressExtreStageView:bindEvents()
	DivineEmpressExtreStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnCardInfo, self._onClickCardInfo, self)
	GameUtil.addClickHandler(self._btnResult, self._onClickResult, self)
end

function DivineEmpressExtreStageView:buildUI()
	DivineEmpressExtreStageView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnReset = self:getGo("btnReset")
	self._btnCardInfo = self:getGo("info/btnCardInfo")
	self._btnResult = self:getGo("info/btnResult")
	self._stageCells = self:getGo("stageCells")
	self._stageCell = self:getGo("stageCells/stageCell")
	self._stagePosRecord = self._stageCells:GetComponent(ComponentType.TestRecordPos)
	self._buffInfoEmpty = self:getGo("info/cardInfo/buffInfo/empty")
	self._buffSelect = self:getGo("info/cardInfo/buffInfo/buffSelect")
	self._txtBuffDesc = self:getTxt("info/cardInfo/buffInfo/buffSelect/txtDesc")
	self._txtBuffNumber = self:getTxt("info/cardInfo/buffInfo/buffSelect/txtNumber")
	self._debuffInfoEmpty = self:getGo("info/cardInfo/debuffInfo/empty")
	self._debuffSelect = self:getGo("info/cardInfo/debuffInfo/buffSelect")
	self._txtDebuffDesc = self:getTxt("info/cardInfo/debuffInfo/buffSelect/txtDesc")
	self._txtDebuffNumber = self:getTxt("info/cardInfo/debuffInfo/buffSelect/txtNumber")
	self._txtResultNum = self:getTxt("info/resultInfo/txtNum")
	self._txtResultDesc = self:getTxt("info/resultInfo/txtDesc")
	self._tablecell = self:getGo("info/tablecell")
	self._teamTableView = self:getGo("info/teamTableView")
	self._teamTableList = ScrollerList.create(self._teamTableView, self._tablecell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._lockTableView = self:getGo("info/lockTableView")
	self._lockTableList = ScrollerList.create(self._lockTableView, self._tablecell, GameUtil.handler(self._updateLockCell, self), GameUtil.handler(self._clearLockCell, self))
	self._txtEmptyLock = self:getGo("info/txtEmptyLock")
end

function DivineEmpressExtreStageView:onExit()
	DivineEmpressExtreStageView.super.onExit(self)
	GameUtil.clearCells(self._stageCells, self._clearStageCell, self, false)
	self._teamTableList:dispose()
	self._lockTableList:dispose()
end

function DivineEmpressExtreStageView:onEnter()
	DivineEmpressExtreStageView.super.onEnter(self)
	self:addGEvent(GlobalNotify.DivineEmpressClgGetInfo, self._refreshView)
	self:addGEvent(GlobalNotify.PM_Notify_DivineDualDragonClgChallengeRes, self._refreshView)

	self._activityId = checknumber(self:getFirstParam())
	self._selectStageId = DivineEmpressModel.instance:getSelectStageId()

	if self._selectStageId == nil then
		self._selectStageId = 1

		local stageCfgs = DivineEmpressConfig.instance:getExtraStageCfgs(self._activityId)

		for i, v in ipairs(stageCfgs) do
			if not DivineEmpressModel.instance:getExtremeStagePass(self._activityId, v.stageId) then
				self._selectStageId = v.stageId

				break
			end
		end
	end

	self:_refreshView()

	if DivineEmpressModel.instance:getTempBattleResult() ~= nil then
		UIStateManager.instance:push(ViewName.DivineEmpressResultView)
	end
end

function DivineEmpressExtreStageView:_refreshView()
	local stageCfgs = DivineEmpressConfig.instance:getExtraStageCfgs(self._activityId)

	GameUtil.updateCellsList(self._stageCells, self._stageCell, stageCfgs, self._updateStageCell, self)
	self._stagePosRecord:LoadPlan(0)

	local stageCfg = DivineEmpressConfig.instance:getExtraStageCfg(self._activityId, self._selectStageId)

	if not stageCfg then
		return
	end

	local stageInfo = DivineEmpressModel.instance:getExtremeStageInfo(self._activityId, self._selectStageId)
	local list = {}
	local teamCrepssCfg = DivineEmpressConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)

	for i, v in ipairs(teamCrepssCfg) do
		if v.posId > 0 then
			table.insert(list, v)
		end
	end

	list = ArraySort.sortOn(list, "posId", ArraySort.NONE)

	self._teamTableList:reloadData(list)

	if stageInfo then
		if not stageInfo.banRaceIds then
			local lockList = {}

			self._lockTableList:reloadData(lockList)
			GameUtil.SetActive(self._txtEmptyLock, #lockList == 0)

			if stageInfo then
				local curBuffId = checknumber(stageInfo.usedPositiveBuffId or 0)
				local buffscore = 0

				GameUtil.SetActive(self._buffInfoEmpty, curBuffId == 0)
				GameUtil.SetActive(self._buffSelect, curBuffId ~= 0)

				if curBuffId ~= 0 then
					local buffCfg = DivineEmpressConfig.instance:getBuffCfg(self._activityId, curBuffId)

					self._txtBuffNumber.text = buffCfg.buffScore
					self._txtBuffDesc.text = buffCfg.desc
					buffscore = buffCfg.buffScore
				end

				if stageInfo then
					local curDebuffId = checknumber(stageInfo.usedNegativeBuffId or 0)
					local debuffScore = 0

					GameUtil.SetActive(self._debuffInfoEmpty, curDebuffId == 0)
					GameUtil.SetActive(self._debuffSelect, curDebuffId ~= 0)

					if curDebuffId ~= 0 then
						local debuffCfg = DivineEmpressConfig.instance:getDebuffCfg(self._activityId, curDebuffId)

						self._txtDebuffNumber.text = debuffCfg.buffScore
						self._txtDebuffDesc.text = debuffCfg.desc
						debuffScore = debuffCfg.buffScore
					end

					local totalScore = debuffScore + buffscore
					local scoreCfg = DivineEmpressController.instance:getScoreCfgByTotalScore(self._activityId, totalScore)

					if checknumber(totalScore) == 0 then
						self._txtResultNum.text = lang("未占卜")
						self._txtResultDesc.text = lang("无")
					else
						self._txtResultNum.text = totalScore
						self._txtResultDesc.text = langPara("破阵，且免疫次数≥%d", scoreCfg.immunityTimes)
					end

					local stagePass = DivineEmpressModel.instance:getExtremeStagePass(self._activityId, self._selectStageId)

					GameUtil.SetActive(self._btnChallenge, not stagePass)
					GameUtil.SetActive(self._btnReset, stagePass == true)
				end
			end
		end
	end
end

function DivineEmpressExtreStageView:_updateStageCell(cell, data, index)
	local go = cell.gameObject
	local bgGo = goutil.findChild(go, "bg")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local selectGo = goutil.findChild(bgGo, "select")
	local passGo = goutil.findChild(go, "pass")
	local btn = go

	txtName.text = data.name

	local isPass = DivineEmpressModel.instance:getExtremeStagePass(self._activityId, data.stageId)

	GameUtil.SetActive(selectGo, data.stageId == self._selectStageId)
	GameUtil.SetActive(passGo, isPass)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickStage(data.stageId)
	end)

	if reverseBgIndex[index] == true then
		GameUtil.setLocalScale(bgGo, -1, 1, 1)
	else
		GameUtil.setLocalScale(bgGo, 1, 1, 1)
	end
end

function DivineEmpressExtreStageView:_clearStageCell(cell)
	local btn = cell.gameObject

	GameUtil.rmClickHandler(btn)
end

function DivineEmpressExtreStageView:_updateTeamCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data.raceId, go)
end

function DivineEmpressExtreStageView:_clearTeamCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function DivineEmpressExtreStageView:_updateLockCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function DivineEmpressExtreStageView:_clearLockCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function DivineEmpressExtreStageView:_onClickStage(stageId)
	self._selectStageId = stageId

	DivineEmpressModel.instance:saveSelectStageId(self._selectStageId)
	self:_refreshView()
end

function DivineEmpressExtreStageView:_onClickChallenge()
	DivineEmpressController.instance:openExtraMissionView(self._activityId, self._selectStageId)
end

function DivineEmpressExtreStageView:_onClickCardInfo()
	UIStateManager.instance:push(ViewName.DivineEmpressExtreCardView, self._activityId)
end

function DivineEmpressExtreStageView:_onClickResult()
	UIStateManager.instance:push(ViewName.DivineEmpressScoreView, self._activityId)
end

function DivineEmpressExtreStageView:_onClickClose()
	DivineEmpressModel.instance:saveSelectStageId(nil)
	self:close()
end

function DivineEmpressExtreStageView:_onClickReset()
	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否将本关重置为未挑战，解除精灵封印和清除塔罗牌占卜记录"), function()
		DivineEmpressChallengeAgent.instance:sendPM_DivineEmpressResetExtremeStageReq(self._activityId, self._selectStageId)
	end)
end

return DivineEmpressExtreStageView
