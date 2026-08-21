-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkGameObjectCollection.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkGameObjectCollection", package.seeall)

local AirWorkGameObjectCollection = class("AirWorkGameObjectCollection")

function AirWorkGameObjectCollection:ctor(url)
	self._url = url
	self._usingList = {}
end

function AirWorkGameObjectCollection:getInstList()
	return self._usingList
end

function AirWorkGameObjectCollection:createInstance(goParent)
	local goInst = AirWorkReusablePoolMgr.instance:fetchGameObjectInstance(self._url, goParent)

	table.insert(self._usingList, goInst)

	return goInst
end

function AirWorkGameObjectCollection:releaseInstance(goInst)
	AirWorkReusablePoolMgr.instance:returnGameObjectInstance(self._url, goInst)
	table.removebyvalue(self._usingList, goInst)
end

function AirWorkGameObjectCollection:clear()
	for _, goInst in pairs(self._usingList) do
		AirWorkReusablePoolMgr.instance:returnGameObjectInstance(self._url, goInst)
	end

	BattleTableUtil.clearTable(self._usingList)
end

return AirWorkGameObjectCollection
