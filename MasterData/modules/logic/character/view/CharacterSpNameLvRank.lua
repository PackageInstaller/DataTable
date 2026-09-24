-- chunkname: @modules/logic/character/view/CharacterSpNameLvRank.lua

module("modules.logic.character.view.CharacterSpNameLvRank", package.seeall)

local CharacterSpNameLvRank = class("CharacterSpNameLvRank", CharacterSpName)

function CharacterSpNameLvRank:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSpNameLvRank:addEvents()
	return
end

function CharacterSpNameLvRank:removeEvents()
	return
end

function CharacterSpNameLvRank.s_create(Self, srcGo, baseViewContainer)
	local item = CharacterSpNameLvRank.New({
		parent = Self,
		baseViewContainer = baseViewContainer
	})

	item:init(srcGo)

	return item
end

function CharacterSpNameLvRank.s_createByView(Self, srcGo)
	return (CharacterSpNameLvRank.s_create(Self, srcGo, Self.viewContainer))
end

function CharacterSpNameLvRank.s_createByListScrollCellExtend(Self, srcGo)
	local scrollView = Self._view

	if scrollView then
		return (CharacterSpNameLvRank:s_create(srcGo, scrollView.viewContainer or Self.viewContainer))
	end
end

function CharacterSpNameLvRank:ctor(...)
	CharacterSpNameLvRank.super.ctor(self, ...)
end

function CharacterSpNameLvRank:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_lv0")
	GameUtil.onDestroyViewMemberList(self, "_lv1")
	GameUtil.onDestroyViewMemberList(self, "_rank0")
	GameUtil.onDestroyViewMemberList(self, "_rank1")
	CharacterSpNameLvRank.super.onDestroyView(self)
end

function CharacterSpNameLvRank:_editableInitView()
	CharacterSpNameLvRank.super._editableInitView(self)

	self._oPoX, self._oPosY = self:posXY()

	local c = self:baseViewContainer()

	self._lv1 = CharacterLv.s_create(self, gohelper.findChild(self.viewGO, "lv"), c)
	self._rank1 = CharacterRank.s_create(self, gohelper.findChild(self.viewGO, "rankobj"), c)
end

function CharacterSpNameLvRank:lv1()
	return self._lv1
end

function CharacterSpNameLvRank:lv0()
	return self._lv0
end

function CharacterSpNameLvRank:rank0()
	return self._rank0
end

function CharacterSpNameLvRank:rank1()
	return self._rank1
end

function CharacterSpNameLvRank:getOriginalPosXY()
	return self._oPoX, self._oPosY
end

function CharacterSpNameLvRank:bindLv0(optObjCharacterLv)
	self:_bindObjImpl(CharacterLv, "_lv0", optObjCharacterLv)

	return self
end

function CharacterSpNameLvRank:bindLv1(optObjCharacterLv)
	self:_bindObjImpl(CharacterLv, "_lv1", optObjCharacterLv)

	return self
end

function CharacterSpNameLvRank:bindRank0(optObjCharacterRank)
	self:_bindObjImpl(CharacterRank, "_rank0", optObjCharacterRank)

	return self
end

function CharacterSpNameLvRank:bindRank1(optObjCharacterRank)
	self:_bindObjImpl(CharacterRank, "_rank1", optObjCharacterRank)

	return self
end

function CharacterSpNameLvRank:setIsOldPattern(b)
	self._bOldPattern = b
end

function CharacterSpNameLvRank:bOldPattern()
	if self._bOldPattern ~= nil then
		return self._bOldPattern
	end

	return self:bEmptySpName()
end

function CharacterSpNameLvRank:mo()
	return self._mo
end

function CharacterSpNameLvRank:setData(mo)
	CharacterSpNameLvRank.super.setData(self, mo)

	if self._onSetStyleCb then
		self._onSetStyleCb(self._onSetStyleCbObj)

		self._onSetStyleCb = nil
	end

	if self._lv0 then
		self._lv0:onUpdateMO(mo)
	end

	if self._lv1 then
		self._lv1:onUpdateMO(mo)
	end

	self:setActiveLvOnly(true)

	if self._rank0 then
		self._rank0:onUpdateMO(mo)
	end

	if self._rank1 then
		self._rank1:onUpdateMO(mo)
	end

	self:setActiveRankOnly(true)

	return self
end

function CharacterSpNameLvRank:regSetStyleAfterSetData(cb, cbObj)
	self._onSetStyleCb = cb
	self._onSetStyleCbObj = cbObj
end

function CharacterSpNameLvRank:setActiveLv0(bActive)
	if self._lv0 then
		self._lv0:setActive(bActive)
	end
end

function CharacterSpNameLvRank:setActiveLv1(bActive)
	if self._lv1 then
		self._lv1:setActive(bActive)
	end
