-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6BossFightSuccViewContainer.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6BossFightSuccViewContainer", package.seeall)

local VersionActivity1_6BossFightSuccViewContainer = class("VersionActivity1_6BossFightSuccViewContainer", BaseViewContainer)

function VersionActivity1_6BossFightSuccViewContainer:buildViews()
	return {
		VersionActivity1_6BossFightSuccView.New()
	}
end

return VersionActivity1_6BossFightSuccViewContainer
