-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarMainSectionItem.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarMainSectionItem", package.seeall)

local V3a9RacingCarMainSectionItem = class("V3a9RacingCarMainSectionItem", ListScrollCellExtend)

function V3a9RacingCarMainSectionItem:onInitView()
	self._gounlock = gohelper.findChild(self.viewGO, "#go_unlock")
	self._txtindex1 = gohelper.findChildText(self.viewGO, "#go_unlock/#txt_index1")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_unlock/#go_progress")
	self._goprogressitem = gohelper.findChild(self.viewGO, "#go_unlock/#go_progress/#go_progressitem")
	self._goselect = gohelper.findChild(self.viewGO, "#go_unlock/#go_select")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._txtindex2 = gohelper.findChildText(self.viewGO, "#go_locked/#txt_index2")
	self._goclickarea = gohelper.findChild(self.viewGO, "#go_clickarea")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingCarMainSectionItem:addEvents()
	return
end

function V3a9RacingCarMainSectionItem:removeEvents()
	return
end

function V3a9RacingCarMainSectionItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)

	self._click:AddClickListener(self._onClick, self)

	self._starList = self:getUserDataTb_()

	gohelper.setActive(self._goprogressitem, false)

	self._maxStarNum = V3a9RacingCarEnum.RacingLevelStarMaxCount

	for i = 1, self._maxStarNum do
		self._starList[i] = gohelper.cloneInPlace(self._goprogressitem)
	end
end

function V3a9RacingCarMainSectionItem:_onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self._episodeInfo then
		V3a9RacingCarSectionListModel.instance:setSelectedCell(self._index)
	else
		GameFacade.showToast(ToastEnum.Va3Act124PreEpisodeNotOpen)
	end
end

function V3a9RacingCarMainSectionItem:_editableAddEvents()
	return
end

function V3a9RacingCarMainSectionItem:_editableRemoveEvents()
	return
end

function V3a9RacingCarMainSectionItem:onUpdateMO(mo)
	self._mo = mo
	self._config = mo.config
	self._episodeId = self._config.episodeId
	self._episodeInfo = V3a9RacingCarEpisodeModel.instance:getEpisodeInfo(self._episodeId)
	self._bestStar = tostring((self._episodeInfo or nil) and (self._episodeInfo.record or ""))
	self._gameLevelConfig = lua_racing_game_level.configDict[self._config.gameId]
	self._conditionParams = GameUtil.splitString2(self._gameLevelConfig.starCondition, true, "|", "#")

	self:_initViews()
	self:_initStars()
end

function V3a9RacingCarMainSectionItem:_initViews()
	local indexStr = tostring(self._index)

	self._txtindex1.text = indexStr
	self._txtindex2.text = indexStr

	gohelper.setActive(self._golocked, self._episodeInfo == nil)
	gohelper.setActive(self._gounlock, self._episodeInfo ~= nil)
end

function V3a9RacingCarMainSectionItem:_initStars()
	for i = 1, self._maxStarNum do
		local star = self._starList[i]
		local showStarGo = self._episodeInfo ~= nil

		gohelper.setActive(star, showStarGo)

		if showStarGo then
			local icon = gohelper.findChild(star, "icon")
			local targetValue = string.sub(self._bestStar, i, i)
			local isFinished = targetValue == "1"

			gohelper.setActive(icon, isFinished)
		end
	end
end

function V3a9RacingCarMainSectionItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function V3a9RacingCarMainSectionItem:onDestroyView()
	self._click:RemoveClickListener()
end

return V3a9RacingCarMainSectionItem
