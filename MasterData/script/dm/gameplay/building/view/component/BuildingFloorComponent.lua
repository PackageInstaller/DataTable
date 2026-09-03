-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingFloorComponent.lua

BuildingFloorComponent = class("BuildingFloorComponent", DmBaseUI)

BuildingFloorComponent:has("_buildingMediator", {
	is = "rw"
})

function BuildingFloorComponent:initialize(view)
	super.initialize(self, view)
	self:setupView()
end

function BuildingFloorComponent:dispose()
	super.dispose(self)
end

function BuildingFloorComponent:enterWithData(data)
	return
end

function BuildingFloorComponent:setupView()
	return
end

function BuildingFloorComponent:adjustLayout(targetFrame)
	return
end
