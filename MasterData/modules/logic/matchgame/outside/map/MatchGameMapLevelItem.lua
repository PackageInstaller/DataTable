-- chunkname: @modules/logic/matchgame/outside/map/MatchGameMapLevelItem.lua

module("modules.logic.matchgame.outside.map.MatchGameMapLevelItem", package.seeall)

local MatchGameMapLevelItem = class("MatchGameMapLevelItem", LuaCompBase)

function MatchGameMapLevelItem:init(go)
	self.viewGO = go
	self.transform = self.viewGO.transform
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")
	self._goLock = gohelper.findChild(self.viewGO, "#go_Lock")
	self._goNormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._goCurrent = gohelper.findChild(self.viewGO, "#go_Current")
	self._txtIndex = gohelper.findChildText(self.viewGO, "#go_Normal/#txt_Index")
	self._txtIndex2 = gohelper.findChildText(self.viewGO, "#go_Lock/#txt_Index")
	self._txtIndex3 = gohelper.findChildText(self.viewGO, "#go_Current/ani_loop/#txt_Index")
	self._goStar = gohelper.findChild(self.viewGO, "#go_Star")
	self._goStarList = gohelper.findChild(self.viewGO, "#go_Star/#go_StarList")
	self._goStarItem = gohelper.findChild(self.viewGO, "#go_Star/#go_StarList/#go_StarItem")
	self._anim = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._actId = MatchGameModel.instance:getCurActId()
end

function MatchGameMapLevelItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnClickSelectEpisode, self._onClickSelectEpisode, self)
end

function MatchGameMapLevelItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function MatchGameMapLevelItem:_btnClickOnClick()
	local curSelectId = MatchGameLevelModel.instance:getCurEpisodeId()

	if curSelectId == self._episodeId then
		return
	end

	MatchGameStatHelper.instance:statEpisodeClick(ViewName.MatchGameMapView, MatchGameEnum.StatClickType.ClickEpisode, self._episodeId)

	local isUnlock = MatchGameLevelModel.instance:isEpisodeUnlock(self._episodeId)

	if not isUnlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	MatchGameLevelModel.instance:switchEpisode(self._episodeId)
end

function MatchGameMapLevelItem:setParam(co, index, posX, posY)
	self._config = co
	self._episodeId = co.id
	self._index = index
	self._posX = posX or 0
	self._posY = posY or 0

	recthelper.setAnchor(self.transform, self._posX, self._posY)
	self:refreshUI()
end

function MatchGameMapLevelItem:getEpisodeId()
	return self._episodeId
end

function MatchGameMapLevelItem:refreshUI()
	self._isUnlock = MatchGameLevelModel.instance:isEpisodeUnlock(self._episodeId)
	self._isPass = MatchGameLevelModel.instance:isEpisodePass(self._episodeId)

	gohelper.setActive(self._goLock, not self._isUnlock)
	gohelper.setActive(self._goNormal, self._isUnlock)
	gohelper.setActive(self.viewGO, true)
	self:refreshIndex()
	self:refreshStar()
	self:refreshSelect()
end

function MatchGameMapLevelItem:refreshIndex()
	local indexEn = ""
	local nextEpisode = MatchGameConfig.instance:getNextEpisodeConfig(self._episodeId)

	indexEn = (not nextEpisode or nextEpisode.chapterId ~= self._config.chapterId) and luaLang("matchgamemapview_lastepisodeindex") or string.char(self._index + 64)
	self._txtIndex.text = indexEn
	self._txtIndex2.text = indexEn
	self._txtIndex3.text = indexEn
end

function MatchGameMapLevelItem:playIdleAnim()
	if self._isUnlock then
		self._anim:Play("idel", 0, 0)
	else
		self._anim:Play("lock", 0, 0)
	end
end

function MatchGameMapLevelItem:refreshStar()
	gohelper.setActive(self._goStar, self._isUnlock)

	if not self._isUnlock then
		return
	end

	local starNum = MatchGameConfig.instance:getConstValue(self._actId, MatchGameEnum.ConstId.EpisodeStarNum, true)

	gohelper.CreateNumObjList(self._goStarList, self._goStarItem, starNum, self._refreshStarItem, self)
end

function MatchGameMapLevelItem:_refreshStarItem(goStar, index)
	local goLight = gohelper.findChild(goStar, "light")
	local episodeMo = MatchGameLevelModel.instance:getEpisodeInfoById(self._episodeId)
	local isPass = episodeMo and episodeMo:isConditionPass(index)

	gohelper.setActive(goLight, isPass)
end

function MatchGameMapLevelItem:isUnlock()
	return self._isUnlock
end

function MatchGameMapLevelItem:playFinish()
	self._isPass = MatchGameLevelModel.instance:isEpisodePass(self._episodeId)

	gohelper.setActive(self._goLock, false)
	gohelper.setActive(self._goNormal, true)

	self._anim.enabled = true

	self._anim:Play("finish", 0, 0)
	AudioMgr.instance:trigger(MatchGameAudioEnum.PassEpisode)
end

function MatchGameMapLevelItem:playUnlock()
	local isCurrent = self._episodeId == MatchGameLevelModel.instance:getCurEpisodeId()

	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self._goLock, true)

	self._anim.enabled = true

	self._anim:Play("unlock", 0, 0)
	AudioMgr.instance:trigger(MatchGameAudioEnum.UnlockEpisode)
end

function MatchGameMapLevelItem:_onClickSelectEpisode()
	self:refreshSelect()
end

function MatchGameMapLevelItem:refreshSelect()
	local curEpisodeId = MatchGameLevelModel.instance:getCurEpisodeId()
	local isSelect = self._episodeId == curEpisodeId

	gohelper.setActive(self._goCurrent, isSelect)

	if isSelect then
		self._anim:Play("select", 0, 0)
	else
		self:playIdleAnim()
	end
end

return MatchGameMapLevelItem
