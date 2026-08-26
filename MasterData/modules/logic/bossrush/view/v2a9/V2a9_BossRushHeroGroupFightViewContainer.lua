-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushHeroGroupFightViewContainer.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushHeroGroupFightViewContainer", package.seeall)

local V2a9_BossRushHeroGroupFightViewContainer = class("V2a9_BossRushHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function V2a9_BossRushHeroGroupFightViewContainer:defineFightView()
	self._heroGroupFightView = V2a9_BossRushHeroGroupFightView.New()
	self._heroGroupFightListView = HeroGroupListView.New()
end

function V2a9_BossRushHeroGroupFightViewContainer:addCommonViews(views)
	table.insert(views, self._heroGroupFightView)
	table.insert(views, HeroGroupAnimView.New())
	table.insert(views, self._heroGroupFightListView.New())
	table.insert(views, V2a9_BossRushHeroGroupFightViewLevel.New())
	table.insert(views, HeroGroupFightViewRule.New())
	table.insert(views, HeroGroupInfoScrollView.New())
	table.insert(views, CheckActivityEndView.New())
	table.insert(views, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(views, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

return V2a9_BossRushHeroGroupFightViewContainer
