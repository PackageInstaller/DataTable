-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142MapItem.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142MapItem", package.seeall)

local Activity142MapItem = class("Activity142MapItem", LuaCompBase)

function Activity142MapItem:ctor(param)
	self._clickCb = param.clickCb
	self._clickCbObj = param.clickCbObj
	self._starItemList = {}
end

function Activity142MapItem:init(go)
	self._go = go
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._go)
	self._golock = gohelper.findChild(self._go, "#go_lock")
	self._simagemaplock = gohelper.findChildImage(self._go, "#go_lock/mask/#simage_maplock")
	self._gonormal = gohelper.findChild(self._go, "#go_normal")
	self._gonormalbg = gohelper.findChild(self._go, "#go_normal/#simage_normalbg")
	self._gosinglebg = gohelper.findChild(self._go, "#go_normal/#simage_singlebg")
	self._simagemap = gohelper.findChildImage(self._go, "#go_normal/mask/#simage_map")
	self._characternum = gohelper.findChildText(self._go, "#txt_characternum")
	self._txtmap = gohelper.findChildText(self._go, "#txt_map")
	self._gostarts = gohelper.findChild(self._go, "#go_starts")
	self._gostartitem = gohelper.findChild(self._go, "#go_starts/#go_startitem")

	gohelper.setActive(self._gostartitem, false)

	self._btnclickarea = gohelper.findChildButtonWithAudio(self._go, "#btn_clickarea")
	self._btnreplay = gohelper.findChildButtonWithAudio(self._go, "#btn_replay")

	self:setEpisodeId()
	self:setBg(false)
end

function Activity142MapItem:addEventListeners()
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
	self._btnclickarea:AddClickListener(self._onClick, self)
end

function Activity142MapItem:removeEventListeners()
	self._btnreplay:RemoveClickListener()
	self._btnclickarea:RemoveClickListener()
end

function Activity142MapItem:_btnreplayOnClick()
	if not self._episodeId then
		return
	end

	Activity142Controller.instance:openStoryView(self._episodeId)
end

function Activity142MapItem:_onClick()
	if not self._episodeId or not self._clickCb then
		return
	end

	self._clickCb(self._clickCbObj, self._episodeId)
end

function Activity142MapItem:setEpisodeId(episodeId, unlockAnimDelayTime)
	self:cancelAllTaskDispatcher()

	self._episodeId = episodeId

	if not self._episodeId then
		gohelper.setActive(self._go, false)

		return
	end

	gohelper.setActive(self._go, true)

	local actId = Activity142Model.instance:getActivityId()

	self._characternum.text = Activity142Config.instance:getEpisodeOrder(actId, self._episodeId) or ""
	self._txtmap.text = Activity142Config.instance:getEpisodeName(actId, self._episodeId) or ""

	local normalSpriteName = Activity142Config.instance:getEpisodeNormalSP(actId, self._episodeId)

	if normalSpriteName then
		UISpriteSetMgr.instance:setV1a5ChessSprite(self._simagemap, normalSpriteName)
	end

	local lockSpriteName = Activity142Config.instance:getEpisodeLockSP(actId, self._episodeId)

	if lockSpriteName then
		UISpriteSetMgr.instance:setV1a5ChessSprite(self._simagemaplock, lockSpriteName)
	end

	for _, starItem in ipairs(self._starItemList) do
		gohelper.setActive(starItem.go, false)
	end

	local maxStar = Activity142Config.instance:getEpisodeMaxStar(actId, self._episodeId)

	for i = 1, maxStar do
		local starItem = self._starItemList[i]

		starItem = starItem or self:_addStarItem()

		gohelper.setActive(starItem.go, true)
		gohelper.setActive(starItem.grayGO, true)
		gohelper.setActive(starItem.lightGO, false)
		gohelper.setActive(starItem.lightEffectGO, false)
	end

	self:refresh(unlockAnimDelayTime)
end

function Activity142MapItem:_addStarItem()
	local index = #self._starItemList + 1
	local starItem = self:getUserDataTb_()

	starItem.go = gohelper.clone(self._gostartitem, self._gostarts, "star" .. index)
	starItem.grayGO = gohelper.findChild(starItem.go, "#go_gray")
	starItem.lightGO = gohelper.findChild(starItem.go, "#go_light")
	starItem.lightAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(starItem.lightGO)
	starItem.lightEffectGO = gohelper.findChild(starItem.go, "#go_light/xing")
	self._starItemList[index] = starItem

	ZProj.UGUIHelper.RebuildLayout(self._gostarts.transform)

	return starItem
end

function Activity142MapItem:setParent(parenGO)
	if gohelper.isNil(self._go) or gohelper.isNil(parenGO) then
		return
	end

	self._go.transform:SetParent(parenGO.transform, false)
end

function Activity142MapItem:setBg(isSingle)
	gohelper.setActive(self._gosinglebg, isSingle)
	gohelper.setActive(self._gonormalbg, not isSingle)
end

function Activity142MapItem:refresh(unlockAnimDelayTime)
	if not self._episodeId then
		return
	end

	self:_refreshUnlock(unlockAnimDelayTime)
	self:_refreshStar()
	self:_refreshReplayBtn()
