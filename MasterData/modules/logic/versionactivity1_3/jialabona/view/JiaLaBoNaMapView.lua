-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaMapView.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapView", package.seeall)

local JiaLaBoNaMapView = class("JiaLaBoNaMapView", BaseView)

function JiaLaBoNaMapView:onInitView()
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "LeftTop/#simage_Title")
	self._btnRewardBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightTop/#btn_RewardBtn")
	self._goreddotreward = gohelper.findChild(self.viewGO, "RightTop/#go_reddotreward")
	self._golockNextPoint = gohelper.findChild(self.viewGO, "Map/Path1/#go_lockNextPoint")
	self._golockNext = gohelper.findChild(self.viewGO, "Map/Path1/#go_lockNext")
	self._btnLockNext = gohelper.findChildButtonWithAudio(self.viewGO, "Map/Path1/#go_lockNext/#btn_LockNext")
	self._goNextBtn = gohelper.findChild(self.viewGO, "Map/Path1/#go_NextBtn")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "Map/Path1/#go_NextBtn/#btn_Next")
	self._goPreviousBtn = gohelper.findChild(self.viewGO, "Map/Path2/#go_PreviousBtn")
	self._btnPrevious = gohelper.findChildButtonWithAudio(self.viewGO, "Map/Path2/#go_PreviousBtn/Root/#btn_Previous")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function JiaLaBoNaMapView:addEvents()
	self._btnRewardBtn:AddClickListener(self._btnRewardBtnOnClick, self)
	self._btnLockNext:AddClickListener(self._btnLockNextOnClick, self)
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
	self._btnPrevious:AddClickListener(self._btnPreviousOnClick, self)
end

function JiaLaBoNaMapView:removeEvents()
	self._btnRewardBtn:RemoveClickListener()
	self._btnLockNext:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnPrevious:RemoveClickListener()
end

function JiaLaBoNaMapView:_btnRewardBtnOnClick()
	ViewMgr.instance:openView(ViewName.JiaLaBoNaTaskView)
end

function JiaLaBoNaMapView:_btnLockNextOnClick()
	if self:_isOpenByChapterId(JiaLaBoNaEnum.Chapter.Two) then
		return
	end

	local episodeCfg = JiaLaBoNaHelper.getFristEpisodeCoByChapterId(JiaLaBoNaEnum.Chapter.Two)

	if not episodeCfg then
		logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s chapterId:%s", VersionActivity1_3Enum.ActivityId.Act306, JiaLaBoNaEnum.Chapter.Two))

		return
	end

	JiaLaBoNaHelper.showToastByEpsodeId(episodeCfg.id, true)
end

function JiaLaBoNaMapView:_btnNextOnClick()
	if self:_isOpenByChapterId(JiaLaBoNaEnum.Chapter.Two) then
		self:_delaySwitchPage(JiaLaBoNaEnum.Chapter.Two)
		AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_chapter_switch)
	end
end

function JiaLaBoNaMapView:_btnPreviousOnClick()
	self:_delaySwitchPage(JiaLaBoNaEnum.Chapter.One)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_chapter_switch)
end

function JiaLaBoNaMapView:_delaySwitchPage(page)
	if self.viewContainer then
		self.viewContainer:switchScene(page == JiaLaBoNaEnum.Chapter.Two)

		self._delayPage = page

		TaskDispatcher.cancelTask(self._onDelaySwitchPage, self)
		TaskDispatcher.runDelay(self._onDelaySwitchPage, self, 0.5)
	end
end

function JiaLaBoNaMapView:_onDelaySwitchPage(page)
	self:_onShiwchPage(self._delayPage)
end

function JiaLaBoNaMapView:_editableInitView()
	self._Path1GO = gohelper.findChild(self.viewGO, "Map/Path1")
	self._Path2GO = gohelper.findChild(self.viewGO, "Map/Path2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "Map/image_Mask")
	self._simageMainPath1 = gohelper.findChildSingleImage(self.viewGO, "Map/Path1/image_MainPath1")
	self._simageBranchPath1_1 = gohelper.findChildSingleImage(self.viewGO, "Map/Path1/image_BranchPath1_1")
	self._simageBranchPath1_2 = gohelper.findChildSingleImage(self.viewGO, "Map/Path1/image_BranchPath1_2")
	self._simageMainPath2 = gohelper.findChildSingleImage(self.viewGO, "Map/Path2/image_MainPath2")
	self._simageBranchPath2_1 = gohelper.findChildSingleImage(self.viewGO, "Map/Path2/#image_BranchPath2_1")
	self._simageBranchPath2_2 = gohelper.findChildSingleImage(self.viewGO, "Map/Path2/#image_BranchPath2_2")

	self._simagemask:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	self._simageMainPath1:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapmainpath_1"))
	self._simageBranchPath1_1:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_1_1"))
	self._simageBranchPath1_2:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_1_2"))
	self._simageMainPath2:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapmainpath_2"))
	self._simageBranchPath2_1:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_2_1"))
	self._simageBranchPath2_2:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_og_mapbranchpath_2_2"))
	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.Activity1_3RedDotAct120)
