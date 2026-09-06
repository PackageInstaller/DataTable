-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/view/FemalePsychicLevelView.lua

module("logic.extensions.femalepsychic.view.FemalePsychicLevelView", package.seeall)

local FemalePsychicLevelView = class("FemalePsychicLevelView", ViewComponent)

function FemalePsychicLevelView:ctor()
	FemalePsychicLevelView.super.ctor(self)
end

function FemalePsychicLevelView:unbindEvents()
	FemalePsychicLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)

	for i = 1, #self._layerInfo do
		GameUtil.rmClickHandler(self._layerInfo[i].go)
	end
end

function FemalePsychicLevelView:bindEvents()
	FemalePsychicLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)

	for i = 1, #self._layerInfo do
		GameUtil.addClickHandler(self._layerInfo[i].go, GameUtil.handler(self._onClickSelectLayer, self, i))
	end
end

function FemalePsychicLevelView:buildUI()
	FemalePsychicLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._layerTransGo = self:getGo("layer")
	self._layerInfo = {}

	for i = 1, self._layerTransGo.transform.childCount do
		local layerCell = {}

		layerCell.go = goutil.findChild(self._layerTransGo, "btnLayer_" .. i)
		layerCell.txtName = goutil.findChildTextComponent(layerCell.go, "txtName")
		layerCell.lock = goutil.findChild(layerCell.go, "lock")
		layerCell.select = goutil.findChild(layerCell.go, "select")
		layerCell.progress = goutil.findChild(layerCell.go, "progress")
		self._layerInfo[i] = layerCell
	end

	self._txtLayerName = self:getTxt("levelInfo/name/txtName")
	self._levelTransGo = self:getGo("levelInfo/level")
	self._levelInfo = {}

	for i = 1, self._levelTransGo.transform.childCount do
		local levelCell = {}

		levelCell.go = goutil.findChild(self._levelTransGo, "cell_" .. i)
		levelCell.head = goutil.findChild(levelCell.go, "head")
		levelCell.txtNumber = goutil.findChildTextComponent(levelCell.go, "number/txt")
		levelCell.select = goutil.findChild(levelCell.go, "select")
		levelCell.lock = goutil.findChild(levelCell.go, "lock")
		levelCell.pass = goutil.findChild(levelCell.go, "pass")
		levelCell.passScore = goutil.findChildTextComponent(levelCell.pass, "txtScore")
		self._levelInfo[i] = levelCell

		GameUtil.SetActive(levelCell.go, false)
	end

	self._bossName = self:getTxt("levelInfo/detail/txtBossName")
	self._txtRule = self:getTxt("levelInfo/detail/rule/txtRule")
	self._txtRecZdl = self:getTxt("levelInfo/detail/formation/txtRecZdl")
	self._formationViewGo = self:getGo("levelInfo/detail/formation/view")
	self._formationItem = self:getGo("levelInfo/detail/formation/item")
	self._formatioView = ScrollerList.create(self._formationViewGo, self._formationItem, GameUtil.handler(self._updateFormationCell, self), GameUtil.handler(self._clearCell, self))
	self._rewardViewGo = self:getGo("levelInfo/detail/reward/view")
	self._rewardItem = self:getGo("levelInfo/detail/reward/item")
	self._rewardView = ScrollerList.create(self._rewardViewGo, self._rewardItem, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearCell, self))
end

function FemalePsychicLevelView:onExit()
	FemalePsychicLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FemalePsychicChallengeInfoRes, self._refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.FemalePsychicChallengeConformResultRes, self._sendChallengeInfoReq, self)
end

function FemalePsychicLevelView:onEnter()
	FemalePsychicLevelView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.FemalePsychicChallenge)
	self._challengeCfg = FemalePsychicChallengeConfig.instance:getChallengeCfgById(self._activityId)

	self:_sendChallengeInfoReq()
	GlobalDispatcher:addListener(GlobalNotify.FemalePsychicChallengeInfoRes, self._refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.FemalePsychicChallengeConformResultRes, self._sendChallengeInfoReq, self)

	self._curSelectLayer = 1
	self._curSelectLevel = 1
	self._canChanllengeLayer = 1
	self._creepsMasterId = 0

	self:_setLayerInfo()
	self:_setLevelInfo()
end

function FemalePsychicLevelView:_sendChallengeInfoReq()
	FemalePsychicController.instance:sendPM_FemalePsychicChallengeInfoReq(self._activityId)
end

function FemalePsychicLevelView:_refreshUI()
	self._canChanllengeLayer = FemalePsychicModel.instance:getCanChanllengeLayerId()
	self._curSelectLayer = FemalePsychicModel.instance:getCurChallengeLayerId()

	FemalePsychicModel.instance:setCurLayerData(self._curSelectLayer)

	self._curSelectLevel = FemalePsychicModel.instance:getCurChallengeLevelId()

	for i = 1, #self._layerInfo do
		GameUtil.SetActive(self._layerInfo[i].select, i == self._curSelectLayer)
		GameUtil.SetActive(self._layerInfo[i].progress, false)
	end

	self:_setLevelCell()
	self:_setLevelInfo()
end

