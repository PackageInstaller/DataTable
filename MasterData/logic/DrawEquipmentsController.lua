-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/controller/DrawEquipmentsController.lua

module("logic.extensions.drawequipments.controller.DrawEquipmentsController", package.seeall)

local DrawEquipmentsController = class("DrawEquipmentsController", BaseController)
local itemRefineHammers = {
	[8002] = true,
	[8001] = true,
	[8003] = true
}

DrawEquipmentsController.EquipEffsByQuality = {
	"fx_ui_chouka_10_linshi/zong1.prefab",
	"fx_ui_chouka_10_linshi/zong2.prefab",
	"fx_ui_chouka_10_linshi/zong3.prefab",
	"fx_ui_chouka_10_linshi/zong4.prefab"
}
DrawEquipmentsController.drawEffectsConfig = {
	{
		soundId = 30228,
		effNodes = "chouka_all/zhengfangti/equipNode/effNodes",
		effectTime = 6,
		effectPath = "fx_ui_chouka_10_linshi/fx_chouka_1g_linshi.prefab"
	},
	[10] = {
		soundId = 30229,
		effNodes = "chouka_all/kapai1_all",
		effectTime = 6,
		effectPath = "fx_ui_chouka_10_linshi/fx_chouka_10_linshi.prefab"
	}
}

function DrawEquipmentsController:onInit()
	self:onReset()
end

function DrawEquipmentsController:onReset()
	self._isRequestingInfo = false
	self._lastDrawPoolId = 0
	self._lastDrawPoolTimes = 0
	self._lastOpenPoolId = nil
	self._lastDrawChangeSet = 0
	self._lastDrawItems = nil
	self._lastDrawQualities = nil
end

function DrawEquipmentsController:getLastOpenPoolId()
	return self._lastOpenPoolId
end

function DrawEquipmentsController:setLastOpenPoolId(lastOpenPoolId)
	self._lastOpenPoolId = lastOpenPoolId
end

function DrawEquipmentsController:getEquipmentPoolInfoReq()
	if self._isRequestingInfo then
		return
	end

	self._isRequestingInfo = true

	DrawEquipmentsAgent.instance:sendPM_EquipmentPoolInfoReq()
end

function DrawEquipmentsController:onEquipmentPoolInfo(status, msg)
	self._isRequestingInfo = false

	if status ~= 0 then
		return
	end

	DrawEquipmentsModel.instance:onEquipmentPoolInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnDrawEquipmentsInfo)
end

function DrawEquipmentsController:drawEquipmentPoolDraw(poolId, times)
	if self._lastDrawPoolId ~= 0 then
		return
	end

	self._lastDrawPoolId = poolId
	self._lastDrawPoolTimes = times

	DrawEquipmentsAgent.instance:sendPM_EquipmentPoolDrawReq(poolId, times)
end

function DrawEquipmentsController:onEquipmentPoolDraw(status, msg)
	if self._lastDrawPoolId == 0 then
		return
	end

	local poolId = self._lastDrawPoolId
	local times = self._lastDrawPoolTimes

	self._lastDrawPoolId = 0
	self._lastDrawPoolTimes = 0

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

	self._lastDrawItems = MaterialController.instance:getTempItemsByChangeSetId(msg.changeSetId)
	self._lastDrawChangeSet = msg.changeSetId
	self._lastDrawQualities = self:_getDrawEquipsQuality()

	if status == 0 then
		DrawEquipmentsModel.instance:onEquipmentPoolDraw(poolId, times, (msg:HasField("lastSSR") or nil) and msg.lastSSR)
		GlobalDispatcher:dispatch(GlobalNotify.OnDrawEquipmentDrawBack, poolId, times)
	end
end

function DrawEquipmentsController:getDrawChangesetId()
	return self._lastDrawChangeSet
end

function DrawEquipmentsController:getDrawItems()
	return self._lastDrawItems
end

function DrawEquipmentsController:getDrawQualities()
	return self._lastDrawQualities
end

function DrawEquipmentsController:_getDrawEquipsQuality()
	if not self._lastDrawItems then
		return
	end

	local qualitys

	for i = 1, #self._lastDrawItems do
		local mo = self._lastDrawItems[i]
		local matType = MaterialMgr.getMoType(mo)
		local bagMo = MaterialMgr.getModel(matType, mo:getId())
		local defineId = bagMo:getDefineId()

		if matType == MatType.Equipment then
			local equipCo = EquipmentConfig.instance:GetEquipDefineInfoById(defineId)

			if equipCo then
				qualitys = qualitys or {}

				table.insert(qualitys, equipCo.qualityBase)
			end
		elseif not itemRefineHammers[defineId] then
			local itemCo = MaterialMgr.getMatCfg(matType, defineId)

			if itemCo then
				qualitys = qualitys or {}

				table.insert(qualitys, itemCo.quality)
			end
		end
	end

	return qualitys
end

function DrawEquipmentsController:openDrawEquipmentView(poolId)
	local tryOpenPoolId = poolId
	local openPoolId
	local currOpenPools = DrawEquipmentsModel.instance:getCurrOpenPools()

	if tryOpenPoolId then
		for i = 1, #currOpenPools do
			if currOpenPools[i]:getPoolId() == poolId then
				openPoolId = poolId

				break
			end
		end
	end

	openPoolId = openPoolId or currOpenPools[1]:getPoolId()
	self._lastOpenPoolId = openPoolId

	UIStateManager.instance:push(ViewName.DrawEquipmentsView, openPoolId, tryOpenPoolId)
end

DrawEquipmentsController.instance = DrawEquipmentsController.New()

return DrawEquipmentsController
