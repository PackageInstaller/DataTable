-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/ArcadeGameView.lua

module("modules.logic.versionactivity3_3.arcade.view.game.ArcadeGameView", package.seeall)

local ArcadeGameView = class("ArcadeGameView", BaseView)

function ArcadeGameView:onInitView()
	self._goentitytip = gohelper.findChild(self.viewGO, "#go_entitytip")
	self._goeventtip = gohelper.findChild(self.viewGO, "#go_eventtip")
	self._txteventname = gohelper.findChildText(self.viewGO, "#go_eventtip/#scroll_desc/viewport/content/item/title/txt_name")
	self._goeventicon = gohelper.findChild(self.viewGO, "#go_eventtip/#scroll_desc/viewport/content/item/title/go_icon")
	self._simageeventicon = gohelper.findChildSingleImage(self.viewGO, "#go_eventtip/#scroll_desc/viewport/content/item/title/go_icon/image_icon")
	self._txteventdesc = gohelper.findChildText(self.viewGO, "#go_eventtip/#scroll_desc/viewport/content/item/txt_desc")
	self._gooptioncontent = gohelper.findChild(self.viewGO, "#go_eventtip/#scroll_desc/viewport/content/#go_option")
	self._gooptionitem = gohelper.findChild(self.viewGO, "#go_eventtip/#scroll_desc/viewport/content/#go_option/#go_optionitem")
	self._gogame = gohelper.findChild(self.viewGO, "Game")
	self._godrag = gohelper.findChild(self.viewGO, "Game/#go_drag")
	self._btndrag = gohelper.findChildButtonWithAudio(self.viewGO, "Game/#go_drag", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._gostoreRefresh = gohelper.findChild(self.viewGO, "Game/#go_storeRefresh")
	self._txtstoreRefreshNum = gohelper.findChildText(self.viewGO, "Game/#go_storeRefresh/#txt_num")
	self._btnstoreRefreshclick = gohelper.findChildButtonWithAudio(self.viewGO, "Game/#go_storeRefresh/#btn_click", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._goiconnode = gohelper.findChild(self.viewGO, "Game/#go_iconnode")
	self._goentityicon = gohelper.findChild(self.viewGO, "Game/#go_iconnode/#go_entityicon")
	self._gofloatnode = gohelper.findChild(self.viewGO, "Game/#go_floatnode")
	self._gofloatitem = gohelper.findChild(self.viewGO, "Game/#go_floatnode/#go_floatitem")
	self._goselectedframe = gohelper.findChild(self.viewGO, "Game/#go_selectedframe")
	self._goselectedlu = gohelper.findChild(self.viewGO, "Game/#go_selectedframe/leftup")
	self._goselectedrd = gohelper.findChild(self.viewGO, "Game/#go_selectedframe/rightdown")
	self._godangerwarning = gohelper.findChild(self.viewGO, "Game/#go_dangerWarning")
	self._simagedangericon = gohelper.findChildSingleImage(self.viewGO, "Game/#go_dangerWarning/#simage_icon")
	self._imagedangericon = self._simagedangericon:GetComponent(gohelper.Type_Image)
	self._txtdangername = gohelper.findChildText(self.viewGO, "Game/#go_dangerWarning/#txt_name")
	self._txtdangerdesc = gohelper.findChildText(self.viewGO, "Game/#go_dangerWarning/#txt_desc")
	self._gotimenode = gohelper.findChild(self.viewGO, "Game/#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "Game/#go_time/#txt_time")
	self._goskilltip = gohelper.findChild(self.viewGO, "Right/#go_skilltip")
	self._btnboom = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_boom", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._imageboomicon = gohelper.findChildImage(self.viewGO, "Right/#btn_boom/image_icon")
	self._txtboomNum = gohelper.findChildText(self.viewGO, "Right/#btn_boom/#txt_num")
	self._goboomCanUse = gohelper.findChild(self.viewGO, "Right/#btn_boom/#go_canUse")
	self._goboomLack = gohelper.findChild(self.viewGO, "Right/#btn_boom/#go_lack")
	self._btnskill = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_skill", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._imageskillicon = gohelper.findChildImage(self.viewGO, "Right/#btn_skill/#image_icon")
	self._imageskillProgress = gohelper.findChildImage(self.viewGO, "Right/#btn_skill/image_progress")
	self._goskillCanUse = gohelper.findChild(self.viewGO, "Right/#btn_skill/#go_canUse")
	self._gocollection = gohelper.findChild(self.viewGO, "Left/#go_item/#scroll_collection/viewport/content")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "Left/#go_item/#scroll_collection/viewport/content/#go_collectionitem")
	self._btncollection = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_item/#scroll_collection/#btn_collectionclick", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._gocollectionFlyTarget = gohelper.findChild(self.viewGO, "Left/#go_item/#go_collectionflytarget")
	self._goweapon = gohelper.findChild(self.viewGO, "Left/#go_item/#go_weapon")
	self._goweaponItem = gohelper.findChild(self.viewGO, "Left/#go_item/#go_weapon/#go_weaponitem")
	self._goweaponFlyTarget = gohelper.findChild(self.viewGO, "Left/#go_item/#go_weaponflytarget")
	self._goitemtip = gohelper.findChild(self.viewGO, "Left/#go_itemtip")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "Left/hero/mask/simage_icon")
	self._gohpbar = gohelper.findChild(self.viewGO, "Left/hero/#go_hpbar")
	self._gohpitem = gohelper.findChild(self.viewGO, "Left/hero/#go_hpbar/go_hpitem")
	self._txthpnum = gohelper.findChildText(self.viewGO, "Left/hero/go_hpNum/#txt_num")
	self._gobase = gohelper.findChild(self.viewGO, "Left/hero/#go_base")
	self._gobaseItem = gohelper.findChild(self.viewGO, "Left/hero/#go_base/go_baseitem")
	self._btnLeft = gohelper.findChildClick(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_left")
	self._btnRight = gohelper.findChildClick(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_right")
	self._btnUp = gohelper.findChildClick(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_up")
	self._btnDown = gohelper.findChildClick(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_down")
	self._gocurrencyFlyTarget = gohelper.findChild(self.viewGO, "Top/#go_currencyflytarget")
	self._txtcurrent = gohelper.findChildText(self.viewGO, "Top/#go_rest/#txt_current")
	self._txttotal = gohelper.findChildText(self.viewGO, "Top/#go_rest/#txt_current/#txt_total")
	self._golv = gohelper.findChild(self.viewGO, "Top/#go_lv")
	self._imagelvBG = gohelper.findChildImage(self.viewGO, "Top/#go_lv/#image_lvBG")
	self._imagelv = gohelper.findChildImage(self.viewGO, "Top/#go_lv/#image_lv")
	self._txtrate = gohelper.findChildText(self.viewGO, "Top/#go_lv/#txt_rate")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topleft/#btn_back", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._goFlyItemContent = gohelper.findChild(self.viewGO, "#go_flyItemContent")
	self._goFlyItem = gohelper.findChild(self.viewGO, "#go_flyItemContent/#go_flyItem")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")
	self._gowave = gohelper.findChild(self.viewGO, "#go_wave")
	self._excessiveAnimEvent = gohelper.findChildComponent(self.viewGO, "#go_excessive/storymode/anim", gohelper.Type_AnimationEventWrap)
	self._transFlyContent = self._goFlyItemContent.transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeGameView:addEvents()
	self._btnboom:AddClickListener(self._btnboomOnClick, self)
	self._btnskill:AddClickListener(self._btnskillOnClick, self)
	self._btnstoreRefreshclick:AddClickListener(self._btnstoreRefreshOnClick, self)
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnLeft:AddClickDownListener(self._btnDirectionOnClick, self, ArcadeEnum.Direction.Left)
	self._btnRight:AddClickDownListener(self._btnDirectionOnClick, self, ArcadeEnum.Direction.Right)
	self._btnUp:AddClickDownListener(self._btnDirectionOnClick, self, ArcadeEnum.Direction.Up)
	self._btnDown:AddClickDownListener(self._btnDirectionOnClick, self, ArcadeEnum.Direction.Down)
	self._btndrag:AddClickListener(self._btnClickOnClick, self)

	self._dragHandle = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._dragHandle:AddDragBeginListener(self._onDragBegin, self)
	self._dragHandle:AddDragListener(self._onDrag, self)
	self._dragHandle:AddDragEndListener(self._onDragEnd, self)
	NavigateMgr.instance:addEscape(ViewName.ArcadeGameView, self._btnbackOnClick, self)
	self._excessiveAnimEvent:AddEventListener("beginSwitchRoom", self._onBeginSwitchRoom, self)
	self._skillLongPress:AddLongPressListener(self._onSkillLongPress, self)
	self._bombLongPress:AddLongPressListener(self._onBombLongPress, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnResetArcadeGame, self._onResetArcadeGame, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnCharacterResourceCountUpdate, self._onCharacterResourceUpdate, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnAddEntities, self._onAddEntities, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnLoadEntityFinished, self._onLoadEntitiesFinish, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnChangeEntityHp, self._onHpChange, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillAttrChange, self._onSkillChangeAttr, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillResourceChange, self._onSkillChangeRes, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnEntityMove, self._onEntityMove, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnEntityTweenMove, self._onEntityTweenMove, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnRemoveEntity, self._onRemoveEntity, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.RefreshGameEventTip, self._onRefreshGameEventTip, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnArcadeRoomExit, self._onRoomExit, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnChangeArcadeRoomFinish, self._onChangeRoomFinish, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnCollectionChange, self._onCollectionChange, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnWeaponDurabilityChange, self._onWeaponDurabilityChange, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.PlayChangeRoomExcessive, self._onPlayChangeRoomExcessive, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillGameSwitchChange, self._onSkillGameSwitchChange, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSetAllEntityIsShow, self._onSetAllEntityIsShow, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.PlayUIEffect, self._onPlayUIEffect, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeGameView:removeEvents()
	self._btnboom:RemoveClickListener()
	self._btnskill:RemoveClickListener()
	self._btnstoreRefreshclick:RemoveClickListener()
	self._btncollection:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self._btnLeft:RemoveClickDownListener()
	self._btnRight:RemoveClickDownListener()
	self._btnUp:RemoveClickDownListener()
	self._btnDown:RemoveClickDownListener()
	self._dragHandle:RemoveDragBeginListener()
	self._dragHandle:RemoveDragEndListener()
	self._dragHandle:RemoveDragListener()
	self._btndrag:RemoveClickListener()
	self._excessiveAnimEvent:RemoveAllEventListener()
	self._skillLongPress:RemoveLongPressListener()
	self._bombLongPress:RemoveLongPressListener()
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnResetArcadeGame, self._onResetArcadeGame, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnCharacterResourceCountUpdate, self._onCharacterResourceUpdate, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnAddEntities, self._onAddEntities, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnLoadEntityFinished, self._onLoadEntitiesFinish, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnChangeEntityHp, self._onHpChange, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillAttrChange, self._onSkillChangeAttr, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillResourceChange, self._onSkillChangeRes, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnEntityMove, self._onEntityMove, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnEntityTweenMove, self._onEntityTweenMove, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnRemoveEntity, self._onRemoveEntity, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.RefreshGameEventTip, self._onRefreshGameEventTip, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnArcadeRoomExit, self._onRoomExit, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnChangeArcadeRoomFinish, self._onChangeRoomFinish, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnCollectionChange, self._onCollectionChange, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnWeaponDurabilityChange, self._onWeaponDurabilityChange, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.PlayChangeRoomExcessive, self._onPlayChangeRoomExcessive, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillGameSwitchChange, self._onSkillGameSwitchChange, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.PlayUIEffect, self._onPlayUIEffect, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeGameView:_btnboomOnClick()
	ArcadeGameController.instance:playerTryPlaceBomb()
	self:_closeTipView()
end

function ArcadeGameView:_btnskillOnClick()
	ArcadeGameController.instance:playerTryUseSkill()
	self:_closeTipView()
end

function ArcadeGameView:_btnweaponOnClick(index)
	if self._weaponItemList then
		local weaponItem = self._weaponItemList[index]

		if not weaponItem or not weaponItem.uid then
			return
		end

		local characterMO = ArcadeGameModel.instance:getCharacterMO()
		local weaponMO = characterMO and characterMO:getCollectionMO(weaponItem.uid)

		if weaponMO then
			local weaponId = weaponMO:getId()
			local remainDurability = weaponMO:getRemainDurability()
			local anchor = {
				x = -219,
				y = -168
			}
			local param = {
				isInSide = true,
				skillTipType = ArcadeEnum.EffectType.Weapon,
				tipId = weaponId,
				durability = remainDurability,
				root = self._goitemtip,
				AnchorPos = anchor,
				orignViewName = self.viewName
			}

			ArcadeController.instance:openTipView(ArcadeEnum.TipType.Skill, param)
			self:closeEventTip()
			self:changeSelectedFrame()
		end
	end
end

function ArcadeGameView:_btncollectionOnClick()
	local collectionIdList = {}
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		collectionIdList = characterMO:getCollectionIdList(ArcadeGameEnum.CollectionType.Jewelry)
	end

	if not collectionIdList or #collectionIdList <= 0 then
		return
	end

	local anchor = {
		x = -199,
		y = -185
	}
	local param = {
		isInSide = true,
		root = self._goitemtip,
		AnchorPos = anchor,
		collectionList = collectionIdList,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Collection, param)
	self:closeEventTip()
	self:changeSelectedFrame()
end

function ArcadeGameView:_btnoptionOnClick(index)
	local changeDesc
	local eventEntityType, eventEntityUid = ArcadeGameModel.instance:getNearEventEntity()
	local eventEntityMO = ArcadeGameModel.instance:getMOWithType(eventEntityType, eventEntityUid)

	if eventEntityMO then
		local entityId = eventEntityMO:getId()
		local eventOptionId = eventEntityMO:getEventOptionId(index)
		local eventOptionType = ArcadeConfig.instance:getEventOptionType(eventOptionId)
		local eventOptionParam = eventEntityMO:getEventOptionParam(index)
		local extraParam

		if eventOptionType == ArcadeGameEnum.EventOptionType.Buy then
			local goodsMOList = ArcadeGameModel.instance:getEntityMOList(ArcadeGameEnum.EntityType.Goods)

			if goodsMOList then
				extraParam = {}

				for i, goodsMO in ipairs(goodsMOList) do
					extraParam[i] = goodsMO:getEventOptionParam()
				end
			end
		elseif eventOptionType == ArcadeGameEnum.EventOptionType.ChangeRoom then
			local portalMOList = ArcadeGameModel.instance:getEntityMOList(ArcadeGameEnum.EntityType.Portal)

			if portalMOList then
				extraParam = {
					exitRoomId = ArcadeGameModel.instance:getCurRoomId(),
					portalIdList = {}
				}

				for i, portalMO in ipairs(portalMOList) do
					extraParam.portalIdList[i] = portalMO:getId()
				end
			end
		end

		local result = ArcadeGameController.instance:triggerEventOption(eventEntityType, entityId, eventEntityUid, eventOptionId, eventOptionParam, nil, nil, extraParam)

		if result then
			changeDesc = ArcadeConfig.instance:getEventOptionTriggerDesc(eventOptionId)

			self:checkEntityTalk(ArcadeGameEnum.TalkTriggerType.Interactive, eventOptionId)
		end
	end

	if not string.nilorempty(changeDesc) and (self._showingEventEntityType and eventEntityType ~= self._showingEventEntityType or self._showingEventEntityUid and eventEntityUid ~= self._showingEventEntityUid or nil) and false then
		self._txteventdesc.text = changeDesc
	end

	self:setEventOptionList()
end

function ArcadeGameView:_btnstoreRefreshOnClick()
	ArcadeGameController.instance:resetGoods()
	self:refreshStoreResetBtn()
end

function ArcadeGameView:_btnbackOnClick()
	ArcadeController.instance:openQuitTipView(true)
end

function ArcadeGameView:_btnDirectionOnClick(direction)
	ArcadeGameController.instance:playerActOnDirection(direction)
	self:_closeTipView()
end

function ArcadeGameView:_onDragBegin(param, pointerEventData)
	self._startPosition = pointerEventData.position
end

local DRAG_OFFSET = 10

function ArcadeGameView:_onDrag(param, pointerEventData)
	return
end

function ArcadeGameView:_onDragEnd(param, pointerEventData)
	local direction
	local x = pointerEventData.position.x - self._startPosition.x
	local y = pointerEventData.position.y - self._startPosition.y
	local absX = math.abs(x)
	local absY = math.abs(y)

	if absY < absX then
		if x < -DRAG_OFFSET then
			direction = ArcadeEnum.Direction.Left
		end

		if x > DRAG_OFFSET then
			direction = ArcadeEnum.Direction.Right
		end
	else
		if y < -DRAG_OFFSET then
			direction = ArcadeEnum.Direction.Down
		end

		if y > DRAG_OFFSET then
			direction = ArcadeEnum.Direction.Up
		end
	end

	self:_btnDirectionOnClick(direction)
end

function ArcadeGameView:_btnClickOnClick()
	local scene = ArcadeGameController.instance:getGameScene()

	if scene then
		::label_15_0::

		local transEntityMgr = scene.entityMgr:getTrans()

		if not transEntityMgr then
			self:_closeTipView()

			return
		end

		local mousePos = GamepadController.instance:getMousePosition()
		local worldPos = recthelper.screenPosToWorldPos(mousePos, nil, transEntityMgr.position)
		local localPos = transEntityMgr:InverseTransformPoint(worldPos.x, worldPos.y, 0)
		local gridSize = ArcadeConfig.instance:getArcadeGameGridSize()
		local halfGridSize = gridSize / 2
		local startX, startY = ArcadeConfig.instance:getArcadeGameStartPos()
		local gridX = math.floor((localPos.x - startX + halfGridSize) / gridSize) + 1
		local gridY = math.floor((localPos.y - startY + halfGridSize) / gridSize) + 1
		local min = ArcadeGameEnum.Const.RoomMinCoordinateValue
		local max = ArcadeGameEnum.Const.RoomSize

		if gridX < min or max < gridX or gridY < min or max < gridY then
			self:_closeTipView()

			return
		end

		local curRoom = ArcadeGameController.instance:getCurRoom()
		local occupyEntityData = curRoom and curRoom:getEntityDataInTargetGrid(gridX, gridY)

		if not occupyEntityData then
			self:_closeTipView()

			return
		end

		local entityType = occupyEntityData.entityType
		local uid = occupyEntityData.uid

		if isDebugBuild then
			local clickUnitMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)
			local id = clickUnitMO and clickUnitMO:getId()

			logNormal(string.format("Arcade click entity, Type:%s Id:%s Uid:%s GridX:%s GridY:%s", tostring(entityType), tostring(id), tostring(uid), tostring(gridX), tostring(gridY)))
		end

		if entityType == ArcadeGameEnum.EntityType.Character or entityType == ArcadeGameEnum.EntityType.Monster then
			self:closeEventTip()

			local anchor = {
				x = 705,
				y = 112
			}
			local param = {
				hideCloseBtn = true,
				isInSide = true,
				root = self._goentitytip,
				AnchorPos = anchor,
				entityType = entityType,
				uid = uid,
				orignViewName = self.viewName
			}

			ArcadeController.instance:openTipView(ArcadeEnum.TipType.Hero, param)
			self:changeSelectedFrame(entityType, uid)
		end
	end
end

function ArcadeGameView:_onResetArcadeGame()
	self:onOpen()
end

function ArcadeGameView:_onCharacterResourceUpdate(resId, gainPosList)
	if resId == ArcadeGameEnum.CharacterResource.Score then
		self:refreshScore(true)
	elseif resId == ArcadeGameEnum.CharacterResource.Bomb then
		self:refreshBoom()
	elseif resId == ArcadeGameEnum.CharacterResource.SkillEnergy then
		self:refreshSkillEnergy(true)
	elseif resId == ArcadeGameEnum.CharacterResource.RespawnTimes then
		self:refreshAttr()
	elseif resId == ArcadeGameEnum.CharacterResource.GameCoin then
		if gainPosList then
			for _, gainPos in ipairs(gainPosList) do
				local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(gainPos.x, gainPos.y, gainPos.z, self._transFlyContent)

				self:playEffectFlying(rectPosX, rectPosY, self._currencyPosV2)
			end
		end

		self:refreshEventOptionList()
		self:refreshStoreResetBtn()
	end
end

function ArcadeGameView:_onAddEntities(moList)
	return
end

function ArcadeGameView:_onLoadEntitiesFinish(entityDataList)
	for _, entityData in ipairs(entityDataList) do
		local entityType = entityData.entityType
		local uid = entityData.uid
		local mo = ArcadeGameModel.instance:getMOWithType(entityType, uid)

		self:addIcon2Entity(mo)
	end
end

function ArcadeGameView:_onHpChange(mo, changeVal)
	if not mo then
		return
	end

	local gridX, gridY = mo:getGridPos()

	self:addFightFloatData(gridX, gridY, changeVal)

	local entityType = mo:getEntityType()

	if entityType == ArcadeGameEnum.EntityType.Character then
		self:refreshHp()
	end
end

function ArcadeGameView:_onSkillChangeAttr(entityType, uid, attrId)
	if attrId == ArcadeGameEnum.BaseAttr.hp then
		local mo = ArcadeGameModel.instance:getMOWithType(entityType, uid)

		self:_onHpChange(mo)
	end

	if entityType == ArcadeGameEnum.EntityType.Character then
		self:refreshAttr()
		self:refreshHpCap()
	end
end

function ArcadeGameView:_onSkillChangeRes(entityType, uid, resId, val, gainPosList)
	if entityType == ArcadeGameEnum.EntityType.Character then
		self:_onCharacterResourceUpdate(resId, gainPosList)
	end
end

function ArcadeGameView:_onEntityMove(mo)
	if not mo then
		return
	end

	local entityType = mo:getEntityType()
	local uid = mo:getUid()
	local usedIcon = self:getUsedIcon(entityType, uid)

	if usedIcon then
		usedIcon:refreshPos()
	end

	if entityType == self._selectedEntityType and uid == self._selectedUid then
		self:refreshSelectedFrame()
	end
end

function ArcadeGameView:_onEntityTweenMove(entityType, uid, isTween)
	if entityType == self._selectedEntityType and uid == self._selectedUid then
		self:refreshSelectedFrame()

		self._selectedFrameTweenMoving = isTween
	end
end

function ArcadeGameView:_onRemoveEntity(entityType, uidList)
	if uidList then
		for _, uid in ipairs(uidList) do
			self:recycleIcon(entityType, uid)
		end
	end

	self:checkSelectedEntity()
end

function ArcadeGameView:_onRefreshGameEventTip()
	local isOpenTipView = ViewMgr.instance:isOpen(ViewName.ArcadeTipsView)

	if isOpenTipView then
		return
	end

	local eventEntityType, eventEntityUid = ArcadeGameModel.instance:getNearEventEntity()

	if eventEntityType == self._showingEventEntityType and self._showingEventEntityUid == eventEntityUid then
		return
	end

	local isPlay = false

	if self._showingEventEntityType ~= eventEntityType or self._showingEventEntityUid ~= eventEntityUid then
		isPlay = true

		if eventEntityType and eventEntityUid then
			self._eventTipCanvasGroup.alpha = 0
		end
	end

	self:refreshEventTip(isPlay)
end

function ArcadeGameView:_onRoomExit()
	self._fightFloatDataDict = nil

	self:recycleAllIcon()
	self:refreshEventTip((self._showingEventEntityType and self._showingEventEntityUid or nil) and true)
	self:_closeTipView()
end

function ArcadeGameView:_onChangeRoomFinish()
	self:refreshLevelProgress()
	self:refreshStoreResetBtn()
	self:checkEntityIcon()
	self:checkDangerWarning()
end

function ArcadeGameView:_onCollectionChange(weaponGainPosList, collectionGainPosList)
	self:_checkWeaponList()
	self:_checkCollectList()

	if weaponGainPosList then
		for _, gainPos in ipairs(weaponGainPosList) do
			local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(gainPos.x, gainPos.y, gainPos.z, self._transFlyContent)

			self:playEffectFlying(rectPosX, rectPosY, self._weaponPosV2)
		end
	end

	if collectionGainPosList then
		for _, gainPos in ipairs(collectionGainPosList) do
			local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(gainPos.x, gainPos.y, gainPos.z, self._transFlyContent)

			self:playEffectFlying(rectPosX, rectPosY, self._collectionPosV2)
		end
	end

	self:refreshAttr()
end

function ArcadeGameView:_checkWeaponList()
	local lossWeapon = false
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if self._weaponItemList then
		for _, weaponItem in ipairs(self._weaponItemList) do
			local uid = weaponItem.uid

			if uid then
				local weaponMO = characterMO and characterMO:getCollectionMO(uid)

				if not weaponMO then
					weaponItem.animator:Play("breaking", 0, 0)

					lossWeapon = true
				end
			end
		end
	end

	if lossWeapon then
		TaskDispatcher.cancelTask(self.refreshWeapon, self)
		TaskDispatcher.runDelay(self.refreshWeapon, self, 0.5)
	else
		self:refreshWeapon()
	end
end

function ArcadeGameView:_checkCollectList()
	local lossCollection = false
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	self._newCollectionList = {}

	local collectionIdDict = {}
	local collectionIdList = characterMO and characterMO:getCollectionIdList(ArcadeGameEnum.CollectionType.Jewelry)

	if collectionIdList then
		for _, collectionId in ipairs(collectionIdList) do
			collectionIdDict[collectionId] = true

			if self._collectionItemDict and not self._collectionItemDict[collectionId] then
				self._newCollectionList[#self._newCollectionList + 1] = collectionId
			end
		end
	end

	if self._collectionItemDict then
		for id, collectionItem in pairs(self._collectionItemDict) do
			if not collectionIdDict[id] then
				collectionItem.animator:Play("out", 0, 0)

				lossCollection = true
			end
		end
	end

	if lossCollection then
		TaskDispatcher.cancelTask(self.setCollections, self)
		TaskDispatcher.runDelay(self.setCollections, self, 0.167)
	else
		self:setCollections()
	end
end

function ArcadeGameView:_onWeaponDurabilityChange()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if not self._weaponItemList or not characterMO then
		return
	end

	for _, weaponItem in ipairs(self._weaponItemList) do
		local weaponUid = weaponItem.uid
		local weaponMO = characterMO:getCollectionMO(weaponUid)

		if weaponMO then
			local durabilityProgress = 1
			local remainDurability = weaponMO:getRemainDurability()

			if remainDurability then
				local totalDurability = weaponMO:getTotalDurability()

				durabilityProgress = remainDurability / totalDurability
			end

			weaponItem.imagedurability.fillAmount = durabilityProgress
		end
	end
end

function ArcadeGameView:_onPlayChangeRoomExcessive()
	gohelper.setActive(self._goexcessive, false)
	gohelper.setActive(self._goexcessive, true)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_transition)
	TaskDispatcher.cancelTask(self._playExcessiveOverTime, self)
	TaskDispatcher.runDelay(self._playExcessiveOverTime, self, 5)
end

function ArcadeGameView:_playExcessiveOverTime()
	logError("ArcadeGameView:_playExcessiveOverTime")
	self:_onBeginSwitchRoom()
end

function ArcadeGameView:_onBeginSwitchRoom()
	TaskDispatcher.cancelTask(self._playExcessiveOverTime, self)

	local scene = ArcadeGameController.instance:getGameScene()

	if scene then
		scene.roomMgr:switchRoom()
	end
end

function ArcadeGameView:_onSkillLongPress()
	local anchor = {
		x = 266,
		y = -168
	}
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local skillId = ArcadeConfig.instance:getCharacterSkill(characterId)
	local param = {
		isInSide = true,
		skillTipType = ArcadeEnum.EffectType.Skill,
		tipId = skillId,
		root = self._goskilltip,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Skill, param)
	self:closeEventTip()
	self:changeSelectedFrame()
end

function ArcadeGameView:_onBombLongPress()
	local anchor = {
		x = 266,
		y = -168
	}
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local bombId = ArcadeConfig.instance:getCharacterBomb(characterId)
	local param = {
		isInSide = true,
		skillTipType = ArcadeEnum.EffectType.Bomb,
		tipId = bombId,
		root = self._goskilltip,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Skill, param)
	self:closeEventTip()
	self:changeSelectedFrame()
end

function ArcadeGameView:_onSkillGameSwitchChange(attrId, isOn)
	if attrId == ArcadeGameEnum.GameSwitch.DualWielding then
		self:setWeapons()
		self:refreshWeapon()
	end
end

function ArcadeGameView:_onSetAllEntityIsShow(isShow)
	gohelper.setActive(self._goiconnode, isShow)
end

function ArcadeGameView:_onPlayUIEffect(effectId, needPlayAudio)
	local uiEffName = ArcadeConfig.instance:getUIEffect(effectId)

	if string.nilorempty(uiEffName) or gohelper.isNil(self._uiEffectDict[uiEffName]) then
		return
	end

	local uiEffect = self._uiEffectDict[uiEffName]

	gohelper.setActive(uiEffect, false)
	gohelper.setActive(uiEffect, true)

	if needPlayAudio then
		local audioId = ArcadeConfig.instance:getEffectAudio(effectId)

		if audioId and audioId > 0 then
			AudioMgr.instance:trigger(audioId)
		end
	end
end

function ArcadeGameView:_onScreenResize()
	self:_setCamera()
	self:_setFlayItemEndPos()
end

function ArcadeGameView:_onCloseView(viewName)
	if viewName == ViewName.ArcadeTipsView then
		local eventEntityType, eventEntityUid = ArcadeGameModel.instance:getNearEventEntity()

		self:refreshEventTip((eventEntityType and eventEntityUid or nil) and true)
	end
end

function ArcadeGameView:_editableInitView()
	self._scoreAnimator = self._golv:GetComponent(gohelper.Type_Animator)
	self._topAnimator = gohelper.findChildComponent(self.viewGO, "Top", gohelper.Type_Animator)
	self._eventTipAnimator = self._goeventtip:GetComponent(gohelper.Type_Animator)
	self._eventTipCanvasGroup = self._goeventtip:GetComponent(gohelper.Type_CanvasGroup)
	self._goskillicon = self._imageskillicon.gameObject
	self._transgame = self._gogame.transform
	self._transfloatnode = self._gofloatnode.transform
	self._transselectedframe = self._goselectedframe.transform
	self._selectedAnimator = self._goselectedframe:GetComponent(gohelper.Type_Animator)
	self._selectedCanvasGroup = self._goselectedframe:GetComponent(gohelper.Type_CanvasGroup)

	gohelper.setActive(self._goselectedframe, true)

	self._transselectedlu = self._goselectedlu.transform
	self._transselectedrd = self._goselectedrd.transform
	self._skillLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnskill.gameObject)

	self._skillLongPress:SetLongPressTime({
		ArcadeGameEnum.Const.SkillBombLongPressTime,
		99999
	})

	self._bombLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnboom.gameObject)

	self._bombLongPress:SetLongPressTime({
		ArcadeGameEnum.Const.SkillBombLongPressTime,
		99999
	})

	self._iconPool = {}
	self._usedIconDict = {}

	gohelper.setActive(self._goentityicon, false)
	gohelper.setActive(self._gofloatitem, false)
	self:_setFlayItemEndPos()

	self.flyEffectItemList = self:getUserDataTb_()

	local flyEffectInitCount = 6

	for _ = 1, flyEffectInitCount do
		self:createFlyEffect()
	end

	gohelper.setActive(self._goFlyItem, false)
	gohelper.setActive(self._gotimenode, false)

	self._isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()

	if not self._isRunning then
		self._isRunning = true

		LateUpdateBeat:Add(self._onLateUpdate, self)
	end

	self._uiEffectDict = self:getUserDataTb_()
	self._uiEffectDict[self._gowave.name] = self._gowave
end

function ArcadeGameView:_onLateUpdate()
	if self._selectedFrameTweenMoving then
		self:refreshSelectedFrame()
	end

	self:checkDelayShowFightFloat()

	local inGuiding = ArcadeGameHelper.checkInGuiding()

	if inGuiding then
		return
	end

	if not self._isMobilePlayer then
		local direction

		if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.D) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.RightArrow) then
			direction = ArcadeEnum.Direction.Right
		elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.A) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.LeftArrow) then
			direction = ArcadeEnum.Direction.Left
		elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.W) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.UpArrow) then
			direction = ArcadeEnum.Direction.Up
		elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.S) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.DownArrow) then
			direction = ArcadeEnum.Direction.Down
		end

		if direction then
			self:_btnDirectionOnClick(direction)
		end
	end
