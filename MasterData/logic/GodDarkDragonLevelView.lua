-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/view/GodDarkDragonLevelView.lua

module("logic.extensions.goddarkdragon.view.GodDarkDragonLevelView", package.seeall)

local GodDarkDragonLevelView = class("GodDarkDragonLevelView", ViewComponent)

function GodDarkDragonLevelView:ctor()
	GodDarkDragonLevelView.super.ctor(self)
end

function GodDarkDragonLevelView:unbindEvents()
	GodDarkDragonLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnBuffChallenge)
	GameUtil.rmClickHandler(self._btnMainChallenge)
	GameUtil.rmClickHandler(self._btnBuffChange)
end

function GodDarkDragonLevelView:bindEvents()
	GodDarkDragonLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnBuffChallenge, self._onClickBuffChallenge, self)
	GameUtil.addClickHandler(self._btnMainChallenge, self._onClickMainChallenge, self)
	GameUtil.addClickHandler(self._btnBuffChange, self._onClickStageChange, self)
end

function GodDarkDragonLevelView:buildUI()
	GodDarkDragonLevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("btnRule")
	self._btnMainChallenge = self:getGo("mainChallenge/btnChallenge")
	self._btnBuffChallenge = self:getGo("buffChallenge/btnChallenge")
	self._btnBuffChange = self:getGo("buffChallenge/btnChange")
	self._imageChangeBuffChange = goutil.findChildComponent(self.mainGO, "buffChallenge/btnChange", "UIChangeGroup")
	self._myBuffTableView = self:getGo("buffList/myBuffTableView")
	self._emenyBuffTableView = self:getGo("buffList/emenyBuffTableView")
	self._buffTableCell = self:getGo("buffList/buffTableCell")
	self._rule = self:getGo("buffChallenge/rule")
	self._txtRule = self:getTxt("buffChallenge/rule/txtRule")
	self._txtBubble = self:getTxt("buffChallenge/txtBubble")
	self._txtBuffChallengeName = self:getTxt("buffChallenge/rule/txtTitle")
	self._txtBuffChallengeBallName = self:getTxt("buffChallenge/btnChange/txtName")
	self._imageBlockMain = self:getGo("mainChallenge/imgBlockGo")
	self._imageMainPetShowGo = self:getGo("mainChallenge/img_1/img")

	local rewardRoot = self:getGo("rewardRoot")

	self._rewardSliderMo = PlayerSliderMo.New(rewardRoot)
	self._emptyBuff = self:getGo("buffList/empty")
	self._buffLine = self:getGo("buffList/bg/bgLine/imgDownLine")
end

function GodDarkDragonLevelView:onExit()
	GodDarkDragonLevelView.super.onExit(self)
	self._myBuffTableList:dispose()
	self._emenyBuffTableList:dispose()
	uGuiUtil.clearImage(self._imageMainPetShowGo)
end

