-- chunkname: @modules/logic/dungeon/view/map/DungeonMapChapterLayout.lua

module("modules.logic.dungeon.view.map.DungeonMapChapterLayout", package.seeall)

local DungeonMapChapterLayout = class("DungeonMapChapterLayout", BaseChildView)

function DungeonMapChapterLayout:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapChapterLayout:addEvents()
	return
end

function DungeonMapChapterLayout:removeEvents()
	return
end

function DungeonMapChapterLayout:_editableInitView()
	local rectTransform = self.viewGO.transform
	local vec = Vector2(0, 1)

	rectTransform.pivot = vec
	rectTransform.anchorMin = vec
	rectTransform.anchorMax = vec
	self.defaultY = 100

	recthelper.setAnchorY(rectTransform, self.defaultY)

	self._ContentTransform = self.viewParam[1].transform
	self._rawWidth = recthelper.getWidth(rectTransform)
	self._rawHeight = recthelper.getHeight(rectTransform)

	recthelper.setSize(self._ContentTransform, self._rawWidth, self._rawHeight)

	self._episodeItemList = self:getUserDataTb_()

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local rightOffsetX = 600

	self._offsetX = (width - rightOffsetX) / 2 + rightOffsetX
	self._constDungeonNormalPosX = width - self._offsetX
	self._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	self._constDungeonNormalDeltaX = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalDeltaX) - 220
	self._constDungeonSPDeltaX = CommonConfig.instance:getConstNum(ConstEnum.DungeonSPDeltaX)
	self._timelineAnimation = gohelper.findChildComponent(self.viewGO, "timeline", typeof(UnityEngine.Animation))

	if ViewMgr.instance:isOpening(ViewName.DungeonMapLevelView) then
		self._timelineAnimation:Play("timeline_mask")
	end

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if animator then
		animator:Play(UIAnimationName.Open)
	end
end

function DungeonMapChapterLayout:CheckVision()
	local starNum2Episode, starNum3Episode, starNum4Episode, mapEpisode
	local contentPosX = recthelper.getAnchorX(self._ContentTransform)

	for i, v in ipairs(self._episodeItemList) do
		if contentPosX > v.scrollVisiblePosX then
			break
		end

		if v.unfinishedMap then
			mapEpisode = v
		end

		if v.starNum2 == false then
			starNum2Episode = starNum2Episode or v
		end

		if v.starNum3 == false then
			starNum3Episode = starNum3Episode or v
		end

		if v.starNum4 == false then
			starNum4Episode = starNum4Episode or v
		end
	end

	self._tempParam = self._tempParam or {}
	self._tempParam[1] = starNum2Episode or starNum3Episode or starNum4Episode
	self._tempParam[2] = mapEpisode

	DungeonController.instance:dispatchEvent(DungeonEvent.OnCheckVision, self._tempParam)
end

function DungeonMapChapterLayout:isSpecial(config)
	return config.id == 10217
end

function DungeonMapChapterLayout.getFocusMap(chapterId, jumpEpisodeId)
	local focusItemGo, focusNewGo, focusNormalGo, focusLastNormalGo
	local matchJump = false
	local list = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	for i, config in ipairs(list) do
		local info = DungeonModel.instance:getEpisodeInfo(config.id)

		if info then
			local isFinishElements = DungeonModel.instance:isFinishElementList(config)

			if config.id == DungeonModel.instance.lastSendEpisodeId then
				focusItemGo = config
			end

			if isFinishElements then
				focusLastNormalGo = config
			end

			if info.isNew and not focusNewGo then
				focusNewGo = config

				if focusItemGo and isFinishElements and not matchJump then
					focusItemGo = focusNewGo
				end
			end

			if jumpEpisodeId and config.id == jumpEpisodeId then
				matchJump = true
				focusItemGo = config
			end

			if not focusNormalGo and not DungeonModel.instance:hasPassLevelAndStory(config.id) and isFinishElements then
				focusNormalGo = config
			end
		end
	end

	focusItemGo = focusItemGo or focusNormalGo or focusLastNormalGo

	return DungeonMapEpisodeItem.getMap(focusItemGo)
end

function DungeonMapChapterLayout:skipFocusItem(value)
	self._skipFocusItem = value
end