end

function Activity142MapItem:_refreshUnlock(delayTime)
	if self._animatorPlayer then
		if self._animatorPlayer then
			self._animatorPlayer:Play(Activity142Enum.MAP_ITEM_IDLE_ANIM)
		end

		local actId = Activity142Model.instance:getActivityId()
		local isOpen = Activity142Model.instance:isEpisodeOpen(actId, self._episodeId)
		local cacheKey = string.format("%s_%s", Activity142Enum.MAP_ITEM_CACHE_KEY, self._episodeId)
		local isPlayUnlockAnim = self._episodeId ~= Activity142Enum.AUTO_ENTER_EPISODE_ID and not Activity142Controller.instance:havePlayedUnlockAni(cacheKey)

		if isPlayUnlockAnim and self._animatorPlayer and isOpen then
			self:playMapItemUnlockAnim(delayTime)
		else
			gohelper.setActive(self._gonormal, isOpen)
			gohelper.setActive(self._golock, not isOpen)
		end
	end
end

function Activity142MapItem:_refreshStar()
	local episodeData = Activity142Model.instance:getEpisodeData(self._episodeId)

	if not episodeData then
		return
	end

	for i, starItem in ipairs(self._starItemList) do
		if starItem.lightAnimatorPlayer then
			starItem.lightAnimatorPlayer:Play(Activity142Enum.MAP_STAR_IDLE_ANIM)
		end

		local cacheKey = string.format("%s_%s_%s", Activity142Enum.MAP_STAR_CACHE_KEY, self._episodeId, i)
		local isPlayUnlockAnim = not Activity142Controller.instance:havePlayedUnlockAni(cacheKey)
		local isLight = i <= episodeData.star

		if isPlayUnlockAnim and starItem.lightAnimatorPlayer and isLight then
			Activity142Helper.setAct142UIBlock(true, Activity142Enum.EPISODE_STAR_UNLOCK)
			UIBlockMgrExtend.setNeedCircleMv(false)
			gohelper.setActive(starItem.grayGO, true)
			gohelper.setActive(starItem.lightGO, true)
			starItem.lightAnimatorPlayer:Play(Activity142Enum.MAP_STAR_OPEN_ANIM, self._finishStarItemUnlockAnim, {
				self = self,
				index = i
			})
		else
			gohelper.setActive(starItem.grayGO, not isLight)
			gohelper.setActive(starItem.lightGO, isLight)
		end
	end
end

function Activity142MapItem._finishStarItemUnlockAnim(param)
	if not param or not param.self or not param.self._episodeId or not param.index then
		return
	end

	local self = param.self
	local episodeId = self._episodeId
	local index = param.index
	local cacheKey = string.format("%s_%s_%s", Activity142Enum.MAP_STAR_CACHE_KEY, episodeId, index)

	Activity142Controller.instance:setPlayedUnlockAni(cacheKey)
	self:_endBlock(true)
end

function Activity142MapItem:_refreshReplayBtn()
	local actId = Activity142Model.instance:getActivityId()
	local isStoryEpisode = Va3ChessConfig.instance:isStoryEpisode(actId, self._episodeId)
	local episodeStoryList = Activity142Config.instance:getEpisodeStoryList(actId, self._episodeId)
	local isClear = Activity142Model.instance:isEpisodeClear(self._episodeId)

	gohelper.setActive(self._btnreplay.gameObject, isClear and not isStoryEpisode and #episodeStoryList > 0)
end

function Activity142MapItem:playMapItemUnlockAnim(delayTime)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.MAP_ITEM_UNLOCK)
	gohelper.setActive(self._golock, true)
	gohelper.setActive(self._gonormal, false)

	if delayTime and delayTime > 0 then
		TaskDispatcher.runDelay(self._delayPlayMapItemUnlockAnim, self, delayTime)
	else
		self:_delayPlayMapItemUnlockAnim()
	end
end

function Activity142MapItem:_delayPlayMapItemUnlockAnim()
	gohelper.setActive(self._gonormal, true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockItem)
	self._animatorPlayer:Play(Activity142Enum.CATEGORY_UNLOCK_ANIM, self._finishMapItemUnlockAnim, self)
end

function Activity142MapItem:_finishMapItemUnlockAnim()
	local cacheKey = string.format("%s_%s", Activity142Enum.MAP_ITEM_CACHE_KEY, self._episodeId)

	Activity142Controller.instance:setPlayedUnlockAni(cacheKey)
	self:_endBlock()
end

function Activity142MapItem:_endBlock(isStar)
	Activity142Helper.setAct142UIBlock(false, (isStar or nil) and Activity142Enum.EPISODE_STAR_UNLOCK)
end

function Activity142MapItem:onDestroy()
	self._episodeId = nil
	self.clickCb = nil
	self.clickCbObj = nil
	self._starItemList = {}

	self:cancelAllTaskDispatcher()
	self:_endBlock()
	self:_endBlock(true)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function Activity142MapItem:cancelAllTaskDispatcher()
	TaskDispatcher.cancelTask(self._delayPlayMapItemUnlockAnim, self)
end

return Activity142MapItem
