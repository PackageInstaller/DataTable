-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionView.lua

module(..., package.seeall)

local MissionView = class("MissionView", ViewComponent)

function MissionView:ctor()
	MissionView.super.ctor(self)

	self._perfectRuleDesc = nil
	self._levelStr = ""
	self._titleStr = ""
end

function MissionView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._petButton:AddClickListener(self._onClickPet, self)
	self._startBtn:AddClickListener(self._onClickStart, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._btnClean:AddClickListener(self._onClickClean, self)
	self._videoButton:AddClickListener(self._onClickVideo, self)
	self._btnGuide:AddClickListener(self._onClickGuide, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnEvaluate:AddClickListener(self._onClickEvaluate, self)
	self._btnSetting:AddClickListener(self._onClickSetting, self)
end

function MissionView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._petButton:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
	self._btnClean:RemoveClickListener()
	self._videoButton:RemoveClickListener()
	self._startBtn:RemoveClickListener()
	self._btnGuide:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnEvaluate:RemoveClickListener()
	self._btnSetting:RemoveClickListener()
end

function MissionView:buildUI()
	self._maskBlock = self:getGo("MaskBlock")
	self._closeButton = self:getBtn("lefttop/btn_back")
	self._petButton = self:getBtn("Nego_Right/BtnPet")
	self._startBtn = self:getBtn("BtnStart")
	self._txtStartBtn = goutil.findChildTextComponent(self._startBtn.gameObject, "TxtC_Title")
	self._txtCd = goutil.findChildTextComponent(self._startBtn.gameObject, "txtCd")
	self._btnRule = self:getBtn("btnRule")
	self._redPoint = self:getGo("btnRule/redPoint")
	self._topDesc = self:getGo("topDesc")
	self._txtValidatorDesc = self:getTxt("topDesc/txtValidatorDesc")
	self._imgYes = self:getGo("topDesc/txtValidatorDesc/imgYes")
	self._imgNo = self:getGo("topDesc/txtValidatorDesc/imgNo")
	self._txtDesc = self:getTxt("topDesc/txtDesc")
	self._Titlebg = self:getGo("Titlebg")
	self._effectBase = self:getGo("Titlebg/EffectBase")
	self._effectRight = self:getGo("FmtRight/effectRight")
	self._descTxt = self:getGo("Middle/Desc"):GetComponent("Text")
	self._lImgIsFirst = self:getGo("Nego_Left/Nego_TeamInfo/Nego_TeamSpeed/imgIsFirst"):GetComponent("UIImageSpriteChange")
	self._rImgIsFirst = self:getGo("FmtRight/Nego_TeamInfo/Nego_TeamSpeed/imgIsFirst"):GetComponent("UIImageSpriteChange")
	self._titleTxt = self:getGo("Titlebg/TxtTitle"):GetComponent("Text")
	self._levelTxt = self:getGo("Titlebg/TxtLevel"):GetComponent("Text")

	self._maskBlock:SetActive(false)

	self._btnOneKey = self:getBtn("btnOneKey")
	self._btnClean = self:getBtn("btnClean")
	self._videoGo = self:getGo("Video")
	self._videoButton = self:getBtn("Video/VideoButton")
	self._btnGuide = self:getBtn("lefttop/btnGuide")

	self._videoButton.gameObject:SetActive(false)

	self._Nego_RightRectTrans = self:getGo("Nego_Right"):GetComponent(goutil.Type_RectTransform)
	self._leftTeamInfoRectTrans = self:getGo("Nego_Left/Nego_TeamInfo"):GetComponent(goutil.Type_RectTransform)
	self._rightTeamInfoRectTrans = self:getGo("FmtRight/Nego_TeamInfo"):GetComponent(goutil.Type_RectTransform)
	self._effectParent = self:getGo("effect")
	self._ImgC_Bg = self:getGo("ImgC_Bg")
	self._btnTip = self:getBtn("btnTip")

	self:_initPowerCostNode()

	self._btnEvaluate = self:getBtn("Nego_Left/SelectView/Viewport/Content/Nego_Select/btnEvaluate")
	self._btnSetting = self:getBtn("btnSetting")
	self._btnEvaluate = self._btnEvaluate or self:getBtn("btnEvaluate")
	self._evaluateSprite = goutil.findChild(self._btnEvaluate.gameObject, "icon"):GetComponent("UIImageSpriteChange")
	self._descTxt.text = lang("击败敌阵所有精灵即可过关")
	self._noCost = self:getGo("NodePower/Power/noCost")
	self._extension = self:getGo("extension")
end

function MissionView:_initPowerCostNode()
	self._powerNode = self:getGo("NodePower")
	self._powerCostNum = self:getTxt("NodePower/Power")

	if self._powerNode then
		self._powerNode:SetActive(false)
	end

	if self._noCost then
		self._noCost:SetActive(false)
	end
end

function MissionView:_updatePowerCost(num, isShowNoCost)
	if self._powerNode then
		self._powerNode:SetActive(num and num > 0)

		self._powerCostNum.text = tostring(num)

		if self._noCost then
			self._noCost:SetActive(num and num > 0 and isShowNoCost)
		end
	end
end

function MissionView:destroyUI()
	return
end

function MissionView:onEnterInherit()
	FastFormation.instance:setCurFormFunc(nil)
	FastFormation.instance:setGetCurPetList(nil)
	GlobalDispatcher:addListener(GlobalNotify.FormationSpeedUpdate, self._procLRTxt, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationChangeFinish, self._onFormationChangeFinish, self)
	self._btnOneKey.gameObject:SetActive(self:_setBtnOneKeyActive())
	self:_setMaskBlock(false)
	GlobalDispatcher:addListener(GlobalNotify.OnMissionBattleResBack, self._onMissionBattleResBack, self)
	self:_playEnterAnimation()
	self:_loadVsEffect()
	self:_initValidatorDesc()
	self:_setTxtDesc()
	self:_initFormCondition(nil)
	self._btnEvaluate.gameObject:SetActive(self:_isShowBtnEvaluate())
	self:_setMaxPetNum()
end

function MissionView:onExitInherit()
	GlobalDispatcher:removeListener(GlobalNotify.FormationSpeedUpdate, self._procLRTxt, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationChangeFinish, self._onFormationChangeFinish, self)
	BulletScreenModel.instance:setKey(nil)
	BulletScreenModel.instance:setEnum(nil)
	ViewMgr.instance:close(ViewName.BulletScreen)
	self:_setMaskBlock(false)
	GlobalDispatcher:removeListener(GlobalNotify.OnMissionBattleResBack, self._onMissionBattleResBack, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	self:_removeVsEffect()
end

function MissionView:onEnter()
	self._phase = self._viewPresentor._openParam[1]
	self._branch = self._viewPresentor._openParam[2]
	self._openByJumper = self._viewPresentor._openParam[3]
	self._extParams = self._viewPresentor._openParam[4]

	self:onEnterInherit()
	MissionModel.instance:setForceResetOneKey(true)

	if ChallengeModel.instance:getBranchState(self._phase, self._branch) ~= GameEnum.ChallengeBranchState.UNLOCKED then
		UIStateManager.instance:pop()

		return
	end

	self:_setMaskBlock(false)

	self._fmtChanged = false
	self._cfg = ChallengeConfig.instance:getChallengeMissionCfg(ChallengeModel.instance:getCurId(), self._phase, self._branch)

	local curIndex = ChallengeModel.instance:getWinCount(self._phase, self._branch) + 1

	self:_setLevelAndTitle(curIndex)

	if curIndex ~= self._preIndex and self._openByJumper then
		-- block empty
	else
		self:_setMissionCfgInfo()
	end

	self._preIndex = curIndex

	if ChallengeMgrView.CurClass then
		self:_onSpClassLoad()
	end

	local kvCfg = ChallengeConfig.instance:getChallengeKV(ChallengeModel.instance:getCurId(), 1)

	ChallengeController.instance:registerLocalNotify("ClassLoaded", self._onSpClassLoad, self)

	if not BattleRecordRankController.instance:isChallengeWithBattleRecord(ChallengeModel.instance:getCurId()) then
		self._videoButton.gameObject:SetActive(false)
	elseif not self._cfg.videos or curIndex > #self._cfg.videos then
		self._videoButton.gameObject:SetActive(true)
	else
		self._videoButton.gameObject:SetActive(self._cfg.videos[curIndex] ~= 0)
	end
end

function MissionView:_setLevelAndTitle(curIndex)
	local levelStr, titleStr

	if self._cfg then
		levelStr = langPara("关卡：%s/%s", curIndex, #self._cfg.subMission)
		titleStr = self._cfg.name
	else
		levelStr = ""
		titleStr = ""
	end

	self:_setDescStr(titleStr, levelStr)
end

function MissionView:_setDescStr(titleStr, levelStr, ruleDesc)
	if titleStr ~= nil then
		self._titleStr = titleStr
		self._titleTxt.text = self._titleStr
	end

	if levelStr ~= nil then
		self._levelStr = levelStr
		self._levelTxt.text = self._levelStr
	end

	if ruleDesc ~= nil then
		self._descTxt.text = ruleDesc
	end
end

function MissionView:_getTitleStr()
	return self._titleStr or ""
end

function MissionView:_getLevelStr()
	return self._levelStr or ""
end

function MissionView:_setMissionCfgInfo()
	self:_setTitleName()
end

function MissionView:_setTitleName()
	self._titleTxt.text = string.nilorempty(self._titleStr) and self._levelStr or self._titleStr .. " " .. self._levelStr
end

function MissionView:onEnterFinished()
	self:_procLRTxt()
	self:_initRedPoint()
	self:setRuleDesc()
	BulletScreenController.instance:tryOpenView()
end

function MissionView:_resumeBgMusic()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() ~= SceneType.Battle then
		local bgmId

		if scene.bgm and scene.bgm.getBgmId then
			bgmId = scene.bgm:getBgmId()
		end

		if bgmId then
			AudioPlayerEx.instance:playMusic(bgmId)
		end
	end
end

function MissionView:onExit()
	MissionModel.instance:setMaxPetNum(5)
	FastFormation.instance:setCurFormFunc(nil)
	FastFormation.instance:setGetCurPetList(nil)
	self:onExitInherit()
	self:_setMaskBlock(false)
	ChallengeController.instance:unregisterLocalNotify("ClassLoaded", self._onSpClassLoad, self)
end

function MissionView:onExitFinished()
	self._isRedPoint = nil
	self._perfectRuleDesc = nil
	self._descTxt.text = ""
end

function MissionView:_procLRTxt()
	if MissionModel.instance:getRightPower() > 0 and MissionModel.instance:getRightSpeed() > 0 then
		self._lImgIsFirst.gameObject:SetActive(true)
		self._rImgIsFirst.gameObject:SetActive(true)
	else
		self._lImgIsFirst.gameObject:SetActive(false)
		self._rImgIsFirst.gameObject:SetActive(false)
	end

	if MissionModel.instance:isLeftFirst() then
		self._lImgIsFirst:ChangeStateNow(0)
		self._rImgIsFirst:ChangeStateNow(1)
	else
		self._lImgIsFirst:ChangeStateNow(1)
		self._rImgIsFirst:ChangeStateNow(0)
	end
end

function MissionView:_onSpClassLoad()
	local monsterCo = self:_getSpClassCo()

	if monsterCo and monsterCo.desc and monsterCo.desc ~= "" and tostring(monsterCo.desc) ~= "0" and tostring(monsterCo.desc) ~= "-1" then
		self._descTxt.text = monsterCo.desc
	end
end

function MissionView:_getSpClassCo()
	local curIndex = ChallengeModel.instance:getWinCount(self._phase, self._branch) + 1

	return (ChallengeConfig.instance:getChallengeSubMissionCfg(self._cfg.subMission[curIndex]))
end

function MissionView:_onClickClose()
	BattleSettlementModel.instance:onReset()
	self:close()
end

function MissionView:_onClickPet()
	MissionModel.instance:setIsPlayEnterAnim(false)

	local formation = self:_getCurFormation()
	local positions = formation and formation:GetPositions() or nil

	BagModel.instance:setPetViewTempTopPetIds(positions)
	UIStateManager.instance:push(ViewName.PetView)
end

function MissionView:_onClickStart()
	if EscortModel.instance:IsPickupEscort() and self._viewPresentor.viewName ~= ViewName.EscortMission then
		FloatWordMgr.instance:show("护送期间不能进行其他战斗!")

		return
	end

	if self._extParams and self._extParams.battleConditionId then
		local id = checknumber(self._extParams.battleConditionId)
		local condition = EnterBattleCondition.New()

		condition:init(id)

		if not condition:isCanPass() then
			return
		end
	end

	local hasOneKey = GameUtil.GetActive(self._btnOneKey)

	if self:_isCurFormationEmpty() then
		if hasOneKey then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), lang("fight_unformation"), function()
				return
			end, function()
				self:_onClickOneKey()
			end, lang("fight_goto_fmt"), lang("一键布阵"))
		else
			TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), nil, lang("fight_goto_fmt"))
		end

		return
	end

	if not self:_isFormationValidatorMatchOnStart() then
		return
	end

	if self:needCheckNumLimit() and self:checkFormationEmptyAndPosNumLimit(function()
		self:_startClg()
	end, hasOneKey, function()
		self:_onClickOneKey()
	end) then
		return
	end

	self:_startClg()
