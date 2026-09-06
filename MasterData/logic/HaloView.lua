-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/HaloView.lua

module("logic.extensions.lottery.view.paladin.HaloView", package.seeall)

local HaloView = class("HaloView", LotteryModleView)

function HaloView:ctor()
	HaloView.super.ctor(self)

	self._curActId = 112011
	self._curDragonType = DragonController.DragonActType.Halo
end

return HaloView
