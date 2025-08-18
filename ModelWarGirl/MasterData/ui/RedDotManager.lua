-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RedDotManager.lua

local RedDotMgr = {}
local self = RedDotMgr

self._rdFKey2CKeys = {}
self._rdCKey2FKeys = {}

function RedDotMgr.setKeyRelation(cKey, fKey)
	if fKey == nil or cKey == nil then
		return
	end

	local cKeys = self._rdFKey2CKeys[fKey] or {}

	cKeys[cKey] = true
	self._rdFKey2CKeys[fKey] = cKeys

	local fKeys = self._rdCKey2FKeys[cKey] or {}

	fKeys[fKey] = true
	self._rdCKey2FKeys[cKey] = fKeys

	self.updateDotsByKey(cKey)
end

function RedDotMgr.delKeyRelation(cKey, fKey)
	if fKey then
		local cKeys = self._rdFKey2CKeys[fKey] or {}

		if cKey then
			cKeys[cKey] = nil
			self._rdFKey2CKeys[fKey] = cKeys
		else
			self._rdFKey2CKeys[fKey] = nil
		end

		self.updateDotsByKey(fKey)
	end

	if cKey then
		local fKeys = self._rdCKey2FKeys[cKey] or {}

		if fKey then
			fKeys[fKey] = nil
			self._rdCKey2FKeys[cKey] = fKeys
		else
			for key, _ in pairs(fKeys) do
				self.updateDotsByKey(key)
			end

			self._rdCKey2FKeys[cKey] = nil
		end
	end
end

self._rdKey2State = {}
self._rdKey2Dots = {}
self._rootDots = {}
self._dotMap = {}
self._dotIDIdx = 1

function RedDotMgr.clearRegistedRedDot()
	for key, _ in pairs(self._rdKey2State) do
		self._rdKey2State[key] = false

		self.updateDotsByKey(key)
	end
end

function RedDotMgr.registRedDot(rootID, dot)
	local newID = self._dotIDIdx

	self._dotMap[newID] = dot

	local dotIDs = self._rootDots[rootID] or {}

	dotIDs[newID] = true
	self._rootDots[rootID] = dotIDs
	self._dotIDIdx = self._dotIDIdx + 1

	return newID
end

function RedDotMgr.clearRedDots(rootID, destroyDot)
	local dotIDs = self._rootDots[rootID]

	if dotIDs == nil then
		return
	end

	for dotID, _ in pairs(dotIDs) do
		local dot = self._dotMap[dotID]

		if dot then
			dot:clearHint()

			if destroyDot then
				self._dotMap[dotID] = nil
			end
		end
	end

	if destroyDot then
		self._rootDots[rootID] = nil
	end
end

function RedDotMgr.addDotInfo(rdID, rdKey)
	local dotIDs = self._rdKey2Dots[rdKey] or {}

	if dotIDs[rdID] == nil then
		dotIDs[rdID] = true
		self._rdKey2Dots[rdKey] = dotIDs
	end
end

function RedDotMgr.delDotInfo(rdID, rdKey)
	local dotIDs = self._rdKey2Dots[rdKey] or {}

	if dotIDs[rdID] ~= nil then
		dotIDs[rdID] = nil
		self._rdKey2Dots[rdKey] = dotIDs
	end
end

local function _conditionUnlocked(key)
	if UIConst.RD_CONDITION_MAP[key] ~= nil then
		local isLocked = ConditionLimitManager.inLimitState(UIConst.RD_CONDITION_MAP[key])

		return not isLocked
	end

	return true
end

function RedDotMgr.getState(rdKeys)
	local oriState

	for key, _ in pairs(rdKeys) do
		oriState = false

		if self._rdKey2State[key] then
			oriState = true
		elseif self.getState(self._rdFKey2CKeys[key] or {}) then
			oriState = true
		end

		if oriState and _conditionUnlocked(key) then
			return true
		end
	end

	return false
end

function RedDotMgr.getKeyState(rdKey)
	return self.getState({
		[rdKey] = true
	}) and _conditionUnlocked(rdKey)
end

function RedDotMgr.getStateCnt(rdKeys)
	local cnt = 0

	for key, _ in pairs(rdKeys) do
		if self._rdKey2State[key] then
			cnt = cnt + 1
		end

		if self.getState(self._rdFKey2CKeys[key] or {}) then
			cnt = cnt + 1
		end
	end

	return cnt
end

function RedDotMgr.setKeyState(rdKey, state)
	self._rdKey2State[rdKey] = state

	self.updateDotsByKey(rdKey)
end

function RedDotMgr.updateDotsByKey(rdKey)
	local dotIDs = self._rdKey2Dots[rdKey] or {}

	for rdID, _ in pairs(dotIDs) do
		local dot = self._dotMap[rdID]

		if dot then
			dot:updateHintState()
		end
	end

	for key, _ in pairs(self._rdCKey2FKeys[rdKey] or {}) do
		self.updateDotsByKey(key)
	end
end

function RedDotMgr.clearOnLogin()
	for _, nHintId in pairs(UIConst.RD_HINT_MALL_ALL_HINT) do
		RedDotMgr.setKeyState(nHintId, false)
	end
end

return RedDotMgr
