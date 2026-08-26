-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/Act183DungeonView.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.Act183DungeonView", package.seeall)

local Act183DungeonView = class("Act183DungeonView", BaseView)
local UpdateGroupInterval = 30
local DelaySwitchGroupInfo = 0.1

function Act183DungeonView:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._scrollgroups = gohelper.findChildScrollRect(self.viewGO, "root/left/#scroll_groups")
	self._gogroupitem = gohelper.findChild(self.viewGO, "root/left/#scroll_groups/Viewport/Content/#go_groupitem")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "root/left/#btn_task/#go_taskreddot")
	self._goepisodecontainer = gohelper.findChild(self.viewGO, "root/middle/#go_episodecontainer")
	self._gonormalepisode = gohelper.findChild(self.viewGO, "root/middle/#go_episodecontainer/#go_normalepisode")
	self._gobossepisode = gohelper.findChild(self.viewGO, "root/middle/#go_episodecontainer/#go_bossepisode")
	self._godailyepisode = gohelper.findChild(self.viewGO, "root/middle/#go_episodecontainer/#go_dailyepisode")
	self._goprogresslist = gohelper.findChild(self.viewGO, "root/top/bar/#go_progresslist")
	self._goprogressitem = gohelper.findChild(self.viewGO, "root/top/bar/#go_progresslist/#go_progressitem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "root/top/bar/#go_progresslist/#btn_reset")
	self._gonormal = gohelper.findChild(self.viewGO, "root/right/#go_normal")
	self._gohard = gohelper.findChild(self.viewGO, "root/right/#go_hard")
	self._scrolldetail = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_detail")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/right/#go_detail/title/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/top/#txt_desc")
	self._txtadditionrule = gohelper.findChildText(self.viewGO, "root/right/#scroll_detail/Viewport/Content/#txt_additionrule")
	self._gobaserulecontainer = gohelper.findChild(self.viewGO, "root/right/#scroll_detail/Viewport/Content/baserules/#go_baserulecontainer")
	self._gobaseruleitem = gohelper.findChild(self.viewGO, "root/right/#scroll_detail/Viewport/Content/baserules/#go_baserulecontainer/#go_baseruleitem")
	self._goescaperulecontainer = gohelper.findChild(self.viewGO, "root/right/#scroll_detail/Viewport/Content/escaperules/#go_escaperulecontainer")
	self._goescaperuleitem = gohelper.findChild(self.viewGO, "root/right/#scroll_detail/Viewport/Content/escaperules/#go_escaperulecontainer/#go_escaperuleitem")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_detail/#btn_start")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_detail/#btn_restart")
	self._simagehardbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_HardBG")
	self._gocompleted = gohelper.findChild(self.viewGO, "root/middle/#go_Completed")
	self._godailycompleted = gohelper.findChild(self.viewGO, "root/middle/#go_DailyCompleted")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183DungeonView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function Act183DungeonView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnreset:RemoveClickListener()
end

function Act183DungeonView:_btntaskOnClick()
	if self._groupMo then
		local groupType = self._groupMo:getGroupType()

		if self._groupMo then
			local groupId = self._groupMo:getGroupId()
			local params = {
				selectGroupType = groupType,
				selectGroupId = groupId
			}

			Act183Controller.instance:openAct183TaskView(params)
		end
	end
end

function Act183DungeonView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act183ResetGroupEpisode, MsgBoxEnum.BoxType.Yes_No, self._resetConfirmCallBack, nil, nil, self)
end

function Act183DungeonView:_resetConfirmCallBack()
	Act183Controller.instance:resetGroupEpisode(self._actId, self._selectGroupId)
end

function Act183DungeonView:_onUpdateGroupInfo()
	self:refresh()
end

function Act183DungeonView:_onClickSwitchGroup(newGroupId)
	if self._selectGroupId == newGroupId then
		return
	end

	self._selectGroupId = newGroupId

	self._animator:Play("modeswitch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_SwitchGroup)
	TaskDispatcher.cancelTask(self.refresh, self)
	TaskDispatcher.runDelay(self.refresh, self, DelaySwitchGroupInfo)
end

function Act183DungeonView:_onSelectEpisode(episodeId)
	self._selectEpisodeId = episodeId
end

function Act183DungeonView:_editableInitView()
	self._groupItemTab = self:getUserDataTb_()
	self._episodeItemTab = self:getUserDataTb_()
	self._progressItemTab = self:getUserDataTb_()
	self._actId = Act183Model.instance:getActivityId()
	self._actInfo = Act183Model.instance:getActInfo()
	self._gogroupcontent = gohelper.findChild(self.viewGO, "root/left/#scroll_groups/Viewport/Content")

	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.V2a5_Act183Task)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateGroupInfo, self._onUpdateGroupInfo, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnClickSwitchGroup, self._onClickSwitchGroup, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnClickEpisode, self._onSelectEpisode, self)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function Act183DungeonView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_SwitchGroup)
	self:init()
