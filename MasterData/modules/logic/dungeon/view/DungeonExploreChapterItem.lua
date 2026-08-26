-- chunkname: @modules/logic/dungeon/view/DungeonExploreChapterItem.lua

module("modules.logic.dungeon.view.DungeonExploreChapterItem", package.seeall)

local DungeonExploreChapterItem = class("DungeonExploreChapterItem", LuaCompBase)

function DungeonExploreChapterItem:init(go)
	self._imageselectlevel = gohelper.findChildImage(go, "#go_selected/image_level")
	self._imageunselectlevel = gohelper.findChildImage(go, "#go_unselected/image_level")
	self._goselected = gohelper.findChild(go, "#go_selected")
	self._gounselected = gohelper.findChild(go, "#go_unselected")
	self._golocked = gohelper.findChild(go, "#go_locked")
	self._btnclick = gohelper.findChildButton(go, "#btn_click")
	self._txtselectname = gohelper.findChildTextMesh(go, "#go_selected/txt_levelname")
	self._txtselectnameEn = gohelper.findChildTextMesh(go, "#go_selected/Text")
	self._txtunselectname = gohelper.findChildTextMesh(go, "#go_unselected/txt_levelname")
	self._gonew = gohelper.findChild(go, "#go_unselected/go_unselectednew")
	self._goselectStar = gohelper.findChild(go, "#go_selected/#simage_star")
	self._gounselectStar = gohelper.findChild(go, "#go_unselected/#simage_star")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._goRed1 = gohelper.findChild(go, "#go_selected/#go_red")
	self._goRed2 = gohelper.findChild(go, "#go_unselected/#go_red")

	self._btnclick:AddClickListener(self._click, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnChapterClick, self.onChapterClick, self)
end

function DungeonExploreChapterItem:setData(config, index)
	self._index = index
	self._config = config
	self._txtselectname.text = config.name
	self._txtunselectname.text = config.name
	self._txtselectnameEn.text = config.name_En

	UISpriteSetMgr.instance:setExploreSprite(self._imageselectlevel, "dungeon_secretroom_img_select" .. tostring(index))
	UISpriteSetMgr.instance:setExploreSprite(self._imageunselectlevel, "dungeon_secretroom_img_unselect" .. tostring(index))

	local isChapterFull = ExploreSimpleModel.instance:isChapterCoinFull(config.id)
	local isLock = not ExploreSimpleModel.instance:getChapterIsUnLock(config.id)
	local isShowUnlock = true

	if not isLock then
		isShowUnlock = ExploreSimpleModel.instance:getChapterIsShowUnlock(config.id)
	end

	gohelper.setActive(self._gonew, not isChapterFull and ExploreSimpleModel.instance:getChapterIsNew(config.id))
	gohelper.setActive(self._goselectStar, isChapterFull)
	gohelper.setActive(self._gounselectStar, isChapterFull)
	gohelper.setActive(self._golocked, isLock)

	if not isShowUnlock then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
		ExploreSimpleModel.instance:markChapterShowUnlock(config.id)
		gohelper.setActive(self._golocked, true)
		gohelper.setActive(self._gounselected, true)

		self._showingUnlock = true

		TaskDispatcher.runDelay(self._unlockFinish, self, 1.3)
		self._anim:Play("unlock", 0, 0)
	else
		self._showingUnlock = false

		TaskDispatcher.cancelTask(self._unlockFinish, self)
		self._anim:Play("idle", 0, 0)
	end

	ExploreSimpleModel.instance:markChapterNew(self._config.id)

	self._isLock = isLock

	local str = "Explore_Chapter" .. self._index

	RedDotController.instance:addRedDot(self._goRed1, RedDotEnum.DotNode[str])
	RedDotController.instance:addRedDot(self._goRed2, RedDotEnum.DotNode[str])
end

function DungeonExploreChapterItem:_unlockFinish()
	self._showingUnlock = false

	gohelper.setActive(self._golocked, false)
	TaskDispatcher.cancelTask(self._unlockFinish, self)
	self._anim:Play("idle", 0, 0)
end

function DungeonExploreChapterItem:_click()
	if self._isLock then
		local episodeCo = DungeonConfig.instance:getChapterEpisodeCOList(self._config.id)[1]
		local preEpisodeCo = episodeCo and lua_episode.configDict[episodeCo.preEpisode]
		local preChapterName, preEpisodeName = "", ""

		if preEpisodeCo then
			local chapterCo = lua_chapter.configDict[preEpisodeCo.chapterId]

			preChapterName = chapterCo.name
			preEpisodeName = preEpisodeCo.name
		end

		GameFacade.showToast(ExploreConstValue.Toast.ExploreChapterLock, preChapterName, preEpisodeName)

		return
	end

	gohelper.setActive(self._gonew, false)
	ExploreSimpleModel.instance:markChapterNew(self._config.id)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnChapterClick, self._index)
end

function DungeonExploreChapterItem:onChapterClick(index)
	gohelper.setActive(self._goselected, index == self._index and not self._isLock)
	gohelper.setActive(self._gounselected, index ~= self._index and not self._isLock)

	if index == self._index then
		gohelper.setActive(self._gonew, false)
	end

	if index == self._index and not self._isLock and self._showingUnlock then
		self:_unlockFinish()
	end
end

function DungeonExploreChapterItem:destroy()
	self:_unlockFinish()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnChapterClick, self.onChapterClick, self)
	self._btnclick:RemoveClickListener()

	self._index = 0
	self._config = nil
	self._goselected = nil
	self._gounselected = nil
	self._btnclick = nil
	self._txtselectname = nil
	self._txtunselectname = nil
end

return DungeonExploreChapterItem
