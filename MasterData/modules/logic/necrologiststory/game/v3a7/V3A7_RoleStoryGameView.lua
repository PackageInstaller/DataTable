-- chunkname: @modules/logic/necrologiststory/game/v3a7/V3A7_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v3a7.V3A7_RoleStoryGameView", package.seeall)

local V3A7_RoleStoryGameView = class("V3A7_RoleStoryGameView", BaseView)

function V3A7_RoleStoryGameView:onInitView()
	self._gomapitem = gohelper.findChild(self.viewGO, "Left/TabContent/#go_mapitem")
	self._gofinished = gohelper.findChild(self.viewGO, "Left/#go_finished")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_start")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_restart")
	self._gonormal = gohelper.findChild(self.viewGO, "Right/#go_normal")
	self._golevel3right = gohelper.findChild(self.viewGO, "Right/#go_level_3_right")
	self._golevel3itemright = gohelper.findChild(self.viewGO, "Right/#go_level_3_right/ScrollView/Viewport/Content/GameObject/#go_level_3_item_right")
	self._goprogress1 = gohelper.findChild(self.viewGO, "Right/#go_level_3_right/progressbg/#go_progress_1")
	self._golevel6right = gohelper.findChild(self.viewGO, "Right/#go_level_6_right")
	self._golevel6itemright = gohelper.findChild(self.viewGO, "Right/#go_level_6_right/ScrollView/Viewport/Content/GameObject/#go_level_6_item_right")
	self._golevel3 = gohelper.findChild(self.viewGO, "Panel/#go_level_3")
	self._txtprogress = gohelper.findChildText(self.viewGO, "Panel/#go_level_3/txt_tips/#txt_progress")
	self._golevel3item = gohelper.findChild(self.viewGO, "Panel/#go_level_3/ScrollView/Viewport/Content/GameObject/#go_level_3_item")
	self._goprogress = gohelper.findChild(self.viewGO, "Panel/#go_level_3/progressbg/#go_progress")
	self._golevel6 = gohelper.findChild(self.viewGO, "Panel/#go_level_6")
	self._golevel6item = gohelper.findChild(self.viewGO, "Panel/#go_level_6/ScrollView/Viewport/Content/GameObject/#go_level_6_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A7_RoleStoryGameView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A7_RoleStoryGameView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A7_RoleStoryGameView:_btnstartOnClick()
	self.nextUnLockLevel = self.gameBaseMO:getNextLockLevel(self._selectLevelId)

	NecrologistStoryController.instance:openStoryView(self._selectLevelConfig.storyId, self.gameBaseMO.id)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_yzge_yishi_interface_noise)
end

function V3A7_RoleStoryGameView:_btnrestartOnClick()
	NecrologistStoryController.instance:openStoryView(self._selectLevelConfig.storyId, self.gameBaseMO.id)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_yzge_yishi_interface_noise)
end

function V3A7_RoleStoryGameView:_editableInitView()
	self._goItemParent = gohelper.findChild(self.viewGO, "Left/TabContent")
	self._goMapRotate = gohelper.findChild(self.viewGO, "Middle/#map/#rotate").transform
	self._gofinishedAni = self._gofinished:GetComponent(gohelper.Type_Animator)
	self._goLevel3Ani = self._golevel3:GetComponent(gohelper.Type_Animator)
	self._goLevel6Ani = self._golevel6:GetComponent(gohelper.Type_Animator)
	self._goprogress3Go = gohelper.findChild(self.viewGO, "Right/#go_level_3_right/progressbg")
	self.goContent3 = gohelper.findChild(self.viewGO, "Panel/#go_level_3/ScrollView/Viewport/Content")
	self.goContent6 = gohelper.findChild(self.viewGO, "Panel/#go_level_6/ScrollView/Viewport/Content")
end

function V3A7_RoleStoryGameView:refreshParam()
	local storyId = self.viewParam.roleStoryId

	if self.gameBaseMO == nil then
		self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
	end
end

function V3A7_RoleStoryGameView:onOpen()
	self:refreshParam()

	self._allLevelItem = self:getUserDataTb_()

	local allLevelIds = NecrologistStoryV3A7Config.instance:getBaseList()

	self._selectLevelId = self.gameBaseMO:getLastUnLockLevel()
	self._selectLevelConfig = NecrologistStoryV3A7Config.instance:getBaseConfig(self._selectLevelId)

	gohelper.CreateObjList(self, self._onCreateLevelItem, allLevelIds, self._goItemParent, self._gomapitem)
	self:refreshView()
	gohelper.setActive(self._golevel3, false)
	gohelper.setActive(self._golevel6, false)
	self:_initItem()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_yzge_yishi_interface_noise)
