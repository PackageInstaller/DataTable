-- chunkname: @IQIGame\\Net\\NetEquipResponse.lua

function net_equip.wearEquipResult(code)
	NetCommController.Responded()
	EquipModule.ReplaceEquipSucceed(code)
end

function net_equip.upgradeEquipResult(code, cri, oldEquipPOD, equipPOD)
	NetCommController.Responded()
	EquipModule.IntensifyEquipSucceed(oldEquipPOD, equipPOD)
end

function net_equip.unloadEquipResult(code)
	EquipModule.UnloadEquipSucceed(code)
end

function net_equip.lockEquipResult(code)
	EquipModule.LockEquipSucceed(code)
end

function net_equip.decomposeEquipResult(code)
	EquipModule.OnDecomposeEquipSuccess()
end

function net_equip.succinctAttrResult(code, id, attrCid, type, attrMap, attrValueMap)
	local userData = {
		equipId = id,
		attrCid = attrCid,
		succinctType = type,
		attrMap = attrMap,
		attrValueMap = attrValueMap
	}

	UIModule.Open(Constant.UIControllerName.EquipSuccinctTipsUI, Constant.UILayer.UI, userData)
end

function net_equip.applySuccinctAttrResult(code)
	EventDispatcher.Dispatch(EventID.OnApplySuccinctAttrResult)
end
