-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKImp\\questionnaire.lua

local DeviceHelper = require("Helper/DeviceHelper")
local questionnaire = Class("questionnaire")

questionnaire.SCENE_ID = "hall_icon"
questionnaire.IN_GAME_ID = "4255_questionnaire"

function questionnaire:ctor()
	self.urlData = "https://act.sgsnssdk.com/v2/entry/list"
	self.BASE_URL = nil
end

function questionnaire:setQuestionnaireConfig()
	if CurAvatar and not Framework.Tools.LuaToolkit.IsEditor() then
		local append = {}

		append.role_id = CurAvatar.uid
		append.server_id = tostring(SvrListManager.getSelectedSvrID())
		append.did = SDKAgent.getSDKDeviceID()
		append.access_token = SDKAgent.getToken()
		append.scene_id = self.SCENE_ID
		append.app_id = 4255
		append.language = "ja_JP"
		append.platform = DeviceHelper.isAndroid() and 1 or DeviceHelper.isIOS() and 2 or 1
		self.BASE_URL = ClientUtils.composeGetUrl(self.urlData, append)

		self:getQuestionnaireURL()
	end
end

function questionnaire:getQuestionnaireURL()
	HttpHelper.get(self.BASE_URL, Slot(self.onRequestFinished, self), 3)
end

function questionnaire:onRequestFinished(responseCode, dataString)
	self.questionnaireUrl = nil

	if responseCode == 0 then
		local jsonData = ClientUtils.string2Table(dataString)

		if jsonData then
			local entryData = jsonData.data and jsonData.data.entries

			if entryData then
				for i, v in pairs(entryData) do
					if v.in_game_id == self.IN_GAME_ID then
						self.questionnaireUrl = v.url
					end
				end
			end
		end
	end

	if CurAvatar then
		CurAvatar:setSurveyUrl_JP(self.questionnaireUrl)
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_SURVEY, self.questionnaireUrl and true or false)
end

return questionnaire
