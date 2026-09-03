-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneWarStage.lua

require("dm.gameplay.miniGame.model.gamePoint.MiniPlanePoint")

PlaneWarStage = class("PlaneWarStage", objectlua.Object, _M)

function PlaneWarStage:initialize(config)
	super.initialize(self)
end

function PlaneWarStage:sync(data)
	return
end