end

function ArcadeGameView:onUpdateParam()
	return
end

function ArcadeGameView:onOpen()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local characterIcon = ArcadeConfig.instance:getCharacterIcon2(characterId)
	local characterIconPath = ResUrl.getEliminateIcon(characterIcon)

	self._simageheroicon:LoadImage(characterIconPath, self.onLoadCharacterIconFinished, self)

	local bombId = ArcadeConfig.instance:getCharacterBomb(characterId)
	local bombIcon = ArcadeConfig.instance:getBombIcon(bombId)

	UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageboomicon, bombIcon)

	local skillId = ArcadeConfig.instance:getCharacterSkill(characterId)
	local skillIcon = ArcadeConfig.instance:getActiveSkillIcon(skillId)

	UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageskillicon, skillIcon)

	self._attrItemDict = {}

	local showAttrList = {
		{
			id = ArcadeGameEnum.BaseAttr.attack
		},
		{
			id = ArcadeGameEnum.BaseAttr.defense
		},
		{
			isRes = true,
			id = ArcadeGameEnum.CharacterResource.RespawnTimes
		}
	}

	gohelper.CreateObjList(self, self._onCreateAttrItem, showAttrList, self._gobase, self._gobaseItem)
	MainCameraMgr.instance:addView(self.viewName, self._setCamera, nil, self)
	self:setWeapons()
	self:refresh()
	self:checkEntityIcon()
	self:checkDangerWarning()
