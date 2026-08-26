-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6EliminateView.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6EliminateView", package.seeall)

local LengZhou6EliminateView = class("LengZhou6EliminateView", BaseView)

function LengZhou6EliminateView:onInitView()
	self.viewGO = gohelper.findChild(self.viewGO, "#go_Right")
	self._simageGrid = gohelper.findChildSingleImage(self.viewGO, "#simage_Grid")
	self._goTimes = gohelper.findChild(self.viewGO, "#go_Times")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Times/#btn_Left")
	self._txtTimes = gohelper.findChildText(self.viewGO, "#go_Times/#txt_Times")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Times/#btn_Right")
	self._goChessBG = gohelper.findChild(self.viewGO, "#go_ChessBG")
	self._gochessBoard = gohelper.findChild(self.viewGO, "#go_ChessBG/#go_chessBoard")
	self._gochess = gohelper.findChild(self.viewGO, "#go_ChessBG/#go_chess")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ChessBG/#go_chess/#btn_click")
	self._goChessEffect = gohelper.findChild(self.viewGO, "#go_ChessEffect")
	self._goLoading = gohelper.findChild(self.viewGO, "#go_Loading")
	self._sliderloading = gohelper.findChildSlider(self.viewGO, "#go_Loading/#slider_loading")
	self._goContinue = gohelper.findChild(self.viewGO, "#go_Continue")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#go_Continue/#simage_Mask")
	self._btnContinue = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Continue/#btn_Continue")
	self._goMask = gohelper.findChild(self.viewGO, "#go_Mask")
	self._goAssess = gohelper.findChild(self.viewGO, "#go_Assess")
	self._imageAssess = gohelper.findChildImage(self.viewGO, "#go_Assess/#image_Assess")
	self._goAssess2 = gohelper.findChild(self.viewGO, "#go_Assess2")
	self._imageAssess2 = gohelper.findChildImage(self.viewGO, "#go_Assess2/#image_Assess2")
	self._txtNum = gohelper.findChildText(self.viewGO, "#go_Assess2/#txt_Num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6EliminateView:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnContinue:AddClickListener(self._btnContinueOnClick, self)
end

function LengZhou6EliminateView:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnContinue:RemoveClickListener()
end

function LengZhou6EliminateView:_btnLeftOnClick()
	return
end

function LengZhou6EliminateView:_btnRightOnClick()
	return
end

function LengZhou6EliminateView:_btnclickOnClick()
	return
end

function LengZhou6EliminateView:_btnContinueOnClick()
	local selectSkill = LengZhou6GameModel.instance:getSelectSkillIdList()

	if #selectSkill < LengZhou6Enum.defaultPlayerSkillSelectMax then
		GameFacade.showMessageBox(MessageBoxIdDefine.LengZhou6EndLessContinue, MsgBoxEnum.BoxType.Yes_No, self._continueGame, nil, nil, self)
	else
		self:_continueGame()
	end
end

function LengZhou6EliminateView:_continueGame()
	LengZhou6GameModel.instance:enterNextLayer()

	local selectSkill = LengZhou6GameModel.instance:getSelectSkillIdList()

	LengZhou6GameModel.instance:resetSelectSkillId()

	for i = 1, #selectSkill do
		local skillId = selectSkill[i]

		LengZhou6GameModel.instance:setPlayerSelectSkillId(i, skillId)
	end
end

function LengZhou6EliminateView:_editableInitView()
	gohelper.setActiveCanvasGroup(self._gochess, false)

	local initState = LengZhou6EliminateChessItemController.instance:InitCloneGo(self._gochess, self._gochessBoard, self._goChessBG, self._goChessBG)

	if initState then
		LengZhou6EliminateChessItemController.instance:InitChess()
	end

	gohelper.setActive(self._goeffect, false)
end

function LengZhou6EliminateView:onUpdateParam()
	return
end

function LengZhou6EliminateView:onOpen()
	gohelper.setActive(self._goAssess, false)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.OnChessSelect, self.onSelectItem, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.UpdateGameInfo, self.updateRound, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.PerformBegin, self.onPerformBegin, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.PerformEnd, self.onPerformEnd, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.ReleaseSkill, self.onReleaseSkill, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.ShowAssess, self.OnShowAssess, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.CancelSkill, self.cancelSkill, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.ShowEffect, self.showEffect, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.HideEffect, self.hideEffect, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.ClearEliminateEffect, self.clearAllEffect, self)
	self.addEventCb(self, LengZhou6GameController.instance, LengZhou6Event.OnEndlessChangeSelectState, self.endLessModelRefreshView, self)
	self.addEventCb(self, LengZhou6GameController.instance, LengZhou6Event.GameReStart, self._gameReStart, self)
	self:initView()
