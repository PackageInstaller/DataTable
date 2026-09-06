-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexuanmingtianlong/view/DivinexuanmingtianlongdestinyView.lua

module("logic.extensions.divinexuanmingtianlong.view.DivinexuanmingtianlongdestinyView", package.seeall)

local DivinexuanmingtianlongdestinyView = class("DivinexuanmingtianlongdestinyView", FanRuiChallengeDestinyView)

function DivinexuanmingtianlongdestinyView:_onClickForecast()
	UIStateManager.instance:push(ViewName.DivinexuanmingtianlongbuffView, self._planId, self._choiceId1, self._choiceId2, self._choiceId3)
end

return DivinexuanmingtianlongdestinyView
