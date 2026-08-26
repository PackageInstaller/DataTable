-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/Activity201MaLiAnNaGameView.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaGameView", package.seeall)

local Activity201MaLiAnNaGameView = class("Activity201MaLiAnNaGameView", BaseView)

function Activity201MaLiAnNaGameView:onInitView()
	self._gocameraMain = gohelper.findChild(self.viewGO, "#go_cameraMain")
	self._simageBG = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/#simage_BG")
	self._goRoads = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_Roads")
	self._goroad = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_Roads/#go_road")
	self._goSlots = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_Slots")
	self._goEntitys = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_Entitys")
	self._goEffects = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_Effects")
	self._goarrowLines = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_Effects/#go_arrowLines")
	self._goarrowenemy = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_Effects/#go_arrowLines/#go_arrow_enemy")
	self._goarrowplayer = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_Effects/#go_arrowLines/#go_arrow_player")
	self._goFinger = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_Effects/#go_Finger")
	self._gobattleEffects = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_battleEffects")
	self._gobattleEffect = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_battleEffects/#go_battleEffect")
	self._govxboom = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#go_battleEffects/#go_vx_boom")
	self._goTips = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_cameraMain/Middle/#go_Tips/#txt_Tips")
	self._goIcon = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/#go_Tips/#txt_Tips/#go_Icon")
	self._goTips2 = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/#go_Tips2")
	self._txtTips2 = gohelper.findChildText(self.viewGO, "#go_cameraMain/Middle/#go_Tips2/#txt_Tips2")
	self._scrollTargetList = gohelper.findChildScrollRect(self.viewGO, "#go_cameraMain/Left/Target/#scroll_TargetList")
	self._gotarget = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Target/#scroll_TargetList/viewport/#go_target")
	self._txtTarget = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/Target/#scroll_TargetList/viewport/#go_target/#txt_Target")
	self._goRole = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role")
	self._gotips = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_tips")
	self._txtRoleName = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_tips/#txt_RoleName")
	self._txtdec = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_tips/#txt_dec")
	self._txtRoleHP = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_tips/#txt_RoleHP")
	self._txtreduceHP = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#txt_reduceHP")
	self._goSelf = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_Self")
	self._goEnemy = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_Enemy")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/image/#simage_Role")
	self._txtRoleHP2 = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/image_RoleHPNumBG/#txt_RoleHP_2")
	self._txtRoleHP3 = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/image_RoleHPNumBG/#txt_RoleHP_3")
	self._goDead = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_Dead")
	self._btnrole = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#btn_role")
	self._goSwitch = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/#go_Switch")
	self._gosolider = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/#go_Switch/#go_solider")
	self._simageswitchsolider = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/Left/#go_Switch/#go_solider/Head/image/#simage_switch_solider")
	self._gohero = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/#go_Switch/#go_hero")
	self._simageswitchhero = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/Left/#go_Switch/#go_hero/Head/image/#simage_switch_hero")
	self._goskillList = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/#go_skillList")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Right/#go_skillList/#btn_cancel")
	self._goskillItem = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/#go_skillList/#go_skillItem")
	self._imageskill = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Right/#go_skillList/#go_skillItem/#image_skill")
	self._btnPause = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Right/#btn_Pause")
	self._gopause = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/#go_pause")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Right/#go_pause/#btn_close")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Right/#btn_Reset")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity201MaLiAnNaGameView:addEvents()
	self._btnrole:AddClickListener(self._btnroleOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnPause:AddClickListener(self._btnPauseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
end

function Activity201MaLiAnNaGameView:removeEvents()
	self._btnrole:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnPause:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function Activity201MaLiAnNaGameView:_btnPauseOnClick()
	Activity201MaLiAnNaGameController.instance:setPause(true)
	gohelper.setActive(self._gopause, true)
end

function Activity201MaLiAnNaGameView:_btncloseOnClick()
	gohelper.setActive(self._gopause, false)
	Activity201MaLiAnNaGameController.instance:setPause(false)
end

function Activity201MaLiAnNaGameView:_btncancelOnClick()
	self:_onSelectActiveSkill(nil)
end

function Activity201MaLiAnNaGameView:_btnroleOnClick()
	return
end

function Activity201MaLiAnNaGameView:_btnResetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.MaLiAnNaGameReset, MsgBoxEnum.BoxType.Yes_No, function()
		MaLiAnNaStatHelper.instance:sendGameExit(Activity201MaLiAnNaEnum.resultType.reset)
		Activity201MaLiAnNaGameController.instance:restartGame()
	end, nil, nil, nil, nil, nil)
end

function Activity201MaLiAnNaGameView:_editableInitView()
	self._fingerTr = self._goFinger.transform
	self._fingerGo = self._goFinger
	self._effectsTr = self._goEffects.transform
	self._tipImage = self._goTips:GetComponent(gohelper.Type_Image)
	self._tipIconImage = self._goIcon:GetComponent(gohelper.Type_Image)

	local soliderPath = self.viewContainer._viewSetting.otherRes[3]
	local heroPath = self.viewContainer._viewSetting.otherRes[4]
	local soliderGo = self:getResInst(soliderPath, self._goEntitys, "solider_temp")
	local heroGo = self:getResInst(heroPath, self._goEntitys, "hero_temp")

	gohelper.setActive(soliderGo, false)
	gohelper.setActive(heroGo, false)
	MaliAnNaSoliderEntityMgr.instance:init(soliderGo, heroGo)
	MaliAnNaBulletEntityMgr.instance:init(self._goEffects)

	self._switchClick = gohelper.getClickWithDefaultAudio(self._goSwitch)

	self._switchClick:AddClickListener(self._switchOnClick, self)

	self._switchAni = self._goSwitch:GetComponent(gohelper.Type_Animator)
	self._tipAni = self._goTips:GetComponent(gohelper.Type_Animator)
	self._tip2Ani = self._goTips2:GetComponent(gohelper.Type_Animator)
end

function Activity201MaLiAnNaGameView:onUpdateParam()
	return
end

function Activity201MaLiAnNaGameView:onOpen()
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnGameReStart, self._onGameReStart, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnRefreshView, self._refreshView, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragBeginSlot, self._onDragBeginSlot, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragSlot, self._onDragSlot, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragEndSlot, self._onDragEndSlot, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnShowBattleEffect, self._onShowBattleEffect, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnSelectActiveSkill, self._onSelectActiveSkill, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnClickSlot, self._onClickSlot, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowDisPatchPath, self.showDispatchPathByAI, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowBattleEvent, self.addEventInfo, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowShowVX, self._showShowVX, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.GenerateSolider, self._generateSolider, self)
	self.addEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.SoliderHpChange, self._soliderHpChange, self)
	gohelper.setActive(self._goTips, false)
	self:_refreshView(true)
	self:_initBaseInfo()
	TaskDispatcher.runRepeat(self._hideDispatchPathByAI, self, 0.5)

	self._canSwitch = true

	Activity201MaLiAnNaGameController.instance:_checkGameStart()
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_leimi_smalluncharted_open)
end

