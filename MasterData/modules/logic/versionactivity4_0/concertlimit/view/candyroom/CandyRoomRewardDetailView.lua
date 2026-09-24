-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomRewardDetailView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomRewardDetailView", package.seeall)

local CandyRoomRewardDetailView = class("CandyRoomRewardDetailView", BaseView)

function CandyRoomRewardDetailView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")
	self._gorewards = gohelper.findChild(self.viewGO, "Root/#go_rewards")
	self._goreward101 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_101")
	self._goreward102 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_102")
	self._goreward103 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_103")
	self._goreward104 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_104")
	self._goreward105 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_105")
	self._goreward106 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_106")
	self._goreward107 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_107")
	self._goreward108 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_108")
	self._goreward109 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_109")
	self._goreward110 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_110")
	self._goreward111 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_111")
	self._goreward112 = gohelper.findChild(self.viewGO, "Root/#go_rewards/#go_reward_112")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CandyRoomRewardDetailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function CandyRoomRewardDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function CandyRoomRewardDetailView:_btncloseOnClick()
	self:closeThis()
end

function CandyRoomRewardDetailView:_editableInitView()
	self._rewardItems = self:getUserDataTb_()
end

function CandyRoomRewardDetailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_0.CandyRoom.play_ui_langchao_page_open)
	self:_refresh()
end

function CandyRoomRewardDetailView:_refresh()
	self:_refreshRewards()
end

function CandyRoomRewardDetailView:_refreshRewards()
	local resPath = self.viewContainer:getSetting().otherRes.rewardItemPath
	local rewardCos = CandyRoomConfig.instance:getActivity245RewardCos()

	for _, rewardCo in pairs(rewardCos) do
		if not self._rewardItems[rewardCo.id] then
			local rootGo = self["_goreward" .. tostring(rewardCo.id)]
			local go = self.viewContainer:getResInst(resPath, rootGo)

			self._rewardItems[rewardCo.id] = CandyRoomPanelRewardItem.New()

			self._rewardItems[rewardCo.id]:init(go)
		end

		self._rewardItems[rewardCo.id]:refresh(rewardCo.id)
	end
end

function CandyRoomRewardDetailView:onClose()
	return
end

function CandyRoomRewardDetailView:onDestroyView()
	if self._rewardItems then
		for _, rewardItem in pairs(self._rewardItems) do
			rewardItem:destroy()
		end

		self._rewardItems = nil
	end
end

return CandyRoomRewardDetailView
