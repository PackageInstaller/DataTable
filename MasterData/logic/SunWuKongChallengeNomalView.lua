-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeNomalView.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeNomalView", package.seeall)

local SunWuKongChallengeNomalView = class("SunWuKongChallengeNomalView", ViewComponent)

function SunWuKongChallengeNomalView:ctor()
	SunWuKongChallengeNomalView.super.ctor(self)
end

function SunWuKongChallengeNomalView:buildUI()
	SunWuKongChallengeNomalView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtTitle = self:getTxt("titleTxt")
	self._txtFromCodition = self:getTxt("stageConditionInfo/txtFormCondition/txt")
	self._txtWinCondition = self:getTxt("stageConditionInfo/txtWinCondition/txt")
	self._prizeTableView = self:getGo("prizeInfo/tableview")
	self._prizeTableCell = self:getGo("prizeInfo/item")
	self._enemyList = {}

	for i = 1, 9 do
		local enemyCon = {
			go = self:getGo("creepInfo/teamEnemy/cell_" .. i),
			icon = self:getGo("creepInfo/teamEnemy/cell_" .. i .. "/icon")
		}

		table.insert(self._enemyList, enemyCon)
	end
end

function SunWuKongChallengeNomalView:bindEvents()
	SunWuKongChallengeNomalView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function SunWuKongChallengeNomalView:unbindEvents()
	SunWuKongChallengeNomalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function SunWuKongChallengeNomalView:onEnter()
	SunWuKongChallengeNomalView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._levelIndex = params[2]
	self._activityCfg = SunWuKongChallengeConfig.instance:getActivityCfg(self._activityId)
	self._stageInfoCfg = SunWuKongChallengeConfig.instance:getStageCfg(self._activityCfg.stagePlanId, self._levelIndex)
	self._txtTitle.text = self._stageInfoCfg.name

	for i, v in ipairs(self._enemyList) do
		MaterialMgr.resetAll(v.icon)
		GameUtil.SetActive(v.go, false)
	end

	local creeps = SunWuKongChallengeConfig.instance:getCreepsCfg(self._stageInfoCfg.creepsMasterId)

	for i, v in ipairs(creeps) do
		if v.posId > 0 then
			local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, self._enemyList[v.posId].icon)

			GameUtil.SetActive(self._enemyList[v.posId].go, true)

			if proxy then
				proxy.binder:setAutoTips(false)
			end
		end
	end

	self._scrollList = ScrollerList.create(self._prizeTableView, self._prizeTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local prize = string.split(self._stageInfoCfg.passStagePrize, "#")

	self._scrollList:reloadData(prize)

	self._masterCfg = SunWuKongChallengeConfig.instance:getMasterTeamCfg(self._stageInfoCfg.creepsMasterId)

	local formConditionCfg = FormationValidatorConfig.instance:getFormationValidatorCfg(self._masterCfg.formCondition)

	self._txtFromCodition.text = formConditionCfg and formConditionCfg.desc or lang("无")
	self._txtWinCondition.text = self._masterCfg.ruleDesc

	GameUtil.SetActive(self._btnChallenge, self._levelIndex == SunWuKongChallengeModel.instance:getCurStageId(self._activityId))
end

function SunWuKongChallengeNomalView:onExit()
	SunWuKongChallengeNomalView.super.onExit(self)

	for i, v in ipairs(self._enemyList) do
		MaterialMgr.resetAll(v.icon)
		GameUtil.SetActive(v.go, false)
	end
end

function SunWuKongChallengeNomalView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function SunWuKongChallengeNomalView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function SunWuKongChallengeNomalView:_onClickChallenge()
	local fmtMo = SunWuKongChallengeModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, self._levelIndex)
	CustomFmtController.instance:showMissionView(fmtMo)
	self:close()
end

return SunWuKongChallengeNomalView
