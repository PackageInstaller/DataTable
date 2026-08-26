-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/VersionActivity1_8FactoryCompositeViewContainer.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryCompositeViewContainer", package.seeall)

local VersionActivity1_8FactoryCompositeViewContainer = class("VersionActivity1_8FactoryCompositeViewContainer", BaseViewContainer)

function VersionActivity1_8FactoryCompositeViewContainer:buildViews()
	return {
		VersionActivity1_8FactoryCompositeView.New()
	}
end

return VersionActivity1_8FactoryCompositeViewContainer