function Activity201MaLiAnNaGameView:_initBaseInfo()
	Activity201MaLiAnNaGameModel.instance:setDispatchHeroFirst(false)

	local config = Activity201MaLiAnNaGameModel.instance:getCurGameConfig()
	local path = config.battlePic

	if string.nilorempty(path) then
		self._simageBG:LoadImage(path)
	end

	self._txtTarget.text = config.targetDesc

	local soliderConfig = Activity201MaLiAnNaConfig.instance:getSoldierById(11001)

	if soliderConfig and soliderConfig.icon then
		self._simageswitchhero:LoadImage(ResUrl.getHeadIconSmall(soliderConfig.icon))
	end

	soliderConfig = Activity201MaLiAnNaConfig.instance:getSoldierById(1001)

	if soliderConfig and soliderConfig.icon then
		self._simageswitchsolider:LoadImage(ResUrl.monsterHeadIcon(soliderConfig.icon))
	end
end

function Activity201MaLiAnNaGameView:_onGameReStart()
	self._canSwitch = true

	gohelper.setActive(self._gopause, false)
	gohelper.setActive(self._goTips, false)
	Activity201MaLiAnNaGameModel.instance:setDispatchHeroFirst(false)
	MaliAnNaSoliderEntityMgr.instance:clear()
	MaliAnNaBulletEntityMgr.instance:clear()
	self:_initAndUpdateHeroSolider(true)
	self:_refreshView()
	Activity201MaLiAnNaGameController.instance:setPause(false)
	self:_gameReset()
	self:_onSelectActiveSkill(nil)

	self._lastTriggerSlotId = nil
