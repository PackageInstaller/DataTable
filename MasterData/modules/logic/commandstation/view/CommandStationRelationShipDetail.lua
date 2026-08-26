-- chunkname: @modules/logic/commandstation/view/CommandStationRelationShipDetail.lua

module("modules.logic.commandstation.view.CommandStationRelationShipDetail", package.seeall)

local CommandStationRelationShipDetail = class("CommandStationRelationShipDetail", BaseView)

function CommandStationRelationShipDetail:onInitView()
	self._goteamstorypanel = gohelper.findChild(self.viewGO, "#go_teamstorypanel")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_teamstorypanel/head/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_teamstorypanel/#txt_name")
	self._txtteamname = gohelper.findChildText(self.viewGO, "#go_teamstorypanel/#txt_teamname")
	self._txtDescr1 = gohelper.findChildText(self.viewGO, "#go_teamstorypanel/Scroll View/Viewport/content/#txt_Descr1")
	self._txtDescr2 = gohelper.findChildText(self.viewGO, "#go_teamstorypanel/Scroll View/Viewport/content/#txt_Descr2")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationRelationShipDetail:addEvents()
	return
end

function CommandStationRelationShipDetail:removeEvents()
	return
end

function CommandStationRelationShipDetail:_editableInitView()
	gohelper.setActive(self._txtDescr1, false)
	gohelper.setActive(self._txtDescr2, false)

	self._gridlayout = gohelper.findChild(self.viewGO, "Board")
	self._rootAnimator = self.viewGO:GetComponent("Animator")
	self._panelAnimator = self._goteamstorypanel:GetComponent("Animator")
	self._txtGoList = self:getUserDataTb_()
	self._scroll = gohelper.findChildScrollRect(self.viewGO, "#go_teamstorypanel/Scroll View")
end

function CommandStationRelationShipDetail:_initGos()
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
		elseif name == "sp_char" then
			self._spChar = child
			self._spCharIcon = gohelper.findChildSingleImage(child.gameObject, "#go_character/image_head")

			gohelper.setActive(self._spChar, false)
		else
			logError("child name is not match pattern:", name)
		end
	end
end

function CommandStationRelationShipDetail:_getLineKey(id1, id2)
	local minId = math.min(id1, id2)
	local maxId = math.max(id1, id2)

	return string.format("%d_%d", minId, maxId)
end

function CommandStationRelationShipDetail:_addLineGo(child, id1, id2)
	local key = self:_getLineKey(id1, id2)

	if not self._lineGoMap[key] then
		table.insert(self._lineGoMap[key], child:GetComponent(gohelper.Type_Image))

		self._lineGoMap[key] = self._lineGoMap[key]

		gohelper.setActive(child, false)
	end
end

function CommandStationRelationShipDetail:_initCharacterGo(child, name)
	local characterId = tonumber(string.sub(name, 11))

	if not characterId then
		logError("characterId is nil name:", name)
	else
		self:_addCharacterGo(child, characterId, true)
	end
end

function CommandStationRelationShipDetail:_addCharacterGo(child, characterId, mainCharacter)
	if not self._characterGoMap[characterId] then
		table.insert(self._characterGoMap[characterId], child)

		self._characterGoMap[characterId] = self._characterGoMap[characterId]

		if mainCharacter then
			self._characterGoMap[characterId].mainCharacter = child
		end

		gohelper.setActive(child, false)
	end
end

function CommandStationRelationShipDetail:_initCharacterChain()
	local config = CommandStationController.getCommandStationRelationChain(self.viewParam.pageIndex)

	if config then
		self._stateList = config.stateId or {}
	end
end

function CommandStationRelationShipDetail:onUpdateParam()
	if self._characterId == self.viewParam.characterId then
		return
	end

	self._rootAnimator.enabled = true

	self._rootAnimator:Play("switch", 0, 0)
	self._panelAnimator:Play("switch", 0, 0)

	local time = 0.167

	TaskDispatcher.runDelay(self._delayShowAll, self, time)
	UIBlockHelper.instance:startBlock("CommandStationRelationShipDetail_showAll", time + 0.8)
