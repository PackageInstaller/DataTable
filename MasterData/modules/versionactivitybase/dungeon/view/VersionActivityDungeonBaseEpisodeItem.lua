-- chunkname: @modules/versionactivitybase/dungeon/view/VersionActivityDungeonBaseEpisodeItem.lua

module("modules.versionactivitybase.dungeon.view.VersionActivityDungeonBaseEpisodeItem", package.seeall)

local VersionActivityDungeonBaseEpisodeItem = class("VersionActivityDungeonBaseEpisodeItem", BaseChildView)

function VersionActivityDungeonBaseEpisodeItem:onInitView()
	self._goscale = gohelper.findChild(self.viewGO, "#go_scale")
	self._txtsection = gohelper.findChildText(self.viewGO, "#go_scale/section/#txt_section")
	self._gostaricon = gohelper.findChild(self.viewGO, "#go_scale/star/#go_staricon")
	self._txtsectionname = gohelper.findChildText(self.viewGO, "#go_scale/#txt_sectionname")
	self._goflag = gohelper.findChild(self.viewGO, "#go_scale/#go_flag")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	self._gointeractcontent = gohelper.findChild(self.viewGO, "#go_scale/#txt_sectionname/#go_interactContent")
	self._gointeractitem = gohelper.findChild(self.viewGO, "#go_scale/#txt_sectionname/#go_interactContent/#go_interact")
	self._goraycast = gohelper.findChild(self.viewGO, "#go_raycast")
	self._goclickarea = gohelper.findChild(self.viewGO, "#go_clickarea")
	self.goSelected = gohelper.findChild(self.viewGO, "#go_beselected")
	self.txtlocktips = gohelper.findChildText(self.viewGO, "#txt_locktips")
	self.imagesuo = gohelper.findChildImage(self.viewGO, "#txt_locktips/#image_suo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityDungeonBaseEpisodeItem:addEvents()
	return
end

function VersionActivityDungeonBaseEpisodeItem:removeEvents()
	return
end

function VersionActivityDungeonBaseEpisodeItem:onClick()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.VersionActivityDungeonMapLevelView)

	if viewContainer then
		viewContainer:stopCloseViewTask()

		if viewContainer:getOpenedEpisodeId() == self._config.id then
			ViewMgr.instance:closeView(ViewName.VersionActivityDungeonMapLevelView)

			return
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
		episodeId = self._config.id
	})
	self._layout:setFocusEpisodeItem(self, true)
	self._layout:setSelectEpisodeItem(self)
	self.activityDungeonMo:changeEpisode(self:getEpisodeId())
	self._mapSceneView:refreshMap()
	self._layout:updateFocusStatus(self)

	if GamepadController.instance:isOpen() then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, self)
	end
end

function VersionActivityDungeonBaseEpisodeItem:_editableInitView()
	gohelper.setActive(self._gostaricon, false)
	gohelper.setActive(self._goflag, false)
	gohelper.setActive(self._gointeractitem, false)

	self.starItemList = {}
	self.elementItemList = {}

	table.insert(self.starItemList, self:createStarItem(self._gostaricon))

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goClick = gohelper.getClick(self._goclickarea)

	self.goClick:AddClickListener(self.onClick, self)
end

function VersionActivityDungeonBaseEpisodeItem:initViewParam()
	self._contentTransform = self.viewParam[1]
	self._layout = self.viewParam[2]
	self._mapSceneView = self.viewContainer.mapScene
end

function VersionActivityDungeonBaseEpisodeItem:onUpdateParam()
	self:initViewParam()
end

function VersionActivityDungeonBaseEpisodeItem:onOpen()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self.refreshElements, self)
	self:initViewParam()
end

function VersionActivityDungeonBaseEpisodeItem:refresh(config, dungeonMo)
	self._config = config
	self._dungeonMo = dungeonMo
	self._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(self._config)
	self.pass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)

	self:refreshUI()
	self:calculatePosInContent()
	self:playAnimation("selected")

	self.isSelected = false
end

