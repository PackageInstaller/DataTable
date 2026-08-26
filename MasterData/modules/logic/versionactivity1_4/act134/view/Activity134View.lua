-- chunkname: @modules/logic/versionactivity1_4/act134/view/Activity134View.lua

module("modules.logic.versionactivity1_4.act134.view.Activity134View", package.seeall)

local Activity134View = class("Activity134View", BaseView)

function Activity134View:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._txtdue = gohelper.findChildText(self.viewGO, "Right/bg_normal/#txt_due")
	self._txtrightrecordtitle = gohelper.findChildText(self.viewGO, "Right/bg_normal/#txt_title")
	self._txtpage = gohelper.findChildText(self.viewGO, "Right/bg_normal/#txt_page")
	self._scrollviewright = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_view")
	self._goreportitem = gohelper.findChild(self.viewGO, "Right/#scroll_view/Viewport/Content/#go_reportitem")
	self._btnobtain = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_obtain")
	self._btnleftswitch = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_leftswitch")
	self._btnrightswitch = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_rightswitch")
	self._goleftswitchboundary = gohelper.findChild(self._btnleftswitch.gameObject, "boundary")
	self._gorightswitchboundary = gohelper.findChild(self._btnrightswitch.gameObject, "boundary")
	self._goleftswitchnormal = gohelper.findChild(self._btnleftswitch.gameObject, "normal")
	self._gorightswitchnormal = gohelper.findChild(self._btnrightswitch.gameObject, "normal")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_title")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/#simage_title/remiantime/bg/#txt_remiantime")
	self._scrollviewdetail = gohelper.findChildScrollRect(self.viewGO, "Left/#simage_title/#scroll_view")
	self._txtdetail = gohelper.findChildText(self.viewGO, "Left/#simage_title/#scroll_view/Viewport/Content/#txt_detail")
	self._simagedetailbg = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_detailbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "Left/#simage_detailbg/select/#txt_num")
	self._txtleftrecordtitle = gohelper.findChildText(self.viewGO, "Left/#simage_detailbg/select/bg/#txt_title")
	self._gofill = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content/fill/#go_fill")
	self._txtschedule = gohelper.findChildText(self.viewGO, "Left/progress/bg/#txt_schedule")
	self._scrollviewprogress = gohelper.findChildScrollRect(self.viewGO, "Left/progress/#scroll_view")
	self._goprogressitem = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_progressitem")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._godetailselect = gohelper.findChild(self.viewGO, "Left/#simage_detailbg/select")
	self._goemptydetail = gohelper.findChild(self.viewGO, "Right/bg_normal/bg_empty")
	self._gobrighten = gohelper.findChild(self.viewGO, "Left/#simage_detailbg/#go_brighten")
	self._goIcon1 = gohelper.findChild(self.viewGO, "Right/bg_normal/icon1")
	self._goIcon2 = gohelper.findChild(self.viewGO, "Right/bg_normal/icon2")

	local goRedDot = gohelper.findChild(self.viewGO, "Right/#btn_obtain/#go_reddot")

	self._redDot = RedDotController.instance:addRedDot(goRedDot, RedDotEnum.DotNode.Activity1_4Act134Task)
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.animatorPlayer:Play(UIAnimationName.Open)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity134View:addEvents()
	self._btnobtain:AddClickListener(self._btnobtainOnClick, self)
	self._btnleftswitch:AddClickListener(self._btnleftswitchOnClick, self)
	self._btnrightswitch:AddClickListener(self._btnrightswitchOnClick, self)
	self.addEventCb(self, Activity134Controller.instance, Activity134Event.OnGetBonus, self.getBonusEvent, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.currencyChangeEvent, self)
	self.addEventCb(self, Activity134Controller.instance, Activity134Event.OnUpdateInfo, self.onUpdateParam, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function Activity134View:removeEvents()
	self._btnobtain:RemoveClickListener()
	self._btnleftswitch:RemoveClickListener()
	self._btnrightswitch:RemoveClickListener()
	self.removeEventCb(self, Activity134Controller.instance, Activity134Event.OnGetBonus, self.getBonusEvent, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.currencyChangeEvent, self)
	self.removeEventCb(self, Activity134Controller.instance, Activity134Event.OnUpdateInfo, self.onUpdateParam, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function Activity134View:_btnobtainOnClick()
	Activity134Controller.instance:openActivity134TaskView()
end

function Activity134View:_btnleftswitchOnClick()
	if self._storyTabIndex <= 1 then
		-- block empty
	else
		local index = self._storyTabIndex - 1

		self:cutReportTab(index, true)
	end
end

function Activity134View:_btnrightswitchOnClick()
	if self._storyTabIndex >= Activity134Model.instance:getFinishStoryCount() then
		if self._storyTabIndex < self.storyTotalCount then
			GameFacade.showToast(ToastEnum.Act134LackofClueTip)
		end
	else
		local index = self._storyTabIndex + 1

		self:cutReportTab(index, true)
	end
end

function Activity134View:_editableInitView()
	self._simagefullbg:LoadImage(ResUrl.getV1a4DustRecordsIcon("v1a4_dustyrecords_fullbg_1"))

	self.storyTotalCount = Activity134Model.instance:getStoryTotalCount()
	self.actId = VersionActivity1_4Enum.ActivityId.DustyRecords
	self._brightenPos = self:getUserDataTb_()

	for i = 1, 6 do
		local brighten = gohelper.findChild(self._gobrighten, i)

		table.insert(self._brightenPos, brighten)
	end

	self:initView()
end

function Activity134View:onDestroyView()
	self._simagefullbg:UnLoadImage()
	self._simagedetailbg:UnLoadImage()
	TaskDispatcher.cancelTask(self.cutAnimEnd, self)

	for _, v in ipairs(self.bonusItemList) do
		v:onDestroyView()
	end

	for _, v in ipairs(self.reportItemList) do
		v:onDestroy()
	end
end

function Activity134View:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo then
		local remainTime = actInfoMo:getRemainTimeStr2ByEndTime()

		self._txtremaintime.text = string.format(luaLang("remain"), remainTime)
	end
end

function Activity134View:onUpdateParam()
	self:refreshRemainTime()
end

function Activity134View:_onDailyRefresh()
	Activity134Rpc.instance:sendGet134InfosRequest(self.actId, function()
		Activity134TaskListModel.instance:sortTaskMoList()
	end)
end

function Activity134View:_onRefreshActivityState(actId)
	if string.nilorempty(actId) or actId == 0 then
		return
	end

	if actId ~= self.actId then
		return
	end

	local status = ActivityHelper.getActivityStatus(actId)

	local function yesCallback()
		ViewMgr.instance:closeView(ViewName.Activity134View)
	end

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, yesCallback)
	end
end

function Activity134View:initBonusItem()
	local path = self.viewContainer:getSetting().otherRes[2]
	local content = gohelper.findChild(self._scrollviewprogress.gameObject, "Viewport/Content")

	self.bonusItemList = {}

	local allstoryMo = Activity134Model.instance:getAllStoryMo()

	self._storyTabIndex = Activity134Model.instance:getFinishStoryCount()

	for i, v in ipairs(allstoryMo) do
		local child = self:getResInst(path, content, "bonus" .. i)
		local item = Activity134BonusItem.New()

		item:init(child.gameObject)
		item:initMo(i, v)
		item:refreshProgress()
		table.insert(self.bonusItemList, item)
	end
end

function Activity134View:CenterBonusItem(index)
	if index <= 1 then
		self._scrollviewprogress.horizontalNormalizedPosition = 0

		return
	elseif index >= self.storyTotalCount - 1 then
		self._scrollviewprogress.horizontalNormalizedPosition = 1

		return
	end

	self._scrollviewprogress.horizontalNormalizedPosition = index / self.storyTotalCount
end

function Activity134View:refreshBonusItem()
	for _, item in ipairs(self.bonusItemList) do
		item:refreshProgress()
	end
end

function Activity134View:refreshschedule()
	local maxCount = Activity134Model.instance:getMaxClueCount()
	local curCount = Activity134Model.instance:getClueCount()

	self._txtschedule.text = string.format("<color=#87f8db>%s</color>/%s", curCount, maxCount)
end

function Activity134View:initReportItem()
	local path = self.viewContainer:getSetting().otherRes[1]
	local content = gohelper.findChild(self._scrollviewright.gameObject, "Viewport/Content")
	local template = self:getResInst(path, content, "reportTemplate")

	self.goright = gohelper.findChild(template.gameObject, "#go_right")

	local right = gohelper.findChild(self.viewGO, "Right")

	self.goright.transform:SetParent(self._scrollviewright.transform, false)
	transformhelper.setLocalPosXY(self.goright.transform, 0, 255)

	self.reportItemList = {}

	local allstoryMo = Activity134Model.instance:getAllStoryMo()

	for i, v in ipairs(allstoryMo) do
		local child = gohelper.cloneInPlace(self._goreportitem, "report_" .. i)
		local childTemplate = gohelper.findChild(template, v.config.showTab)
		local item = Activity134ReportItem.New()

		item:init(childTemplate, child)
		item:initMo(i, v)
		table.insert(self.reportItemList, item)
	end
end

Activity134View.UI_CLICK_BLOCK_KEY = "Activity134TaskItemClick"

function Activity134View:cutReportTab(index, isAnim)
	self._curCutPage = index

	if isAnim then
		::label_20_0::

		local var_20_0 = self._storyTabIndex

		if self._storyTabIndex then
			local isPlayAnim = self._storyTabIndex ~= index

			TaskDispatcher.cancelTask(self.cutAnimEnd, self)

			if isPlayAnim then
				self.animatorPlayer:Stop()
				UIBlockMgr.instance:startBlock(Activity134View.UI_CLICK_BLOCK_KEY)

				if index < self._storyTabIndex then
					self.animatorPlayer:Play(Activity134Enum.AnimName.CutLeft, self.endAnimBlock, self)
				else
					self.animatorPlayer:Play(Activity134Enum.AnimName.CutRight, self.endAnimBlock, self)
				end

				TaskDispatcher.runDelay(self.cutAnimEnd, self, 0.3)
			else
				self:cutAnimEnd()
			end
		end
	end
end

function Activity134View:cutAnimEnd()
	if self._curCutPage then
		self:_onCutPageAnimEnd(self._curCutPage)

		if not self._brightenPos[self._curCutPage] then
			local brightenPos = self._godetailselect
			local posX, posY = brightenPos.transform.localPosition.x, brightenPos.transform.localPosition.y

			transformhelper.setLocalPosXY(self._godetailselect.transform, posX, posY)
		end
	end
end

function Activity134View:endAnimBlock()
	UIBlockMgr.instance:endBlock(Activity134View.UI_CLICK_BLOCK_KEY)
end

function Activity134View:_onCutPageAnimEnd(index)
	self._storyTabIndex = index

	self:updateDetailBg(index)
	self:updateSwitchBtn()

	self._scrollviewright.verticalNormalizedPosition = 1

	local formartPage = Activity134Model.instance:getFinishStoryCount() >= self.storyTotalCount and "%s/%s" or "%s/<color=#9ea099>%s</color>"

	self._txtpage.text = string.format(formartPage, index, self.storyTotalCount)

	local mo = Activity134Model.instance:getStoryMoByIndex(index)

	if not mo then
		for _, v in ipairs(self.reportItemList) do
			local go = v.viewGO

			gohelper.setActive(go, false)
		end

		gohelper.setActive(self._goIcon1, false)
		gohelper.setActive(self._goIcon2, false)

		return
	end

	local config = mo.config

	self._txtrightrecordtitle.text = config.title
	self._txtleftrecordtitle.text = config.title
	self._txtnum.text = config.number

	for _, v in ipairs(self.reportItemList) do
		local go = v.viewGO

		gohelper.setActive(go, index == v.mo.index)
	end

	local due = config.due

	self._txtdue.text = due and due or ""

	local isShowRight = config.showTab == "3"

	gohelper.setActive(self.goright, isShowRight)

	if config.storyType >= 3 then
		local introduce = string.split(config.introduce, "<split>")

		for i = 1, 3 do
			local desc = gohelper.findChildText(self.goright, i .. "/#txt_dec")
			local scrape = gohelper.findChild(self.goright, i .. "/img_scrape")

			desc.text = introduce[i]

			gohelper.setActive(scrape, false)
		end
	end

	local isIconType1 = config.storyType == 2 or config.storyType == 3

	gohelper.setActive(self._goIcon1, isIconType1)
	gohelper.setActive(self._goIcon2, not isIconType1)
end

function Activity134View:updateSwitchBtn()
	local storyCount = Activity134Model.instance:getFinishStoryCount()

	gohelper.setActive(self._goleftswitchboundary, self._storyTabIndex <= 1)
	gohelper.setActive(self._gorightswitchboundary, storyCount <= self._storyTabIndex)
	gohelper.setActive(self._goleftswitchnormal, self._storyTabIndex > 1)
	gohelper.setActive(self._gorightswitchnormal, storyCount > self._storyTabIndex)
end

function Activity134View:updateDetailBg(index)
	local isHasStory = self._storyTabIndex > 0 and self._storyTabIndex <= 6

	gohelper.setActive(self._godetailselect, isHasStory)
	gohelper.setActive(self._goemptydetail, not isHasStory)

	if isHasStory then
		index = self._storyTabIndex
	end

	local icon = "v1a4_dustyrecords_" .. index

	self._simagedetailbg:LoadImage(ResUrl.getV1a4DustRecordsIcon(icon))
end

function Activity134View:initView()
	self._curCutPage = nil

	self:initBonusItem()
	self:initReportItem()

	local isHas = Activity134Model.instance:checkGetStoryBonus()

	self:refreshView()
	self:refreshRemainTime()
	recthelper.setWidth(self._gofill.transform, Activity134Model.instance:getBonusFillWidth())
end

function Activity134View:refreshView(isAnim)
	self:refreshBonusItem()

	local tab = Activity134Model.instance:getFinishStoryCount()

	self:cutReportTab(tab, isAnim)
	self:CenterBonusItem(tab)
	self:refreshschedule()
end

function Activity134View:getBonusEvent()
	self:refreshView(true)
end

function Activity134View:currencyChangeEvent(ids)
	local currency = ids[CurrencyEnum.CurrencyType.Act134Clue]

	if not currency then
		return
	end

	self:refreshschedule()

	local isHas = Activity134Model.instance:checkGetStoryBonus()

	if isHas then
		self:refreshView(true)
	end

	recthelper.setWidth(self._gofill.transform, Activity134Model.instance:getBonusFillWidth())
end

return Activity134View
