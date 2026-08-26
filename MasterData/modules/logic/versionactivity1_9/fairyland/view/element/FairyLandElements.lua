-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/element/FairyLandElements.lua

module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElements", package.seeall)

local FairyLandElements = class("FairyLandElements", BaseView)

function FairyLandElements:onInitView()
	self.goElements = gohelper.findChild(self.viewGO, "main/#go_Root/#go_Elements")
	self.goPool = gohelper.findChild(self.goElements, "pool")
	self.wordRes1 = gohelper.findChild(self.goPool, "word1")
	self.wordRes2 = gohelper.findChild(self.goPool, "word2")
	self.elementDict = {}
	self.textDict = {}
	self.elementTypeDict = {}
	self.templateObjDict = {}
	self.element2ObjName = {
		[FairyLandEnum.ElementType.Circle] = "circle",
		[FairyLandEnum.ElementType.Square] = "square",
		[FairyLandEnum.ElementType.Triangle] = "triangle",
		[FairyLandEnum.ElementType.Rectangle] = "rectangle",
		[FairyLandEnum.ElementType.NPC] = "npc",
		[FairyLandEnum.ElementType.Character] = "character",
		[FairyLandEnum.ElementType.Door] = "door",
		[FairyLandEnum.ElementType.Text] = "text"
	}
	self.element2Cls = {
		[FairyLandEnum.ElementType.Circle] = FairyLandElementShape,
		[FairyLandEnum.ElementType.Square] = FairyLandElementShape,
		[FairyLandEnum.ElementType.Triangle] = FairyLandElementShape,
		[FairyLandEnum.ElementType.Rectangle] = FairyLandElementShape,
		[FairyLandEnum.ElementType.NPC] = FairyLandChessNpc,
		[FairyLandEnum.ElementType.Character] = FairyLandChessSelf,
		[FairyLandEnum.ElementType.Door] = FairyLandElementDoor
	}

	for k, v in pairs(self.element2ObjName) do
		self.templateObjDict[k] = gohelper.findChild(self.goPool, v)
	end

	self.characterId = 0
	self.characterType = 0

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FairyLandElements:addEvents()
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.DialogFinish, self.updateElements, self)
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.UpdateInfo, self.updateElements, self)
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.ElementFinish, self.onElementFinish, self)
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.SceneLoadFinish, self.initElements, self)
end

function FairyLandElements:removeEvents()
	return
end

function FairyLandElements:onOpen()
	return
end

function FairyLandElements:onUpdateParam()
	return
end

function FairyLandElements:initElements()
	self:updateElements()
	FairyLandController.instance:dispatchEvent(FairyLandEvent.ElementLoadFinish)
end

function FairyLandElements:onElementFinish()
	self:updateElements()
end

function FairyLandElements:updateElements()
	local elements = FairyLandConfig.instance:getElements()
	local latestFinishElement = 0

	for i, v in ipairs(elements) do
		local elementId = v.id
		local isFinish = FairyLandModel.instance:isFinishElement(elementId)

		if isFinish then
			if latestFinishElement < elementId then
				latestFinishElement = elementId
			end

			self:removeElement(elementId)
		elseif self.elementDict[elementId] then
			self:updateElement(elementId)
		else
			self:createElement(elementId)
		end
	end

	if self.elementDict[self.characterId] then
		self:updateElement(self.characterId)
	else
		self:createCharacter()
	end

	self:refreshText()

	local latestFinishedPuzzle = FairyLandModel.instance:getLatestFinishedPuzzle()

	FairyLandController.instance:dispatchEvent(FairyLandEvent.GuideLatestElementFinish, latestFinishElement)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.GuideLatestPuzzleFinish, latestFinishedPuzzle)
end

function FairyLandElements:createCharacter()
	local elementType = FairyLandEnum.ConfigType2ElementType[self.characterType]
	local cls = self.element2Cls[elementType]
	local config = {}

	config.pos = FairyLandModel.instance:getStairPos()

	local comp = cls.New(self, config)
	local go = gohelper.clone(self.templateObjDict[elementType], self.goElements, tostring(self.characterId))

	gohelper.setActive(go, true)
	comp:init(go)

	self.elementDict[self.characterId] = comp

	self:addTypeDict(self.characterType, self.characterId)
end

function FairyLandElements:createElement(id)
	local config = FairyLandConfig.instance:getElementConfig(id)

	if not config then
		return
	end

	local elementType = FairyLandEnum.ConfigType2ElementType[config.type]
	local cls = self.element2Cls[elementType]
	local comp = cls.New(self, config)
	local go = gohelper.clone(self.templateObjDict[elementType], self.goElements, tostring(id))

	gohelper.setActive(go, true)
	comp:init(go)

	self.elementDict[id] = comp

	self:addTypeDict(config.type, id)
end

function FairyLandElements:addTypeDict(type, id)
	self.elementTypeDict[type] = self.elementTypeDict[type] or {}

	table.insert(self.elementTypeDict[type], id)
end

function FairyLandElements:updateElement(id)
	if not self.elementDict[id] then
		return
	end

	self.elementDict[id]:refresh()
end

function FairyLandElements:removeElement(id)
	if not self.elementDict[id] then
		return
	end

	self.elementDict[id]:finish()

	self.elementDict[id] = nil
end

function FairyLandElements:getElementByType(type)
	type = type or self.characterType

	local list = self.elementTypeDict[type]
	local id = list and list[#list]

	return id and self.elementDict[id]
end

function FairyLandElements:refreshText()
	local puzzleId = 10
	local puzzleConfig = FairyLandConfig.instance:getFairlyLandPuzzleConfig(puzzleId)
	local dialogId = puzzleConfig.storyTalkId
	local showText = FairyLandModel.instance:isFinishDialog(dialogId)

	if showText then
		local curPos = FairyLandModel.instance:getStairPos()
		local textList = lua_fairyland_text.configList
		local startPos = 35

		for i, v in ipairs(textList) do
			local show = curPos >= v.node

			if show then
				if not self.textDict[v.id] then
					local comp = FairyLandText.New(self, {
						pos = startPos + (v.id - 1) * 1.8,
						config = v
					})
					local go = gohelper.clone(self.templateObjDict[FairyLandEnum.ElementType.Text], self.goElements, string.format("text%s", tostring(v.id)))

					gohelper.setActive(go, true)
					comp:init(go)

					self.textDict[v.id] = comp
				end

				self.textDict[v.id]:show()
			elseif self.textDict[v.id] then
				self.textDict[v.id]:hide()
			end
		end
	else
		for k, v in pairs(self.textDict) do
			v:hide()
		end
	end
end

function FairyLandElements:characterMove()
	if self.elementDict[self.characterId] then
		self.elementDict[self.characterId]:move()
	end
end

function FairyLandElements:isMoveing()
	if self.elementDict[self.characterId] then
		return self.elementDict[self.characterId]:isMoveing()
	end
end

function FairyLandElements:onDestroyView()
	for k, v in pairs(self.elementDict) do
		v:onDestroy()
	end

	for k, v in pairs(self.textDict) do
		v:onDestroy()
	end

	self.elementDict = nil
end

return FairyLandElements
