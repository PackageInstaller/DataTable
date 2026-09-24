-- chunkname: @modules/logic/college/view/relation/CollegeRelationShipBoardPage.lua

module("modules.logic.college.view.relation.CollegeRelationShipBoardPage", package.seeall)

local CollegeRelationShipBoardPage = class("CollegeRelationShipBoardPage", BaseView)

function CollegeRelationShipBoardPage:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeRelationShipBoardPage:addEvents()
	return
end

function CollegeRelationShipBoardPage:removeEvents()
	return
end

function CollegeRelationShipBoardPage:ctor(pageIndex)
	self._pageIndex = pageIndex
end

function CollegeRelationShipBoardPage:_getCampByLocation(location)
	if self._pageIndex == CollegeEnum.RelationShipBoardPage.Default then
		return location
	end

	return CollegeConfig.instance:getCampByLocation(location)
end

function CollegeRelationShipBoardPage:_editableInitView()
	self._gridlayout = gohelper.findChild(self.viewGO, "gridlayout")
	self._animator = self.viewGO:GetComponent("Animator")
end

function CollegeRelationShipBoardPage:onUpdateParam()
	return
end

function CollegeRelationShipBoardPage:onTabSwitchClose()
	self.removeEventCb(self, CollegeController.instance, CollegeEvent.ClickRelationShipBoardCharacter, self._onClickRelationShipBoardCharacter, self)
end

function CollegeRelationShipBoardPage:onTabSwitchOpen()
	self.addEventCb(self, CollegeController.instance, CollegeEvent.ClickRelationShipBoardCharacter, self._onClickRelationShipBoardCharacter, self)
	self._animator:Play("open", 0, 0)
end

function CollegeRelationShipBoardPage:onOpen()
	self._campStatusMap = {}
	self._firstOpenCharacter = self:getUserDataTb_()
	self._firstOpenLine = self:getUserDataTb_()

	self:_initFirstOpenTeam()

	self._characterGoMap = self:getUserDataTb_()
	self._lineGoMap = self:getUserDataTb_()

	self:_initGos()

	self._stateList = nil
	self._stateConnectMap = {}

	self:_initCharacterChain()
	self:_initStates(self._stateList)
end

function CollegeRelationShipBoardPage:onOpenFinish()
	self:_playFirstOpenAnim()
end

function CollegeRelationShipBoardPage:_playFirstOpenAnim()
	self:_playFirstOpenTeamAnim()
	self:_playFirstOpenChaAnim()
	self:_playFirstOpenLineAnim()
end

function CollegeRelationShipBoardPage:_initFirstOpenTeam()
	if not CollegeController.hasOnceActionKey(CollegeEnum.PrefsKey.RelationShipBoardFirstOpenTeam) or self._showAllFirstOpenAnim then
		for i = 1, CollegeEnum.MaxCampLocationIndex do
			local go = gohelper.findChild(self.viewGO, "Team" .. i)

			gohelper.setActive(go, false)
		end
	end
end

function CollegeRelationShipBoardPage:_playFirstOpenTeamAnim()
	if not CollegeController.hasOnceActionKey(CollegeEnum.PrefsKey.RelationShipBoardFirstOpenTeam) or self._showAllFirstOpenAnim then
		CollegeController.setOnceActionKey(CollegeEnum.PrefsKey.RelationShipBoardFirstOpenTeam)

		for i = 1, CollegeEnum.MaxCampLocationIndex do
			local go = gohelper.findChild(self.viewGO, "Team" .. i)

			gohelper.setActive(go, true)

			local animator = go and go:GetComponent("Animator")

			if animator then
				animator:Play("firstopen", 0, 0)
			end
		end
	end
end

function CollegeRelationShipBoardPage:_playFirstOpenChaAnim()
	for posId, animator in pairs(self._firstOpenCharacter) do
		gohelper.setActive(animator, true)
		animator:Play("firstopen", self._onChaOpenFinish, self, posId)
		CollegeController.setOnceActionKey(CollegeEnum.PrefsKey.RelationShipBoardFirstOpenCha, posId)
	end
end

function CollegeRelationShipBoardPage:_onChaOpenFinish(posId)
	local characterGos = self._characterGoMap[posId]

	for i, v in ipairs(characterGos) do
		gohelper.setActive(v, true)
	end
end

function CollegeRelationShipBoardPage:_playFirstOpenLineAnim()
	for line, animatorList in pairs(self._firstOpenLine) do
		CollegeController.setOnceActionKey(CollegeEnum.PrefsKey.RelationShipBoardFirstOpenLine, line)

		for _, animator in pairs(animatorList) do
			gohelper.setActive(animator, true)
			animator:Play("firstopen", 0, 0)
		end
	end
end

function CollegeRelationShipBoardPage:_initGos()
	local transform = self._gridlayout.transform
	local itemCount = transform.childCount
	local linePattern = "^line_(%d+)_(%d+)$"

	for i = 1, itemCount do
		local child = transform:GetChild(i - 1)
		local name = child.name

		if string.find(name, "character_") ~= nil then
			self:_initCharacterGo(child, name)
		elseif string.find(name, "point_") ~= nil then
			local match = child.name:gmatch("%d+")
			local id1, id2 = match(), match()

			id1 = tonumber(id1)
			id2 = tonumber(id2)

			if id1 then
				if id2 then
					self:_addLineGo(child, id1, id2)
				else
					self:_addCharacterGo(child, id1)
				end
			else
				logError("point is not match pattern:", name)
			end
		elseif string.find(name, "line_") ~= nil then
			local id1, id2 = string.match(child.name, linePattern)

			id1 = tonumber(id1)
			id2 = tonumber(id2)

			if id1 and id2 then
				self:_addLineGo(child, id1, id2)
			else
				logError("line is not match pattern:", name)
			end
		elseif name ~= "#go_btngroup" then
			logError("child name is not match pattern:", name)
		end
	end