end

function CharacterSpNameLvRank:setActiveLvOnly(bActive)
	if not self._mo then
		bActive = false
	end

	if not bActive then
		self:setActiveLv0(false)
		self:setActiveLv1(false)
	else
		local bEmptySpName = self:bEmptySpName()

		self:setActiveLv0(bEmptySpName)
		self:setActiveLv1(not bEmptySpName)
	end
end

function CharacterSpNameLvRank:setActiveRank0(bActive)
	if self._rank0 then
		self._rank0:setActive(bActive)
	end
end

function CharacterSpNameLvRank:setActiveRank1(bActive)
	if self._rank1 then
		self._rank1:setActive(bActive)
	end
end

function CharacterSpNameLvRank:setActiveRankOnly(bActive)
	if not self._mo then
		bActive = false
	end

	if not bActive then
		self:setActiveRank0(false)
		self:setActiveRank1(false)
	else
		local bEmptySpName = self:bEmptySpName()

		self:setActiveRank0(bEmptySpName)
		self:setActiveRank1(not bEmptySpName)
	end
end

function CharacterSpNameLvRank:setLv(level)
	local str = HeroConfig.instance:getShowLevel(level)

	self:setLvStr(str)
end

function CharacterSpNameLvRank:setBalanceLv(level, optHexColor)
	local str = gohelper.getRichColorText(HeroConfig.instance:getShowLevel(level), optHexColor or "#bfdaff")

	self:setLvStr(str)
end

function CharacterSpNameLvRank:setLvStr(str)
	if self._lv0 then
		self._lv0:setLv(str)
	end

	if self._lv1 then
		self._lv1:setLv(str)
	end
end

function CharacterSpNameLvRank:setLvColor(optHexColor)
	if not optHexColor then
		return
	end

	if self._lv0 then
		self._lv0:setLvColor(optHexColor)
	end

	if self._lv1 then
		self._lv1:setLvColor(optHexColor)
	end
end

function CharacterSpNameLvRank:setRankColor(targetRank, optHexColor)
	if self._rank0 then
		self._rank0:setActiveRank(targetRank)

		if optHexColor then
			self._rank0:setColorRank(optHexColor)
		end
	end

	if self._rank1 then
		self._rank1:setActiveRank(targetRank)

		if optHexColor then
			self._rank1:setColorRank(optHexColor)
		end
	end
end

function CharacterSpNameLvRank:setScaleHeroName(sx, sy, sz)
	self:setScaleName0(sx, sy, sz)
	self:setScaleName1(sx, sy, sz)
end

function CharacterSpNameLvRank:setScaleHeroSpName(sx, sy, sz)
	self:setScaleSpName(sx, sy, sz)
end

function CharacterSpNameLvRank:setScaleLv(sx, sy, sz)
	if self._lv0 then
		self._lv0:setScaleXYZ(sx, sy, sz)
	end

	if self._lv1 then
		self._lv1:setScaleXYZ(sx, sy, sz)
	end
end

function CharacterSpNameLvRank:setScaleRank(sx, sy, sz)
	if self._rank0 then
		self._rank0:setScaleXYZ(sx, sy, sz)
	end

	if self._rank1 then
		self._rank1:setScaleXYZ(sx, sy, sz)
	end
end

function CharacterSpNameLvRank:setPosLv(x, y)
	if self._lv0 then
		self._lv0:setAPos(x, y)
	end

	if self._lv1 then
		self._lv1:setAPos(x, y)
	end
end

function CharacterSpNameLvRank:setPosRank(x, y)
	if self._rank0 then
		self._rank0:setAPos(x, y)
	end

	if self._rank1 then
		self._rank1:setAPos(x, y)
	end
end

function CharacterSpNameLvRank:setPosNameCn(x, y)
	self:setPosName0(x, y, nil, nil)
	self:setPosName1(x, y, nil, nil)
end

function CharacterSpNameLvRank:setPosNameEn(x, y)
	self:setPosName0(nil, nil, x, y)
	self:setPosName1(nil, nil, x, y)
end

function CharacterSpNameLvRank:setWidthNameCn(value)
	self:setWName0(value, nil)
	self:setWName1(value, nil)
end

function CharacterSpNameLvRank:setWidthNameEn(value)
	self:setWName0(nil, value)
	self:setWName1(nil, value)
end

function CharacterSpNameLvRank:setSizeScaleNameCn(sx, sy)
	self:setSizeScaleName0(sx, sy, nil, nil)
	self:setSizeScaleName1(sx, sy, nil, nil)
end

function CharacterSpNameLvRank:setSizeScaleNameEn(sx, sy)
	self:setSizeScaleName0(nil, nil, sx, sy)
	self:setSizeScaleName1(nil, nil, sx, sy)
end

return CharacterSpNameLvRank
