-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/view/OriginLightDimensionNormalView.lua

module("logic.extensions.originlightdimension.view.OriginLightDimensionNormalView", package.seeall)

local OriginLightDimensionNormalView = class("OriginLightDimensionNormalView", ViewComponent)

function OriginLightDimensionNormalView:ctor()
	OriginLightDimensionNormalView.super.ctor(self)
end

function OriginLightDimensionNormalView:unbindEvents()
	OriginLightDimensionNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginLightDimensionNormalView:bindEvents()
	OriginLightDimensionNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriginLightDimensionNormalView:buildUI()
	OriginLightDimensionNormalView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._stageTableCell = self:getGo("stageTableCell")
	self._stageTableView = self:getGo("stageTableView")
	self._stageTableList = ScrollerList.create(self._stageTableView, self._stageTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._stageTableList:setCenterMode(true)

	self._txtFightCount = self:getTxt("txtFightCount")
end

function OriginLightDimensionNormalView:onExit()
	OriginLightDimensionNormalView.super.onExit(self)
end

function OriginLightDimensionNormalView:onEnter()
	OriginLightDimensionNormalView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginLightDimensionGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_OriginLightDimensionNotifyNormalClgRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	self:_refreshView()
end

function OriginLightDimensionNormalView:_refreshView()
	local stageCfgs = OriginLightDimensionConfig.instance:getNormalStageCfgs(self._activityId)

	self._stageTableList:reloadData(stageCfgs)

	if OriginLightDimensionModel.instance:getMaxNormalPassStage(self._activityId) >= #stageCfgs then
		self:close()

		return
	end

	local curStageId = OriginLightDimensionModel.instance:getMaxNormalPassStage(self._activityId) + 1

	if curStageId > #stageCfgs then
		curStageId = #stageCfgs
	end

	self._stageTableList:MoveCellToCenter(curStageId - 1)

	local activityCfg = OriginLightDimensionConfig.instance:getActivityCfg(self._activityId)
	local challengeCount = OriginLightDimensionModel.instance:getNormalChallengeCount(self._activityId)

	self._txtFightCount.text = langPara("当前剩余挑战次数：%s/%s", challengeCount, activityCfg.normalClgCountStorage)
end

function OriginLightDimensionNormalView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local maskGo = goutil.findChild(teamEnemy, "mask")
	local passGo = goutil.findChild(maskGo, "pass")
	local nextGo = goutil.findChild(maskGo, "next")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local enemyCellMap = {}

	for i = 1, 9 do
		local enemyCell = {}

		enemyCell.cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		enemyCell.con = goutil.findChild(enemyCell.cellGo, "con")
		enemyCellMap[i] = enemyCell

		GameUtil.SetActive(enemyCell.cellGo, false)
	end

	local btnChallenge = goutil.findChild(go, "btnChallenge")
	local creepsCfg = OriginLightDimensionConfig.instance:getCreepsCfg(data.creepsMasterId)

	for i, v in ipairs(creepsCfg) do
		local enemyCell = enemyCellMap[v.posId]

		if enemyCell then
			MaterialMgr.resetAll(enemyCell.con)
			MaterialMgr.setIcon(enemyCell.con, MatType.Pet, v.raceId)
			GameUtil.SetActive(enemyCell.cellGo, true)
		end
	end

	txtName.text = langPara("第%s关", GameUtil.getChineseNumber(data.stageId))

	GameUtil.rmClickHandler(btnChallenge)
	GameUtil.addClickHandler(btnChallenge, function()
		self:_onClickChallenge(data.stageId)
	end, self)

	local curStageId = OriginLightDimensionModel.instance:getMaxNormalPassStage(self._activityId) + 1

	GameUtil.SetActive(maskGo, curStageId ~= data.stageId)
	GameUtil.SetActive(passGo, curStageId > data.stageId)
	GameUtil.SetActive(nextGo, curStageId < data.stageId)
end

function OriginLightDimensionNormalView:_clearCell(cell)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local con = goutil.findChild(cellGo, "con")

		GameUtil.SetActive(cellGo, false)
		MaterialMgr.resetAll(con)
	end

	local btnChallenge = goutil.findChild(go, "teamEnemy")

	GameUtil.rmClickHandler(btnChallenge)
end

function OriginLightDimensionNormalView:_onClickChallenge(stageId)
	local challengeCount = OriginLightDimensionModel.instance:getNormalChallengeCount(self._activityId)
	local curStageId = OriginLightDimensionModel.instance:getMaxNormalPassStage(self._activityId) + 1

	if challengeCount <= 0 then
		FloatWordMgr.instance:show(lang("已无挑战次数"))
	elseif curStageId == stageId then
		OriginLightDimensionController.instance:openNormalMissionView(self._activityId, stageId)
	elseif curStageId < stageId then
		FloatWordMgr.instance:show(lang("请通关上一个关卡"))
	else
		FloatWordMgr.instance:show(lang("已通关"))
	end
end

return OriginLightDimensionNormalView
