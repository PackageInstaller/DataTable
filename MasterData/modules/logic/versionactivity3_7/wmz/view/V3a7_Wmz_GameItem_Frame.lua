-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Frame.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Frame", package.seeall)

local V3a7_Wmz_GameItem_Frame = class("V3a7_Wmz_GameItem_Frame", V3a7_Wmz_GameItemMiscBase)

function V3a7_Wmz_GameItem_Frame:onInitView()
	self._simagekuang = gohelper.findChildSingleImage(self.viewGO, "#simage_kuang")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameItem_Frame:addEvents()
	return
end

function V3a7_Wmz_GameItem_Frame:removeEvents()
	return
end

function V3a7_Wmz_GameItem_Frame:ctor(...)
	V3a7_Wmz_GameItem_Frame.super.ctor(self, ...)
end

function V3a7_Wmz_GameItem_Frame:_editableInitView()
	V3a7_Wmz_GameItem_Frame.super._editableInitView(self)

	self._simagekuangImg = gohelper.findChildImage(self._simagekuang.gameObject, "")
end

function V3a7_Wmz_GameItem_Frame:onDestroyView()
	V3a7_Wmz_GameItem_Frame.super.onDestroyView(self)
end

function V3a7_Wmz_GameItem_Frame:setData(mo)
	V3a7_Wmz_GameItem_Frame.super.setData(self, mo)

	local frameBgResName = self._mo.frameBgResName

	if string.nilorempty(frameBgResName) then
		gohelper.setActive(self._simagekuangImg, false)
	else
		self._simagekuang:LoadImage(ResUrl.getV3a7WmzSingleBg(frameBgResName), function()
			gohelper.setActive(self._simagekuangImg, true)
			self._simagekuangImg:SetNativeSize()
		end)
	end

	local posX = tonumber(self._mo.frameFocusX) or -19999
	local posY = tonumber(self._mo.frameFocusY) or -19999

	self:setAPos(posX, posY)

	if isDebugBuild then
		self:setName(string.format("%s: %s (%s)", self:index(), self:zoneId(), self._mo.frameBgResName))
	end
end

function V3a7_Wmz_GameItem_Frame:zoneId()
	return self._mo.id
end

function V3a7_Wmz_GameItem_Frame:setGrayScale(bSelected)
	if bSelected then
		if self:bZoneCompleted() then
			UIColorHelper.set(self._simagekuangImg, WmzConfig.instance:selectedCompletedFrameGrayScaleHex())
		else
			self._simagekuangImg.color = Color.white
		end
	else
		UIColorHelper.set(self._simagekuangImg, WmzConfig.instance:grayScaleHex())
	end
end

return V3a7_Wmz_GameItem_Frame