end

function LengZhou6EliminateView:_gameReStart()
	gohelper.setActive(self._goAssess, false)
	self:initView()
end

function LengZhou6EliminateView:onSelectItem(x, y, isShowSelect)
	if self._mask then
		return
	end

	local cell = LocalEliminateChessModel.instance:getCell(x, y)

	if cell then
		local isFrost = cell:haveStatus(EliminateEnum_2_7.ChessState.Frost)
		local isStone = cell:getEliminateID() == EliminateEnum_2_7.ChessType.stone

		if self._needReleaseSkill == nil and (isFrost or isStone) then
			return
		end
	end

	if self._needReleaseSkill ~= nil then
		if self._lastSelectX and self._lastSelectY then
			self:setSelect(false, self._lastSelectX, self._lastSelectY)
			self:recordLastSelect(nil, nil)
		end

		self:setSkillParams(x, y)

		return
	end

	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_click)

	if self._lastSelectX and self._lastSelectY then
		if self._lastSelectX ~= x or self._lastSelectY ~= y then
			self:setSelect(false, self._lastSelectX, self._lastSelectY)
			LengZhou6EliminateController.instance:exchangeCell(self._lastSelectX, self._lastSelectY, x, y)
			self:recordLastSelect(nil, nil)
			self:setSelect(false, x, y)
		else
			self:setSelect(false, self._lastSelectX, self._lastSelectY)
			self:recordLastSelect(nil, nil)
		end
	else
		if isShowSelect then
			self:setSelect(true, x, y)
		end

		self:recordLastSelect(x, y)
	end
end

function LengZhou6EliminateView:setSelect(isSelect, x, y)
	local item = x and y and LengZhou6EliminateChessItemController.instance:getChessItem(x, y) or LengZhou6EliminateChessItemController.instance:getChessItem(self._lastSelectX, self._lastSelectY)

	if item ~= nil then
		item:setSelect(isSelect)
	end
end

function LengZhou6EliminateView:recordLastSelect(x, y)
	self._lastSelectX = x
	self._lastSelectY = y

	self:updateTipTime()
	self:tip(false)
end

function LengZhou6EliminateView:initView()
	TaskDispatcher.cancelTask(self.showViewByModel, self)

	local battleModel = LengZhou6GameModel.instance:getBattleModel()

	if battleModel == LengZhou6Enum.BattleModel.normal then
		self:updateRound()
		self:showLoading(true)
	else
		self:endLessModelRefreshView(true)
	end
end

function LengZhou6EliminateView:endLessModelRefreshView(isInitView)
	local progress = LengZhou6GameModel.instance:getEndLessBattleProgress()
	local isSelect = progress == LengZhou6Enum.BattleProgress.selectSkill

	gohelper.setActive(self._goContinue, isSelect)
	gohelper.setActive(self._goLoading, not isSelect)
	gohelper.setActive(self._goChessBG, not isSelect)
	gohelper.setActive(self._goChessEffect, not isSelect)
	self:setMaskActive(false)
	self:updateRound()

	if progress == LengZhou6Enum.BattleProgress.selectFinish then
		self:showLoading(isInitView)
	else
		self:changeTipState(false, true, false)
		LengZhou6GameModel.instance:recordChessData()

		local layer = LengZhou6GameModel.instance:getEndLessModelLayer()

		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.ChangePlayerSkill, layer)
	end
end

function LengZhou6EliminateView:updateRound()
	self._txtTimes.text = LengZhou6GameModel.instance:getCurRound()
end

function LengZhou6EliminateView:setMaskActive(active)
	gohelper.setActive(self._goMask, active)

	self._mask = active
end

function LengZhou6EliminateView:onPerformBegin()
	self:setMaskActive(true)
	self:changeTipState(false, true, false)
end

function LengZhou6EliminateView:onPerformEnd()
	self:setMaskActive(false)
	self:changeTipState(true, false, true)
end

function LengZhou6EliminateView:showLoading(init)
	self:setMaskActive(true)
	gohelper.setActive(self._goLoading, true)
	gohelper.setActive(self._goChessBG, false)
	gohelper.setActive(self._goContinue, false)
	gohelper.setActive(self._goChessEffect, false)
	self:setMaskActive(true)
	self._sliderloading:SetValue(0)

	if init then
		TaskDispatcher.runDelay(self._showLoading, self, LengZhou6Enum.openViewAniTime)
	else
		self:_showLoading()
	end