function VersionActivityDungeonBaseEpisodeItem:refreshUI()
	self._txtsection.text = string.format("%02d", self._levelIndex)
	self._txtsectionname.text = self._config.name
	self._txtnameen.text = self._config.name_En

	self:refreshStar()
	self:refreshFlag()
	self:refreshUnlockContent()
	self:refreshFocusStatus()
	self:refreshElements()
end

function VersionActivityDungeonBaseEpisodeItem:refreshStar()
	if self.activityDungeonMo:isHardMode() then
		self:refreshHardModeStar()
	else
		self:refreshStoryModeStar()
	end
end

function VersionActivityDungeonBaseEpisodeItem:refreshFlag()
	gohelper.setActive(self._goflag, not self.pass)
end

function VersionActivityDungeonBaseEpisodeItem:refreshUnlockContent()
	if self.pass then
		gohelper.setActive(self.txtlocktips.gameObject, false)

		return
	end

	local isReactivityEpisode = DungeonModel.instance:isReactivityEpisode(self._config.id)

	if isReactivityEpisode then
		gohelper.setActive(self.txtlocktips, false)

		return
	end

	local openList = OpenConfig.instance:getOpenShowInEpisode(self._config.id)

	if openList and #openList > 0 then
		gohelper.setActive(self.txtlocktips.gameObject, true)

		local unLockContentList = DungeonModel.instance:getUnlockContentList(self._config.id)

		if unLockContentList and #unLockContentList > 0 then
			self.txtlocktips.text = unLockContentList[1] or ""
		end

		UISpriteSetMgr.instance:setUiFBSprite(self.imagesuo, "unlock", true)
	else
		gohelper.setActive(self.txtlocktips.gameObject, false)
	end
end

function VersionActivityDungeonBaseEpisodeItem:refreshHardModeStar()
	self:refreshEpisodeStar(self.starItemList[1], self._config.id, true)

	for i = 2, #self.starItemList do
		gohelper.setActive(self.starItemList[i].goStar, false)
	end
end

function VersionActivityDungeonBaseEpisodeItem:refreshStoryModeStar()
	local starItem

	for index, episodeCo in ipairs(DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(self._config)) do
		starItem = self.starItemList[index]

		if not self.starItemList[index] then
			starItem = self:createStarItem(gohelper.cloneInPlace(self._gostaricon))

			table.insert(self.starItemList, starItem)
		end

		self:refreshEpisodeStar(starItem, episodeCo.id)
	end
end

function VersionActivityDungeonBaseEpisodeItem:refreshEpisodeStar(starItem, episodeId, isHard)
	gohelper.setActive(starItem.goStar, true)

	local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId)
	local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)

	self:setImage(starItem.imgStar1, self.pass and episodeMo and episodeMo.star > DungeonEnum.StarType.None, isHard)

	if string.nilorempty(advancedConditionText) then
		gohelper.setActive(starItem.imgStar2.gameObject, false)
	else
		gohelper.setActive(starItem.imgStar2.gameObject, true)
		self:setImage(starItem.imgStar2, self.pass and episodeMo and episodeMo.star >= DungeonEnum.StarType.Advanced, isHard)
	end
end

function VersionActivityDungeonBaseEpisodeItem:refreshFocusStatus()
	gohelper.setActive(self.goSelected, self._config.id == self.activityDungeonMo.episodeId)
end

