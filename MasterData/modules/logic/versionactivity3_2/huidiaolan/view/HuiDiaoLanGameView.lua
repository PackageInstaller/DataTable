-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanGameView.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanGameView", package.seeall)

local HuiDiaoLanGameView = class("HuiDiaoLanGameView", BaseView)

function HuiDiaoLanGameView:onInitView()
	self._txttarget = gohelper.findChildText(self.viewGO, "root/info/target/#txt_target")
	self._txtremainNum = gohelper.findChildText(self.viewGO, "root/info/remain/#txt_remainNum")
	self._goblackMask = gohelper.findChild(self.viewGO, "root/#go_blackMask")
	self._btncloseSkill = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_blackMask/#btn_closeSkill")
	self._gochangeColor = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_changeColor")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "root/planeRoot/#go_plane/#go_changeColor/#btn_sure")
	self._txtaddSkillPoint = gohelper.findChildText(self.viewGO, "root/skill/skillPoint/num")
	self._txtmaxSkillPoint = gohelper.findChildText(self.viewGO, "root/skill/skillPoint/#txt_maxSkillPoint")
	self._txtcurSkillPoint = gohelper.findChildText(self.viewGO, "root/skill/skillPoint/#txt_maxSkillPoint/#txt_curSkillPoint")
	self._imageSkillPointIcon = gohelper.findChildImage(self.viewGO, "root/skill/skillPoint/#txt_maxSkillPoint/#txt_curSkillPoint/#image_skillPointIcon")
	self._gochangeColorIcon = gohelper.findChild(self.viewGO, "root/skill/changeColor/#go_changeColorIcon")
	self._gochangeColorMask = gohelper.findChild(self.viewGO, "root/skill/changeColor/#go_changeColorMask")
	self._gochangeColorlight = gohelper.findChild(self.viewGO, "root/skill/changeColor/#go_changeColorlight")
	self._txtchangeColorCD = gohelper.findChildText(self.viewGO, "root/skill/changeColor/#txt_changeColorCD")
	self._gochangeColorSelect = gohelper.findChild(self.viewGO, "root/skill/changeColor/#go_changeColorSelect")
	self._txtchangeColorPoint = gohelper.findChildText(self.viewGO, "root/skill/changeColor/#txt_changeColorPoint")
	self._imagechangeColorIcon = gohelper.findChildImage(self.viewGO, "root/skill/changeColor/#txt_changeColorPoint/#image_changeColorIcon")
	self._btnchangeColor = gohelper.findChildButtonWithAudio(self.viewGO, "root/skill/changeColor/#btn_changeColor")
	self._goexchangePosIcon = gohelper.findChild(self.viewGO, "root/skill/exchangePos/#go_exchangePosIcon")
	self._goexchangePosMask = gohelper.findChild(self.viewGO, "root/skill/exchangePos/#go_exchangePosMask")
	self._goexchangePoslight = gohelper.findChild(self.viewGO, "root/skill/exchangePos/#go_exchangePoslight")
	self._txtexchangePosCD = gohelper.findChildText(self.viewGO, "root/skill/exchangePos/#txt_exchangePosCD")
	self._goexchangePosSelect = gohelper.findChild(self.viewGO, "root/skill/exchangePos/#go_exchangePosSelect")
	self._txtexchangePosPoint = gohelper.findChildText(self.viewGO, "root/skill/exchangePos/#txt_exchangePosPoint")
	self._imageexchangePosIcon = gohelper.findChildImage(self.viewGO, "root/skill/exchangePos/#txt_exchangePosPoint/#image_exchangePosIcon")
	self._btnexchangePos = gohelper.findChildButtonWithAudio(self.viewGO, "root/skill/exchangePos/#btn_exchangePos")
	self._txtskillDesc = gohelper.findChildText(self.viewGO, "root/skill/#txt_skillDesc")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HuiDiaoLanGameView:addEvents()
	self._btncloseSkill:AddClickListener(self._btncloseSkillOnClick, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
	self._btnchangeColor:AddClickListener(self._btnchangeColorOnClick, self)
	self._btnexchangePos:AddClickListener(self._btnexchangePosOnClick, self)
end

function HuiDiaoLanGameView:removeEvents()
	self._btncloseSkill:RemoveClickListener()
	self._btnsure:RemoveClickListener()
	self._btnchangeColor:RemoveClickListener()
	self._btnexchangePos:RemoveClickListener()
end

function HuiDiaoLanGameView:_btnexchangePosOnClick()
	local isChangeColorState = HuiDiaoLanGameModel.instance:getChangeColorSkillState()

	if isChangeColorState then
		return
	end

	local isExchangePosCd = HuiDiaoLanGameModel.instance:getExchangePosSkillCdState()

	if isExchangePosCd then
		GameFacade.showToast(ToastEnum.HuiDiaoLanSkillInCd)

		return
	end

	if self.curEnergy < self.exchangePosSkillCost then
		GameFacade.showToast(ToastEnum.HuiDiaoLanEnergyNotEnough)

		return
	end

	gohelper.setActive(self._goblackMask, true)
	gohelper.setActive(self._txtskillDesc, true)
	HuiDiaoLanGameModel.instance:setExchangePosSkillState(true)
	self.sceneView:setExchangePosSkillReadyState(true)

	self._txtskillDesc.text = luaLang("huidiaolan_skill_changepos")
end

function HuiDiaoLanGameView:_btncloseSkillOnClick()
	gohelper.setActive(self._goblackMask, false)
	gohelper.setActive(self._txtskillDesc, false)

	local isChangeColorState = HuiDiaoLanGameModel.instance:getChangeColorSkillState()

	if isChangeColorState then
		HuiDiaoLanGameModel.instance:setChangeColorSkillState(false)
		self.sceneView:setChangeColorSkillReadyState(false)
		gohelper.setActive(self._gochangeColor, false)
		gohelper.setActive(self._gochangeColorSelect, false)
	end

	local isExchangePosState = HuiDiaoLanGameModel.instance:getExchangePosSkillState()

	if isExchangePosState then
		HuiDiaoLanGameModel.instance:setExchangePosSkillState(false)
		self.sceneView:setExchangePosSkillReadyState(false)
		gohelper.setActive(self._goexchangePosSelect, false)
	end
end

function HuiDiaoLanGameView:_btnsureOnClick()
	gohelper.setActive(self._goblackMask, false)
	gohelper.setActive(self._txtskillDesc, false)
	gohelper.setActive(self._gochangeColor, false)
	self.sceneView:doChangeColorSkill()
end

function HuiDiaoLanGameView:_btnchangeColorOnClick()
	local isExchangePosState = HuiDiaoLanGameModel.instance:getExchangePosSkillState()

	if isExchangePosState then
		return
	end

	local isChangeColorCd = HuiDiaoLanGameModel.instance:getChangeColorSkillCdState()

	if isChangeColorCd then
		GameFacade.showToast(ToastEnum.HuiDiaoLanSkillInCd)

		return
	end

	if self.curEnergy < self.changeColorSkillCost then
		GameFacade.showToast(ToastEnum.HuiDiaoLanEnergyNotEnough)

		return
	end

	gohelper.setActive(self._goblackMask, true)
	gohelper.setActive(self._txtskillDesc, true)
	gohelper.setActive(self._gochangeColorSelect, true)

	self._txtskillDesc.text = luaLang("huidiaolan_skill_changecolor")

	HuiDiaoLanGameModel.instance:setChangeColorSkillState(true)
	self.sceneView:setChangeColorSkillReadyState(true)
end

function HuiDiaoLanGameView:onCloseBtnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.HuiDiaoLanQuitGameTip, MsgBoxEnum.BoxType.Yes_No, self.openGameResultView, nil, nil, self)
end