end

function Activity201MaLiAnNaGameView:_gameReset()
	if self._slotItem then
		for _, item in pairs(self._slotItem) do
			item:reset()
		end
	end

	if self._heroSoliderItem then
		for _, item in pairs(self._heroSoliderItem) do
			item:reset()
		end
	end
end

function Activity201MaLiAnNaGameView:_refreshView(isInit)
	self._gameMo = Activity201MaLiAnNaGameModel.instance:getGameMo()

	self:_initSlot()
	self:_initLine()
	self:_initSkill()
	self:refreshDisPatchState()
	self:_initAndUpdateHeroSolider(isInit)
end

function Activity201MaLiAnNaGameView:_initSlot()
	if self._slotItem == nil then
		self._slotItem = self:getUserDataTb_()
	end

	local allSlot = self._gameMo:getAllSlot()

	if allSlot == nil then
		return
	end

	for _, slot in pairs(allSlot) do
		local item = self._slotItem[slot.id]

		if item == nil then
			local slotResPath = self.viewContainer._viewSetting.otherRes[1]
			local go = self:getResInst(slotResPath, self._goSlots, "slot" .. slot.id .. "_" .. slot.configId)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, MaLiAnNaSlotItem)

			item:initData(slot)

			self._slotItem[slot.id] = item
		end

		item:updateInfo(slot)
	end
end

function Activity201MaLiAnNaGameView:_initLine()
	if self._lineItem == nil then
		self._lineItem = self:getUserDataTb_()

		gohelper.CreateObjList(self, self._roadItem, self._gameMo:getAllRoad(), self._goRoads, self._goroad, MaLiAnNaLineGameComp)
	end
end

function Activity201MaLiAnNaGameView:_roadItem(item, data, index)
	if item and data then
		item:updateInfo(data)

		self._lineItem[data.id] = item
	end
end

function Activity201MaLiAnNaGameView:_switchOnClick()
	if not self._canSwitch then
		return
	end

	local state = Activity201MaLiAnNaGameModel.instance:getDispatchHeroFirst()

	Activity201MaLiAnNaGameModel.instance:setDispatchHeroFirst(not state)
	self:refreshDisPatchState()
end

function Activity201MaLiAnNaGameView:refreshDisPatchState()
	local isFirst = Activity201MaLiAnNaGameModel.instance:getDispatchHeroFirst()

	if self._lastDisPatchHeroFirst == nil or isFirst ~= self._lastDisPatchHeroFirst then
		self._canSwitch = false

		local name = isFirst and "hero" or "solider"

		self._switchAni:Play(name)
		TaskDispatcher.runDelay(function(self)
			self._canSwitch = true
		end, self, 0.4)

		self._lastDisPatchHeroFirst = isFirst
	end
end

local CSRectTrHelper = SLFramework.UGUI.RectTrHelper

function Activity201MaLiAnNaGameView:_onDragBeginSlot(id, x, y)
	return
end

