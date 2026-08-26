-- chunkname: @modules/logic/room/view/RoomCharacterPlaceItem.lua

module("modules.logic.room.view.RoomCharacterPlaceItem", package.seeall)

local RoomCharacterPlaceItem = class("RoomCharacterPlaceItem", ListScrollCellExtend)

function RoomCharacterPlaceItem:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "role/heroicon")
	self._gobeplaced = gohelper.findChild(self.viewGO, "placeicon")
	self._goclick = gohelper.findChild(self.viewGO, "go_click")
	self._goselect = gohelper.findChild(self.viewGO, "select")
	self._gotrust = gohelper.findChild(self.viewGO, "trust")
	self._txttrust = gohelper.findChildText(self.viewGO, "trust/txt_trust")
	self._goonbirthdayicon = gohelper.findChild(self.viewGO, "#go_onbirthdayicon")
	self._gorole = gohelper.findChild(self.viewGO, "role")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "role/career")
	self._imagerare = gohelper.findChildImage(self.viewGO, "role/rare")
	self._txtname = gohelper.findChildText(self.viewGO, "role/name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "role/name/nameEn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCharacterPlaceItem:addEvents()
	return
end

function RoomCharacterPlaceItem:removeEvents()
	return
end

function RoomCharacterPlaceItem:_btnclickOnClick()
	if self._scene.camera:isTweening() then
		return
	end

	if self._isDragUI then
		return
	end

	local heroId = self._mo.heroId
	local skinId = self._mo.skinId

	if RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
		RoomCharacterModel.instance:endAllMove()

		local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

		if tempCharacterMO and tempCharacterMO.id == heroId then
			RoomCharacterPlaceListModel.instance:setSelect(self._mo.id)
			self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
				focus = true,
				heroId = heroId
			})

			return
		end

		if self._mo.use then
			RoomCharacterPlaceListModel.instance:setSelect(self._mo.id)

			local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)

			self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
				heroId = heroId
			})
		else
			local function replaceHeroFunction(heroId, skinId, nearPosition)
				local bestParam = RoomCharacterHelper.getRecommendHexPoint(heroId, skinId, nearPosition)

				if not bestParam then
					GameFacade.showToast(ToastEnum.RoomCharacterPlace)

					return
				end

				RoomCharacterPlaceListModel.instance:setSelect(nil)
				RoomCharacterPlaceListModel.instance:setSelect(heroId)
				self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
					heroId = heroId,
					skinId = skinId,
					position = bestParam.position
				})
			end

			local count = RoomCharacterModel.instance:getConfirmCharacterCount()
			local maxCount = RoomCharacterModel.instance:getMaxCharacterCount()

			if tempCharacterMO then
				if maxCount <= count - 1 then
					GameFacade.showToast(ToastEnum.RoomCharacterPlace2)

					return
				end

				local nearPosition = Vector2(tempCharacterMO.currentPosition.x, tempCharacterMO.currentPosition.z)

				if tempCharacterMO.characterState == RoomCharacterEnum.CharacterState.Revert then
					RoomMapController.instance:unUseCharacterRequest(tempCharacterMO.heroId, function()
						replaceHeroFunction(heroId, skinId, nearPosition)
					end)
				else
					replaceHeroFunction(heroId, skinId, nearPosition)
				end

				return
			end

			if maxCount <= count then
				GameFacade.showToast(ToastEnum.RoomCharacterPlace2)

				return
			end

			replaceHeroFunction(heroId, skinId, nil)
		end
	end
end

function RoomCharacterPlaceItem:_onDragBegin(param, pointerEventData)
	self._isDragUI = true
	self._isDragFirstBegin = true

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterListOnDragBeginListener, pointerEventData)
end