function HuiDiaoLanGameView:openGameResultView()
	local params = {}

	params.isWin = false
	params.curDiamondCount = self.curDiamondCount

	HuiDiaoLanGameController.instance:openGameResultView(params)
	HuiDiaoLanStatHelper.instance:buildDataObj(self.curRemainStep, self.changeColorSkillUseCount, self.exchangePosSkillUseCount, self.getAllEnergyCount, self.curDiamondCount)
	HuiDiaoLanStatHelper.instance:sendOperationInfo(self.mapId, "exit")
end

function HuiDiaoLanGameView:_editableInitView()
	self:initUIState()

	self._goRemain = gohelper.findChild(self.viewGO, "root/info/remain")
end

function HuiDiaoLanGameView:initUIState()
	gohelper.setActive(self._goblackMask, false)
	gohelper.setActive(self._gochangeColor, false)
	gohelper.setActive(self._txtskillDesc, false)
	gohelper.setActive(self._txtaddSkillPoint, false)
	gohelper.setActive(self._gochangeColorSelect, false)
	gohelper.setActive(self._goexchangePosSelect, false)
	gohelper.setActive(self._txtchangeColorCD.gameObject, false)
	gohelper.setActive(self._txtexchangePosCD.gameObject, false)
	gohelper.setActive(self._gochangeColorMask, false)
	gohelper.setActive(self._goexchangePosMask, false)