end

function ArcadeGameView:_setFlayItemEndPos()
	self._currencyPosV2 = Vector2(0, 0)

	local currencyPos = recthelper.rectToRelativeAnchorPos(self._gocurrencyFlyTarget.transform.position, self._transFlyContent)

	self._currencyPosV2:Set(currencyPos.x, currencyPos.y)

	self._weaponPosV2 = Vector2(0, 0)

	local weaponPos = recthelper.rectToRelativeAnchorPos(self._goweaponFlyTarget.transform.position, self._transFlyContent)

	self._weaponPosV2:Set(weaponPos.x, weaponPos.y)

	self._collectionPosV2 = Vector2(0, 0)

	local collectionPos = recthelper.rectToRelativeAnchorPos(self._gocollectionFlyTarget.transform.position, self._transFlyContent)

	self._collectionPosV2:Set(collectionPos.x, collectionPos.y)
end

function ArcadeGameView:_setCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = ArcadeEnum.MapCameraSize * scale

	local cameraTrs = CameraMgr.instance:getMainCameraTrs()

	transformhelper.setLocalPos(cameraTrs, 0, 0, 0)
	transformhelper.setLocalRotation(cameraTrs, 0, 0, 0)
end

function ArcadeGameView:onLoadCharacterIconFinished()
	if not self._simageheroicon then
		return
	end

	self._simageheroicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local posArr = ArcadeConfig.instance:getCharacterIcon2Offset(characterId)
	local posX = posArr and tonumber(posArr[1])
	local posY = posArr and tonumber(posArr[2])
	local trans = self._simageheroicon.transform

	if posX and posY then
		transformhelper.setLocalPosXY(trans, posX, posY)
	end

	local scaleArr = ArcadeConfig.instance:getCharacterIcon2Scale(characterId)
	local scaleX = scaleArr and tonumber(scaleArr[1])
	local scaleY = scaleArr and tonumber(scaleArr[2])

	if posX and posY then
		transformhelper.setLocalScale(trans, scaleX, scaleY, 1)
	end
