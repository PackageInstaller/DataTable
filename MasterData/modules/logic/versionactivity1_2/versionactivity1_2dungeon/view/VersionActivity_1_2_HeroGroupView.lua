-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_HeroGroupView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupView", package.seeall)

local VersionActivity_1_2_HeroGroupView = class("VersionActivity_1_2_HeroGroupView", HeroGroupFightView)

function VersionActivity_1_2_HeroGroupView:openHeroGroupEditView()
	ViewMgr.instance:openView(ViewName.VersionActivity_1_2_HeroGroupEditView, self._param)
end

return VersionActivity_1_2_HeroGroupView
