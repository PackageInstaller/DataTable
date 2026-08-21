-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/pool/util/BattleGameObjectCollection.lua

module("logic.battle.pool.util.BattleGameObjectCollection", package.seeall)

local BattleGameObjectCollection = class("BattleGameObjectCollection")

function BattleGameObjectCollection:ctor(url)
	self._url = url
	self._usingList = {}
end

function BattleGameObjectCollection:getInstList()
	return self._usingList
end

function BattleGameObjectCollection:createInstance(goParent)
	local goInst = BattleReusablePoolMgr.instance:fetchGameObjectInstance(self._url, goParent)

	table.insert(self._usingList, goInst)

	return goInst
end

function BattleGameObjectCollection:releaseInstance(goInst)
	BattleReusablePoolMgr.instance:returnGameObjectInstance(self._url, goInst)
	table.removebyvalue(self._usingList, goInst)
end

function BattleGameObjectCollection:clear()
	for _, goInst in pairs(self._usingList) do
		BattleReusablePoolMgr.instance:returnGameObjectInstance(self._url, goInst)
	end

	BattleTableUtil.clearTable(self._usingList)
end

return BattleGameObjectCollection
