-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/view/DivineShiKongLongZunLevelView.lua

module("logic.extensions.divineshikonglongzunmainview.view.DivineShiKongLongZunLevelView", package.seeall)

local DivineShiKongLongZunLevelView = class("DivineShiKongLongZunLevelView", ViewComponent)

function DivineShiKongLongZunLevelView:buildUI()
	DivineShiKongLongZunLevelView.super.buildUI(self)

	self._rule = self:getGo("desc/lineFrame/rule")
	self._txtRule = self:getTxt("desc/lineFrame/rule/txtRule")
	self._txtRequest = self:getTxt("desc/lineFrame/request/bg/txtRequest")
	self._txtTotalScore = self:getTxt("totalScore/txt")
	self._tablecell2 = self:getGo("tablecell2")
	self._tableview2 = self:getGo("tableview2")
	self.scrollerList2 = ScrollerList.create(self._tableview2, self._tablecell2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self.scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
end

function DivineShiKongLongZunLevelView:bindEvents()
	DivineShiKongLongZunLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DivineShiKongLongZunLevelView:unbindEvents()
	DivineShiKongLongZunLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineShiKongLongZunLevelView:onEnter()
	DivineShiKongLongZunLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineTSDragonLordClgGetInfoRes, self._update, self)
	self.addGEvent(self, GlobalNotify.PM_DivineTSDragonLordClgConfirmScoreRes, self._update, self)
	self.addGEvent(self, GlobalNotify.PM_Notify_DivineTSDragonLordClgChallengeEndRes, self._update, self)

	self._activityId = self:getFirstParam()
	self._actStartTime = ActivityDefineController.instance:getStartTimeAndEndTime(DivineShiKongLongZunController.instance:getActivityType(), self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	DivineShiKongLongZunController.instance:sendPM_DivineTSDragonLordClgGetInfoReq(self._activityId)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._rule.transform)
	self:_update()
end

function DivineShiKongLongZunLevelView:onExit()
	DivineShiKongLongZunLevelView.super.onExit(self)
	self.scrollerList:dispose()
	self.scrollerList2:dispose()
end

function DivineShiKongLongZunLevelView:_update()
	self:_updateData()
	self:_updateUI()

	local count = DivineShiKongLongZunModel.instance:getChangeSetIdCount()

	for idx = 1, count do
		local changeSetId = DivineShiKongLongZunModel.instance:popChangeSetId()

		if changeSetId then
			MaterialController.instance:showChangeSetInTemp(changeSetId)
		end
	end
end

function DivineShiKongLongZunLevelView:_updateData()
	self._curShowStageId = DivineShiKongLongZunModel.instance:getCurShowStageId(self._activityId)
	self._stageDatas = DivineShiKongLongZunConfig.instance:getDivineTsDragonLoardClgStageData(self._activityId)
	self._curStageData = DivineShiKongLongZunConfig.instance:getStageData(self._activityId, self._curShowStageId)
	self._stageRule = self._curStageData.rule or "找不到数据"
	self._stageExpression = DivineShiKongLongZunController.instance:getPassExpression(self._activityId, self._curShowStageId)
	self._totalScoreArr = DivineShiKongLongZunModel.instance:getTotalScoreArr(self._activityId, self._curShowStageId)
	self._curTeamsData = {}

	for index, creepsMasterId in ipairs(self._curStageData.teams) do
		local cur = {}

		cur.teamId = index
		cur.team = creepsMasterId

		table.insert(self._curTeamsData, cur)
	end
end

function DivineShiKongLongZunLevelView:_updateUI()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._rule.transform)

	self._txtTotalScore.text = "<color=#FF0000FF>总计：</color>曙光:" .. self._totalScoreArr[1] .. " 黑暗:" .. self._totalScoreArr[2]
	self._txtRule.text = self._stageRule
	self._txtRequest.text = self._stageExpression

	self.scrollerList:reloadData(self._stageDatas)
	self.scrollerList2:reloadData(self._curTeamsData)
end

