-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_StoryCollectView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryCollectView", package.seeall)

local VersionActivity_1_2_StoryCollectView = class("VersionActivity_1_2_StoryCollectView", BaseViewExtended)
local stroyFinalShowGuideId = 12110

function VersionActivity_1_2_StoryCollectView:onInitView()
	self._simagebookbg1 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bookbg1")
	self._simagebookbg2 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bookbg2")
	self._simagebookbg3 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bookbg3")
	self._simagebookbg4 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bookbg4")
	self._simagebookbg5 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bookbg1/#simage_bookbg5")
	self._simageleftbookbg5 = gohelper.findChildSingleImage(self.viewGO, "root/left/#simage_bookbg5")
	self._simagebookbg6 = gohelper.findChildSingleImage(self.viewGO, "root/left/#simage_bookbg6")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/left/title/#simage_title")
	self._txttitleName = gohelper.findChildText(self.viewGO, "root/left/title/#txt_titleName")
	self._gofinishIcon = gohelper.findChild(self.viewGO, "root/left/title/#txt_titleName/#go_finishIcon")
	self._txttitleIndex = gohelper.findChildText(self.viewGO, "root/left/title/#txt_titleIndex")
	self._goleftNoteContent = gohelper.findChild(self.viewGO, "root/left/#go_leftNoteContent")
	self._gocategory = gohelper.findChild(self.viewGO, "root/left/#go_category")
	self._gocategoryItem = gohelper.findChild(self.viewGO, "root/left/#go_category/#go_categoryItem")
	self._gorightNoteContent = gohelper.findChild(self.viewGO, "root/right/#go_rightNoteContent")
	self._gorightEmpty = gohelper.findChild(self.viewGO, "root/right/#go_rightEmpty")
	self._gocollectReward = gohelper.findChild(self.viewGO, "root/right/collect/rewardItem/#go_collectReward")
	self._txtequiplv = gohelper.findChildText(self.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/#txt_equiplv")
	self._goequipcareer = gohelper.findChild(self.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer")
	self._gorefinebg = gohelper.findChild(self.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#go_refinebg")
	self._goboth = gohelper.findChild(self.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#go_both")
	self._imagecarrer = gohelper.findChildImage(self.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#go_both/#image_carrer")
	self._txtrefinelv = gohelper.findChildText(self.viewGO, "root/right/collect/rewardItem/#go_collectReward/commonitemicon/click/#go_equipcareer/#txt_refinelv")
	self._gofinish = gohelper.findChild(self.viewGO, "root/right/collect/rewardItem/#go_finish")
	self._gocanget = gohelper.findChild(self.viewGO, "root/right/collect/#go_canget")
	self._gocollectNote = gohelper.findChild(self.viewGO, "root/right/collect/#go_collectNote")
	self._gocollectProcess = gohelper.findChild(self.viewGO, "root/right/collect/#go_collectProcess")
	self._txtcollectProcess = gohelper.findChildText(self.viewGO, "root/right/collect/#go_collectProcess/#txt_collectProcess")
	self._gocollectContent = gohelper.findChild(self.viewGO, "root/right/collect/#go_collectProcess/#go_collectContent")
	self._gocollectItem = gohelper.findChild(self.viewGO, "root/right/collect/#go_collectProcess/#go_collectContent/#go_collectItem")
	self._gocollectFinish = gohelper.findChild(self.viewGO, "root/right/collect/#go_collectFinish")
	self._btntidyclue = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/collect/#go_collectFinish/#btn_tidyclue")
	self._gonoteItem = gohelper.findChild(self.viewGO, "root/#go_noteItem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._goblock = gohelper.findChild(self.viewGO, "root/#go_block")
	self._root = gohelper.findChild(self.viewGO, "root")
	self._gomask = gohelper.findChild(self.viewGO, "#go_mask")
	self._gomaskGuide = gohelper.findChild(self.viewGO, "#go_mask_guide")
	self._maskClick = gohelper.getClick(self._gomask)
	self._ani = gohelper.onceAddComponent(self._root, typeof(UnityEngine.Animator))
	self._goCollectProcessAni = gohelper.onceAddComponent(self._gocollectProcess, typeof(UnityEngine.Animator))
	self._goCollectFinishAni = gohelper.onceAddComponent(self._gocollectFinish, typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_StoryCollectView:addEvents()
	self._btntidyclue:AddClickListener(self._btntidyclueOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._maskClick:AddClickListener(self._onMaskClick, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet121BonusReply, self._onReceiveGet121BonusReply, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.focusCollectedAllClueTab, self._focusCollectedAllClueTab, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.StoryCollectViewSelectTab, self._selectStoryTabByGuide, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.ShowMarkingStoryInView, self._markingKeyWordInStory, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.ShowMarkingStoryAllDone, self._onLastShowFlowDone, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self._OnRemoveElement, self)
end

function VersionActivity_1_2_StoryCollectView:removeEvents()
	self._btntidyclue:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._maskClick:RemoveClickListener()
end

function VersionActivity_1_2_StoryCollectView:_onReceiveGet121BonusReply(storyId)
	if not self._selectConfig then
		return
	end

	if storyId == self._selectConfig.id then
		self.bonusFinished = VersionActivity1_2NoteModel.instance:getBonusFinished(self._selectConfig.id)

		self:_showCollectData()
	end
end

function VersionActivity_1_2_StoryCollectView:_btntidyclueOnClick()
	self:_markNote()
	self:_playMarkClueAni()
end

function VersionActivity_1_2_StoryCollectView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity_1_2_StoryCollectView:onOpen()
	self._simagebookbg1:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben03"))
	self._simagebookbg2:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben04"))
	self._simagebookbg3:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben01"))
	self._simagebookbg4:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben02"))
	self._simagebookbg5:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben07"))
	self._simageleftbookbg5:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben05"))
	self._simagebookbg6:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2("bg_bijiben06"))
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
	gohelper.setActive(self._goblock, false)
	gohelper.setActive(self._gomask, false)

	self._activityId = VersionActivityEnum.ActivityId.Act121
	self._storyList = VersionActivity1_2NoteConfig.instance:getStoryList()

	self:_showBtn()
	self:_showBtnUnlockAni()
end

function VersionActivity_1_2_StoryCollectView.getBtnAniFinish(storyId)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteBtnUnlockAni .. storyId, 0)
end

function VersionActivity_1_2_StoryCollectView.setBtnAniFinish(storyId, value)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteBtnUnlockAni .. storyId, value or 1)
end

function VersionActivity_1_2_StoryCollectView:_showBtnUnlockAni()
	for i, v in ipairs(self._storyList) do
		local storyId = self._storyList[i].id
		local isOpen = DungeonModel.instance:hasPassLevel(self._storyList[i].episodeId)

		if isOpen and VersionActivity_1_2_StoryCollectView.getBtnAniFinish(storyId) == 0 then
			VersionActivity_1_2_StoryCollectView.setBtnAniFinish(storyId)

			local btn = self._btnList[i]

			gohelper.setActive(gohelper.findChild(btn, "go_lock"), true)
			gohelper.onceAddComponent(btn, typeof(UnityEngine.Animator)):Play("unlock")
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
		end
	end
end

function VersionActivity_1_2_StoryCollectView:_showBtn()
	self._btnComList = self:getUserDataTb_()
	self._btnList = self:getUserDataTb_()

	self:com_createObjList(self._onBtnShow, self._storyList, self._gocategory, self._gocategoryItem)

	self._selectIndex = 1

	self:_refreshBtnState()
	self:_refreshData()
end

function VersionActivity_1_2_StoryCollectView:_onBtnShow(obj, data, index)
	local txt_name = gohelper.findChildText(obj, "go_select/txt_name")
	local txt_name_normal = gohelper.findChildText(obj, "go_normal/txt_name")
	local go_normal = gohelper.findChild(obj, "go_normal")
	local go_select = gohelper.findChild(obj, "go_select")
	local go_lock = gohelper.findChild(obj, "go_lock")

	txt_name.text = data.name
	txt_name_normal.text = data.name

	local isOpen = DungeonModel.instance:hasPassLevel(data.episodeId)

	gohelper.setActive(go_normal, isOpen)
	gohelper.setActive(go_select, isOpen)
	gohelper.setActive(go_lock, not isOpen)

	local btn_click = gohelper.findChildButtonWithAudio(obj, "btn_click", AudioEnum.TeachNote.play_ui_activity_switch)

	btn_click:RemoveClickListener()
	btn_click:AddClickListener(self._onBtnClick, self, index)
	table.insert(self._btnComList, btn_click)
	table.insert(self._btnList, obj)
end

function VersionActivity_1_2_StoryCollectView:_refreshBtnState()
	for i, v in ipairs(self._btnList) do
		local isOpen = DungeonModel.instance:hasPassLevel(self._storyList[i].episodeId)

		gohelper.setActive(gohelper.findChild(v, "go_select"), isOpen and self._selectIndex == i)
		gohelper.setActive(gohelper.findChild(v, "go_normal"), isOpen and self._selectIndex ~= i)
		gohelper.setActive(gohelper.findChild(v, "go_lock"), not isOpen)
	end
end

function VersionActivity_1_2_StoryCollectView:_onBtnClick(index)
	local config = self._storyList[index]

	if not DungeonModel.instance:hasPassLevel(config.episodeId) then
		GameFacade.showToast(ToastEnum.Activity1_2NoteStoryUnlockLick)

		return
	end

	if self._selectIndex == index then
		return
	end

	self._isOpened = true
	self._selectIndex = index

	self:_refreshBtnState()
	self._ani:Play("siwtch", 0, 0)
	TaskDispatcher.runDelay(self._refreshData, self, 0.1)
end

function VersionActivity_1_2_StoryCollectView:_refreshData()
	self._selectConfig = self._storyList[self._selectIndex]
	self.bonusFinished = VersionActivity1_2NoteModel.instance:getBonusFinished(self._selectConfig.id)

	local arr = string.splitToNumber(self._selectConfig.noteIds, "|")

	self._allClueCount = #arr
	self._haveClueCount = 0
	self._haveNoteList = {}
	self._noteList = {}

	for i, v in ipairs(arr) do
		if VersionActivity1_2NoteModel.instance:getNote(v) then
			self._haveClueCount = self._haveClueCount + 1
			self._haveNoteList[i] = v
		end

		self._noteList[i] = v
	end

	self:_releaseSignObj()
	self:_showNoteCollectData()
	self:_showCollectData()

	self._txttitleIndex.text = string.format("%02d", self._selectIndex)

	self:_showReward()
	self:_refreshRedPoint()
end

function VersionActivity_1_2_StoryCollectView:_refreshRewardState()
	gohelper.setActive(self._gofinishIcon, self.bonusFinished)
	gohelper.setActive(self._gofinish, false)
end

function VersionActivity_1_2_StoryCollectView:_refreshRedPoint()
	for i, v in ipairs(self._storyList) do
		gohelper.setActive(gohelper.findChild(self._btnList[i], "redPoint"), VersionActivity_1_2_StoryCollectView.getStoryRedPoint(v.id))
	end
end

function VersionActivity_1_2_StoryCollectView:_showNoteCollectData()
	gohelper.setActive(self._gorightEmpty, false)
	gohelper.setActive(self._gorightNoteContent, true)

	self._textList = self:getUserDataTb_()

	self:com_createObjList(self._createLeftNote, 2, self._goleftNoteContent, self._gonoteItem)
	self:com_createObjList(self._createRightNote, self._allClueCount - 2, self._gorightNoteContent, self._gonoteItem)

	self._txttitleName.text = self._selectConfig.name

	self._simagetitle:LoadImage(ResUrl.getVersionActivityStoryCollect_1_2(self._selectConfig.icon))
end

function VersionActivity_1_2_StoryCollectView:_playUnlockNoteAni()
	local transform = self._gocollectContent.transform

	for i = self._collectItemUnlockPlayIndex, self._haveClueCount do
		local childObj = gohelper.findChild(transform:GetChild(i - 1).gameObject, "go_collected")

		gohelper.setActive(childObj, true)
		gohelper.onceAddComponent(childObj, typeof(UnityEngine.Animator)):Play("unlock", 0, 0)
	end

	for i, v in ipairs(self._playUnlockNoteAniIds) do
		local tarObj = self._textList[v].transform.parent.gameObject
		local text = gohelper.findChildText(tarObj, "txt_desc")
		local materialPropsCtrl = tarObj:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		local cloneMat = UnityEngine.Object.Instantiate(text.materialForRendering)

		text.fontMaterial = cloneMat

		materialPropsCtrl.mas:Clear()
		materialPropsCtrl.mas:Add(cloneMat)

		gohelper.onceAddComponent(tarObj, gohelper.Type_CanvasGroup).alpha = 1
		gohelper.onceAddComponent(tarObj, typeof(UnityEngine.Animator)).enabled = true

		gohelper.onceAddComponent(tarObj, typeof(UnityEngine.Animator)):Play("unlock")
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_unlock)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_collect)
	TaskDispatcher.runDelay(self._afterUnlockNoteAni, self, 1)
end

function VersionActivity_1_2_StoryCollectView:_afterUnlockNoteAni()
	if self._haveClueCount == self._allClueCount and not self.bonusFinished then
		self:_closeProcessAndShowGoCollectFinish()
	else
		self:_refreshCollectData()
	end

	self:_showUnlockNote()
end

function VersionActivity_1_2_StoryCollectView:_showUnlockNote()
	if VersionActivity_1_2_StoryCollectView.getFirstShowStory(self._selectConfig.id) == 0 then
		VersionActivity_1_2_StoryCollectView.setFirstShowStory(self._selectConfig.id)

		for i, v in ipairs(self._noteList) do
			if not VersionActivity1_2NoteModel.instance:getNote(v) then
				local tarObj = self._textList[i].transform.parent.gameObject

				gohelper.onceAddComponent(tarObj, gohelper.Type_CanvasGroup).alpha = 1
				gohelper.onceAddComponent(tarObj, typeof(UnityEngine.Animator)).enabled = true

				gohelper.onceAddComponent(tarObj, typeof(UnityEngine.Animator)):Play("open")
			end
		end
	end
end

function VersionActivity_1_2_StoryCollectView:_showCollectData()
	self:_refreshRewardState()

	self._playUnlockNoteAniIds = {}

	if not self.bonusFinished then
		for i, v in ipairs(self._noteList) do
			if VersionActivity1_2NoteModel.instance:getNote(v) and VersionActivity_1_2_StoryCollectView.getNoteItemUnlockAniFinish(v) == 0 then
				VersionActivity_1_2_StoryCollectView.setNoteItemUnlockAniFinish(v)
				table.insert(self._playUnlockNoteAniIds, i)
			end
		end
	end

	self._collectItemUnlockPlayIndex = self._haveClueCount - #self._playUnlockNoteAniIds + 1
	self._txtcollectProcess.text = string.format("<color=#ad7b40>%d</color>/%d", self._haveClueCount, self._allClueCount)

	self:com_createObjList(self._onCollectPieceShow, self._noteList, self._gocollectContent, self._gocollectItem)

	if #self._playUnlockNoteAniIds > 0 then
		gohelper.setActive(self._gocollectNote, false)
		gohelper.setActive(self._gocollectFinish, false)
		gohelper.setActive(self._gocollectProcess, true)
		gohelper.setActive(self._goblock, true)

		if self._isOpened then
			TaskDispatcher.runDelay(self._playUnlockNoteAni, self, 0.7)
		else
			TaskDispatcher.runDelay(self._playUnlockNoteAni, self, 1)
		end

		return
	end

	self:_showUnlockNote()
	self:_refreshCollectData()
end

function VersionActivity_1_2_StoryCollectView:_refreshCollectData()
	gohelper.setActive(self._gocollectNote, self.bonusFinished)
	gohelper.setActive(self._gocollectProcess, not self.bonusFinished and self._haveClueCount < self._allClueCount)
	gohelper.setActive(self._gocollectFinish, not self.bonusFinished and self._haveClueCount == self._allClueCount)
	self._goCollectProcessAni:Play("idle")
	self._goCollectFinishAni:Play("open")

	if self.bonusFinished then
		TaskDispatcher.runDelay(self._markNote, self, 0.02)
	end

	local arr = string.splitToNumber(self._selectConfig.clueIds, "|")
	local collectClueItem = gohelper.findChild(self._gocollectNote, "txt_noteItem")

	self:com_createObjList(self._onCollectItemShow, arr, self._gocollectNote, collectClueItem)
	gohelper.setActive(self._goblock, false)
end

function VersionActivity_1_2_StoryCollectView:_closeProcessAndShowGoCollectFinish()
	self._showGoCollectAniFlow = self._showGoCollectAniFlow or FlowSequence.New()

	self._showGoCollectAniFlow:addWork(FunctionWork.New(function()
		self._goCollectProcessAni:Play("close")
	end))
	self._showGoCollectAniFlow:addWork(WorkWaitSeconds.New(0.3))
	self._showGoCollectAniFlow:addWork(FunctionWork.New(function()
		gohelper.setActive(self._gocollectProcess, false)
		gohelper.setActive(self._gocollectFinish, true)
		self._goCollectFinishAni:Play("open")
		self:_refreshCollectData()
	end))
	self._showGoCollectAniFlow:start()
end

function VersionActivity_1_2_StoryCollectView:_onCollectPieceShow(obj, data, index)
	local go_empty = gohelper.findChild(obj, "go_empty")
	local go_collected = gohelper.findChild(obj, "go_collected")
	local uiMesh = gohelper.findChildComponent(obj, "go_collected", typeof(UIMesh))
	local cloneMat = UnityEngine.Object.Instantiate(uiMesh.material)

	uiMesh.material = cloneMat

	local materialPropsCtrl = go_collected:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	materialPropsCtrl.mas:Clear()
	materialPropsCtrl.mas:Add(cloneMat)
	gohelper.onceAddComponent(go_collected, typeof(UnityEngine.Animator)):Play("idle", 0, 0)
	gohelper.setActive(go_collected, index < self._collectItemUnlockPlayIndex)
end

function VersionActivity_1_2_StoryCollectView.getNoteItemUnlockAniFinish(noteId)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteItemUnlockAniFinish .. noteId, 0)
end

function VersionActivity_1_2_StoryCollectView.setNoteItemUnlockAniFinish(noteId, value)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteItemUnlockAniFinish .. noteId, value or 1)
end

function VersionActivity_1_2_StoryCollectView:_onCollectItemShow(obj, data, index)
	local text = gohelper.findChildText(obj, "")
	local go_storytag = gohelper.findChild(obj, "go_storytag")
	local go_point = gohelper.findChild(obj, "go_point")
	local go_line = gohelper.findChild(obj, "go_line")
	local go_vline = gohelper.findChild(obj, "go_vline")
	local go_wave = gohelper.findChild(obj, "go_wave")
	local config = lua_activity121_clue.configDict[data][self._activityId]

	text.text = config.name

	local tagType = config.tagType

	gohelper.setActive(go_vline, config.tagType == 1)
	gohelper.setActive(go_line, config.tagType == 2)
	gohelper.setActive(go_point, config.tagType == 3)
	gohelper.setActive(go_wave, config.tagType == 4)

	local tarSign

	if tagType == 1 then
		tarSign = go_vline.transform
	elseif tagType == 2 then
		tarSign = go_line.transform
	elseif tagType == 3 then
		tarSign = go_point.transform
	elseif tagType == 4 then
		tarSign = go_wave.transform
	end

	gohelper.setActive(go_storytag, false)
	recthelper.setWidth(tarSign, text:GetPreferredValues().x - 26)
end

function VersionActivity_1_2_StoryCollectView:_createLeftNote(obj, data, index)
	self:_onNoteItemShow(obj, self._haveNoteList[index], index)
end

function VersionActivity_1_2_StoryCollectView:_createRightNote(obj, data, index)
	index = index + 2

	self:_onNoteItemShow(obj, self._haveNoteList[index], index)
end

function VersionActivity_1_2_StoryCollectView.getFirstShowStory(storyId)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteFirstShowStory .. storyId, 0)
end