end

function MissionView:needCheckNumLimit()
	return true
end

function MissionView:_setMaxPetNum()
	MissionModel.instance:setMaxPetNum(self:_maxPetNum())
end

function MissionView:_maxPetNum()
	return 5
end

function MissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	return FormationFacade.instance:checkFormationEmptyAndPosNumLimitByFmo(self:_getCurFormation(), callback, hasOneKey, onekeyCallBack)
end

function MissionView:_saveFormationEx()
	return FormationController.instance:SaveFormationEx()
end

function MissionView:_startClg()
	self:_setMaskBlock(true)
	GlobalDispatcher:addListener(GlobalNotify.FormationRefresh, self._startNow, self)

	if self:_saveFormationEx() then
		return
	else
		self:_startNow()
	end
end

function MissionView:_setBattleResultTxtTitle()
	local str = self._titleStr

	if self._levelStr and self._levelStr ~= "" then
		str = str .. " " .. self._levelStr
	end

	BattleSettlementModel.instance:setTxtTitle(str)
end

function MissionView:_startNow()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	self:_setMaskBlock(true)
	self:_setBattleResultTxtTitle()

	local _, key = BulletScreenModel.instance:getCurKeys()

	BattleModel.instance:setBulletKey(key)
	self:_enterBattle()
