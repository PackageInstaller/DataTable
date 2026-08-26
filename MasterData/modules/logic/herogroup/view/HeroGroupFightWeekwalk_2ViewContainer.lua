-- chunkname: @modules/logic/herogroup/view/HeroGroupFightWeekwalk_2ViewContainer.lua

module("modules.logic.herogroup.view.HeroGroupFightWeekwalk_2ViewContainer", package.seeall)

local HeroGroupFightWeekwalk_2ViewContainer = class("HeroGroupFightWeekwalk_2ViewContainer", HeroGroupFightViewContainer)

function HeroGroupFightWeekwalk_2ViewContainer:addFirstViews(views)
	HeroGroupFightWeekwalk_2ViewContainer.super.addFirstViews(self, views)
	table.insert(views, WeekWalk_2HeroGroupFightLayoutView.New())
end

function HeroGroupFightWeekwalk_2ViewContainer:defineFightView()
	self._heroGroupFightView = HeroGroupWeekWalk_2FightView.New()
	self._heroGroupFightListView = WeekWalk_2HeroGroupListView.New()
	self._heroGroupLevelView = WeekWalk_2HeroGroupFightView_Level.New()
end

function HeroGroupFightWeekwalk_2ViewContainer:addCommonViews(views)
	table.insert(views, self._heroGroupFightView)
	table.insert(views, HeroGroupAnimView.New())
	table.insert(views, self._heroGroupFightListView.New())
	table.insert(views, self._heroGroupLevelView.New())
	table.insert(views, HeroGroupFightWeekWalk_2ViewRule.New())
	table.insert(views, HeroGroupInfoScrollView.New())
	table.insert(views, CheckActivityEndView.New())
	table.insert(views, HeroGroupPresetFightView.New())
	table.insert(views, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(views, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

function HeroGroupFightWeekwalk_2ViewContainer:addLastViews(views)
	table.insert(views, HeroGroupFightWeekWalk_2View.New())
	table.insert(views, WeekWalk_2HeroGroupBuffView.New())

	self.helpView = HelpShowView.New()

	self.helpView:setHelpId(HelpEnum.HelpId.WeekWalk_2HeroGroup)
	table.insert(views, self.helpView)
end

function HeroGroupFightWeekwalk_2ViewContainer:getHelpId()
	return HelpEnum.HelpId.WeekWalk_2HeroGroup
end

return HeroGroupFightWeekwalk_2ViewContainer