end

function CommandStationRelationShipDetail:_delayShowAll()
	self:_showAll()
end

function CommandStationRelationShipDetail:onOpen()
	self:_showAll()
end

function CommandStationRelationShipDetail:_showAll()
	if self._characterId == self.viewParam.characterId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_3.CommandStationMap.play_ui_yuanzheng_zhb_zhanshi)

	self._characterId = self.viewParam.characterId
	self._descList = self.viewParam.descList
	self._stateId = self.viewParam.stateId
	self._stateConfig = lua_copost_character_state.configDict[self._stateId]
	self._characterGoMap = self._characterGoMap or self:getUserDataTb_()
	self._lineGoMap = self._lineGoMap or self:getUserDataTb_()

	tabletool.clear(self._characterGoMap)
	tabletool.clear(self._lineGoMap)
	self:_initGos()

	self._stateList = nil

	self:_initCharacterChain()
	self:_showMainCharacter()
	self:_initStates()
	self:_showSpChar()
end

function CommandStationRelationShipDetail:_showSpChar()
	local showSpChar = self._stateConfig.otherId > 0

	gohelper.setActive(self._spChar, showSpChar)

	if not showSpChar then
		return
	end

	local showCharacterId = self._stateConfig.otherId
	local showChaConfig = lua_copost_character.configDict[showCharacterId]

	if not showChaConfig then
		logError("CommandStationRelationShipDetail can not find showCharacterId:" .. showCharacterId)

		return
	end

	self._spCharIcon:LoadImage(ResUrl.getHeadIconSmall(showChaConfig.chaPicture), self._spCharIconLoadCallback, self)
end

function CommandStationRelationShipDetail:_spCharIconLoadCallback()
	self._spCharIcon:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function CommandStationRelationShipDetail:_initStates()
	local mainCharacterStateConfig

	for i, id in ipairs(self._stateList) do
		local config = lua_copost_character_state.configDict[id]

		if not config then
			logError(string.format("copost_character_state stateId:%d not find config", id))
		elseif config.chaId == self._characterId then
			mainCharacterStateConfig = config

			break
		end
	end

	if not mainCharacterStateConfig then
		logError(string.format("CommandStationRelationShipDetail _initStates mainCharacterId:%d not find config", self._characterId))

		return
	end

	for i, id in ipairs(self._stateList) do
		local config = lua_copost_character_state.configDict[id]

		if not config then
			logError(string.format("copost_character_state stateId:%d not find config", id))
		elseif config.chaId == self._characterId then
			self:_initState(config)
		else
			local posIndex = tabletool.indexOf(mainCharacterStateConfig.relationshipCha, config.chaId)

			if posIndex then
				local characterItem = self:_initCharacterState(config.stateId, tonumber(config.chaId), posIndex, config.state, config.chaTxt)

				characterItem:updateRelationDesc(mainCharacterStateConfig.relationshipTxt[posIndex], mainCharacterStateConfig.relationshipType[posIndex])
			end
		end
	end
end

function CommandStationRelationShipDetail:_initState(config)
	local item = self:_initCharacterState(config.stateId, tonumber(config.chaId), 0, config.state, config.chaTxt)

	item:showSelected(true)

	for i, characterId in ipairs(config.relationshipCha) do
		self:_initChaConnect(0, i, config.relationshipTxt[i], config.relationshipType[i])
	end
end

function CommandStationRelationShipDetail:_initCharacterState(stateId, characterId, posId, state, chaTxt)
	local characterGos = self._characterGoMap[posId]

	if not characterGos then
		logError(string.format("CommandStationRelationShipDetail itemGo is nil characterId:%s,posId:%s", tostring(characterId), tostring(posId)))

		return
	end

	for i, itemGo in ipairs(characterGos) do
		gohelper.setActive(itemGo, true)
	end

	local mainCharacter = characterGos.mainCharacter

	if not mainCharacter then
		logError(string.format("CommandStationRelationShipDetail mainCharacter is nil characterId:%s,posId:%s", tostring(characterId), tostring(posId)))

		return
	end

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(mainCharacter.gameObject, CommandStationRelationShipItem)

	item:onUpdateMO(stateId, characterId, state, chaTxt)

	return item