end

function ArcadeGameView:_onCreateAttrItem(obj, data, index)
	local attrItem = self:getUserDataTb_()

	attrItem.id = data.id
	attrItem.isRes = data.isRes
	attrItem.go = obj
	attrItem.txtNum = gohelper.findChildText(obj, "#txt_num")
	attrItem._imagebase = gohelper.findChildImage(obj, "#txt_num/#image_base")

	local icon = ArcadeConfig.instance:getAttributeIcon(attrItem.id)

	UISpriteSetMgr.instance:setV3a3EliminateSprite(attrItem._imagebase, icon)

	self._attrItemDict[attrItem.id] = attrItem
end

function ArcadeGameView:setWeapons()
	self:_clearWeaponItems()

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local weaponNum = characterMO and characterMO:getCanCarryWeaponNum() or 0

	gohelper.CreateNumObjList(self._goweapon, self._goweaponItem, weaponNum, self._onCreateWeaponItem, self)
end

function ArcadeGameView:_onCreateWeaponItem(obj, index)
	local weaponItem = self:getUserDataTb_()

	weaponItem.go = obj
	weaponItem.animator = gohelper.findComponentAnim(weaponItem.go)
	weaponItem.gohas = gohelper.findChild(obj, "has")
	weaponItem.imagedurability = gohelper.findChildImage(obj, "has/image_durability")
	weaponItem.simageIcon = gohelper.findChildSingleImage(obj, "has/#image_icon")
	weaponItem.goempty = gohelper.findChild(obj, "empty")
	weaponItem.btn = gohelper.findChildButtonWithAudio(obj, "btn_click", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)

	weaponItem.btn:AddClickListener(self._btnweaponOnClick, self, index)

	self._weaponItemList[index] = weaponItem