function GodDarkDragonLevelView:onEnter()
	GodDarkDragonLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_GodDarkDragonInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_GodDarkDragonBuffConfirmRes, self._PM_GodDarkDragonBuffConfirmRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_GodDarkDragonGainPrizeRes, self._refreshView, self)

	self._myBuffTableList = ScrollerList.create(self._myBuffTableView, self._buffTableCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._emenyBuffTableList = ScrollerList.create(self._emenyBuffTableView, self._buffTableCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._actId = self:getFirstParam()
	self._actCfg = GodDarkDragonConfig.instance:getActivityCfg(self._actId)

	self:initSlider()
	GodDarkDragonAgent.instance:sendPM_GodDarkDragonInfoReq(self._actId)

	self._stageList = {}

	if not GodDarkDragonModel.instance:getIsNotFirstEnter(self._actId) then
		if self._actCfg.storyId then
			GlobalDispatcher:addListener(GlobalNotify.EndStory, self._endStory, self)
			GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._actCfg.storyId)
		else
			self:_endStory()
		end

		GodDarkDragonModel.instance:saveIsNotFirstEnter(self._actId)
	end
end

function GodDarkDragonLevelView:initSlider()
	local sliderParam = {}

	sliderParam.view = self
	sliderParam.prizeCfgs = GodDarkDragonConfig.instance:getMainStageCfgs(self._actId)

	function sliderParam.getPlayerProgress()
		return GodDarkDragonModel.instance:getPassStage(self._actId)
	end

	function sliderParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.stageId
	end

	function sliderParam.getPrizeByRewardCfg(rewardCfg)
		return rewardCfg.prize
	end

	function sliderParam.isPlayerRewardCanGet(rewardCfg)
		return GodDarkDragonModel.instance:isCanGetProgressReward(self._actId, rewardCfg.stageId)
	end

	function sliderParam.isPlayerRewardGeted(rewardCfg)
		return GodDarkDragonModel.instance:isGetedProgressReward(self._actId, rewardCfg.stageId)
	end

	function sliderParam.sendGainPlayerPrizeReq(rewardCfg)
		GodDarkDragonAgent.instance:sendPM_GodDarkDragonGainPrizeReq(self._actId, rewardCfg.stageId)
	end

	local isSkipAnimation = true

	self._rewardSliderMo:initParam(sliderParam, isSkipAnimation)
	self._rewardSliderMo:onEnter()
	self._rewardSliderMo:updatePlayerReward()
	self._rewardSliderMo:relocation()
end

function GodDarkDragonLevelView:_refreshView()
	local myBuffMap = GodDarkDragonModel.instance:getMyBuffMap(self._actId)
	local emenyBuffMap = GodDarkDragonModel.instance:getEmenyBuffMap(self._actId)

	self._day = GodDarkDragonModel.instance:getTodayBuffConfigDay(self._actId)
	self._buffStageCfgs = GodDarkDragonConfig.instance:getBuffStageCfgByDay(self._actId, self._day)

	local hasBuff = false
	local myBuffList = {}

	for i, v in pairs(myBuffMap) do
		if v.num > 0 and v.limitNum > 0 and v.limitNum <= 9 then
			table.insert(myBuffList, v)

			hasBuff = true
		end
	end

	table.sort(myBuffList, function(a, b)
		return b.limitNum < a.limitNum
	end)

	local emenyBuffList = {}

	for i, v in pairs(emenyBuffMap) do
		if v.num > 0 and v.limitNum > 0 and v.limitNum <= 9 then
			table.insert(emenyBuffList, v)

			hasBuff = true
		end
	end

	table.sort(emenyBuffList, function(a, b)
		return a.limitNum < b.limitNum
	end)
	self._myBuffTableList:reloadData(table.values(myBuffList))
	self._emenyBuffTableList:reloadData(table.values(emenyBuffList))
	GameUtil.SetActive(self._buffLine, hasBuff)
	GameUtil.SetActive(self._emptyBuff, not hasBuff)

	self._isAllBuffStagePass = false

	table.clear(self._stageList)

	local passBuffStage = GodDarkDragonModel.instance:getPassBuffStage(self._actId)

	for i, v in ipairs(self._buffStageCfgs) do
		if not passBuffStage[v.stageId] then
			table.insert(self._stageList, v)
		end
	end

	self._stageId = GodDarkDragonModel.instance:getShowStage()

	if GodDarkDragonModel.instance:getWaitConfirm(self._actId) then
		local data = GodDarkDragonModel.instance:getWaitConfirm(self._actId)

		UIStateManager.instance:push(ViewName.GodDarkDragonResultView, self._actId, self._day, data.buffStageId, data.myLimitNum, data.enemyLimitNum)

		self._stageId = data.buffStageId
	elseif passBuffStage[self._stageId] == true or not self._buffStageCfgs[self._stageId] then
		if #self._stageList > 0 then
			self._stageId = self._stageList[1].stageId
		else
			self._stageId = 0
			self._isAllBuffStagePass = true
		end
	end

	GodDarkDragonModel.instance:setShowStage(self._stageId)

	local mainStageCfgs = GodDarkDragonConfig.instance:getMainStageCfgs(self._actId)

	self._curMainStageId = GodDarkDragonModel.instance:getPassStage(self._actId)

	if #mainStageCfgs > self._curMainStageId then
		self._curMainStageId = self._curMainStageId + 1
	end

	self:_refreshBuffStage()
	self._rewardSliderMo:updatePlayerReward()

	local mainStageCfgs = GodDarkDragonConfig.instance:getMainStageCfgs(self._actId)
	local creepCfg = GodDarkDragonConfig.instance:getCreepsCfg(mainStageCfgs[self._curMainStageId].creepsMasterId)
	local showRaceId = creepCfg[1].raceId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. raceId)

		return
	end

	uGuiUtil.clearImage(self._imageMainPetShowGo)
	uGuiUtil.setSpriteToImage(self._imageMainPetShowGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	GameUtil.SetActive(self._imageBlockMain, false)

	if not hasBuff then
		GameUtil.SetActive(self._imageBlockMain, true)
	end
end

function GodDarkDragonLevelView:_refreshBuffStage()
	local stageCfg = GodDarkDragonConfig.instance:getBuffStageCfg(self._actId, self._day, self._stageId)
	local mainStageCfgs = GodDarkDragonConfig.instance:getMainStageCfgs(self._actId)

	if #mainStageCfgs <= GodDarkDragonModel.instance:getPassStage(self._actId) then
		self._txtBubble.text = lang("您已通关无需挑战")

		GameUtil.SetActive(self._rule, false)
		GameUtil.SetActive(self._btnBuffChange, false)
	elseif self._stageId == 0 then
		self._txtBubble.text = lang("今日力量已耗尽 明日再来")

		GameUtil.SetActive(self._rule, false)
		GameUtil.SetActive(self._btnBuffChange, false)
	else
		self._txtBubble.text = lang("点击我的星昼球体\n挑战成功，解锁星宇限制")

		GameUtil.SetActive(self._rule, true)
		GameUtil.SetActive(self._btnBuffChange, true)
	end

	self._imageChangeBuffChange:SetState(self._stageId)

	if stageCfg then
		self._txtRule.text = langPara("1.%s=我方精灵上阵数量\n2.%s=敌方精灵上阵数量", stageCfg.myBuffDesc, stageCfg.enemyBuffDesc)
		self._txtBuffChallengeName.text = langPara("%s星宇限制", stageCfg.name)
		self._txtBuffChallengeBallName.text = stageCfg.ballName
	end
end

function GodDarkDragonLevelView:_updateBuffCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtLimitNum = goutil.findChildTextComponent(go, "txtNum")
	local txtCount = goutil.findChildTextComponent(go, "txtCount")

	if data.type == 1 then
		uGuiUtil.setSpriteToImage(go, nil, GameUrl.getExpEventUrl("icon_xingyu_01"))
	else
		uGuiUtil.setSpriteToImage(go, nil, GameUrl.getExpEventUrl("icon_xingyu_02"))
	end

	txtLimitNum.text = data.limitNum
	txtCount.text = data.num
end

function GodDarkDragonLevelView:_clearBuffCell(cell)
	local go = cell.gameObject

	uGuiUtil.clearImage(go)
end

function GodDarkDragonLevelView:_endStory()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._endStory, self)
end

