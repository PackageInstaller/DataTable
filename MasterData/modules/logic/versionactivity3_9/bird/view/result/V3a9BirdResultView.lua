-- chunkname: @modules/logic/versionactivity3_9/bird/view/result/V3a9BirdResultView.lua

module("modules.logic.versionactivity3_9.bird.view.result.V3a9BirdResultView", package.seeall)

local V3a9BirdResultView = class("V3a9BirdResultView", BaseView)

function V3a9BirdResultView:onInitView()
	self._goreward = gohelper.findChild(self.viewGO, "root/bottom/#go_reward")
	self._gocontent = gohelper.findChild(self.viewGO, "root/bottom/#go_reward/#go_content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/bottom/#go_reward/#go_content/#go_rewarditem")
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom/go_btn/#btn_exit")
	self._btnagain = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom/go_btn/#btn_again")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "root/middle/bg_grade/grade_1/#txt_num")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "root/middle/bg_grade/grade_2/#txt_num")
	self._txtplayername = gohelper.findChildText(self.viewGO, "root/middle/bg_grade/txt_playername")
	self._animEvent = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9BirdResultView:addEvents()
	self._btnexit:AddClickListener(self._btnexitOnClick, self)
	self._btnagain:AddClickListener(self._btnagainOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self._animEvent:AddEventListener("PlayAudio", self._onPlayAudio, self)
end

function V3a9BirdResultView:removeEvents()
	self._btnexit:RemoveClickListener()
	self._btnagain:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self._animEvent:RemoveEventListener("PlayAudio")
end

function V3a9BirdResultView:_onPlayAudio()
	AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_diqiu_unlock)
end

function V3a9BirdResultView:_onOpenViewFinish(viewName)
	if viewName == ViewName.V3a9BirdMainView then
		self:closeThis()
	end
end

function V3a9BirdResultView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		for i, item in ipairs(self._rewardItems) do
			gohelper.setActive(item.gocanget, false)
			gohelper.setActive(item.goreceive, true)
		end

		AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_bulaochuan_win)
	end
end

function V3a9BirdResultView:_btnexitOnClick()
	if not self._isCanClick then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.V3a9BirdGameView) then
		ViewMgr.instance:closeView(ViewName.V3a9BirdGameView, true)
	end

	if self._gameType == V3a9BirdEnum.BirdGameType.Normal then
		self:closeThis()

		local max = V3a9BirdModel.instance:getGameNeedPassNum()
		local count = V3a9BirdModel.instance:getPassCount()

		if max <= count then
			local storyId = V3a9BirdModel.instance:getAfterStoryId()
			local storyEpisodeId = V3a9BirdModel.instance:getNormalEpisodeId()

			StoryController.instance:playStory(storyId, nil, function()
				if not DungeonModel.instance:hasPassLevelAndStory(storyEpisodeId) then
					DungeonRpc.instance:sendEndDungeonRequest(false)
				end
			end, self)
		end
	else
		self._animPlayer:Play("switchclose", self._onExit, self)
		AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_langchao_tv_close)
	end
end

function V3a9BirdResultView:_onExit()
	if not self._isCanClick then
		return
	end

	V3a9BirdController.instance:openBirdMainView(self._actId, self._episodeId, true)
end

function V3a9BirdResultView:_btnagainOnClick()
	V3a9BirdModel.instance:onStartGame(self._episodeId)
	V3a9BirdController.instance:dispatchEvent(V3a9BirdEvent.onAgainGame)
	self._animPlayer:Play("again", self._onAgain, self)
end

function V3a9BirdResultView:_onAgain()
	self:closeThis()
end

function V3a9BirdResultView:_editableInitView()
	self._rewardItems = self:getUserDataTb_()

	gohelper.setActive(self._gorewarditem, false)

	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	NavigateMgr.instance:addEscape(self.viewName, self.clickClose, self)
end

function V3a9BirdResultView:clickClose()
	if ViewMgr.instance:isOpen(ViewName.V3a9BirdGameView) then
		ViewMgr.instance:closeView(ViewName.V3a9BirdGameView)
	end

	self:closeThis()
end

function V3a9BirdResultView:onUpdateParam()
	return
end

function V3a9BirdResultView:onOpen()
	self._isCanClick = false

	TaskDispatcher.cancelTask(self._onGetRewards, self)

	self._actId = V3a9BirdModel.instance:getActId()
	self._episodeId = V3a9BirdModel.instance:getEnterGameEpisodeId()
	self._gameType = V3a9BirdModel.instance:getGameType(self._episodeId)

	self:_refreshPlayerInfo()
	self:_initReward()

	local rewardList = self:_getRewards()

	if rewardList and #rewardList > 0 then
		TaskDispatcher.runDelay(self._onGetRewards, self, 0.5)
	else
		self._isCanClick = true

		AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_bulaochuan_win)
	end

	AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_langchao_tv_unfold)
end

function V3a9BirdResultView:_initReward()
	local rewardList = self:_getRewards()

	if rewardList then
		for i, v in ipairs(rewardList) do
			local item = self:_getRewardItem(i)

			item.iconItem:onUpdateMO(v)
			item.iconItem:setScale(0.6)
			gohelper.setActive(item.gocanget, true)
			gohelper.setActive(item.goreceive, false)
		end
	end

	if rewardList then
		if not #rewardList then
			local count = 0

			for i, item in ipairs(self._rewardItems) do
				gohelper.setActive(item.go, i <= count)
			end
		end
	end
end

function V3a9BirdResultView:_getRewards()
	if not self._rewards then
		local levelMo = V3a9BirdModel.instance:getLevelMo(self._episodeId)

		if levelMo then
			self._rewards = {}

			local rewardList = levelMo:getPassReward()

			if rewardList then
				for i, v in ipairs(rewardList) do
					local materialData = MaterialDataMO.New()
					local materialType = v.materialType
					local materialId = v.materialId
					local weight = v.weight

					materialData:initValue(materialType, materialId, weight)
					table.insert(self._rewards, materialData)
				end
			end
		end
	end

	return self._rewards
end

function V3a9BirdResultView:_onGetRewards()
	self._isCanClick = true

	local rewardList = self:_getRewards()

	if rewardList then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, rewardList)
	end
end

function V3a9BirdResultView:_getRewardItem(index)
	local item = self._rewardItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gorewarditem)
		item.itemParent = gohelper.findChild(item.go, "go_icon")
		item.gocanget = gohelper.findChild(item.go, "go_canget")
		item.goreceive = gohelper.findChild(item.go, "go_receive")
		item.iconItem = IconMgr.instance:getCommonItemIcon(item.itemParent)
		self._rewardItems[index] = item
	end

	return item
end

function V3a9BirdResultView:_refreshPlayerInfo()
	self._txtplayername.text = PlayerModel.instance:getPlayerName()
	self._txtnum1.text = V3a9BirdModel.instance:getGameScore()
	self._txtnum2.text = V3a9BirdModel.instance:getPassCount()
end

function V3a9BirdResultView:onClose()
	return
end

function V3a9BirdResultView:onDestroyView()
	TaskDispatcher.cancelTask(self._onGetRewards, self)
end

return V3a9BirdResultView
