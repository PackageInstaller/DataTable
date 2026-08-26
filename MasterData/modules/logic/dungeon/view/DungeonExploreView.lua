-- chunkname: @modules/logic/dungeon/view/DungeonExploreView.lua

module("modules.logic.dungeon.view.DungeonExploreView", package.seeall)

local DungeonExploreView = class("DungeonExploreView", BaseView)

function DungeonExploreView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._gochapteritem = gohelper.findChild(self.viewGO, "left/mask/#scroll_level/Viewport/Content/#go_levelitem")
	self._golevelitem = gohelper.findChild(self.viewGO, "right/contain/level/#go_levelitem")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "right/contain/#btn_start")
	self._btnbook = gohelper.findChildButtonWithAudio(self.viewGO, "right/contain/#btn_book", AudioEnum.UI.play_ui_leimi_biguncharted_open)
	self._gobookred = gohelper.findChild(self.viewGO, "right/contain/#btn_book/#go_bookreddot")
	self._gofullbooknum = gohelper.findChild(self.viewGO, "right/contain/#btn_book/full")
	self._gounfullbooknum = gohelper.findChild(self.viewGO, "right/contain/#btn_book/unfull")
	self._txtfullbooknum = gohelper.findChildTextMesh(self.viewGO, "right/contain/#btn_book/full/#txt_num")
	self._txtunfullbooknum = gohelper.findChildTextMesh(self.viewGO, "right/contain/#btn_book/unfull/#txt_num")
	self._txtrewarddesc = gohelper.findChildTextMesh(self.viewGO, "right/contain/progress/curprogress")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "right/contain/progress/curprogress/#btn_detail")
	self._goRewardRed = gohelper.findChild(self.viewGO, "right/contain/progress/curprogress/#btn_detail/#go_reddot")
	self._simagedecorate = gohelper.findChildSingleImage(self.viewGO, "right/contain/#simage_decorate")
	self._txtlevelname = gohelper.findChildTextMesh(self.viewGO, "right/contain/#txt_levelname")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "right/contain/#txt_desc")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonExploreView:addEvents()
	ExploreController.instance:registerCallback(ExploreEvent.OnChapterClick, self.onChapterClick, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnLevelClick, self.onLevelClick, self)
	ExploreController.instance:registerCallback(ExploreEvent.TaskUpdate, self.onTaskUpdate, self)
	self._btnstart:AddClickListener(self._clickStart, self)
	self._btnbook:AddClickListener(self._clickBook, self)
end

function DungeonExploreView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnbook:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnChapterClick, self.onChapterClick, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnLevelClick, self.onLevelClick, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.TaskUpdate, self.onTaskUpdate, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function DungeonExploreView:_editableInitView()
	self._chapterProcess = {}

	for i = 1, 3 do
		self._chapterProcess[i] = self:getUserDataTb_()
		self._chapterProcess[i].go = gohelper.findChild(self.viewGO, "right/contain/progress/list/#go_progressitem" .. i)
		self._chapterProcess[i].bg = gohelper.findChildImage(self._chapterProcess[i].go, "bg")
		self._chapterProcess[i].dark = gohelper.findChild(self._chapterProcess[i].go, "dark")
		self._chapterProcess[i].light = gohelper.findChild(self._chapterProcess[i].go, "light")
		self._chapterProcess[i].progress = gohelper.findChildTextMesh(self._chapterProcess[i].go, "txt_progress")
		self._chapterProcess[i].unlockEffect = gohelper.findChild(self._chapterProcess[i].go, "click_light")
		self._chapterProcess[i].red = gohelper.findChild(self._chapterProcess[i].go, "#go_reddot")

		local btn = gohelper.findButtonWithAudio(self._chapterProcess[i].go)

		self.addClickCb(self, btn, self._clickReward, self, i)
	end
end

function DungeonExploreView:_onCloseView(viewName)
	if viewName == ViewName.LoadingView then
		self:onShow()
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	end
end

function DungeonExploreView:onOpen()
	self:onShow()
end

function DungeonExploreView:onShow()
	gohelper.setActive(self.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_ilbn_open)
	ExploreSimpleModel.instance:setDelaySave(true)
	self:initChapterList()

	self._selectChapterIndex, self._selectLevelIndex = ExploreSimpleModel.instance:getChapterIndex(ExploreSimpleModel.instance:getLastSelectMap())

	ExploreController.instance:dispatchEvent(ExploreEvent.OnChapterClick, self._selectChapterIndex or 1)

	self._selectChapterIndex = nil
	self._selectLevelIndex = nil

	ExploreSimpleModel.instance:setDelaySave(false)
	self._anim:Play("open", 0, 0)
	self._anim:Update(0)
end

function DungeonExploreView:onUpdateParam()
	return
end

function DungeonExploreView:_clickBook()
	gohelper.setActive(self._gobookred, false)
	ViewMgr.instance:openView(ViewName.ExploreArchivesView, {
		id = self._chapterCo.id
	})
