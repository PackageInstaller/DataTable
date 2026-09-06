-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceMissionView.lua

module("logic.extensions.rankrace.view.RankRaceMissionView", package.seeall)

local RankRaceMissionView = class("RankRaceMissionView", MissionView)

function RankRaceMissionView:buildUI()
	RankRaceMissionView.super.buildUI(self)

	local parentNode = self.mainGO
	local res = rescache:GetResourceNoLoadIfNotExists("ui/views/rankrace/rankracemissionview.prefab")
	local mainAsset = res:GetMainAsset()

	self._rankRaceNode = goutil.cloneAndSetParent(mainAsset, parentNode.transform, "RankRaceNode")
	self._imgLevel = goutil.findChild(self._rankRaceNode, "rightBottom/PlayerInfo/imgLevel"):GetComponent("UIImageSpriteChange")
	self._levelNum = goutil.findChild(self._rankRaceNode, "rightBottom/PlayerInfo/imgLevel/levelNum"):GetComponent("UIImageSpriteChange")
	self._txtScore = goutil.findChildTextComponent(self._rankRaceNode, "rightBottom/PlayerInfo/txtScore")

	self:_initRankRaceBuffs()
	self:_initRankRaceMission()
end

function RankRaceMissionView:_initRankRaceBuffs()
	local btnDefenseBuff = goutil.findChild(self._rankRaceNode, "rightTop/BtnDefenseBuff")

	self._btnDefenseBuf = Framework.UIClickTrigger.Get(btnDefenseBuff)
	self._imgBuffIconState = btnDefenseBuff:GetComponent(typeof(UIImageSpriteChange))
	self._imgBuffIcon = goutil.findChild(btnDefenseBuff, "Icon")
	self._tipsPos = goutil.findChild(btnDefenseBuff, "TipsPos")
	self._buffName = goutil.findChildTextComponent(btnDefenseBuff, "TxtBuffName")
	self._btnBuffForm = Framework.ButtonAdapter.GetFrom(self._rankRaceNode, "rightTop/Btn_BuffForm")
end

function RankRaceMissionView:_initRankRaceMission()
	self._txtTiming = goutil.findChildTextComponent(self._rankRaceNode, "Timing")
	self._txtTimingFill = goutil.findChildComponent(self._rankRaceNode, "Timing/Fill", "RectTransform")
	self._waitingReady = goutil.findChild(self._rankRaceNode, "WaitingReady")
	self._playerInfoNode = goutil.findChild(self._rankRaceNode, "rightBottom/PlayerInfo")
	self._playerRankLv = goutil.findChildTextComponent(self._playerInfoNode, "RankLevel")

	local msg = RankRaceController.instance:getNotifyBeginGameResData()

	self._enemyFormation = msg.opFormationView.curForm.extParams

	goutil.setActive(self._btnBuffForm.gameObject, self._enemyFormation.formStrengthId ~= nil and self._enemyFormation.formStrengthId ~= 0)

	local _opConfigRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(msg.opStar)

	if _opConfigRankRaceLevel then
		self._playerRankLv.text = _opConfigRankRaceLevel._levelName or ""
	end

	self._playerReady = goutil.findChild(self._playerInfoNode, "Ready")
	self._playerHeadIcon = goutil.findChild(self._playerInfoNode, "ImgHead/mask/img_head")
	self._playerName = goutil.findChildTextComponent(self._playerInfoNode, "Name")
	self._clickMask = goutil.findChild(self._rankRaceNode, "ClickMask")
end

function RankRaceMissionView:bindEvents()
	RankRaceMissionView.super.bindEvents(self)
	self._btnDefenseBuf:AddClickListener(self._onClickDefenseBuf, self)
	self._btnBuffForm:AddClickListener(self._onClickEnemyBuffForm, self)
end

function RankRaceMissionView:unbindEvents()
	self._btnDefenseBuf:RemoveClickListener()
	self._btnBuffForm:RemoveClickListener()
	RankRaceMissionView.super.unbindEvents(self)
end

function RankRaceMissionView:onEnter()
	self._matchType = self:getFirstParam()

	self:onEnterInherit()
	self._clickMask:SetActive(false)
	self:_setMaskBlock(false)

	self._fmtChanged = false
	self._isReady = false
	self._loader, self._lastCallBack, self._mdlObj = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._mdlObj)

	self._videoButton.gameObject:SetActive(false)
	self._closeButton.gameObject:SetActive(false)
	self:_setMissionCfgInfo()
	self:_onSpClassLoad()
	self._playerReady:SetActive(false)
	self:_updatePlayerInfo()
	self:_updatePlayerBuff()
	self:_updateReadyState()
	self:_updateImgLevel()
	self:_startTiming()
	self:_onRankRaceOpPlayerReady()
	self.registerNotify(self, GlobalNotify.RankRaceOpPlayerReady, self._onRankRaceOpPlayerReady, self)
	self.registerNotify(self, GlobalNotify.RankRaceResult, self._onRankRaceResult, self)
	goutil.setActive(self._btnRule.gameObject, false)
	goutil.setActive(self._titleTxt.gameObject, false)
