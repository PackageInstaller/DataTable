-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/view/OriginGoldenDragonClgResultView.lua

module("logic.extensions.origingoldendragonclg.view.OriginGoldenDragonClgResultView", package.seeall)

local OriginGoldenDragonClgResultView = class("OriginGoldenDragonClgResultView", ViewComponent)

function OriginGoldenDragonClgResultView:ctor()
	OriginGoldenDragonClgResultView.super.ctor(self)
end

function OriginGoldenDragonClgResultView:unbindEvents()
	OriginGoldenDragonClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function OriginGoldenDragonClgResultView:bindEvents()
	OriginGoldenDragonClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function OriginGoldenDragonClgResultView:buildUI()
	OriginGoldenDragonClgResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._txtScore = self:getTxt("info/txtScore")
	self._imgResult = self:getGo("info/imgResult")

	local goTableview = self:getGo("info/prophecy/tableview")
	local goCell = self:getGo("info/prophecy/tableview/tablecell")

	self._tableview = ScrollerList.create(goTableview, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginGoldenDragonClgResultView:onExit()
	OriginGoldenDragonClgResultView.super.onExit(self)
	self._tableview:dispose()
end

function OriginGoldenDragonClgResultView:onEnter()
	OriginGoldenDragonClgResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginGoldenDragonClgConfirmRes, self._handleConfirm, self)

	local lastFightInfo = self:getFirstParam()

	if lastFightInfo == nil then
		self:_onClickCancel()

		return
	end

	self._activityId = lastFightInfo.activityId
	self._stageId = lastFightInfo.stageId

	if not lastFightInfo.win then
		local isWin = false

		if not lastFightInfo.preStageProphecyInfos then
			local preStageProphecyInfos = {}
			local curSelectProphecyId = OriginGoldenDragonClgController.instance:getCurSelectProphecyId()
			local resultBattle = BattleModel.instance.battleResult

			GameUtil.setUIImageSpriteIdx(self._imgResult, (resultBattle == GameEnum.BattleResult.ExpSuccess or resultBattle == GameEnum.BattleResult.Success or nil) and 1)

			local curScore = 0
			local preHitCount = 0
			local baseScore = 0
			local dataList = {}
			local curStateData = {}

			curStateData.prophecyId = curSelectProphecyId
			curStateData.isHit = isWin
			curStateData.isCurStage = true

			table.insert(dataList, curStateData)

			local scoreCfg = OriginGoldenDragonClgConfig.instance:getProphecyCfgById(self._activityId, curSelectProphecyId)

			if scoreCfg then
				baseScore = scoreCfg.baseScore or 0
			end

			for _, prophecyInfo in ipairs(preStageProphecyInfos) do
				local prophecyData = {}

				prophecyData.prophecyId = prophecyInfo.prophecyId
				prophecyData.isHit = prophecyInfo.hit or false
				prophecyData.isCurStage = false

				table.insert(dataList, prophecyData)

				if prophecyData.isHit then
					preHitCount = preHitCount + 1
				end
			end

			self._tableview:setCenterMode(true)
			self._tableview:reloadData(dataList)

			if lastFightInfo.win then
				local rate = OriginGoldenDragonClgConfig.instance:getScoreRateByHitCount(self._activityId, preHitCount)

				curScore = baseScore * rate
			end

			self._txtScore.text = tostring(curScore)
			self._needSendMsg = lastFightInfo.win
		end
	end
end

function OriginGoldenDragonClgResultView:_onClickSure()
	if self._needSendMsg then
		OriginGoldenDragonClgController.instance:confirmResult(self._activityId, self._stageId, true)
	else
		self:_handleConfirm()
	end
end

function OriginGoldenDragonClgResultView:_onClickCancel()
	if self._needSendMsg then
		OriginGoldenDragonClgController.instance:confirmResult(self._activityId, self._stageId, false)
	else
		self:_handleConfirm()
	end
end

function OriginGoldenDragonClgResultView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local imgResult = goutil.findChild(go, "imgResult")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local prophecyCfg = OriginGoldenDragonClgConfig.instance:getProphecyCfgById(self._activityId, data.prophecyId)

	txtName.text = prophecyCfg and (prophecyCfg.name or "") or ""

	if not data.isHit then
		local isHit = false
		local idImgShow = isHit and 1 or 0

		GameUtil.setUIImageSpriteIdx(imgResult, idImgShow)

		local markCur = goutil.findChild(go, "markCur")

		goutil.setActive(markCur, data.isCurStage == true)
	end
end

function OriginGoldenDragonClgResultView:_clearCell(cell)
	return
end

function OriginGoldenDragonClgResultView:_handleConfirm()
	self:close()
	BattleController.instance:endBattle()
end

return OriginGoldenDragonClgResultView