function VersionActivity_1_2_StoryCollectView.setFirstShowStory(storyId)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Activity1_2NoteFirstShowStory .. storyId, 1)
end

function VersionActivity_1_2_StoryCollectView:_onNoteItemShow(obj, data, index)
	local isFirstShowStory = VersionActivity_1_2_StoryCollectView.getFirstShowStory(self._selectConfig.id) == 0

	obj.name = data or 0

	local go_titleNormal = gohelper.findChild(obj, "title/go_titleNormal")
	local txt_title_normal = gohelper.findChildText(obj, "title/go_titleNormal/txt_title")
	local go_titleEmpty = gohelper.findChild(obj, "title/go_titleEmpty")
	local txt_title_empty = gohelper.findChildText(obj, "title/go_titleEmpty/txt_title")
	local txt_desc = gohelper.findChildText(obj, "txt_desc")
	local go_empty = gohelper.findChild(obj, "go_empty")
	local text_empty = gohelper.findChildText(obj, "go_empty/txt")
	local go_line = gohelper.findChild(obj, "go_line")
	local title = gohelper.findChild(obj, "title")

	gohelper.setActive(go_line, true)

	local noteConfig = lua_activity121_note.configDict[self._noteList[index]][self._activityId]

	txt_title_normal.text = noteConfig.name
	txt_title_empty.text = ""

	local data = self._haveNoteList[index]

	if not data then
		gohelper.setActive(obj, true)
		gohelper.setActive(go_titleNormal, false)
		gohelper.setActive(go_titleEmpty, false)
		gohelper.setActive(go_empty, true)

		txt_desc.text = ""

		local episodeId = noteConfig.episodeId
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

		gohelper.onceAddComponent(obj, typeof(UnityEngine.Animator)).enabled = false
		gohelper.onceAddComponent(obj, gohelper.Type_CanvasGroup).alpha = isFirstShowStory and 0 or 1
	else
		gohelper.setActive(go_titleNormal, true)
		gohelper.setActive(go_titleEmpty, false)
		gohelper.setActive(go_empty, false)

		txt_desc.text = self:_showNoteDesNormal(noteConfig.content)

		if self.bonusFinished then
			VersionActivity_1_2_StoryCollectView.setNoteItemUnlockAniFinish(noteConfig.noteId)
		end

		if VersionActivity_1_2_StoryCollectView.getNoteItemUnlockAniFinish(data) == 0 then
			gohelper.onceAddComponent(obj, typeof(UnityEngine.Animator)).enabled = false
			gohelper.onceAddComponent(obj, gohelper.Type_CanvasGroup).alpha = 0
		end
	end

	table.insert(self._textList, txt_desc)
	gohelper.onceAddComponent(obj, typeof(UnityEngine.Animator)):Play("idle")
