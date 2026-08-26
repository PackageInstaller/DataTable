-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/comp/MaLiAnNaLineGameComp.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.comp.MaLiAnNaLineGameComp", package.seeall)

local MaLiAnNaLineGameComp = class("MaLiAnNaLineGameComp", MaLiAnNaLineBaseComp)

function MaLiAnNaLineGameComp:init(go)
	MaLiAnNaLineGameComp.super.init(self, go)

	self._goRailWay = gohelper.findChild(go, "RailWay")
	self._goHighWay = gohelper.findChild(go, "HighWay")
end

function MaLiAnNaLineGameComp:updateInfo(data)
	if data == nil then
		return
	end

	self._data = data

	local beginX, beginY = data:getBeginPos()
	local endX, endY = data:getEndPos()

	beginX, beginY, endX, endY = MathUtil.calculateVisiblePoints(beginX, beginY, Activity201MaLiAnNaEnum.defaultHideLineRange, endX, endY, Activity201MaLiAnNaEnum.defaultHideLineRange)

	gohelper.setActive(self._goRailWay, self._data._roadType == Activity201MaLiAnNaEnum.RoadType.RailWay)
	gohelper.setActive(self._goHighWay, self._data._roadType == Activity201MaLiAnNaEnum.RoadType.HighWay)
	self:updateItem(beginX, beginY, endX, endY)
end

function MaLiAnNaLineGameComp:updateItem(beginX, beginY, endX, endY)
	transformhelper.setLocalPosXY(self._tr, beginX, beginY)

	local width = MathUtil.vec2_length(beginX, beginY, endX, endY)

	recthelper.setHeight(self._tr, width)

	local angle = MathUtil.calculateV2Angle(endX, endY, beginX, beginY)

	transformhelper.setEulerAngles(self._tr, 0, 0, angle - 90)
end

return MaLiAnNaLineGameComp
