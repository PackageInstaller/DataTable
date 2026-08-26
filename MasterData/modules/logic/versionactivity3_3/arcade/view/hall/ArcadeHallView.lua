-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeHallView.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeHallView", package.seeall)

local ArcadeHallView = class("ArcadeHallView", BaseView)

function ArcadeHallView:onInitView()
	self._gofull = gohelper.findChild(self.viewGO, "#go_full")
	self._gobuildingui = gohelper.findChild(self.viewGO, "#go_buildingui")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._godrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._btnboom = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_boom", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._txtboomnum = gohelper.findChildText(self.viewGO, "Right/#btn_boom/#txt_num")
	self._goboomcanUse = gohelper.findChild(self.viewGO, "Right/#btn_boom/#go_canUse")
	self._goboomhasUse = gohelper.findChild(self.viewGO, "Right/#btn_boom/#go_hasUse")
	self._imageboomicon = gohelper.findChildImage(self.viewGO, "Right/#btn_boom/image_icon")
	self._txttime = gohelper.findChildText(self.viewGO, "Right/#btn_boom/#go_hasUse/#txt_time")
	self._golack = gohelper.findChild(self.viewGO, "Right/#btn_boom/#go_lack")
	self._btnskill = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_skill", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._imageskillicon = gohelper.findChildImage(self.viewGO, "Right/#btn_skill/#image_icon")
	self._imageskillprogress = gohelper.findChildImage(self.viewGO, "Right/#btn_skill/image_progress")
	self._goskillcanUse = gohelper.findChild(self.viewGO, "Right/#btn_skill/#go_canUse")
	self._goskillhasUse = gohelper.findChild(self.viewGO, "Right/#btn_skill/#go_hasUse")
	self._txtcd = gohelper.findChildText(self.viewGO, "Right/#btn_skill/#go_hasUse/#txt_cd")
	self._btnweapon = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_weapon", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._simageweaponicon = gohelper.findChildSingleImage(self.viewGO, "Right/#btn_weapon/has/#image_icon")
	self._imageweapondurability = gohelper.findChildImage(self.viewGO, "Right/#btn_weapon/has/image_durability")
	self._goweapon = gohelper.findChild(self.viewGO, "Right/#btn_weapon/has")
	self._goweaponempty = gohelper.findChild(self.viewGO, "Right/#btn_weapon/empty")
	self._gocollection = gohelper.findChild(self.viewGO, "Right/#go_collection")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "Right/#go_collection/#go_collectionitem")
	self._simagecollectionicon = gohelper.findChildSingleImage(self.viewGO, "Right/#go_collection/#go_collectionitem/#image_icon")
	self._imagecollectionicon = gohelper.findChildImage(self.viewGO, "Right/#go_collection/#go_collectionitem/#image_icon")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "Right/#go_collection/#go_collectionitem/#txt_num")
	self._btncollection = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_collection/#go_collectionitem/btn_click", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._gotips = gohelper.findChild(self.viewGO, "Right/#go_tips")
	self._gojoyPoint = gohelper.findChild(self.viewGO, "Left/#go_joyPoint")
	self._gojoystick = gohelper.findChild(self.viewGO, "Left/#go_joyPoint/#go_joystick")
	self._gobackground = gohelper.findChild(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background")
	self._gocurrency = gohelper.findChild(self.viewGO, "Top/#go_currency")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gotipview = gohelper.findChild(self.viewGO, "#go_tipview")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topleft/#btn_back", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeHallView:addEvents()
	self._btnboom:AddClickListener(self._btnboomOnClick, self)
	self._btnskill:AddClickListener(self._btnskillOnClick, self)
	self._btnweapon:AddClickListener(self._btnweaponOnClick, self)
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self:_editableAddEvents()
end

function ArcadeHallView:removeEvents()
	self._btnboom:RemoveClickListener()
	self._btnskill:RemoveClickListener()
	self._btnweapon:RemoveClickListener()
	self._btncollection:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self:_editableRemoveEvents()
end

function ArcadeHallView:_btnbackOnClick()
	if self._isNpcTalkBlock then
		return
	end

	ArcadeController.instance:onExitHall()
end

function ArcadeHallView:_btnboomOnClick()
	if not self._boomMo then
		local effectList = self._heroMo:getEffect()

		self._boomMo = effectList and effectList[ArcadeEnum.EffectType.Bomb]

		if not self._boomMo then
			return
		end
	end

	local anchor = {
		x = 371,
		y = -155
	}
	local param = {
		SkillMo = self._boomMo,
		root = self._gotipview,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Skill, param)
end

function ArcadeHallView:_btnskillOnClick()
	if not self._skillMo then
		local effectList = self._heroMo:getEffect()

		self._skillMo = effectList and effectList[ArcadeEnum.EffectType.Skill]

		if not self._skillMo then
			return
		end
	end

	local anchor = {
		x = 371,
		y = -155
	}
	local param = {
		SkillMo = self._skillMo,
		root = self._gotipview,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Skill, param)
end

function ArcadeHallView:_btncollectionOnClick()
	if not self._collectionMo then
		local effectList = self._heroMo:getEffect()

		self._collectionMo = effectList and effectList[ArcadeEnum.EffectType.Collection]

		if not self._collectionMo then
			return
		end
	end

	if self._collectionMo.type == ArcadeEnum.EffectType.Collection then
		local anchor = {
			x = 340,
			y = -651
		}
		local param = {
			CollectionMo = self._collectionMo,
			root = self._gotipview,
			AnchorPos = anchor,
			orignViewName = self.viewName
		}

		ArcadeController.instance:openTipView(ArcadeEnum.TipType.Collection, param)
	end
end

function ArcadeHallView:_btnweaponOnClick()
	if not self._collectionMo then
		local effectList = self._heroMo:getEffect()

		self._collectionMo = effectList and effectList[ArcadeEnum.EffectType.Collection]

		if not self._collectionMo then
			return
		end
	end

	if self._collectionMo.type == ArcadeEnum.EffectType.Weapon then
		local anchor = {
			x = 371,
			y = -155
		}
		local param = {
			SkillMo = self._collectionMo,
			root = self._gotipview,
			AnchorPos = anchor,
			orignViewName = self.viewName
		}

		ArcadeController.instance:openTipView(ArcadeEnum.TipType.Skill, param)
	end
end

function ArcadeHallView:_editableInitView()
	self._isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()

	if not self._isRunning then
		self._isRunning = true

		LateUpdateBeat:Add(self._onLateUpdate, self)
	end

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)
end

