-- chunkname: @modules/logic/character/view/CharacterSpName.lua

module("modules.logic.character.view.CharacterSpName", package.seeall)

local CharacterSpName = class("CharacterSpName", CharacterDecoratorBase)

function CharacterSpName:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSpName:addEvents()
	return
end

function CharacterSpName:removeEvents()
	return
end

function CharacterSpName.s_create(Self, srcGo, baseViewContainer)
	local item = CharacterSpName.New({
		parent = Self,
		baseViewContainer = baseViewContainer
	})

	item:init(srcGo)

	return item
end

function CharacterSpName.s_createByView(Self, srcGo)
	return (CharacterSpName.s_create(Self, srcGo, Self.viewContainer))
end

function CharacterSpName.s_createByListScrollCellExtend(Self, srcGo)
	local scrollView = Self._view

	if scrollView then
		return (CharacterSpName:s_create(srcGo, scrollView.viewContainer or Self.viewContainer))
	end
end

function CharacterSpName:ctor(...)
	CharacterSpName.super.ctor(self, ...)
end

function CharacterSpName:onDestroyView()
	CharacterSpName.super.onDestroyView(self)
end

function CharacterSpName:_editableInitView()
	CharacterSpName.super._editableInitView(self)

	self._txt1 = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txt1en = gohelper.findChildText(self.viewGO, "#txt_nameen")
	self._txtSp = gohelper.findChildText(self.viewGO, "#txt_sp")
end

function CharacterSpName:bindName0(txt)
	self._txt0 = txt

	return self
end

function CharacterSpName:bindName0En(txtEn)
	self._txt0en = txtEn

	return self
end

function CharacterSpName:bindName1(txt)
	self._txt1 = txt

	return self
end

function CharacterSpName:bindName1En(txtEn)
	self._txt1en = txtEn

	return self
end

function CharacterSpName:bindSpName(txtSp)
	self._txtSp = txtSp

	return self
end

function CharacterSpName:simpleBindSpNameWithBg()
	self._txtSp = gohelper.findChildText(self.viewGO, "bg/#txt_sp")

	return self
end

function CharacterSpName:setActiveName0(bActive)
	gohelper.setActive(self._txt0, bActive)
	gohelper.setActive(self._txt0en, bActive)
end

function CharacterSpName:setActiveName1(bActive)
	gohelper.setActive(self._txt1, bActive)
	gohelper.setActive(self._txt1en, bActive)
end

function CharacterSpName:setActiveNameOnly(bActive)
	if not bActive then
		self:setActiveName0(false)
		self:setActiveName1(false)
	else
		local bML = self:_bML()

		self:setActiveName0(not bML)
		self:setActiveName1(bML)
	end
end

function CharacterSpName:getOriCnAndEn()
	local name, nameEng, oriName, oriNameEng = self:_getName4()

	return oriName, oriNameEng
end

function CharacterSpName:setData(mo)
	CharacterSpName.super.setData(self, mo)

	self._heroCO = self:_getHeroCO()

	return self
end

function CharacterSpName:_bML()
	return not self:bEmptySpName()
end

function CharacterSpName:setSpName(optStr)
	self:_setSpName(optStr or self:spName())
end

function CharacterSpName:simpleAutoSet()
	local bML = self:_bML()

	if bML then
		self:_simpleSetAsML()
	else
		self:_simpleSetAsSL()
	end

	return self
end

function CharacterSpName:_simpleSetAsML()
	self:setAsML()

	return self
end

function CharacterSpName:_simpleSetAsSL()
	self:setAsSL()

	return self
end

function CharacterSpName:_calcNameAndEnStr(optStr, optEnStr)
	if not optStr or not optEnStr then
		local bML = self:_bML()
		local tmpStr, tmpEnStr
		local name, nameEng, oriName, oriNameEng = self:_getName4()

		if bML then
			tmpEnStr = nameEng
			tmpStr = oriName
		else
			tmpEnStr = nameEng
			tmpStr = name
		end

		optStr = optStr or tmpStr
		optEnStr = optEnStr or tmpEnStr
	end

	return optStr, optEnStr
end

