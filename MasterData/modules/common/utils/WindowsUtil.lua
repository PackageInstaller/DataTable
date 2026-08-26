-- chunkname: @modules/common/utils/WindowsUtil.lua

module("modules.common.utils.WindowsUtil", package.seeall)

local WindowsUtil = {}

function WindowsUtil.getSelectFileContent(title, ext)
	require("tolua.reflection")
	tolua.loadassembly("UnityEditor")

	local arr = System.Array.CreateInstance(typeof("System.Type"), 3)

	arr[0] = typeof(System.String)
	arr[1] = typeof(System.String)
	arr[2] = typeof(System.String)

	local func = tolua.gettypemethod(typeof("UnityEditor.EditorUtility"), "OpenFilePanel", arr)
	local defaultFolder = SLFramework.FrameworkSettings.PersistentResRootDir

	SLFramework.FileHelper.EnsureDir(defaultFolder)

	local path = func:Call(title, defaultFolder, ext)
	local content

	if not string.nilorempty(path) then
		content = SLFramework.FileHelper.ReadText(path)
	end

	func:Destroy()

	return content
end

function WindowsUtil.saveContentToFile(title, content, defaultName, ext)
	require("tolua.reflection")
	tolua.loadassembly("UnityEditor")

	local arr = System.Array.CreateInstance(typeof("System.Type"), 4)

	arr[0] = typeof(System.String)
	arr[1] = typeof(System.String)
	arr[2] = typeof(System.String)
	arr[3] = typeof(System.String)

	local func = tolua.gettypemethod(typeof("UnityEditor.EditorUtility"), "SaveFilePanel", arr)
	local defaultFolder = SLFramework.FrameworkSettings.PersistentResRootDir

	SLFramework.FileHelper.EnsureDir(defaultFolder)

	local path = func:Call(title, defaultFolder, defaultName, ext)

	if not string.nilorempty(path) then
		SLFramework.FileHelper.WriteTextToPath(path, content)
	end

	func:Destroy()
end

return WindowsUtil
