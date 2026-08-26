-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3MapEpisodeItem.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3MapEpisodeItem", package.seeall)

local VersionActivity1_3MapEpisodeItem = class("VersionActivity1_3MapEpisodeItem", VersionActivity1_3DungeonBaseEpisodeItem)

function VersionActivity1_3MapEpisodeItem:_promptlyShow()
	return not ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonChangeView)
end

function VersionActivity1_3MapEpisodeItem:_onCloseViewFinish(viewName)
	if viewName == ViewName.VersionActivity1_3DungeonChangeView and self._needShowMapLevelView then
		self:_showMapLevelView()
	end
end

return VersionActivity1_3MapEpisodeItem
