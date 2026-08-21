-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/util/AuthorityResMgr.lua

module("logic.extensions.charactersystem.util.AuthorityResMgr", package.seeall)

local M = class("AuthorityResMgr")

function M:ctor()
	self._resLoader = MultiResLoader.New()
	self._instList = {}
	self._resPath = nil
	self._prefab = nil
	self._frameCount = 0
	self._totalCount = 0
end

function M:setResPaths(resPaths, resPreloadFlags, resTypeList)
	self._resLoader:setResPaths(resPaths, resPreloadFlags, resTypeList)
end

function M:preload()
	self._resLoader:load(self._onAllResLoaded, nil, self)
end

function M:_onAllResLoaded()
	if self._resPath and self._instList and #self._instList <= 0 then
		self:instantiate(self._resPath, self._totalCount, self._isFrame, self._frameCount)
	end
end

function M:instantiate(resPath, count, isFrame, frameCount)
	self._resPath = resPath
	self._instList = {}

	local res = self._resLoader:getResource(resPath)

	if not res then
		return
	end

	self._prefab = res:GetMainAsset()
	self._totalCount = count or 1
	self._isFrame = isFrame

	if self._isFrame then
		self._frameCount = frameCount or 1

		self:_onFrame()
		settimer(0, self._onFrame, self, true)
	else
		for i = 1, count do
			table.insert(self._instList, goutil.clone(self._prefab))
		end
	end
end

function M:_onFrame()
	if not self._prefab or self._frameCount <= 0 then
		return
	end

	if #self._instList >= self._totalCount then
		removetimer(self._onFrame, self)

		return
	end

	for i = 1, self._frameCount do
		table.insert(self._instList, goutil.clone(self._prefab))
	end
end

function M:getResInstances(isStopFrame)
	if isStopFrame == nil or isStopFrame == true then
		removetimer(self._onFrame, self)
	end

	return self._instList
end

function M:getResInstance(resPath)
	local res = self._resLoader:getResource(resPath)

	if res then
		return goutil.clone(res:GetMainAsset())
	end

	return nil
end

function M:clear()
	if self._resLoader then
		self._resLoader:clear()
	end

	if self._instList and #self._instList > 0 then
		for i = 1, #self._instList do
			goutil.destroy(self._instList[i])
		end
	end

	self._instList = nil
	self._prefab = nil
	self._frameCount = 0
	self._totalCount = 0
end

M.instance = M.New()

return M