function CharacterSpName:setAsML(optStr, optEnStr)
	self:_setActiveCompatible(true)

	local str, enStr = self:_calcNameAndEnStr(optStr, optEnStr)

	self:_setName1(str, enStr)
	self:setSpName()

	return self
end

function CharacterSpName:setAsSL(optStr, optEnStr)
	self:_setActiveCompatible(false)

	local str, enStr = self:_calcNameAndEnStr(optStr, optEnStr)

	self:_setName0(str, enStr)

	return self
end

function CharacterSpName:setAsML_SpAndName0(optStr, optEnStr)
	local bML = self:_bML()
	local str, enStr = self:_calcNameAndEnStr(optStr, optEnStr)

	if bML then
		self:setSpName()
	end

	self:_setName0(str, enStr)
	self:setActiveName0(true)
	self:setActive(bML)
end

function CharacterSpName:_setActiveCompatible(bSp)
	self:setActive(bSp)
	self:setActiveName0(not bSp)
end

function CharacterSpName:_setName0(str, enStr)
	if self._txt0 then
		self._txt0.text = str or ""
	end

	if self._txt0en then
		self._txt0en.text = enStr or ""
	end
end

function CharacterSpName:_setName1(str, enStr)
	if self._txt1 then
		self._txt1.text = str or ""
	end

	if self._txt1en then
		self._txt1en.text = enStr or ""
	end
end

function CharacterSpName:_setSpName(str)
	if self._txtSp then
		self._txtSp.text = str or ""
	end
end

function CharacterSpName:setScaleName0(sx, sy, sz)
	if self._txt0 then
		self:setScaleXYZ(sx, sy, sz, self._txt0.transform)
	end

	if self._txt0en then
		self:setScaleXYZ(sx, sy, sz, self._txt0en.transform)
	end
end

function CharacterSpName:setScaleName1(sx, sy, sz)
	if self._txt1 then
		self:setScaleXYZ(sx, sy, sz, self._txt1.transform)
	end

	if self._txt1en then
		self:setScaleXYZ(sx, sy, sz, self._txt1en.transform)
	end
end

function CharacterSpName:setScaleSpName(sx, sy, sz)
	if self._txtSp then
		self:setScaleXYZ(sx, sy, sz, self._txtSp.transform)
	end
end

function CharacterSpName:setPosName0(optX, optY, optEnX, optEnY)
	if self._txt0 and (optX or optY) then
		self:setAPos(optX, optY, self._txt0.transform)
	end

	if self._txt0en and (optEnX or optEnY) then
		self:setAPos(optEnX, optEnY, self._txt0en.transform)
	end
end

function CharacterSpName:setPosName1(optX, optY, optEnX, optEnY)
	if self._txt1 and (optX or optY) then
		self:setAPos(optX, optY, self._txt1.transform)
	end

	if self._txt1en and (optEnX or optEnY) then
		self:setAPos(optEnX, optEnY, self._txt1en.transform)
	end
end

function CharacterSpName:setWName0(optW, optEnW)
	if self._txt0 and optW then
		self:setW(optW, self._txt0.transform)
	end

	if self._txt0en and optEnW then
		self:setW(optEnW, self._txt0en.transform)
	end
end

function CharacterSpName:setWName1(optW, optEnW)
	if self._txt1 and optW then
		self:setW(optW, self._txt1.transform)
	end

	if self._txt1en and optEnW then
		self:setW(optEnW, self._txt1en.transform)
	end
end

function CharacterSpName:setSizeScaleName0(optSx, optSy, optEnSx, optEnSy)
	if self._txt0 and (optSx or optSy) then
		self:setWHByRatio(optSx, optSy, self._txt0.transform)
	end

	if self._txt0en and (optEnSx or optEnSy) then
		self:setWHByRatio(optEnSx, optEnSy, self._txt0en.transform)
	end
end

function CharacterSpName:setSizeScaleName1(optSx, optSy, optEnSx, optEnSy)
	if self._txt1 and (optSx or optSy) then
		self:setWHByRatio(optSx, optSy, self._txt1.transform)
	end

	if self._txt1en and (optEnSx or optEnSy) then
		self:setWHByRatio(optEnSx, optEnSy, self._txt1en.transform)
	end
end

return CharacterSpName