end

function Act183DungeonView:onUpdateParam()
	self:destroyEpisodeItems()
	self:destroyGroupItems()

	self._groupItemTab = self:getUserDataTb_()
	self._episodeItemTab = self:getUserDataTb_()

	self:init()
end

function Act183DungeonView:init()
	self:initViewParams()
	self:initGroupItems()
	self:refresh()
	self:tickRefreshGroupItems()
	self:addGuide()
end

function Act183DungeonView:onOpenFinish()
	self:focusGroupCategory()
	Act183Controller.instance:dispatchEvent(Act183Event.OnInitDungeonDone)
end

function Act183DungeonView:initViewParams()
	if self.viewParam then
		self._groupTypes = self.viewParam.groupTypes or {
			Act183Enum.GroupType.NormalMain
		}
	end

	self._groupList = {}

	for _, groupType in ipairs(self._groupTypes) do
		local groupMos = self._actInfo:getGroupEpisodeMos(groupType)

		tabletool.addValues(self._groupList, groupMos)
	end

	self._selectGroupId = self.viewParam and self.viewParam.selectGroupId

	if not self._selectGroupId then
		self._firstGroupMo = self._groupList and self._groupList[1]
		self._selectGroupId = self._firstGroupMo:getGroupId()
	end

	local groupMo = self._actInfo:getGroupEpisodeMo(self._selectGroupId)

	self._groupType = groupMo:getGroupType()

	if self.viewParam then
		self._selectEpisodeId = self._selectEpisodeId or self.viewParam
	end
end

function Act183DungeonView:initGroupItems()
	if self._groupList then
		for index, groupMo in ipairs(self._groupList) do
			local status = groupMo:getStatus()

			if self._groupType == Act183Enum.GroupType.Daily and status == Act183Enum.GroupStatus.Locked then
				break
			end

			local groupType = groupMo:getGroupType()
			local groupItem = self:_getOrCreateGroupItem(index, groupType)
			local groupId = groupMo:getGroupId()

			groupItem:onUpdateMO(groupMo, index)
			groupItem:onSelect(groupId == self._selectGroupId)
		end
	end
end

function Act183DungeonView:_getOrCreateGroupItem(index, groupType)
	local groupItem = self._groupItemTab[index]

	if not groupItem then
		local groupItemGO = gohelper.cloneInPlace(self._gogroupitem, "groupitem_" .. index)
		local clsDefine = Act183Enum.GroupCategoryClsType[groupType]

		groupItem = MonoHelper.addNoUpdateLuaComOnceToGo(groupItemGO, clsDefine)
		self._groupItemTab[index] = groupItem
	end

	return groupItem
end

function Act183DungeonView:destroyGroupItems(useMap)
	for _, groupItem in pairs(self._groupItemTab) do
		if not useMap or not useMap[groupItem] then
			groupItem:destroySelf()
		end
	end
end

function Act183DungeonView:tickRefreshGroupItems()
	if self._groupType ~= Act183Enum.GroupType.Daily then
		TaskDispatcher.cancelTask(self.checkRefreshGroupItems, self)

		return
	end

	TaskDispatcher.cancelTask(self.checkRefreshGroupItems, self)
	TaskDispatcher.runRepeat(self.checkRefreshGroupItems, self, UpdateGroupInterval)
end

function Act183DungeonView:checkRefreshGroupItems()
	self:initGroupItems()
end

function Act183DungeonView:refresh()
	self:refreshInfo()
	self:refreshEpisodes()
	self:refreshProgress()
	self:refreshCompletedUI()
end

function Act183DungeonView:refreshInfo()
	self._groupMo = self._actInfo and self._actInfo:getGroupEpisodeMo(self._selectGroupId)
	self._groupType = self._groupMo and self._groupMo:getGroupType()

	gohelper.setActive(self._simagehardbg.gameObject, self._groupType == Act183Enum.GroupType.HardMain)
end

function Act183DungeonView:getGroupStatus(groupId)
	if self._actInfo then
		local groupMo = self._actInfo:getGroupEpisodeMo(groupId)

		return groupMo and groupMo:getStatus()
	end
end

function Act183DungeonView:refreshEpisodes()
	if not self._groupMo then
		return
	end

	local useMap = {}
	local episodeMos = self._groupMo:getEpisodeMos()

	for _, episodeMo in ipairs(episodeMos) do
		local episodeId = episodeMo:getEpisodeId()
		local episodeItem = self:_getOrCreeateEpisodeItem(episodeMo)

		episodeItem:onUpdateMo(episodeMo)
		episodeItem:onSelect(episodeId == self._selectEpisodeId)

		useMap[episodeItem] = true
	end

	self:destroyEpisodeItems(useMap)
end

function Act183DungeonView:destroyEpisodeItems(useMap)
	for _, episodeItem in pairs(self._episodeItemTab) do
		if not useMap or not useMap[episodeItem] then
			episodeItem:destroySelf()
		end
	end