end

function VersionActivity_1_2_StoryCollectView:_episodeId2Number(episodeId)
	self._episode2NumberDic = self._episode2NumberDic or {}

	if self._episode2NumberDic[episodeId] then
		return self._episode2NumberDic[episodeId]
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(episodeConfig.chapterId)

	if episodeList then
		table.sort(episodeList, function(a, b)
			return a.id < b.id
		end)
	end

	for i, v in ipairs(episodeList) do
		local stageIdList = DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(v.id)

		for index, stageId in ipairs(stageIdList) do
			self._episode2NumberDic[stageId] = chapterConfig.chapterIndex .. string.format(".%02d", i)
		end
	end

	return self._episode2NumberDic[episodeId]
end

function VersionActivity_1_2_StoryCollectView:_showNoteDesNormal(des)
	local str = des

	return string.gsub(str, "<%d-:(.-)>", "%1")
end

function VersionActivity_1_2_StoryCollectView:_releaseSignObj()
	if self._signObjDic then
		for k, v in pairs(self._signObjDic) do
			for index, objList in ipairs(v) do
				for i, obj in ipairs(objList) do
					gohelper.destroy(obj)
				end
			end
		end
	end

	self._signObjDic = {}
end

VersionActivity_1_2_StoryCollectView._signTypeName = {
	"go_vline",
	"go_line",
	"go_point",
	"go_wave",
	[101] = "go_vline",
	[202] = "go_line",
	[104] = "go_wave",
	[303] = "go_point",
	[304] = "go_wave",
	[204] = "go_wave",
	[301] = "go_vline",
	[302] = "go_line",
	[102] = "go_line",
	[201] = "go_vline",
	[103] = "go_point",
	[203] = "go_point"
}

