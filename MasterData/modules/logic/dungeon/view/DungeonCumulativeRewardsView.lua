-- chunkname: @modules/logic/dungeon/view/DungeonCumulativeRewardsView.lua

module("modules.logic.dungeon.view.DungeonCumulativeRewardsView", package.seeall)

local DungeonCumulativeRewardsView = class("DungeonCumulativeRewardsView", BaseView)

function DungeonCumulativeRewardsView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#simage_rightbg")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txttipsinfo = gohelper.findChildText(self.viewGO, "#go_tips/#txt_tipsinfo")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "#scroll_reward")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_content")
	self._gograyline = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_content/#go_grayline")
	self._gonormalline = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_content/#go_normalline")
	self._gotarget = gohelper.findChild(self.viewGO, "#go_target")
	self._txtprogress = gohelper.findChildText(self.viewGO, "progresstip/#txt_progress")
	self._simagetargetbg = gohelper.findChildSingleImage(self.viewGO, "#go_target/#simage_targetbg")
	self._simagerightfademask = gohelper.findChildSingleImage(self.viewGO, "#simage_rightfademask")
	self._simageleftfademask = gohelper.findChildSingleImage(self.viewGO, "#simage_leftfademask")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "progresstip/#txt_progress/#btn_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonCumulativeRewardsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncloseview:AddClickListener(self._btncloseOnClick, self)
	self._btntips:AddClickListener(self._btntipsOnClick, self)
end

function DungeonCumulativeRewardsView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btncloseview:RemoveClickListener()
	self._btntips:RemoveClickListener()
end

function DungeonCumulativeRewardsView:_btntipsOnClick()
	DungeonController.instance:openDungeonCumulativeRewardsTipsView()
end

function DungeonCumulativeRewardsView:_btncloseOnClick()
	self:closeThis()
end

function DungeonCumulativeRewardsView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getDungeonIcon("full/guankajianlibiejing_038"))
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simagetargetbg:LoadImage(ResUrl.getDungeonIcon("bg_zhezhao"))
	self._simagerightfademask:LoadImage(ResUrl.getDungeonIcon("bg_zhezhao2"))
	self._simageleftfademask:LoadImage(ResUrl.getDungeonIcon("bg_zhezhao1"))
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_main_eject)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollreward.gameObject)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._scrollreward.gameObject, DungeonMapEpisodeAudio, self._scrollreward)
	self._touch = SLFramework.UGUI.UIClickListener.Get(self._scrollreward.gameObject)

	self._touch:AddClickDownListener(self._onClickDownHandler, self)
end

function DungeonCumulativeRewardsView:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function DungeonCumulativeRewardsView:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function DungeonCumulativeRewardsView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function DungeonCumulativeRewardsView:onUpdateParam()
	return
end

function DungeonCumulativeRewardsView:_getPointRewardRequest()
	local rewardList = DungeonMapModel.instance:canGetRewardsList(self._maxChapterId)

	if rewardList and #rewardList > 0 then
		self._getRewardLen = #rewardList

		DungeonRpc.instance:sendGetPointRewardRequest(rewardList)
	end
end

function DungeonCumulativeRewardsView:_onScrollChange(value)
	self:_showTarget()
	gohelper.setActive(self._simagerightfademask.gameObject, self._isNormalMode and self._scrollreward.horizontalNormalizedPosition < 1)
end

function DungeonCumulativeRewardsView:onOpen()
	local lastConfig = lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList]

	self._maxChapterId = lastConfig.chapterId

	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnGetPointReward, self._onGetPointReward, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnGetPointRewardMaterials, self._onGetPointRewardMaterials, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideGetPointReward, self._getPointRewardRequest, self)
	self._scrollreward:AddOnValueChanged(self._onScrollChange, self)

	if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		TaskDispatcher.runDelay(self._getPointRewardRequest, self, 0.6)
	end

	self:_showChapters()
	self:_showProgress()
	self:_moveCenter()
	self:_showTarget()
	NavigateMgr.instance:addEscape(ViewName.DungeonCumulativeRewardsView, self._btncloseOnClick, self)
end

function DungeonCumulativeRewardsView:_onGetPointRewardMaterials(materials)
	self._rewardsMaterials = materials
end

function DungeonCumulativeRewardsView:_showMaterials()
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, self._rewardsMaterials)
end

