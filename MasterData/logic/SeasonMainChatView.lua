-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/mainhud/SeasonMainChatView.lua

module("logic.extensions.season.view.mainhud.SeasonMainChatView", package.seeall)

local SeasonMainChatView = class("SeasonMainChatView", MainChatView)

function SeasonMainChatView:onEnter()
	SeasonMainChatView.super.onEnter(self)

	if checknumber(SeasonModel.instance:getTeammateId()) > 0 then
		GameUtil.SetActive(self._Nego_Chat, true)
	else
		GameUtil.SetActive(self._Nego_Chat, false)
	end
end

return SeasonMainChatView
