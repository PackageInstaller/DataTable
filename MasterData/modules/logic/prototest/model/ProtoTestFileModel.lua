-- chunkname: @modules/logic/prototest/model/ProtoTestFileModel.lua

module("modules.logic.prototest.model.ProtoTestFileModel", package.seeall)

local ProtoTestFileModel = class("ProtoTestFileModel", ListScrollModel)

function ProtoTestFileModel:refreshFileList()
	SLFramework.FileHelper.EnsureDir(ProtoFileHelper.DirPath)

	local filePaths = SLFramework.FileHelper.GetDirFilePaths(ProtoFileHelper.DirPath)
	local list = self:getList()

	for i = 1, filePaths.Length do
		local filePath = filePaths[i - 1]
		local fileName = SLFramework.FileHelper.GetFileName(filePath, false)
		local mo = list[i]

		if not mo then
			mo = ProtoTestFileMO.New()

			table.insert(list, mo)
		end

		mo.id = i
		mo.filePath = filePath
		mo.fileName = fileName
	end

	self:setList(list)
end

ProtoTestFileModel.instance = ProtoTestFileModel.New()

return ProtoTestFileModel
