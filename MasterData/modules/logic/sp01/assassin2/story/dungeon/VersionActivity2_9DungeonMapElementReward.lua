-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapElementReward.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapElementReward", package.seeall)

local VersionActivity2_9DungeonMapElementReward = class("VersionActivity2_9DungeonMapElementReward", BaseView)

function VersionActivity2_9DungeonMapElementReward:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_9DungeonMapElementReward:addEvents()
	return
end

function VersionActivity2_9DungeonMapElementReward:removeEvents()
	return
end

function VersionActivity2_9DungeonMapElementReward:_editableInitView()
	return
end

function VersionActivity2_9DungeonMapElementReward:onUpdateParam()
	return
end

function VersionActivity2_9DungeonMapElementReward:onOpen()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self._OnRemoveElement, self, LuaEventSystem.High)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function VersionActivity2_9DungeonMapElementReward:_onCloseViewFinish(viewName)
	if viewName == self._lastViewName then
		if self._rewardPoint then
			self:_dispatchEvent()
		end

		DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
	end
end

function VersionActivity2_9DungeonMapElementReward:setShowToastState(state)
	self.notShowToast = state
end

function VersionActivity2_9DungeonMapElementReward:_OnRemoveElement(id)
	local config = lua_chapter_map_element.configDict[id]

	self._lastViewName = nil
	self._rewardPoint = nil

	local rewardStr = DungeonModel.instance:getMapElementReward(id)

	if not string.nilorempty(rewardStr) then
		local list = GameUtil.splitString2(rewardStr, false, "|", "#")
		local dataList = {}

		for i, v in ipairs(list) do
			local materialData = MaterialDataMO.New()

			materialData:initValue(v[1], v[2], v[3])
			table.insert(dataList, materialData)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, dataList)

		self._lastViewName = ViewName.CommonPropView
	end

	if config.fragment > 0 then
		local fragmentCo = lua_chapter_map_fragment.configDict[config.fragment]

		if fragmentCo and fragmentCo.type == DungeonEnum.FragmentType.LeiMiTeBeiNew then
			self._lastViewName = ViewName.VersionActivityNewsView
		elseif config.type == DungeonEnum.ElementType.SpStory then
			if fragmentCo and fragmentCo.type == DungeonEnum.FragmentType.AvgStory then
				self._lastViewName = ViewName.StoryView
			end
		else
			self._lastViewName = config.type == DungeonEnum.ElementType.Investigate and ViewName.InvestigateTipsView or ViewName.VersionActivity2_9DungeonFragmentInfoView
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.DungeonFragmentInfoView, self._lastViewName, {
			elementId = config.id,
			fragmentId = config.fragment,
			notShowToast = self.notShowToast
		})
	end

	if self._lastViewName then
		DungeonController.instance:dispatchEvent(DungeonEvent.BeginShowRewardView)
	end

	if config.rewardPoint > 0 then
		self._rewardPoint = config.rewardPoint

		if not self._lastViewName then
			self:_dispatchEvent()
		end
	end
end

function VersionActivity2_9DungeonMapElementReward:_dispatchEvent()
	DungeonModel.instance:endCheckUnlockChapter()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnAddRewardPoint, self._rewardPoint)

	self._rewardPoint = nil
end

function VersionActivity2_9DungeonMapElementReward:onClose()
	return
end

function VersionActivity2_9DungeonMapElementReward:onDestroyView()
	return
end

return VersionActivity2_9DungeonMapElementReward
