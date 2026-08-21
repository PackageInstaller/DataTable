-- chunkname: @IQIGame\\Module\\CommonActivity\\Common\\CommonActivitySceneModule.lua

CommonActivitySceneModule = {
	__VirtualSceneID = 0
}

function CommonActivitySceneModule.EnterScene(virtualSceneId, onLoadSceneComplete)
	if virtualSceneId == nil or virtualSceneId == 0 then
		logError("请传入正确的virtualSceneId，参考CommonActivityVirtualSceneID类。")

		return
	end

	CommonActivitySceneModule.__VirtualSceneID = virtualSceneId
	CommonActivitySceneModule.__OnLoadSceneCompleteCallback = onLoadSceneComplete

	CommonActivitySceneModule.AddListeners()
	SceneManager.ChangeScene(SceneID.CommonActivity)
end

function CommonActivitySceneModule.SwitchScene(clearFunc, sceneId)
	if clearFunc == nil then
		logError("参数clearFunc不能为空，请传入功能模块的clear或shutdown方法。")

		return
	end

	CommonActivitySceneModule.OnExitScene()
	clearFunc()

	sceneId = sceneId or SceneID.MainCity

	SceneManager.ChangeScene(sceneId)
end

function CommonActivitySceneModule.Jump(clearFunc, jumpId, jumpParam)
	if clearFunc == nil then
		logError("参数clearFunc不能为空，请传入功能模块的clear或shutdown方法。")

		return
	end

	CommonActivitySceneModule.OnExitScene()
	clearFunc()
	JumpModule.Jump(jumpId, jumpParam)
end

function CommonActivitySceneModule.Shutdown()
	CommonActivitySceneModule.OnExitScene()
end

function CommonActivitySceneModule.OnExitScene()
	if CommonActivitySceneModule.__VirtualSceneID == 0 then
		return
	end

	CommonActivitySceneModule.RemoveListeners()

	CommonActivitySceneModule.__VirtualSceneID = 0
	CommonActivitySceneModule.__OnLoadSceneCompleteCallback = nil
end

function CommonActivitySceneModule.AddListeners()
	EventDispatcher.AddEventListener(EventID.LoadSceneSuccess, CommonActivitySceneModule.OnLoadSceneSuccess)
end

function CommonActivitySceneModule.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.LoadSceneSuccess, CommonActivitySceneModule.OnLoadSceneSuccess)
end

function CommonActivitySceneModule.OnLoadSceneSuccess(sceneID)
	if sceneID == SceneID.CommonActivity then
		CommonActivitySceneModule.CallOnLoadSceneComplete()
	end
end

function CommonActivitySceneModule.CallOnLoadSceneComplete()
	if CommonActivitySceneModule.__OnLoadSceneCompleteCallback ~= nil then
		CommonActivitySceneModule.__OnLoadSceneCompleteCallback()

		CommonActivitySceneModule.__OnLoadSceneCompleteCallback = nil
	end
end

function CommonActivitySceneModule.GetVirtualSceneId()
	return CommonActivitySceneModule.__VirtualSceneID
end

function CommonActivitySceneModule.IsInScene()
	return CommonActivitySceneModule.__VirtualSceneID ~= 0
end
