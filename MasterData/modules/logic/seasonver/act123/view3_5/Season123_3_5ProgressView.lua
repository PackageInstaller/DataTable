-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5ProgressView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5ProgressView", package.seeall)

local Season123_3_5ProgressView = class("Season123_3_5ProgressView", BaseView)

function Season123_3_5ProgressView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._goMask = gohelper.findChild(self.viewGO, "root/progress")
	self.txtCurrent = gohelper.findChildTextMesh(self.viewGO, "root/title/scorebg/#go_progress/#txt_current")
	self.txtTotal = gohelper.findChildTextMesh(self.viewGO, "root/title/scorebg/#go_progress/#txt_total")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "root/progress/#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "root/progress/#scroll_view/Viewport/Content")
	self._gonormalline = gohelper.findChild(self.viewGO, "root/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._rectnormalline = self._gonormalline.transform
	self._gotarget = gohelper.findChild(self.viewGO, "root/rightbg")
	self._gotargetrewardpos = gohelper.findChild(self.viewGO, "root/rightbg/rightprogressbg/#go_progressitem")

	self._scrollreward:AddOnValueChanged(self._onScrollChange, self)

	self._normalDelta = Vector2.New(1290, 529)
	self._fullDelta = Vector2.New(1614, 529)
	self.startSpace = 2
	self.cellWidth = 268
	self.space = 0
	self.targetId = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5ProgressView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.StageRewardGet, self._onStageRewardGet, self)
end

function Season123_3_5ProgressView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, Season123Controller.instance, Season123Event.StageRewardGet, self._onStageRewardGet, self)
end

function Season123_3_5ProgressView:_btncloseOnClick()
	self:closeThis()
end

function Season123_3_5ProgressView:_onScrollChange(value)
	self:refreshTarget()
end

function Season123_3_5ProgressView:_onStageRewardGet()
	self:refreshView()
end

function Season123_3_5ProgressView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_fight_ui_uttu_popup)

	self.actId = self.viewParam.activityId
	self.stageId = self.viewParam.stageId

	self:refreshView()
end

function Season123_3_5ProgressView:refreshView()
	self:refreshReward()
	self:refreshProgress()
	TaskDispatcher.cancelTask(self.refreshTarget, self)
	TaskDispatcher.runDelay(self.refreshTarget, self, 0.02)
end

function Season123_3_5ProgressView:refreshProgress()
	local seasonMo = Season123Model.instance:getActInfo(self.actId)
	local stageMo = seasonMo and seasonMo:getStageMO(self.stageId)
	local current, total = stageMo:getProgressStar()

	self.txtCurrent.text = current
	self.txtTotal.text = total

	local list = Season123Config.instance:getStageRewardList(self.actId, self.stageId)
	local curIndex = #list

	for i, v in ipairs(list) do
		if current < v.star then
			curIndex = i - 1

			break
		end
	end

	if list[curIndex] then
		if not list[curIndex].star then
			local curStar = 0

			if list[curIndex + 1] then
				if not list[curIndex + 1].star then
					local nextStar = curStar
					local beginPos = 0
					local nodeWidth = self:getNodeWidth(curIndex, beginPos)
					local offsetWidth = self:getNodeWidth(curIndex + 1, beginPos) - nodeWidth

					recthelper.setWidth(self._rectnormalline, nodeWidth + ((curStar < nextStar or nil) and (current - curStar) / (nextStar - curStar) * offsetWidth))

					if not self.isPlayMove then
						self.isPlayMove = true

						local scrollView = self.viewContainer:getScrollView()

						scrollView:moveToByCheckFunc(function(mo)
							return mo.index == curIndex
						end)
					end
				end
			end
		end
	end
end

function Season123_3_5ProgressView:getNodeWidth(index, beginPos)
	beginPos = beginPos or 0

	return (index > 0 or nil) and (index - 1) * (self.cellWidth + self.space) + (self.startSpace + self.cellWidth * 0.5) + beginPos
end

function Season123_3_5ProgressView:refreshReward()
	Season123StageRewardListModel.instance:refreshList(self.actId, self.stageId)
end

function Season123_3_5ProgressView:refreshTarget()
	TaskDispatcher.cancelTask(self.refreshTarget, self)

	local rewardData = self:getTargetReward()

	if rewardData then
		::label_13_0::

		local var_13_0 = rewardData.config

		if rewardData.config then
			local targetId = rewardData.config.id

			if targetId == self.targetId then
				return
			end

			self.targetId = targetId

			local data

			if targetId then
				if not self.targetItem then
					local path = self.viewContainer:getSetting().otherRes.itemRes
					local child = self:getResInst(path, self._gotargetrewardpos, "targetItem")

					self.targetItem = MonoHelper.addLuaComOnceToGo(child, RoleStoryRewardItem)
				end

				data = {
					config = rewardData.config,
					index = rewardData.index
				}
				data.isTarget = true
			end

			if self.targetItem then
				self.targetItem:refresh(data)
			end

			if data then
				gohelper.setActive(self._gotarget, true)

				self._goMask.transform.sizeDelta = self._normalDelta
			else
				gohelper.setActive(self._gotarget, false)

				self._goMask.transform.sizeDelta = self._fullDelta
			end
		end
	end
end

function Season123_3_5ProgressView:getTargetReward()
	if not self.importantRewards then
		self.importantRewards = {}

		local list = RoleStoryConfig.instance:getRewardList(self.storyId) or {}

		for i, v in ipairs(list) do
			if v.keyReward == 1 then
				table.insert(self.importantRewards, {
					star = v.star,
					index = i,
					config = v
				})
			end
		end

		table.sort(self.importantRewards, SortUtil.keyLower("star"))
	end

	local contentPosX = recthelper.getAnchorX(self._gocontent.transform)
	local viewWidth = recthelper.getWidth(self._scrollreward.transform)
	local targetCo = {}
	local lastCo = {}

	for i, v in ipairs(self.importantRewards) do
		if RoleStoryModel.instance:getRewardState(v.config.storyId, v.config.id, v.config.star) == 0 then
			lastCo = v

			local pos = (v.index - 1) * (self.cellWidth + self.space) + self.startSpace
			local posX = pos + contentPosX

			if viewWidth < posX then
				targetCo = v

				break
			end
		end
	end

	if not targetCo.config then
		targetCo = lastCo
	end

	return targetCo
end

function Season123_3_5ProgressView:onClose()
	self._scrollreward:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self.refreshTarget, self)
end

function Season123_3_5ProgressView:onDestroyView()
	return
end

return Season123_3_5ProgressView
