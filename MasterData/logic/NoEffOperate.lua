-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/operate/NoEffOperate.lua

module("logic.extensions.funcopen.operate.NoEffOperate", package.seeall)

local NoEffOperate = class("NoEffOperate", OprateBase)

function NoEffOperate:ctor(operateDat)
	NoEffOperate.super.ctor(self, operateDat)
end

function NoEffOperate:doOprate()
	local _widget = self:getWidget()

	_widget.gameObject:SetActive(true)

	local trs = _widget.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)

		child.gameObject:SetActive(true)
	end
end

return NoEffOperate
