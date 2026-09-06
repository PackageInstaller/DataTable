-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/ExpedTilingElemsMgr.lua

module("logicscene.scene.component.mainplayer.ExpedTilingElemsMgr", package.seeall)

local ExpedTilingElemsMgr = class("ExpedTilingElemsMgr", TilingElemsMgr)

function ExpedTilingElemsMgr:_onTilingElemDelete(elemData)
	ExpedTilingElemsMgr.super._onTilingElemDelete(self, elemData)

	local bindExpedData = elemData.bindExpGridData
	local units = self._scene.unitFactory:getUnits(UnitTag.TilingSceneElem)

	for id, unit in pairs(units) do
		if unit.elemData and unit.elemData.bindExpGridData then
			local gridData = unit.elemData.bindExpGridData

			if gridData.eventId == bindExpedData.eventId and gridData.eventIndex == bindExpedData.eventIndex then
				self._scene.unitFactory:destroyCommonObject(UnitTag.TilingSceneElem, unit.id)

				return
			end
		end
	end
end

return ExpedTilingElemsMgr
