-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/reward/V3a9RacingRewardView.lua

module("modules.logic.versionactivity3_9.racingcar.view.reward.V3a9RacingRewardView", package.seeall)

local V3a9RacingRewardView = class("V3a9RacingRewardView", BaseView)

function V3a9RacingRewardView:onInitView()
	self._txtScore = gohelper.findChildTextMesh(self.viewGO, "Left/title/#txt_score")
	self._txtdetail = gohelper.findChildTextMesh(self.viewGO, "Left/title/#txt_detail")
	self._goline = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg")
	self._gonormalline = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._rectnormalline = self._gonormalline.transform
	self.startSpace = 2
	self.cellWidth = 268
	self.space = 0
	self.rewardIndex = 30

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, MileStoneController.instance, MileStoneEvent.onGetBonus, self.onGainReward, self)
end

function V3a9RacingRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, MileStoneController.instance, MileStoneEvent.onGetBonus, self.onGainReward, self)
end

function V3a9RacingRewardView:_btncloseOnClick()
	self:closeThis()
end

function V3a9RacingRewardView:onClickModalMask()
	self:_btncloseOnClick()
end

function V3a9RacingRewardView:_editableInitView()
	self._mileStoneId = V3a9RacingCarEnum.MileStoneId

	local actId = V3a9RacingCarModel.instance:getActId()

	self._txtdetail.text = V3a9RacingCarConfig.instance:getAct243ConstValue(actId, V3a9RacingCarEnum.Act243Const.RewardDetail, true, false, "")
end

function V3a9RacingRewardView:onClickReward()
	local scrollView = self.viewContainer:getScrollView()

	scrollView:moveToByIndex(self.rewardIndex - 3, 1, self.openRewardView, self)
end

function V3a9RacingRewardView:openRewardView()
	local moList = V3a9RacingRewardListModel.instance:getList()
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

function V3a9RacingRewardView:onGainReward()
	self:refreshView()
end

function V3a9RacingRewardView:onOpen()
	self:refreshView()
end

function V3a9RacingRewardView:refreshView()
	self:refreshReward()
	self:refreshProgress()
end

function V3a9RacingRewardView:refreshProgress()
	local score = V3a9RacingRewardListModel.instance:getPoint(self._mileStoneId)

	self._txtScore.text = GameUtil.numberDisplay(score)

	local moList = V3a9RacingRewardListModel.instance:getList()
	local curIndex = #moList
	local curShowIndex

	for i, mo in ipairs(moList) do
		if curShowIndex == nil and not MileStoneUtil.isBonusHasGet(mo.config.milestoneId, mo.config.bonusId) then
			curShowIndex = i
		end

		if score < mo:getProgress() then
			curIndex = i - 1

			break
		end
	end

	if moList[curIndex] then
		if not moList[curIndex].config.needProgress then
			local curScore = 0

			if moList[curIndex + 1] then
				if not moList[curIndex + 1].config.needProgress then
					local nextScore = curScore
					local beginPos = 0
					local nodeWidth = self:getNodeWidth(curIndex, beginPos)
					local offsetWidth = self:getNodeWidth(curIndex + 1, beginPos) - nodeWidth

					recthelper.setWidth(self._rectnormalline, nodeWidth + ((curScore < nextScore or nil) and (score - curScore) / (nextScore - curScore) * offsetWidth))

					local totalWidth = self:getNodeWidth(#moList, beginPos)

					recthelper.setWidth(self._goline.transform, totalWidth)

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

function V3a9RacingRewardView:getNodeWidth(index, beginPos)
	beginPos = beginPos or 0

	return (index > 0 or nil) and (index - 1) * (self.cellWidth + self.space) + beginPos
end

function V3a9RacingRewardView:refreshReward()
	V3a9RacingRewardListModel.instance:refreshList(self._mileStoneId)
end

function V3a9RacingRewardView:onClose()
	return
end

function V3a9RacingRewardView:onDestroyView()
	return
end

return V3a9RacingRewardView