end

function HuiDiaoLanGameView:onUpdateParam()
	return
end

function HuiDiaoLanGameView:resetGame()
	self:cleanTween()
	self:initUIState()
	self:initData()
	self:refreshUI()
end

function HuiDiaoLanGameView:onOpen()
	self.viewContainer:setOverrideCloseClick(self.onCloseBtnClick, self)
	self:initData()
	self:refreshUI()
end

function HuiDiaoLanGameView:onOpenFinish()
	self.sceneView = self.viewContainer:getHuiDiaoLanSceneView()
	self.effectView = self.viewContainer:getHuiDiaoLanEffectView()
end

function HuiDiaoLanGameView:initData()
	local episodeId = self.viewParam.episodeId

	HuiDiaoLanGameModel.instance:setWinState(episodeId, false)

	self.episodeConfig = HuiDiaoLanConfig.instance:getEpisodeConfig(episodeId)

	if self.episodeConfig.gameId > 0 then
		self.mapId = self.episodeConfig.gameId or HuiDiaoLanEnum.DefaultMapId
	end

	HuiDiaoLanGameModel.instance:initConfigData(self.mapId)

	self.gameInfoData = HuiDiaoLanGameModel.instance:getGameInfoData()
	self.planeWidth = self.gameInfoData.planeWidth
	self.planeHeight = self.gameInfoData.planeHeight
	self.planeItemWidth = self.gameInfoData.planeItemWidth
	self.planeItemHeight = self.gameInfoData.planeItemHeight
	self.isSpEpisode = self.gameInfoData.isSpEpisode
	self.originRemainStep = self.gameInfoData.stepNum
	self.curRemainStep = self.originRemainStep
	self.winTargetNum = self.gameInfoData.targetNum
	self.curDiamondCount = 0
	self.changeColorSkillCost, self.changeColorSkillCd = HuiDiaoLanConfig.instance:getChangeColorSkillInfo()
	self.exchangePosSkillCost, self.exchangePosSkillCd = HuiDiaoLanConfig.instance:getExchangePosSkillInfo()
	self.curEnergy = HuiDiaoLanConfig.instance:getConstConfig(HuiDiaoLanEnum.ConstId.OriginEnergy)
	self.maxEnergy = HuiDiaoLanConfig.instance:getConstConfig(HuiDiaoLanEnum.ConstId.MaxEnergy)
	self.moveRecoverEnergy = HuiDiaoLanConfig.instance:getConstConfig(HuiDiaoLanEnum.ConstId.MoveRecoverEnergy)

	recthelper.setSize(self._gochangeColor.transform, self.planeItemWidth, self.planeItemHeight)
	HuiDiaoLanStatHelper.instance:initGameStartTime()

	self.changeColorSkillUseCount = 0
	self.exchangePosSkillUseCount = 0
	self.getAllEnergyCount = 0
end

function HuiDiaoLanGameView:refreshUI()
	self._txttarget.text = self.winTargetNum > 0 and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("huidiaolan_win_target"), self.curDiamondCount, self.winTargetNum) or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("huidiaolan_getdiamond"), self.curDiamondCount)

	gohelper.setActive(self._goRemain, self.originRemainStep > 0)

	self._txtremainNum.text = self.curRemainStep

	self:refreshSkillInfo()
end