end

function RankRaceMissionView:_updateImgLevel()
	local _opStar = RankRaceChallengerModel.instance:getOpStar()
	local _configRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(_opStar)

	self._imgLevel.gameObject:SetActive(true)
	self._imgLevel:SetState(_configRankRaceLevel._bigLevel - 1)
	self._levelNum:SetState(_configRankRaceLevel._subLevel - 1)
end

function RankRaceMissionView:onExit()
	RankRaceMissionView.super.onExit(self)
	self.unregisterNotify(self, GlobalNotify.RankRaceOpPlayerReady, self._onRankRaceOpPlayerReady, self)
	self.unregisterNotify(self, GlobalNotify.RankRaceResult, self._onRankRaceResult, self)
	self:_stopTiming()

	local bigImg = Framework.ImageBigBG.Get(self._imgBuffIcon)

	bigImg:ClearImage()
	self:_removeCountdownEffect()
end

function RankRaceMissionView:_setMissionCfgInfo()
	local msg = RankRaceController.instance:getNotifyBeginGameResData()
	local titleStr = RankRaceChallengerModel.instance:getOpUserName()
	local levelStr = ""

	self:_setDescStr(titleStr, levelStr, nil)
	self:_setTitleName()

	local _opConfigRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(msg.opStar)

	self._txtScore.text = _opConfigRankRaceLevel._bigLevel < 8 and "" or string.format("%s分", msg.opLegendRankScore)
end

function RankRaceMissionView:onEnterFinished()
	self:_procLRTxt()
end

function RankRaceMissionView:_setBattleResultTxtTitle()
	RankRaceMissionView.super._setBattleResultTxtTitle(self)
	BattleModel.instance:setBattleName(self:_getTitleStr())
end

function RankRaceMissionView:_getSpClassCo()
	local spClsCo = {}

	spClsCo.desc = "战斗结束后根据<color=#c54949>双方破阵时剩余精灵存活数量</color>进行胜负判断：\n①我方存活数目＞对方存活数目，<color=#c54949>我方获胜</color>\n②我方存活数目＜对方存活数目，<color=#c54949>对方</color>获胜\n③双方存活数目相同，<color=#c54949>平局</color>\n注意：存活数目是<color=#c54949>双方</color>破阵时的<color=#c54949>存活数</color>，不是<color=#c54949>守阵</color>的存活数目！"
	spClsCo.descTitle = ""
	spClsCo.buffTitle = ""

	return spClsCo
end

function RankRaceMissionView:_onClickStart()
	if self._isReady then
		return
	end

	RankRaceController.instance:setAvoidFormZdlDetailFlag(true)
	RankRaceMissionView.super._onClickStart(self)
end

function RankRaceMissionView:_onClickMiddleOn()
	return
end

function RankRaceMissionView:_enterBattle()
	if self._isReady then
		return
	end

	self._isReady = true

	local fmtMo = self:_getCurFormation()
	local simpleForm = CustomFmtController.instance:createFormPb(fmtMo)

	FormationController.instance:SaveFormationEx()
	RankingMatchAgent.instance:sendRM_ReadyFightReq(self, simpleForm)
	self:_updateReadyState()
end

function RankRaceMissionView:_updatePlayerInfo()
	local _opHeadInfo = RankRaceChallengerModel.instance:getHeadInfo()

	if _opHeadInfo then
		local _areaName = RankRaceController.instance:parseOpAreaInfo(_opHeadInfo)

		self._playerName.text = _areaName and _areaName .. "\n" .. RankRaceChallengerModel.instance:getOpUserName() or RankRaceChallengerModel.instance:getOpUserName()
	else
		self._playerName.text = RankRaceChallengerModel.instance:getOpUserName()
	end

	local headId = RankRaceChallengerModel.instance:getOpIconId()
	local frameId = RankRaceChallengerModel.instance:getOpFrameId()
	local vipLv = RankRaceChallengerModel.instance:getVipLv()

	HeadItemController.instance:setHeadCell(self._playerHeadIcon, headId, frameId)
end