function Activity201MaLiAnNaGameView:_onDragSlot(id, x, y)
	local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(id)

	if slot == nil then
		return
	end

	local anchorX, anchorY = CSRectTrHelper.ScreenPosXYToAnchorPosXY(x, y, self._effectsTr, CameraMgr.instance:getUICamera(), nil, nil)

	recthelper.setAnchor(self._fingerTr, anchorX, anchorY)

	local posX, posY = transformhelper.getLocalPos(self._fingerTr)

	Activity201MaLiAnNaGameModel.instance:checkPosAndDisPatch(posX, posY)

	local disPatchSlot = Activity201MaLiAnNaGameModel.instance:getDisPatchSlotList()

	if disPatchSlot and disPatchSlot[1] == id then
		if not self._fingerGo.activeSelf then
			gohelper.setActive(self._fingerGo, true)
		end

		if self._disPatchId == nil then
			self._disPatchId = Activity201MaLiAnNaGameModel.instance:getNextDisPatchId()
		end

		self:showDispatch(self._disPatchId, Activity201MaLiAnNaEnum.CampType.Player, disPatchSlot, true, posX, posY)
		self:updateDisPatchMiddlePoint(Activity201MaLiAnNaEnum.CampType.Player, disPatchSlot, true)
		self:updateCurLine(disPatchSlot, Activity201MaLiAnNaEnum.CampType.Player, true, posX, posY)

		local inRange, rangeSlotId = Activity201MaLiAnNaGameModel.instance:inSlotCanSelectRange(posX, posY)

		if inRange and rangeSlotId ~= id then
			self:playerDragAnim(rangeSlotId)

			if self._lastTriggerSlotId == nil or self._lastTriggerSlotId ~= rangeSlotId then
				AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_link_click)

				self._lastTriggerSlotId = rangeSlotId
			end
		else
			self:playerDragAnim(nil)
		end
	end
end

function Activity201MaLiAnNaGameView:_onDragEndSlot(id, x, y)
	local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(id)

	if slot == nil then
		return
	end

	gohelper.setActive(self._fingerGo, false)

	local anchorX, anchorY = CSRectTrHelper.ScreenPosXYToAnchorPosXY(x, y, self._effectsTr, CameraMgr.instance:getUICamera(), nil, nil)

	recthelper.setAnchor(self._fingerTr, anchorX, anchorY)

	local posX, posY = transformhelper.getLocalPos(self._fingerTr)
	local slotIdList = Activity201MaLiAnNaGameModel.instance:getDisPatchSlotList()

	if slotIdList and slotIdList[1] == id then
		self:showDispatch(self._disPatchId, Activity201MaLiAnNaEnum.CampType.Player, slotIdList, false)
		self:updateDisPatchMiddlePoint(Activity201MaLiAnNaEnum.CampType.Player, slotIdList, false)
		self:updateCurLine(slotIdList, Activity201MaLiAnNaEnum.CampType.Player, false)
	end

	if Activity201MaLiAnNaGameModel.instance:inSlotCanSelectRange(posX, posY) and self._disPatchId ~= nil then
		Activity201MaLiAnNaGameModel.instance:disPatch(self._disPatchId)

		self._disPatchId = nil
	end

	Activity201MaLiAnNaGameModel.instance:clearDisPatch()

	self._disPatchId = nil

	self:playerDragAnim(nil)

	self._lastTriggerSlotId = nil
end

function Activity201MaLiAnNaGameView:showDispatch(disPatchId, camp, slotIdList, active)
	if slotIdList == nil or #slotIdList == 0 or disPatchId == nil or camp == nil then
		return nil
	end

	if self._lineItems == nil then
		self._lineItems = {}
	end

	if self._lineItems[disPatchId] == nil then
		self._lineItems[disPatchId] = {}
	end

	local itemCount = #slotIdList

	for i = 1, itemCount do
		local slotId1 = slotIdList[i]
		local slotId2 = slotIdList[i + 1]

		if slotId1 and slotId2 then
			local key = slotId1 .. "_" .. slotId2
			local lineTr = self._lineItems[disPatchId][key]

			if lineTr == nil then
				lineTr = self:getLineObject(camp)
				self._lineItems[disPatchId][key] = lineTr
			end

			if active then
				local slot1 = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId1)
				local slot2 = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId2)

				if slot1 and slot2 then
					local beginX, beginY = slot1:getBasePosXY()
					local endX, endY = slot2:getBasePosXY()

					self:setLineData(lineTr, beginX, beginY, endX, endY)
					gohelper.setActive(lineTr.gameObject, true)
				end
			else
				self:recycleLineGo(lineTr, camp)

				self._lineItems[disPatchId][key] = nil
			end
		end
	end

	if not active then
		self._lineItems[disPatchId] = nil
	end
end

