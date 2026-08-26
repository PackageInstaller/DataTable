-- chunkname: @modules/logic/versionactivity2_8/act200/view/Activity2ndTakePhotosView.lua

module("modules.logic.versionactivity2_8.act200.view.Activity2ndTakePhotosView", package.seeall)

local Activity2ndTakePhotosView = class("Activity2ndTakePhotosView", BaseView)

function Activity2ndTakePhotosView:onInitView()
	self._gocategory = gohelper.findChild(self.viewGO, "#go_category")
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "#go_category/#scroll_category")
	self._gocategorycontent = gohelper.findChild(self.viewGO, "#go_category/#scroll_category/viewport/content")
	self._gocategoryitem = gohelper.findChild(self.viewGO, "#go_category/#scroll_category/viewport/content/#go_categoryitem")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#txt_LimitTime")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Bottom/txt_dec")
	self._simagephoto = gohelper.findChildSingleImage(self.viewGO, "#simage_photo")
	self._btnshot = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_shot")
	self._simageframe = gohelper.findChildSingleImage(self.viewGO, "Success/#simage_frame")
	self._simagesuccessphoto = gohelper.findChildSingleImage(self.viewGO, "Success/#simage_photo")
	self._goshoted = gohelper.findChild(self.viewGO, "Success/#go_shoted")
	self._simagephotoSmall = gohelper.findChildSingleImage(self.viewGO, "Bottom/#simage_photoSmall")
	self._gorewardicon = gohelper.findChild(self.viewGO, "Bottom/#go_rewarditem/go_icon")
	self._gorewardreceive = gohelper.findChild(self.viewGO, "Bottom/#go_rewarditem/go_receive")
	self._gorewarditem = gohelper.findChild(self.viewGO, "Bottom/#go_rewarditem")
	self._gosuccess = gohelper.findChild(self.viewGO, "Success")
	self._goerror = gohelper.findChild(self.viewGO, "Fail")
	self._goshotframe = gohelper.findChild(self.viewGO, "#simage_photo/shotFrame")
	self._gonormal = gohelper.findChild(self.viewGO, "#simage_photo/shotFrame/normal")
	self._gowrong = gohelper.findChild(self.viewGO, "#simage_photo/shotFrame/wrong")
	self._btnclickphoto = gohelper.findChildButton(self.viewGO, "#simage_photo/#btn_clickpoto")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._shotAnimator = self._gonormal:GetComponent(typeof(UnityEngine.Animator))
	self._successAnimator = self._gosuccess:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gocategoryitem, false)

	self._categoryitemList = {}
	self._showErrorTime = 2
	self._switchAnimTime = 0.5
	self._shotFocusTime = 0.25
	self._successTime = 1.5
	self._isError = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity2ndTakePhotosView:addEvents()
	self._btnshot:AddClickListener(self._btnshotOnClick, self)
	self._btnclickphoto:AddClickListener(self._clickPhoto, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Activity2ndTakePhotosView:removeEvents()
	self._btnshot:RemoveClickListener()
	self._btnclickphoto:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function Activity2ndTakePhotosView:_btnshotOnClick()
	local temp = not string.nilorempty(self.config.position) and string.splitToNumber(self.config.position, "#")
	local pos = {
		x = temp[1],
		y = temp[2]
	}

	if Activity2ndTakePhotosHelper.checkPhotoAreaMoreGoal(self.rectshotframe, pos) then
		gohelper.setActive(self._gosuccess, true)
		self._successAnimator:Play("open", 0, 0)
		self:_refreshPhotoPanel(true)
		TaskDispatcher.runDelay(self._showSuccess, self, self._successTime)
		Activity2ndController.instance:statTakePhotos(self._currentIndex, true)
		AudioMgr.instance:trigger(AudioEnum2_8.TakePhotosActivity.play_ui_diqiu_yure_success_20249043)
	else
		self._isError = true

		gohelper.setActive(self._goerror, true)
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._gowrong, true)
		TaskDispatcher.runDelay(self._showError, self, self._showErrorTime)
		Activity2ndController.instance:statTakePhotos(self._currentIndex, false)
		AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_wrong)
	end