end

function MissionView:_enterBattle()
	ChallengeController.instance:startFight(ChallengeModel.instance:getCurId(), self._branch)
end

function MissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function MissionView:_onClickClean()
	printInfo("_onClickClean")

	local fixedPosDic = MissionModel.instance:getFixedPos()
	local unableLevelPos = self:_getUnableLevelPos() or {}

	if fixedPosDic then
		table.merge(unableLevelPos, fixedPosDic)
	end

	FastFormation.instance:clean(unableLevelPos)
end

function MissionView:_onClickVideo()
	local curIndex = ChallengeModel.instance:getWinCount(self._phase, self._branch) + 1

	BattleRecordRankController.instance:enterChallenge(ChallengeModel.instance:getCurId(), self._phase, self._branch, curIndex)
end

function MissionView:_onClickGuide()
	UIStateManager.instance:open(ViewName.PanelGuide, GameEnum.PanelGuideType.Formation)
end

function MissionView:_onClickRule()
	if self._isFirstClickRedPoint == true then
		self._isFirstClickRedPoint = false

		self._redPoint:SetActive(false)
	end

	self:_openPassRuleView()
end

function MissionView:_openPassRuleView()
	local param1, param2 = MissionModel.instance:getRuleDesc()
	local param3 = MissionModel.instance:getRuleParam()
	local uiFlyParam = UIFlyTweenParam.New()

	uiFlyParam.endPosition = self:_getBtnRulePosition()

	UIStateManager.instance:open(ViewName.PassRuleView, param1, param2, param3, uiFlyParam)