function Activity201MaLiAnNaGameView:updateDisPatchMiddlePoint(camp, slotIdList, active)
	if camp ~= Activity201MaLiAnNaEnum.CampType.Player then
		return
	end

	if slotIdList == nil or #slotIdList < 2 then
		return
	end

	local count = #slotIdList

	for i = 2, count - 1 do
		local slotId = slotIdList[i]

		if slotId and self._slotItem[slotId] then
			self._slotItem[slotId]:setMiddlePointActive(active)
		end
	end
end

function Activity201MaLiAnNaGameView:updateCurLine(slotIdList, camp, active, posX, posY)
	if not active and self._curLine and self._curLineSlotId then
		self:recycleLineGo(self._curLine, Activity201MaLiAnNaEnum.CampType.Player)

		self._curLine = nil

		return
	end

	if slotIdList == nil or #slotIdList == 0 then
		return
	end

	local slotId = slotIdList[#slotIdList]

	if self._curLineSlotId ~= slotId and self._curLine ~= nil then
		self:recycleLineGo(self._curLine, camp)

		self._curLine = nil
	end

	if slotId ~= nil and active and self._curLine == nil then
		self._curLine = self:getLineObject(camp)

		local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

		if slot then
			local startX, startY = slot:getBasePosXY()

			self:setLineData(self._curLine, startX, startY, posX or startX, posY or startY)
			gohelper.setActive(self._curLine.gameObject, true)
		end

		self._curLineSlotId = slotId
	end

	if self._curLine ~= nil then
		local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

		if slot then
			local startX, startY = slot:getBasePosXY()

			self:setLineData(self._curLine, startX, startY, posX or startX, posY or startY)
		end
	end
end

function Activity201MaLiAnNaGameView:setLineData(lineTr, beginX, beginY, endX, endY)
	local needHideEnd = true
	local needHideBegin = true
	local isInSlot, slotId = Activity201MaLiAnNaGameModel.instance:inSlotCanSelectRange(beginX, beginY)

	if isInSlot then
		local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)
		local inRange = slot:isInCanSelectRange(endX, endY)

		if inRange then
			endY = 0
			endX = 0
			beginY = 0
			beginX = 0
			needHideEnd = false
			needHideBegin = false
		end
	end

	isInSlot, slotId = Activity201MaLiAnNaGameModel.instance:inSlotCanSelectRange(endX, endY)

	if needHideBegin or not not isInSlot then
		beginX, beginY, endX, endY = MathUtil.calculateVisiblePoints(beginX, beginY, Activity201MaLiAnNaEnum.defaultHideLineRange, endX, endY, Activity201MaLiAnNaEnum.defaultHideLineRange)
	end

	transformhelper.setLocalPosXY(lineTr, beginX, beginY)

	local width = MathUtil.vec2_length(beginX, beginY, endX, endY)

	recthelper.setWidth(lineTr, width)

	local angle = MathUtil.calculateV2Angle(endX, endY, beginX, beginY)

	transformhelper.setEulerAngles(lineTr, 0, 0, angle)
end

function Activity201MaLiAnNaGameView:getLineObject(camp)
	if self._lineItemPools == nil then
		self._lineItemPools = {}
	end

	camp = camp or Activity201MaLiAnNaEnum.CampType.Player

	if self._lineItemPools[camp] == nil then
		local maxCount = 20

		self._lineItemPools[camp] = LuaObjPool.New(maxCount, function()
			if camp == Activity201MaLiAnNaEnum.CampType.Player then
				local go = gohelper.cloneInPlace(self._goarrowplayer, "playerLine")

				return go.transform
			end

			if camp == Activity201MaLiAnNaEnum.CampType.Enemy then
				local go = gohelper.cloneInPlace(self._goarrowenemy, "enemyLine")

				return go.transform
			end
		end, function(tr)
			if tr then
				gohelper.destroy(tr.gameObject)
			end
		end, function(tr)
			if tr then
				gohelper.setActive(tr.gameObject, false)
			end
		end)
	end

	return (self._lineItemPools[camp]:getObject())
end

function Activity201MaLiAnNaGameView:recycleLineGo(tr, camp)
	if tr == nil then
		return
	end

	if self._lineItemPools ~= nil and self._lineItemPools[camp] then
		self._lineItemPools[camp]:putObject(tr)
	end
