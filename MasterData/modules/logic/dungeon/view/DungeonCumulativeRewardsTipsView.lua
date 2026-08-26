-- chunkname: @modules/logic/dungeon/view/DungeonCumulativeRewardsTipsView.lua

module("modules.logic.dungeon.view.DungeonCumulativeRewardsTipsView", package.seeall)

local DungeonCumulativeRewardsTipsView = class("DungeonCumulativeRewardsTipsView", BaseView)

function DungeonCumulativeRewardsTipsView:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")
	self._scrolltips = gohelper.findChildScrollRect(self.viewGO, "root/tips/#scroll_tips")
	self._gotipsitem = gohelper.findChild(self.viewGO, "root/tips/#scroll_tips/viewport/content/#go_tipsitem")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/tips/#scroll_tips/viewport/content/#go_tipsitem/title/#txt_title")
	self._txtrest = gohelper.findChildText(self.viewGO, "root/tips/#scroll_tips/viewport/content/#go_tipsitem/title/#txt_title/#txt_rest")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonCumulativeRewardsTipsView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function DungeonCumulativeRewardsTipsView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function DungeonCumulativeRewardsTipsView:_btnclickOnClick()
	self:closeThis()
end

function DungeonCumulativeRewardsTipsView:_editableInitView()
	gohelper.setActive(self._gotipsitem, false)
end

function DungeonCumulativeRewardsTipsView:onUpdateParam()
	return
end

function DungeonCumulativeRewardsTipsView:onOpen()
	self._maxEpisodeNum = CommonConfig.instance:getConstNum(ConstEnum.CumulativeRewardsMaxEpisode)
	self._maxElementNum = CommonConfig.instance:getConstNum(ConstEnum.CumulativeRewardsMaxElement)
	self._btnList = self:getUserDataTb_()
	self._episodeList, self._elementList = self.viewParam.episodeList, self.viewParam.elementList

	local episodeItem = self:_initEpisode()
	local elementItem = self:_initElement()

	if #self._episodeList == 0 then
		gohelper.setSiblingBefore(elementItem, episodeItem)
	end
end

function DungeonCumulativeRewardsTipsView:_initEpisode()
	local item = gohelper.cloneInPlace(self._gotipsitem)

	gohelper.setActive(item, true)

	local emptyGo = gohelper.findChild(item, "empty")
	local jumpItem = gohelper.findChild(item, "go_jumpItem")
	local titleTxt = gohelper.findChildText(item, "title/#txt_title")
	local restTxt = gohelper.findChildText(item, "title/#txt_title/#txt_rest")
	local list = self._episodeList

	for i, v in ipairs(list) do
		local jumpGo = gohelper.cloneInPlace(jumpItem)

		self:_showEpisode(jumpGo, v, i)

		if i >= self._maxEpisodeNum then
			break
		end
	end

	titleTxt.text = luaLang("CumulativeRewardsTipsTitle_1")

	local num = #list
	local isEmpty = num == 0

	gohelper.setActive(emptyGo, isEmpty)

	restTxt.text = isEmpty and "" or string.format("(%s)", formatLuaLang("remain", string.format(":<#D1550E>%s</color>", num)))

	return item
end

function DungeonCumulativeRewardsTipsView:_showEpisode(obj, episodeConfig, index)
	gohelper.setActive(obj, true)

	local indexText = gohelper.findChildText(obj, "indexText")
	local originText = gohelper.findChildText(obj, "layout/originText")
	local hardtag = gohelper.findChild(obj, "layout/hardtag")

	gohelper.setActive(hardtag, JumpConfig.instance:isJumpHardDungeon(episodeConfig.id))

	local name, index = JumpConfig.instance:getEpisodeNameAndIndex(episodeConfig.id)

	originText.text = name
	indexText.text = index

	local btn = gohelper.findChildButtonWithAudio(obj, "jump/jumpBtn")

	btn:AddClickListener(self._jumpEpisode, self, episodeConfig)
	table.insert(self._btnList, btn)
end

function DungeonCumulativeRewardsTipsView:_jumpEpisode(episodeConfig)
	JumpController.instance:jumpTo("4#" .. episodeConfig.id)
end

