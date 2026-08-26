-- chunkname: @modules/logic/room/view/RoomBranchView.lua

module("modules.logic.room.view.RoomBranchView", package.seeall)

local RoomBranchView = class("RoomBranchView", BaseView)

function RoomBranchView:onInitView()
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_next")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._goselectitem = gohelper.findChild(self.viewGO, "#go_select/viewport/content/#go_selectitem")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_content/#simage_bg")
	self._txtinfo = gohelper.findChildText(self.viewGO, "#go_content/#txt_info")
	self._gospine = gohelper.findChild(self.viewGO, "#go_content/#go_spine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBranchView:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, self.OnStoryDialogSelect, self)
end

function RoomBranchView:removeEvents()
	self._btnnext:RemoveClickListener()
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, self.OnStoryDialogSelect, self)
end

function RoomBranchView:_btnnextOnClick()
	RoomCharacterController.instance:trynextDialogInteraction()
end

function RoomBranchView:_btnclickOnClick(index)
	RoomCharacterController.instance:nextDialogInteraction(index)
end

function RoomBranchView:OnStoryDialogSelect(selectIndex)
	if selectIndex > 0 and selectIndex <= #self._selectItemList then
		RoomCharacterController.instance:nextDialogInteraction(selectIndex)
	end
end

function RoomBranchView:_editableInitView()
	self._scene = RoomCameraController.instance:getRoomScene()
	self._gocontentTrs = self._gocontent.transform
	self._gospineTrs = self._gospine.transform

	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	gohelper.setActive(self._goselectitem, false)

	self._selectItemList = {}
end

function RoomBranchView:_refreshUI()
	local playingInteractionParam = RoomCharacterController.instance:getPlayingInteractionParam()

	if not playingInteractionParam then
		return
	end

	self._selectParam = playingInteractionParam.selectParam
	self._dialogId = playingInteractionParam.dialogId
	self._stepId = playingInteractionParam.stepId
	self._critterUid = playingInteractionParam.critterUid
	self._heroId = playingInteractionParam.heroId
	self._critterMO = CritterModel.instance:getCritterMOByUid(self._critterUid)

	if self._critterMO then
		self:_addPostionEventCb()

		if not self._critterItem then
			self._critterItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gospine, RoomCritterTrainCritterItem, self)

			self._critterItem:init(self._gospine)
		end
	else
		self:_removePostionEventCb()
	end

	gohelper.setActive(self._gospine, self._critterMO ~= nil)
	gohelper.setActive(self._goselect, self._selectParam)
	gohelper.setActive(self._gocontent, (false or nil) and true)

	if self._selectParam then
		self:_refreshSelect()
	elseif self._dialogId and self._stepId then
		self:_refreshDialog()
	end
end

function RoomBranchView:_refreshSelect()
	for i = 1, #self._selectParam do
		local param = self._selectParam[i]
		local selectId = param[1]
		local selectItem = self._selectItemList[i]

		if not selectItem then
			selectItem = self:getUserDataTb_()
			selectItem.index = i
			selectItem.go = gohelper.cloneInPlace(self._goselectitem, "item" .. i)
			selectItem.txtcontent = gohelper.findChildText(selectItem.go, "bgdark/txtcontentdark")
			selectItem.btnclick = gohelper.findChildButtonWithAudio(selectItem.go, "btnselect")

			selectItem.btnclick:AddClickListener(self._btnclickOnClick, self, selectItem.index)

			local pctipsgo = gohelper.findChild(selectItem.go, "bgdark/#go_pcbtn")

			PCInputController.instance:showkeyTips(pctipsgo, nil, nil, i)
			table.insert(self._selectItemList, selectItem)
		end

		local selectConfig = RoomConfig.instance:getCharacterDialogSelectConfig(selectId)

		selectItem.txtcontent.text = selectConfig.content

		gohelper.setActive(selectItem.go, true)
	end

	for i = #self._selectParam + 1, #self._selectItemList do
		local selectItem = self._selectItemList[i]

		gohelper.setActive(selectItem.go, false)
	end
end

