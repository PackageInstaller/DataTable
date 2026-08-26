-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0StoryView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0StoryView", package.seeall)

local Season123_2_0StoryView = class("Season123_2_0StoryView", BaseView)

function Season123_2_0StoryView:onInitView()
	self._gocoverPage = gohelper.findChild(self.viewGO, "Root/#go_coverPage")
	self._txtcoverTitle = gohelper.findChildText(self.viewGO, "Root/#go_coverPage/Left/Title/txt_Title")
	self._txttitleDesc = gohelper.findChildText(self.viewGO, "Root/#go_coverPage/Left/#txt_titleDesc")
	self._simageCover = gohelper.findChildSingleImage(self.viewGO, "Root/#go_coverPage/Left/#simage_Cover")
	self._gocoverContent = gohelper.findChild(self.viewGO, "Root/#go_coverPage/Right/#go_coverContent")
	self._gocoverItem = gohelper.findChild(self.viewGO, "Root/#go_coverPage/Right/#go_coverContent/#go_coverItem")
	self._godetailPage = gohelper.findChild(self.viewGO, "Root/#go_detailPage")
	self._txtdetailTitle = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Left/Title/#txt_detailTitle")
	self._simagePolaroid = gohelper.findChildSingleImage(self.viewGO, "Root/#go_detailPage/Left/#simage_Polaroid")
	self._txtdetailPageTitle = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Right/#txt_detailPageTitle")
	self._txtAuthor = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Right/#txt_Author")
	self._scrollDesc = gohelper.findChildScrollRect(self.viewGO, "Root/#go_detailPage/Right/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Right/#scroll_desc/Viewport/#txt_desc")
	self._goarrow = gohelper.findChild(self.viewGO, "Root/#go_detailPage/Right/#go_arrow")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self._goLeftTop = gohelper.findChild(self.viewGO, "#go_LeftTop")
	self._animView = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0StoryView:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.OnCoverItemClick, self.onCoverItemClick, self)
end

function Season123_2_0StoryView:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self.removeEventCb(self, Season123Controller.instance, Season123Event.OnCoverItemClick, self.onCoverItemClick, self)
end

function Season123_2_0StoryView:_btnLeftOnClick()
	self.curPageIndex = Mathf.Max(0, self.curPageIndex - 1)

	if self.curPageIndex == 0 then
		self:showSwitchPageAnim("tocover")
	else
		self:showSwitchPageAnim("toleft")
	end
end

function Season123_2_0StoryView:_btnRightOnClick()
	local nextPageIndex = math.min(self.curPageIndex + 1, self.maxPageIndex)
	local nextPageItem = self.coverItemList[nextPageIndex].item

	if nextPageItem.isUnlock then
		self.curPageIndex = Mathf.Min(self.curPageIndex + 1, self.maxPageIndex)

		if self.curPageIndex == 1 then
			self:showSwitchPageAnim("todetail")
		else
			self:showSwitchPageAnim("toright")
		end
	else
		GameFacade.showToast(ToastEnum.SeasonStageNotPass)
	end
end

function Season123_2_0StoryView:_editableInitView()
	self.coverItemTab = self:getUserDataTb_()
	self.coverItemList = self:getUserDataTb_()
	self.unlockStateTab = self:getUserDataTb_()
	self.saveUnlockStateTab = self:getUserDataTb_()

	gohelper.setActive(self._gocoverItem, false)

	self.transScrollDesc = self._scrollDesc.gameObject:GetComponent(gohelper.Type_RectTransform)
end

function Season123_2_0StoryView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_role_culture_open)

	self.actId = self.viewParam.actId
	self.allStoryConfig = Season123Config.instance:getAllStoryCo(self.actId)
	self.maxPageIndex = GameUtil.getTabLen(self.allStoryConfig)
	self.curPageIndex = 0

	self:initCoverPageUI()
	self:createCoverItem()
	self:refreshUI()
end

function Season123_2_0StoryView:refreshUI()
	gohelper.setActive(self._gocoverPage, true)
	gohelper.setActive(self._godetailPage, self.curPageIndex > 0)
	gohelper.setActive(self._btnLeft.gameObject, self.curPageIndex > 0)

	local nextPageIndex = math.min(self.curPageIndex + 1, self.maxPageIndex)
	local nextPageIsUnlocked = self.coverItemList[nextPageIndex].item.isUnlock

	ZProj.UGUIHelper.SetColorAlpha(self._btnRight.gameObject:GetComponent(typeof(UnityEngine.UI.Image)), nextPageIsUnlocked and 1 or 0.2)
	gohelper.setActive(self._btnRight.gameObject, self.curPageIndex < self.maxPageIndex)

	if self.curPageIndex > 0 then
		self:refreshDetailPageUI()
	end

	self:refreshUnlockState()
	self:fitScrollHeight()
end

function Season123_2_0StoryView:initCoverPageUI()
	local coverIconUrl = string.format("singlebg/%s", Season123Config.instance:getSeasonConstStr(self.actId, Activity123Enum.Const.StoryCoverIconUrl))

	self._simageCover:LoadImage(coverIconUrl)

	self._txttitleDesc.text = Season123Config.instance:getSeasonConstStr(self.actId, Activity123Enum.Const.StoryCoverDesc)
	self._txtcoverTitle.text = Season123Config.instance:getSeasonConstStr(self.actId, Activity123Enum.Const.StoryCoverTitle)
end