function VersionActivityDungeonBaseEpisodeItem:refreshElements()
	if self.activityDungeonMo:isHardMode() then
		gohelper.setActive(self._gointeractcontent, false)

		return
	end

	local mapCfg = DungeonConfig.instance:getChapterMapCfg(self._config.chapterId, self._config.preEpisode)

	if not mapCfg then
		gohelper.setActive(self._gointeractcontent, false)

		return
	end

	local mapAllElementList = DungeonConfig.instance:getMapElements(mapCfg.id)

	if not mapAllElementList or #mapAllElementList < 1 then
		gohelper.setActive(self._gointeractcontent, false)
	else
		gohelper.setActive(self._gointeractcontent, true)

		local notFinishElementCoList = DungeonMapModel.instance:getElements(mapCfg.id)

		if notFinishElementCoList then
			local finishCount = #mapAllElementList - (#notFinishElementCoList or 0)
			local elementItem

			for index, _ in ipairs(mapAllElementList) do
				elementItem = self.elementItemList[index]

				if not self.elementItemList[index] then
					elementItem = self:getUserDataTb_()
					elementItem.go = gohelper.cloneInPlace(self._gointeractitem)
					elementItem.goNotFinish = gohelper.findChild(elementItem.go, "go_notfinish")
					elementItem.goFinish = gohelper.findChild(elementItem.go, "go_finish")

					table.insert(self.elementItemList, elementItem)
				end

				gohelper.setActive(elementItem.go, true)
				gohelper.setActive(elementItem.goNotFinish, not self.pass or finishCount < index)
				gohelper.setActive(elementItem.goFinish, self.pass and index <= finishCount)
			end

			for i = #mapAllElementList + 1, #self.elementItemList do
				gohelper.setActive(self.elementItemList[i].go, false)
			end
		end
	end
end

function VersionActivityDungeonBaseEpisodeItem:calculatePosInContent()
	local nameAnchorX = recthelper.getAnchorX(self._txtsectionname.transform)
	local nameEnAnchorX = recthelper.getAnchorX(self._txtnameen.transform)
	local halfWidth1 = nameAnchorX + self._txtsectionname.preferredWidth
	local halfWidth2 = nameEnAnchorX + self._txtsectionname.preferredWidth
	local halfWidth = math.max(halfWidth1, halfWidth2)

	self._maxWidth = math.max(halfWidth * 2, VersionActivityEnum.EpisodeItemMinWidth) + 30

	recthelper.setWidth(self._goclickarea.transform, self._maxWidth)
	recthelper.setWidth(self._goraycast.transform, self._maxWidth + self._layout._constDungeonNormalDeltaX)

	self.scrollContentPosX = recthelper.rectToRelativeAnchorPos(self.viewGO.transform.position, self._contentTransform).x
end

function VersionActivityDungeonBaseEpisodeItem:setImage(image, light, isHard)
	if light then
		if isHard then
			UISpriteSetMgr.instance:setVersionActivitySprite(image, "star_0_4")
		else
			UISpriteSetMgr.instance:setVersionActivitySprite(image, "star_0_3")
		end
	else
		UISpriteSetMgr.instance:setVersionActivitySprite(image, "star_0_1")
	end
end

function VersionActivityDungeonBaseEpisodeItem:getMaxWidth()
	return self._maxWidth
end

function VersionActivityDungeonBaseEpisodeItem:updateSelectStatus(selectedItem)
	if not selectedItem then
		if not self.isSelected and self.playLeftAnimation then
			self:playAnimation("restore")
		end

		self.isSelected = false

		return
	end

	self.isSelected = selectedItem._config.id == self._config.id

	if selectedItem._config.id == self._config.id then
		self:playAnimation("selected")
	else
		self.playLeftAnimation = true

		self:playAnimation("notselected")
	end
end

function VersionActivityDungeonBaseEpisodeItem:playAnimation(animationName)
	self.animator:Play(animationName)
end

function VersionActivityDungeonBaseEpisodeItem:getEpisodeId()
	return self._config and self._config.id
end

function VersionActivityDungeonBaseEpisodeItem:createStarItem(goStar)
	local starItem = self:getUserDataTb_()

	starItem.goStar = goStar
	starItem.imgStar1 = gohelper.findChildImage(goStar, "starLayout/#image_star1")
	starItem.imgStar2 = gohelper.findChildImage(goStar, "starLayout/#image_star2")

	return starItem
end

function VersionActivityDungeonBaseEpisodeItem:onClose()
	return
end

function VersionActivityDungeonBaseEpisodeItem:onDestroyView()
	self.goClick:RemoveClickListener()
end

return VersionActivityDungeonBaseEpisodeItem
