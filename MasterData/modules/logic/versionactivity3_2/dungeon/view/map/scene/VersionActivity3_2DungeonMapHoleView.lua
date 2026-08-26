-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/scene/VersionActivity3_2DungeonMapHoleView.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.scene.VersionActivity3_2DungeonMapHoleView", package.seeall)

local VersionActivity3_2DungeonMapHoleView = class("VersionActivity3_2DungeonMapHoleView", VersionActivityFixedDungeonMapHoleView)

function VersionActivity3_2DungeonMapHoleView:refreshHoles()
	if not self.loadSceneDone or gohelper.isNil(self.mat) then
		return
	end

	local index = 1

	for _, pos in pairs(self.holdCoList) do
		local x = pos[1] + self.sceneWorldPosX - self.defaultSceneWorldPosX
		local y = pos[2] + self.sceneWorldPosY - self.defaultSceneWorldPosY
		local size = math.abs(pos[3])
		local xDistance = math.sqrt((self.mainCameraPosX - x)^2)
		local yDistance = math.sqrt((self.mainCameraPosY - y)^2)

		if index > 5 then
			logError("元件太多无法挖孔")

			return
		end

		self.tempVector4:Set(x, y, pos[3])
		self.mat:SetVector(self.shaderParamList[index], self.tempVector4)

		index = index + 1
	end

	for i = index, 5 do
		self.tempVector4:Set(100, 100, 100)
		self.mat:SetVector(self.shaderParamList[i], self.tempVector4)
	end
end

return VersionActivity3_2DungeonMapHoleView
