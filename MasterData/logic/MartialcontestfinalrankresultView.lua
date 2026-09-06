-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalrankresultView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalrankresultView", package.seeall)

local MartialcontestfinalrankresultView = class("MartialcontestfinalrankresultView", ViewComponent)

function MartialcontestfinalrankresultView:ctor()
	MartialcontestfinalrankresultView.super.ctor(self)
end

function MartialcontestfinalrankresultView:unbindEvents()
	MartialcontestfinalrankresultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MartialcontestfinalrankresultView:bindEvents()
	MartialcontestfinalrankresultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function MartialcontestfinalrankresultView:buildUI()
	MartialcontestfinalrankresultView.super.buildUI(self)

	self._txtKill = self:getTxt("txtKill")
	self._txtScore = self:getTxt("txtScore")
	self._pettableviewGo = self:getGo("pettableview")
	self._bufftablecellGo = self:getGo("buffnode/bufftablecell")
	self._bufftableviewGo = self:getGo("buffnode/bufftableview")
	self._buffNodeGo = self:getGo("buffnode")
	self._pettablecellGo = self:getGo("pettablecell")
	self._btnClose = self:getBtn("btnClose")
	self._rankNum = self:getGo("rank/rankNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._imgNum = self:getGo("rank/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._buffscrollerList = ScrollerList.create(self._bufftableviewGo, self._bufftablecellGo, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._petscrollerList = ScrollerList.create(self._pettableviewGo, self._pettablecellGo, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._headGo = self:getGo("player/head")
	self._txtArea = self:getTxt("player/txtArea")
	self._txtName = self:getTxt("player/name/txtName")
	self._btnGotoGo = self:getGo("btnGoto")
	self._effectGo = self:getGo("effect")

	goutil.setActive(self._btnGotoGo, false)

	self._txtRound = self:getTxt("txtRound")
	self._txtBuffEmptyGo = self:getGo("buffnode/txtEmpty")
end

function MartialcontestfinalrankresultView:onExit()
	MartialcontestfinalrankresultView.super.onExit(self)
	self._petscrollerList:dispose()
	self._buffscrollerList:dispose()

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	HeadItemController.instance:resetHeadCell(self._headGo)
end

function MartialcontestfinalrankresultView:onEnter()
	MartialcontestfinalrankresultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.MCFinalsResultRes, self._onMCFinalsResultRes, self)

	local viewData = self:getFirstParam()

	self._finalsResultResMsg = finalsResultResMsg
	self._activityId = viewData.activityId
	self._stepId = viewData.stepId
	self._myBattleResult = viewData.myBattleResult
	self._lastScore = viewData.lastScore
	self._curScore = viewData.curScore
	self._deadCnt = viewData.deadCnt
	self._activeCnt = viewData.activeCnt
	self._battleCnt = viewData.battleCnt

	local userId = tostring(RoleModel.instance:getUserId())

	self._isTeamA = self._myBattleResult.playerUserIdA == userId

	local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, self._stepId)

	self._roundId = stepCfg.roundId

	self:_updateUI()
	MartialContestAgent.instance:sendPM_MCFinalsResultReq(self._activityId, self._stepId, self._myBattleResult.groupId)
end

function MartialcontestfinalrankresultView:_onClickbtnClose()
	self:close()
end

function MartialcontestfinalrankresultView:_onClickbtnShare()
	local shareData = {
		rank = LotusbattleModel.instance:getTopWinRank(),
		memberNum = self._modelCfg.memberNum,
		creepsIds = table.concat(LotusbattleModel.instance:getTopWinCreepsIds(), "#"),
		buffIds = table.concat(LotusbattleModel.instance:getTopWinBuffIds(), "#"),
		score = LotusbattleModel.instance:getTopWinScore(),
		killNum = LotusbattleModel.instance:getTopWinKillNum(),
		buffPlanId = self._modelCfg.buffPlanId,
		rankPlanId = self._modelCfg.rankPlanId
	}

	UIStateManager.instance:open(ViewName.Share, GameEnum.ShareType.LotusBattle, shareData)
end

function MartialcontestfinalrankresultView:_updateUI()
	self._txtRound.text = MartialContestController.instance:getFinalsRoundDesc(self._activityId, self._stepId, self._roundId)

	self:_setRank()
	self:_setMyHead()

	local roundCfg = MartialContestConfig.instance:getRoundCfg(self._activityId, self._roundId)

	goutil.setActive(self._buffNodeGo, roundCfg.roundType == "FINALS_BUFF")
end

function MartialcontestfinalrankresultView:_setBuff(buffIds)
	self._buffscrollerList:reloadData(buffIds)
	goutil.setActive(self._txtBuffEmptyGo, not buffIds or #buffIds == 0)
end

function MartialcontestfinalrankresultView:_setPets(raceIds)
	self._petscrollerList:reloadData(raceIds)
end

function MartialcontestfinalrankresultView:_updateBuffCell(view, cell, buffId, tag)
	local buffCfg = MartialContestConfig.instance:getFinalsBuffCfg(self._activityId, buffId)
	local btnIcon = Framework.ButtonAdapter.Get(cell.gameObject)

	uGuiUtil.clearImage(btnIcon.gameObject)

	local spriteName = GameUrl.getExpEventUrl(buffCfg.icon)

	uGuiUtil.setSpriteToImage(btnIcon.gameObject, nil, spriteName)
	btnIcon:AddClickListener(function()
		local data = MartialContestConfig.instance:getBuffTipSimpleData(self._activityId, buffId)

		CommonTipsMgr.instance:openBuffTipView(data, cell.gameObject)
	end)
end

function MartialcontestfinalrankresultView:_clearBuffCell(cell)
	uGuiUtil.clearImage(cell.gameObject)
end

function MartialcontestfinalrankresultView:_updatePetCell(view, cell, raceId, tag)
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)

	proxy.binder:setCallBack(function()
		CommonTipsMgr.instance:showMaxLvlPetTips(raceId)
	end)
end

function MartialcontestfinalrankresultView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function MartialcontestfinalrankresultView:_setRank()
	local curScore = self._curScore
	local lastScore = self._lastScore
	local addScore = curScore - lastScore

	self._txtKill.text = string.format("淘汰人数：<color=#fdffd1>%s</color>", self._deadCnt)
	self._txtScore.text = string.format("%s+<color=green>%s</color>", lastScore, addScore)

	self._rankNum:SetNum(self._activeCnt)
	self._imgNum:SetNum(self._battleCnt)
end

function MartialcontestfinalrankresultView:_getCreepsCfgs(creepsIds)
	local list = {}

	for i, creepsId in ipairs(creepsIds) do
		local cfg = LotusbattleConfig.instance:getCreepsCfg(creepsId)

		table.insert(list, cfg)
	end

	return list
end

function MartialcontestfinalrankresultView:_setMyHead()
	HeadItemController.instance:setMyHeadCell(self._headGo)

	self._txtName.text = RoleModel.instance:getUserName()
	self._txtArea.text = RoleModel.instance:getAreaName()
end

function MartialcontestfinalrankresultView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_jiesuanjiemian.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function MartialcontestfinalrankresultView:_onMCFinalsResultRes(msg)
	local buffIds
	local raceIds = {}

	buffIds = self._isTeamA and msg.buffIdsA or msg.buffIdsB

	for i, v in ipairs(msg.battles) do
		if self._isTeamA then
			table.insertto(raceIds, v.teamARaceIds)
		else
			table.insertto(raceIds, v.teamBRaceIds)
		end
	end

	self:_setBuff(buffIds)
	self:_setPets(raceIds)
end

return MartialcontestfinalrankresultView
