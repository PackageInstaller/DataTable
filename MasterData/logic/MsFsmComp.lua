-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/fsm/MsFsmComp.lua

module("logic.extensions.spineinterface.fsm.MsFsmComp", package.seeall)

local MsFsmComp = class("MsFsmComp")

function MsFsmComp:ctor()
	self._fsmDic = {}
	self._tempFsmList = {}
end

function MsFsmComp:onUpdate(elapseSeconds, realElapseSeconds)
	table.clear(self._tempFsmList)

	for _, fsm in pairs(self._fsmDic) do
		table.insert(self._tempFsmList, fsm)
	end

	for _, fsm in ipairs(self._tempFsmList) do
		if not fsm:isDestroyed() then
			fsm:onUpdate(elapseSeconds, realElapseSeconds)
		end
	end
end

function MsFsmComp:onDestroy()
	for fsmName, fsm in pairs(self._fsmDic) do
		self:destroyFsm(fsmName)

		self._fsmDic[fsmName] = nil
	end
end

function MsFsmComp:isHasFsm(fsmName)
	return self._fsmDic[fsmName] ~= nil
end

function MsFsmComp:createFsm(fsmName, states)
	if self:isHasFsm(fsmName) then
		printError(string.format("Already exist FSM '%s'.", fsmName))
	end

	local fsm = MsFsm.createFsm(fsmName, states)

	self._fsmDic[fsmName] = fsm

	return fsm
end

function MsFsmComp:destroyFsm(fsmName)
	local fsm = self._fsmDic[fsmName]

	if fsm then
		fsm:destroyFsm()

		self._fsmDic[fsmName] = nil

		return true
	end

	return false
end

return MsFsmComp