function DungeonCumulativeRewardsView:_onGetPointReward()
	if self._getRewardLen == 1 then
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
	else
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_multiple)
	end

	self:_refreshItems()
	self:_showProgress()
	self:_showTarget()

	if self._rewardsMaterials then
		TaskDispatcher.cancelTask(self._showMaterials, self)
		TaskDispatcher.runDelay(self._showMaterials, self, 0.8)
	end
end

function DungeonCumulativeRewardsView:_refreshItems()
	for i, v in ipairs(self._itemList) do
		v:refreshRewardItems(true)
	end
end

function DungeonCumulativeRewardsView:_showChapters()
	self._firstPosX = 145
	self._sliderBasePosx = 59.5
	self._posX = 0
	self._posY = -506.8
	self._deltaPosX = 335
	self._endNormalGap = 165
	self._endTargetGap = 280
	self._targetModeWidth = 1266
	self._normalModeWidth = 1630
	self._itemList = self:getUserDataTb_()
	self._itemMap = self:getUserDataTb_()

	recthelper.setAnchor(self._gograyline.transform, self._sliderBasePosx, self._posY)
	recthelper.setAnchor(self._gonormalline.transform, self._sliderBasePosx, self._posY)

	self._prevPointValue = 0

	for i = 101, self._maxChapterId do
		self:_showChapter(i)
	end
end

function DungeonCumulativeRewardsView:_showChapter(chapterId)
	local pointRewardCfg = DungeonConfig.instance:getChapterPointReward(chapterId)
	local pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo()

	for i, v in ipairs(pointRewardCfg) do
		local path = self.viewContainer:getSetting().otherRes[1]
		local child = self:getResInst(path, self._gocontent, "item" .. v.id)
		local prevPosX = self._posX

		if self._posX == 0 then
			local curPosX = self._posX + (self._firstPosX or self._deltaPosX)

			self._posX = curPosX

			recthelper.setAnchor(child.transform, curPosX, self._posY)
			recthelper.setWidth(self._gocontent.transform, self._posX)

			local graySliderLen = self._posX + self._sliderBasePosx

			recthelper.setWidth(self._gograyline.transform, graySliderLen)

			local item = MonoHelper.addLuaComOnceToGo(child, DungeonCumulativeRewardsItem, {
				chapterId,
				v,
				false,
				prevPosX,
				curPosX,
				self._prevPointValue
			})

			table.insert(self._itemList, item)

			self._itemMap[v.id] = item
			self._prevPointValue = v.rewardPointNum
		end
	end
end

function DungeonCumulativeRewardsView:_showTarget()
	local contentPosX = recthelper.getAnchorX(self._gocontent.transform)
	local viewWidth = recthelper.getWidth(self._scrollreward.transform)
	local targetReward, lastTargetReward
	local pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo()

	for chapterId = 101, self._maxChapterId do
		local pointRewardCfg = DungeonConfig.instance:getChapterPointReward(chapterId)

		for i, v in ipairs(pointRewardCfg) do
			if v.display > 0 and pointRewardInfo.rewardPoint < v.rewardPointNum then
				lastTargetReward = v

				local item = self._itemMap[v.id]
				local posX = item.curPosX + contentPosX

				if viewWidth < posX then
					targetReward = v

					break
				end
			end
		end

		if targetReward then
			break
		end
	end

	targetReward = targetReward or lastTargetReward
	self._isNormalMode = true

	if targetReward then
		self._isNormalMode = false

		if self._targetItem then
			if self._targetItem.rewardId == targetReward.id then
				return
			end

			self:_playTargetItemQuitAmim()

			self._targetItem = nil
		end

		recthelper.setWidth(self._scrollreward.transform, self._targetModeWidth)

		local path = self.viewContainer:getSetting().otherRes[1]
		local child = self:getResInst(path, self._gotarget, "item" .. targetReward.id)

		gohelper.setActive(child, not self._unUseTargetItemGo)

		self._targetItem = MonoHelper.addLuaComOnceToGo(child, DungeonCumulativeRewardsItem, {
			nil,
			targetReward,
			true
		})

		TaskDispatcher.cancelTask(self._showTargetItem, self)
		TaskDispatcher.runDelay(self._showTargetItem, self, 0.1)
		gohelper.setActive(self._gotarget, true)
		gohelper.setActive(self._simagerightfademask.gameObject, false)
	else
		gohelper.setActive(self._gotarget, false)
		recthelper.setWidth(self._scrollreward.transform, self._normalModeWidth)
	end

	if self._isNormalMode then
		if not self._endNormalGap then
			local endGap = self._endTargetGap

			recthelper.setWidth(self._gocontent.transform, self._posX + endGap)
			gohelper.setActive(self._simagerightfademask.gameObject, self._isNormalMode and self._scrollreward.horizontalNormalizedPosition < 1)
		end
	end