function GodDarkDragonLevelView:_onClickBuffChallenge()
	if GodDarkDragonModel.instance:getWaitConfirm(self._actId) then
		local data = GodDarkDragonModel.instance:getWaitConfirm(self._actId)

		UIStateManager.instance:push(ViewName.GodDarkDragonResultView, self._actId, self._day, self._stageId, data.myLimitNum, data.enemyLimitNum)

		return
	end

	if self._stageId <= 0 then
		FloatWordMgr.instance:show(lang("今日力量已耗尽 明日再来"))

		return
	end

	local mainStageCfgs = GodDarkDragonConfig.instance:getMainStageCfgs(self._actId)

	if #mainStageCfgs <= GodDarkDragonModel.instance:getPassStage(self._actId) then
		FloatWordMgr.instance:show(lang("您已通关无需挑战"))

		return
	end

	local fmtMo = GodDarkDragonModel.instance:getBuffFmtMo()

	fmtMo:initParams(self._actId, self._day, self._stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function GodDarkDragonLevelView:_onClickMainChallenge()
	if GodDarkDragonModel.instance:getWaitConfirm(self._actId) then
		local data = GodDarkDragonModel.instance:getWaitConfirm(self._actId)

		UIStateManager.instance:push(ViewName.GodDarkDragonResultView, self._actId, self._day, self._stageId, data.myLimitNum, data.enemyLimitNum)

		return
	end

	local myBuffMap = GodDarkDragonModel.instance:getMyBuffMap(self._actId)
	local emenyBuffMap = GodDarkDragonModel.instance:getEmenyBuffMap(self._actId)
	local mainStageCfgs = GodDarkDragonConfig.instance:getMainStageCfgs(self._actId)
	local hasBuff = false

	for i, v in pairs(myBuffMap) do
		if v.num > 0 and v.limitNum > 0 and v.limitNum <= 9 then
			hasBuff = true

			break
		end
	end

	for i, v in pairs(emenyBuffMap) do
		if v.num > 0 and v.limitNum > 0 and v.limitNum <= 9 then
			hasBuff = true

			break
		end
	end

	if not hasBuff then
		FloatWordMgr.instance:show(lang("未持有祝福"))
	elseif #mainStageCfgs <= GodDarkDragonModel.instance:getPassStage(self._actId) then
		FloatWordMgr.instance:show(lang("您已通关无需挑战"))
	else
		UIStateManager.instance:push(ViewName.GodDarkDragonSelectView, self._actId, self._curMainStageId)
	end
end

function GodDarkDragonLevelView:_onClickStageChange()
	local index = 0

	for i, v in ipairs(self._stageList) do
		if v.stageId == self._stageId then
			index = i
		end
	end

	index = (index + 1) % #self._stageList

	if index == 0 then
		index = #self._stageList
	end

	self._stageId = self._stageList[index].stageId

	GodDarkDragonModel.instance:setShowStage(self._stageId)
	self:_refreshBuffStage()
end

function GodDarkDragonLevelView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "goddarkdragon_rule")
end

function GodDarkDragonLevelView:_PM_GodDarkDragonBuffConfirmRes(confirm, stageId)
	self:_refreshView()

	if confirm == true then
		-- block empty
	elseif checknumber(stageId) > 0 then
		self._stageId = stageId

		self:_onClickBuffChallenge()
	end
end

return GodDarkDragonLevelView