end

function LengZhou6EliminateView:_showLoading()
	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_loading)

	self._conTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, LengZhou6Enum.LoadingTime, self._updateLoading, self._finishLoading, self, nil, EaseType.Linear)
end

function LengZhou6EliminateView:_updateLoading(value)
	if self._sliderloading then
		self._sliderloading:SetValue(value)
	end
end

function LengZhou6EliminateView:_finishLoading()
	LengZhou6EliminateController.instance:createInitMoveStepAndUpdatePos()
	gohelper.setActive(self._goLoading, false)
	gohelper.setActive(self._goChessBG, true)
	gohelper.setActive(self._goChessEffect, true)
	self:setMaskActive(false)

	local battleModel = LengZhou6GameModel.instance:getBattleModel()
	local progress = LengZhou6GameModel.instance:getEndLessBattleProgress()

	if battleModel == LengZhou6Enum.BattleModel.infinite then
		if progress == LengZhou6Enum.BattleProgress.selectFinish then
			if not LengZhou6GameModel.instance:isFirstEnterLayer() then
				self:clearAllEffect()
			end

			LengZhou6GameModel.instance:recordChessData()
		end
	else
		local curEpisodeId = LengZhou6Model.instance:getCurEpisodeId()

		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.EnterGameLevel, curEpisodeId)
	end

	self:changeTipState(true, false, true)
end

function LengZhou6EliminateView:onReleaseSkill(skill)
	if not skill:paramIsFull() then
		self._needReleaseSkill = skill

		self:changeTipState(false, true, false)
	end
end

function LengZhou6EliminateView:setSkillParams(x, y)
	if self._needReleaseSkill ~= nil then
		self._needReleaseSkill:setParams(x, y)
	end

	if self._needReleaseSkill:paramIsFull() then
		self._needReleaseSkill:execute()

		self._needReleaseSkill = nil

		self:changeTipState(true, false, true)
	end
end

function LengZhou6EliminateView:cancelSkill()
	self._needReleaseSkill = nil

	self:changeTipState(true, false, true)
end

function LengZhou6EliminateView:OnShowAssess(assessLevel)
	if assessLevel == nil then
		return
	end

	local imageName = EliminateEnum_2_7.AssessLevelToImageName[assessLevel]

	UISpriteSetMgr.instance:setHisSaBethSprite(self._imageAssess, imageName, false)
	gohelper.setActive(self._goAssess, true)
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_result)
	TaskDispatcher.runDelay(self.hideAssess, self, EliminateEnum_2_7.AssessShowTime)
end

function LengZhou6EliminateView:hideAssess()
	gohelper.setActive(self._goAssess, false)
end

function LengZhou6EliminateView:onClose()
	TaskDispatcher.cancelTask(self.hideAssess, self)
	TaskDispatcher.cancelTask(self.checkTip, self)

	if self.effectPool ~= nil then
		self.effectPool:dispose()

		self.flyItemPool = nil
	end
end

function LengZhou6EliminateView:showEffect(x, y, effect)
	if x == nil or y == nil or effect == nil then
		return
	end

	local index = self:getEffectIndex(x, y)

	if self._effectList == nil then
		self._effectList = self:getUserDataTb_()
	end

	local itemGo = self._effectList[index]

	if itemGo == nil then
		local path = self.viewContainer:getSetting().otherRes[4]

		itemGo = self:getResInst(path, self._goChessEffect, "effect_" .. index)
		self._effectList[index] = itemGo
	end

	self:updateEffectInfo(itemGo, x, y, effect)
	LocalEliminateChessModel.instance:recordSpEffect(x, y, effect)
end

function LengZhou6EliminateView:hideEffect(x, y, effect)
	if x == nil or y == nil or effect == nil or self._effectList == nil then
		return
	end

	local recordEffect = LocalEliminateChessModel.instance:getSpEffect(x, y)

	if recordEffect and effect == recordEffect then
		local index = self:getEffectIndex(x, y)
		local itemGo = self._effectList[index]

		if itemGo ~= nil and effect == EliminateEnum_2_7.ChessEffect.frost then
			local image2Go = gohelper.findChild(itemGo, "#image_sprite2")
			local ani = image2Go:GetComponent(typeof(UnityEngine.Animator))

			ani:Play("out", 0, 0)

			if self._needHidePos == nil then
				self._needHidePos = {}
			end

			table.insert(self._needHidePos, {
				x,
				y
			})
			TaskDispatcher.cancelTask(self._delayHideEffect, self)
			TaskDispatcher.runDelay(self._delayHideEffect, self, 0.5)
		else
			self:_realHideEffect(x, y)
		end
	end
