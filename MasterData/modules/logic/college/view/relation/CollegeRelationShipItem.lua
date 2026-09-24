-- chunkname: @modules/logic/college/view/relation/CollegeRelationShipItem.lua

module("modules.logic.college.view.relation.CollegeRelationShipItem", package.seeall)

local CollegeRelationShipItem = class("CollegeRelationShipItem", ListScrollCellExtend)

function CollegeRelationShipItem:onInitView()
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

function CollegeRelationShipItem:addEvents()
	if self._btnclickcharacter then
		self._btnclickcharacter:AddClickListener(self._btnclickcharacterOnClick, self)
	end

	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateCharacterState, self._onUpdateCharacterState, self)
end

function CollegeRelationShipItem:removeEvents()
	if self._btnclickcharacter then
		self._btnclickcharacter:RemoveClickListener()
	end
end

function CollegeRelationShipItem:_btnclickcharacterOnClick()
	if self._noClick then
		return
	end

	if self._showReddot then
		CollegeRpc.instance:sendCollegeMilestoneReadState(self._stateId)
	end

	CollegeController.instance:dispatchEvent(CollegeEvent.ClickRelationShipBoardCharacter, {
		stateId = self._stateId,
		characterId = self._characterId,
		descList = self._chaTxt
	})
end

function CollegeRelationShipItem:_editableInitView()
	self._singleImage = gohelper.findChildSingleImage(self.viewGO, "#go_character/image_head")
	self._deadEffect = self._singleImage and self._singleImage:GetComponent(typeof(Coffee.UIEffects.BaseMaterialEffect))

	gohelper.setActive(self._goreddot, false)

	if not self._btnclickcharacter then
		logError("CollegeRelationShipItem btnclickcharacter is nil", self.viewGO.name)
	end
end

function CollegeRelationShipItem:onUpdateMO(stateId, characterId, state, chaTxt, inMainBoard)
	self._stateId = stateId
	self._stateConfig = lua_college_character_state.configDict[stateId]
	self._characterId = characterId
	self._state = state
	self._chaTxt = chaTxt
	self._inMainBoard = inMainBoard
	self._noClick = self._stateConfig.isClick == CollegeEnum.CharacterClickState.NoClick

	self:_changeCharacterView()

	local chaConfig = lua_college_character.configDict[characterId]

	if chaConfig then
		if self._txtName then
			self._txtName.text = chaConfig.chaName
		end
	else
		logError("CollegeRelationShipItem can not find characterId:" .. tostring(characterId))
	end

	self:_updateReddot()
	self:_updateHeadIcon()
end

function CollegeRelationShipItem:_changeCharacterView()
	if not self._stateConfig then
		return
	end

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
		logError("CollegeRelationShipItem:_changeCharacterView btnclickcharacter is nil", self._stateConfig.stateId, self._stateConfig.positionId, goName)

		return
	end

	self._btnclickcharacter:AddClickListener(self._btnclickcharacterOnClick, self)
end

function CollegeRelationShipItem:getAnimator()
	return self._gocharacter and self._gocharacter:GetComponent("Animator")
end

function CollegeRelationShipItem:_updateHeadIcon()
	if self._inMainBoard then
		return
	end

	if not self._stateConfig then
		return
	end

	if not self._stateConfig.chaChange[2] then
		local showCharacterId = self._characterId
		local showChaConfig = lua_college_character.configDict[showCharacterId]

		if not showChaConfig then
			logError("CollegeRelationShipItem can not find showCharacterId:" .. tostring(showCharacterId))

			return
		end

		self._singleImage:LoadImage(ResUrl.getCollegeSingleBg(showChaConfig.chaPicture, "headicon_small"), self._singleImageLoadCallback, self)
	end
end

function CollegeRelationShipItem:_onUpdateCharacterState(stateId)
	if self._stateId == stateId then
		self:_updateReddot()
	end
end

function CollegeRelationShipItem:_updateReddot()
	local firstShowStateId = CollegeConfig.instance:getCharacterFirstShowState(self._stateId, self._characterId)
	local isFirstShow = firstShowStateId == self._stateId

	self._showReddot = not self._noClick and not CollegeModel.instance:getCharacterState(self._stateId)

	gohelper.setActive(self._goreddot, self._showReddot and not isFirstShow)
	gohelper.setActive(self._gonew, self._showReddot and isFirstShow)
end

function CollegeRelationShipItem:_singleImageLoadCallback()
	self._singleImage:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function CollegeRelationShipItem:updateRelationDesc(relationshipId, relationshipType)
	local config = lua_college_event_text.configDict[relationshipId]

	if not config then
		logError(string.format("CollegeRelationShipItem config is nil relationshipId:%s", tostring(relationshipId)))

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

	local color = CollegeEnum.CharacterRelationColor[relationshipType]
	local star = gohelper.findChildImage(self.viewGO, "#go_character/image_Relationship/#image_Star")

	if color and star then
		star.color = color
	end
end

function CollegeRelationShipItem:showSelected(value)
	gohelper.setActive(self._goselect, value)
end

function CollegeRelationShipItem:onDestroyView()
	return
end

return CollegeRelationShipItem
