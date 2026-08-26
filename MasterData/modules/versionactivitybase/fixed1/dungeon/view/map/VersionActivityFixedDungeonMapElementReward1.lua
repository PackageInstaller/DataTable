-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/VersionActivityFixedDungeonMapElementReward1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.VersionActivityFixedDungeonMapElementReward1", package.seeall)

local VersionActivityFixedDungeonMapElementReward1 = class("VersionActivityFixedDungeonMapElementReward1", DungeonMapElementReward)

function VersionActivityFixedDungeonMapElementReward1:_OnRemoveElement(id)
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
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

	local dungeonFragmentInfoView = VersionActivityFixedHelper.getVersionActivityDungeonFragmentInfoViewName(bigVersion, smallVersion)

	if config.fragment > 0 then
		local fragmentCo = lua_chapter_map_fragment.configDict[config.fragment]

		if fragmentCo and fragmentCo.type == DungeonEnum.FragmentType.LeiMiTeBeiNew then
			self._lastViewName = ViewName.VersionActivityNewsView
		elseif config.type == DungeonEnum.ElementType.SpStory then
			-- block empty
		else
			self._lastViewName = config.type == DungeonEnum.ElementType.Investigate and ViewName.InvestigateTipsView or dungeonFragmentInfoView
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

return VersionActivityFixedDungeonMapElementReward1
