-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/controller/KernelSystem.lua

require("dm.gameplay.develop.model.kernel.KernelList")

KernelSystem = class("KernelSystem", Facade, _M)

KernelSystem:has("_kernelList", {
	is = "r"
}):injectWith("KernelList")

function KernelSystem:initialize(developSystem)
	super.initialize(self)

	self._developSystem = developSystem
end

function KernelSystem:synchronize(kernelData)
	self._kernelList = self:getInjector():getInstance(KernelList)

	self._kernelList:synchronize(kernelData)
end

function KernelSystem:synchronizeDel(kernelData)
	self._kernelList = self:getInjector():getInstance(KernelList)

	self._kernelList:synchronizeDel(kernelData)
end

function KernelSystem:synchronizeDelEquip(kernelData)
	self._kernelList = self:getInjector():getInstance(KernelList)

	self._kernelList:synchronizeDelEquip(kernelData)
end

function KernelSystem:getEquipKernelByMasterId(entryId)
	return
end

function KernelSystem:getOneKernelById(entryId)
	return
end

function KernelSystem:getUseKernelById(groupId)
	return
end

function KernelSystem:getOneSuitKernelById(suitId)
	return
end

function KernelSystem:getAllSuitList()
	return
end

function KernelSystem:getAllKernel()
	return self._kernelList:getAllKernelList(), self:getAllKernelNum()
end

function KernelSystem:getAllKernelNum()
	local len = 0
	local list = self._kernelList:getAllKernelList()

	for k, v in pairs(list) do
		if v ~= nil then
			len = len + 1
		end
	end

	return len
end

function KernelSystem:getKernelIndex()
	return self._kernelList._intKernelList
end

function KernelSystem:sortListByType(list, srotype)
	self._kernelList:sortListByType(list, srotype)
end

function KernelSystem:requestUseKernel(kernelid, masterid, callback)
	local kernelService = self:getInjector():getInstance(KernelService)
	local data = {
		kernelId = kernelid,
		masterId = masterid
	}

	print("要装备的核心id::", kernelid, " 主角id::", masterid)
	kernelService:requestUseKernel(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_KERNEL_USE_KERNEL, heroId))
		end
	end)
end

function KernelSystem:requestStrengthenKernel(kernelid, eatList, callback)
	local kernelService = self:getInjector():getInstance(KernelService)
	local data = {
		kernelId = kernelid,
		resList = eatList
	}

	dump(data, "强化发送参数")
	kernelService:requestStrengthenKernel(data, true, function(response)
		dump(response, "requestStrengthenKernel___20103返回")

		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_KERNEL_STRENGTHEN_KERNEL, heroId))
		end
	end)
end

function KernelSystem:requestUnloadKernel(kernelPos, targeyMasterId, callback)
	local kernelService = self:getInjector():getInstance(KernelService)
	local data = {
		pos = kernelPos,
		masterId = targeyMasterId
	}

	kernelService:requestUnloadKernel(data, true, function(response)
		dump(response, "requestUnloadKernel___20102返回")

		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_KERNEL_UNLOAD_KERNEL, heroId))
		end
	end)
end

function KernelSystem:addEatKernelList(serverid)
	self._kernelList:addEatKernelList(serverid)
end

function KernelSystem:delEatKernelList(serverid)
	self._kernelList:delEatKernelList(serverid)
end

function KernelSystem:getEatList()
	return self._kernelList:getEatList()
end

function KernelSystem:calculateEatListExp()
	return self._kernelList:calculateEatListExp()
end

function KernelSystem:getSuiteList(suiteId)
	return self._kernelList:getSuiteList(suiteId)
end

function KernelSystem:getOneKernelByConfigId(configid)
	return self._kernelList:getOneKernelByConfigId(configid)
end

function KernelSystem:getNameByConfigId(configid)
	return self._kernelList:getNameByConfigId(configid)
end

function KernelSystem:getPosByConfigId(configid)
	return self._kernelList:getPosByConfigId(configid)
end

function KernelSystem:resetEatList()
	self._kernelList:resetEatList()
end

function KernelSystem:getMainEffectDesc(kerneldata)
	return self._kernelList:getMainEffectDesc(kerneldata)
end

function KernelSystem:getSubEffectDesc(kerneldata)
	return self._kernelList:getSubEffectDesc(kerneldata)
end

function KernelSystem:getOneSuitDescByKernelId(configid)
	return self._kernelList:getOneSuitDescByKernelId(configid)
end

function KernelSystem:calculateEquipListAttribute(equipdata)
	return self._kernelList:calculateEquipListAttribute(equipdata)
end

function KernelSystem:getOneSuiteHaveNum(suiteid)
	return self._kernelList:getOneSuiteHaveNum(suiteid)
end

function KernelSystem:getKernelByPos(pos)
	return self._kernelList:getKernelByPos(pos)
end

function KernelSystem:getNeedExpToNextLevel(configId, nextlevel)
	return self._kernelList:getNeedExpToNextLevel(configId, nextlevel)
end

function KernelSystem:findKernelOneKernelInt(serverid)
	return self._kernelList:findKernelOneKernelInt(serverid)
end

function KernelSystem:getStrengthenLevel(curlevel, eatexp)
	return self._kernelList:getStrengthenLevel(curlevel, eatexp)
end

function KernelSystem:getEquipSuiteDesc(kerneldata)
	return self._kernelList:getEquipSuiteDesc(kerneldata)
end
