-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/MiZongView.lua

module("logic.extensions.lottery.view.paladin.MiZongView", package.seeall)

local MiZongView = class("MiZongView", LotteryModleView)

function MiZongView:ctor()
	MiZongView.super.ctor(self)

	self._curActId = 112012
	self._curDragonType = DragonController.DragonActType.MiZong
end

return MiZongView
