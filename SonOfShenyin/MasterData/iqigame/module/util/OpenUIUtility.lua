-- chunkname: @IQIGame\\Module\\Util\\OpenUIUtility.lua

OpenUIUtility = {
	callbackList = {}
}

function OpenUIUtility.Init()
	GameEntry.LuaEvent:Subscribe(OpenUIFormSuccessEventArgs.EventId, OpenUIUtility.OnOpenUI)

	OpenUIUtility.isInited = true
end

function OpenUIUtility.OpenUI(uiName, layer, callback, userData)
	OpenUIUtility.callbackList[uiName] = callback

	if uiName == Constant.UIControllerName.ChallengeWorldBossUI then
		ChallengeWorldBossModule.OpenChallengeWorldBossUI()
	elseif uiName == Constant.UIControllerName.ChallengeWorldBossRankUI then
		ChallengeWorldBossModule.OpenChallengeWorldBossRankUI()
	else
		UIModule.Open(uiName, layer, userData)
	end
end

function OpenUIUtility.OnOpenUI(sender, args)
	local uiName = string.gsub(args.UIForm.Logic.Name, "%(Clone%)", "")
	local callback = OpenUIUtility.callbackList[uiName]

	if callback then
		callback(uiName)

		OpenUIUtility.callbackList[uiName] = nil
	end
end

function OpenUIUtility.Dispose()
	GameEntry.LuaEvent:Unsubscribe(OpenUIFormSuccessEventArgs.EventId, OpenUIUtility.OnOpenUI)
end