end

function MissionView:_getBtnRulePosition()
	return self._btnRule.transform.position
end

function MissionView:_setBtnRuleActive(isShow)
	self._btnRule.gameObject:SetActive(isShow)
end

function MissionView:_onClickTip()
	CommonTipsMgr.instance:openMaterialTips(self._btnTip, MatType.Race, 1)
end

function MissionView:_onClickEvaluate()
	UIStateManager.instance:open(ViewName.FmtScoreView)
end

function MissionView:_onClickSetting()
	UIStateManager.instance:open(ViewName.MissionSettingView)
end

function MissionView:_onFormationChangeFinish()
	self:_setEvaluateScore()
end

function MissionView:_setEvaluateScore()
	if self:_isShowBtnEvaluate() then
		local score = FastFormation.instance:getCurrFmtValue()
		local _, index = MissionController.instance:getFmtEvaluate(score)

		self._evaluateSprite:SetState(index)
		printInfo("test 设置分数", score)
	end
end

function MissionView:_playEnterAnimation()
	local isPlay = MissionModel.instance:getIsPlayEnterAnim()

	if isPlay then
		self:_playTeamInfoEnterAnim()
	end
end

function MissionView:_playTeamInfoEnterAnim()
	self._leftTeamInfoRectTrans.anchoredPosition = Vector2.New(-1000, 300)
	self._rightTeamInfoRectTrans.anchoredPosition = Vector2.New(1000, 300)

	local time = 0.2
	local delayTime = 0.3

	self._leftTeamInfoRectTrans:DOAnchorPosX(-10, time):SetDelay(delayTime):SetEase(DG.Tweening.Ease.OutCubic)
	self._rightTeamInfoRectTrans:DOAnchorPosX(112, time):SetDelay(delayTime):SetEase(DG.Tweening.Ease.OutCubic)
