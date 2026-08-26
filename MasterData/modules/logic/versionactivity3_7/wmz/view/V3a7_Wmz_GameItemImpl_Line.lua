-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItemImpl_Line.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItemImpl_Line", package.seeall)

local V3a7_Wmz_GameItemImpl_Line = class("V3a7_Wmz_GameItemImpl_Line", RougeSimpleItemBase)

function V3a7_Wmz_GameItemImpl_Line:onInitView()
	self._goLine01 = gohelper.findChild(self.viewGO, "#go_Line_0_1")
	self._goLine02 = gohelper.findChild(self.viewGO, "#go_Line_0_2")
	self._goLine03 = gohelper.findChild(self.viewGO, "#go_Line_0_3")
	self._goLine04 = gohelper.findChild(self.viewGO, "#go_Line_0_4")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameItemImpl_Line:addEvents()
	return
end

function V3a7_Wmz_GameItemImpl_Line:removeEvents()
	return
end

function V3a7_Wmz_GameItemImpl_Line:onDestroyView()
	V3a7_Wmz_GameItemImpl_Line.super.onDestroyView(self)
end

function V3a7_Wmz_GameItemImpl_Line:ctor(...)
	V3a7_Wmz_GameItemImpl_Line.super.ctor(self, ...)
end

function V3a7_Wmz_GameItemImpl_Line:_editableInitView()
	V3a7_Wmz_GameItemImpl_Line.super._editableInitView(self)

	self._imgLine01 = gohelper.findChildImage(self._goLine01, "")
	self._imgLine02 = gohelper.findChildImage(self._goLine02, "")
	self._imgLine03 = gohelper.findChildImage(self._goLine03, "")
	self._imgLine04 = gohelper.findChildImage(self._goLine04, "")
end

function V3a7_Wmz_GameItemImpl_Line:setData(mo)
	V3a7_Wmz_GameItemImpl_Line.super.setData(self, mo)

	local ePathType = mo
	local info = WmzEnum.PathInfo[ePathType]
	local zRot = info.zRot
	local spriteId = info.spriteId

	gohelper.setActive(self._goLine01, false)
	gohelper.setActive(self._goLine02, false)
	gohelper.setActive(self._goLine03, false)
	gohelper.setActive(self._goLine04, false)

	if spriteId == WmzEnum.PathSpriteId.Exit2_Straight then
		gohelper.setActive(self._goLine01, true)
	elseif spriteId == WmzEnum.PathSpriteId.Exit2_Angle then
		gohelper.setActive(self._goLine02, true)
	elseif spriteId == WmzEnum.PathSpriteId.Exit3 then
		gohelper.setActive(self._goLine03, true)
	elseif spriteId == WmzEnum.PathSpriteId.Exit4 then
		gohelper.setActive(self._goLine04, true)
	end

	self:localRotateZ(zRot)
end

local kWhite = Color.white

function V3a7_Wmz_GameItemImpl_Line:setGrayScale(bSelected)
	if bSelected then
		self._imgLine01.color = kWhite
		self._imgLine02.color = kWhite
		self._imgLine03.color = kWhite
		self._imgLine04.color = kWhite
	else
		local hexColor = WmzConfig.instance:grayScaleHex()

		UIColorHelper.set(self._imgLine01, hexColor)
		UIColorHelper.set(self._imgLine02, hexColor)
		UIColorHelper.set(self._imgLine03, hexColor)
		UIColorHelper.set(self._imgLine04, hexColor)
	end
end

return V3a7_Wmz_GameItemImpl_Line
