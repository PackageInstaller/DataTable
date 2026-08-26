-- chunkname: @modules/logic/survival/view/shelter/SurvivalShelterRewardView.lua

module("modules.logic.survival.view.shelter.SurvivalShelterRewardView", package.seeall)

local SurvivalShelterRewardView = class("SurvivalShelterRewardView", BaseView)

function SurvivalShelterRewardView:onInitView()
	self.btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._txtScore = gohelper.findChildTextMesh(self.viewGO, "Left/title/#txt_score")
	self._gonormalline = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._rectnormalline = self._gonormalline.transform
	self.startSpace = 2
	self.cellWidth = 268
	self.space = 0
	self.rewardIndex = 30

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalShelterRewardView:addEvents()
	self.addClickCb(self, self.btnReward, self.onClickReward, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnGainReward, self.onGainReward, self)
end

function SurvivalShelterRewardView:removeEvents()
	self:removeClickCb(self.btnReward)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnGainReward, self.onGainReward, self)
end

function SurvivalShelterRewardView:_editableInitView()
	return
end

function SurvivalShelterRewardView:onClickReward()
	local scrollView = self.viewContainer:getScrollView()

	scrollView:moveToByIndex(self.rewardIndex - 3, 1, self.openRewardView, self)
end

function SurvivalShelterRewardView:openRewardView()
	local list = SurvivalShelterRewardListModel.instance:getList()
	local config = list[self.rewardIndex]

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

function SurvivalShelterRewardView:onGainReward()
	self:refreshView()
end

function SurvivalShelterRewardView:onOpen()
	self:refreshView()
end

function SurvivalShelterRewardView:refreshView()
	self:refreshReward()
	self:refreshProgress()
end

function SurvivalShelterRewardView:refreshProgress()
	local outsideInfo = SurvivalModel.instance:getOutSideInfo()
	local score = outsideInfo:getScore()

	self._txtScore.text = score

	local list = SurvivalShelterRewardListModel.instance:getList()
	local curIndex = #list
	local curShowIndex

	for i, v in ipairs(list) do
		if curShowIndex == nil and not outsideInfo:isGainReward(v.id) then
			curShowIndex = i
		end

		if score < v.score then
			curIndex = i - 1

			break
		end
	end

	if list[curIndex] then
		if not list[curIndex].score then
			local curScore = 0

			if list[curIndex + 1] then
				if not list[curIndex + 1].score then
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

function SurvivalShelterRewardView:getNodeWidth(index, beginPos)
	beginPos = beginPos or 0

	return (index > 0 or nil) and (index - 1) * (self.cellWidth + self.space) + (self.startSpace + self.cellWidth * 0.5) + beginPos
end

function SurvivalShelterRewardView:refreshReward()
	SurvivalShelterRewardListModel.instance:refreshList()
end

function SurvivalShelterRewardView:checkGetReward()
	local list = {}
	local rewardList = RoleStoryConfig.instance:getRewardList(self.storyId)

	if rewardList then
		for i, v in ipairs(rewardList) do
			if RoleStoryModel.instance:getRewardState(v.storyId, v.id, v.score) == 1 then
				table.insert(list, v.id)
			end
		end
	end

	if #list > 0 then
		HeroStoryRpc.instance:sendGetScoreBonusRequest(list)
	end
end

function SurvivalShelterRewardView:onClose()
	TaskDispatcher.cancelTask(self.checkGetReward, self)
end

function SurvivalShelterRewardView:onDestroyView()
	return
end

return SurvivalShelterRewardView
