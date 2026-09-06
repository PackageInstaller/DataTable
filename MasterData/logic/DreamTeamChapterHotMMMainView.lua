-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterHotMMMainView.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterHotMMMainView", package.seeall)

local DreamTeamChapterHotMMMainView = class("DreamTeamChapterHotMMMainView", ViewComponent)

function DreamTeamChapterHotMMMainView:ctor()
	DreamTeamChapterHotMMMainView.super.ctor(self)
end

function DreamTeamChapterHotMMMainView:unbindEvents()
	DreamTeamChapterHotMMMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function DreamTeamChapterHotMMMainView:bindEvents()
	DreamTeamChapterHotMMMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
end

function DreamTeamChapterHotMMMainView:buildUI()
	DreamTeamChapterHotMMMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._txtTip = self:getTxt("tip/txtTip")
	self._scrCell = self:getGo("rewardRow/scrCell")
	self._scrView = self:getGo("rewardRow/scrView")
	self._rewardViewport = self:getGo("rewardRow/scrView/Viewport")
	self._progressBar = self:getSlider("rewardRow/scrView/Viewport/Content/progressBar")
	self._txtNum = self:getTxt("rewardRow/total/txtNum")
	self._scrollListReward = ScrollerList.create(self._scrView, self._scrCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DreamTeamChapterHotMMMainView:onExit()
	DreamTeamChapterHotMMMainView.super.onExit(self)
	MaterialMgr.resetAll(self._role)

	if self._scrollList then
		self._scrollList:dispose()
	end

	if self._scrollListReward then
		self._scrollListReward:dispose()
	end
end

function DreamTeamChapterHotMMMainView:onEnter()
	DreamTeamChapterHotMMMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterOneClickGainProgressPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterNotifyClgRes, self._onUpdate, self)

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

	local key = string.format(DreamTeamChapterController.HOT_MM_DAY_KEY, self._activityId)

	GameUtil.saveUserDayData(key, true)
end

function DreamTeamChapterHotMMMainView:_onSetUI()
	if self._awakeMMCfg then
		if not self._awakeMMCfg.posNScale then
			local posNScale = {}
			local x = checknumber(posNScale[1])
			local y = checknumber(posNScale[2])
			local scale = checknumber(posNScale[3])

			if self._txtOpenTime then
				self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
			end

			if self._awakeMMCfg then
				if not self._awakeMMCfg.skinId then
					local skinId = 0
					local petName
					local petData = CharacterConfig.instance:getPetCo(skinId)

					self._txtName.text = (petData or nil) and petData.name or ""

					if self._awakeMMCfg then
						self._txtTip.text = self._awakeMMCfg.tipStr or ""
					end

					GameUtil.setLocalPos(self._con, x, y, 1)
					GameUtil.setLocalScale(self._con, scale, scale, scale)

					self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

					if skinId > 0 then
						MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
					end
				end
			end
		end
	end
end

function DreamTeamChapterHotMMMainView:_onUpdate()
	self._info = DreamTeamChapterModel.instance:getInfo(self._activityId)
	self._progressInfoMap = DreamTeamChapterModel.instance:getProgressInfoMap(self._activityId) or {}
	self._challengeInfoMap = DreamTeamChapterModel.instance:getChallengeInfoMap(self._activityId) or {}
	self._hotMMStageKillMap = DreamTeamChapterModel.instance:getHotMMStageKillMap(self._activityId) or {}
	self._challengeInfo = self._challengeInfoMap[DreamTeamChapterController.battleTypeEnum.HotMM]

	local stageCfgs = DreamTeamChapterConfig.instance:getBattleStageCfgs(self._activityId, DreamTeamChapterController.battleTypeEnum.HotMM)
	local progressCfgs = DreamTeamChapterConfig.instance:getProgressPlanCfgs(self._activityId, DreamTeamChapterController.progressTypeEnum.HotMM) or {}
	local curProgress = self:_getHotMMProgress()
	local scoreList = {}

	for _, cfg in ipairs(progressCfgs) do
		table.insert(scoreList, checknumber(cfg.progress))
	end

	self._txtNum.text = curProgress

	self._scrollList:reloadData(stageCfgs)
	self._scrollListReward:updateUnderSlider(self._progressBar, curProgress, scoreList)
	self._scrollListReward:reloadData(progressCfgs)
end

function DreamTeamChapterHotMMMainView:_getHotMMProgress()
	local progress = 0

	for stage, killNum in pairs(self._hotMMStageKillMap) do
		progress = progress + killNum
	end

	return progress
end