function VersionActivity_1_2_StoryCollectView:_markNote()
	self:_releaseSignObj()

	for index = 1, self._allClueCount do
		local note = self._haveNoteList[index]

		if note then
			local content = lua_activity121_note.configDict[note][self._activityId].content
			local findPattern = "<%d-:.->"
			local pattern = "<%d-:(.-)>"
			local startIndex, endIndex = string.find(content, findPattern)

			while startIndex do
				local clueId = string.match(content, "<(%d-):.->")

				clueId = tonumber(clueId)

				local fillContent = ""

				content = string.gsub(content, pattern, function(str)
					fillContent = str

					return str
				end, 1)

				local tarText = self._textList[index]
				local clueConfig = lua_activity121_clue.configDict[clueId][self._activityId]

				if clueConfig then
					local preStr = string.sub(content, 1, startIndex - 1)
					local signObj = gohelper.cloneInPlace(gohelper.findChild(tarText.gameObject, VersionActivity_1_2_StoryCollectView._signTypeName[clueId]))

					if signObj then
						self._signObjDic[clueId] = self._signObjDic[clueId] or {}

						local objList = self:getUserDataTb_()

						table.insert(objList, signObj)
						gohelper.setActive(signObj, true)

						local signTransform = signObj.transform
						local characterCount = tarText.textInfo.characterCount
						local preLen = GameUtil.utf8len(preStr)

						if preLen <= characterCount then
							local textWidth = recthelper.getWidth(tarText.transform)
							local textHeight = recthelper.getHeight(tarText.transform)
							local characterInfo = tarText.textInfo.characterInfo[preLen]
							local startBL = characterInfo.bottomLeft
							local startX = startBL.x + textWidth / 2
							local startY = characterInfo.baseLine - textHeight / 2 - 10

							recthelper.setAnchorX(signTransform, startX)
							recthelper.setAnchorY(signTransform, startY)

							local endLen = GameUtil.utf8len(fillContent) + preLen - 1
							local endCharacterInfo = tarText.textInfo.characterInfo[endLen]
							local endBR = endCharacterInfo.bottomRight

							if endBR.x < startBL.x then
								recthelper.setWidth(signTransform, textWidth - startX)

								for i = preLen, endLen do
									local tempCharacterInfo = tarText.textInfo.characterInfo[i]
									local nextCharacterInfo = tarText.textInfo.characterInfo[i + 1]

									if tempCharacterInfo and nextCharacterInfo and tempCharacterInfo.baseLine - nextCharacterInfo.baseLine > 1 then
										local nextSignObj = gohelper.cloneInPlace(signObj)

										table.insert(objList, nextSignObj)

										local nextSignTransform = nextSignObj.transform

										startBL = nextCharacterInfo.bottomLeft
										startX = nextCharacterInfo.bottomLeft.x + textWidth / 2
										startY = nextCharacterInfo.baseLine - textHeight / 2 - 10

										recthelper.setAnchorX(nextSignTransform, nextCharacterInfo.bottomLeft.x + textWidth / 2)
										recthelper.setAnchorY(nextSignTransform, startY)
										recthelper.setWidth(nextSignTransform, endBR.x - nextCharacterInfo.bottomLeft.x)
									end
								end
							else
								recthelper.setWidth(signTransform, endBR.x - startBL.x)
							end
						end

						table.insert(self._signObjDic[clueId], objList)
					end
				end

				startIndex, endIndex = string.find(content, findPattern)
			end
		end
	end

	if GuideModel.instance:isGuideFinish(stroyFinalShowGuideId) and self.bonusFinished then
		local arr = string.splitToNumber(self._selectConfig.clueIds, "|")

		for clueIndex, clueValue in ipairs(arr) do
			local clueConfig = lua_activity121_clue.configDict[clueValue][self._activityId]

			if clueConfig.storyTag == 1 then
				local tarObj = self._gocollectNote.transform:GetChild(clueIndex - 1).gameObject
				local signObj = gohelper.findChild(tarObj, "go_storytag")

				gohelper.setActive(signObj, true)
			end
		end
	end