end

function Activity2ndTakePhotosView:_showSuccess()
	TaskDispatcher.cancelTask(self._showSuccess, self)
	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(self._actId, self._currentIndex, 0)
end

function Activity2ndTakePhotosView:_showError()
	TaskDispatcher.cancelTask(self._showError, self)

	self._isError = false

	gohelper.setActive(self._goerror, false)
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._gowrong, false)
end

function Activity2ndTakePhotosView:_editableInitView()
	self.rectSimagePhoto = self._simagephoto.transform
	self.rectshotframe = self._goshotframe.transform

	recthelper.setAnchor(self.rectshotframe, 0, 0)
end

function Activity2ndTakePhotosView:_initCategoryItem()
	local configList = Activity2ndConfig.instance:getAct200ConfigList()

	if not configList then
		return logError("没有拍照活动配置")
	end

	local topspace = 30
	local bottomspace = 50
	local itemspace = 46

	self.scrollHeight = recthelper.getHeight(self._scrollcategory.transform)
	self._itemHeight = 120
	self._selectItemHeight = 132

	local count = #configList

	self._contentHeight = self._selectItemHeight + self._itemHeight * (count - 1) + (count - 1) * itemspace + topspace + bottomspace
	self._canMoveHeight = math.max(0, self._contentHeight - self.scrollHeight)

	for index, co in ipairs(configList) do
		local item = self._categoryitemList[index]

		if not item then
			item = self:getUserDataTb_()
			item.co = co
			item.index = index
			item.go = gohelper.clone(self._gocategoryitem, self._gocategorycontent, "categoryitem" .. index)
			item.goselect = gohelper.findChild(item.go, "#go_select")
			item.txtselect = gohelper.findChildText(item.go, "#go_select/#txt_select")
			item.gounselect = gohelper.findChild(item.go, "#txt_unselect")
			item.txtunselect = gohelper.findChildText(item.go, "#txt_unselect")
			item.golocked = gohelper.findChild(item.go, "#txt_locked")
			item.txtlocked = gohelper.findChildText(item.go, "#txt_locked")
			item.btnclick = gohelper.findChildButtonWithAudio(item.go, "#btn_click")

			item.btnclick:AddClickListener(self._clickCategoryItem, self, item)
			gohelper.setActive(item.go, true)
			table.insert(self._categoryitemList, item)
		end
	end

	self:_autoSelectTab()
end

function Activity2ndTakePhotosView:_clickCategoryItem(item)
	local index = item.index
	local curSelectedIndex = self:getCurSelectedEpisode()
	local isOpen, remainDay, remainTime = Activity125Model.instance:isEpisodeDayOpen(self._actId, index)

	if not isOpen then
		if remainDay < 1 then
			local time, suffix = TimeUtil.secondToRoughTime2(remainTime)
			local timestr = time .. suffix

			GameFacade.showToastString(formatLuaLang("season123_overview_unlocktime_custom", timestr))
		else
			GameFacade.showToast(ToastEnum.TakePhotoUnlockDay, remainDay)
		end

		return
	end

	local isTargetSelectEpisodeUnLock = Activity125Model.instance:isEpisodeUnLock(self._actId, index)

	if not isTargetSelectEpisodeUnLock then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	if curSelectedIndex ~= index then
		Activity125Model.instance:setSelectEpisodeId(self._actId, index)

		self._currentIndex = index

		self._animator:Play("switch", 0, 0)
		self:_refreshItemList()
		self:_initPanelState()
		TaskDispatcher.runDelay(self._onSwitchFinish, self, self._switchAnimTime)
		AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)
	end
end

function Activity2ndTakePhotosView:_onSwitchFinish()
	TaskDispatcher.cancelTask(self._onSwitchFinish, self)
	self:_refreshUI()
	TaskDispatcher.runDelay(self._onOpenFinish, self, self._shotFocusTime)
	recthelper.setAnchor(self.rectshotframe, 0, 0)