end

function JiaLaBoNaMapView:onUpdateParam()
	return
end

function JiaLaBoNaMapView:onOpen()
	self.addEventCb(self, JiaLaBoNaController.instance, JiaLaBoNaEvent.Refresh120MapData, self._onRefreshMapData, self)
	self.addEventCb(self, JiaLaBoNaController.instance, JiaLaBoNaEvent.SelectEpisode, self._onSelectEpisode, self)
	self.addEventCb(self, JiaLaBoNaController.instance, JiaLaBoNaEvent.ClearNewEpisode, self._onClearNewEpisode, self)
	self:_initStages()

	local chapterId = self:_getSelectChapterId() or JiaLaBoNaEnum.Chapter.One

	self:_refreshStageItemList()
	self:_refreshSelectStageItem()
	self:_onShiwchPage(chapterId, UIAnimationName.Open)
	self:_refreshUI()

	local isOpen, cdTime = JiaLaBoNaHelper.isOpenChapterDay(JiaLaBoNaEnum.Chapter.Two)

	if not isOpen and cdTime and cdTime > 0 then
		TaskDispatcher.runDelay(self._onCDCharpterOpen, self, cdTime)
	end
end

function JiaLaBoNaMapView:_onRefreshMapData()
	if self._clrearNewEpisodeId then
		if self._canPlayNewEpisodeTime <= Time.time then
			if self.viewContainer and self.viewContainer.playPathAnim then
				self.viewContainer:playPathAnim()
			end

			local item = self:_getStageItemById(self._clrearNewEpisodeId)

			if item then
				item:refreshUI(true)
				AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_pass)
			end

			TaskDispatcher.cancelTask(self._onDelayReshMapData, self)
			TaskDispatcher.runDelay(self._onDelayReshMapData, self, JiaLaBoNaEnum.AnimatorTime.ChapterPath)
			self.viewContainer:refreshInteract(self._clrearNewEpisodeId)
		end
	else
		self:_refreshStageItemList()
		self:_refreshUI()
	end
end

function JiaLaBoNaMapView:_onDelayReshMapData()
	local item = self:_getStageItemById(self._clrearNewEpisodeId, true)

	self._clrearNewEpisodeId = nil

	if item then
		if JiaLaBoNaHelper.isOpenDay(item:getCfgId()) then
			AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_unlock)

			local chapterId = item:getCfgChapterId()

			if chapterId ~= self._curChapterId then
				self.viewContainer:refreshPathPoin()
				self:_onShiwchPage(chapterId)
			end
		end

		item:refreshUI(true)
	end

	self:_refreshUI()
end

function JiaLaBoNaMapView:_onSelectEpisode()
	local chapterId = self:_getSelectChapterId()

	if chapterId and chapterId ~= self._curChapterId then
		self:_onShiwchPage(chapterId)
	end

	self:_refreshSelectStageItem()
end

function JiaLaBoNaMapView:_onClearNewEpisode(episodeId)
	if episodeId then
		self._clrearNewEpisodeId = episodeId
		self._canPlayNewEpisodeTime = Time.time + JiaLaBoNaEnum.AnimatorTime.MapViewOpen - 0.05

		TaskDispatcher.cancelTask(self._onRefreshMapData, self)
		TaskDispatcher.runDelay(self._onRefreshMapData, self, JiaLaBoNaEnum.AnimatorTime.MapViewOpen)

		local item = self:_getStageItemById(self._clrearNewEpisodeId)

		if item then
			item:_unLockUI()
		end

		local lockItem = self:_getStageItemById(self._clrearNewEpisodeId, true)

		if lockItem then
			lockItem:_lockUI()
		end
	end
end

function JiaLaBoNaMapView:_onCDCharpterOpen()
	if not self._clrearNewEpisodeId then
		self:_refreshStageItemList()
		self:_refreshUI()
	end
end

function JiaLaBoNaMapView:_onShiwchPage(chapterId, playAnim)
	self._curChapterId = chapterId

	gohelper.setActive(self._Path1GO, chapterId ~= JiaLaBoNaEnum.Chapter.Two)
	gohelper.setActive(self._Path2GO, chapterId == JiaLaBoNaEnum.Chapter.Two)

	if self.viewContainer and self.viewContainer.switchPage then
		self.viewContainer:switchPage(chapterId, playAnim)
	end
end

