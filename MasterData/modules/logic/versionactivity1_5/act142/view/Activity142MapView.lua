-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142MapView.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142MapView", package.seeall)

local Activity142MapView = class("Activity142MapView", BaseView)
local DEFAULT_SELECT_CATEGORY_INDEX = 1

function Activity142MapView:onInitView()
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gotime = gohelper.findChild(self.viewGO, "#go_time")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "#go_time/#txt_remainTime")
	self._gocategory = gohelper.findChild(self.viewGO, "#go_category")
	self._gocategoryitem = gohelper.findChild(self.viewGO, "#go_category/#go_categoryitem")
	self._gomapcontainer = gohelper.findChild(self.viewGO, "#go_mapcontainer")
	self._gomapitem = gohelper.findChild(self.viewGO, "#go_mapcontainer/#go_mapitem")
	self._goMapNode3 = gohelper.findChild(self.viewGO, "#go_mapcontainer/#go_mapnode3")
	self._goMapNodeSP = gohelper.findChild(self.viewGO, "#go_mapcontainer/#go_mapnodesp")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._goRedDotRoot = gohelper.findChild(self.viewGO, "#btn_task/#go_reddotreward")
	self._btncollect = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_collect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity142MapView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btncollect:AddClickListener(self._btncollectOnClick, self)
end

function Activity142MapView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btncollect:RemoveClickListener()
end

function Activity142MapView:_btntaskOnClick()
	ViewMgr.instance:openView(ViewName.Activity142TaskView)
end

function Activity142MapView:_btncollectOnClick()
	local actId = Activity142Model.instance:getActivityId()

	Activity142Rpc.instance:sendGetAct142CollectionsRequest(actId, function()
		Activity142StatController.instance:statCollectionViewStart()
		ViewMgr.instance:openView(ViewName.Activity142CollectView)
	end)
end

function Activity142MapView:_onCategoryItemClick(index, notPlaySwitchAnim)
	if not index or self._selectCategoryIndex == index then
		return
	end

	local selectedCategoryItem = self:getCategoryItemByIndex(index)

	if not selectedCategoryItem then
		return
	end

	if self._selectCategoryIndex then
		local preSelectedCategoryItem = self:getCategoryItemByIndex(self._selectCategoryIndex)

		if preSelectedCategoryItem then
			preSelectedCategoryItem:setIsSelected(false)
		end
	end

	selectedCategoryItem:setIsSelected(true)

	self._selectCategoryIndex = index

	if notPlaySwitchAnim then
		self:_setMapItems()
	else
		self:playViewAnimation(Activity142Enum.MAP_VIEW_SWITCH_ANIM)
		TaskDispatcher.runDelay(self._setMapItems, self, Activity142Enum.MAP_VIEW_SWITCH_SET_MAP_ITEM_ANIM_TIME)
	end
end

function Activity142MapView:_setMapItems()
	if not self._selectCategoryIndex then
		return
	end

	local selectedCategoryItem = self:getCategoryItemByIndex(self._selectCategoryIndex)

	if not selectedCategoryItem then
		return
	end

	local chapterId = selectedCategoryItem:getChapterId()
	local actId = Activity142Model.instance:getActivityId()
	local episodeList = Activity142Config.instance:getChapterEpisodeIdList(actId, chapterId)
	local isSP = Activity142Config.instance:isSPChapter(chapterId)

	for i = 1, Activity142Enum.MAX_EPISODE_SINGLE_CHAPTER do
		local mapItem = self._mapItemList[i]

		if mapItem then
			local isSingle = false

			mapItem:setEpisodeId((isSP and i > Activity142Enum.MAX_EPISODE_SINGLE_SP_CHAPTER or nil) and nil)

			if i == Activity142Enum.MAX_EPISODE_SINGLE_SP_CHAPTER then
				isSingle = isSP

				if isSP then
					if not self._goMapNodeSP then
						local parentGO = self._goMapNode3

						mapItem:setParent(parentGO)
					end
				end
			end

			mapItem:setBg(isSingle)
		end
	end
end

function Activity142MapView:_onMapItemClick(episodeId)
	if not episodeId then
		return
	end

	local actId = Activity142Model.instance:getActivityId()
	local isOpen = Activity142Model.instance:isEpisodeOpen(actId, episodeId)

	if isOpen then
		self._tmpEnterEpisode = episodeId

		self:playViewAnimation(UIAnimationName.Close)
		AudioMgr.instance:trigger(AudioEnum.ui_activity142.CloseMapView)
		TaskDispatcher.runDelay(self._enterEpisode, self, Activity142Enum.CLOSE_MAP_VIEW_TIME)
	else
		Activity142Helper.showToastByEpisodeId(episodeId)
	end
end

function Activity142MapView:_enterEpisode()
	if not self._tmpEnterEpisode then
		self:closeThis()

		return
	end

	Activity142Controller.instance:enterChessGame(self._tmpEnterEpisode)

	self._tmpEnterEpisode = nil
end

