-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Start.lua

local sf = string.format

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Start", package.seeall)

local V3a7_Wmz_GameItem_Start = class("V3a7_Wmz_GameItem_Start", V3a7_Wmz_GameItem_Cell)

function V3a7_Wmz_GameItem_Start:ctor(...)
	V3a7_Wmz_GameItem_Start.super.ctor(self, ...)
end

function V3a7_Wmz_GameItem_Start:_editableInitView()
	V3a7_Wmz_GameItem_Start.super._editableInitView(self)
end

function V3a7_Wmz_GameItem_Start:onDestroyView()
	V3a7_Wmz_GameItem_Start.super.onDestroyView(self)
end

function V3a7_Wmz_GameItem_Start:setData(mo)
	V3a7_Wmz_GameItem_Start.super.setData(self, mo)

	local ePathType = self:pathType()
	local pathInfo = WmzEnum.PathInfo[ePathType]

	self:setActive_goLineStart(true)
	self:setActive_goLine()
	self:localRotateZ(pathInfo.zRot, self._goLineStartTran)
	self:_debug_refresh()
end

function V3a7_Wmz_GameItem_Start:setActive_goLine()
	self._line0:setActive(false)
	self._line1:setActive(false)
end

function V3a7_Wmz_GameItem_Start:getTileItem()
	return nil
end

function V3a7_Wmz_GameItem_Start:_refreshBorder()
	self._border:setActive(false)
end

function V3a7_Wmz_GameItem_Start:_debug_refresh()
	if not WmzEnum.rDir then
		return
	end

	local floorType = self:floorType()

	self:setName(sf("(%s,%s): %s -- START --", self:x(), self:y(), WmzEnum.nameOfFT(floorType)))
end

return V3a7_Wmz_GameItem_Start
