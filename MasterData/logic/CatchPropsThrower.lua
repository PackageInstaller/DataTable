-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsThrower.lua

module("logic.extensions.catchprops.view.CatchPropsThrower", package.seeall)

local CatchPropsThrower = class("CatchPropsThrower", CatchPropsAnimCtrl)

function CatchPropsThrower:onEnter()
	CatchPropsThrower.super.onEnter(self)
end

function CatchPropsThrower:onExit()
	CatchPropsThrower.super.onExit(self)
end

function CatchPropsThrower:startGame()
	self:playAnim("reng_yuebing", true, true)
end

function CatchPropsThrower:stopGame()
	self:playAnim("idle_yuebing", true, true)
end

return CatchPropsThrower
