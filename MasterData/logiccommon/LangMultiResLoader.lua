-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/lang/LangMultiResLoader.lua

module("logiccommon.common.lang.LangMultiResLoader", package.seeall)

local LangMultiResLoader = class("LangMultiResLoader", MultiResLoader)

function LangMultiResLoader:ctor()
	LangMultiResLoader.super.ctor(self)

	self._langPathDict = {}
	self._loadingRes = {}
end

local MultiResLoader_setResPriority = MultiResLoader.setResPriority

function MultiResLoader:setResPriority(priority)
	if not VersionCrtl.enabledResPriority then
		return
	end

	MultiResLoader_setResPriority(self, priority)
end

function LangMultiResLoader:load(finishCallback, progressCallback, callbackObj)
	if self._resPaths == nil or #self._resPaths == 0 then
		if finishCallback then
			if callbackObj then
				finishCallback(callbackObj, self)
			else
				finishCallback(self)
			end
		end

		return
	end

	self._finishCallback = finishCallback
	self._progressCallback = progressCallback
	self._callbackObj = callbackObj
	self.totalCount = #self._resPaths

	local needPreload = false
	local resType = ResType.AssetBunble

	if self._callbackObj and self._callbackObj.viewName then
		ViewCheck.instance:recordResList(self._callbackObj.viewName, self._resPaths)
	end

	for i = 1, self.totalCount do
		local resLangPath = langpath(self._resPaths[i])

		if not self._loadingRes[resLangPath] then
			self._loadingRes[resLangPath] = true
			needPreload = self._isAllPreload and true or self._resPreloadFlags ~= nil and self._resPreloadFlags[i] or true
			resType = self._resTypeList ~= nil and self._resTypeList[i] or ResType.AssetBunble

			if needPreload == nil then
				needPreload = true
			end

			self._langPathDict[resLangPath] = self._resPaths[i]

			local hasAdd = false
			local res = rescache:GetResourceNoLoadIfNotExists(resLangPath)

			if res then
				hasAdd = true

				res:Retain()

				if self.priority and self.priority ~= 0 then
					rescache:SetPriority(res, self.priority)
				end
			end

			getres(resLangPath, LangMultiResLoader._onResLoaded, self, resType, needPreload)

			if hasAdd == false then
				local res = rescache:GetResourceNoLoadIfNotExists(resLangPath)

				if res then
					res:Retain()

					if self.priority and self.priority ~= 0 then
						rescache:SetPriority(res, self.priority)
					end
				end
			end
		end
	end
end

function LangMultiResLoader:_onResLoaded(res)
	if self._callbackObj and self._callbackObj.viewName then
		ViewCheck.instance:resLoaded(self._callbackObj.viewName)
	end

	if not self._loadingRes[res.ResPath] then
		res:Release()

		return
	end

	if self.totalCount == 0 then
		return
	end

	if res.IsSuccess then
		self.successCount = self.successCount + 1

		local resPath = self._langPathDict[res.ResPath]

		self._loadedResDict[resPath] = self._loadedResDict[resPath] or res
	end

	self._loadingRes[res.ResPath] = nil
	self.loadedCount = self.loadedCount + 1

	if self._progressCallback then
		if self._callbackObj then
			self._progressCallback(self._callbackObj, res)
		else
			self._progressCallback(res)
		end
	end

	if self.loadedCount >= self.totalCount and self._finishCallback then
		if self._callbackObj then
			self._finishCallback(self._callbackObj, self)
		else
			self:_finishCallback()
		end
	end
end

function LangMultiResLoader:getResources()
	return self._loadedResDict
end

function LangMultiResLoader:getResource(resPath)
	return self._loadedResDict[resPath]
end

function LangMultiResLoader:clear()
	if self.totalCount == 0 then
		return
	end

	for k, v in pairs(self._loadedResDict) do
		v:Release()
	end

	self._loadedResDict = {}
	self._resPaths = {}
	self._resPreloadFlags = {}
	self._isAllPreload = false
	self._loadingRes = {}
	self._callbackObj = nil
	self._finishCallback = nil
	self._progressCallback = nil
	self.loadedCount = 0
	self.totalCount = 0
	self.successCount = 0
	self._langPathDict = {}
end

return LangMultiResLoader
