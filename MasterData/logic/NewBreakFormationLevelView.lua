-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewBreakFormationLevelView.lua

module("logic.extensions.newbreakformation.view.NewBreakFormationLevelView", package.seeall)

local NewBreakFormationLevelView = class("NewBreakFormationLevelView", ViewComponent)

function NewBreakFormationLevelView:ctor()
	NewBreakFormationLevelView.super.ctor(self)
end

function NewBreakFormationLevelView:unbindEvents()
	NewBreakFormationLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAllBuff)
	GameUtil.rmClickHandler(self._btnUniqueBuff)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRule)
end

function NewBreakFormationLevelView:bindEvents()
	NewBreakFormationLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnAllBuff, self._onClickAllBuff, self)
	GameUtil.addClickHandler(self._btnUniqueBuff, self._onClickUniqueBuff, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function NewBreakFormationLevelView:buildUI()
	NewBreakFormationLevelView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._btnRule = self:getGo("static/btnTip")
	self._btnAllBuff = self:getGo("allBuff")
	self._btnUniqueBuff = self:getGo("uniqueBuff")
	self._btnChallenge = self:getGo("btnChallenge")
	self._levelTableView = self:getGo("tabCol/tabScrollerview")
	self._levelTableCell = self:getGo("tabCol/tabScrollercell")
	self._txtName = self:getTxt("info/txtName")
	self._txtWeekScore = self:getTxt("info/txtWeekScore")
	self._txtSeasonScore = self:getTxt("info/txtSeasonScore")
	self._txtPassTime = self:getTxt("info/txtTime")
	self._txtFixBuff = self:getTxt("info/txtFixBuff")
	self._petCon = self:getGo("petCon/mask/con")
	self._allBuffAdd = self:getGo("allBuff/imgAdd")
	self._allBuffCon = self:getGo("allBuff/imgBg/imgCon")
	self._uniqueBuffAdd = self:getGo("uniqueBuff/imgAdd")
	self._uniqueBuffCon = self:getGo("uniqueBuff/imgBg/imgCon")
end

function NewBreakFormationLevelView:onExit()
	NewBreakFormationLevelView.super.onExit(self)
	uGuiUtil.clearImage(self._petCon)
	uGuiUtil.clearImage(self._allBuffCon)
	uGuiUtil.clearImage(self._uniqueBuffCon)
end

function NewBreakFormationLevelView:onEnter()
	NewBreakFormationLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.NewBreakFormationeSelectBuff, self.refreshView, self)

	self._levelTableList = ScrollerList.create(self._levelTableView, self._levelTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local param = self:getOpenParam()

	self._seasonId = param[1]
	self._tabId = param[2]

	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)

	self._periodId = NewBreakFormationController.instance:getPeriodId(tabCfg.periodPlanId)
	self._stageId = param[3] or 1

	if self._periodId < 0 then
		FloatWordMgr.instance:show(lang("已结束"))
		self:close()

		return
	end

	self._buffMap = NewBreakFormationModel.instance:getBuffMap(self._tabId)

	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)
	local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, self._periodId)

	self._stageCfg = NewBreakFormationConfig.instance:getStageCfg(periodCfg.stagePlanId, self._stageId)

	local stageInfo = NewBreakFormationModel.instance:getStageInfo(self._seasonId, self._tabId, self._periodId, self._stageId)

	if self._stageCfg.petBuffPlan > 0 then
		if (not self._buffMap or not self._buffMap[self._stageId]) and stageInfo then
			local petRaceId1, petRaceId2

			if stageInfo.buffOption and stageInfo.buffOption.petBuff then
				petRaceId1 = stageInfo.buffOption.petBuff.raceIds[1]
				petRaceId2 = stageInfo.buffOption.petBuff.raceIds[2]
			end

			NewBreakFormationModel.instance:setPetBuffMap(self._tabId, self._stageId, petRaceId1, petRaceId2)
		end
	elseif (not self._buffMap or not self._buffMap[self._stageId]) and stageInfo then
		local allPetBuffId, specialBuffId

		if stageInfo.buffOption and stageInfo.buffOption.globalBuff then
			allPetBuffId = stageInfo.buffOption.globalBuff.allPetBuffId
			specialBuffId = stageInfo.buffOption.globalBuff.specialBuffId
		end

		NewBreakFormationModel.instance:setBuffMap(self._tabId, self._stageId, allPetBuffId, specialBuffId)
	end

	self:refreshView()
end

function NewBreakFormationLevelView:refreshView()
	self:refreshTab()
	self:refreshInfo()
	self:refreshBuff()
end

function NewBreakFormationLevelView:refreshTab()
	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)
	local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, self._periodId)
	local stageCfgs = NewBreakFormationConfig.instance:getStageCfgs(periodCfg.stagePlanId)

	self._levelTableList:reloadData(stageCfgs)
