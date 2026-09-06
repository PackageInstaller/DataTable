-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/picka/PickAPetInfoOfTourArena.lua

module("logic.extensions.tourarena.view.copy.picka.PickAPetInfoOfTourArena", package.seeall)

local PickAPetInfoOfTourArena = class("PickAPetInfoOfTourArena", PickAPetInfoBase)

function PickAPetInfoOfTourArena:ctor()
	PickAPetInfoOfTourArena.super.ctor(self)

	self._gameType = PickAPetModel.GameType.Default
end

function PickAPetInfoOfTourArena:onGameOverCallback(callback)
	local info = {}

	info.isPass = true
	info.gameScore = PickAPetModel.instance:getCollect()

	GameUtil.callBack(callback)
	self:doOnClose(info)
end

function PickAPetInfoOfTourArena:getViewDesc()
	return "神曜次元龙真身"
end

function PickAPetInfoOfTourArena:getIconName()
	return "icon_17010_wangzheji", "icon_14016_shenyaoguangciyuan"
end

return PickAPetInfoOfTourArena
