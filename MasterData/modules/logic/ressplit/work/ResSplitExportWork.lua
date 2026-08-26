-- chunkname: @modules/logic/ressplit/work/ResSplitExportWork.lua

module("modules.logic.ressplit.work.ResSplitExportWork", package.seeall)

local ResSplitExportWork = class("ResSplitExportWork", BaseWork)

function ResSplitExportWork:onStart(context)
	self.result = {}

	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "atlassrc/ui_modules/explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "ui/viewres/explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "singlebg/explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "atlassrc/ui_spriteset/explore/", true)
	self:_filter(ResSplitEnum.Path)
	self:_filter(ResSplitEnum.Folder)
	self:_filter(ResSplitEnum.SinglebgFolder)
	self:_filter(ResSplitEnum.AudioBank)
	self:_filter(ResSplitEnum.CommonAudioBank)
	self:_filter(ResSplitEnum.Video)
	self:_filter(ResSplitEnum.AudioWem)
	self:_filter(ResSplitEnum.InnerAudioWem)
	self:_filter(ResSplitEnum.InnerRoomAB)
	self:_filter(ResSplitEnum.OutRoomAB)
	self:_filter(ResSplitEnum.OutSceneAB)
	self:_filter(ResSplitEnum.InnerSceneAB)

	local resultJson = cjson.encode(self.result)

	resultJson = string.gsub(resultJson, "\\/", "/")

	local file = io.open(ResSplitEnum.ExportConfigPath, "w")

	file:write(tostring(resultJson))
	file:close()
	self:onDone(true)
	logNormal("ResSplit Done!")
end

function ResSplitExportWork:_filter(type)
	local dic = {}
	local excludeDic = ResSplitModel.instance:getExcludeDic(type)

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

return ResSplitExportWork
