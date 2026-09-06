-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/view/DivineKingCiYuanResultView.lua

module("logic.extensions.divinekingciyuan.view.DivineKingCiYuanResultView", package.seeall)

local DivineKingCiYuanResultView = class("DivineKingCiYuanResultView", ViewComponent)

function DivineKingCiYuanResultView:ctor()
	DivineKingCiYuanResultView.super.ctor(self)
end

function DivineKingCiYuanResultView:unbindEvents()
	DivineKingCiYuanResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineKingCiYuanResultView:bindEvents()
	DivineKingCiYuanResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSureBtn, self)
end

function DivineKingCiYuanResultView:buildUI()
	DivineKingCiYuanResultView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._txtResult = self:getGo("txtResult"):GetComponent(typeof(UnityEngine.UI.Text))
	self._targetState1 = self:getGo("target/desc1/state"):GetComponent("UIImageSpriteChange")
	self._txtTargetDesc2 = self:getGo("target/desc2"):GetComponent(typeof(UnityEngine.UI.Text))
	self._targetState2 = self:getGo("target/desc2/state"):GetComponent("UIImageSpriteChange")
	self._goTableView = self:getGo("petEventRecord/tableview")
	self._goCell = self:getGo("petEventRecord/tableview/tablecell")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineKingCiYuanResultView:onExit()
	DivineKingCiYuanResultView.super.onExit(self)
end

function DivineKingCiYuanResultView:onEnter()
	DivineKingCiYuanResultView.super.onEnter(self)

	self._data = self:getFirstParam()

	local stageConfig = DivineKingCiYuanConfig.instance:getStageCfg(self._data.activityId, self._data.phaseId, self._data.stageId)
	local targetCount = stageConfig.targetCount
	local actionCount = 0

	for i, v in ipairs(self._data.raceIdAndActionCountList) do
		actionCount = actionCount + v.right
	end

	local isWin = self._data.isWin
	local isPass = targetCount <= actionCount
	local str = "我方精灵出手次数："

	self._txtTargetDesc2.text = isPass and lang(string.format("%s<color=#20b376FF>%d</color> / %d", str, actionCount, targetCount)) or lang(string.format("%s<color=#FF0000FF>%d</color> / %d", str, actionCount, targetCount))
	self._txtResult.text = isWin and isPass and "挑战成功" or "挑战失败"

	self._targetState1:SetState(isWin and 1 or 0)
	self._targetState2:SetState(isPass and 1 or 0)

	local raceIdAndActionCountList = self._data.raceIdAndActionCountList

	for _, v in pairs(raceIdAndActionCountList) do
		table.sort(raceIdAndActionCountList, function(x, y)
			return x.right > y.right
		end)
	end

	self._tableView:reloadData(raceIdAndActionCountList)
	self._tableView:setCenterMode(true)
end

function DivineKingCiYuanResultView:_updateCell(view, goCell, data)
	local item = goutil.findChild(goCell, "item")
	local txt = goutil.findChild(goCell, "txt"):GetComponent(typeof(UnityEngine.UI.Text))
	local tag = goutil.findChild(goCell, "tag")
	local lockRaceIds = self._data.lockRaceIds
	local isLock = false

	if lockRaceIds then
		for _, v in ipairs(lockRaceIds) do
			if v == data.left then
				isLock = true

				break
			end
		end
	end

	MaterialMgr.setCell(MatType.Pet, data.left, item)

	txt.text = data.right .. "次"

	goutil.setActive(tag, isLock)
end

function DivineKingCiYuanResultView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function DivineKingCiYuanResultView:_onClickSureBtn()
	local activityId = self._data.activityId
	local curPhaseId = self._data.phaseId
	local phaseList = DivineKingCiYuanConfig.instance:getPhaseCfgsByActId(activityId)
	local maxPhaseData = phaseList[#phaseList]

	if maxPhaseData then
		if not maxPhaseData.phaseId then
			local maxPhaseId = 0
			local curStageId = self._data.stageId
			local curPhaseData = phaseList[curPhaseId]

			if curPhaseData then
				if not curPhaseData.stagePlanId then
					local stagePlanId = 0
					local stageList = DivineKingCiYuanConfig.instance:getStageCfgsByStagePlanId(stagePlanId)
					local maxStageData = stageList[#stageList]

					if maxStageData then
						if not maxStageData.stageId then
							local maxStageId = 0

							if maxPhaseId <= curPhaseId and maxStageId <= curStageId then
								local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

								if isAoqiGodProcessType then
									local activityType = DivineKingCiYuanController.instance:getActivityType()

									AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
								else
									UIJumper.instance:removeTopState(ViewName.DivineKingCiYuanClgView)
									UIJumper.instance:pushOneStack(ViewName.DivineKingCiYuanPassView, nil, activityId)
								end
							end

							BattleController.instance:endBattle()
						end
					end
				end
			end
		end
	end
end

return DivineKingCiYuanResultView
