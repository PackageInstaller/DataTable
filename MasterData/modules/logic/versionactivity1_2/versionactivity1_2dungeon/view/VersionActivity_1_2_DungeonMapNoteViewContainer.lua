-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_DungeonMapNoteViewContainer.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapNoteViewContainer", package.seeall)

local VersionActivity_1_2_DungeonMapNoteViewContainer = class("VersionActivity_1_2_DungeonMapNoteViewContainer", BaseViewContainer)

function VersionActivity_1_2_DungeonMapNoteViewContainer:buildViews()
	return {
		VersionActivity_1_2_DungeonMapNoteView.New()
	}
end

return VersionActivity_1_2_DungeonMapNoteViewContainer
