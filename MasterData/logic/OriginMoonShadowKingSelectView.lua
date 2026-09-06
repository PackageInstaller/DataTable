-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmoonshadowking/view/OriginMoonShadowKingSelectView.lua

module("logic.extensions.originmoonshadowking.view.OriginMoonShadowKingSelectView", package.seeall)

local OriginMoonShadowKingSelectView = class("OriginMoonShadowKingSelectView", ShenJiSelectView)

OriginMoonShadowKingSelectView.posNode = {
	{
		9.85,
		-88
	},
	{
		9.85,
		-88
	},
	{
		44,
		-88
	}
}

function OriginMoonShadowKingSelectView:buildUI()
	OriginMoonShadowKingSelectView.super.buildUI(self)

	self._tabNode = self:getGo("main/levels/tab/node")
end

function OriginMoonShadowKingSelectView:_onClickLevel(index)
	goutil.setActive(self._tab, true)
	self._tab.transform:SetSiblingIndex(index)
	self:_updateCurLevel(index)
	self:_updateLevelsLayout(index)

	if self._tabNode then
		local pos = OriginMoonShadowKingSelectView.posNode[index]
		local x = pos[1]
		local y = pos[2]

		GameUtil.setAnchoredPos(self._tabNode, x, y)
	end
end

function OriginMoonShadowKingSelectView:_onClickTip()
	local actCfg = ShenJiChallengeConfig.instance:getActivityCfg(self._activityId)
	local ruleTip = actCfg.ruleTip

	if ruleTip then
		UIStateManager.instance:push(ViewName.RulesView, ruleTip)
	end
end

return OriginMoonShadowKingSelectView
