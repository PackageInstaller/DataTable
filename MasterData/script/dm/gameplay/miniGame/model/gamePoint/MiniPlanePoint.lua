-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/gamePoint/MiniPlanePoint.lua

MiniPlanePoint = class("MiniPlanePoint", objectlua.Object, _M)

MiniPlanePoint:has("_id", {
	is == "r"
})
MiniPlanePoint:has("_pointConfig", {
	is == "r"
})

function MiniPlanePoint:initialize(id)
	super.initialize(self)

	self._id = id
	self._pointConfig = ConfigReader:getRecordById("MiniPlanePoint", id[1])
end

function MiniPlanePoint:getWave()
	return self._pointConfig.Wave
end

function MiniPlanePoint:getEnergy()
	return self._pointConfig.Energy
end

function MiniPlanePoint:getDoubleTime()
	return self._pointConfig.DoubleTime
end

function MiniPlanePoint:getPlayerBulletAction()
	return self._pointConfig.PlayerAmmo
end

function MiniPlanePoint:getEnergyNeed()
	return self._pointConfig.EnergyNeed
end

function MiniPlanePoint:getFirstSleepTime()
	return self._pointConfig.FirstTime
end
