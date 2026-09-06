-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/view/SwordStormMainView.lua

module("logic.extensions.swordstorm.view.SwordStormMainView", package.seeall)

local SwordStormMainView = class("SwordStormMainView", ViewComponent)

function SwordStormMainView:ctor()
	SwordStormMainView.super.ctor(self)
end

function SwordStormMainView:unbindEvents()
	SwordStormMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnJump)
end

function SwordStormMainView:bindEvents()
	SwordStormMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickJump, self)
end

function SwordStormMainView:buildUI()
	SwordStormMainView.super.buildUI(self)

	self._btnTip = self:getGo("btnTip")
	self._btnClose = self:getGo("btnClose")
	self._chapterTableview = self:getGo("chapterTableview")
	self._chapterTablecell = self:getGo("chapterTableview/chapterTablecell")
	self._chapterTableList = ScrollerList.create(self._chapterTableview, self._chapterTablecell, GameUtil.handler(self._updateChapterCell, self), GameUtil.handler(self._clearChapterCell, self))
	self._stageTableview = self:getGo("stageTableview")
	self._stageTablecell = self:getGo("stageTableview/stageTablecell")
	self._stageTableList = ScrollerList.create(self._stageTableview, self._stageTablecell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._stageGroup = self:getGo("stageGroup")
	self._stagePosRecord = self._stageGroup:GetComponent(ComponentType.TestRecordPos)
	self._btnJump = self:getGo("btnJump")
	self._txtTime = self:getTxt("time/txtTime")
end

function SwordStormMainView:onExit()
	SwordStormMainView.super.onExit(self)
	self._chapterTableList:dispose()
	self._stageTableList:dispose()
end

function SwordStormMainView:onEnter()
	SwordStormMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SwordStormGetInfoRes, self._PM_SwordStormGetInfoRes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 579001
	end

	self._activityCfg = SwordStormConfig.instance:getActivityCfg(self._activityId)
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	SwordStormAgent.instance:sendPM_SwordStormGetInfoReq(self._activityId)
end

function SwordStormMainView:_refreshView()
	local phaseCfgs = SwordStormConfig.instance:getPhaseCfgs(self._activityId)

	self._chapterTableList:reloadData(phaseCfgs)

	local stageCfgs = SwordStormConfig.instance:getStageCfgs(self._activityId, self._phaseId)

	GameUtil.updateCellsList(self._stageGroup, self._stageTablecell, stageCfgs, self._updateStageCell, self)
	self._stagePosRecord:LoadPlan(0)
end

function SwordStormMainView:_updateChapterCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local redPoint = goutil.findChild(go, "redpoint")
	local lockMaskGo = goutil.findChild(go, "mask")
	local txtOpenTime = goutil.findChildTextComponent(lockMaskGo, "txtOpenTime")
	local selectGo = goutil.findChild(go, "select")
	local openDate = GameUtil.string2date(data.openTime)
	local openTime = GameUtil.string2time(data.openTime)

	txtOpenTime.text = langPara("%d.%d.%d开启", openDate.year, openDate.month, openDate.day)

	GameUtil.SetActive(lockMaskGo, openTime > ServerTime.now())
	GameUtil.SetActive(selectGo, self._phaseId == data.phaseId)

	txtName.text = langPara("第%s章", GameUtil.getChineseNumber(data.phaseId))

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickChapter(data.phaseId)
	end)

	if string.nilorempty(data.redPoint) then
		GameUtil.SetActive(redPoint, false)
	else
		RedPointController.instance:regRedPoint(redPoint, data.redPoint)
	end
end

function SwordStormMainView:_clearChapterCell(cell)
	local go = cell.gameObject
	local redPoint = goutil.findChild(go, "redpoint")

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.rmClickHandler(go)
end

function SwordStormMainView:_updateStageCell(cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtStar = goutil.findChildTextComponent(go, "txtStar")
	local btnChallenge = goutil.findChild(go, "btnChallenge")
	local petCon = goutil.findChild(go, "mask/petCon")
	local creepsCfgs = SwordStormConfig.instance:getCreepsCfg(data.creepsMasterId)
	local showRaceId = creepsCfgs[1].raceId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. raceId)

		return
	end

	uGuiUtil.clearImage(petCon)
	uGuiUtil.setSpriteToImage(petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	txtName.text = creepsCfgs[1].creepsName

	local conditionCfgs = SwordStormConfig.instance:getConditionPlanCfgs(data.conditionPlanId)
	local completeCount = 0

	for i, v in ipairs(conditionCfgs) do
		if SwordStormModel.instance:getConditionComplete(self._activityId, self._phaseId, data.stageId, v.conditionId) == true then
			completeCount = completeCount + 1
		end
	end

	txtStar.text = langPara("%d/%d", completeCount, #conditionCfgs)

	GameUtil.rmClickHandler(btnChallenge)
	GameUtil.addClickHandler(btnChallenge, function()
		self:_onClickChallenge(data.stageId)
	end)
end

function SwordStormMainView:_clearStageCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "mask/petCon")

	uGuiUtil.clearImage(petCon)
end

function SwordStormMainView:_onClickChallenge(stageId)
	UIStateManager.instance:push(ViewName.SwordStormDetailView, self._activityId, self._phaseId, stageId)
end

function SwordStormMainView:_onClickChapter(phaseId)
	local phaseCfg = SwordStormConfig.instance:getPhaseCfg(self._activityId, phaseId)
	local openTime = GameUtil.string2time(phaseCfg.openTime)

	if openTime > ServerTime.now() then
		FloatWordMgr.instance:show(lang("未到开启时间"))
	else
		SwordStormModel.instance:setTempPhaseId(phaseId)

		self._phaseId = phaseId

		if not string.nilorempty(phaseCfg.redPoint) then
			RedPointController.instance:saveUserOnceRedPoint(phaseCfg.redPoint, true)
		end

		self:_refreshView()
	end
end

function SwordStormMainView:_onClickTip()
	TipsFacade.instance:openRulesView("sword_storm_rule")
end

function SwordStormMainView:_onClickClose()
	SwordStormModel.instance:setTempPhaseId(nil)
	self:close()
end

function SwordStormMainView:_onClickJump()
	if not string.nilorempty(self._activityCfg.jumpTo) then
		GotoMgr.gotoByString(self._activityCfg.jumpTo)
	end
end

function SwordStormMainView:_PM_SwordStormGetInfoRes()
	self._phaseId = SwordStormModel.instance:getTempPhase()

	if not self._phaseId then
		self._phaseId = 1

		SwordStormModel.instance:setTempPhaseId(1)
	end

	self:_refreshView()
end

return SwordStormMainView