function DreamTeamChapterHotMMMainView:_updateCell(view, cell, data)
	local btnClg = goutil.findChild(cell, "btnClg")
	local txtStage = goutil.findChildTextComponent(cell, "stage/txtStage")
	local txtKill = goutil.findChildTextComponent(cell, "kill/txtKill")
	local txtBtnClg = goutil.findChildTextComponent(cell, "btnClg/txt")
	local passStageIdList = checktable(self._challengeInfo.passStageId)
	local hasPass = table.indexof(passStageIdList, data.stageId)
	local canNotFight = data.stageId > #passStageIdList + 1

	txtStage.text = string.format(lang("第<size=48>%s</size>关"), data.stageId)
	txtBtnClg.text = lang("挑战")

	if hasPass then
		txtBtnClg.text = lang("挑战成功")
	end

	txtKill.text = string.format(lang("当前击杀%s"), checknumber(self._hotMMStageKillMap[data.stageId]))

	GameUtil.addClickHandler(btnClg, function()
		if canNotFight then
			FloatWordMgr.instance:show(lang("请先通过前置关卡"))

			return
		end

		DreamTeamChapterController.instance:enterHotMMBattleClg(self._activityId, data.challengeId, data.stageId)
	end, self)
end

function DreamTeamChapterHotMMMainView:_clearCell(cell)
	local btnClg = goutil.findChild(cell, "btnClg")

	GameUtil.rmClickHandler(btnClg)
end

function DreamTeamChapterHotMMMainView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effectRoot = goutil.findChild(cell, "effectRoot")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local curProgress = self:_getHotMMProgress()
	local maxGainProgressId = checknumber(self._progressInfoMap[data.progressType]) or 0
	local hasGet = maxGainProgressId >= data.progressId
	local isCanGet = curProgress >= checknumber(data.progress)

	txtScore.text = data.progress

	MaterialMgr.setCellByCfg(data.prize, item)
	GameUtil.SetActive(received, hasGet)
	GameUtil.SetActive(btnGet, isCanGet and not hasGet)
	self:_clearCellEffect(effectRoot)

	if isCanGet and not hasGet then
		self:_playCellEffect(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function DreamTeamChapterHotMMMainView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effectRoot = goutil.findChild(cell, "effectRoot")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effectRoot)
	GameUtil.rmClickHandler(btnGet)
end

function DreamTeamChapterHotMMMainView:_playCellEffect(effectRoot)
	local loadedHandler

	if self._rewardViewport then
		function loadedHandler(_, effect)
			effect:setClipping(self._rewardViewport.transform)
		end
	end

	self:stopViewEffectUniGo(effectRoot)
	self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
end

function DreamTeamChapterHotMMMainView:_clearCellEffect(effectRoot)
	self:stopViewEffectUniGo(effectRoot)
end

function DreamTeamChapterHotMMMainView:_onClickGetPrize(data)
	local maxGainProgressId = checknumber(self._progressInfoMap[data.progressType]) or 0
	local hasGet = maxGainProgressId >= data.progressId
	local curProgress = self:_getHotMMProgress()
	local isCanGet = curProgress >= checknumber(data.progress)

	if not hasGet then
		if isCanGet then
			DreamTeamChapterController.instance:sendPM_DreamTeamChapterOneClickGainProgressPrizeReq(self._activityId, DreamTeamChapterController.progressTypeEnum.HotMM)
		else
			TipsFacade.instance:openCommonTips("还没达到条件哦")
		end
	end
end

function DreamTeamChapterHotMMMainView:_onClickBtnTip()
	if self._actCfg then
		TipsFacade.instance:openRulesView(self._actCfg)
	end
end

function DreamTeamChapterHotMMMainView:_onBtnSkillClg()
	if self._awakeMMCfg then
		local var_20_0 = self._awakeMMCfg.skinId

		if not self._awakeMMCfg.skinId then
			if self._actCfg then
				var_20_0 = self._actCfg.skinId

				if not self._actCfg.skinId then
					local skinId = 0

					if skinId > 0 then
						PetbookController.instance:previewBattle(skinId)
					end
				end
			end
		end
	end
end

function DreamTeamChapterHotMMMainView:_onBtnIntroduceClg()
	if self._awakeMMCfg then
		local var_21_0 = self._awakeMMCfg.skinId

		if not self._awakeMMCfg.skinId then
			if self._actCfg then
				var_21_0 = self._actCfg.skinId

				if not self._actCfg.skinId then
					local skinId = 0

					if skinId > 0 then
						PetbookController.instance:openPetinfoView(skinId)
					end
				end
			end
		end
	end
end

return DreamTeamChapterHotMMMainView
