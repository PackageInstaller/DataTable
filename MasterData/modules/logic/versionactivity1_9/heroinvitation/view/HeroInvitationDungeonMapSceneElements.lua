-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/view/HeroInvitationDungeonMapSceneElements.lua

module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapSceneElements", package.seeall)

local HeroInvitationDungeonMapSceneElements = class("HeroInvitationDungeonMapSceneElements", DungeonMapSceneElements)

function HeroInvitationDungeonMapSceneElements:onInitView()
	HeroInvitationDungeonMapSceneElements.super.onInitView(self)

	self.goItem = gohelper.findChild(self.viewGO, "#go_arrow/#go_item")
	self.allFinish = HeroInvitationModel.instance:isAllFinish()
end

function HeroInvitationDungeonMapSceneElements:addEvents()
	HeroInvitationDungeonMapSceneElements.super.addEvents(self)
	self.addEventCb(self, HeroInvitationController.instance, HeroInvitationEvent.StateChange, self.updateState, self)
	self.addEventCb(self, HeroInvitationController.instance, HeroInvitationEvent.UpdateInfo, self.updateHeroInvitation, self)
end

function HeroInvitationDungeonMapSceneElements:updateState()
	if self._mapCfg then
		self:_showElements(self._mapCfg.id)
	end
end

function HeroInvitationDungeonMapSceneElements:updateHeroInvitation()
	local allFinish = HeroInvitationModel.instance:isAllFinish()

	if allFinish == self.allFinish then
		return
	end

	if self._mapCfg then
		self:_showElements(self._mapCfg.id)
	end
end

function HeroInvitationDungeonMapSceneElements:_addElement(elementConfig)
	local elementId = elementConfig.id
	local elementComp = self._elementList[elementId]
	local create = false

	if not elementComp then
		local go = UnityEngine.GameObject.New(tostring(elementId))

		gohelper.addChild(self._elementRoot, go)

		elementComp = MonoHelper.addLuaComOnceToGo(go, HeroInvitationDungeonMapElement, {
			elementConfig,
			self._mapScene,
			self
		})
		self._elementList[elementId] = elementComp
		create = true
	end

	if elementComp:showArrow() then
		self:createArrowItem(elementId)
		self:_updateArrow(elementComp)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnElementAdd, elementId)

	if self._inRemoveElementId == elementId then
		elementComp:setWenHaoGoVisible(true)
		self:_removeElement(elementId)
	else
		local isFinish = DungeonMapModel.instance:elementIsFinished(elementId)

		elementComp:setWenHaoGoVisible(self.allFinish or not isFinish)

		if not create and self.allFinish then
			elementComp:setWenHaoAnim(DungeonMapElement.InAnimName)
		end
	end
end

function HeroInvitationDungeonMapSceneElements:_getElements(mapId)
	local list = DungeonConfig.instance:getMapElements(mapId)

	self.allFinish = HeroInvitationModel.instance:isAllFinish()

	local elements = {}

	if list then
		for i, v in ipairs(list) do
			local state = HeroInvitationModel.instance:getInvitationStateByElementId(v.id)

			if state ~= HeroInvitationEnum.InvitationState.TimeLocked and state ~= HeroInvitationEnum.InvitationState.ElementLocked and (self.allFinish or DungeonMapModel.instance:getElementById(v.id) or DungeonMapModel.instance:elementIsFinished(v.id)) then
				table.insert(elements, v)
			end
		end
	end

	return elements
end

function HeroInvitationDungeonMapSceneElements:_removeElement(id)
	local elementComp = self._elementList[id]

	if not elementComp then
		self._inRemoveElementId = id

		return
	end

	DungeonMapModel.instance.directFocusElement = true

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, id)

	DungeonMapModel.instance.directFocusElement = false
	self._inRemoveElementId = nil
	self._inRemoveElement = true

	if elementComp then
		elementComp:setFinishAndDotDestroy()
	end

	local arrowItem = self._arrowList[id]

	if arrowItem then
		self:destoryArrowItem(arrowItem)

		self._arrowList[id] = nil
	end
end

function HeroInvitationDungeonMapSceneElements:onRemoveElementFinish()
	self._inRemoveElement = false

	if self._mapCfg then
		self:_showElements(self._mapCfg.id)
	end
end

function HeroInvitationDungeonMapSceneElements:_showElements(mapId)
	if self._inRemoveElement then
		return
	end

	if gohelper.isNil(self._sceneGo) or self._lockShowElementAnim then
		return
	end

	if self._inRemoveElementId then
		local elementsList = self:_getElements(mapId)
		local animElements = {}
		local normalElements = {}

		for i, config in ipairs(elementsList) do
			if config.id <= self._inRemoveElementId then
				if config.showCamera == 1 and not self._skipShowElementAnim and self._forceShowElementAnim then
					table.insert(animElements, config.id)
				else
					table.insert(normalElements, config)
				end
			end
		end

		self:_showElementAnim(animElements, normalElements)
	else
		local elementsList = self:_getElements(mapId)
		local newElements = DungeonMapModel.instance:getNewElements()
		local animElements = {}
		local normalElements = {}

		for i, config in ipairs(elementsList) do
			if config.showCamera == 1 and not self._skipShowElementAnim and (newElements and tabletool.indexOf(newElements, config.id) or self._forceShowElementAnim) then
				table.insert(animElements, config.id)
			else
				table.insert(normalElements, config)
			end
		end

		self:_showElementAnim(animElements, normalElements)
		DungeonMapModel.instance:clearNewElements()
	end