end

function ArcadeGameView:checkDangerWarning()
	TaskDispatcher.cancelTask(self.closeDangerWarning, self)

	local dangerMonsterMO
	local monsterMOList = ArcadeGameModel.instance:getEntityMOList(ArcadeGameEnum.EntityType.Monster)

	if monsterMOList then
		for _, monsterMO in ipairs(monsterMOList) do
			local monsterId = monsterMO:getId()
			local race = ArcadeConfig.instance:getMonsterRace(monsterId)

			if race == ArcadeGameEnum.MonsterRace.Boss then
				dangerMonsterMO = monsterMO

				break
			end
		end
	end

	if dangerMonsterMO then
		ArcadeGameController.instance:setAllEntityVisibility()
		ArcadeGameController.instance:pauseGame()

		local icon = dangerMonsterMO:getIcon()
		local name = dangerMonsterMO:getName()
		local desc = dangerMonsterMO:getDesc()

		self._simagedangericon:LoadImage(ResUrl.getEliminateIcon(icon), self.setDangerIconNativeSize, self)

		self._txtdangername.text = name
		self._txtdangerdesc.text = desc

		gohelper.setActive(self._godangerwarning, true)
		AudioMgr.instance:trigger(AudioEnum3_7.Arcade.play_ui_beiai_boss_dengchang)

		local warningKeepTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.DangerWarningKeepTime, true)

		TaskDispatcher.runDelay(self.closeDangerWarning, self, warningKeepTime)
	else
		self:closeDangerWarning()
	end
end

function ArcadeGameView:setDangerIconNativeSize()
	self._imagedangericon:SetNativeSize()
end

function ArcadeGameView:closeDangerWarning()
	ArcadeGameController.instance:setAllEntityVisibility(true)
	ArcadeGameController.instance:resumeGame()
	gohelper.setActive(self._godangerwarning, false)
	self:checkEntityTalk(ArcadeGameEnum.TalkTriggerType.EnterRoom)
end

function ArcadeGameView:addFightFloatData(gridX, gridY, value)
	if not gridX or not gridY or not value then
		return
	end

	self._fightFloatDataDict = self._fightFloatDataDict or {}

	local gridId = ArcadeGameHelper.getGridId(gridX, gridY)
	local data = self._fightFloatDataDict[gridId]

	if data then
		data.val = data.val + value
	else
		self._fightFloatDataDict[gridId] = {
			beginTime = Time.time,
			gridX = gridX,
			gridY = gridY,
			val = value
		}
	end
end

function ArcadeGameView:checkDelayShowFightFloat()
	if not self._fightFloatDataDict then
		return
	end

	local curTime = Time.time
	local delayTime = ArcadeGameEnum.Const.FightFloatWaitTime
	local showGirdIdList = {}

	for gridId, fightFloatData in pairs(self._fightFloatDataDict) do
		if delayTime <= curTime - fightFloatData.beginTime then
			self:showFightFloat(fightFloatData.gridX, fightFloatData.gridY, fightFloatData.val)

			showGirdIdList[#showGirdIdList + 1] = gridId
		end
	end

	for _, gridId in ipairs(showGirdIdList) do
		self._fightFloatDataDict[gridId] = nil
	end
end

function ArcadeGameView:showFightFloat(gridX, gridY, value)
	if not gridX or not gridY or not value or value == 0 then
		return
	end

	local floatItem = self:getFightFloatItem(gridX, gridY)

	SLFramework.UGUI.GuiHelper.SetColor(floatItem.txtval, value >= 0 and "#00FF68" or "#FF1300")

	floatItem.txtval.text = math.abs(value)

	gohelper.setActive(floatItem.go, false)
	gohelper.setActive(floatItem.go, true)
end

function ArcadeGameView:getFightFloatItem(gridX, gridY)
	self._floatItemDict = self._floatItemDict or {}

	local gridId = ArcadeGameHelper.getGridId(gridX, gridY)
	local floatItem = self._floatItemDict[gridId]

	if not floatItem then
		floatItem = self:getUserDataTb_()
		floatItem.go = gohelper.clone(self._gofloatitem, self._gofloatnode)
		floatItem.txtval = gohelper.findChildText(floatItem.go, "x/txtNum")

		local x, y, z = ArcadeGameHelper.getGridWorldPos(gridX, gridY)
		local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(x, y, z, self._transfloatnode)

		recthelper.setAnchor(floatItem.go.transform, rectPosX, rectPosY)

		self._floatItemDict[gridId] = floatItem
	end

	return floatItem
end

function ArcadeGameView:checkEntityIcon()
	for _, entityType in ipairs(ArcadeGameEnum.IconEntityTypes) do
		local moList = ArcadeGameModel.instance:getEntityMOList(entityType)

		self:addIcon2EntityList(moList)
	end
end

function ArcadeGameView:addIcon2EntityList(moList)
	if not moList then
		return
	end

	for _, mo in ipairs(moList) do
		self:addIcon2Entity(mo)
	end
end

function ArcadeGameView:addIcon2Entity(mo)
	if not mo then
		return
	end

	local entityType = mo:getEntityType()
	local id = mo:getId()
	local isNeedIcon = ArcadeGameHelper.isEntityNeedIcon(entityType, id)

	if not isNeedIcon then
		return
	end

	local uid = mo:getUid()
	local usedIcon = self:getUsedIcon(entityType, uid)

	if usedIcon then
		usedIcon:refreshPos()

		return
	end

	local entityTypeDict = ArcadeGameHelper.checkDictTable(self._usedIconDict, entityType)
	local iconComp = self:getEntityIcon()

	iconComp:setEntity(entityType, uid, id)

	entityTypeDict[uid] = iconComp
end

function ArcadeGameView:getEntityIcon()
	if next(self._iconPool) then
		return table.remove(self._iconPool)
	else
		local goIcon = gohelper.clone(self._goentityicon, self._goiconnode)

		return (MonoHelper.addLuaComOnceToGo(goIcon, ArcadeGameEntityIcon))
	end
end

function ArcadeGameView:recycleIcon(entityType, uid)
	local iconComp = self:getUsedIcon(entityType, uid)

	if not iconComp then
		return
	end

	iconComp:reset()
	table.insert(self._iconPool, iconComp)

	self._usedIconDict[entityType][uid] = nil
end

function ArcadeGameView:recycleAllIcon()
	if not self._usedIconDict then
		return
	end

	for entityType, entityTypeDict in pairs(self._usedIconDict) do
		for _, iconComp in pairs(entityTypeDict) do
			iconComp:reset()
			table.insert(self._iconPool, iconComp)
		end

		self._usedIconDict[entityType] = nil
	end
end

function ArcadeGameView:getUsedIcon(entityType, uid)
	if not self._usedIconDict or not entityType or not uid then
		return
	end

	local entityTypeDict = self._usedIconDict[entityType]

	return entityTypeDict and entityTypeDict[uid]
end

function ArcadeGameView:checkEntityTalk(triggerType, param)
	for _, entityTypeDict in pairs(self._usedIconDict) do
		for _, iconComp in pairs(entityTypeDict) do
			iconComp:checkTalk(triggerType, param)
		end
	end
end

function ArcadeGameView:refresh()
	self:refreshScore()
	self:refreshBoom()
	self:refreshSkillEnergy()
	self:refreshEventTip()
	self:refreshLevelProgress()
	self:refreshAttr()
	self:refreshHpCap()
	self:refreshWeapon()
	self:setCollections()
	self:refreshStoreResetBtn()
	self:checkSelectedEntity()
end

function ArcadeGameView:refreshScore(isPlay)
	self:killScoreProgressTween()

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local curScore = characterMO and characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.Score) or 0
	local progress = 1
	local curGradeNeedScore = ArcadeConfig.instance:getCurGradeNeedScore(curScore)
	local nextGradeNeedScore = ArcadeConfig.instance:getNextGradeNeedScore(curScore)

	if nextGradeNeedScore and curGradeNeedScore < nextGradeNeedScore then
		local overScore = curScore - curGradeNeedScore
		local scoreStep = nextGradeNeedScore - curGradeNeedScore

		progress = Mathf.Clamp(overScore / scoreStep, 0, 1)
	end

	local icon = ArcadeConfig.instance:getArcadeGradeIcon(curScore)

	UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imagelv, icon)
	UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imagelvBG, icon)

	local tweenBegin, tweenEnd
	local curLevel = ArcadeConfig.instance:getArcadeGradeLevel(curScore)

	if isPlay then
		local audioId, scoreLevelAnimName

		if curLevel ~= self._curLevel then
			if curLevel > self._curLevel then
				tweenBegin = 0
				scoreLevelAnimName = "lvup"
				audioId = AudioEnum3_3.Arcade.play_ui_yuanzheng_rate
			else
				tweenBegin = 1
			end

			gohelper.setActive(self._txtrate, false)
			gohelper.setActive(self._txtrate, true)
		else
			if progress > self._curProgress then
				scoreLevelAnimName = "add"
			end

			tweenBegin = self._curProgress
		end

		tweenEnd = progress

		if not string.nilorempty(scoreLevelAnimName) then
			self._scoreAnimator:Play(scoreLevelAnimName, 0, 0)

			if audioId then
				AudioMgr.instance:trigger(audioId)
			end
		end
	end

	if tweenBegin and tweenEnd and tweenBegin ~= tweenEnd then
		self._scoreProgressTweenId = ZProj.TweenHelper.DOTweenFloat(tweenBegin, tweenEnd, 0.5, self._onTweenScoreProgress, nil, self, nil, EaseType.OutQuart)
	else
		self._imagelv.fillAmount = progress
	end

	self._curLevel = curLevel
	self._curProgress = progress

	local coinResMO = characterMO and characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.GameCoin)
	local gainRate = coinResMO and coinResMO:getGainRate()

	self._txtrate.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("add_percent_value"), (gainRate or 0) / 10)
