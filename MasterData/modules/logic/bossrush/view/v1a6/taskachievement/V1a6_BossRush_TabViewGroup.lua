-- chunkname: @modules/logic/bossrush/view/v1a6/taskachievement/V1a6_BossRush_TabViewGroup.lua

module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_TabViewGroup", package.seeall)

local V1a6_BossRush_TabViewGroup = class("V1a6_BossRush_TabViewGroup", TabViewGroup)

function V1a6_BossRush_TabViewGroup:_setVisible(tabId, isVisible)
	local canvasGroup = self._tabCanvasGroup[tabId]

	if not canvasGroup then
		local viewGO = self._tabViews[tabId].viewGO

		canvasGroup = gohelper.onceAddComponent(viewGO, typeof(UnityEngine.CanvasGroup))
		self._tabCanvasGroup[tabId] = canvasGroup
	end

	canvasGroup.interactable = isVisible
	canvasGroup.blocksRaycasts = isVisible
end

return V1a6_BossRush_TabViewGroup
