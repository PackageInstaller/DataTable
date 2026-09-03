-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/ChapterBase.lua

ChapterBase = class("ChapterBase", DmBaseUI)

ChapterBase:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

function ChapterBase:initialize(data)
	super.initialize(self, data)

	self._winSize = cc.Director:getInstance():getWinSize()
	self._stageType = StageType.kNormal
end

function ChapterBase:onScroll()
	return
end

function ChapterBase:update()
	return
end

function ChapterBase:checkRedPoint(tabRedPoint, value)
	for _, v in ipairs(tabRedPoint) do
		if v == value then
			return true
		end
	end

	return false
end

function ChapterBase:initMobileObj(offX, objectPanel, willOffSetWidth, rowPosition, initPosX, objectWidth)
	local percent
	local linePosition = self._winSize.width - offX - initPosX

	objectPanel:setPosition(cc.p(rowPosition.x + (linePosition > 0 and linePosition < self._winSize.width + willOffSetWidth + objectWidth and linePosition / (self._winSize.width + willOffSetWidth + objectWidth) or linePosition < 0 and 0 or linePosition > self._winSize.width + willOffSetWidth + objectWidth and 1 or 0.5) * willOffSetWidth, rowPosition.y))
end

function ChapterBase:initChapterPanel(chapterPanel, chapterId, enterCallFunc)
	local mapInfo = self._stageSystem:getMapById(chapterId)
	local mapConfig = ConfigReader:getRecordById("BlockMap", chapterId)
	local mapName = Strings:get(mapConfig.MapName)
	local chapterTitleText = chapterPanel:getChildByFullName("chapterTitle.titleText")

	chapterTitleText:setString(mapName)

	local curStars = chapterPanel:getChildByName("curStars")
	local maxStars = chapterPanel:getChildByName("maxStars")
	local chapterNum = chapterPanel:getChildByName("chapterNum")

	chapterNum:setString(mapConfig.Order)
	chapterPanel:setSwallowTouches(false)

	local callFunc

	if mapInfo then
		curStars:setString(mapInfo:getCurrentStarCount())
		maxStars:setString("/" .. mapInfo:getTotalStarCount())

		local chapterIndex = mapConfig.Order
		local unlock, tipStr = mapInfo:isUnlock()

		function callFunc(sender, eventType)
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
				self._mediator._data.stageType = self._stageType

				if unlock == true then
					if enterCallFunc then
						enterCallFunc()
					end

					AudioEngine:getInstance():playEffect("Se_Click_Charpter", false)
					self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, self:getInjector():getInstance("CommonStageChapterView"), {}, {
						chapterIndex = chapterIndex,
						stageType = self._stageType
					}))
				else
					local lastMapInfo = self._stageSystem:getMapByIndex(chapterIndex - 1, self._stageType)

					if lastMapInfo:isPass() or not lastMapInfo:isBattlePointPass() then
						AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
						self:dispatch(ShowTipEvent({
							duration = 0.2,
							tip = tipStr
						}))
					else
						local delegate, outSelf = {}, self

						function delegate:willClose(popupMediator, data)
							local resData = data.response

							if resData == 1 then
								local contentData = {}

								contentData.stageType = outSelf._stageType
								contentData.tabOffX = outSelf._mediator._tableView:getContentOffset().x

								outSelf._mediator:getStageSystem():setContentData(contentData)
								outSelf:dispatch(ViewEvent:new(EVT_PUSH_VIEW, outSelf:getInjector():getInstance("CommonStageChapterView"), {}, {
									chapterIndex = chapterIndex - 1,
									stageType = outSelf._stageType
								}))
							end
						end

						local view = self:getInjector():getInstance("AlertGoStoryPopView")

						self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
							transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
						}, {}, delegate))
					end
				end
			end
		end
	else
		curStars:setString("0")
		maxStars:setString("/0")

		function callFunc(sender, eventType)
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
				AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:get("Battle_Lock_Tips")
				}))
			end
		end
	end

	mapButtonHandlerClick(nil, chapterPanel, {
		ignoreClickAudio = true,
		func = callFunc
	})
end