end

function CollegeRelationShipBoardPage:_getLineKey(id1, id2)
	local minId = math.min(id1, id2)
	local maxId = math.max(id1, id2)

	return string.format("%d_%d", minId, maxId)
end

function CollegeRelationShipBoardPage:_addLineGo(child, id1, id2)
	local key = self:_getLineKey(id1, id2)

	if not self._lineGoMap[key] then
		table.insert(self._lineGoMap[key], child)

		self._lineGoMap[key] = self._lineGoMap[key]

		gohelper.setActive(child, false)
	end
end

function CollegeRelationShipBoardPage:_initCharacterGo(child, name)
	local characterId = tonumber(string.sub(name, 11))

	if not characterId then
		logError("characterId is nil name:", name)
	else
		self:_addCharacterGo(child, characterId, true)
	end
end

function CollegeRelationShipBoardPage:_addCharacterGo(child, characterId, mainCharacter)
	if not self._characterGoMap[characterId] then
		table.insert(self._characterGoMap[characterId], child)

		self._characterGoMap[characterId] = self._characterGoMap[characterId]

		if mainCharacter then
			self._characterGoMap[characterId].mainCharacter = child
		end

		gohelper.setActive(child, false)
	end
end

function CollegeRelationShipBoardPage:_initCharacterChain()
	local config = CollegeController.getCollegeRelationChain(self._pageIndex)

	if config then
		self._stateList = config.stateId or {}
	end
end

function CollegeRelationShipBoardPage:_initStates(stateId)
	if not stateId then
		logError("CollegeRelationShipBoardPage stateId is nil")

		return
	end

	for i, id in ipairs(stateId) do
		local config = lua_college_character_state.configDict[id]

		if not config then
			logError(string.format("college_character_state stateId:%d not find config", id))
		else
			self:_initState(config)
		end
	end
end

function CollegeRelationShipBoardPage:_initState(config)
	self:_initCharacterState(config.stateId, tonumber(config.chaId), config.positionId, config.state, config.chaTxt)

	for i, characterId in ipairs(config.relationshipCha) do
		self:_initChaConnect(config.chaId, characterId, config.relationshipTxt[i], config)
	end
end

function CollegeRelationShipBoardPage:_initCharacterState(stateId, characterId, posId, state, chaTxt)
	local characterGos = self._characterGoMap[posId]

	if not characterGos then
		logError(string.format("CollegeRelationShipBoardPage itemGo is nil characterId:%s,posId:%s", tostring(characterId), tostring(posId)))

		return
	end

	local mainCharacter = characterGos.mainCharacter

	if not mainCharacter then
		logError(string.format("CollegeRelationShipBoardPage mainCharacter is nil characterId:%s,posId:%s", tostring(characterId), tostring(posId)))

		return
	end

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(mainCharacter.gameObject, CollegeRelationShipItem)

	item:onUpdateMO(stateId, characterId, state, chaTxt, true)

	local animator = item:getAnimator()

	if animator and (not CollegeController.hasOnceActionKey(CollegeEnum.PrefsKey.RelationShipBoardFirstOpenCha, posId) or self._showAllFirstOpenAnim) then
		gohelper.setActive(animator, false)

		self._firstOpenCharacter[posId] = ZProj.ProjAnimatorPlayer.Get(animator.gameObject)
	else
		for i, itemGo in ipairs(characterGos) do
			gohelper.setActive(itemGo, true)
		end
	end

	local chaConfig = lua_college_character.configDict[characterId]

	if chaConfig then
		self._campStatusMap[chaConfig.chaCamp] = true
	end
end

function CollegeRelationShipBoardPage:_initChaConnect(characterId1, characterId2, relationshipId, configState)
	characterId1 = tonumber(characterId1)
	characterId2 = tonumber(characterId2)

	local pos1 = CollegeConfig.instance:getCharacterPos(configState.stateId, characterId1)
	local pos2 = CollegeConfig.instance:getCharacterPos(configState.stateId, characterId2)
	local key = self:_getLineKey(pos1, pos2)

	if self._stateConnectMap[key] then
		return
	end

	self._stateConnectMap[key] = true

	local lineGos = self._lineGoMap[key]

	if not lineGos then
		logError(string.format("CollegeRelationShipBoardPage lineGo is nil stateId:%s,characterId1:%s,characterId2:%s, pos1:%s,pos2:%s", configState.stateId, characterId1, characterId2, tostring(pos1), tostring(pos2)))

		return
	end

	local animatorList = {}

	for _, lineGo in ipairs(lineGos) do
		gohelper.setActive(lineGo, true)

		local animator = lineGo:GetComponent("Animator")

		if animator and (not CollegeController.hasOnceActionKey(CollegeEnum.PrefsKey.RelationShipBoardFirstOpenLine, key) or self._showAllFirstOpenAnim) then
			gohelper.setActive(animator, false)
			table.insert(animatorList, animator)
		end
	end

	self._firstOpenLine[key] = animatorList

	local config = lua_college_event_text.configDict[relationshipId]

	if not config then
		logError(string.format("CollegeRelationShipBoardPage stateId:%s, characterId1:%s,characterId2:%s, config is nil relationshipId:%s", configState.stateId, characterId1, characterId2, tostring(relationshipId)))

		return
	end
end

function CollegeRelationShipBoardPage:_onClickRelationShipBoardCharacter(params)
	params.pageIndex = self._pageIndex

	CollegeController.instance:openCollegeRelationShipDetail(params)
end

function CollegeRelationShipBoardPage:onClose()
	return
end

function CollegeRelationShipBoardPage:onDestroyView()
	return
end

return CollegeRelationShipBoardPage