function FemalePsychicLevelView:_setLayerInfo()
	local nowTime = ServerTime.now()

	for i = 1, #self._layerInfo do
		self._layerInfo[i].txtName.text = self._challengeCfg[i].stageName or ""

		local openTime = GameUtil.string2time(self._challengeCfg[i].openDateTime or "")

		GameUtil.SetActive(self._layerInfo[i].lock, nowTime < openTime)
		GameUtil.SetActive(self._layerInfo[i].select, i == self._curSelectLayer)
		GameUtil.SetActive(self._layerInfo[i].progress, false)
	end
end

function FemalePsychicLevelView:_setLevelInfo()
	self._txtLayerName.text = string.format("%s之层", self._challengeCfg[self._curSelectLayer].stageName or "")

	self:_setLevelCell()
	self:_setLevelDetail()
end

function FemalePsychicLevelView:_setLevelCell()
	local layerCfg = FemalePsychicChallengeConfig.instance:getStageChallengeCfg(self._activityId, self._curSelectLayer)
	local layerInfo = FemalePsychicModel.instance:getCurLayerInfo(self._curSelectLayer)

	for i = 1, #self._levelInfo do
		local cfg = layerCfg[i]

		GameUtil.SetActive(self._levelInfo[i].go, cfg)

		if cfg then
			local raceId = FemalePsychicChallengeConfig.instance:getSupportCfg(cfg.supportPetId).raceId
			local score = FemalePsychicModel.instance:getCurLevelScore(cfg.challengeId, cfg.stageId)
			local state = FemalePsychicController.instance:levelState(cfg.challengeId, cfg.stageId)

			GameUtil.SetActive(self._levelInfo[i].go, true)
			GameUtil.SetActive(self._levelInfo[i].select, i == self._curSelectLevel)
			GameUtil.SetActive(self._levelInfo[i].lock, state == 1)
			GameUtil.SetActive(self._levelInfo[i].pass, state == 4)

			self._levelInfo[i].txtNumber.text = cfg.stageId
			self._levelInfo[i].passScore.text = string.format("通灵：<size=24>%s</size>", score)

			MaterialMgr.setIcon(self._levelInfo[i].head, MatType.Pet, raceId)
			GameUtil.addClickHandler(self._levelInfo[i].go, GameUtil.handler(self._onClickLevel, self, i))
		end
	end
end

function FemalePsychicLevelView:_setLevelDetail()
	local levelCfg = FemalePsychicChallengeConfig.instance:getStageChallengeDetailCfg(self._activityId, self._curSelectLayer, self._curSelectLevel)
	local creepsCfg = FemalePsychicChallengeConfig.instance:getStageCreepsCfg(levelCfg.creepsMasterId)

	self._bossName.text = levelCfg.challengeName
	self._txtRule.text = levelCfg.rule
	self._txtRecZdl.text = string.format("推荐战力：%s", levelCfg.recZdl)
	self._creepsMasterId = creepsCfg.creepsMasterId

	local fmo = FightingPowerPetMo.New()
	local petMoList = {}

	for _, data in ipairs(creepsCfg) do
		fmo:fromChallengeCreepCo(data)

		local petMo = fmo:toBaseBagPetMo()

		table.insert(petMoList, petMo)
	end

	self._formatioView:reloadData(petMoList)
	self._rewardView:reloadData(string.split(levelCfg.prize, "#"))
end

function FemalePsychicLevelView:_updateFormationCell(view, cell, petMo)
	local petId = petMo:getPetId()
	local skinId = petMo.curFaceId
	local proxy = MaterialMgr.setCell(MatType.Pet, skinId, cell)

	if proxy then
		local function func()
			CommonTipsMgr.instance:showPetTips(petMo, false)
		end

		proxy.binder:setClickCallBack(func)
	end
end

function FemalePsychicLevelView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function FemalePsychicLevelView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function FemalePsychicLevelView:_onClickSelectLayer(layerId)
	local nowTime = ServerTime.now()
	local openTimeDate = GameUtil.string2date(self._challengeCfg[layerId].openDateTime)
	local openTime = GameUtil.string2time(self._challengeCfg[layerId].openDateTime or "")

	if nowTime < openTime then
		local desc = string.format("%s之层将在%04d.%02d.%02d开放", self._challengeCfg[layerId].stageName, openTimeDate.year, openTimeDate.month, openTimeDate.day)

		FloatWordMgr.instance:show(desc)

		return
	end

	self._curSelectLayer = layerId

	FemalePsychicModel.instance:setCurLayerData(layerId)

	self._curSelectLevel = FemalePsychicModel.instance:getCurChallengeLevelId()

	self:_setLayerInfo()
	self:_setLevelInfo()
end

function FemalePsychicLevelView:_onClickLevel(challengeId)
	self._curSelectLevel = challengeId

	self:_setLevelCell()
	self:_setLevelDetail()
end

function FemalePsychicLevelView:_onClickChallenge()
	if FemalePsychicController.instance:levelState(self._curSelectLayer, self._curSelectLevel) < 2 then
		FloatWordMgr.instance:show("当前不满足挑战条件")

		return
	end

	FemalePsychicModel.instance:setChallengeId(self._activityId, self._curSelectLayer, self._curSelectLevel)
	FemalePsychicController.instance:openFemalePsychicChallengeForm(self._activityId, self._curSelectLayer, self._curSelectLevel)
end

function FemalePsychicLevelView:_onClickTip()
	TipsFacade.instance:openRulesView("femalepsychicchallengelview")
end

return FemalePsychicLevelView
