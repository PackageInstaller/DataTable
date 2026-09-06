-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/YanLuoView.lua

module("logic.extensions.lottery.view.paladin.YanLuoView", package.seeall)

local YanLuoView = class("YanLuoView", LotteryModleView)

function YanLuoView:ctor()
	YanLuoView.super.ctor(self)

	self._curActId = 112014
	self._curDragonType = DragonController.DragonActType.YanLuo
end

return YanLuoView
