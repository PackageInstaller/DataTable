-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/SkyFlashView.lua

module("logic.extensions.lottery.view.paladin.SkyFlashView", package.seeall)

local SkyFlashView = class("SkyFlashView", LotteryModleView)

function SkyFlashView:ctor()
	SkyFlashView.super.ctor(self)

	self._curActId = 112010
	self._curDragonType = DragonController.DragonActType.SkyFlash
end

return SkyFlashView