end

function DungeonCumulativeRewardsView:_playTargetItemQuitAmim()
	if not self._targetItem or not self._targetItem.viewGO then
		return
	end

	self._unUseTargetItemGo = self._targetItem.viewGO

	local anim = self._unUseTargetItemGo:GetComponent(typeof(UnityEngine.Animator))

	anim:Play("dungeoncumulativerewardsitem_switch_out")
	TaskDispatcher.cancelTask(self._destroyUnUseTargetItem, self)
	TaskDispatcher.runDelay(self._destroyUnUseTargetItem, self, 0.1)
end

function DungeonCumulativeRewardsView:_destroyUnUseTargetItem()
	if not self._unUseTargetItemGo then
		return
	end

	gohelper.destroy(self._unUseTargetItemGo)

	self._unUseTargetItemGo = nil
end

function DungeonCumulativeRewardsView:_showTargetItem()
	if not self._targetItem or not self._targetItem.viewGO then
		return
	end

	gohelper.setActive(self._targetItem.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_flip)
end

function DungeonCumulativeRewardsView:_showProgress()
	local pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo()

	for i, v in ipairs(self._itemList) do
		if v.curPointValue <= pointRewardInfo.rewardPoint then
			local silderWidth = v.curPosX - self._sliderBasePosx

			recthelper.setWidth(self._gonormalline.transform, silderWidth)
		elseif pointRewardInfo.rewardPoint >= v.prevPointValue then
			local deltaValue = v.curPointValue - v.prevPointValue

			if i == 1 then
				if not self._sliderBasePosx then
					local prePosX = v.prevPosX
					local deltaPosX = v.curPosX - prePosX
					local value = pointRewardInfo.rewardPoint - v.prevPointValue
					local posX = prePosX + value / deltaValue * deltaPosX - self._sliderBasePosx

					recthelper.setWidth(self._gonormalline.transform, posX)

					break
				end
			end
		end
	end

	if self._itemList then
		if not #self._itemList then
			local itemLen = 0

			if itemLen > 0 and self._itemList[itemLen].curPointValue <= pointRewardInfo.rewardPoint then
				local graySliderWidth = recthelper.getWidth(self._gograyline.transform)

				recthelper.setWidth(self._gonormalline.transform, graySliderWidth)
			end

			self._txtprogress.text = pointRewardInfo.rewardPoint
		end
	end
end

function DungeonCumulativeRewardsView:_moveCenter()
	local pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo()
	local moveItem

	for i, v in ipairs(self._itemList) do
		if v.curPointValue > pointRewardInfo.rewardPoint then
			moveItem = v

			break
		end
	end

	moveItem = moveItem or self._itemList[#self._itemList]

	local viewWidth = recthelper.getWidth(self._scrollreward.transform)

	recthelper.setAnchorX(self._gocontent.transform, -moveItem.curPosX + viewWidth / 2)
end

function DungeonCumulativeRewardsView:onClose()
	TaskDispatcher.cancelTask(self._getPointRewardRequest, self)
	TaskDispatcher.cancelTask(self._destroyUnUseTargetItem, self)
	TaskDispatcher.cancelTask(self._showTargetItem, self)
	self._scrollreward:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self._showMaterials, self)

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.DelayGetPointReward, nil)
		logError("DungeonCumulativeRewardsView clear flag:DelayGetPointReward")
	end
end

function DungeonCumulativeRewardsView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simagetargetbg:UnLoadImage()
	self._simageleftfademask:UnLoadImage()
	self._simagerightfademask:UnLoadImage()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._touch then
		self._touch:RemoveClickDownListener()

		self._touch = nil
	end
end

return DungeonCumulativeRewardsView
