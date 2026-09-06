-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/view/OriginOrderDragonClgStageView.lua

module("logic.extensions.originorderdragonclg.view.OriginOrderDragonClgStageView", package.seeall)

local OriginOrderDragonClgStageView = class("OriginOrderDragonClgStageView", ViewComponent)

function OriginOrderDragonClgStageView:ctor()
	OriginOrderDragonClgStageView.super.ctor(self)
end

function OriginOrderDragonClgStageView:unbindEvents()
	OriginOrderDragonClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnRank)

	for _, cell in ipairs(self._stageCellList) do
		GameUtil.rmClickHandler(cell.go)
	end
end

function OriginOrderDragonClgStageView:bindEvents()
	OriginOrderDragonClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)

	for i, cell in ipairs(self._stageCellList) do
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickStageCell, self, i))
	end
end

function OriginOrderDragonClgStageView:buildUI()
	OriginOrderDragonClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnReset = self:getGo("btnReset")
	self._stageCellList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("stages/stage" .. i)
		cell.select = goutil.findChild(cell.go, "select")
		cell.score = goutil.findChild(cell.go, "score")
		cell.txtScore = goutil.findChildTextComponent(cell.score, "txt")
		cell.txtName = goutil.findChildTextComponent(cell.go, "name/txt")

		table.insert(self._stageCellList, cell)
	end

	self._txtDesc = self:getTxt("txtDesc")
	self._unpass = self:getGo("unpass")
	self._txtTotalScore = self:getTxt("totalScore/txt")
	self._btnRank = self:getGo("btnRank")
end

function OriginOrderDragonClgStageView:onExit()
	OriginOrderDragonClgStageView.super.onExit(self)
	self:_setLastSelectId()
end

function OriginOrderDragonClgStageView:onEnter()
	OriginOrderDragonClgStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginOrderDragonClgGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_OriginOrderDragonClgResetRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 568001
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()

	local lastSelectId = self:_getLastSelectId()

	lastSelectId = math.min(lastSelectId, #self._stageCfgs)

	if lastSelectId == 0 then
		lastSelectId = 1
	end

	self:_switchToStage(lastSelectId)
	OriginOrderDragonClgController.instance:getInfo(self._activityId)
end

function OriginOrderDragonClgStageView:_updateUIByCfg()
	self._stageCfgs = OriginOrderDragonClgConfig.instance:getStageCfgs(self._activityId) or {}

	for i = 1, #self._stageCellList do
		local cell = self._stageCellList[i]
		local cfg = self._stageCfgs[i]

		if cfg then
			goutil.setActive(cell.go, true)

			cell.txtName.text = string.format("第%s关", cfg.stageId)
		else
			goutil.setActive(cell.go, false)
		end
	end
end

function OriginOrderDragonClgStageView:_updateUIByInfo()
	local hasGainPrize = false

	self._totalMaxScore = 0

	local stageInfoMap = OriginOrderDragonClgModel.instance:getStageInfoMap(self._activityId) or {}

	self._isPassMap = {}

	for i = 1, #self._stageCellList do
		local cell = self._stageCellList[i]
		local stageInfo = stageInfoMap[i]

		if stageInfo then
			if not stageInfo.raceIds then
				local raceIds = {}

				if not stageInfo.score then
					local score = 0

					cell.txtScore.text = string.format("得分：%d", score)
					self._isPassMap[i] = #raceIds > 0
				end
			end
		else
			cell.txtScore.text = "未挑战"
		end
	end

	local info = OriginOrderDragonClgModel.instance:getInfoByActId(self._activityId)

	if info then
		self._totalMaxScore = info.histoyMaxScore or 0
		hasGainPrize = info.hasGainPrize or false
	end

	self._txtTotalScore.text = string.format("总分：%d", self._totalMaxScore)

	goutil.setActive(self._unpass, not hasGainPrize)
end

function OriginOrderDragonClgStageView:_getLastSelectId()
	local saveKey = string.format("OriginOrderDragonClgStageView_LastSelectId_%d", self._activityId)
	local strId = GameUtil.getUserData(saveKey) or "1"

	return checknumber(strId)
end

function OriginOrderDragonClgStageView:_setLastSelectId()
	local saveKey = string.format("OriginOrderDragonClgStageView_LastSelectId_%d", self._activityId)

	GameUtil.saveUserData(saveKey, tostring(self._curStageId))
end

function OriginOrderDragonClgStageView:_switchToStage(stageId)
	self._curStageId = stageId

	for i, cell in ipairs(self._stageCellList) do
		if i == stageId then
			goutil.setActive(cell.select, true)
		else
			goutil.setActive(cell.select, false)
		end
	end

	local stageCfg = self._stageCfgs[stageId]

	if stageCfg then
		self._txtDesc.text = stageCfg.showDesc or ""
	end
end

function OriginOrderDragonClgStageView:_onClickStageCell(index)
	self:_switchToStage(index)

	if not self._isPassMap[index] then
		if self._isPassMap[index] then
			UIStateManager.instance:push(ViewName.OriginOrderDragonClgInfoView, self._activityId, index)
		else
			OriginOrderDragonClgController.instance:showMissionView(self._activityId, index)
		end
	end
end

function OriginOrderDragonClgStageView:_onClickReset()
	local tips = "是否重置所有挑战数据?"

	TipsFacade.instance:openPopupWindow("提示", tips, function()
		OriginOrderDragonClgController.instance:reset(self._activityId)
	end)
end

function OriginOrderDragonClgStageView:_onClickRank()
	UIStateManager.instance:push(ViewName.GoddailyrankmainView, self._activityId)
end

function OriginOrderDragonClgStageView:_updateUIByRankInfo()
	self._myRank = -1

	local rankInfo = GodDailyRankModel.instance:getGodRankInfo(self._activityId)

	if rankInfo then
		self._myRank = rankInfo.myRank or -1
	end

	goutil.setActive(self._unpass, self._myRank <= 0)
end

return OriginOrderDragonClgStageView