end

function VersionActivity_1_2_StoryCollectView:_onMaskClick()
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.skipLineWork)
end

function VersionActivity_1_2_StoryCollectView:_playMarkClueAni()
	gohelper.setActive(self._goblock, true)
	self:_releaseAniFlow()

	self._aniFlow = FlowSequence.New()

	local collectNoteTtran = self._gocollectNote.transform

	self._aniFlow:addWork(FunctionWork.New(function()
		gohelper.setActive(self._gocollectFinish, false)
		gohelper.setActive(self._gocollectNote, true)

		for i = 0, collectNoteTtran.childCount - 1 do
			local obj = collectNoteTtran:GetChild(i).gameObject

			gohelper.setActive(obj, false)
		end
	end))

	local arr = string.splitToNumber(self._selectConfig.clueIds, "|")

	for i, v in ipairs(arr) do
		if self._signObjDic[v] then
			self._aniFlow:addWork(VersionActivity_1_2_StoryClueAniWork.New(self._signObjDic[v], self, i, v))
		end
	end

	self._aniFlow:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tox = 0,
		toy = 0,
		t = 0.3,
		tr = self._root.transform
	}))
	self._aniFlow:addWork(TweenWork.New({
		toz = 1,
		type = "DOScale",
		tox = 1,
		toy = 1,
		t = 0.3,
		tr = self._root.transform
	}))
	self._aniFlow:addWork(FunctionWork.New(function()
		gohelper.setActive(self._gomask, false)
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
		Activity121Rpc.instance:sendGet121BonusRequest(self._selectConfig.id)
	end))
	self._aniFlow:registerDoneListener(self._onAniFlowDone, self)
	self._aniFlow:start()