function DivineShiKongLongZunLevelView:_updateCell(view, cell, data, tag)
	local btn = goutil.findChild(cell, "btn")
	local prizeIcon = goutil.findChild(cell, "btn/prizeIcon")
	local txtprizeNum = goutil.findChildTextComponent(cell, "btn/txtprizeNum")
	local txtTitle = goutil.findChildTextComponent(cell, "btn/txtTitle")
	local txtStage = goutil.findChildTextComponent(cell, "btn/txtStage")
	local pass = goutil.findChild(cell, "btn/pass")
	local lockBg = goutil.findChild(cell, "btn/lockBg")
	local lockBg2 = goutil.findChild(cell, "btn/lockBg2")
	local stageId = data.stageId
	local isPass = DivineShiKongLongZunModel.instance:curShowStageIsPass(self._activityId, stageId)
	local isOpenTime = DivineShiKongLongZunModel.instance:isOpenTime(self._activityId, stageId)

	txtTitle.text = data.title
	txtStage.text = "第" .. stageId .. "层"

	GameUtil.SetActive(pass, isPass)

	if not isOpenTime and self._curShowStageId ~= stageId then
		GameUtil.SetActive(lockBg, not isOpenTime)
		GameUtil.SetActive(lockBg2, not isOpenTime)
	elseif not isPass and self._curShowStageId ~= stageId then
		GameUtil.SetActive(lockBg, not isPass)
		GameUtil.SetActive(lockBg2, not isPass)
	else
		GameUtil.SetActive(lockBg, false)
		GameUtil.SetActive(lockBg2, false)
	end

	if not string.nilorempty(data.passPrize) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.passPrize)

		MaterialMgr.setIcon(prizeIcon, matType, matId, nil, nil)

		if not self._isAoqiGodProcessType then
			GameUtil.addClickHandler(prizeIcon, function()
				CommonTipsMgr.instance:openMaterialTips(prizeIcon, matType, matId, matNum)
			end)
		end
	end

	GameUtil.SetActive(prizeIcon, not self._isAoqiGodProcessType)
	GameUtil.SetActive(txtprizeNum.gameObject, not self._isAoqiGodProcessType)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._clickCell, self, stageId))
end

function DivineShiKongLongZunLevelView:_clickCell(stageId)
	local isOpenTime = DivineShiKongLongZunModel.instance:isOpenTime(self._activityId, stageId)

	if not isOpenTime then
		local stageOpenDay = self._stageDatas[stageId].openDay - 1
		local stageTimeSecond = self._actStartTime + 86400 * stageOpenDay
		local remainDay = GameUtil.getDaysByTimestamp(ServerTime.now(), stageTimeSecond)

		FloatWordMgr.instance:show("将于" .. GameUtil.formatTimeStamp("%Y-%m.%d", stageTimeSecond) .. " 开启")

		return
	end

	if stageId > self._curShowStageId then
		FloatWordMgr.instance:show("请先通关上一层")

		return
	end

	if stageId < self._curShowStageId then
		FloatWordMgr.instance:show("已完成该关卡，无法返回")

		return
	end
end

function DivineShiKongLongZunLevelView:_clearCell(cell)
	local prizeIcon = goutil.findChild(cell, "btn/prizeIcon")
	local btn = goutil.findChild(cell, "btn")

	GameUtil.rmClickHandler(btn)
	GameUtil.rmClickHandler(prizeIcon)
	MaterialMgr.clearIcon(prizeIcon)
end

function DivineShiKongLongZunLevelView:_updateCell2(view, cell, data, tag)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local pass = goutil.findChild(cell, "btnChallenge/pass")
	local fmt = goutil.findChild(cell, "btnChallenge/fmt")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local fmtData = DivineShiKongLongZunConfig.instance:getDivineTsDragonLoardClgCreepsData(data.team)
	local isPass = DivineShiKongLongZunModel.instance:curTeamIsPass(self._activityId, self._curShowStageId, data.teamId)
	local teamScore = DivineShiKongLongZunModel.instance:getStageTeamScore(self._activityId, self._curShowStageId, data.teamId)

	txtScore.text = isPass and "<color=#fff1ba>曙光:</color><color=#6bf4ff>" .. teamScore[1] .. "</color> <color=#fff1ba>   黑暗:</color><color=#6bf4ff>" .. teamScore[2] .. "</color>" or "<color=#fff1ba>敌阵</color>"

	self:_showFromCell(fmt, fmtData)
	GameUtil.SetActive(pass, isPass)
	GameUtil.addClickHandler(btnChallenge, function()
		if isPass and DivineShiKongLongZunModel.instance:curShowStageIsPass(self._activityId, self._curShowStageId) then
			FloatWordMgr.instance:show("已通关，无法再次挑战")

			return
		end

		if self._isAoqiGodProcessType then
			local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				return
			end
		end

		DivineShiKongLongZunController.instance:enterBattleClg(self._activityId, self._curShowStageId, data.teamId)
	end)
end

function DivineShiKongLongZunLevelView:_clearCell2(cell)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")

	self:_clearFromCell(cell)
	GameUtil.rmClickHandler(btnChallenge)
end

function DivineShiKongLongZunLevelView:_showFromCell(fmtView, cfg)
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, 9 do
		local creepsData = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)

		if creepsData then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function DivineShiKongLongZunLevelView:_clearFromCell(cell)
	local fmtView = goutil.findChild(cell, "btnChallenge/fmt")

	for posId = 1, 9 do
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
	end
end

function DivineShiKongLongZunLevelView:_onClickBtnTip()
	local key = DivineShiKongLongZunConfig.instance:getCommonValue(self._activityId, "ruleKeyLevel")

	TipsFacade.instance:openRulesView(key)
end

return DivineShiKongLongZunLevelView