function Activity142MapView:_editableInitView()
	self._mapItemList = {}

	for i = 1, Activity142Enum.MAX_EPISODE_SINGLE_CHAPTER do
		local goMapNode = gohelper.findChild(self.viewGO, "#go_mapcontainer/#go_mapnode" .. i)

		if goMapNode then
			local itemGO = gohelper.clone(self._gomapitem, goMapNode, "mapItem" .. i)
			local param = {
				clickCb = self._onMapItemClick,
				clickCbObj = self
			}

			self._mapItemList[#self._mapItemList + 1] = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, Activity142MapItem, param)
		end
	end

	self:_initCategoryItems()
	gohelper.setActive(self._gocategoryitem, false)
	gohelper.setActive(self._gomapitem, false)
	RedDotController.instance:addRedDot(self._goRedDotRoot, RedDotEnum.DotNode.v1a5Activity142TaskReward)
	gohelper.setActive(self._gotime, false)
end

function Activity142MapView:_initCategoryItems()
	self._selectCategoryIndex = nil
	self._categoryItemList = {}

	local autoSelectIndex = DEFAULT_SELECT_CATEGORY_INDEX
	local actId = Activity142Model.instance:getActivityId()
	local chapterList = Activity142Config.instance:getChapterList(actId)

	for index, chapterId in ipairs(chapterList) do
		local itemGO = gohelper.clone(self._gocategoryitem, self._gocategory, "categoryItem" .. chapterId)
		local param = {
			index = index,
			clickCb = self._onCategoryItemClick,
			clickCbObj = self
		}
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, Activity142MapCategoryItem, param)

		item:setChapterId(chapterId)

		self._categoryItemList[index] = item

		local isOpen = Activity142Model.instance:isChapterOpen(chapterId)

		if isOpen and autoSelectIndex < index then
			autoSelectIndex = index
		end
	end

	local defaultCateGoryItem = self:getCategoryItemByIndex(autoSelectIndex)

	if defaultCateGoryItem then
		defaultCateGoryItem:onClick(true)
	end
end

function Activity142MapView:onOpen()
	self:_startRefreshRemainTime()
end

function Activity142MapView:onSetVisible(visible)
	if not visible then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.ui_activity142.OpenMapView)
	self:refresh(Activity142Enum.OPEN_MAP_VIEW_TIME)
end

function Activity142MapView:refresh(unlockAnimDelayTime)
	self:_refreshCategoryItems()
	self:_refreshMapItems(unlockAnimDelayTime)
end

function Activity142MapView:_refreshCategoryItems()
	for _, categoryItem in ipairs(self._categoryItemList) do
		categoryItem:refresh()
	end
end

function Activity142MapView:_refreshMapItems(unlockAnimDelayTime)
	for _, mapItem in ipairs(self._mapItemList) do
		mapItem:refresh(unlockAnimDelayTime)
	end
end

function Activity142MapView:_startRefreshRemainTime()
	self:_refreshRemainTime()
	TaskDispatcher.runRepeat(self._refreshRemainTime, self, TimeUtil.OneMinuteSecond)
end

function Activity142MapView:_refreshRemainTime()
	if gohelper.isNil(self._txtremainTime) then
		TaskDispatcher.cancelTask(self._refreshRemainTime, self)

		return
	end

	local actId = Activity142Model.instance:getActivityId()

	self._txtremainTime.text = Activity142Model.instance:getRemainTimeStr(actId)
end

function Activity142MapView:playViewAnimation(aniName, cb, cbObj)
	if self._animatorPlayer then
		Activity142Helper.setAct142UIBlock(true, Activity142Enum.PLAY_MAP_VIEW_ANIM)
		self._animatorPlayer:Play(aniName, self.playViewAnimationFinish, self)

		self._tmpAnimCb = cb
		self._tmpAnimCbObj = cbObj
	elseif cb then
		cb(cbObj)
	end
end

function Activity142MapView:playViewAnimationFinish()
	if self._tmpAnimCb then
		self._tmpAnimCb(self._tmpAnimCbObj)
	end

	self._tmpAnimCb = nil
	self._tmpAnimCbObj = nil

	Activity142Helper.setAct142UIBlock(false, Activity142Enum.PLAY_MAP_VIEW_ANIM)
end

function Activity142MapView:getCategoryItemByIndex(index)
	local categoryItem

	if self._categoryItemList then
		categoryItem = self._categoryItemList[index]
	end

	if not categoryItem then
		logError("Activity142MapView:getCategoryItemByIndex error, can't find category item, index:", index or "nil")
	end

	return categoryItem
end

function Activity142MapView:onClose()
	TaskDispatcher.cancelTask(self._setMapItems, self)
	TaskDispatcher.cancelTask(self._refreshRemainTime, self)
	TaskDispatcher.cancelTask(self._enterEpisode, self)
end

function Activity142MapView:onDestroyView()
	self._selectCategoryIndex = nil
	self._categoryItemList = {}
	self._mapItemList = {}
	self._tmpAnimCb = nil
	self._tmpAnimCbObj = nil

	Activity142Helper.setAct142UIBlock(false, Activity142Enum.PLAY_MAP_VIEW_ANIM)
end

return Activity142MapView
