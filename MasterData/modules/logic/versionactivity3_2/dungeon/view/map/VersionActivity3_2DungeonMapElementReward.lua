-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapElementReward.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapElementReward", package.seeall)

local VersionActivity3_2DungeonMapElementReward = class("VersionActivity3_2DungeonMapElementReward", DungeonMapElementReward)

function VersionActivity3_2DungeonMapElementReward:_OnRemoveElement(id)
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
			-- block empty
		else
			self._lastViewName = config.type == DungeonEnum.ElementType.Investigate and ViewName.InvestigateTipsView or ViewName.VersionActivity3_2DungeonFragmentInfoView
		end

		if self._lastViewName then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.DungeonFragmentInfoView, self._lastViewName, {
				elementId = config.id,
				fragmentId = config.fragment,
				notShowToast = self.notShowToast
			})
		end
	end

	if config.type == DungeonEnum.ElementType.EnterDialogue then
		self._lastViewName = ViewName.DialogueView
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

return VersionActivity3_2DungeonMapElementReward