end

function VersionActivity_1_2_StoryCollectView:_onAniFlowDone()
	gohelper.setActive(self._goblock, false)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.CollectStoryAniEnd)
end

function VersionActivity_1_2_StoryCollectView:_onCloseView(viewName)
	if viewName == ViewName.CommonPropView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)

		local allCollected = true

		for i, v in ipairs(self._storyList) do
			if not VersionActivity1_2NoteModel.instance:getBonusFinished(v.id) then
				allCollected = false
			end
		end

		if allCollected then
			if GuideModel.instance:isGuideRunning(stroyFinalShowGuideId) then
				return
			end

			self:_playLastShowFlow()
		end
	end
end

function VersionActivity_1_2_StoryCollectView:_playLastShowFlow()
	gohelper.setActive(self._goblock, true)

	if not self._lastShowFlow then
		local index = 0

		self._lastShowFlow = FlowSequence.New()

		for i, v in ipairs(self._storyList) do
			self._lastShowFlow:addWork(FunctionWork.New(function()
				index = index + 1

				self:_onBtnClick(index)
			end))
			self._lastShowFlow:addWork(WorkWaitSeconds.New(1))

			local arr = string.splitToNumber(v.clueIds, "|")

			for clueIndex, clueValue in ipairs(arr) do
				local clueConfig = lua_activity121_clue.configDict[clueValue][self._activityId]

				if clueConfig.storyTag == 1 then
					self._lastShowFlow:addWork(FunctionWork.New(function()
						local tarObj = self._gocollectNote.transform:GetChild(clueIndex - 1).gameObject
						local signObj = gohelper.findChild(tarObj, "go_storytag")

						gohelper.setActive(signObj, true)
						gohelper.onceAddComponent(signObj, typeof(UnityEngine.Animator)):Play("open")
					end))
					self._lastShowFlow:addWork(WorkWaitSeconds.New(1))
				end
			end
		end
	end

	self._lastShowFlow:registerDoneListener(self._onLastShowFlowDone, self)
	self._lastShowFlow:start()
