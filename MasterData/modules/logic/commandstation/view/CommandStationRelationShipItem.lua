-- chunkname: @modules/logic/commandstation/view/CommandStationRelationShipItem.lua

module("modules.logic.commandstation.view.CommandStationRelationShipItem", package.seeall)

local CommandStationRelationShipItem = class("CommandStationRelationShipItem", ListScrollCellExtend)

function CommandStationRelationShipItem:onInitView()
	self._gocharacter = gohelper.findChild(self.viewGO, "#go_character")
	self._godead = gohelper.findChild(self.viewGO, "#go_character/#go_dead")
	self._goselect = gohelper.findChild(self.viewGO, "#go_character/#go_select")
	self._gonew = gohelper.findChild(self.viewGO, "#go_character/#go_new")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_character/#go_reddot")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_character/#txt_Name")
	self._btnclickcharacter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_character/#btn_click_character")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationRelationShipItem:addEvents()
	if self._btnclickcharacter then
		self._btnclickcharacter:AddClickListener(self._btnclickcharacterOnClick, self)
	end
end

function CommandStationRelationShipItem:removeEvents()
	if self._btnclickcharacter then
		self._btnclickcharacter:RemoveClickListener()
	end
end

function CommandStationRelationShipItem:_btnclickcharacterOnClick()
	if self._noClick then
		return
	end

	if self._showReddot then
		CommandStationModel.instance:updateCharacterState(self._stateId)
		CommandStationRpc.instance:sendCommandPostCharacterReadRequest(self._stateId)
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.ClickRelationShipBoardCharacter, {
		stateId = self._stateId,
		characterId = self._characterId,
		descList = self._chaTxt
	})
end

function CommandStationRelationShipItem:_editableInitView()
	self._singleImage = gohelper.findChildSingleImage(self.viewGO, "#go_character/image_head")
	self._deadEffect = self._singleImage:GetComponent(typeof(Coffee.UIEffects.BaseMaterialEffect))

	gohelper.setActive(self._goreddot, false)

	if not self._btnclickcharacter then
		logError("btnclickcharacter is nil", self.viewGO.name)
	end
end

function CommandStationRelationShipItem:_editableAddEvents()
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.UpdateCharacterState, self._onUpdateCharacterState, self)
end

function CommandStationRelationShipItem:_editableRemoveEvents()
	return
end

function CommandStationRelationShipItem:_onUpdateCharacterState(stateId)
	if stateId == self._stateId then
		self:_updateReddot()
	end
end

function CommandStationRelationShipItem:onUpdateMO(stateId, characterId, state, chaTxt, inMainBoard)
	self._stateId = stateId
	self._stateConfig = lua_copost_character_state.configDict[stateId]
	self._characterId = characterId
	self._state = state
	self._chaTxt = chaTxt
	self._inMainBoard = inMainBoard
	self._noClick = self._stateConfig.isClick == CommandStationEnum.CharacterClickState.NoClick

	self:_changeCharacterView()

	self._isDead = state == CommandStationEnum.ChainState.Dead

	gohelper.setActive(self._godead, self._isDead)

	if self._deadEffect then
		self._deadEffect.enabled = self._isDead
	end

	local chaConfig = lua_copost_character.configDict[characterId]

	if chaConfig then
		if self._txtName then
			self._txtName.text = chaConfig.chaName
		end
	else
		logError("CommandStationRelationShipItem can not find characterId:" .. characterId)
	end

	self:_updateReddot()
	self:_updateHeadIcon()
end

function CommandStationRelationShipItem:_changeCharacterView()
	if not self._inMainBoard or not self._stateConfig.chaChange[1] then
		return
	end

	gohelper.setActive(self._gocharacter, false)
	self._btnclickcharacter:RemoveClickListener()

	local goName = "#go_character" .. self._stateConfig.chaChange[1]

	self._gocharacter = gohelper.findChild(self.viewGO, goName)
	self._godead = gohelper.findChild(self.viewGO, goName .. "/#go_dead")
	self._goselect = gohelper.findChild(self.viewGO, goName .. "/#go_select")
	self._gonew = gohelper.findChild(self.viewGO, goName .. "/#go_new")
	self._goreddot = gohelper.findChild(self.viewGO, goName .. "/#go_reddot")
	self._txtName = gohelper.findChildText(self.viewGO, goName .. "/#txt_Name")
	self._btnclickcharacter = gohelper.findChildButtonWithAudio(self.viewGO, goName .. "/#btn_click_character")

	gohelper.setActive(self._gocharacter, true)

	if not self._btnclickcharacter then
		logError("CommandStationRelationShipItem:_changeCharacterView", "btnclickcharacter is nil", self._stateConfig.stateId, self._stateConfig.positionId, goName)

		return
	end

	self._btnclickcharacter:AddClickListener(self._btnclickcharacterOnClick, self)
end

function CommandStationRelationShipItem:getAnimator()
	return self._gocharacter and self._gocharacter:GetComponent("Animator")
end

function CommandStationRelationShipItem:_updateHeadIcon()
	if self._inMainBoard then
		return
	end

	if not self._stateConfig.chaChange[2] then
		local showCharacterId = self._characterId
		local showChaConfig = lua_copost_character.configDict[showCharacterId]

		if not showChaConfig then
			logError("CommandStationRelationShipItem can not find showCharacterId:" .. showCharacterId)

			return
		end

		self._singleImage:LoadImage(ResUrl.getHeadIconSmall(showChaConfig.chaPicture), self._singleImageLoadCallback, self)
	end
end

function CommandStationRelationShipItem:_updateReddot()
	local firstShowStateId = CommandStationConfig.instance:getCharacterFirstShowState(self._stateId, self._characterId)
	local isFirstShow = firstShowStateId == self._stateId

	self._showReddot = not self._noClick and not CommandStationModel.instance:getCharacterState(self._stateId)

	gohelper.setActive(self._goreddot, self._showReddot and not isFirstShow)
	gohelper.setActive(self._gonew, self._showReddot and isFirstShow)
end

function CommandStationRelationShipItem:_singleImageLoadCallback()
	self._singleImage:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function CommandStationRelationShipItem:updateRelationDesc(relationshipId, relationshipType)
	local config = lua_copost_event_text.configDict[relationshipId]

	if not config then
		logError(string.format("CommandStationRelationShipItem config is nil relationshipId:%s", tostring(relationshipId)))

		return
	end

	local go = gohelper.findChild(self.viewGO, "#go_character/image_Relationship")
	local showTxt = relationshipId ~= 100

	gohelper.setActive(go, showTxt)

	if not showTxt then
		return
	end

	local txt = gohelper.findChildText(self.viewGO, "#go_character/image_Relationship/#txt_Relationship")

	txt.text = config.text

	local color = CommandStationEnum.CharacterRelationColor[relationshipType]
	local star = gohelper.findChildImage(self.viewGO, "#go_character/image_Relationship/#image_Star")

	if color and star then
		star.color = color
	end
end

function CommandStationRelationShipItem:showSelected(value)
	gohelper.setActive(self._goselect, value)
end

function CommandStationRelationShipItem:onDestroyView()
	return
end

return CommandStationRelationShipItem