end

function Act183DungeonView:_getOrCreeateEpisodeItem(episodeMo)
	local episodeCo = episodeMo:getConfig()
	local order = episodeCo.order

	if self._episodeItemTab then
		local episodeItem = self._episodeItemTab[order]

		if not self._episodeItemTab then
			episodeItem = Act183BaseEpisodeItem.Get(self.viewGO, episodeMo)
			self._episodeItemTab[order] = self._episodeItemTab
		end

		return self._episodeItemTab
	end
end

function Act183DungeonView:getEpisodeItemTab()
	return self._episodeItemTab
end

function Act183DungeonView:refreshProgress()
	local episodeMos = self._groupMo:getEpisodeMos()

	if episodeMos then
		self._episodeCount = #episodeMos or 0
	end

	self._episodeFinishCount = self._groupMo:getEpisodeFinishCount()

	local useMap = {}

	if episodeMos then
		for index, episodeMo in ipairs(episodeMos) do
			local progressItem = self:_getOrCreateProgressItem(index)

			self:refreshEpisodeProgress(progressItem, episodeMo, index)

			useMap[progressItem] = true
		end
	end

	for _, progressItem in pairs(self._progressItemTab) do
		if not useMap[progressItem] then
			gohelper.setActive(progressItem.viewGO, false)
		end
	end

	gohelper.setAsLastSibling(self._btnreset.gameObject)
end

function Act183DungeonView:refreshCompletedUI()
	local isFinished = self._groupMo:isGroupFinished()
	local isNewFinished = false

	if isFinished then
		local groupId = self._groupMo:getGroupId()
		local newFinishGroupId = Act183Model.instance:getNewFinishGroupId()

		isNewFinished = newFinishGroupId == groupId
	end

	if self._groupMo then
		local groupType = self._groupMo:getGroupType()

		gohelper.setActive(self._gocompleted, isFinished and groupType ~= Act183Enum.GroupType.Daily and not isNewFinished)
		gohelper.setActive(self._godailycompleted, isFinished and groupType == Act183Enum.GroupType.Daily and not isNewFinished)
	end
end

function Act183DungeonView:_getOrCreateProgressItem(index)
	local progressItem = self._progressItemTab[index]

	if not progressItem then
		progressItem = self:getUserDataTb_()
		progressItem.viewGO = gohelper.cloneInPlace(self._goprogressitem, "item_" .. index)
		progressItem.goicon1 = gohelper.findChild(progressItem.viewGO, "icon")
		progressItem.goicon2 = gohelper.findChild(progressItem.viewGO, "icon2")
		progressItem.goicon3 = gohelper.findChild(progressItem.viewGO, "icon3")
		self._progressItemTab[index] = progressItem
	end

	return progressItem
end

function Act183DungeonView:refreshEpisodeProgress(progressItem, episodeMo, index)
	gohelper.setActive(progressItem.viewGO, true)
	gohelper.setActive(progressItem.goicon1, false)
	gohelper.setActive(progressItem.goicon2, false)
	gohelper.setActive(progressItem.goicon3, false)

	if index <= self._episodeFinishCount then
		gohelper.setActive(progressItem.goicon2, true)
	elseif index == self._episodeFinishCount + 1 then
		gohelper.setActive(progressItem.goicon3, true)
	else
		gohelper.setActive(progressItem.goicon1, true)
	end
end

function Act183DungeonView:focusGroupCategory()
	local scrollOffsetY = 0
	local isFocusSucc = false

	if self._selectGroupId and self._groupList then
		for index, groupMo in ipairs(self._groupList) do
			if groupMo:getGroupId() == self._selectGroupId then
				isFocusSucc = true

				break
			end

			local groupItem = self:_getOrCreateGroupItem(index)
			local itemHeight = groupItem:getHeight()

			scrollOffsetY = scrollOffsetY + itemHeight
		end
	end

	ZProj.UGUIHelper.RebuildLayout(self._gogroupcontent.transform)

	local scrollHeight = recthelper.getHeight(self._scrollgroups.transform)
	local scrollContentHeight = recthelper.getHeight(self._gogroupcontent.transform)
	local resultScrollOffsetY = isFocusSucc and scrollOffsetY or 0

	self._scrollgroups.verticalNormalizedPosition = 1 - resultScrollOffsetY / (scrollContentHeight - scrollHeight)
end

function Act183DungeonView:addGuide()
	if self._groupType == Act183Enum.GroupType.NormalMain then
		local helpView = HelpShowView.New()

		helpView:setHelpId(HelpEnum.HelpId.Act183EnterDungeon)
		self:addChildView(helpView)
	end
end

function Act183DungeonView:onClose()
	TaskDispatcher.cancelTask(self.refresh, self)
	TaskDispatcher.cancelTask(self.checkRefreshGroupItems, self)
end

function Act183DungeonView:onDestroyView()
	return
end

return Act183DungeonView