end

function HeroInvitationDungeonMapSceneElements:clickElement(id)
	if self:_isShowElementAnim() then
		return
	end

	local mapElement = self._elementList[tonumber(id)]

	if not mapElement then
		return
	end

	local config = mapElement._config

	self:_focusElementById(config.id)

	local invitationConfig = HeroInvitationConfig.instance:getInvitationConfigByElementId(config.id)

	if DungeonMapModel.instance:elementIsFinished(config.id) then
		local storyId = invitationConfig.restoryId
		local param = {}

		param.blur = true
		param.hideStartAndEndDark = true

		StoryController.instance:playStory(storyId, param)
	else
		local storyId = invitationConfig.storyId
		local param = {}

		param.blur = true
		param.hideStartAndEndDark = true

		StoryController.instance:playStory(storyId, param, function()
			DungeonRpc.instance:sendMapElementRequest(config.id)
		end)
	end
end

function HeroInvitationDungeonMapSceneElements:hideMapHeroIcon()
	for k, v in pairs(self._arrowList) do
		self:destoryArrowItem(v)
	end

	self._arrowList = self:getUserDataTb_()
end

function HeroInvitationDungeonMapSceneElements:createArrowItem(elementId)
	if self._arrowList[elementId] then
		return self._arrowList[elementId]
	end

	local item = self:getUserDataTb_()

	item.elementId = elementId
	item.go = gohelper.cloneInPlace(self.goItem, tostring(elementId))

	gohelper.setActive(item.go, false)

	item.arrowGO = gohelper.findChild(item.go, "arrow")
	item.rotationTrans = item.arrowGO.transform
	item.goHeroIcon = gohelper.findChild(item.go, "heroicon")
	item.heroHeadImage = gohelper.findChildSingleImage(item.go, "heroicon/#simage_herohead")
	item.click = gohelper.getClickWithDefaultAudio(item.heroHeadImage.gameObject)

	item.click:AddClickListener(self.onClickHeroHeadIcon, self, item)

	local rx, ry, rz = transformhelper.getLocalRotation(item.rotationTrans)

	item.initRotation = {
		rx,
		ry,
		rz
	}
	self._arrowList[elementId] = item

	local config = HeroInvitationConfig.instance:getInvitationConfigByElementId(elementId)

	item.heroHeadImage:LoadImage(ResUrl.getHeadIconSmall(config.head))

	return item
end

function HeroInvitationDungeonMapSceneElements:destoryArrowItem(item)
	if not item then
		return
	end

	item.click:RemoveClickListener()
	item.heroHeadImage:UnLoadImage()
	gohelper.destroy(item.go)
end

function HeroInvitationDungeonMapSceneElements:onClickHeroHeadIcon(item)
	local elementId = item.elementId

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, elementId)
end

function HeroInvitationDungeonMapSceneElements:_updateArrow(elementComp)
	if not elementComp:showArrow() then
		return
	end

	local t = elementComp._transform
	local camera = CameraMgr.instance:getMainCamera()
	local pos = camera:WorldToViewportPoint(t.position)
	local x = pos.x
	local y = pos.y
	local isFinish = DungeonMapModel.instance:elementIsFinished(elementComp:getElementId())
	local isShow = x >= 0 and x <= 1 and y >= 0 and y <= 1
	local arrowItem = self._arrowList[elementComp:getElementId()]

	if not arrowItem then
		return
	end

	gohelper.setActive(arrowItem.go, not isFinish and not isShow)

	if isShow or isFinish then
		return
	end

	local viewportX = math.max(0.05, math.min(x, 0.95))
	local viewportY = math.max(0.1, math.min(y, 0.9))

	if viewportY > 0.85 and viewportX < 0.15 then
		viewportY = 0.85
	end

	local width = recthelper.getWidth(self._goarrow.transform)
	local height = recthelper.getHeight(self._goarrow.transform)

	recthelper.setAnchor(arrowItem.go.transform, width * (viewportX - 0.5), height * (viewportY - 0.5))

	local initRotation = arrowItem.initRotation

	if x >= 0 and x <= 1 then
		if y < 0 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 180)

			return
		elseif y > 1 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 0)

			return
		end
	end

	if y >= 0 and y <= 1 then
		if x < 0 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 90)

			return
		elseif x > 1 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 270)

			return
		end
	end

	local angle = Mathf.Deg(Mathf.Atan2(y, x)) - 90

	transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], angle)
end

function HeroInvitationDungeonMapSceneElements:_disposeOldMap()
	for k, v in pairs(self._elementList) do
		v:onDestroy()
	end

	self._elementList = self:getUserDataTb_()

	self:hideMapHeroIcon()
	self:_stopShowSequence()
end

return HeroInvitationDungeonMapSceneElements