end

function MissionView:_onMissionBattleResBack(status)
	if status ~= 0 then
		self:_setMaskBlock(false)
		UIJumper.instance:clear()
	end
end

function MissionView:_setMaskBlock(isBlocking)
	GameUtil.SetActive(self._maskBlock, isBlocking)
	MissionMsgBlockController.instance:setIsBlocking(isBlocking)
end

function MissionView:_initRedPoint()
	if self._isRedPoint then
		self._redPoint:SetActive(true)

		self._isFirstClickRedPoint = true
	else
		self._redPoint:SetActive(false)
	end
end

function MissionView:_setRedPoint(value)
	self._isRedPoint = value == 1
end

function MissionView:_setPerfectRuleDesc(desc)
	self._perfectRuleDesc = desc
end

function MissionView:_loadVsEffect()
	local path = "fx_ui_zhanqianzhunbei/fx_ui_zhanqianzhunbei_vs.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, self._ImgC_Bg.transform, 0, 0, true, false)

	effect:setParent(self._ImgC_Bg.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	effect.hideEffWhileNotOnTop = false
	self._vsEffect = effect
end

function MissionView:_removeVsEffect()
	if self._vsEffect then
		UIEffectManager.instance:stopEffect(self._vsEffect)

		self._vsEffect = nil
	end
end

function MissionView:setRuleDesc()
	MissionModel.instance:setRuleDesc(self._descTxt.text, self._perfectRuleDesc)
	MissionModel.instance:setRuleParam(nil)
end

function MissionView:_isShowBtnEvaluate()
	return false
end

function MissionView:_initValidatorDesc()
	self._txtValidatorDesc.gameObject:SetActive(false)

	if not self._txtDesc.gameObject.activeSelf then
		goutil.setActive(self._topDesc.gameObject, false)
	end
end

function MissionView:_setValidatorDesc(formCondition)
	local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(formCondition)

	if cfg then
		local isMatch = FormationValidatorController.instance:isFormationValidatorMatchOnStart(formCondition, self:_getCurFormation(), true)

		goutil.setActive(self._topDesc.gameObject, true)
		goutil.setActive(self._txtValidatorDesc.gameObject, true)

		self._txtValidatorDesc.text = cfg.desc

		self._imgYes:SetActive(isMatch)
		self._imgNo:SetActive(not isMatch)
	else
		self:_initValidatorDesc()
	end
end

function MissionView:_setPureValidatorDesc(str)
	if string.nilorempty(str) then
		self:_initValidatorDesc()
	else
		goutil.setActive(self._topDesc.gameObject, true)
		goutil.setActive(self._txtValidatorDesc.gameObject, true)
		goutil.setActive(self._imgYes, false)
		goutil.setActive(self._imgNo, false)

		self._txtValidatorDesc.text = str
	end
end

function MissionView:_setPureValidatorDescYesOrNo(isYes)
	goutil.setActive(self._imgYes, isYes)
	goutil.setActive(self._imgNo, not isYes)
end

function MissionView:_setTxtDesc(desc)
	if string.nilorempty(desc) then
		goutil.setActive(self._topDesc.gameObject, false)
		goutil.setActive(self._txtDesc.gameObject, false)
	else
		goutil.setActive(self._topDesc.gameObject, true)
		goutil.setActive(self._txtDesc.gameObject, true)

		self._txtDesc.text = desc
	end
end

function MissionView:_initFormCondition(formCondition)
	MissionModel.instance:setFormCondition(formCondition)
end

function MissionView:_setBtnVideoState(flag)
	goutil.setActive(self._videoButton.gameObject, flag)
end

function MissionView:_isCurFormationEmpty()
	return self:_getCurFormation():isEmpty()
end

function MissionView:_isFormationValidatorMatchOnStart()
	return true
end

function MissionView:_setBtnOneKeyActive()
	return true
end

function MissionView:_getCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function MissionView:_getUnableLevelPos()
	return nil
end

return MissionView