end

function VersionActivity_1_2_StoryCollectView:_onLastShowFlowDone()
	DungeonRpc.instance:sendMapElementRequest(12101091)
end

function VersionActivity_1_2_StoryCollectView:_OnRemoveElement(id)
	if id == 12101091 then
		self:closeThis()
	end
end

function VersionActivity_1_2_StoryCollectView:_releaseAniFlow()
	if self._aniFlow then
		self._aniFlow:unregisterDoneListener(self._onAniFlowDone, self)
		self._aniFlow:destroy()

		self._aniFlow = nil
	end
end

function VersionActivity_1_2_StoryCollectView:_showReward()
	if string.nilorempty(self._selectConfig.bonus) then
		gohelper.setActive(self._gocollectReward, false)
		gohelper.setActive(self._gocanget, false)

		return
	end

	gohelper.setActive(self._gocollectReward, true)

	local itemco = string.splitToNumber(self._selectConfig.bonus, "#")

	self._reward = self._reward or IconMgr.instance:getCommonItemIcon(self._gocollectReward)

	self._reward:setMOValue(itemco[1], itemco[2], itemco[3])
	self._reward:setCountFontSize(34)
	gohelper.setActive(self._gocanget, not self.bonusFinished and self._haveClueCount == self._allClueCount)