end

function V3A7_RoleStoryGameView:setSelectLevelId(levelId, needAni)
	if levelId == nil then
		return
	end

	local state = self.gameBaseMO:getLevelState(levelId)

	if state == NecrologistStoryEnum.StoryState.Lock then
		GameFacade.showToast(ToastEnum.V3A7YiShiLevelLockTip)

		return
	end

	self._selectLevelId = levelId
	self._selectLevelConfig = NecrologistStoryV3A7Config.instance:getBaseConfig(levelId)

	self:refreshView(needAni)
end

local ZProj_TweenHelper = ZProj.TweenHelper

function V3A7_RoleStoryGameView:refreshView(needAni)
	if self._allLevelItem then
		local count = tabletool.len(self._allLevelItem)

		for i = 1, count do
			local item = self._allLevelItem[i]

			if item then
				local isSelect = item.levelId == self._selectLevelId
				local isLock = self.gameBaseMO:getStoryState(item.storyId) == NecrologistStoryEnum.StoryState.Lock

				gohelper.setActive(item.selectGo, isSelect)
				gohelper.setActive(item.unSelectGo, not isSelect)
				gohelper.setActive(item.lockGo, isLock)

				if isSelect and not isLock and needAni and self.nextUnLockLevel ~= nil and self.nextUnLockLevel == item.levelId then
					item.anim:Play("unlock", 0, 0)

					self.nextUnLockLevel = nil
				end
			end
		end
	end

	local state = self.gameBaseMO:getLevelState(self._selectLevelId)
	local isFinish = state == NecrologistStoryEnum.StoryState.Finish

	gohelper.setActive(self._btnstart.gameObject, state == NecrologistStoryEnum.StoryState.Normal or state == NecrologistStoryEnum.StoryState.Reading)
	gohelper.setActive(self._btnrestart.gameObject, isFinish)
	gohelper.setActive(self._gofinished, self.gameBaseMO:allLevelIsFinish())

	if needAni and self._gofinishedAni then
		self._gofinishedAni:Play("finish", 0, 0)
	end

	local firstSp = self.gameBaseMO:isFirstSpLevel(self._selectLevelId)
	local lastSp = self.gameBaseMO:isLastSpLevel(self._selectLevelId)

	if firstSp or lastSp then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_yzge_yishi_spam_short)
	end

	gohelper.setActive(self._golevel3right, firstSp)
	gohelper.setActive(self._goprogress3Go, firstSp and isFinish)
	gohelper.setActive(self._golevel6right, lastSp)
	gohelper.setActive(self._gonormal, not firstSp and not lastSp)

	local rotate = self._selectLevelConfig.mapRotate

	self._tweenId = ZProj_TweenHelper.DOLocalRotate(self._goMapRotate, 54.09, -54.7, rotate, 0.5, self._beginMove, self, EaseType.InOutQuart)

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_yzge_yishi_planet_rotates)
end

function V3A7_RoleStoryGameView:_onCreateLevelItem(obj, levelConfig, _)
	local item = {}
	local storyGroupConfig = NecrologistStoryConfig.instance:getPlotGroupCo(levelConfig.storyId)

	item.go = obj
	item.levelId = levelConfig.id
	item.selectGo = gohelper.findChild(obj, "select")
	item.lockGo = gohelper.findChild(obj, "lock")
	item.unSelectGo = gohelper.findChild(obj, "unselect")
	item.anim = obj:GetComponent(gohelper.Type_Animator)

	local clickGo = gohelper.findChild(obj, "click")
	local click = gohelper.getClick(clickGo)

	click:AddClickListener(function()
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_yzge_yishi_click)
		self:setSelectLevelId(item.levelId)
	end, self)

	item.click = click

	local nameText1 = gohelper.findChildText(obj, "unselect/txt_name")
	local nameText2 = gohelper.findChildText(obj, "lock/txt_name")
	local nameText3 = gohelper.findChildText(obj, "select/txt_name")
	local selectNormal = gohelper.findChild(obj, "select/go_namebg/normal")
	local selectSpe = gohelper.findChild(obj, "select/go_namebg/special")
	local lockNormal = gohelper.findChild(obj, "lock/go_namebg/normal")
	local lockSpe = gohelper.findChild(obj, "lock/go_namebg/special")
	local unSelectNormal = gohelper.findChild(obj, "unselect/go_namebg/normal")
	local unSelectSpe = gohelper.findChild(obj, "unselect/go_namebg/special")
	local firstSp = self.gameBaseMO:isFirstSpLevel(item.levelId)
	local lastSp = self.gameBaseMO:isLastSpLevel(item.levelId)
	local isSp = firstSp or lastSp

	gohelper.setActive(selectNormal, not isSp)
	gohelper.setActive(unSelectNormal, not isSp)
	gohelper.setActive(lockNormal, not isSp)
	gohelper.setActive(unSelectSpe, isSp)
	gohelper.setActive(lockSpe, isSp)
	gohelper.setActive(selectSpe, isSp)

	nameText1.text = storyGroupConfig.storyName
	nameText2.text = storyGroupConfig.storyName
	nameText3.text = storyGroupConfig.storyName
	item.storyId = levelConfig.storyId

	table.insert(self._allLevelItem, item)
