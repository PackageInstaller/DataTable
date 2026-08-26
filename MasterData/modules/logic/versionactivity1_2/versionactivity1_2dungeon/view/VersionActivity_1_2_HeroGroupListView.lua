-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_HeroGroupListView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupListView", package.seeall)

local VersionActivity_1_2_HeroGroupListView = class("VersionActivity_1_2_HeroGroupListView", HeroGroupListView)

function VersionActivity_1_2_HeroGroupListView:_onHeroGroupExit()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if self._openTweenIdList then
		for i, openTweenId in ipairs(self._openTweenIdList) do
			ZProj.TweenHelper.KillById(openTweenId)
		end
	end

	self._closeTweenIdList = {}

	for i = 1, 4 do
		local closeTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - i), nil, self._closeTweenFinish, self, i, EaseType.Linear)

		table.insert(self._closeTweenIdList, closeTweenId)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(ViewName.VersionActivity_1_2_HeroGroupView, false, false)
end

return VersionActivity_1_2_HeroGroupListView