end

function Activity2ndTakePhotosView:_initPanelState()
	gohelper.setActive(self._gosuccess, false)
end

function Activity2ndTakePhotosView:_refreshCategoryItem(item)
	local isSelect = item.index == self:getCurSelectedEpisode()
	local unlock, remainDay, remainTime = Activity125Model.instance:isEpisodeDayOpen(self._actId, item.index)
	local isFinish = Activity125Model.instance:isEpisodeFinished(self._actId, item.index)

	gohelper.setActive(item.goselect, isSelect and unlock)
	gohelper.setActive(item.gounselect, not isSelect and unlock)
	gohelper.setActive(item.golocked, not unlock)

	local color = isFinish and "#c66030" or "D7D7D7"

	item.txtselect.color = GameUtil.parseColor(color)
	item.txtselect.text = item.co.name
	item.txtunselect.text = item.co.name
	item.txtunselect.color = GameUtil.parseColor(color)

	if not unlock then
		item.txtlocked.text = formatLuaLang("versionactivity_1_2_119_unlock", remainDay)

		if remainDay < 1 then
			local time, suffix = TimeUtil.secondToRoughTime2(remainTime)
			local timestr = time .. suffix

			item.txtlocked.text = formatLuaLang("season123_overview_unlocktime_custom", timestr)
		end
	end
end

function Activity2ndTakePhotosView:_refreshItemList()
	for index, item in ipairs(self._categoryitemList) do
		self:_refreshCategoryItem(item)
	end
end

function Activity2ndTakePhotosView:_refreshPhotoPanel(isfake)
	local isSuccess = Activity125Model.instance:isEpisodeFinished(self._actId, self:getCurSelectedEpisode())
	local isSuccess

	if isfake then
		isSuccess = true
	end

	gohelper.setActive(self._gosuccess, isSuccess)
	gohelper.setActive(self._btnshot.gameObject, not isSuccess)
	gohelper.setActive(self._goshotframe, not isSuccess)

	local photoName = "v2a8_gift_photo_"
	local smallPhotoName = "v2a8_gift_smallphoto_"

	photoName = isSuccess and photoName .. self._currentIndex .. "_1" .. ".jpg" or photoName .. self._currentIndex .. ".jpg"
	smallPhotoName = isSuccess and smallPhotoName .. self._currentIndex .. "_1" .. ".png" or smallPhotoName .. self._currentIndex .. ".png"

	if isSuccess then
		self._simagesuccessphoto:LoadImage(ResUrl.getActivity2ndTakePhotoSingleBg(photoName))
	end

	self._simagephoto:LoadImage(ResUrl.getActivity2ndTakePhotoSingleBg(photoName))
	self._simagephotoSmall:LoadImage(ResUrl.getActivity2ndTakePhotoSingleBg(smallPhotoName))

	if isSuccess then
		self._txtdesc.text = self.config.text or luaLang("p_v2a8_gift_fullview_txt_dec")
	end
end

function Activity2ndTakePhotosView:_refreshReward()
	local isSuccess = Activity125Model.instance:isEpisodeFinished(self._actId, self:getCurSelectedEpisode())

	self.rewardcomp = self.rewardcomp or IconMgr.instance:getCommonPropItemIcon(self._gorewardicon)

	if self.config then
		local reawrdco = self.config.bonus

		if reawrdco and not string.nilorempty(reawrdco) then
			local bonus = string.splitToNumber(reawrdco, "#")

			self.rewardcomp:setMOValue(bonus[1], bonus[2], bonus[3], nil, true)
		end

		gohelper.setActive(self._gorewardreceive, isSuccess)
	end
end

function Activity2ndTakePhotosView:_refreshUI()
	self.config = Activity2ndConfig.instance:getAct200ConfigById(self._currentIndex)
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)

	self:_refreshPhotoPanel()
	self:_refreshItemList()
	self:_refreshReward()

	if not self.config then
		logError("没有关卡" .. self._currentIndex .. "的配置")
	end
end