end

function ArcadeGameView:killScoreProgressTween()
	if self._scoreProgressTweenId then
		ZProj.TweenHelper.KillById(self._scoreProgressTweenId)

		self._scoreProgressTweenId = nil
	end
end

function ArcadeGameView:_onTweenScoreProgress(value)
	if self._imagelv then
		self._imagelv.fillAmount = value
	end
end

function ArcadeGameView:refreshBoom()
	local boomCount = 0
	local maxCount = 0
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local boomResMO = characterMO and characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.Bomb)

	if boomResMO then
		boomCount = boomResMO:getCount()
		maxCount = boomResMO:getMax()
	end

	self._txtboomNum.text = boomCount

	local hasBoom = boomCount > 0

	gohelper.setActive(self._goboomCanUse, hasBoom)
	gohelper.setActive(self._goboomLack, not hasBoom)
end

function ArcadeGameView:refreshSkillEnergy(isTween)
	self:killSkillEnergyTween()

	local progress = 0
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local skillEnergyResMO = characterMO and characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.SkillEnergy)

	if skillEnergyResMO then
		local characterId = characterMO:getId()
		local needEnergy = ArcadeConfig.instance:getCharacterSkillCost(characterId)
		local curSkillEnergy = skillEnergyResMO:getCount()

		if needEnergy > 0 then
			progress = Mathf.Clamp(curSkillEnergy / needEnergy, 0, 1)
		end
	end

	if self._curSkillProgress and isTween then
		self._skillProgressTweenId = ZProj.TweenHelper.DOTweenFloat(self._curSkillProgress, progress, 0.5, self._onTweenSkillEnergy, nil, self, nil, EaseType.OutQuart)
	else
		self._imageskillProgress.fillAmount = progress
	end

	self._curSkillProgress = progress

	local isCanUse = progress >= 1

	ZProj.UGUIHelper.SetGrayscale(self._goskillicon, not isCanUse)
	gohelper.setActive(self._goskillCanUse, isCanUse)
end

function ArcadeGameView:killSkillEnergyTween()
	if self._skillProgressTweenId then
		ZProj.TweenHelper.KillById(self._skillProgressTweenId)

		self._skillProgressTweenId = nil
	end
end

function ArcadeGameView:_onTweenSkillEnergy(value)
	self._imageskillProgress.fillAmount = value
end

function ArcadeGameView:refreshEventTip(isPlay)
	local eventEntityType, eventEntityUid = ArcadeGameModel.instance:getNearEventEntity()

	if eventEntityType and eventEntityUid then
		self._showingEventEntityType = eventEntityType
		self._showingEventEntityUid = eventEntityUid

		local name = ""
		local desc = ""
		local icon = ""
		local eventEntityMO = ArcadeGameModel.instance:getMOWithType(eventEntityType, eventEntityUid)

		if eventEntityMO then
			name = eventEntityMO:getName()
			desc = eventEntityMO:getInteractDesc()
			icon = eventEntityMO:getIcon()
		end

		self._txteventname.text = name
		self._txteventdesc.text = desc

		if not string.nilorempty(icon) then
			local iconScaleX = 1
			local iconScaleY = 1
			local iconPath = ResUrl.getEliminateIcon(icon)

			self._simageeventicon:LoadImage(iconPath)

			if eventEntityType == ArcadeGameEnum.EntityType.Goods then
				iconScaleX, iconScaleY = eventEntityMO:getScale()
			end

			transformhelper.setLocalScale(self._simageeventicon.transform, iconScaleX or 1, iconScaleY or 1, 1)
			gohelper.setActive(self._goeventicon, true)
		else
			gohelper.setActive(self._goeventicon, false)
		end

		self:setEventOptionList()
		self._eventTipAnimator:Play("open", 0, isPlay and 0 or 1)
		AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_tips_open)
		self:_closeTipView()
		ArcadeGameController.instance:dispatchEvent(ArcadeEvent.TriggerGuideOnShowEventTip)
	else
		self._showingEventEntityType = nil
		self._showingEventEntityUid = nil

		self._eventTipAnimator:Play("close", 0, isPlay and 0 or 1)
		self:changeSelectedFrame()
	end
end

function ArcadeGameView:closeEventTip()
	if self._showingEventEntityType and self._showingEventEntityUid then
		self._showingEventEntityType = nil
		self._showingEventEntityUid = nil

		self._eventTipAnimator:Play("close", 0, 1)
	end
end

function ArcadeGameView:setEventOptionList()
	self:_clearOptionItemList()

	local optionList = {}
	local eventEntityType, eventEntityUid = ArcadeGameModel.instance:getNearEventEntity()
	local eventEntityMO = ArcadeGameModel.instance:getMOWithType(eventEntityType, eventEntityUid)

	if eventEntityMO and eventEntityMO.getEventOptionList then
		local canInteract = eventEntityMO:isCanInteract()

		if canInteract then
			optionList = eventEntityMO:getEventOptionList()
		end
	end

	gohelper.CreateObjList(self, self._onCreateEventOption, optionList, self._gooptioncontent, self._gooptionitem)
	self:refreshEventOptionList()
end

