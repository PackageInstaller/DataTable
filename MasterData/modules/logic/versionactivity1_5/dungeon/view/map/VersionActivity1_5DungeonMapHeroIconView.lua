-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapHeroIconView.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapHeroIconView", package.seeall)

local VersionActivity1_5DungeonMapHeroIconView = class("VersionActivity1_5DungeonMapHeroIconView", BaseView)

function VersionActivity1_5DungeonMapHeroIconView:onInitView()
	self._gomapdirection = gohelper.findChild(self.viewGO, "#go_mapdirection")
	self._goherorightitem = gohelper.findChild(self.viewGO, "#go_mapdirection/#go_rightitem")
	self._goheroleftitem = gohelper.findChild(self.viewGO, "#go_mapdirection/#go_leftitem")
	self._goherotopitem = gohelper.findChild(self.viewGO, "#go_mapdirection/#go_topitem")
	self._goherobottomitem = gohelper.findChild(self.viewGO, "#go_mapdirection/#go_bottomitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5DungeonMapHeroIconView:addEvents()
	return
end

function VersionActivity1_5DungeonMapHeroIconView:removeEvents()
	return
end

function VersionActivity1_5DungeonMapHeroIconView:_editableInitView()
	self.heroItemDict = {}
	self.dirToFocusElementDict = {
		[VersionActivity1_5DungeonEnum.MapDir.Right] = {},
		[VersionActivity1_5DungeonEnum.MapDir.Left] = {},
		[VersionActivity1_5DungeonEnum.MapDir.Top] = {},
		[VersionActivity1_5DungeonEnum.MapDir.Bottom] = {}
	}
	self.focusElementDataPool = {}

	self:createHeroItem(self._goherorightitem, VersionActivity1_5DungeonEnum.MapDir.Right)
	self:createHeroItem(self._goheroleftitem, VersionActivity1_5DungeonEnum.MapDir.Left)
	self:createHeroItem(self._goherotopitem, VersionActivity1_5DungeonEnum.MapDir.Top)
	self:createHeroItem(self._goherobottomitem, VersionActivity1_5DungeonEnum.MapDir.Bottom)

	self.taskMoList = {}

	for _, taskMo in ipairs(VersionActivity1_5RevivalTaskModel.instance:getTaskMoList()) do
		if not taskMo:isExploreTask() then
			table.insert(self.taskMoList, taskMo)
		end
	end

	self.mapSceneElementsView = self.viewContainer.mapSceneElements
	self.mainCamera = CameraMgr.instance:getMainCamera()
	self._tempVector = Vector3()
	self.loadedElements = false
	self.canShowHeroIcon = true

	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnInitElements, self.onInitElements, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, self.onDisposeScene, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function VersionActivity1_5DungeonMapHeroIconView:onClickElement()
	self:hideMapDir()
end

function VersionActivity1_5DungeonMapHeroIconView:onHideInteractUI()
	self:showMapDir()
end

function VersionActivity1_5DungeonMapHeroIconView:onOpenView(viewName)
	if viewName == ViewName.VersionActivity1_5DungeonMapLevelView then
		self:hideMapDir()
	end
end

function VersionActivity1_5DungeonMapHeroIconView:onCloseView(viewName)
	if viewName == ViewName.VersionActivity1_5DungeonMapLevelView then
		self:showMapDir()
	end
end

function VersionActivity1_5DungeonMapHeroIconView:onDisposeOldMap()
	self.loadedElements = false

	self:hideMapHeroIcon()
end

function VersionActivity1_5DungeonMapHeroIconView:onDisposeScene()
	self.loadedElements = false

	self:hideMapHeroIcon()
end

function VersionActivity1_5DungeonMapHeroIconView:hideMapDir()
	self.canShowHeroIcon = false

	gohelper.setActive(self._gomapdirection, self.canShowHeroIcon)
end

function VersionActivity1_5DungeonMapHeroIconView:showMapDir()
	self.canShowHeroIcon = true

	gohelper.setActive(self._gomapdirection, self.canShowHeroIcon)
	self:refreshHeroIcon()
end

function VersionActivity1_5DungeonMapHeroIconView:hideMapHeroIcon()
	for dir, heroItem in pairs(self.heroItemDict) do
		gohelper.setActive(heroItem.go, false)
	end
end

function VersionActivity1_5DungeonMapHeroIconView:onInitElements()
	if self.activityDungeonMo:isHardMode() then
		self:hideMapHeroIcon()

		return
	end

	self.loadedElements = true

	self:refreshHeroIcon()
end

function VersionActivity1_5DungeonMapHeroIconView:createHeroItem(itemGo, dir)
	local heroItem = self:getUserDataTb_()

	heroItem.go = itemGo

	gohelper.setActive(heroItem.go, false)

	heroItem.goHeroIcon1 = gohelper.findChild(heroItem.go, "heroicon_container/heroicon1")
	heroItem.goHeroIcon2 = gohelper.findChild(heroItem.go, "heroicon_container/heroicon2")
	heroItem.heroHeadImage1 = gohelper.findChildSingleImage(heroItem.go, "heroicon_container/heroicon1/#simage_herohead")
	heroItem.heroHeadImage2 = gohelper.findChildSingleImage(heroItem.go, "heroicon_container/heroicon2/#simage_herohead")
	heroItem.click1 = gohelper.getClickWithDefaultAudio(heroItem.heroHeadImage1.gameObject)
	heroItem.click2 = gohelper.getClickWithDefaultAudio(heroItem.heroHeadImage2.gameObject)

	heroItem.click1:AddClickListener(self.onClickHeroHeadIcon, self, {
		index = 1,
		dir = dir
	})
	heroItem.click2:AddClickListener(self.onClickHeroHeadIcon, self, {
		index = 2,
		dir = dir
	})

	self.heroItemDict[dir] = heroItem

	return heroItem
end

function VersionActivity1_5DungeonMapHeroIconView:onClickHeroHeadIcon(data)
	local elementId = self.dirToFocusElementDict[data.dir][data.index].focusElementId

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.FocusElement, elementId)
end

