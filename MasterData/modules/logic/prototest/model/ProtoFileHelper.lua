-- chunkname: @modules/logic/prototest/model/ProtoFileHelper.lua

module("modules.logic.prototest.model.ProtoFileHelper", package.seeall)

local ProtoFileHelper = _M

ProtoFileHelper.DirPath = SLFramework.FrameworkSettings.StreamingAssetsPath .. "/prototest/"

function ProtoFileHelper.getFullPathByFileName(fileName)
	return ProtoFileHelper.DirPath .. fileName .. ".json"
end

return ProtoFileHelper