end

function V3A7_RoleStoryGameView:onClose()
	if self._allLevelItem then
		for _, v in pairs(self._allLevelItem) do
			if v and v.click then
				v.click:RemoveClickListener()
			end
		end
	end

	if self._tweenId ~= nil then
		ZProj_TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._tweenIdProgress then
		ZProj_TweenHelper.KillById(self._tweenIdProgress)

		self._tweenIdProgress = nil
	end

	TaskDispatcher.cancelTask(self._updateProgress, self)
	TaskDispatcher.cancelTask(self._showProgress3, self)
	TaskDispatcher.cancelTask(self._showProgress6, self)
	TaskDispatcher.cancelTask(self.closeLevelPop, self)
	TaskDispatcher.cancelTask(self._showNewLevel, self)
	TaskDispatcher.cancelTask(self._updateProgressLineMove, self)
end

function V3A7_RoleStoryGameView:_onCloseViewFinish(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		return
	end

	if not self.gameBaseMO:levelIsFinish(self._selectLevelId) then
		return
	end

	if viewName ~= ViewName.NecrologistStoryView and viewName ~= ViewName.NecrologistStoryReviewView then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_yzge_yishi_interface_noise)

	local newLevelId = self.gameBaseMO:getNextLockLevel(self._selectLevelId) or self._selectLevelId

	gohelper.setActive(self._golevel6, false)
	gohelper.setActive(self._golevel3, false)

	local firstSp = self.gameBaseMO:isFirstSpLevel(newLevelId)
	local lastSp = self.gameBaseMO:isLastSpLevel(newLevelId)

	if firstSp or lastSp then
		self:showProgress(newLevelId)
	else
		self:_showNewLevel()
	end
end

function V3A7_RoleStoryGameView:showProgress(levelId)
	local firstSp = self.gameBaseMO:isFirstSpLevel(levelId)
	local lastSp = self.gameBaseMO:isLastSpLevel(levelId)

	gohelper.setActive(self._golevel3, firstSp)

	if firstSp then
		self._txtprogress.text = "0%"

		self._goLevel3Ani:Play("open", 0, 0)
		transformhelper.setLocalPos(self.goContent3.transform, 0, 0, 0)
		TaskDispatcher.runDelay(self._showProgress3, self, 1)
	end

	gohelper.setActive(self._golevel6, lastSp)

	if lastSp then
		self._goLevel6Ani:Play("open", 0, 0)
		TaskDispatcher.runDelay(self._showProgress6, self, 1)
	end

	if lastSp or firstSp then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_yzge_yishi_tab)
	end

	TaskDispatcher.runDelay(self._showNewLevel, self, 2.5)
end

function V3A7_RoleStoryGameView:_showProgress3()
	self.progressImage = self._goprogress:GetComponent(gohelper.Type_Image)
	self.progressImage.fillAmount = 0
	self._tweenIdProgress = ZProj_TweenHelper.DOFillAmount(self.progressImage, 1, 1, nil, nil)

	TaskDispatcher.runRepeat(self._updateProgress, self, 0.01)
	self:updateProgressLineMove(self.goContent3.transform, 6)
	self:_updateProgress()
end

function V3A7_RoleStoryGameView:updateProgressLineMove(transform, totalLines)
	self._progressLineIndex = 0
	self._progressTotalLines = 20 - totalLines
	self._progressLineOffsetY = 45
	self.curTransform = transform

	recthelper.setAnchorY(self.curTransform, 0)

	local intervalTime = 1 / self._progressTotalLines

	TaskDispatcher.runRepeat(self._updateProgressLineMove, self, intervalTime)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_yzge_yishi_spam_long)
	self:_updateProgressLineMove()
end

function V3A7_RoleStoryGameView:_updateProgressLineMove()
	if self._progressLineIndex >= self._progressTotalLines then
		TaskDispatcher.cancelTask(self._updateProgressLineMove, self)

		return
	end

	local posY = recthelper.getAnchorY(self.curTransform)

	recthelper.setAnchorY(self.curTransform, posY + self._progressLineOffsetY)

	self._progressLineIndex = self._progressLineIndex + 1
