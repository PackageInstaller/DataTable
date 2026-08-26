-- chunkname: @modules/logic/towercompose/model/TowerComposeBossMo.lua

module("modules.logic.towercompose.model.TowerComposeBossMo", package.seeall)

local TowerComposeBossMo = class("TowerComposeBossMo", TowerComposeBossMo)

function TowerComposeBossMo:ctor(params)
	self.themeId = params.themeId
	self.highScore = 0
	self.curScore = 0
	self.level = 0
	self.lock = false
	self.planeInfoMap = {}
end

function TowerComposeBossMo:updateComposeBossInfo(bossInfo)
	for index, planeInfo in ipairs(bossInfo.planes) do
		self:updatePlaneInfoData(planeInfo)
	end

	self.highScore = bossInfo.highScore
	self.curScore = bossInfo.currScore
	self.level = bossInfo.level
	self.lock = bossInfo.lock
end

function TowerComposeBossMo:updatePlaneInfoData(planeInfo)
	local planeInfoMo = self.planeInfoMap[planeInfo.planeId]

	if not planeInfoMo then
		planeInfoMo = TowerComposePlaneMo.New({
			themeId = self.themeId
		})
		self.planeInfoMap[planeInfo.planeId] = planeInfoMo
	end

	planeInfoMo:updateInfo(planeInfo)
end

function TowerComposeBossMo:getPlaneMo(planeId)
	return self.planeInfoMap[planeId]
end

function TowerComposeBossMo:getPlaneInfoMap()
	return self.planeInfoMap
end

function TowerComposeBossMo:setBossLevel(level)
	self.level = level
end

return TowerComposeBossMo
