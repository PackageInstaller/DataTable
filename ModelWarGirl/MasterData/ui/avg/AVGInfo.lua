-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\AVG\\AVGInfo.lua

local AVGManifest = require("ClientData/AVGData/EditorData/AVGManifest")
local strClassName = "AVGInfo"
local AVGInfo = {}
local editorDataPrefix = "ClientData/AVGData/EditorData/"

function AVGInfo:_initSectionTalks()
	if self.resTalkList then
		for _, resData in pairs(self.resTalkList) do
			for id, talkData in pairs(resData) do
				local sectionInfos = self.resTalkMap[talkData.section] or {}

				if not talkData.page then
					-- block empty
				else
					sectionInfos[talkData.page] = id
					self.resTalkMap[talkData.section] = sectionInfos
				end
			end
		end
	end
end

function AVGInfo:_init()
	local excelResTalk = require("ClientData/AVGData/ExcelData/ResTalk")
	local excelResTalkBg = require("ClientData/AVGData/ExcelData/ResTalkBg")
	local excelResTalkScenery = require("ClientData/AVGData/ExcelData/ResTalkScenery")

	self.resTalkMap = {}
	self.resTalkList = {}
	self.resTalkBgList = {}
	self.resTalkSceneryList = {}

	table.insert(self.resTalkList, excelResTalk)
	table.insert(self.resTalkBgList, excelResTalkBg)
	table.insert(self.resTalkSceneryList, excelResTalkScenery)
	self:_initSectionTalks()
end

function AVGInfo:getSection(sectionId)
	if not sectionId then
		return nil
	end

	if self.resTalkMap and self.resTalkMap[sectionId] then
		return self.resTalkMap[sectionId]
	end

	return self:findResTalkSection(sectionId)
end

function AVGInfo:getResTalk(pageId)
	if not pageId then
		return nil
	end

	if self.resTalkList then
		for _, resData in pairs(self.resTalkList) do
			if resData[pageId] then
				return resData[pageId]
			end
		end
	end

	return self:findResTalk(pageId)
end

function AVGInfo:getBg(bgId)
	if not bgId then
		return nil
	end

	if self.resTalkBgList then
		for _, resData in pairs(self.resTalkBgList) do
			if resData[bgId] then
				return resData[bgId]
			end
		end
	end

	return self:findResBg(bgId)
end

function AVGInfo:getScenery(sceneryId)
	if not sceneryId then
		return nil
	end

	if self.resTalkSceneryList then
		for _, resData in pairs(self.resTalkSceneryList) do
			if resData[sceneryId] then
				return resData[sceneryId]
			end
		end
	end

	return self:findResScenery(sceneryId)
end

function AVGInfo:findResTalkSection(index)
	local fileName

	for _, value in ipairs(AVGManifest) do
		if index >= value.sectionStartId and index <= value.sectionEndId and value.resPath then
			fileName = editorDataPrefix .. value.resPath .. "/ResTalk"

			break
		end
	end

	if fileName then
		local resTalk = require(fileName)

		table.insert(self.resTalkList, resTalk)

		self.resTalkList[1], self.resTalkList[#self.resTalkList] = self.resTalkList[#self.resTalkList], self.resTalkList[1]
	end

	self:_initSectionTalks()

	return self.resTalkMap[index]
end

function AVGInfo:findResTalk(pageId)
	local sectionId = Mathf.Floor(pageId / 1000)

	self:findResTalkSection(sectionId)

	if self.resTalkList then
		for _, resData in pairs(self.resTalkList) do
			if resData[pageId] then
				return resData[pageId]
			end
		end
	end

	return nil
end

function AVGInfo:findResBg(index)
	local fileName

	for _, value in ipairs(AVGManifest) do
		if index >= value.bgStartId and index <= value.bgEndId and value.resPath then
			fileName = editorDataPrefix .. value.resPath .. "/ResTalkBg"

			break
		end
	end

	if fileName then
		local resTalkBg = require(fileName)

		table.insert(self.resTalkBgList, resTalkBg)

		self.resTalkBgList[1], self.resTalkBgList[#self.resTalkBgList] = self.resTalkBgList[#self.resTalkBgList], self.resTalkBgList[1]

		return resTalkBg[index]
	else
		return nil
	end
end

function AVGInfo:findResScenery(index)
	local fileName

	for _, value in ipairs(AVGManifest) do
		if index >= value.sceneryStartId and index <= value.sceneryEndId and value.resPath then
			fileName = editorDataPrefix .. value.resPath .. "/ResTalkScenery"

			break
		end
	end

	if fileName then
		local resTalkScenery = require(fileName)

		table.insert(self.resTalkSceneryList, resTalkScenery)

		self.resTalkSceneryList[1], self.resTalkSceneryList[#self.resTalkSceneryList] = self.resTalkSceneryList[#self.resTalkSceneryList], self.resTalkSceneryList[1]

		return resTalkScenery[index]
	else
		return nil
	end
end

function AVGInfo:getRawAVGData(resName)
	local ExcelData = require("ClientData/AVGData/ExcelData/" .. resName)
	local EditorData = {}

	for index, value in ipairs(AVGManifest) do
		local res = require("ClientData/AVGData/EditorData/" .. value.resPath .. "/" .. resName)

		for k, v in pairs(res) do
			EditorData[k] = res[k]
		end
	end

	return EditorData, ExcelData
end

AVGInfo:_init()

return AVGInfo