function DungeonCumulativeRewardsTipsView:_initElement()
	local item = gohelper.cloneInPlace(self._gotipsitem)

	gohelper.setActive(item, true)

	local emptyGo = gohelper.findChild(item, "empty")
	local jumpItem = gohelper.findChild(item, "go_jumpItem")
	local titleTxt = gohelper.findChildText(item, "title/#txt_title")
	local restTxt = gohelper.findChildText(item, "title/#txt_title/#txt_rest")
	local list = self._elementList
	local index = 0

	for i, v in ipairs(list) do
		local jumpGo = gohelper.cloneInPlace(jumpItem)
		local episodeId = DungeonConfig.instance:getEpisodeIdByMapId(v.mapId)

		if episodeId then
			self:_showElement(jumpGo, v, episodeId)

			index = index + 1

			if index >= self._maxElementNum then
				break
			end
		end
	end

	titleTxt.text = luaLang("CumulativeRewardsTipsTitle_2")

	local num = #list
	local isEmpty = num == 0

	gohelper.setActive(emptyGo, isEmpty)

	restTxt.text = isEmpty and "" or string.format("(%s)", formatLuaLang("remain", string.format(":<#D1550E>%s</color>", num)))

	return item
end

function DungeonCumulativeRewardsTipsView:_showElement(obj, config, episodeId)
	gohelper.setActive(obj, true)
	gohelper.setActive(obj, true)

	local indexText = gohelper.findChildText(obj, "indexText")
	local originText = gohelper.findChildText(obj, "layout/originText")

	originText.text = config.title

	local _, index = JumpConfig.instance:getEpisodeNameAndIndex(episodeId)

	indexText.text = index

	local btn = gohelper.findChildButtonWithAudio(obj, "jump/jumpBtn")

	btn:AddClickListener(self._jumpElementEpisode, self, {
		config.id,
		episodeId
	})
	table.insert(self._btnList, btn)
end

function DungeonCumulativeRewardsTipsView:_jumpElementEpisode(param)
	DungeonMapModel.instance:setFocusElementId(param[1])
	JumpController.instance:jumpTo(string.format("4#%s#1", param[2]))
end

function DungeonCumulativeRewardsTipsView:onClose()
	for i, v in ipairs(self._btnList) do
		v:RemoveClickListener()
	end
end

function DungeonCumulativeRewardsTipsView:onDestroyView()
	return
end

function DungeonCumulativeRewardsTipsView.getEpisodeList()
	local result = {}
	local elementResult = {}
	local chapterList = {
		DungeonConfig.instance:getNormalChapterList()
	}

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		table.insert(chapterList, DungeonConfig.instance:getHardChapterList())
	end

	for i, list in ipairs(chapterList) do
		for _, chapterConfig in ipairs(list) do
			if not DungeonModel.instance:chapterIsLock(chapterConfig.id) then
				local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterConfig.id)

				if episodeList then
					for _, episodeConfig in ipairs(episodeList) do
						local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeConfig.id)

						if episodeInfo and DungeonModel.instance:isFinishElementList(episodeConfig) then
							if chapterConfig.type == DungeonEnum.ChapterType.Hard then
								if episodeInfo.star < DungeonEnum.StarType.Advanced then
									table.insert(result, episodeConfig)
								end
							elseif chapterConfig.type == DungeonEnum.ChapterType.Normal then
								local config = DungeonConfig.instance:getEpisodeCO(episodeInfo.episodeId)

								if config then
									if config.type == DungeonEnum.EpisodeType.Normal then
										if episodeInfo.star < DungeonEnum.StarType.Advanced then
											table.insert(result, config)
										end
									elseif episodeInfo.star == 0 then
										table.insert(result, config)
									end
								else
									logError("DungeonCumulativeRewardsTipsView._collectElementList config is nil", tostring(episodeInfo.episodeId))
								end
							else
								logError("DungeonCumulativeRewardsTipsView._collectElementList chapterConfig.type error", tostring(chapterConfig.type))
							end

							DungeonCumulativeRewardsTipsView._collectElementList(episodeConfig, elementResult)
						end
					end
				end
			end
		end
	end

	return result, elementResult
end

function DungeonCumulativeRewardsTipsView._collectElementList(episodeConfig, elementResult)
	local map = DungeonMapEpisodeItem.getMap(episodeConfig)

	if not map then
		return
	end

	local list = DungeonConfig.instance:getMapElements(map.id)

	if not list then
		return
	end

	for _, elementCo in pairs(list) do
		if elementCo.rewardPoint > 0 and DungeonMapModel.instance:getElementById(elementCo.id) then
			table.insert(elementResult, elementCo)
		end
	end
end

return DungeonCumulativeRewardsTipsView
