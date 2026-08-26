-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossHeroGroupFightViewContainer.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossHeroGroupFightViewContainer", package.seeall)

local Rouge2_BossHeroGroupFightViewContainer = class("Rouge2_BossHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function Rouge2_BossHeroGroupFightViewContainer:defineFightView()
	self._heroGroupFightView = Rouge2_BossHeroGroupFightView.New()
	self._heroGroupFightListView = HeroGroupListView.New()
end

function Rouge2_BossHeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	Rouge2_BossBattleController.instance:onExitHeroGroup()
end

return Rouge2_BossHeroGroupFightViewContainer