end

function V3A7_RoleStoryGameView:_showProgress6()
	self:updateProgressLineMove(self.goContent6.transform, 10)
end

function V3A7_RoleStoryGameView:_updateProgress()
	if self.progressImage == nil then
		return
	end

	self._txtprogress.text = math.ceil(self.progressImage.fillAmount * 100) .. "%"
end

function V3A7_RoleStoryGameView:_showNewLevel()
	TaskDispatcher.cancelTask(self._updateProgress, self)
	TaskDispatcher.cancelTask(self._updateProgressLineMove, self)

	local newLevelId = self.gameBaseMO:getNextLockLevel(self._selectLevelId) or self._selectLevelId
	local firstSp = self.gameBaseMO:isFirstSpLevel(newLevelId)
	local lastSp = self.gameBaseMO:isLastSpLevel(newLevelId)

	if firstSp then
		self._goLevel3Ani:Play("close", 0, 0)
	end

	if lastSp then
		self._goLevel6Ani:Play("close", 0, 0)
	end

	TaskDispatcher.runDelay(self.closeLevelPop, self, 0.8)
	self:setSelectLevelId(newLevelId, true)
end

function V3A7_RoleStoryGameView:closeLevelPop()
	gohelper.setActive(self._golevel6, false)
	gohelper.setActive(self._golevel3, false)
end

function V3A7_RoleStoryGameView:_initItem()
	self.sp1Config = NecrologistStoryV3A7Config.instance:getBaseConfig(NecrologistStoryEnum.V3A7SpLevelId.Sp1)
	self.sp2Config = NecrologistStoryV3A7Config.instance:getBaseConfig(NecrologistStoryEnum.V3A7SpLevelId.Sp2)
	self.sp1DescList = string.split(self.sp1Config.spDesc, "|")
	self.sp1ImageDescList = string.split(self.sp1Config.spDescPic, "|")
	self.sp2DescList = string.split(self.sp2Config.spDesc, "|")
	self.sp2ImageDescList = string.split(self.sp2Config.spDescPic, "|")

	gohelper.CreateNumObjList(self._golevel3item.transform.parent.gameObject, self._golevel3item, 20, self.createLevel3Item, self)
	gohelper.CreateNumObjList(self._golevel3itemright.transform.parent.gameObject, self._golevel3itemright, 20, self.createLevel3Item, self)
	gohelper.CreateNumObjList(self._golevel6itemright.transform.parent.gameObject, self._golevel6itemright, 20, self.createLevel6Item, self)
	gohelper.CreateNumObjList(self._golevel6item.transform.parent.gameObject, self._golevel6item, 20, self.createLevel6Item, self)
end

function V3A7_RoleStoryGameView:createLevel3Item(go, index)
	local txt = gohelper.findChildText(go, "txt_dec")

	txt.text = self.sp1DescList[index]

	UISpriteSetMgr.instance:setRoleStorySprite(gohelper.findChildImage(go, "image_dec"), "rolestory_3154_en_" .. ((not string.nilorempty(self.sp1ImageDescList[index]) or nil) and (self.sp1ImageDescList[index] or 1)))
	gohelper.setActive(go, true)
end

function V3A7_RoleStoryGameView:createLevel6Item(go, index)
	local txt = gohelper.findChildText(go, "txt_dec")
	local image_dec_1 = gohelper.findChildImage(go, "image_dec_1")
	local image_dec_2 = gohelper.findChildImage(go, "image_dec_2")
	local image_dec_3 = gohelper.findChildImage(go, "image_dec_3")

	txt.text = self.sp2DescList[index]

	UISpriteSetMgr.instance:setRoleStorySprite(image_dec_1, "rolestory_3154_en_" .. ((not string.nilorempty(self.sp2ImageDescList[(index - 1) * 3 + 1]) or nil) and (self.sp2ImageDescList[(index - 1) * 3 + 1] or 1)))
	UISpriteSetMgr.instance:setRoleStorySprite(image_dec_2, "rolestory_3154_en_" .. ((not string.nilorempty(self.sp2ImageDescList[(index - 1) * 3 + 2]) or nil) and (self.sp2ImageDescList[(index - 1) * 3 + 2] or 1)))
	UISpriteSetMgr.instance:setRoleStorySprite(image_dec_3, "rolestory_3154_en_" .. ((not string.nilorempty(self.sp2ImageDescList[(index - 1) * 3 + 3]) or nil) and (self.sp2ImageDescList[(index - 1) * 3 + 3] or 1)))
	gohelper.setActive(go, true)
end

function V3A7_RoleStoryGameView:onDestroyView()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_yzge_yishi_interface_noise)
end

return V3A7_RoleStoryGameView