end

function Activity201MaLiAnNaGameView:_onShowBattleEffect(posX, posY, showTime, isBattle)
	if self._goBattleEffectItem == nil then
		self._goBattleEffectItem = self:getUserDataTb_()
	end

	local go = isBattle and gohelper.cloneInPlace(self._gobattleEffect, "battleEffect_" .. posX .. "_" .. posY) or gohelper.cloneInPlace(self._govxboom, "effect" .. posX .. "_" .. posY)

	if go == nil then
		return
	end

	transformhelper.setLocalPosXY(go.transform, posX, posY)
	gohelper.setActive(go, true)
	TaskDispatcher.runDelay(function()
		if go then
			gohelper.setActive(go, false)
			gohelper.destroy(go)
		end
	end, nil, showTime)
end

function Activity201MaLiAnNaGameView:_initSkill()
	if self._skillItem == nil then
		self._skillItem = self:getUserDataTb_()
	end

	local allActiveSkill = Activity201MaLiAnNaGameModel.instance:getAllActiveSkill()

	if allActiveSkill == nil then
		return
	end

	for i = 1, #allActiveSkill do
		local item = self._skillItem[i]

		if item == nil then
			local skillPath = self.viewContainer._viewSetting.otherRes[2]
			local go = self:getResInst(skillPath, self._goskillList, "skill_" .. allActiveSkill[i]._configId)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, MaLiAnNaSkillItem)

			item:initData(allActiveSkill[i])
			table.insert(self._skillItem, item)
		end

		item:updateInfo(allActiveSkill[i])
		item:refreshSelect(self._skillData)
	end
end

function Activity201MaLiAnNaGameView:refreshSkillSelect()
	if self._skillItem == nil then
		return
	end

	for _, item in pairs(self._skillItem) do
		if item then
			item:refreshSelect(self._skillData)
		end
	end
end

function Activity201MaLiAnNaGameView:_onSelectActiveSkill(skillData)
	local camp

	if skillData ~= nil then
		camp = skillData:getSkillNeedSlotCamp()
	end

	if camp == nil and self._skillData ~= nil then
		camp = self._skillData:getSkillNeedSlotCamp()
	end

	if skillData == nil and self._skillData ~= nil then
		self._skillData:clearParams()
	end

	Activity201MaLiAnNaGameController.instance:setPause(skillData ~= nil)

	self._skillData = skillData

	self:refreshSkillSelect()

	if self._skillData ~= nil then
		self:showSkillInfo(self._skillData:getConfig().description)
	else
		self:showSkillInfo(nil)
	end

	if self._skillData == nil then
		self:slotPlayAniNameByCamp(camp, true)
	else
		self:slotPlayAniNameByCamp(camp, false)
	end

	gohelper.setActive(self._btncancel.gameObject, self._skillData ~= nil)
end

function Activity201MaLiAnNaGameView:releaseSkill(slotId)
	if self._skillData == nil then
		return false
	end

	local setSuccess = self._skillData:addParams(slotId)

	if setSuccess and self._skillData:paramIsFull() then
		MaLiAnNaStatHelper.instance:addUseSkillInfo(self._skillData:getConfigId())
		self._skillData:execute()
		self:_onSelectActiveSkill(nil)
		Activity201MaLiAnNaGameController.instance:setPause(false)

		return true
	end

	return setSuccess
end

function Activity201MaLiAnNaGameView:_onClickSlot(slotId)
	if self._skillData == nil then
		return
	end

	self:releaseSkill(slotId)
end

function Activity201MaLiAnNaGameView:_initAndUpdateHeroSolider(isInit)
	if self._heroSoliderItem == nil then
		self._heroSoliderItem = self:getUserDataTb_()
	end

	local allSolider = MaLiAnNaLaSoliderMoUtil.instance:getAllHeroSolider(Activity201MaLiAnNaEnum.CampType.Player)

	if allSolider == nil then
		return
	end

	for _, solider in pairs(allSolider) do
		local item = self._heroSoliderItem[solider:getId()]

		if item == nil then
			local go = gohelper.cloneInPlace(self._goRole, "heroSolider_" .. solider:getId())

			gohelper.setActive(go, true)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, MaLiAnNaHeroSoliderItem)
			self._heroSoliderItem[solider:getId()] = item
		end

		if isInit then
			item:initData(solider)
		end

		item:updateInfo(solider)
	end