end

function NewBreakFormationLevelView:refreshInfo()
	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)
	local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, self._periodId)
	local stageCfg = NewBreakFormationConfig.instance:getStageCfg(periodCfg.stagePlanId, self._stageId)
	local stageInfo = NewBreakFormationModel.instance:getStageInfo(self._seasonId, self._tabId, self._periodId, self._stageId)
	local nextStageCfg = NewBreakFormationConfig.instance:getStageCfg(periodCfg.stagePlanId, self._stageId + 1)

	if stageInfo then
		local seasonScore = NewBreakFormationModel.instance:getTotalScoreByStage(self._seasonId, self._tabId, self._stageId)

		self._txtWeekScore.text = stageInfo.evenMaxscore
		self._txtSeasonScore.text = seasonScore

		if checknumber(stageInfo.time) > 0 then
			local passTime = GameUtil.time2date(checknumber(stageInfo.time) / 1000)

			self._txtPassTime.text = langPara("%d年%d月%d日 %d:%02d", passTime.year, passTime.month, passTime.day, passTime.hour, passTime.min)
		else
			self._txtPassTime.text = lang("尚未通关")
		end

		self._txtName.text = nextStageCfg and seasonScore < nextStageCfg.unlockScore and langPara("%s（积分达到<color=#21B273FF>%d</color>解锁%s）", stageCfg.name, nextStageCfg.unlockScore, nextStageCfg.name) or stageCfg.name
	else
		self._txtWeekScore.text = 0
		self._txtSeasonScore.text = 0
		self._txtPassTime.text = lang("尚未通关")
		self._txtName.text = nextStageCfg and langPara("%s（积分达到<color=#21B273FF>%d</color>解锁%s）", stageCfg.name, nextStageCfg.unlockScore, nextStageCfg.name) or stageCfg.name
	end

	self._txtFixBuff.text = stageCfg.buffDesc

	local creepCfg = NewBreakFormationConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)
	local showRaceId = creepCfg[1].raceId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. raceId)

		return
	end

	uGuiUtil.clearImage(self._petCon)
	uGuiUtil.setSpriteToImage(self._petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function NewBreakFormationLevelView:refreshBuff()
	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)
	local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, self._periodId)
	local stageCfg = NewBreakFormationConfig.instance:getStageCfg(periodCfg.stagePlanId, self._stageId)
	local allBuffCfg, uniqueBuffCfg, buffResName1, buffResName2

	self._buffMap = NewBreakFormationModel.instance:getBuffMap(self._tabId)

	if self._buffMap then
		local buffCache = self._buffMap[self._stageId]

		goutil.setActive(self._btnUniqueBuff.gameObject, true)

		if buffCache then
			if stageCfg.petBuffPlan > 0 then
				goutil.setActive(self._btnUniqueBuff.gameObject, stageCfg.selectPetBuffCount > 1)

				if buffCache.petRaceId1 then
					local petBuffCfg = NewBreakFormationConfig.instance:getPetBuffCfg(stageCfg.petBuffPlan, buffCache.petRaceId1)

					if petBuffCfg then
						buffResName1 = petBuffCfg.buffResName
					end
				end

				if buffCache.petRaceId2 then
					local petBuffCfg = NewBreakFormationConfig.instance:getPetBuffCfg(stageCfg.petBuffPlan, buffCache.petRaceId2)

					if petBuffCfg then
						buffResName2 = petBuffCfg.buffResName
					end
				end
			else
				if buffCache.allBuffId then
					local allBuffCfg = NewBreakFormationConfig.instance:getBuffCfg(stageCfg.allPetBuffPlan, buffCache.allBuffId)

					if allBuffCfg then
						buffResName1 = allBuffCfg.buffResName
					end
				end

				if buffCache.uniqueBuffId then
					local uniqueBuffCfg = NewBreakFormationConfig.instance:getBuffCfg(stageCfg.specialBuffPlan, buffCache.uniqueBuffId)

					if uniqueBuffCfg then
						buffResName2 = uniqueBuffCfg.buffResName
					end
				end
			end
		end

		GameUtil.SetActive(self._allBuffAdd, buffResName1 == nil)
		GameUtil.SetActive(self._allBuffCon, buffResName1 ~= nil)
		uGuiUtil.clearImage(self._allBuffCon)

		if buffResName1 then
			uGuiUtil.setSpriteToImage(self._allBuffCon, nil, buffResName1)
		end

		GameUtil.SetActive(self._uniqueBuffAdd, buffResName2 == nil)
		GameUtil.SetActive(self._uniqueBuffCon, buffResName2 ~= nil)
		uGuiUtil.clearImage(self._uniqueBuffCon)

		if buffResName2 then
			uGuiUtil.setSpriteToImage(self._uniqueBuffCon, nil, buffResName2)
		end
	end