function Season123_2_0StoryView:refreshDetailPageUI()
	local storyConfig = Season123Config.instance:getStoryConfig(self.actId, self.curPageIndex)

	self._txtdetailTitle.text = GameUtil.setFirstStrSize(storyConfig.title, 80)

	local iconUrl = Season123ViewHelper.getIconUrl("singlebg/%s_season_singlebg/storycover/%s.png", storyConfig.picture, self.actId)

	self._simagePolaroid:LoadImage(iconUrl)

	self._txtdetailPageTitle.text = storyConfig.subTitle
	self._txtAuthor.text = storyConfig.subContent

	gohelper.setActive(self._txtAuthor.gameObject, not string.nilorempty(storyConfig.subContent))
	recthelper.setHeight(self._scrollDesc.gameObject.transform, string.nilorempty(storyConfig.subContent) and 705 or 585)

	self._scrollDesc.verticalNormalizedPosition = 1
	self._txtdesc.text = storyConfig.content
end

function Season123_2_0StoryView:createCoverItem()
	local allStoryConfig = Season123Config.instance:getAllStoryCo(self.actId)

	for storyId, storyConfig in pairs(allStoryConfig) do
		local coverItem = self.coverItemTab[storyId]

		if not coverItem then
			coverItem = {
				go = gohelper.clone(self._gocoverItem, self._gocoverContent, "cover" .. storyId)
			}
			coverItem.item = MonoHelper.addNoUpdateLuaComOnceToGo(coverItem.go, Season123_2_0StoryCoverItem, {
				actId = self.actId,
				storyId = storyId,
				storyConfig = storyConfig
			})
			self.coverItemTab[storyId] = coverItem

			table.insert(self.coverItemList, coverItem)
		end

		coverItem.item:refreshItem()

		self.unlockStateTab[storyId] = coverItem.item.isUnlock

		gohelper.setActive(coverItem.go, true)
	end
end

function Season123_2_0StoryView:refreshUnlockState()
	local saveStr = PlayerPrefsHelper.getString(self:getLocalKey(), "")

	if not string.nilorempty(saveStr) then
		for _, unlockStateStr in ipairs((cjson.decode(saveStr))) do
			local param = string.split(unlockStateStr, "|")
			local id = tonumber(param[1])

			self.saveUnlockStateTab[id] = self:setStrToBool(param[2])
		end
	end

	for storyId, coverItem in pairs(self.coverItemTab) do
		if GameUtil.getTabLen(self.saveUnlockStateTab) == 0 then
			coverItem.item:refreshUnlockState(false)
		else
			local saveUnlockState = self.saveUnlockStateTab[storyId]

			coverItem.item:refreshUnlockState(saveUnlockState)
		end
	end

	self:saveUnlockState()
end

function Season123_2_0StoryView:getLocalKey()
	return "Season123StoryUnlock" .. "#" .. tostring(self.actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function Season123_2_0StoryView:saveUnlockState()
	local stateSaveStrTab = {}

	for storyId, unlockState in ipairs(self.unlockStateTab) do
		local saveStr = string.format("%s|%s", storyId, unlockState)

		table.insert(stateSaveStrTab, saveStr)
	end

	PlayerPrefsHelper.setString(self:getLocalKey(), cjson.encode(stateSaveStrTab))
end

function Season123_2_0StoryView:setStrToBool(unlockStateStr)
	if string.nilorempty(unlockStateStr) then
		return false
	elseif unlockStateStr == "true" then
		return true
	else
		return false
	end
end

function Season123_2_0StoryView:onCoverItemClick(param)
	self.curPageIndex = param.storyId

	self:showSwitchPageAnim("todetail")
end

function Season123_2_0StoryView:showSwitchPageAnim(animName)
	self._animView.enabled = true

	self._animView:Play(animName, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_screenplay_photo_close)
	UIBlockMgr.instance:startBlock("playSwitchPageAnim")
	TaskDispatcher.runDelay(self.refreshPage, self, 0.3)
end

function Season123_2_0StoryView:refreshPage()
	UIBlockMgr.instance:endBlock("playSwitchPageAnim")
	self:refreshUI()
end

Season123_2_0StoryView.scrollDescHeight = 650
Season123_2_0StoryView.maxDescSpacing = 41
Season123_2_0StoryView.minDescSpacing = 35
Season123_2_0StoryView.minDescFontSize = 27

function Season123_2_0StoryView:fitScrollHeight()
	local singleAuthorHeight = ZProj.GameHelper.GetTmpLineHeight(self._txtAuthor, 1)
	local heightOffset = self._txtAuthor.preferredHeight - singleAuthorHeight

	recthelper.setHeight(self.transScrollDesc, Season123_2_0StoryView.scrollDescHeight - heightOffset)

	self._txtdesc.enableAutoSizing = true

	TaskDispatcher.cancelTask(self.setDescSpacing, self)
	TaskDispatcher.runDelay(self.setDescSpacing, self, 0.01)
end

function Season123_2_0StoryView:setDescSpacing()
	local fontSize = self._txtdesc.fontSize

	self._txtdesc.lineSpacing = Mathf.Lerp(Season123_2_0StoryView.maxDescSpacing, Season123_2_0StoryView.minDescSpacing, self._txtdesc.fontSize - Season123_2_0StoryView.minDescFontSize)
	self._txtdesc.enableAutoSizing = false
	self._txtdesc.fontSize = fontSize
end

function Season123_2_0StoryView:onClose()
	self:saveUnlockState()
	TaskDispatcher.cancelTask(self.refreshPage, self)
	UIBlockMgr.instance:endBlock("playSwitchPageAnim")
	Season123Controller.instance:checkHasReadUnlockStory(self.actId)
	TaskDispatcher.cancelTask(self.setDescSpacing, self)
end

function Season123_2_0StoryView:onDestroyView()
	self._simageCover:UnLoadImage()
	self._simagePolaroid:UnLoadImage()
end

return Season123_2_0StoryView
