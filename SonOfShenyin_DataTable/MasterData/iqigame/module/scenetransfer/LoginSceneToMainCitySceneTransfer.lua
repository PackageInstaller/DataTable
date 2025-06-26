-- chunkname: @IQIGame\\Module\\SceneTransfer\\LoginSceneToMainCitySceneTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__LoadScene()
	function self.__delegateLoadSceneCallback(sender, event)
		self:__OnLoadSceneCallback(sender, event)
	end

	GameEntry.LuaEvent:Subscribe(LoadSceneExtResEndEventArgs.EventId, self.__delegateLoadSceneCallback)
	GameEntry.LuaEvent:FireNow(nil, ChangeSceneEventArgs():Fill(SceneID.MainCity))
end

function Transfer:__OnLoadSceneCallback(sender, event)
	if event.SceneID ~= SceneID.MainCity then
		return
	end

	GameEntry.LuaEvent:Unsubscribe(LoadSceneExtResEndEventArgs.EventId, self.__delegateLoadSceneCallback)
	UIModule.Open(Constant.UIControllerName.GlobalNoticeUI, Constant.UILayer.AboveAll)
	self:__DoPlayerLogin()
end

function Transfer:__DoPlayerLogin()
	PlayerModule.CurrSceneID = SceneID.MainCity

	if GameObject.Find("UIDText_New") ~= nil then
		local str = "UID:" .. PlayerModule.PlayerInfo.baseInfo.guid
		local gameObject = GameObject.Find("UIDText_New").gameObject

		gameObject:GetComponent("Text").text = str
	end

	self:__ChangeState(self.State.Exit)
end

function Transfer:__Exit()
	self:__RevertUISystemSettingValue()

	if self.completeCall == nil then
		return
	end

	self.completeCall(self.completeCallArgs)
end

return Transfer