end

function VersionActivity_1_2_StoryCollectView.getStoryRedPoint(storyId)
	if VersionActivity1_2NoteModel.instance:getBonusFinished(storyId) then
		return false
	end

	local activityId = VersionActivityEnum.ActivityId.Act121
	local config = lua_activity121_story.configDict[activityId][storyId]
	local arr = string.splitToNumber(config.noteIds, "|")

	for index, noteId in ipairs(arr) do
		if VersionActivity1_2NoteModel.instance:getNote(noteId) and VersionActivity_1_2_StoryCollectView.getNoteItemUnlockAniFinish(noteId) == 0 then
			return true
		end
	end
end

function VersionActivity_1_2_StoryCollectView.getRedPoint()
	for i, v in ipairs(VersionActivity1_2NoteConfig.instance:getStoryList()) do
		if VersionActivity_1_2_StoryCollectView.getStoryRedPoint(v.id) then
			return true
		end
	end
end

function VersionActivity_1_2_StoryCollectView:_focusCollectedAllClueTab()
	return
end

function VersionActivity_1_2_StoryCollectView:_selectStoryTabByGuide(tabIdx)
	self._selectIndex = tonumber(tabIdx)

	self:_refreshBtnState()
	self:_refreshData()
end

function VersionActivity_1_2_StoryCollectView:_markingKeyWordInStory(storyIdx)
	if self._guideMarkingStoryFlow then
		self._guideMarkingStoryFlow:stop()
		self._guideMarkingStoryFlow:destroy()

		self._guideMarkingStoryFlow = nil
	end

	self._guideMarkingStoryFlow = FlowSequence.New()

	local index = tonumber(storyIdx)

	self._curGuideMarkingStoryIndex = index

	local storyCfg = self._storyList[index]

	self._guideMarkingStoryFlow:addWork(FunctionWork.New(function()
		self:_onBtnClick(index)
	end))
	self._guideMarkingStoryFlow:addWork(WorkWaitSeconds.New(1))

	local arr = string.splitToNumber(storyCfg.clueIds, "|")

	for clueIndex, clueValue in ipairs(arr) do
		local clueConfig = lua_activity121_clue.configDict[clueValue][self._activityId]

		if clueConfig.storyTag == 1 then
			self._guideMarkingStoryFlow:addWork(FunctionWork.New(function()
				local tarObj = self._gocollectNote.transform:GetChild(clueIndex - 1).gameObject
				local signObj = gohelper.findChild(tarObj, "go_storytag")

				gohelper.setActive(signObj, true)
				gohelper.onceAddComponent(signObj, typeof(UnityEngine.Animator)):Play("open")
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_level_chosen)
			end))
			self._guideMarkingStoryFlow:addWork(WorkWaitSeconds.New(1))
		end
	end

	self._guideMarkingStoryFlow:registerDoneListener(self._markingStoryFlowDone, self)
	self._guideMarkingStoryFlow:start()
end

function VersionActivity_1_2_StoryCollectView:_markingStoryFlowDone()
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.CollectStoryAniEnd)
end

function VersionActivity_1_2_StoryCollectView:onClose()
	if self._showGoCollectAniFlow then
		self._showGoCollectAniFlow:destroy()

		self._showGoCollectAniFlow = nil
	end

	if self._lastShowFlow then
		self._lastShowFlow:unregisterDoneListener(self._onLastShowFlowDone, self)
		self._lastShowFlow:destroy()

		self._lastShowFlow = nil
	end

	if self._guideMarkingStoryFlow then
		self._guideMarkingStoryFlow:stop()
		self._guideMarkingStoryFlow:destroy()

		self._guideMarkingStoryFlow = nil
	end

	self:_releaseAniFlow()
	TaskDispatcher.cancelTask(self._markNote, self)
	TaskDispatcher.cancelTask(self._refreshData, self)
	TaskDispatcher.cancelTask(self._afterUnlockNoteAni, self)
	TaskDispatcher.cancelTask(self._playUnlockNoteAni, self)

	if self._btnComList then
		for i, v in ipairs(self._btnComList) do
			v:RemoveClickListener()
		end
	end

	if DungeonMapModel.instance:getElementById(12101091) then
		DungeonRpc.instance:sendMapElementRequest(12101091)
	end
end

function VersionActivity_1_2_StoryCollectView:onDestroyView()
	self._simagebookbg1:UnLoadImage()
	self._simagebookbg2:UnLoadImage()
	self._simagebookbg3:UnLoadImage()
	self._simagebookbg4:UnLoadImage()
	self._simagebookbg5:UnLoadImage()
	self._simagetitle:UnLoadImage()
	self._simageleftbookbg5:UnLoadImage()
	self._simagebookbg6:UnLoadImage()
end

return VersionActivity_1_2_StoryCollectView