end

function CommandStationRelationShipDetail:_initChaConnect(pos1, pos2, relationshipId, relationshipType)
	local key = self:_getLineKey(pos1, pos2)
	local lineGos = self._lineGoMap[key]

	if not lineGos then
		logError(string.format("CommandStationRelationShipDetail lineGo is nil pos1:%s,pos2:%s", tostring(pos1), tostring(pos2)))

		return
	end

	local color = CommandStationEnum.CharacterRelationColor[relationshipType]

	if not color then
		logError(string.format("CommandStationRelationShipDetail color is nil relationshipType:%s", tostring(relationshipType)))
	end

	for _, lineImage in ipairs(lineGos) do
		gohelper.setActive(lineImage, true)

		if color then
			lineImage.color = color
		end
	end

	local config = lua_copost_event_text.configDict[relationshipId]

	if not config then
		logError(string.format("CommandStationRelationShipDetail config is nil relationshipId:%s", tostring(relationshipId)))

		return
	end
end

function CommandStationRelationShipDetail:_showMainCharacter()
	local chaConfig = lua_copost_character.configDict[self._characterId]

	self._txtname.text = chaConfig.chaName

	if not self._stateConfig.chaChange[2] then
		local showCharacterId = self._characterId
		local showChaConfig = lua_copost_character.configDict[showCharacterId]

		self._simageicon:LoadImage(ResUrl.getHeadIconSmall(showChaConfig.chaPicture))

		local campConfig = lua_copost_character_camp.configDict[chaConfig.chaCamp]

		self._txtteamname.text = campConfig and campConfig.camp

		self:_initDesc(self._descList)

		self._scroll.verticalNormalizedPosition = 1
	end
end

function CommandStationRelationShipDetail:_initDesc(list)
	for k, v in pairs(self._txtGoList) do
		gohelper.destroy(v)
	end

	tabletool.clear(self._txtGoList)

	local lastStateId = CommandStationConfig.instance:getCharacterLastShowState(self._stateId, self._characterId)
	local showMoreDetailTip = lastStateId > self._stateId
	local num = #list

	if num == 1 then
		if showMoreDetailTip then
			local config = lua_copost_event_text.configDict[list[1]]

			self:_addDesc(self._txtDescr1.gameObject, config.text)
			self:_addDesc(self._txtDescr2.gameObject, luaLang("commandstation_moredetail"))
		else
			local config = lua_copost_event_text.configDict[list[1]]

			self:_addDesc(self._txtDescr2.gameObject, config.text)
		end

		return
	end

	for i, v in ipairs(list) do
		local txtGo = i == num and (showMoreDetailTip and self._txtDescr1.gameObject or self._txtDescr2.gameObject) or self._txtDescr1.gameObject
		local config = lua_copost_event_text.configDict[v]

		self:_addDesc(txtGo, config.text)
	end

	if showMoreDetailTip then
		self:_addDesc(self._txtDescr2.gameObject, luaLang("commandstation_moredetail"))
	end
end

function CommandStationRelationShipDetail:_addDesc(txt, text)
	local go = gohelper.cloneInPlace(txt.gameObject)

	gohelper.setActive(go, true)
	gohelper.setAsLastSibling(go)

	local txt = gohelper.findChildText(go, "")

	txt.text = text

	table.insert(self._txtGoList, go)
end

function CommandStationRelationShipDetail:onClose()
	TaskDispatcher.cancelTask(self._delayShowAll, self)
end

function CommandStationRelationShipDetail:onDestroyView()
	return
end

return CommandStationRelationShipDetail