function HuiDiaoLanGameView:checkGameFinish()
	if self.isSpEpisode then
		if self.curRemainStep <= 0 then
			local params = {}

			params.isWin = true
			params.curDiamondCount = self.curDiamondCount

			HuiDiaoLanGameController.instance:openGameResultView(params)
			HuiDiaoLanStatHelper.instance:buildDataObj(self.curRemainStep, self.changeColorSkillUseCount, self.exchangePosSkillUseCount, self.getAllEnergyCount, self.curDiamondCount)
			HuiDiaoLanStatHelper.instance:sendOperationInfo(self.mapId, "finish")
		end
	elseif self.curDiamondCount >= self.winTargetNum and self.curRemainStep >= 0 then
		local params = {}

		params.isWin = true
		params.curDiamondCount = self.curDiamondCount

		HuiDiaoLanGameController.instance:openGameResultView(params)
		HuiDiaoLanStatHelper.instance:buildDataObj(self.curRemainStep, self.changeColorSkillUseCount, self.exchangePosSkillUseCount, self.getAllEnergyCount, self.curDiamondCount)
		HuiDiaoLanStatHelper.instance:sendOperationInfo(self.mapId, "finish")
	elseif self.curDiamondCount < self.winTargetNum and self.curRemainStep <= 0 then
		local params = {}

		params.isWin = false
		params.curDiamondCount = self.curDiamondCount

		HuiDiaoLanGameController.instance:openGameResultView(params)
		HuiDiaoLanStatHelper.instance:buildDataObj(self.curRemainStep, self.changeColorSkillUseCount, self.exchangePosSkillUseCount, self.getAllEnergyCount, self.curDiamondCount)
		HuiDiaoLanStatHelper.instance:sendOperationInfo(self.mapId, "fail")
	end
end

function HuiDiaoLanGameView:addCurDiamond()
	self.curDiamondCount = self.winTargetNum > 0 and Mathf.Min(self.curDiamondCount + 1, self.winTargetNum) or self.curDiamondCount + 1
	self._txttarget.text = self.winTargetNum > 0 and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("huidiaolan_win_target"), self.curDiamondCount, self.winTargetNum) or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("huidiaolan_getdiamond"), self.curDiamondCount)

	self:checkGameFinish()
end

function HuiDiaoLanGameView:reduceCurRemainStep()
	self:addEnergy(self.moveRecoverEnergy)

	if self.originRemainStep <= 0 then
		return
	end

	self.curRemainStep = Mathf.Max(0, self.curRemainStep - 1)
	self._txtremainNum.text = self.curRemainStep

	local animName = self.curRemainStep > 0 and self.curRemainStep <= HuiDiaoLanEnum.RemainStepTipNum and "loop" or "idle"

	self.effectView:playRemainStepAnim(animName)
	self.effectView:playRemainStepCostAnim()
	self:doShowChangeColorSkillCd()
	self:doShowExchangePosSkillCd()
end

function HuiDiaoLanGameView:addEnergy(value)
	gohelper.setActive(self._txtaddSkillPoint, true)

	if value > 0 then
		self._txtaddSkillPoint.text = "+" .. value or value
	end

	self.effectView:playSkillPointAnim()

	self.curEnergy = Mathf.Clamp(self.curEnergy + value, 0, self.maxEnergy)

	self:refreshSkillInfo()

	if value > 0 then
		self.getAllEnergyCount = self.getAllEnergyCount + value
	end
end

function HuiDiaoLanGameView:refreshSkillInfo()
	local isChangeColorCd = HuiDiaoLanGameModel.instance:getChangeColorSkillCdState()

	gohelper.setActive(self._gochangeColorMask, self.curEnergy < self.changeColorSkillCost or isChangeColorCd)
	gohelper.setActive(self._gochangeColorlight, self.curEnergy >= self.changeColorSkillCost and not isChangeColorCd)

	self._txtchangeColorPoint.text = self.changeColorSkillCost

	local isExchangePosCd = HuiDiaoLanGameModel.instance:getExchangePosSkillCdState()

	gohelper.setActive(self._goexchangePosMask, self.curEnergy < self.exchangePosSkillCost or isExchangePosCd)
	gohelper.setActive(self._goexchangePoslight, self.curEnergy >= self.exchangePosSkillCost and not isExchangePosCd)

	self._txtexchangePosPoint.text = self.exchangePosSkillCost
	self._txtmaxSkillPoint.text = string.format("/%d", self.maxEnergy)
	self._txtcurSkillPoint.text = self.curEnergy
