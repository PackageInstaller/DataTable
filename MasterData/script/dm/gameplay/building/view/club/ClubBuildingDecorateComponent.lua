-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/club/ClubBuildingDecorateComponent.lua

ClubBuildingDecorateComponent = class("ClubBuildingDecorateComponent", BuildingDecorateComponent)

function ClubBuildingDecorateComponent:initialize(view)
	super.initialize(self, view)
end

function ClubBuildingDecorateComponent:dispose()
	super.dispose(self)
end

function ClubBuildingDecorateComponent:instantiateBuildingHero(node)
	return self:getInjector():instantiate("ClubBuildingHero", {
		view = node
	})
end