function VersionActivity1_5DungeonMapHeroIconView:getElementData()
	if #self.focusElementDataPool > 0 then
		return table.remove(self.focusElementDataPool)
	end

	return {}
end

function VersionActivity1_5DungeonMapHeroIconView:onMapPosChanged()
	self:refreshHeroIcon()
end

function VersionActivity1_5DungeonMapHeroIconView:onRemoveElement()
	self:refreshHeroIcon()
end

function VersionActivity1_5DungeonMapHeroIconView:refreshHeroIcon()
	if not self.loadedElements then
		return
	end

	if not self.canShowHeroIcon then
		return
	end

	if self.activityDungeonMo:isHardMode() then
		return
	end

	for _, list in pairs(self.dirToFocusElementDict) do
		for i = 1, #list do
			table.insert(self.focusElementDataPool, table.remove(list))
		end
	end

	for _, taskMo in ipairs(self.taskMoList) do
		local elementId, viewPortPos = self:getTaskMoFirstNotFinishElement(taskMo)

		if elementId then
			local elementData = self:getElementData()

			elementData.focusElementId = elementId
			elementData.heroId = taskMo.config.heroId

			table.insert(self.dirToFocusElementDict[self:getDir(viewPortPos.x, viewPortPos.y)], elementData)
		end
	end

	for dir, elementDataList in pairs(self.dirToFocusElementDict) do
		local isShow = #elementDataList > 0

		gohelper.setActive(self.heroItemDict[dir].go, isShow)

		if isShow then
			gohelper.setActive(self.heroItemDict[dir].goHeroIcon1, false)
			gohelper.setActive(self.heroItemDict[dir].goHeroIcon2, false)

			for index, elementData in ipairs(elementDataList) do
				self:refreshHeroItemPos(dir, index, elementData)
			end
		end
	end
end

function VersionActivity1_5DungeonMapHeroIconView:getTaskMoFirstNotFinishElement(taskMo)
	if not taskMo:isUnlock() then
		return
	end

	if taskMo.gainedReward then
		return
	end

	local subTaskCoList = taskMo:getSubTaskCoList()

	for _, subTaskCo in ipairs(subTaskCoList) do
		local subTaskStatus = VersionActivity1_5RevivalTaskModel.instance:getSubHeroTaskStatus(subTaskCo)

		if subTaskStatus == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal then
			for _, elementId in ipairs(subTaskCo.elementList) do
				if not DungeonMapModel.instance:elementIsFinished(elementId) then
					local elementComp = self.mapSceneElementsView:getElementComp(elementId)

					if elementComp then
						local x, y, z = transformhelper.getPos(elementComp:getTransform())

						self._tempVector:Set(x, y, z)

						local viewPortPos = self.mainCamera:WorldToViewportPoint(self._tempVector)

						y = viewPortPos.y
						x = viewPortPos.x

						if viewPortPos.x < 0 or x > 1 or y < 0 or y > 1 then
							return elementId, viewPortPos
						end
					end
				end
			end
		end
	end
end

function VersionActivity1_5DungeonMapHeroIconView:refreshHeroItemPos(dir, index, elementData)
	if index > 2 then
		return
	end

	local heroItem = self.heroItemDict[dir]

	gohelper.setActive(heroItem.go, true)

	if index == 1 then
		if not heroItem.heroHeadImage1 then
			local simage = heroItem.heroHeadImage2

			if index == 1 then
				if not heroItem.goHeroIcon1 then
					local goHeroIcon = heroItem.goHeroIcon2

					gohelper.setActive(goHeroIcon, true)
					simage:LoadImage(ResUrl.getHeadIconSmall(elementData.heroId .. "01"))
				end
			end
		end
	end
end

function VersionActivity1_5DungeonMapHeroIconView:getDir(x, y)
	if x < 0 then
		return VersionActivity1_5DungeonEnum.MapDir.Left
	elseif x >= 0 and x <= 1 then
		if y < 0 then
			return VersionActivity1_5DungeonEnum.MapDir.Bottom
		else
			return VersionActivity1_5DungeonEnum.MapDir.Top
		end
	else
		return VersionActivity1_5DungeonEnum.MapDir.Right
	end
end

function VersionActivity1_5DungeonMapHeroIconView:onDestroyView()
	for _, heroItem in pairs(self.heroItemDict) do
		heroItem.click1:RemoveClickListener()
		heroItem.click2:RemoveClickListener()
		heroItem.heroHeadImage1:UnLoadImage()
		heroItem.heroHeadImage2:UnLoadImage()
	end
end

return VersionActivity1_5DungeonMapHeroIconView