function RoomBranchView:_refreshDialog()
	local dialogConfig = RoomConfig.instance:getCharacterDialogConfig(self._dialogId, self._stepId)

	if dialogConfig then
		local content = dialogConfig.relateContent

		if string.nilorempty(dialogConfig.relateContent) then
			content = dialogConfig.content
		end

		local speaker = self:_getSpeakerName(dialogConfig)

		if not string.nilorempty(speaker) then
			content = string.format("%s:  %s", speaker, content)
		end

		self._txtinfo.text = content

		if self._critterMO and self._critterItem then
			self:_refreshCritterItem(dialogConfig.critteremoji)
		end
	end
end

function RoomBranchView:_refreshCritterItem(eojiId)
	if not self._critterMO or not self._critterItem then
		return
	end

	if eojiId and eojiId ~= 0 then
		self._critterItem:fadeIn()
		self._critterItem:setEffectByType(eojiId)
		self._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
		self:_refreshPosition()
	else
		self._critterItem:setEffectByType(0)
		self._critterItem:hideEffects()
	end
end

function RoomBranchView:_getSpeakerName(dialogConfig)
	if not string.nilorempty(dialogConfig.speaker) then
		return dialogConfig.speaker
	end

	if self._critterMO then
		if dialogConfig.speakerType == RoomEnum.DialogSpeakerType.Hero then
			local heroCfg = HeroConfig.instance:getHeroCO(self._heroId)

			return heroCfg and heroCfg.name
		elseif dialogConfig.speakerType == RoomEnum.DialogSpeakerType.Critter then
			return self._critterMO:getName()
		end
	end

	return nil
end

function RoomBranchView:_onEscape()
	return
end

function RoomBranchView:onOpen()
	self:_refreshUI()
	NavigateMgr.instance:addEscape(ViewName.RoomBranchView, self._onEscape, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, self._refreshUI, self)
end

function RoomBranchView:_addPostionEventCb()
	if not self._isAddPostionEven then
		self._isAddPostionEven = true

		self.addEventCb(self, RoomCharacterController.instance, RoomEvent.CharacterPositionChanged, self._characterPositionChanged, self)
		self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._refreshPosition, self)
	end
end

function RoomBranchView:_removePostionEventCb()
	if self._isAddPostionEven then
		self._isAddPostionEven = false

		self.removeEventCb(self, RoomCharacterController.instance, RoomEvent.CharacterPositionChanged, self._characterPositionChanged, self)
		self.removeEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._refreshPosition, self)
	end
end

function RoomBranchView:_characterPositionChanged(heroId)
	if self._critterMO and self._critterMO.trainInfo.heroId ~= heroId then
		return
	end

	self:_refreshPosition()
end

function RoomBranchView:_refreshPosition()
	local critterEntity = self:_getCritterEntity()

	if not critterEntity then
		return
	end

	local trs = critterEntity.critterspine:getMountheadGOTrs() or critterEntity.goTrs

	if not trs then
		return
	end

	local px, py, pz = transformhelper.getPos(trs)
	local bendingPos = RoomBendingHelper.worldToBendingSimple(Vector3(px, py, pz))
	local anchorPos = RoomBendingHelper.worldPosToAnchorPos(bendingPos, self._gocontentTrs)

	if anchorPos then
		recthelper.setAnchor(self._gospineTrs, anchorPos.x, anchorPos.y)
	end
end

function RoomBranchView:_getCritterEntity()
	if self._scene.cameraFollow:isFollowing() then
		return self._scene.crittermgr:getCritterEntity(self._critterUid, SceneTag.RoomCharacter)
	end

	return self._scene.crittermgr:getTempCritterEntity()
end

function RoomBranchView:onClose()
	return
end

function RoomBranchView:onDestroyView()
	self._simagebg:UnLoadImage()

	for i, selectItem in ipairs(self._selectItemList) do
		selectItem.btnclick:RemoveClickListener()
	end

	if self._critterItem then
		local item = self._critterItem

		self._critterItem = nil

		item:onDestroy()
	end
end

return RoomBranchView