end

function NewBreakFormationLevelView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local uichangeGroup = go:GetComponent(ComponentType.UIChangeGroup)
	local lockGo = goutil.findChild(go, "lockTip")

	if data.stageId == self._stageId then
		uichangeGroup:SetState(1)
	else
		uichangeGroup:SetState(0)
	end

	txtName.text = data.name

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickStage(data.stageId)
	end)

	local lastMaxScore = NewBreakFormationModel.instance:getTotalScoreByStage(self._seasonId, self._tabId, data.stageId - 1)

	GameUtil.SetActive(lockGo, lastMaxScore < data.unlockScore)
end

function NewBreakFormationLevelView:_clearCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function NewBreakFormationLevelView:_checkOpen()
	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)
	local periodId = NewBreakFormationController.instance:getPeriodId(tabCfg.periodPlanId)
	local isOpen = false

	if periodId > 0 then
		local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, periodId)

		isOpen, _ = GameUtil.checkTimeStr(tabCfg.openTime, periodCfg.startDateTime)
	end

	if isOpen == false then
		UIStateManager.instance:popByName(ViewName.NewBreakFormationeSelectView)
		FloatWordMgr.instance:show(lang("已关闭"))
		self:close()

		return
	end
end

function NewBreakFormationLevelView:_onClickStage(stageId)
	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)
	local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, self._periodId)
	local stageCfg = NewBreakFormationConfig.instance:getStageCfg(periodCfg.stagePlanId, stageId)
	local lastMaxScore = NewBreakFormationModel.instance:getTotalScoreByStage(self._seasonId, self._tabId, stageId - 1)

	if lastMaxScore < stageCfg.unlockScore then
		FloatWordMgr.instance:show(langPara("需要上一关达到%d分解锁本关", stageCfg.unlockScore))

		return
	else
		self._stageId = stageId

		local stageInfo = NewBreakFormationModel.instance:getStageInfo(self._seasonId, self._tabId, self._periodId, self._stageId)

		if (not self._buffMap or not self._buffMap[self._stageId]) and stageInfo then
			NewBreakFormationModel.instance:setBuffMap(self._tabId, self._stageId, stageInfo.allPetBuffId, stageInfo.specialBuffId)
		end

		self:refreshView()
	end
end

function NewBreakFormationLevelView:_onClickAllBuff()
	local petBuffPlan = self:_getPetBuffPlan()

	if petBuffPlan > 0 then
		UIStateManager.instance:push(ViewName.NewbreakformationpetbuffselectView, self._seasonId, self._tabId, self._periodId, self._stageId)

		return
	end

	UIStateManager.instance:push(ViewName.NewBreakFormationeSelectView, self._seasonId, self._tabId, self._periodId, self._stageId)
end

function NewBreakFormationLevelView:_onClickUniqueBuff()
	self:_onClickAllBuff()
end

function NewBreakFormationLevelView:_onClickChallenge()
	if self._buffMap then
		local buffCache = self._buffMap[self._stageId]

		if buffCache then
			if self._stageCfg.petBuffPlan > 0 then
				local raceId1 = checknumber(buffCache.petRaceId1)
				local raceId2 = checknumber(buffCache.petRaceId2)
				local fmtMo = NewBreakFormationModel.instance:getFmtMo()

				fmtMo:initParams(self._seasonId, self._tabId, self._periodId, self._stageId, nil, nil, raceId1, raceId2)
				CustomFmtController.instance:showMissionView(fmtMo)
			else
				local allBuffId = buffCache.allBuffId
				local uniqueBuffId = buffCache.uniqueBuffId

				if checknumber(allBuffId) > 0 and checknumber(uniqueBuffId) > 0 then
					local fmtMo = NewBreakFormationModel.instance:getFmtMo()

					fmtMo:initParams(self._seasonId, self._tabId, self._periodId, self._stageId, allBuffId, uniqueBuffId)
					CustomFmtController.instance:showMissionView(fmtMo)
				else
					FloatWordMgr.instance:show(lang("请选择两个增益才可开始挑战"))
				end
			end
		else
			FloatWordMgr.instance:show(lang("请选择增益才可开始挑战"))
		end
	end
end

function NewBreakFormationLevelView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "newbreakformation_rule")
end

function NewBreakFormationLevelView:_getPetBuffPlan()
	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)
	local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, self._periodId)
	local stageCfg = NewBreakFormationConfig.instance:getStageCfg(periodCfg.stagePlanId, self._stageId)

	return stageCfg.petBuffPlan
end

return NewBreakFormationLevelView