function ArcadeGameView:_onCreateEventOption(obj, data, index)
	local optionId = data
	local optionItem = self:getUserDataTb_()

	optionItem.go = obj
	optionItem.btnOption = gohelper.findChildButtonWithAudio(optionItem.go, "#btn_enter", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	optionItem.btnBuy = gohelper.findChildButtonWithAudio(optionItem.go, "#btn_buy", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	optionItem.txtbuycost = gohelper.findChildText(optionItem.go, "#btn_buy/#txt_num")

	optionItem.btnOption:AddClickListener(self._btnoptionOnClick, self, index)
	optionItem.btnBuy:AddClickListener(self._btnoptionOnClick, self, index)

	optionItem.goBuy = optionItem.btnBuy.gameObject

	local eventEntityType, eventEntityUid = ArcadeGameModel.instance:getNearEventEntity()
	local isGoods = eventEntityType == ArcadeGameEnum.EntityType.Goods

	if isGoods then
		local eventEntityMO = ArcadeGameModel.instance:getMOWithType(eventEntityType, eventEntityUid)

		optionItem.txtbuycost.text = eventEntityMO and eventEntityMO:getPrice() or 0
	else
		local optionDesc = ArcadeConfig.instance:getEventOptionDesc(optionId)
		local txtoption = gohelper.findChildText(optionItem.go, "#btn_enter/txt")

		txtoption.text = optionDesc
	end

	gohelper.setActive(optionItem.btnOption, not isGoods)
	gohelper.setActive(optionItem.btnBuy, isGoods)

	self._optionItemList[index] = optionItem
end

function ArcadeGameView:refreshEventOptionList()
	if not self._optionItemList or #self._optionItemList <= 0 then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local hasCoin = characterMO and characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.GameCoin) or 0
	local isGoods = self._showingEventEntityType == ArcadeGameEnum.EntityType.Goods

	if isGoods then
		for _, optionItem in ipairs(self._optionItemList) do
			local cost = tonumber(optionItem.txtbuycost.text) or 0
			local isCanBuy = cost <= hasCoin

			SLFramework.UGUI.GuiHelper.SetColor(optionItem.txtbuycost, isCanBuy and "#FFFFED" or "#FF1300")
			ZProj.UGUIHelper.SetGrayscale(optionItem.goBuy, not isCanBuy)
		end
	end
end

function ArcadeGameView:refreshLevelProgress()
	local total, cur = ArcadeGameModel.instance:getLevelCount()

	if total < cur then
		local difficulty = ArcadeGameModel.instance:getDifficulty()
		local curAreaIndex = ArcadeGameModel.instance:getCurAreaIndex()
		local roomId = ArcadeGameModel.instance:getCurRoomId()

		logError(string.format("ArcadeGameView:refreshLevelProgress error, level count over, difficulty:%s areaIndex:%s roomId:%s", difficulty, curAreaIndex, roomId))
		ArcadeGameController.instance:endGame(ArcadeGameEnum.SettleType.Win, true)
	else
		self._txtcurrent.text = cur
		self._txttotal.text = total

		self._topAnimator:Play("refresh", 0, 0)
	end
end

function ArcadeGameView:refreshAttr()
	if not self._attrItemDict then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local weaponMO
	local weaponUidList = characterMO and characterMO:getCollectionUidListWithType(ArcadeGameEnum.CollectionType.Weapon)
	local useWeaponUid = weaponUidList and weaponUidList[1]

	if useWeaponUid then
		weaponMO = characterMO and characterMO:getCollectionMO(useWeaponUid)
	end

	for attrId, attrItem in pairs(self._attrItemDict) do
		local value = 0

		if characterMO then
			if attrItem.isRes then
				value = characterMO:getResourceCount(attrId)
			else
				value = characterMO:getAttributeValue(attrId)

				if attrId == ArcadeGameEnum.BaseAttr.attack or attrId == ArcadeGameEnum.BaseAttr.defense then
					local attrSetMO = characterMO:getAttrSetMO()
					local tempVal = attrSetMO:getTempVal(attrId)

					value = value - tempVal

					if weaponMO then
						local weaponId = weaponMO:getId()
						local tmpShowAttrVal = ArcadeConfig.instance:getCollectionShowTempAttrVal(weaponId, attrId) or 0

						value = value + tmpShowAttrVal
					end
				end
			end
		end

		attrItem.txtNum.text = value
	end
end

function ArcadeGameView:refreshHpCap()
	self._characterHpItemList = {}

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local hpCap = characterMO and characterMO:getAttributeValue(ArcadeGameEnum.BaseAttr.hpCap) or 0
	local maxShowCount = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.MaxShowHpCount, true)
	local showHpCount = math.min(hpCap, maxShowCount)

	gohelper.CreateNumObjList(self._gohpbar, self._gohpitem, showHpCount, self._onCreateHpItem, self)
	self:refreshHp()
end

function ArcadeGameView:_onCreateHpItem(obj, index)
	local hpItem = self:getUserDataTb_()

	hpItem.go = obj
	hpItem.golight = gohelper.findChild(hpItem.go, "light")
	hpItem.imagehp = gohelper.findChildImage(hpItem.go, "light")
	self._characterHpItemList[index] = hpItem
end

function ArcadeGameView:refreshHp()
	if not self._characterHpItemList then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local curHp = characterMO and characterMO:getHp() or 0
	local showHpCount = #self._characterHpItemList

	for i, hpItem in ipairs(self._characterHpItemList) do
		local belongHpSeqIndex = ArcadeGameHelper.getHPSeqIndex(curHp, showHpCount, i)

		if belongHpSeqIndex and belongHpSeqIndex >= 0 then
			local imgIndex = ArcadeConfig.instance:getHpColorImgIndex(belongHpSeqIndex)
			local img = string.format("v3a3_eliminate_heart_%s", imgIndex)

			UISpriteSetMgr.instance:setV3a3EliminateSprite(hpItem.imagehp, img)
			gohelper.setActive(hpItem.golight, true)
		else
			gohelper.setActive(hpItem.golight, false)
		end
	end

	local hpCap = characterMO and characterMO:getAttributeValue(ArcadeGameEnum.BaseAttr.hpCap) or 0

	self._txthpnum.text = string.format("%s/%s", curHp, hpCap)
end

function ArcadeGameView:refreshWeapon()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	for i, weaponItem in ipairs(self._weaponItemList) do
		local weaponUid = ((characterMO or nil) and characterMO:getCollectionUidListWithType(ArcadeGameEnum.CollectionType.Weapon))[i]
		local weaponMO = characterMO and characterMO:getCollectionMO(weaponUid)
		local animName = "has"

		if weaponMO then
			weaponItem.uid = weaponUid

			local weaponId = weaponMO:getId()
			local icon = ArcadeConfig.instance:getCollectionIcon(weaponId)
			local iconPath = ResUrl.getEliminateIcon(icon)

			weaponItem.simageIcon:LoadImage(iconPath)

			local durabilityProgress = 1
			local remainDurability = weaponMO:getRemainDurability()

			if remainDurability then
				local totalDurability = weaponMO:getTotalDurability()

				durabilityProgress = remainDurability / totalDurability
			end

			weaponItem.imagedurability.fillAmount = durabilityProgress
		else
			weaponItem.uid = nil
			animName = "empty"
		end

		weaponItem.animator:Play(animName, 0, 0)
		gohelper.setActive(weaponItem.gohas, weaponMO)
		gohelper.setActive(weaponItem.goempty, not weaponMO)
	end
end

function ArcadeGameView:setCollections()
	self:_clearCollectionItems()

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	gohelper.CreateObjList(self, self._onCreateCollectionItem, (characterMO or nil) and characterMO:getCollectionIdList(ArcadeGameEnum.CollectionType.Jewelry), self._gocollection, self._gocollectionitem)
	self:_checkNewCollection()
end

function ArcadeGameView:_onCreateCollectionItem(obj, data, index)
	local collectionItem = self:getUserDataTb_()

	collectionItem.id = data
	collectionItem.go = obj
	collectionItem.animator = gohelper.findComponentAnim(collectionItem.go)
	collectionItem.simageIcon = gohelper.findChildSingleImage(obj, "#image_icon")

	local icon = ArcadeConfig.instance:getCollectionIcon(collectionItem.id)
	local iconPath = ResUrl.getEliminateIcon(icon)

	collectionItem.simageIcon:LoadImage(iconPath)

	collectionItem.txtNum = gohelper.findChildText(obj, "#txt_num")

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local uidList = characterMO and characterMO:getCollectionUidList(collectionItem.id)

	if uidList then
		collectionItem.txtNum.text = #uidList
	end

	collectionItem.animator:Play("idle", 0, 0)

	self._collectionItemDict[data] = collectionItem
end

function ArcadeGameView:_checkNewCollection()
	if self._newCollectionList and self._collectionItemDict then
		for _, id in ipairs(self._newCollectionList) do
			local item = self._collectionItemDict[id]

			if item then
				item.animator:Play("in", 0, 0)
			end
		end
	end

	self._newCollectionList = nil
end

function ArcadeGameView:refreshStoreResetBtn()
	local roomId = ArcadeGameModel.instance:getCurRoomId()

	if roomId then
		::label_90_0::

		local roomType = ArcadeConfig.instance:getRoomType(roomId)
		local isOpenReset = ArcadeGameModel.instance:getGameSwitchIsOn(ArcadeGameEnum.GameSwitch.CanResetStore)
		local canResetTimes = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.StoreRoomResetTimes, true)
		local haveResetTimes = ArcadeGameModel.instance:getGoodsHasResetTimes()
		local isShowStoreRefreshBtn = not (roomType ~= ArcadeGameEnum.RoomType.Store or not isOpenReset or canResetTimes <= haveResetTimes)

		if isShowStoreRefreshBtn then
			local resetCost = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.ResetStoreCost)

			self._txtstoreRefreshNum.text = resetCost

			local characterMO = ArcadeGameModel.instance:getCharacterMO()
			local coinResMO = characterMO and characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.GameCoin)
			local hasCoin = coinResMO and coinResMO:getCount() or 0

			SLFramework.UGUI.GuiHelper.SetColor(self._txtstoreRefreshNum, resetCost <= hasCoin and "#FFFFED" or "#FF1300")
		end

		gohelper.setActive(self._gostoreRefresh, isShowStoreRefreshBtn)
	end