function DungeonMapChapterLayout:onRefresh(jumpEpisodeId)
	local rectTransform = self.viewGO.transform

	self._ContentTransform = self.viewParam[1].transform
	self._ScrollView = self.viewParam[2]
	self._scrollTrans = self.viewParam[3].transform
	self._dungeonChapterView = self.viewParam[4]
	self._chapter = self.viewParam[5]

	local chapterKey = "default"
	local chapterGo = gohelper.findChild(self.viewGO, string.format("%s", chapterKey))

	gohelper.setActive(chapterGo.gameObject, true)

	self._golevellist = gohelper.findChild(self.viewGO, string.format("%s/go_levellist", chapterKey))
	self._gotemplatenormal = gohelper.findChild(self.viewGO, string.format("%s/go_levellist/#go_templatenormal", chapterKey))
	self._gotemplatesp = gohelper.findChild(self.viewGO, string.format("%s/go_levellist/#go_templatesp", chapterKey))

	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(DungeonModel.instance.curLookChapterId)

	self._levelItemList = self._levelItemList or self:getUserDataTb_()

	local focusNormalGo, focusNewGo, focusStarTypeNormalGo, focusHardGo, focusItemGo, lastItemGo, lastItemParentTransform, focusLastNormalGo
	local matchJump = false
	local chapterIndex, _ = DungeonConfig.instance:getChapterIndex(DungeonModel.instance.curChapterType, DungeonModel.instance.curLookChapterId)

	self:_initLevelList()

	local spIndex = 0
	local nonSpIndex = 0
	local curIndex

	self._episodeOpenCount = 0

	if episodeList then
		self._episodeCount = #episodeList or 0
	end

	gohelper.setActive(self._scrollTrans, self._episodeCount ~= 0)

	if self._episodeCount == 0 then
		local map = DungeonConfig.instance:getChapterMapCfg(DungeonModel.instance.curLookChapterId, 0)

		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMap, {
			map
		})
	end

	if episodeList then
		for i, config in ipairs(episodeList) do
			local spType = config.type == DungeonEnum.EpisodeType.Sp

			if spType then
				spIndex = spIndex + 1
				curIndex = spIndex
			else
				nonSpIndex = nonSpIndex + 1
				curIndex = nonSpIndex
			end

			local info = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil
			local isSpShow = self:_isSpShow(config, episodeList[i + 1])
			local oneItemTr = info and not spType and self:_getLevelContainer(config)

			if info and oneItemTr then
				if not spType then
					self._episodeOpenCount = curIndex
				end

				local itemGo

				if oneItemTr.childCount == 0 then
					local path = self._dungeonChapterView.viewContainer:getSetting().otherRes[1]

					itemGo = self._dungeonChapterView:getResInst(path, oneItemTr.gameObject)
				else
					itemGo = oneItemTr:GetChild(0).gameObject
				end

				oneItemTr.name = config.id

				local isFinishElements = DungeonModel.instance:isFinishElementList(config)
				local item = self._levelItemList[config.id]
				local param = {
					config,
					info,
					self._ContentTransform,
					curIndex
				}

				if not item then
					item = DungeonMapEpisodeItem.New()

					item:initView(itemGo, param)
					table.insert(self._episodeItemList, item)

					self._levelItemList[config.id] = item
				else
					item:updateParam(param)
				end

				if config.id == DungeonModel.instance.lastSendEpisodeId then
					DungeonModel.instance.lastSendEpisodeId = nil
					focusItemGo = itemGo
				end

				if not lastItemParentTransform or recthelper.getAnchorX(oneItemTr) >= recthelper.getAnchorX(lastItemParentTransform) then
					lastItemParentTransform = oneItemTr
					lastItemGo = itemGo
				end

				if not spType and not item:isLock() and isFinishElements then
					focusLastNormalGo = itemGo
				end

				if info.isNew then
					info.isNew = false

					if not focusNewGo then
						focusNewGo = itemGo

						if not spType and focusItemGo and isFinishElements and not matchJump then
							focusItemGo = focusNewGo

							item:showUnlockAnim()
						end
					end
				end

				if jumpEpisodeId and config.id == jumpEpisodeId then
					matchJump = true
					focusItemGo = itemGo
				end

				if config.chainEpisode ~= 0 then
					if not config.chainEpisode then
						local episodeId = config.id

						if not spType and not focusNormalGo and not item:isLock() and not DungeonModel.instance:hasPassLevelAndStory(episodeId) and isFinishElements then
							focusNormalGo = itemGo
						end

						local hardEpisode = DungeonConfig.instance:getHardEpisode(config.id)

						if DungeonModel.instance:isOpenHardDungeon(config.chapterId) and not spType and not focusHardGo and hardEpisode and not DungeonModel.instance:hasPassLevelAndStory(hardEpisode.id) then
							-- block empty
						end

						if not spType and not focusStarTypeNormalGo and hardEpisode and info.star == DungeonEnum.StarType.Normal then
							-- block empty
						end
					end
				end
			elseif info and not oneItemTr then
				-- block empty
			end
		end
	end

	if not focusItemGo then
		focusItemGo = focusNormalGo or focusLastNormalGo
		focusItemGo = focusItemGo or self._episodeItemList[1] and self._episodeItemList[1].viewGO
	end

	if lastItemGo then
		local pos = recthelper.rectToRelativeAnchorPos(lastItemGo.transform.position, rectTransform)
		local width = pos.x + self._offsetX

		recthelper.setSize(self._ContentTransform, width, self._rawHeight)

		self._contentWidth = width
	end

	if self._skipFocusItem then
		return
	end

	self:setFocusItem(focusItemGo, false)
end

