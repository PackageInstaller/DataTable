-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/FireGodView.lua

module("logic.extensions.lottery.view.paladin.FireGodView", package.seeall)

local FireGodView = class("FireGodView", LotteryModleView)

function FireGodView:ctor()
	FireGodView.super.ctor(self)

	self._curActId = 112013
	self._curDragonType = DragonController.DragonActType.FireGod
end

return FireGodView
