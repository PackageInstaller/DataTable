-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterAlchemyMMMainView.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterAlchemyMMMainView", package.seeall)

local DreamTeamChapterAlchemyMMMainView = class("DreamTeamChapterAlchemyMMMainView", ViewComponent)

function DreamTeamChapterAlchemyMMMainView:ctor()
	DreamTeamChapterAlchemyMMMainView.super.ctor(self)
end

function DreamTeamChapterAlchemyMMMainView:unbindEvents()
	DreamTeamChapterAlchemyMMMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function DreamTeamChapterAlchemyMMMainView:bindEvents()
	DreamTeamChapterAlchemyMMMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
end

function DreamTeamChapterAlchemyMMMainView:buildUI()
	DreamTeamChapterAlchemyMMMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnStart = self:getGo("progressCol/btnStart/btn")
	self._con = self:getGo("con")
	self._scrCell = self:getGo("progressCol/scrCell")
	self._scrView = self:getGo("progressCol/scrView")
	self._txtNum = self:getTxt("progressCol/total/txtNum")
	self._progressBar = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._tableviewViewport = self:getGo("progressCol/scrView/Viewport")
	self._scrView = self:getGo("progressCol/scrView")
	self._scrCell = self:getGo("progressCol/scrCell")
	self._scrollList = ScrollerList.create(self._scrView, self._scrCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DreamTeamChapterAlchemyMMMainView:onExit()
	DreamTeamChapterAlchemyMMMainView.super.onExit(self)
	MaterialMgr.resetAll(self._role)
	self._scrollList:dispose()
end

function DreamTeamChapterAlchemyMMMainView:onEnter()
	DreamTeamChapterAlchemyMMMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterOneClickGainProgressPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 595001
	end

	self._mmId = checknumber(params[2])
	self._actCfg = DreamTeamChapterConfig.instance:getActivityCfg(self._activityId)
	self._awakeMMCfg = DreamTeamChapterConfig.instance:getAwakeMMCfgById(self._activityId, self._mmId)

	self:_onSetUI()
	self:_onUpdate()

	local key = string.format(DreamTeamChapterController.ALCHEMY_MM_DAY_KEY, self._activityId)

	GameUtil.saveUserDayData(key, true)
end

function DreamTeamChapterAlchemyMMMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = self._awakeMMCfg.skinId
	local petName
	local petData = CharacterConfig.instance:getPetCo(skinId)

	if petData then
		self._txtName.text = petData.name
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end
end

function DreamTeamChapterAlchemyMMMainView:_onUpdate()
	self._info = DreamTeamChapterModel.instance:getInfo(self._activityId)
	self._progressInfoMap = DreamTeamChapterModel.instance:getProgressInfoMap(self._activityId)

	local progressCfgs = DreamTeamChapterConfig.instance:getProgressPlanCfgs(self._activityId, DreamTeamChapterController.progressTypeEnum.AlchemyMM)
	local scoreList = {}

	for i, v in ipairs(progressCfgs) do
		table.insert(scoreList, checknumber(v.progress))
	end

	self._txtNum.text = self._info.alchemyScore

	self._scrollList:updateUnderSlider(self._progressBar, checknumber(self._info.alchemyScore), scoreList)
	self._scrollList:reloadData(progressCfgs)
end

function DreamTeamChapterAlchemyMMMainView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effectRoot")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local hasGet = false

	txtScore.text = data.progress

	MaterialMgr.setCellByCfg(data.prize, item)

	if self._info then
		local finishIds = checknumber(self._info.alchemyScore)
		local isCanGet = finishIds >= checknumber(data.progress)
		local maxGainProgressId = checknumber(self._progressInfoMap[data.progressType]) or 0

		hasGet = maxGainProgressId >= data.progressId

		GameUtil.SetActive(received, hasGet)
		GameUtil.SetActive(btnGet, isCanGet and not hasGet)
		self:_clearCellEffect(effect)

		if isCanGet and not hasGet then
			self:_playCellEffect(effect)
		end

		GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
	end
end

function DreamTeamChapterAlchemyMMMainView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effectRoot")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

function DreamTeamChapterAlchemyMMMainView:_playCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)

	local eff = self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effGo, self._tableviewViewport.transform, true, nil, nil)
end

function DreamTeamChapterAlchemyMMMainView:_clearCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)
end

function DreamTeamChapterAlchemyMMMainView:_onClickGetPrize(data)
	local maxGainProgressId = checknumber(self._progressInfoMap[data.progressType]) or 0
	local hasGet = maxGainProgressId >= data.progressId

	if not hasGet then
		local finishIds = checknumber(self._info.alchemyScore)
		local isCanGet = finishIds >= checknumber(data.progress)

		if isCanGet then
			DreamTeamChapterController.instance:sendPM_DreamTeamChapterOneClickGainProgressPrizeReq(self._activityId, DreamTeamChapterController.progressTypeEnum.AlchemyMM)
		else
			TipsFacade.instance:openCommonTips("还没达到条件哦~")
		end
	end
end

function DreamTeamChapterAlchemyMMMainView:_onClickBtnTip()
	local ruleCfg = DreamTeamChapterConfig.instance:getAlchemyRuleCfgs(self._actCfg.ruleIdAlchemyMM)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList, "游戏规则")
end

function DreamTeamChapterAlchemyMMMainView:_onBtnSkillClg()
	local skinId = self._actCfg.skinId

	PetbookController.instance:previewBattle(skinId)
end

function DreamTeamChapterAlchemyMMMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function DreamTeamChapterAlchemyMMMainView:_onClickBtnStart()
	UIStateManager.instance:push(ViewName.DreamTeamChapterAlchemyMMGameView, self._activityId)
end

return DreamTeamChapterAlchemyMMMainView