function ArcadeHallView:_editableAddEvents()
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnEquipHero, self._refreshHero, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.UpLevelTalent, self._refreshDevelopReddot, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHeroItem, self._refreshDevelopReddot, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHandBookItem, self._refreshHandBookReddot, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshTaskReddot, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCamera, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnLoadFinishHallScene, self._onLoadFinishHallScene, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnExitHallView, self._onExitHallView, self, LuaEventSystem.Low)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnBeginTransitionGame, self._onBeginTransitionGame, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.NPCTalkBlock, self._setNPCBlock, self)
	self:_initHandleComp()
end

function ArcadeHallView:_editableRemoveEvents()
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnEquipHero, self._refreshHero, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.UpLevelTalent, self._refreshDevelopReddot, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHeroItem, self._refreshDevelopReddot, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHandBookItem, self._refreshHandBookReddot, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshTaskReddot, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCamera, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnLoadFinishHallScene, self._onLoadFinishHallScene, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnExitHallView, self._onExitHallView, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnBeginTransitionGame, self._onBeginTransitionGame, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.NPCTalkBlock, self._setNPCBlock, self)
	self:_removeHandleComp()
end

function ArcadeHallView:_initHandleComp()
	self._btnLeft = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_left")
	self._btnRight = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_right")
	self._btnUp = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_up")
	self._btnDown = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_down")
	self._btnLeftLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnLeft.gameObject)

	self._btnLeftLongPress:SetLongPressTime(ArcadeHallEnum.LongPressArr)
	self._btnLeftLongPress:AddLongPressListener(self._playerActOnDirection, self, ArcadeEnum.Direction.Left)

	self._btnRightLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnRight.gameObject)

	self._btnRightLongPress:SetLongPressTime(ArcadeHallEnum.LongPressArr)
	self._btnRightLongPress:AddLongPressListener(self._playerActOnDirection, self, ArcadeEnum.Direction.Right)

	self._btnUpLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnUp.gameObject)

	self._btnUpLongPress:SetLongPressTime(ArcadeHallEnum.LongPressArr)
	self._btnUpLongPress:AddLongPressListener(self._playerActOnDirection, self, ArcadeEnum.Direction.Up)

	self._btnDownLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnDown.gameObject)

	self._btnDownLongPress:SetLongPressTime(ArcadeHallEnum.LongPressArr)
	self._btnDownLongPress:AddLongPressListener(self._playerActOnDirection, self, ArcadeEnum.Direction.Down)
	self._btnLeft:AddClickListener(self._playerActOnDirection, self, ArcadeEnum.Direction.Left)
	self._btnRight:AddClickListener(self._playerActOnDirection, self, ArcadeEnum.Direction.Right)
	self._btnUp:AddClickListener(self._playerActOnDirection, self, ArcadeEnum.Direction.Up)
	self._btnDown:AddClickListener(self._playerActOnDirection, self, ArcadeEnum.Direction.Down)

	self._dragHandle = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._dragHandle:AddDragBeginListener(self._onDragBegin, self)
	self._dragHandle:AddDragListener(self._onDrag, self)
	self._dragHandle:AddDragEndListener(self._onDragEnd, self)

	self._btndrag = gohelper.findChildButtonWithAudio(self.viewGO, "#go_drag", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)

	self._btndrag:AddClickListener(self._btnClickOnClick, self)