end

function ArcadeGameView:checkSelectedEntity()
	if not self._selectedEntityType or not self._selectedUid then
		self._selectedAnimator:Play(UIAnimationName.Close, 0, 1)

		return
	end

	local scene = ArcadeGameController.instance:getGameScene()

	if scene then
		::label_91_0::

		local entity = scene.entityMgr:getEntityWithType(self._selectedEntityType, self._selectedUid)

		if not entity then
			self:changeSelectedFrame()
		else
			self:refreshSelectedFrame()
		end
	end
end

function ArcadeGameView:changeSelectedFrame(entityType, uid)
	if self._selectedEntityType == entityType and self._selectedUid == uid then
		return
	end

	local newSelectedEntityType, newSelectedUid, sizeX, sizeY
	local scene = ArcadeGameController.instance:getGameScene()

	if scene then
		::label_92_0::

		local entity = scene.entityMgr:getEntityWithType(entityType, uid)

		if entityType ~= ArcadeGameEnum.EntityType.Character then
			local mo = entity and entity:getMO()

			if mo then
				if entityType == ArcadeGameEnum.EntityType.Monster then
					local id = mo:getId()
					local showFrame = ArcadeGameHelper.isShowMonsterFrame(id)

					if not showFrame then
						newSelectedEntityType = entityType
						newSelectedUid = uid
						sizeX, sizeY = mo:getSize()
					end
				else
					newSelectedEntityType = entityType
					newSelectedUid = uid
					sizeX, sizeY = mo:getSize()
				end
			end
		end

		if sizeX and sizeY then
			local uiGridSize = ArcadeConfig.instance:getArcadeGameUIGridSize()
			local halfUIGridSize = uiGridSize / 2

			transformhelper.setLocalPosXY(self._transselectedlu, -halfUIGridSize, (sizeY - 0.5) * uiGridSize)
			transformhelper.setLocalPosXY(self._transselectedrd, (sizeX - 0.5) * uiGridSize, -halfUIGridSize)
		end

		local animName

		if self._selectedEntityType ~= newSelectedEntityType or self._selectedUid ~= newSelectedUid then
			if newSelectedEntityType and newSelectedUid then
				animName = UIAnimationName.Open
				self._selectedCanvasGroup.alpha = 0
			else
				animName = UIAnimationName.Close
			end
		end

		if animName then
			self._selectedAnimator:Play(animName, 0, 0)
		end

		self._selectedFrameTweenMoving = entity and entity:isTweenMoving()
		self._selectedEntityType = newSelectedEntityType
		self._selectedUid = newSelectedUid

		self:refreshSelectedFrame()
	end
end

function ArcadeGameView:refreshSelectedFrame()
	if not self._selectedEntityType or not self._selectedUid then
		return
	end

	local scene = ArcadeGameController.instance:getGameScene()

	if scene then
		::label_93_0::

		local entity = scene.entityMgr:getEntityWithType(self._selectedEntityType, self._selectedUid)

		if entity then
			local x, y, z = entity:getPosition()
			local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(x, y, z, self._transgame)

			recthelper.setAnchor(self._transselectedframe, rectPosX, rectPosY)
		end
	end
end

function ArcadeGameView:playEffectFlying(starPosX, starPosY, endPosV2)
	local flyEffectItem = self:getFlyEffectItem()

	gohelper.setActive(flyEffectItem.go, true)
	flyEffectItem.comp:SetOneFlyItemDoneCallback(self.onFlyDone, self)
	flyEffectItem.comp:SetOneFlyItemDoneAndRecycleDoneCallback(self.onFlyRecycle, self, flyEffectItem)

	flyEffectItem.comp.startPosition = Vector2(starPosX, starPosY)
	flyEffectItem.comp.endPosition = endPosV2

	gohelper.setActive(flyEffectItem.compGO, true)
	flyEffectItem.comp:StartFlying()
end

function ArcadeGameView:getFlyEffectItem()
	for i = 1, #self.flyEffectItemList do
		if not self.flyEffectItemList[i].isActive then
			self.flyEffectItemList[i].isActive = true

			return self.flyEffectItemList[i]
		end
	end

	self:createFlyEffect()

	return self.flyEffectItemList[#self.flyEffectItemList]
end

function ArcadeGameView:createFlyEffect()
	local flyEffectItem = {}

	flyEffectItem.go = gohelper.clone(self._goFlyItem, self._goFlyItemContent)
	flyEffectItem.compGO = gohelper.findChild(flyEffectItem.go, "#fly")
	flyEffectItem.comp = flyEffectItem.compGO:GetComponent(typeof(UnityEngine.UI.UIFlying))
	flyEffectItem.flyGO = gohelper.findChild(flyEffectItem.go, "fly_item")
	flyEffectItem.isActive = false

	flyEffectItem.comp:SetFlyItemObj(flyEffectItem.flyGO)
	table.insert(self.flyEffectItemList, flyEffectItem)
end

function ArcadeGameView:recycleFlyEffectItem(flyEffectItem)
	flyEffectItem.isActive = false

	gohelper.setActive(flyEffectItem.go, false)
	gohelper.setActive(flyEffectItem.compGO, false)
end

function ArcadeGameView:recycleAllFlyEffectItem()
	for i = 1, #self.flyEffectItemList do
		self.flyEffectItemList[i].isActive = false

		gohelper.setActive(self.flyEffectItemList[i].compGO, false)
		gohelper.setActive(self.flyEffectItemList[i].go, false)
	end
end

function ArcadeGameView:onFlyDone()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_item_get)
end

function ArcadeGameView:onFlyRecycle(flyEffectItem)
	self:recycleFlyEffectItem(flyEffectItem)
end

function ArcadeGameView:onClose()
	self._newCollectionList = nil
	self._fightFloatDataDict = nil

	self:killScoreProgressTween()
	self:killSkillEnergyTween()
	TaskDispatcher.cancelTask(self._playExcessiveOverTime, self)
	TaskDispatcher.cancelTask(self.refreshWeapon, self)
	TaskDispatcher.cancelTask(self.setCollections, self)
	TaskDispatcher.cancelTask(self.closeDangerWarning, self)
	self:recycleAllFlyEffectItem()

	if self._isRunning then
		self._isRunning = false

		LateUpdateBeat:Remove(self._onLateUpdate, self)
	end

	self._selectedFrameTweenMoving = false
	self._showingEventEntityType = nil
	self._showingEventEntityUid = nil

	self:_closeTipView()
end

function ArcadeGameView:_closeTipView()
	ArcadeController.instance:closeTipView()
	self:changeSelectedFrame(self._showingEventEntityType, self._showingEventEntityUid)
end

function ArcadeGameView:_clearWeaponItems()
	if self._weaponItemList then
		for _, weaponItem in ipairs(self._weaponItemList) do
			weaponItem.uid = nil

			weaponItem.simageIcon:UnLoadImage()
			weaponItem.btn:RemoveClickListener()
		end
	end

	self._weaponItemList = {}
end

function ArcadeGameView:_clearCollectionItems()
	if self._collectionItemDict then
		for _, collectionItem in pairs(self._collectionItemDict) do
			collectionItem.simageIcon:UnLoadImage()
		end
	end

	self._collectionItemDict = {}
end

function ArcadeGameView:_clearOptionItemList()
	if self._optionItemList then
		for _, optionItem in ipairs(self._optionItemList) do
			optionItem.btnOption:RemoveClickListener()
			optionItem.btnBuy:RemoveClickListener()
		end
	end

	self._optionItemList = {}
end

function ArcadeGameView:onDestroyView()
	self._simageheroicon:UnLoadImage()
	self._simageeventicon:UnLoadImage()
	self._simagedangericon:UnLoadImage()
	self:_clearWeaponItems()
	self:_clearCollectionItems()
	self:_clearOptionItemList()
	ArcadeGameController.instance:exitGame()
end

return ArcadeGameView
