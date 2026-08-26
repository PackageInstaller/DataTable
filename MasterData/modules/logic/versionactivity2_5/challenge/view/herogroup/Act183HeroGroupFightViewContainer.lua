-- chunkname: @modules/logic/versionactivity2_5/challenge/view/herogroup/Act183HeroGroupFightViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupFightViewContainer", package.seeall)

local Act183HeroGroupFightViewContainer = class("Act183HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function Act183HeroGroupFightViewContainer:addLastViews(views)
	return
end

function Act183HeroGroupFightViewContainer:defineFightView()
	self._heroGroupFightView = Act183HeroGroupFightView.New()
	self._heroGroupFightListView = Act183HeroGroupListView.New()
	self._heroGroupLevelView = Act183HeroGroupFightView_Level.New()
end

function Act183HeroGroupFightViewContainer:addCommonViews(views)
	table.insert(views, self._heroGroupFightView)
	table.insert(views, HeroGroupAnimView.New())
	table.insert(views, self._heroGroupFightListView.New())
	table.insert(views, self._heroGroupLevelView.New())
	table.insert(views, HeroGroupFightViewRule.New())
	table.insert(views, HeroGroupInfoScrollView.New())
	table.insert(views, CheckActivityEndView.New())
	table.insert(views, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(views, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

function Act183HeroGroupFightViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
	return true
end

return Act183HeroGroupFightViewContainer