end

function ArcadeHallView:_removeHandleComp()
	self._btnLeftLongPress:RemoveLongPressListener()
	self._btnRightLongPress:RemoveLongPressListener()
	self._btnUpLongPress:RemoveLongPressListener()
	self._btnDownLongPress:RemoveLongPressListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnUp:RemoveClickListener()
	self._btnDown:RemoveClickListener()
	self._dragHandle:RemoveDragBeginListener()
	self._dragHandle:RemoveDragEndListener()
	self._dragHandle:RemoveDragListener()
	self._btndrag:RemoveClickListener()
end

function ArcadeHallView:_setNPCBlock(isBlock)
	self._isNpcTalkBlock = isBlock
end

function ArcadeHallView:_onLateUpdate()
	local inGuiding = ArcadeGameHelper.checkInGuiding()

	if inGuiding then
		return
	end

	if self._readyEnterLevel then
		return
	end

	if self._moveTime and Time.time - self._moveTime > 0.5 and not self._isSendMoveRpc then
		ArcadeHallModel.instance:saveHeroGrid()

		self._isSendMoveRpc = true
	end

	if not self._isMobilePlayer then
		local direction

		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.RightArrow) then
			direction = ArcadeEnum.Direction.Right
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftArrow) then
			direction = ArcadeEnum.Direction.Left
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.UpArrow) then
			direction = ArcadeEnum.Direction.Up
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.DownArrow) then
			direction = ArcadeEnum.Direction.Down
		else
			return
		end

		if not self._inputTime or Time.time - self._inputTime >= ArcadeHallEnum.LongPressArr[1] then
			self:_playerActOnDirection(direction)

			self._inputTime = Time.time
		end
	end
end

function ArcadeHallView:_playerActOnDirection(direction)
	self.viewContainer:playerActOnDirection(direction)

	self._moveTime = Time.time
	self._isSendMoveRpc = false
end

function ArcadeHallView:_onDragBegin(param, pointerEventData)
	if self._readyEnterLevel then
		return
	end

	self._dragTime = 0
	self._preDirection = nil
	self._prePosition = pointerEventData.position
	self._startPosition = pointerEventData.position
	self._isMove = false
end

local dragOffset = 10

function ArcadeHallView:_onDrag(param, pointerEventData)
	if self._readyEnterLevel or not self._prePosition or not self._preDirection then
		return
	end

	if not self.viewContainer:isCanMove() then
		self._dragTime = 0
		self._preDirection = nil
		self._prePosition = nil

		return
	end

	local direction
	local x = pointerEventData.position.x - self._prePosition.x
	local y = pointerEventData.position.y - self._prePosition.y
	local absX = math.abs(x)
	local absY = math.abs(y)

	if absY < absX then
		if x < -dragOffset then
			if self._preDirection ~= ArcadeEnum.Direction.Left then
				self._dragTime = 0
			end

			direction = ArcadeEnum.Direction.Left
		end

		if x > dragOffset then
			if self._preDirection ~= ArcadeEnum.Direction.Right then
				self._dragTime = 0
			end

			direction = ArcadeEnum.Direction.Right
		end
	elseif absX < absY then
		if y < -dragOffset then
			if self._preDirection ~= ArcadeEnum.Direction.Down then
				self._dragTime = 0
			end

			direction = ArcadeEnum.Direction.Down
		end

		if y > dragOffset then
			if self._preDirection ~= ArcadeEnum.Direction.Up then
				self._dragTime = 0
			end

			direction = ArcadeEnum.Direction.Up
		end
	end

	self._dragTime = self._dragTime + Time.deltaTime
	self._preDirection = direction
	self._prePosition = pointerEventData.position

	if self._dragTime > ArcadeHallEnum.LongPressArr[2] then
		self._dragTime = 0

		self:_playerActOnDirection(direction)

		self._isMove = true
	end
