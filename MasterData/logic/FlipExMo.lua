-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/FlipExMo.lua

module("logic.extensions.dreamteam.view.FlipExMo", package.seeall)

local FlipExMo = class("FlipExMo")

function FlipExMo:ctor()
	self._openGameOverCallBack = nil
end

function FlipExMo:deepcopy()
	return TableUtil.deepcopy(self)
end

function FlipExMo:openGameOverOfFlipExMo(info)
	if self._openGameOverCallBack then
		GameUtil.callBack(self._openGameOverCallBack, info)
	else
		self:_defaultOpenGameOverOfFlipExMo(info)
	end
end

function FlipExMo:setOpenGameOverOfFlipExMo(callBack)
	self._openGameOverCallBack = callBack
end

function FlipExMo:_defaultOpenGameOverOfFlipExMo(info)
	FlipGameController.instance:openGameOver()
end

return FlipExMo