end

function Activity201MaLiAnNaGameView:showDispatchPathByAI(disPatchId, camp, path)
	if disPatchId == nil or camp == nil or path == nil then
		return
	end

	if self._aiDisPatchInfo == nil then
		self._aiDisPatchInfo = {}
	end

	table.insert(self._aiDisPatchInfo, {
		disPatchId = disPatchId,
		camp = camp,
		path = path,
		time = os.time()
	})
	self:showDispatch(disPatchId, camp, path, true)
end

function Activity201MaLiAnNaGameView:_hideDispatchPathByAI()
	if self._aiDisPatchInfo == nil then
		return
	end

	local data = self._aiDisPatchInfo[1]

	if data and os.time() - data.time >= Activity201MaLiAnNaEnum.enemyLineShowTime then
		self:showDispatch(data.disPatchId, data.camp, data.path, false)
		table.remove(self._aiDisPatchInfo, 1)
	end
end

function Activity201MaLiAnNaGameView:addEventInfo(camp, info, autoHide)
	self:_showInfo(camp, info)
end

function Activity201MaLiAnNaGameView:showInfo()
	if self._infoList == nil then
		gohelper.setActive(self._goTips, false)

		return
	end
end

function Activity201MaLiAnNaGameView:showSkillInfo(info)
	if info ~= nil then
		self._txtTips2.text = info
	end

	local isShowInfo = info ~= nil

	if isShowInfo then
		gohelper.setActive(self._goTips2, true)
	else
		self:_closeSkillTip()
	end
end

function Activity201MaLiAnNaGameView:_closeSkillTip()
	if self._tip2Ani then
		self._tip2Ani:Play("close")
		TaskDispatcher.runDelay(function(self)
			if self._goTips2 then
				gohelper.setActive(self._goTips2, false)
			end
		end, self, 0.5)
	end
end

function Activity201MaLiAnNaGameView:_showInfo(camp, info)
	if info ~= nil then
		self._txtTips.text = info
	end

	local bgName = Activity201MaLiAnNaEnum.tipBgByCamp[camp]

	if bgName and self._tipImage then
		UISpriteSetMgr.instance:setMaliAnNaSprite(self._tipImage, bgName)
	end

	local iconName = Activity201MaLiAnNaEnum.tipIconByCamp[camp]

	if iconName and self._tipIconImage then
		UISpriteSetMgr.instance:setMaliAnNaSprite(self._tipIconImage, iconName)
	end

	local showTips = info ~= nil

	if showTips and self._goTips.activeSelf then
		gohelper.setActive(self._goTips, false)
	end

	gohelper.setActive(self._goTips, showTips)
	TaskDispatcher.cancelTask(self._closeTip, self)
	TaskDispatcher.runDelay(self._closeTip, self, 1)
end

function Activity201MaLiAnNaGameView:_closeTip()
	if self._tipAni then
		self._tipAni:Play("close")
		TaskDispatcher.runDelay(function(self)
			if self._goTips then
				gohelper.setActive(self._goTips, false)
			end
		end, self, 0.5)
	end
end

function Activity201MaLiAnNaGameView:playerDragAnim(slotId)
	if self._lastShowDragSlotId == slotId then
		return
	end

	if self._lastShowDragSlotId ~= nil then
		self:slotPlayAniName(self._lastShowDragSlotId, nil, true)

		self._lastShowDragSlotId = nil
	end

	if slotId == nil then
		return
	end

	local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

	if slot:getSlotCamp() == Activity201MaLiAnNaEnum.CampType.Player then
		if not Activity201MaLiAnNaEnum.slotAnimName.help then
			local name = Activity201MaLiAnNaEnum.slotAnimName.attack

			self:slotPlayAniName(slotId, name, false)

			self._lastShowDragSlotId = slotId
		end
	end
end

