-- chunkname: @modules/logic/ressplit/work/save/ResSplitSaveExportWork.lua

module("modules.logic.ressplit.work.save.ResSplitSaveExportWork", package.seeall)

local ResSplitSaveExportWork = class("ResSplitSaveExportWork", BaseWork)

function ResSplitSaveExportWork:onStart(context)
	self.result = {}

	self:_filter(ResSplitEnum.Path)
	self:_filter(ResSplitEnum.Folder)
	self:_filter(ResSplitEnum.SinglebgFolder)
	self:_filter(ResSplitEnum.AudioBank)
	self:_filter(ResSplitEnum.CommonAudioBank)
	self:_filter(ResSplitEnum.Video)
	self:_filter(ResSplitEnum.AudioWem)
	self:_filter(ResSplitEnum.InnerAudioWem)
	self:_filter(ResSplitEnum.InnerSceneAB)

	local resultJson = cjson.encode(self.result)

	resultJson = string.gsub(resultJson, "\\/", "/")

	local file = io.open(ResSplitEnum.ExportSaveConfigPath, "w")

	file:write(tostring(resultJson))
	file:close()
	self:onDone(true)
	logNormal("ResSplit Done!")
end

function ResSplitSaveExportWork:_filter(type)
	local dic = {}
	local excludeDic = ResSplitModel.instance:getIncludeDic(type)

	if excludeDic then
		for i, v in pairs(excludeDic) do
			if v == true then
				local fileName = SLFramework.FileHelper.GetFileName(i, true)
				local index = string.find(fileName, "%.")

				if i == "" or not index or index > 1 then
					dic[i] = true
				end
			end
		end

		self.result[type] = dic
	end

	logNormal(type, tabletool.len(dic))
end

return ResSplitSaveExportWork