end

function ArcadeHallView:_onDragEnd(param, pointerEventData)
	if self._readyEnterLevel then
		return
	end

	if not self._isMove and self._dragTime > 0.1 then
		local direction
		local x = pointerEventData.position.x - self._startPosition.x
		local y = pointerEventData.position.y - self._startPosition.y
		local absX = math.abs(x)
		local absY = math.abs(y)

		if absY < absX then
			if x < -dragOffset then
				direction = ArcadeEnum.Direction.Left
			end

			if x > dragOffset then
				direction = ArcadeEnum.Direction.Right
			end
		else
			if y < -dragOffset then
				direction = ArcadeEnum.Direction.Down
			end

			if y > dragOffset then
				direction = ArcadeEnum.Direction.Up
			end
		end

		self:_playerActOnDirection(direction)
	end

	self._dragTime = 0
	self._preDirection = nil
	self._prePosition = nil
	self._startPosition = nil
	self._isMove = false
end

function ArcadeHallView:onUpdateParam()
	return
end

function ArcadeHallView:_btnClickOnClick()
	if self._readyEnterLevel then
		return
	end

	self._sceneView = self._sceneView or self.viewContainer:getSceneView()

	if not self.viewContainer:isCanMove() then
		return
	end

	local mainCamera = CameraMgr.instance:getMainCamera()
	local worldpos = recthelper.screenPosToWorldPos(GamepadController.instance:getMousePosition(), mainCamera, self._sceneView:getSceneRoot().transform.position)
	local localPos = self._sceneView:onInverseTransformPoint(worldpos)
	local gridX = math.ceil((localPos.x - ArcadeHallEnum.Const.StartX) / ArcadeHallEnum.Const.GridSize + 0.75)
	local gridY = math.ceil((localPos.y - ArcadeHallEnum.Const.StartY) / ArcadeHallEnum.Const.GridSize + 0.75)
	local interactiveId = self._sceneView.entity:isInteractiveRange(gridX, gridY)

	if interactiveId then
		local param = ArcadeHallEnum.HallInteractiveParams[interactiveId]

		if param then
			if param.isOpenTip then
				self._sceneView:openBuildingTipView(interactiveId)
			else
				ArcadeController.instance:dispatchEvent(ArcadeEvent.OnMoveToInteractive, interactiveId)
			end
		end

		return
	end

	local characterMO = ArcadeHallModel.instance:getEquipedCharacterMO()

	if characterMO:isRange(gridX, gridY) then
		local anchor = {
			x = 736,
			y = 117
		}
		local param = {
			heroMo = characterMO:getHeroMo(),
			root = self._gotipview,
			AnchorPos = anchor,
			orignViewName = self.viewName
		}

		ArcadeController.instance:openTipView(ArcadeEnum.TipType.Hero, param)
	end
end

function ArcadeHallView:onOpen()
	self._readyEnterLevel = nil

	MainCameraMgr.instance:addView(self.viewName, self.initCamera, nil, self)
	ArcadeHallModel.instance:onOpenHallView()

	self._sceneView = self.viewContainer:getSceneView()

	self:_refreshHero()

	self._anim.enabled = true

	self._anim:Play(UIAnimationName.Open, 0, 0)
	self._anim:Update(0)

	self._anim.enabled = false

	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.ArcadeOutSide, AudioEnum3_3.bgm.play_8bit_music_explore)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_game_start)
	NavigateMgr.instance:addEscape(self.viewName, self._btnbackOnClick, self)
end

function ArcadeHallView:_onLoadFinishHallScene()
	self._animPlayer:Play(UIAnimationName.Open, self._onPlayOpenAnimFinish, self)
end