end

function DungeonExploreView:_clickReward(index)
	if index == 3 then
		ViewMgr.instance:openView(ViewName.ExploreBonusRewardView, self._chapterCo)
	else
		ViewMgr.instance:openView(ViewName.ExploreRewardView, self._chapterCo)
	end
end

function DungeonExploreView:onTaskUpdate()
	gohelper.setActive(self._chapterProcess[1].red, ExploreSimpleModel.instance:getTaskRed(self._chapterCo.id, ExploreEnum.CoinType.PurpleCoin))
	gohelper.setActive(self._chapterProcess[2].red, ExploreSimpleModel.instance:getTaskRed(self._chapterCo.id, ExploreEnum.CoinType.GoldCoin))
end

function DungeonExploreView:onChapterClick(index)
	local chapterCo = self._chapterCoList[index]

	if self._chapterCo == chapterCo then
		return
	end

	if self._nowIndex ~= index then
		local isFirst = not self._nowIndex

		self._nowIndex = index

		if not isFirst then
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)

			self._anim.enabled = true

			self._anim:Play("switch", 0, 0)
			self._anim:Update(0)
			TaskDispatcher.runDelay(self._delayRefreshView, self, 0)
		else
			self:_refreshChapterInfo(index)
		end
	end
end

function DungeonExploreView:_delayRefreshView()
	self:_refreshChapterInfo(self._nowIndex)
end

function DungeonExploreView:_refreshChapterInfo(index)
	local chapterCo = self._chapterCoList[index]

	self._chapterCo = chapterCo
	self._episodeCoList = DungeonConfig.instance:getChapterEpisodeCOList(chapterCo.id)
	self._levelList = self._levelList or {}

	gohelper.CreateObjList(self, self._onLevelItemLoad, self._episodeCoList, self._golevelitem.transform.parent.gameObject, self._golevelitem, DungeonExploreLevelItem)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnLevelClick, self._selectLevelIndex or 1)

	if ExploreSimpleModel.instance:isChapterFinish(chapterCo.id) then
		if not ("level/levelbg" .. index .. "_1") then
			local bg = "level/levelbg" .. index

			self._simagelevelbg:LoadImage(ResUrl.getExploreBg(bg))
			self._simagedecorate:LoadImage(ResUrl.getExploreBg("dungeon_secretroom_img_title" .. index))
			gohelper.setActive(self._gobookred, ExploreSimpleModel.instance:getHaveNewArchive(chapterCo.id))
			gohelper.setActive(self._goRewardRed, ExploreSimpleModel.instance:getTaskRed(chapterCo.id))

			local name = chapterCo.name
			local len = GameUtil.utf8len(name)
			local showName

			if len >= 2 then
				local first = GameUtil.utf8sub(name, 1, 1)
				local center = GameUtil.utf8sub(name, 2, len - 2)
				local last = GameUtil.utf8sub(name, len, 1)

				showName = string.format("<size=86>%s</size>%s<size=86>%s</size>", first, center, last)
			else
				showName = "<size=86>" .. name
			end

			self._txtlevelname.text = showName
			self._txtdesc.text = chapterCo.desc

			local bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal = ExploreSimpleModel.instance:getChapterCoinCount(chapterCo.id)
			local isAllFull = ExploreSimpleModel.instance:isChapterCoinFull(chapterCo.id)
			local bonusFull = bonusNum == bonusNumTotal
			local goldCoinFull = goldCoin == goldCoinTotal
			local purpleCoinFull = purpleCoin == purpleCoinTotal

			for i = 1, 3 do
				UISpriteSetMgr.instance:setExploreSprite(self._chapterProcess[i].bg, isAllFull and "dungeon_secretroom_img_full" or "dungeon_secretroom_img_unfull")
			end

			gohelper.setActive(self._chapterProcess[1].dark, not purpleCoinFull)
			gohelper.setActive(self._chapterProcess[1].light, purpleCoinFull)
			gohelper.setActive(self._chapterProcess[2].dark, not goldCoinFull)
			gohelper.setActive(self._chapterProcess[2].light, goldCoinFull)
			gohelper.setActive(self._chapterProcess[3].dark, not bonusFull)
			gohelper.setActive(self._chapterProcess[3].light, bonusFull)

			self._txtrewarddesc.text = isAllFull and luaLang("explore_collect_full") or luaLang("explore_collect")

			local chapterMo = ExploreSimpleModel.instance:getChapterMo(self._chapterCo.id)
			local nowCount = chapterMo and tabletool.len(chapterMo.archiveIds) or 0
			local totalCount = ExploreConfig.instance:getArchiveTotalCount(self._chapterCo.id)

			self._txtfullbooknum.text = nowCount .. "/" .. totalCount
			self._txtunfullbooknum.text = nowCount .. "/" .. totalCount

			gohelper.setActive(self._gofullbooknum, totalCount <= nowCount)
			gohelper.setActive(self._gounfullbooknum, nowCount < totalCount)

			self._chapterProcess[1].progress.text = string.format("%d/%d", purpleCoin, purpleCoinTotal)
			self._chapterProcess[2].progress.text = string.format("%d/%d", goldCoin, goldCoinTotal)
			self._chapterProcess[3].progress.text = string.format("%d/%d", bonusNum, bonusNumTotal)

			self:_hideUnlockEffect()

			local haveUnlockShow = false

			if bonusFull and not ExploreSimpleModel.instance:getCollectFullIsShow(chapterCo.id, ExploreEnum.CoinType.Bonus) then
				ExploreSimpleModel.instance:markCollectFullIsShow(chapterCo.id, ExploreEnum.CoinType.Bonus)
				gohelper.setActive(self._chapterProcess[3].unlockEffect, true)

				haveUnlockShow = true
			end

			if goldCoinFull and not ExploreSimpleModel.instance:getCollectFullIsShow(chapterCo.id, ExploreEnum.CoinType.GoldCoin) then
				ExploreSimpleModel.instance:markCollectFullIsShow(chapterCo.id, ExploreEnum.CoinType.GoldCoin)
				gohelper.setActive(self._chapterProcess[2].unlockEffect, true)

				haveUnlockShow = true
			end

			if purpleCoinFull and not ExploreSimpleModel.instance:getCollectFullIsShow(chapterCo.id, ExploreEnum.CoinType.PurpleCoin) then
				ExploreSimpleModel.instance:markCollectFullIsShow(chapterCo.id, ExploreEnum.CoinType.PurpleCoin)
				gohelper.setActive(self._chapterProcess[1].unlockEffect, true)

				haveUnlockShow = true
			end

			TaskDispatcher.cancelTask(self._hideUnlockEffect, self)

			if haveUnlockShow then
				TaskDispatcher.runDelay(self._hideUnlockEffect, self, 1.8)
			end

			self:onTaskUpdate()
		end
	end
