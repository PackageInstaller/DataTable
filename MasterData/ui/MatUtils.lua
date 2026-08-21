-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MatUtils.lua

local Shader = UnityEngine.Shader
local LoaderFactory = Framework.Resource.LoaderFactory
local LoaderMode = Framework.Resource.LoaderMode
local VersionUtils = require("System/VersionUtils")
local MatUtils = {}

MatUtils.cachedMat = {}

local _beginTimeID = Shader.PropertyToID("_recordBeginTime")

function MatUtils.startTimeRecord(matName)
	MatUtils.setKeywordFloat(matName, _beginTimeID, UnityEngine.Time.timeSinceLevelLoad)
end

function MatUtils.resetTimeRecord(matName)
	MatUtils.setKeywordFloat(matName, _beginTimeID, 0)
end

function MatUtils.loadMaterialAsync(matName, callback)
	local loader = LoaderFactory.LoadFile(matName, LoaderMode.Async, callback)
	local isComplete = loader.IsCompleted

	if isComplete and callback then
		callback(true, loader)
	end
end

function MatUtils.setKeywordFloat(matName, keyword, value)
	if VersionUtils.hasMaterialAndCamSupport() then
		local mat = MatUtils.cachedMat[matName]

		if not mat then
			MatUtils.loadMaterialAsync(matName, Functor(MatUtils.onMaterialLoadCallback, matName, keyword, value))
		else
			mat:SetFloat(keyword, value)
		end
	end
end

function MatUtils.onMaterialLoadCallback(matName, keyword, value, state, loader)
	if VersionUtils.hasMaterialAndCamSupport() and state then
		local mat = loader.AsyncResult

		if mat then
			MatUtils.cachedMat[matName] = mat

			mat:SetFloat(keyword, value)
		end
	elseif not state then
		-- block empty
	end
end

return MatUtils