function ArcadeHallView:_onPlayOpenAnimFinish()
	local strReturnReward = ArcadeOutSizeModel.instance:getStrReturnRewardData()

	if string.nilorempty(strReturnReward) then
		return
	end

	ViewMgr.instance:openView(ViewName.ArcadeRefundTipView)
end

function ArcadeHallView:initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = ArcadeEnum.MapCameraSize * scale
end

function ArcadeHallView:_refreshHero()
	local equipHeroId = ArcadeHeroModel.instance:getEquipHeroId()

	self._heroMo = ArcadeHeroModel.instance:getHeroMoById(equipHeroId)

	local effectList = self._heroMo:getEffect()

	self._boomMo = effectList and effectList[ArcadeEnum.EffectType.Bomb]
	self._skillMo = effectList and effectList[ArcadeEnum.EffectType.Skill]
	self._collectionMo = effectList and effectList[ArcadeEnum.EffectType.Collection]

	self:_refreshSkill()
	self:_refreshBoom()
	self:_refreshCollection()
end

function ArcadeHallView:_refreshDevelopReddot()
	ArcadeHallModel.instance:refreshDevelopReddot()
	self:_refreshUIReddot(ArcadeHallEnum.HallInteractiveId.Develop)
end

function ArcadeHallView:_refreshHandBookReddot()
	ArcadeHallModel.instance:refreshHandBookReddot()
	self:_refreshUIReddot(ArcadeHallEnum.HallInteractiveId.HandBook)
end

function ArcadeHallView:_refreshTaskReddot()
	ArcadeHallModel.instance:refreshTaskReddot()
	self:_refreshUIReddot(ArcadeHallEnum.HallInteractiveId.Task)
end

function ArcadeHallView:_refreshUIReddot(interactiveId)
	ArcadeController.instance:dispatchEvent(ArcadeEvent.OnRefreshHallBuildingReddot, interactiveId)
end

function ArcadeHallView:_onOpenView(viewName)
	if viewName == ViewName.ArcadeGameView then
		ArcadeController.instance:onExitHall(true)
	end
end

function ArcadeHallView:_refreshBoom()
	if self._boomMo == nil then
		return
	end

	local icon = self._boomMo:getIcon()

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageboomicon, icon)
	end

	self._txtboomnum.text = self._boomMo:getCount()
end

function ArcadeHallView:_refreshSkill()
	if self._skillMo == nil then
		return
	end

	local icon = self._skillMo:getIcon()

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageskillicon, icon)
	end

	self._imageskillprogress.fillAmount = 1
end

function ArcadeHallView:_refreshCollection()
	if self._collectionMo == nil then
		return
	end

	self._txtcollectionnum.text = self._collectionMo:getCount()

	local icon = self._collectionMo:getIcon()
	local isJewelry = self._collectionMo.type == ArcadeEnum.EffectType.Collection

	if isJewelry then
		if not string.nilorempty(icon) then
			self._simagecollectionicon:LoadImage(ResUrl.getEliminateIcon(icon))
		end
	else
		if not string.nilorempty(icon) then
			self._simageweaponicon:LoadImage(ResUrl.getEliminateIcon(icon))
		end

		self._imageweapondurability.fillAmount = 1
	end

	gohelper.setActive(self._gocollection, isJewelry)
	gohelper.setActive(self._goweapon, not isJewelry)
	gohelper.setActive(self._goweaponempty, isJewelry)
end

function ArcadeHallView:_onBeginTransitionGame(level)
	if self._readyEnterLevel then
		return
	end

	self._readyEnterLevel = level

	self._animPlayer:Play("close1", self._onFinishTransitionGame, self)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_transition)
end

function ArcadeHallView:_onFinishTransitionGame()
	self._sceneView:showScene(false)
	ArcadeGameController.instance:enterGame(self._readyEnterLevel)
end

function ArcadeHallView:_onExitHallView(isImmediate)
	if isImmediate then
		self:closeThis()
	else
		self._animPlayer:Play(UIAnimationName.Close, self.closeThis, self)
	end
end

function ArcadeHallView:onClose()
	ArcadeHallModel.instance:saveHeroGrid()

	if self._isRunning then
		self._isRunning = false

		LateUpdateBeat:Remove(self._onLateUpdate, self)
	end
end

function ArcadeHallView:onDestroyView()
	self._simagecollectionicon:UnLoadImage()
	self._simageweaponicon:UnLoadImage()
end

return ArcadeHallView
