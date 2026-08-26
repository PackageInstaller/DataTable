-- chunkname: @modules/logic/ressplit/model/VersionResSplitData.lua

module("modules.logic.ressplit.model.VersionResSplitData", package.seeall)

local VersionResSplitData = class("VersionResSplitData")

function VersionResSplitData:init(versionResSplitId)
	self._id = versionResSplitId
	self._allResDict = {}
	self._resType2PathsDict = {}
end

function VersionResSplitData:addResSplitInfo(splitType, resType, path)
	if not path then
		return
	end

	self._allResDict[splitType] = self._allResDict[splitType] or {}
	self._resType2PathsDict[resType] = self._resType2PathsDict[resType] or {}

	if not self._allResDict[splitType][path] then
		self._resType2PathsDict[resType][path] = true
		self._allResDict[splitType][path] = true
	end
end

function VersionResSplitData:checkResSplitInfo(splitType, path)
	return self._allResDict[splitType] and self._allResDict[splitType][path]
end

function VersionResSplitData:checkResTypeSplitInfo(resType, path)
	return self._resType2PathsDict[resType] and self._resType2PathsDict[resType][path]
end

function VersionResSplitData:deleteResSplitInfo(splitType, resType, path)
	if splitType and self._allResDict[splitType] and self._allResDict[splitType][path] then
		self._allResDict[splitType][path] = false
	end

	if resType and self._resType2PathsDict[resType] and self._resType2PathsDict[resType][path] then
		self._resType2PathsDict[resType][path] = false
	end
end

function VersionResSplitData:getAllResDict()
	return self._allResDict
end

function VersionResSplitData:getAllResTypeDict()
	return self._resType2PathsDict
end

function VersionResSplitData:getResSplitMap()
	local splitMap = {}

	for splitType, splitTypeDict in pairs(self._allResDict) do
		splitMap[splitType] = splitMap[splitType] or {}

		for path, value in pairs(splitTypeDict) do
			if value then
				local splitTypeList = splitMap[splitType]

				splitTypeList[#splitTypeList + 1] = path
			end
		end
	end

	return splitMap
end

function VersionResSplitData:getResTypeSplitMap()
	local resType2PathsDict = {}

	for resType, resPathDict in pairs(self._resType2PathsDict) do
		resType2PathsDict[resType] = resType2PathsDict[resType] or {}

		for path, value in pairs(resPathDict) do
			if value then
				local resPathList = resType2PathsDict[resType]

				resPathList[#resPathList + 1] = path
			end
		end
	end

	return resType2PathsDict
end

VersionResSplitData.instance = VersionResSplitData.New()

return VersionResSplitData