end

function LengZhou6EliminateView:_delayHideEffect()
	TaskDispatcher.cancelTask(self._delayHideEffect, self)

	if self._needHidePos == nil then
		return
	end

	local count = #self._needHidePos

	for i = 1, count do
		local pos = table.remove(self._needHidePos, 1)
		local x = pos[1]
		local y = pos[2]

		self:_realHideEffect(x, y)
	end
end

function LengZhou6EliminateView:_realHideEffect(x, y)
	if self._effectList == nil then
		return
	end

	local index = self:getEffectIndex(x, y)

	if self._effectList[index] ~= nil then
		LocalEliminateChessModel.instance:recordSpEffect(x, y, nil)
		gohelper.setActive(self._effectList[index], false)
	end
end

function LengZhou6EliminateView:clearAllEffect()
	if self._effectList == nil then
		return
	end

	LocalEliminateChessModel.instance:clearAllEffect()

	for _, itemGo in pairs(self._effectList) do
		if itemGo ~= nil then
			gohelper.setActive(itemGo, false)
			gohelper.destroy(itemGo)
		end
	end

	if self._needHidePos ~= nil then
		tabletool.clear(self._needHidePos)
	end

	if self._effectList ~= nil then
		tabletool.clear(self._effectList)
	end
end

function LengZhou6EliminateView:getEffectIndex(x, y)
	return x .. "_" .. y
end

function LengZhou6EliminateView:updateEffectInfo(itemGo, x, y, effectType)
	if x == nil or y == nil or effectType == nil then
		return
	end

	local image1 = gohelper.findChildImage(itemGo, "#image_sprite")
	local image2 = gohelper.findChildImage(itemGo, "#image_sprite2")
	local isFrost = effectType == EliminateEnum_2_7.ChessEffect.frost

	gohelper.setActive(image1.gameObject, not isFrost)
	gohelper.setActive(image2.gameObject, isFrost)

	local posX, posY = LocalEliminateChessUtils.instance.getChessPos(x, y)

	transformhelper.setLocalPosXY(itemGo.transform, posX, posY)
	gohelper.setActive(itemGo, true)
end

function LengZhou6EliminateView:updateTipTime()
	self._lastClickTime = os.time()
end

function LengZhou6EliminateView:checkTip()
	if self._lastClickTime == nil then
		self._lastClickTime = os.time()
	end

	if os.time() - self._lastClickTime >= EliminateEnum.DotMoveTipInterval then
		self:tip(true)
	end
end

function LengZhou6EliminateView:tip(active)
	if self._lastTipActive ~= nil and self._lastTipActive == active then
		return
	end

	if active and not self.canTip then
		return
	end

	if active then
		local tipInfo = LocalEliminateChessModel.instance:canEliminate()

		if tipInfo and #tipInfo >= 3 then
			for i = 1, #tipInfo do
				local data = tipInfo[i]
				local x = data.x
				local y = data.y
				local item = LengZhou6EliminateChessItemController.instance:getChessItem(x, y)

				if item ~= nil then
					item:toTip(active)
				end
			end
		end
	else
		local allItem = LengZhou6EliminateChessItemController.instance:getChess()

		for i = 1, #allItem do
			local rowItems = allItem[i]

			for j = 1, #rowItems do
				local item = rowItems[j]

				if item ~= nil then
					item:toTip(active)
				end
			end
		end
	end

	self._lastTipActive = active
end

function LengZhou6EliminateView:changeTipState(canTip, stopTip, needReset)
	self.canTip = canTip

	if stopTip then
		self:tip(false)

		self._lastClickTime = nil

		TaskDispatcher.cancelTask(self.checkTip, self)
	end

	if needReset then
		self._lastClickTime = nil

		TaskDispatcher.cancelTask(self.checkTip, self)
		TaskDispatcher.runRepeat(self.checkTip, self, 1)
	end
end

function LengZhou6EliminateView:onDestroyView()
	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	self._needHidePos = nil

	TaskDispatcher.cancelTask(self._delayHideEffect, self)
	TaskDispatcher.cancelTask(self._showLoading, self)
	TaskDispatcher.cancelTask(self.checkTip, self)
end

return LengZhou6EliminateView
