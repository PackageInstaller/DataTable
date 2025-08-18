-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\AutoTest\\AutoTestModule.lua

local AutoTestModule = {}

if not IsGLDeclared("AutoTestModule") or not AutoTestModule then
	GLDeclare("AutoTestModule", AutoTestModule)
end

local AutoRecordClick = AutoRecordClick

function AutoTestModule.init()
	require("Debug/AutoTest/TButtonClick")

	AutoRecordClick.isInit = true

	Framework.Tools.LuaToolkit.LogEx("lua AutoTestModule.init")
end

function AutoTestModule.setShortId()
	if CurAvatar and CurAvatar.shortUid then
		AutoRecordClick.setSuid(CurAvatar.shortUid)
		AutoRecordClick.setServerid(SvrListManager.getSelectedSvrID())
	end
end

return AutoTestModule