function Activity2ndTakePhotosView:_onRewardRefresh(viewName)
	if viewName == ViewName.CommonPropView then
		gohelper.setActive(self._gorewardreceive, true)
		self:_refreshItemList()
		self:_checkLastOpenIndexHeight()
	end
end

function Activity2ndTakePhotosView:_checkLastOpenIndexHeight()
	local mo = Activity125Model.instance:getById(self._actId)
	local hadmoveY = recthelper.getAnchorY(self._gocategorycontent.transform)
	local lastUnlockIndex = mo:getFirstRewardEpisode()
	local topspace = 30
	local itemspace = 46
	local height = 0

	if lastUnlockIndex > 1 then
		height = self._selectItemHeight + self._itemHeight * (lastUnlockIndex - 2) + (lastUnlockIndex - 1) * itemspace + topspace
	end

	if hadmoveY + height > self.scrollHeight then
		local moveY = height - self.scrollHeight + hadmoveY + self._itemHeight

		recthelper.setAnchorY(self._gocategorycontent.transform, moveY)
	end
end

function Activity2ndTakePhotosView:_clickPhoto()
	self._shotAnimator:Play("open", 0, 0)

	local clickPos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self.rectSimagePhoto)

	self:_checkShotFramePosAvailable(clickPos)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_choose)
end

function Activity2ndTakePhotosView:_checkShotFramePosAvailable(clickPos)
	local pos = Activity2ndTakePhotosHelper.ClampPosition(self.rectSimagePhoto, self.rectshotframe, clickPos)

	recthelper.setAnchor(self.rectshotframe, pos.x, pos.y)
end

function Activity2ndTakePhotosView:_onDailyRefresh()
	if self._actId then
		Activity125Controller.instance:getAct125InfoFromServer(self._actId)
	end
end

function Activity2ndTakePhotosView:getCurSelectedEpisode()
	return Activity125Model.instance:getSelectEpisodeId(self._actId) or 1
end

function Activity2ndTakePhotosView:onUpdateParam()
	return
end

function Activity2ndTakePhotosView:onOpen()
	self._actId = self.viewParam.actId

	self:_initCategoryItem()

	local mo = Activity125Model.instance:getById(self._actId)

	self._currentIndex = mo:getFirstRewardEpisode()

	Activity125Model.instance:setSelectEpisodeId(self._actId, self._currentIndex)
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._gowrong, false)
	TaskDispatcher.runDelay(self._onOpenFinish, self, self._shotFocusTime)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Enter.play_ui_jinye_unfold)
	self:_refreshUI()
end

function Activity2ndTakePhotosView:_onOpenFinish()
	TaskDispatcher.cancelTask(self._onOpenFinish, self)
	self._shotAnimator:Play("open", 0, 0)
end

function Activity2ndTakePhotosView:onClose()
	TaskDispatcher.cancelTask(self._onSwitchFinish, self)
	TaskDispatcher.cancelTask(self._onOpenFinish, self)
	TaskDispatcher.cancelTask(self._showError, self)
	TaskDispatcher.cancelTask(self._showSuccess, self)

	for _, item in ipairs(self._categoryitemList) do
		item.btnclick:RemoveClickListener()
	end
end

function Activity2ndTakePhotosView:_autoSelectTab()
	local mo = Activity125Model.instance:getById(self._actId)
	local lastUnlockIndex = mo:getFirstRewardEpisode() - 1
	local topspace = 30
	local itemspace = 46
	local height = 0

	if lastUnlockIndex > 1 then
		height = self._selectItemHeight + self._itemHeight * (lastUnlockIndex - 2) + (lastUnlockIndex - 1) * itemspace + topspace
	end

	if height > self._canMoveHeight then
		height = self._canMoveHeight
	end

	recthelper.setAnchorY(self._gocategorycontent.transform, height)
end

function Activity2ndTakePhotosView:onDestroyView()
	return
end

function Activity2ndTakePhotosView:onRefreshActivity()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.NotOnLine or status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

return Activity2ndTakePhotosView