function RoomCharacterPlaceItem:_onDrag(param, pointerEventData)
	self._isDragUI = true

	if self._isStartDrag then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, pointerEventData.position)
	elseif pointerEventData.position.y > self._dragStartY and self._isDragFirstBegin then
		local heroId = self._mo.id
		local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()
		local count = RoomCharacterModel.instance:getConfirmCharacterCount()
		local maxCount = RoomCharacterModel.instance:getMaxCharacterCount()

		if not self._mo.use and (not tempCharacterMO or tempCharacterMO.id ~= heroId) and maxCount <= count then
			GameFacade.showToast(ToastEnum.RoomCharacterPlace2)

			self._isDragFirstBegin = false
		else
			self._isStartDrag = true

			self._scene.touch:setUIDragScreenScroll(true)

			local skinId = self._mo.skinId
			local worldPos = RoomBendingHelper.screenToWorld(pointerEventData.position)
			local bestParam = RoomCharacterHelper.getRecommendHexPoint(heroId, skinId, worldPos)

			if bestParam then
				self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
					uidrag = true,
					heroId = heroId,
					skinId = skinId,
					position = bestParam.position
				})
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, pointerEventData.position, heroId)
			else
				GameFacade.showToast(ToastEnum.RoomCharacterPlace)

				self._isDragFirstBegin = false
			end
		end
	end

	if not self._isStartDrag then
		RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterListOnDragListener, pointerEventData)
	end
end

function RoomCharacterPlaceItem:_onDragEnd(param, pointerEventData)
	self._isDragUI = false

	if self._isStartDrag then
		self._isStartDrag = false

		self._scene.touch:setUIDragScreenScroll(false)
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, pointerEventData.position)
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterListOnDragEndListener, pointerEventData)
end

function RoomCharacterPlaceItem:_btnclickOnClickDown()
	self._isDragUI = false
end

function RoomCharacterPlaceItem:_editableInitView()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._isSelect = false

	gohelper.addUIClickAudio(self._goclick, AudioEnum.UI.UI_Common_Click)

	self._canvasGroup = self._gorole:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._uiclick = SLFramework.UGUI.UIClickListener.Get(self._goclick)

	self._uiclick:AddClickListener(self._btnclickOnClick, self)
	self._uiclick:AddClickDownListener(self._btnclickOnClickDown, self)

	self._uidrag = SLFramework.UGUI.UIDragListener.Get(self._goclick)

	self._uidrag:AddDragBeginListener(self._onDragBegin, self)
	self._uidrag:AddDragListener(self._onDrag, self)
	self._uidrag:AddDragEndListener(self._onDragEnd, self)

	self._isStartDrag = false
	self._isDragFirstBegin = false
	self._isDragUI = false
	self._dragStartY = 350 * UnityEngine.Screen.height / 1080
end

function RoomCharacterPlaceItem:_refreshUI()
	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(self._mo.skinConfig.headIcon))
	gohelper.setActive(self._gobeplaced, self._mo.use)

	local isOnBirthday = RoomCharacterModel.instance:isOnBirthday(self._mo.heroConfig.id)

	gohelper.setActive(self._goonbirthdayicon, isOnBirthday)

	self._canvasGroup.alpha = self._mo.use and 0.7 or 1

	gohelper.addUIClickAudio(self._goclick, (self._mo.use or nil) and (AudioEnum.UI.UI_Common_Click or AudioEnum.UI.Play_UI_Copies))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. self._mo.heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. CharacterEnum.Color[self._mo.heroConfig.rare])

	self._txtname.text = self._mo.heroConfig.name
	self._txtnameen.text = self._mo.heroConfig.nameEng

	local order = RoomCharacterPlaceListModel.instance:getOrder()
	local faith = HeroConfig.instance:getFaithPercent(self._mo.heroMO.faith)[1]
	local faithColor = faith ~= 1 and "#cccccc" or "#e59650"

	self._txttrust.text = string.format("<color=%s>%s%%</color>", faithColor, faith * 100)
end

function RoomCharacterPlaceItem:onUpdateMO(mo)
	gohelper.setActive(self._goselect, self._isSelect)

	self._mo = mo

	self:_refreshUI()

	self._uidrag.enabled = RoomCharacterModel.instance:canDragCharacter()
end

function RoomCharacterPlaceItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)

	self._isSelect = isSelect
end

function RoomCharacterPlaceItem:onDestroy()
	self._simageicon:UnLoadImage()
	self._uiclick:RemoveClickListener()
	self._uiclick:RemoveClickDownListener()
	self._uidrag:RemoveDragBeginListener()
	self._uidrag:RemoveDragListener()
	self._uidrag:RemoveDragEndListener()
end

return RoomCharacterPlaceItem