function DungeonMapChapterLayout:setFocusItem(focusItemGo, tween)
	if not focusItemGo then
		return
	end

	local rectTransform = self.viewGO.transform
	local pos = recthelper.rectToRelativeAnchorPos(focusItemGo.transform.position, rectTransform)
	local scrollWidth = recthelper.getWidth(self._scrollTrans)
	local scrollHeight = recthelper.getHeight(self._scrollTrans)
	local offsetX = -pos.x + self._constDungeonNormalPosX

	if tween then
		ZProj.TweenHelper.DOAnchorPosX(self._ContentTransform, offsetX, 0.26)
	else
		recthelper.setAnchorX(self._ContentTransform, offsetX)
	end

	self:CheckVision()

	for i, v in ipairs(self._episodeItemList) do
		if v.viewGO == focusItemGo then
			DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, v)

			break
		end
	end
end

function DungeonMapChapterLayout:setFocusEpisodeItem(item, tween)
	local offsetX = -item.scrollContentPosX + self._constDungeonNormalPosX

	if tween then
		if not DungeonMapModel.instance.focusEpisodeTweenDuration then
			DungeonMapModel.instance.focusEpisodeTweenDuration = nil

			ZProj.TweenHelper.DOAnchorPosX(self._ContentTransform, offsetX, DungeonMapModel.instance.focusEpisodeTweenDuration)
		end
	else
		recthelper.setAnchorX(self._ContentTransform, offsetX)
	end

	self:CheckVision()
end

function DungeonMapChapterLayout:setFocusEpisodeId(episodeId, tween)
	local focusItemGo = self._levelItemList[episodeId]

	if focusItemGo and focusItemGo.viewGO then
		self:setFocusItem(focusItemGo.viewGO, tween)
	end
end

function DungeonMapChapterLayout:changeFocusEpisodeItem(episodeId)
	local item = self._levelItemList[episodeId]

	if not item then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, item)
end

function DungeonMapChapterLayout:_initLevelList()
	if not self._itemTransformList then
		self._itemTransformList = self:getUserDataTb_()
		self._rawGoList = self:getUserDataTb_()
	end
end

function DungeonMapChapterLayout:_isSpShow(config, nextConfig)
	local isSp = config.type == DungeonEnum.EpisodeType.Sp

	if isSp and nextConfig and nextConfig.preEpisode == config.id and nextConfig.type ~= DungeonEnum.EpisodeType.Sp then
		isSp = false
	end

	return isSp
end

function DungeonMapChapterLayout:getEpisodeCount()
	return self._episodeCount
end

function DungeonMapChapterLayout:_getLevelContainer(config)
	local id = config.id
	local oneItemTr = self._itemTransformList[id]

	if oneItemTr then
		return oneItemTr
	end

	if not oneItemTr and #self._rawGoList > 0 then
		oneItemTr = table.remove(self._rawGoList, 1)
	end

	if not oneItemTr then
		local preEpisode = config.preEpisode
		local preItemTr = self._itemTransformList[preEpisode]
		local prePosX = preItemTr and recthelper.getAnchorX(preItemTr)
		local go = gohelper.cloneInPlace(self._gotemplatenormal, id)

		gohelper.setActive(go, true)

		oneItemTr = go.transform

		if prePosX then
			local prevItem = self._levelItemList[preEpisode]

			recthelper.setAnchorX(oneItemTr, prePosX + prevItem:getMaxWidth() + self._constDungeonNormalDeltaX)
		else
			recthelper.setAnchorX(oneItemTr, self._constDungeonNormalPosX)
		end

		recthelper.setAnchorY(oneItemTr, self._constDungeonNormalPosY)
	end

	self._itemTransformList[id] = oneItemTr

	return oneItemTr
end

function DungeonMapChapterLayout:onUpdateParam()
	return
end

function DungeonMapChapterLayout:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyUp, self._onGamepadKeyUp, self)
	end

	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, self._onChangeFocusEpisodeItem, self)
end

function DungeonMapChapterLayout:_onChangeFocusEpisodeItem(item)
	for i, v in ipairs(self._episodeItemList) do
		if v == item then
			self._focusIndex = i
		end
	end
end

function DungeonMapChapterLayout:_onGamepadKeyUp(key)
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if (topView == ViewName.DungeonMapView or topView == ViewName.DungeonMapLevelView) and self._focusIndex and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (key == GamepadEnum.KeyCode.LB or key == GamepadEnum.KeyCode.RB) then
		local offset = key == GamepadEnum.KeyCode.LB and -1 or 1
		local index = self._focusIndex + offset

		if index > 0 and index <= #self._episodeItemList then
			local item = self._episodeItemList[index]

			item:onClickHandler()
		end
	end
end

function DungeonMapChapterLayout:_onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self._timelineAnimation:Play("timeline_mask")
	end
end

function DungeonMapChapterLayout:_onCloseView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self._timelineAnimation:Play("timeline_reset")
	end
end

function DungeonMapChapterLayout:onClose()
	for i, v in pairs(self._levelItemList) do
		v:destroyView()
	end
end

function DungeonMapChapterLayout:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end
end

return DungeonMapChapterLayout
