-- chunkname: @modules/logic/matchgame/outside/map/MatchGameMapListItem.lua

module("modules.logic.matchgame.outside.map.MatchGameMapListItem", package.seeall)

local MatchGameMapListItem = class("MatchGameMapListItem", SimpleListItem)

function MatchGameMapListItem:onInit()
	self._txtIndex = gohelper.findChildText(self.viewGO, "image_bg/#txt_index")
	self._txtIndex2 = gohelper.findChildText(self.viewGO, "#go_lock/#txt_lockindex")
	self._goLock = gohelper.findChild(self.viewGO, "#go_lock")
	self._goUnlock = gohelper.findChild(self.viewGO, "#go_unlock")
	self._goSelect = gohelper.findChild(self.viewGO, "#go_select")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
end

function MatchGameMapListItem:onAddListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function MatchGameMapListItem:onRemoveListeners()
	self._btnClick:RemoveClickListener()
end

function MatchGameMapListItem:_btnClickOnClick()
	if not MatchGameLevelModel.instance:isCanSwitchChapter(self._mapId, true) then
		return
	end

	MatchGameController.instance:dispatchEvent(MatchGameEvent.PlaySwitchMapAnim, self._mapId)
end

function MatchGameMapListItem:onItemShow(mapMo)
	self._mapMo = mapMo
	self._mapId = mapMo.chapterId
	self._status = MatchGameModel.instance:getChapterStatus(self._mapId)
	self._mapCo = lua_activity244_chapter.configDict[self._mapId]

	self:refreshUI()
end

function MatchGameMapListItem:refreshUI()
	self._txtIndex.text = self._mapCo and self._mapCo.chapterName
	self._txtIndex2.text = self._mapCo and self._mapCo.chapterName

	gohelper.setActive(self._goLock, self._status == MatchGameEnum.MapStatus.Lock)
	gohelper.setActive(self._goUnlock, self._status == MatchGameEnum.MapStatus.Unlock)
end

function MatchGameMapListItem:onSelectChange(isSelect)
	gohelper.setActive(self._goSelect, isSelect)
end

return MatchGameMapListItem
