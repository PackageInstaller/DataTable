-- chunkname: @modules/logic/versionactivity3_3/arcade/view/reward/ArcadeRewardView.lua

module("modules.logic.versionactivity3_3.arcade.view.reward.ArcadeRewardView", package.seeall)

local ArcadeRewardView = class("ArcadeRewardView", BaseView)

function ArcadeRewardView:onInitView()
	self.btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._txtScore = gohelper.findChildTextMesh(self.viewGO, "Left/title/#txt_score")
	self._gonormalline = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._rectnormalline = self._gonormalline.transform
	self.startSpace = 2
	self.cellWidth = 268
	self.space = 0
	self.rewardIndex = 30

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addClickCb(self, self.btnReward, self.onClickReward, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnGainReward, self.onGainReward, self)
end

function ArcadeRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
	self:removeClickCb(self.btnReward)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnGainReward, self.onGainReward, self)
end

function ArcadeRewardView:_btncloseOnClick()
	self:closeThis()
end

function ArcadeRewardView:onClickModalMask()
	self:_btncloseOnClick()
end

function ArcadeRewardView:_editableInitView()
	return
end

function ArcadeRewardView:onClickReward()
	local scrollView = self.viewContainer:getScrollView()

	scrollView:moveToByIndex(self.rewardIndex - 3, 1, self.openRewardView, self)
end

function ArcadeRewardView:openRewardView()
	local moList = ArcadeRewardListModel.instance:getList()
	local config = moList[self.rewardIndex]

	if not config then
		return
	end

	local rewardList = DungeonConfig.instance:getRewardItems(tonumber(config.reward))
	local rewardData = rewardList and rewardList[1]

	if not rewardData then
		return
	end

	MaterialTipController.instance:showMaterialInfo(rewardData[1], rewardData[2])
end

function ArcadeRewardView:onGainReward()
	self:refreshView()
end

function ArcadeRewardView:onOpen()
	self:refreshView()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)
end

function ArcadeRewardView:refreshView()
	self:refreshReward()
	self:refreshProgress()
end

function ArcadeRewardView:refreshProgress()
	local score = ArcadeOutSizeModel.instance:getScore()

	self._txtScore.text = GameUtil.numberDisplay(score)

	local moList = ArcadeRewardListModel.instance:getList()
	local curIndex = #moList
	local curShowIndex

	for i, mo in ipairs(moList) do
		if curShowIndex == nil and not mo:isGainReward() then
			curShowIndex = i
		end

		if score < mo:getScore() then
			curIndex = i - 1

			break
		end
	end

	if moList[curIndex] then
		if not moList[curIndex].score then
			local curScore = 0

			if moList[curIndex + 1] then
				if not moList[curIndex + 1].score then
					local nextScore = curScore
					local beginPos = 0
					local nodeWidth = self:getNodeWidth(curIndex, beginPos)
					local offsetWidth = self:getNodeWidth(curIndex + 1, beginPos) - nodeWidth

					recthelper.setWidth(self._rectnormalline, nodeWidth + ((curScore < nextScore or nil) and (score - curScore) / (nextScore - curScore) * offsetWidth))

					if not self.isPlayMove then
						self.isPlayMove = true

						if curShowIndex ~= nil then
							local scrollView = self.viewContainer:getScrollView()

							scrollView:moveToByIndex(curShowIndex, 0.2)
						end
					end
				end
			end
		end
	end
end

function ArcadeRewardView:getNodeWidth(index, beginPos)
	beginPos = beginPos or 0

	return (index > 0 or nil) and (index - 1) * (self.cellWidth + self.space) + (self.startSpace + self.cellWidth * 0.5) + beginPos
end

function ArcadeRewardView:refreshReward()
	ArcadeRewardListModel.instance:refreshList()
end

function ArcadeRewardView:onClose()
	return
end

function ArcadeRewardView:onDestroyView()
	return
end

return ArcadeRewardView