function JiaLaBoNaMapView:_initStages()
	if self._stageItemList then
		return
	end

	local prefabPath = JiaLaBoNaMapViewStageItem.prefabPath
	local pathGOs = {
		self._Path1GO,
		self._Path2GO
	}

	self._stageItemList = {}

	for _, pGo in ipairs(pathGOs) do
		for i = 1, 4 do
			local cloneGo = self:getResInst(prefabPath, gohelper.findChild(pGo, string.format("#go_Stage%s", i)))
			local stageItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, JiaLaBoNaMapViewStageItem, self)

			stageItem:setStageType((i < 5 or nil) and (JiaLaBoNaEnum.StageType.Main or JiaLaBoNaEnum.StageType.Branch))
			table.insert(self._stageItemList, stageItem)
		end
	end

	local actId = VersionActivity1_3Enum.ActivityId.Act306

	self._episodeCfgList, self._chapterIdList = Activity120Config.instance:getEpisodeList(actId)

	for i, episodeCfg in ipairs(self._episodeCfgList) do
		self._stageItemList[i]:setCfg(episodeCfg)
	end
end

function JiaLaBoNaMapView:_getSelectChapterId()
	if not self._episodeCfgList or #self._episodeCfgList < 1 then
		return
	end

	local tActivity120Model = Activity120Model.instance
	local episodeId = tActivity120Model:getCurEpisodeId()

	if episodeId then
		::label_20_0::

		local episodeCfg = Activity120Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act306, episodeId)

		if episodeCfg and JiaLaBoNaHelper.isOpenDay(episodeId) then
			return episodeCfg.chapterId
		end

		local selectCfg = self._episodeCfgList[1]

		for _, episodeCfg in ipairs(self._episodeCfgList) do
			if tActivity120Model:isEpisodeClear(episodeCfg.id) then
				selectCfg = episodeCfg
			else
				if JiaLaBoNaHelper.isOpenDay(episodeCfg.id) then
					selectCfg = episodeCfg
				end

				break
			end
		end

		if selectCfg then
			tActivity120Model:setCurEpisodeId(selectCfg.id)

			return selectCfg.chapterId
		end
	end
end

function JiaLaBoNaMapView:_isCanShowChapter(chapterId)
	local episodeCfg = JiaLaBoNaHelper.getFristEpisodeCoByChapterId(chapterId)

	if episodeCfg then
		local tActivity120Model = Activity120Model.instance

		if tActivity120Model:isEpisodeClear(episodeCfg.id) or episodeCfg.preEpisode == 0 or tActivity120Model:isEpisodeClear(episodeCfg.preEpisode) then
			return true
		end
	end

	return false
end

function JiaLaBoNaMapView:_isOpenByChapterId(chapterId)
	return JiaLaBoNaHelper.isOpenChapterDay(chapterId, false)
end

function JiaLaBoNaMapView:_refreshUI()
	local isNextOpen, cdTime = self:_isOpenByChapterId(JiaLaBoNaEnum.Chapter.Two)

	gohelper.setActive(self._golockNext, not isNextOpen)
	gohelper.setActive(self._goNextBtn, isNextOpen)
	gohelper.setActive(self._golockNextPoint, not isNextOpen)
end

function JiaLaBoNaMapView:_getStageItemById(episodeId, isPre)
	for i = 1, #self._stageItemList do
		local item = self._stageItemList[i]

		if isPre then
			if item:getCfgPreId() == episodeId then
				return item
			end
		elseif item:getCfgId() == episodeId then
			return item
		end
	end
end

function JiaLaBoNaMapView:_refreshStageItemList()
	for i = 1, #self._stageItemList do
		local item = self._stageItemList[i]

		item:refreshUI()
	end
end

function JiaLaBoNaMapView:_refreshSelectStageItem()
	for i = 1, #self._stageItemList do
		self._stageItemList[i]:onSelect()
	end
end

function JiaLaBoNaMapView:onClose()
	TaskDispatcher.cancelTask(self._onDelaySwitchPage, self)
	TaskDispatcher.cancelTask(self._onDelayReshMapData, self)
	TaskDispatcher.cancelTask(self._onRefreshMapData, self)
	TaskDispatcher.cancelTask(self._onCDCharpterOpen, self)
end

function JiaLaBoNaMapView:onDestroyView()
	if self._stageItemList then
		for _, stageItem in ipairs(self._stageItemList) do
			stageItem:onDestroyView()
		end

		self._stageItemList = nil
	end

	self._simagemask:UnLoadImage()
	self._simageMainPath1:UnLoadImage()
	self._simageBranchPath1_1:UnLoadImage()
	self._simageBranchPath1_2:UnLoadImage()
	self._simageMainPath2:UnLoadImage()
	self._simageBranchPath2_1:UnLoadImage()
	self._simageBranchPath2_2:UnLoadImage()
end

return JiaLaBoNaMapView