end

function HuiDiaoLanGameView:showSkillCd()
	local isChangeColorState = HuiDiaoLanGameModel.instance:getChangeColorSkillState()
	local isExchangePosState = HuiDiaoLanGameModel.instance:getExchangePosSkillState()

	if isChangeColorState then
		self:addEnergy(-self.changeColorSkillCost)

		self.changeColorSkillUseCount = self.changeColorSkillUseCount + 1

		if self.changeColorSkillCd == 0 then
			return
		end

		HuiDiaoLanGameModel.instance:setChangeColorSkillCdState(true)
		gohelper.setActive(self._gochangeColorMask, true)
		gohelper.setActive(self._txtchangeColorCD.gameObject, true)

		self._txtchangeColorCD.text = string.format("%d", self.changeColorSkillCd)
		self.curChangeColorSkillCd = self.changeColorSkillCd
	elseif isExchangePosState then
		self:addEnergy(-self.exchangePosSkillCost)

		self.exchangePosSkillUseCount = self.exchangePosSkillUseCount + 1

		if self.exchangePosSkillCd == 0 then
			return
		end

		HuiDiaoLanGameModel.instance:setExchangePosSkillCdState(true)
		gohelper.setActive(self._goexchangePosMask, true)
		gohelper.setActive(self._txtexchangePosCD.gameObject, true)

		self._txtexchangePosCD.text = string.format("%d", self.exchangePosSkillCd)
		self.curExchangePosCd = self.exchangePosSkillCd
	end
end

function HuiDiaoLanGameView:doShowChangeColorSkillCd()
	local isChangeColorCd = HuiDiaoLanGameModel.instance:getChangeColorSkillCdState()

	if not isChangeColorCd then
		return
	end

	self.curChangeColorSkillCd = Mathf.Max(0, self.curChangeColorSkillCd - 1)
	self._txtchangeColorCD.text = string.format("%d", self.curChangeColorSkillCd)

	if self.curChangeColorSkillCd == 0 then
		self:showChangeColorSkillCdFinish()
	end
end

function HuiDiaoLanGameView:showChangeColorSkillCdFinish()
	HuiDiaoLanGameModel.instance:setChangeColorSkillCdState(false)

	if self.changeColorCdTween then
		ZProj.TweenHelper.KillById(self.changeColorCdTween)

		self.changeColorCdTween = nil
	end

	gohelper.setActive(self._gochangeColorMask, self.curEnergy < self.changeColorSkillCost)
	gohelper.setActive(self._txtchangeColorCD.gameObject, false)
end

function HuiDiaoLanGameView:doShowExchangePosSkillCd()
	local isExchangePosCd = HuiDiaoLanGameModel.instance:getExchangePosSkillCdState()

	if not isExchangePosCd then
		return
	end

	self.curExchangePosCd = Mathf.Max(0, self.curExchangePosCd - 1)
	self._txtexchangePosCD.text = string.format("%d", self.curExchangePosCd)

	if self.curExchangePosCd == 0 then
		self:showExchangePosSkillCdFinish()
	end
end

function HuiDiaoLanGameView:showExchangePosSkillCdFinish()
	HuiDiaoLanGameModel.instance:setExchangePosSkillCdState(false)

	if self.exchangePosCdTween then
		ZProj.TweenHelper.KillById(self.exchangePosCdTween)

		self.exchangePosCdTween = nil
	end

	gohelper.setActive(self._goexchangePosMask, self.curEnergy < self.exchangePosSkillCost)
	gohelper.setActive(self._txtexchangePosCD.gameObject, false)
end

function HuiDiaoLanGameView:onClose()
	return
end

function HuiDiaoLanGameView:cleanTween()
	if self.changeColorCdTween then
		ZProj.TweenHelper.KillById(self.changeColorCdTween)

		self.changeColorCdTween = nil
	end

	if self.exchangePosCdTween then
		ZProj.TweenHelper.KillById(self.exchangePosCdTween)

		self.exchangePosCdTween = nil
	end
end

function HuiDiaoLanGameView:onDestroyView()
	self:cleanTween()
end

return HuiDiaoLanGameView