function Activity201MaLiAnNaGameView:slotPlayAniNameByCamp(camp, isReset)
	if camp == nil then
		return
	end

	for slotId, item in pairs(self._slotItem) do
		if item:getCamp() == camp then
			self:slotPlayAniName(slotId, Activity201MaLiAnNaEnum.slotAnimName.skill, isReset)
		end
	end
end

function Activity201MaLiAnNaGameView:slotPlayAniName(slotId, name, isReset)
	if self._cacheSlotResetAniName == nil then
		self._cacheSlotResetAniName = {}
	end

	local slot = self._slotItem[slotId]

	if slot == nil then
		return
	end

	local playName = name

	if isReset then
		if self._cacheSlotResetAniName[slotId] then
			if slot:getCamp() == Activity201MaLiAnNaEnum.CampType.Player then
				playName = Activity201MaLiAnNaEnum.slotAnimName.myIdle
			end

			if slot:getCamp() == Activity201MaLiAnNaEnum.CampType.Enemy then
				playName = Activity201MaLiAnNaEnum.slotAnimName.enemyIdle
			end

			if slot:getCamp() == Activity201MaLiAnNaEnum.CampType.Middle then
				playName = Activity201MaLiAnNaEnum.slotAnimName.middle
			end
		end

		self._cacheSlotResetAniName[slotId] = nil
	else
		self._cacheSlotResetAniName[slotId] = true
	end

	if not string.nilorempty(playName) then
		slot:playAnim(playName)
	end
end

function Activity201MaLiAnNaGameView:_showShowVX(slotId, actionType, delayTime)
	if slotId == nil or actionType == nil then
		return
	end

	local slot = self._slotItem[slotId]

	if slot ~= nil then
		slot:showVxBySkill(actionType, delayTime)
	end
end

function Activity201MaLiAnNaGameView:_generateSolider(slotId, addValue)
	if slotId == nil or addValue == nil then
		return
	end

	local slot = self._slotItem[slotId]

	if slot ~= nil then
		slot:showAddSolider(addValue)
	end
end

function Activity201MaLiAnNaGameView:_soliderHpChange(soliderId, hpDiff)
	if self._heroSoliderItem == nil then
		return
	end

	local item = self._heroSoliderItem[soliderId]

	if item then
		item:showDiff(hpDiff)
	end
end

function Activity201MaLiAnNaGameView:onClose()
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnGameReStart, self._onGameReStart, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnRefreshView, self._refreshView, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragBeginSlot, self._onDragBeginSlot, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragSlot, self._onDragSlot, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragEndSlot, self._onDragEndSlot, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnShowBattleEffect, self._onShowBattleEffect, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnSelectActiveSkill, self._onSelectActiveSkill, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnClickSlot, self._onClickSlot, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowDisPatchPath, self.showDispatchPathByAI, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowBattleEvent, self.addEventInfo, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowShowVX, self._showShowVX, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.GenerateSolider, self._generateSolider, self)
	self.removeEventCb(self, Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.SoliderHpChange, self._soliderHpChange, self)

	self._aiDisPatchInfo = nil
	self._cacheSlotResetAniName = nil
	self._lastShowDragSlotId = nil

	if self._switchClick then
		self._switchClick:RemoveClickListener()

		self._switchClick = nil
	end

	if self._curLine ~= nil then
		self._curLine = nil
	end

	if self._lineItems then
		for _, disPatchLines in pairs(self._lineItems) do
			if disPatchLines ~= nil then
				for _, keyLines in pairs(disPatchLines) do
					if keyLines then
						gohelper.destroy(keyLines.gameObject)
					end
				end
			end
		end

		self._lineItems = nil
	end

	if self._lineItemPools ~= nil then
		for _, lineItemPool in pairs(self._lineItemPools) do
			lineItemPool:dispose()

			lineItemPool = nil
		end

		self._lineItemPools = nil
	end

	TaskDispatcher.cancelTask(self._hideDispatchPathByAI, self)
	Activity201MaLiAnNaGameController.instance:exitGame()
end

function Activity201MaLiAnNaGameView:onDestroyView()
	MaliAnNaSoliderEntityMgr.instance:onDestroy()
	MaliAnNaBulletEntityMgr.instance:onDestroy()
end

return Activity201MaLiAnNaGameView