function RankRaceMissionView:_updatePlayerBuff()
	local buffId = RankRaceChallengerModel.instance:getOpDefenseBuffId()
	local buffCo = RankRaceConfig.instance:getRankRaceBuffCo(buffId)

	self._imgBuffIcon:SetActive(buffId > 0)

	if buffCo then
		self._buffName.text = buffCo.name

		self._imgBuffIconState:ChangeStateNow(0)
		uGuiUtil.setSpriteToImage(self._imgBuffIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceBuffIconUrl(buffCo.icon))
	else
		self._buffName.text = "防守之力"

		self._imgBuffIconState:ChangeStateNow(1)
	end
end

function RankRaceMissionView:_startTiming()
	settimer(1, self._tickTiming, self)

	self._readyTiming = ServerTime.now() + checknumber(RankRaceConfig.instance:getRankCommonValue("READY_TIME"))
	self._txtTiming.text = "倒计时：" .. tostring(self._readyTiming - ServerTime.now())

	goutil.setWidth(self._txtTimingFill, 150 * (self._readyTiming - ServerTime.now()) / 60)
end

function RankRaceMissionView:_stopTiming()
	removetimer(self._tickTiming, self)

	self._readyTiming = 0
	self._txtTiming.text = ""
end

function RankRaceMissionView:_tickTiming()
	local _leftTime = self._readyTiming - ServerTime.now()

	if _leftTime <= 0 then
		_leftTime = 0
	end

	self._txtTiming.text = "倒计时：" .. tostring(_leftTime)

	goutil.setWidth(self._txtTimingFill, 150 * _leftTime / 60)

	if _leftTime <= 10 then
		goutil.findChildComponent(self._txtTimingFill.gameObject, "", "UIImageSpriteChange"):SetState(1)
		self:_loadCountdownEffect()
	end

	if _leftTime <= 0 then
		self:_enterBattle()
	end
end

function RankRaceMissionView:_updateReadyState()
	if self._isReady then
		self._waitingReady:SetActive(true)
	else
		self._waitingReady:SetActive(false)
	end
end

function RankRaceMissionView:_onRankRaceOpPlayerReady()
	if RankRaceFmtController.instance:getReadyFight() then
		RankRaceFmtController.instance:setReadyFight(false)
		self._playerReady:SetActive(true)
	end
end

function RankRaceMissionView:_onRankRaceResult()
	if RankRaceResultModel.instance:getRankRaceState() == RankRaceResultModel.State_Normal then
		RankRaceController.instance:openClassicsView()

		local attackResult = RankRaceResultModel.instance:getAttackResult()
		local str = attackResult:SerializeToString()
		local msgClone = BattleExtension_pb.PM_BattleResult()

		msgClone:ParseFromString(str)
		BattleFacade.instance:startFightingByBtlResult(msgClone, GameEnum.BattleRecordEntry.RankRace)
		BattleFacade.instance:startRankRace()
	else
		UIStateManager.instance:pop()
	end
end

function RankRaceMissionView:_onClickDefenseBuf()
	local buffId = RankRaceChallengerModel.instance:getOpDefenseBuffId()

	ViewMgr.instance:open(ViewName.RankRaceBuffTipsView, buffId, self._tipsPos, self._matchType)
end

function RankRaceMissionView:_onClickEnemyBuffForm()
	UIStateManager.instance:open(ViewName.NineplacebuffenemyView, self._enemyFormation)
end

function RankRaceMissionView:_loadCountdownEffect()
	if self._countdownEffect then
		return
	end

	local path = "fx_ui_zhanqianzhunbei/fx_ui_zhanqianzhunbei_shanshuo.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, self._ImgC_Bg.transform, 0, 0, true, false)

	effect:setParent(self._ImgC_Bg.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	effect.hideEffWhileNotOnTop = false
	self._countdownEffect = effect
end

function RankRaceMissionView:_removeCountdownEffect()
	if self._countdownEffect then
		UIEffectManager.instance:stopEffect(self._countdownEffect)

		self._countdownEffect = nil
	end
end

function RankRaceMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), GameUtil.handler(self.notFilterPet, self), function(posList, petPool)
		return posList, petPool
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function RankRaceMissionView:notFilterPet(petMo)
	local forbit = self:checkPetIsForbit(petMo)

	if forbit then
		return false
	end

	return true
end

function RankRaceMissionView:checkPetIsForbit(checkPetMo)
	local isForbit = false
	local tips = ""

	if isForbit == false and self:_isPetNotCanUp(checkPetMo:getDefineId()) then
		isForbit = true
		tips = lang("该精灵已被禁用")
	end

	return isForbit, tips
end

function RankRaceMissionView:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return RankRaceController.instance:iscurBanPet(self._matchType, raceId)
	else
		return false
	end
end

return RankRaceMissionView