end

function DungeonExploreView:_hideUnlockEffect()
	if not self._chapterProcess then
		return
	end

	for i = 1, 3 do
		gohelper.setActive(self._chapterProcess[i].unlockEffect, false)
	end
end

function DungeonExploreView:onLevelClick(index)
	if self._curEpisodeCo then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	end

	self._curEpisodeCo = self._episodeCoList[index]

	ExploreSimpleModel.instance:setLastSelectMap(self._curEpisodeCo.chapterId, self._curEpisodeCo.id)
end

function DungeonExploreView:_clickStart()
	local mapCo = lua_explore_scene.configDict[self._curEpisodeCo.chapterId][self._curEpisodeCo.id]

	ExploreController.instance:enterExploreScene(mapCo.id)
end

function DungeonExploreView:initChapterList()
	self._chapterCoList = DungeonConfig.instance:getExploreChapterList()
	self._chapterList = {}

	gohelper.CreateObjList(self, self._onChapterItemLoad, self._chapterCoList, self._gochapteritem.transform.parent.gameObject, self._gochapteritem, DungeonExploreChapterItem)
end

function DungeonExploreView:_onChapterItemLoad(obj, data, index)
	obj:setData(data, index)

	self._chapterList[index] = obj
end

function DungeonExploreView:_onLevelItemLoad(obj, data, index)
	obj:setData(data, index, index == #self._episodeCoList)

	self._levelList[index] = obj
end

function DungeonExploreView:onHide(callback, callbackobj)
	if ExploreModel.instance.isJumpToExplore then
		ExploreModel.instance.isJumpToExplore = false

		ViewMgr.instance:closeView(ViewName.DungeonView)

		return
	end

	if self._anim then
		self._anim:Play("close", 0, 0)
	end

	self._closeCallBack = callback
	self._closeCallBackObj = callbackobj

	UIBlockMgr.instance:startBlock("DungeonExploreView_Close")
	TaskDispatcher.runDelay(self._onCloseAnimEnd, self, 0.167)
	TaskDispatcher.cancelTask(self._hideUnlockEffect, self)
end

function DungeonExploreView:_onCloseAnimEnd()
	UIBlockMgr.instance:endBlock("DungeonExploreView_Close")

	if self._closeCallBack then
		self._closeCallBack(self._closeCallBackObj)
	end
end

function DungeonExploreView:onClose()
	self:onHide()
end

function DungeonExploreView:onDestroyView()
	TaskDispatcher.cancelTask(self._onCloseAnimEnd, self)
	UIBlockMgr.instance:endBlock("DungeonExploreView_Close")
	TaskDispatcher.cancelTask(self._delayRefreshView, self)

	for _, v in pairs(self._chapterList) do
		v:destroy()
	end

	for _, v in pairs(self._levelList) do
		v:destroy()
	end

	self._simagelevelbg:UnLoadImage()
	self._simagedecorate:UnLoadImage()
end

return DungeonExploreView
