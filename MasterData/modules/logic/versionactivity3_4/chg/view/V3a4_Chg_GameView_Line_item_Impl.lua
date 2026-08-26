-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameView_Line_item_Impl.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameView_Line_item_Impl", package.seeall)

local V3a4_Chg_GameView_Line_item_Impl = class("V3a4_Chg_GameView_Line_item_Impl", RougeSimpleItemBase)

function V3a4_Chg_GameView_Line_item_Impl:ctor(...)
	self:__onInit()
	V3a4_Chg_GameView_Line_item_Impl.super.ctor(self, ...)

	self._dir = ChgEnum.Dir.None
end

function V3a4_Chg_GameView_Line_item_Impl:onDestroyView()
	GameUtil.onDestroyViewMember_TweenId(self, "_tween")
	V3a4_Chg_GameView_Line_item_Impl.super.onDestroyView(self)
	self:__onDispose()
end

function V3a4_Chg_GameView_Line_item_Impl:_editableInitView()
	V3a4_Chg_GameView_Line_item_Impl.super._editableInitView(self)

	self._gohotArea = gohelper.findChild(self.viewGO, "#go_hotArea")
	self._finish = gohelper.findChild(self.viewGO, "finish")
	self._guaijiao = gohelper.findChild(self.viewGO, "guaijiao")

	self:setActiveTopLight(false)
	self:reset()
end

function V3a4_Chg_GameView_Line_item_Impl:_refLineItem()
	return self:parent()._refLineItem
end

function V3a4_Chg_GameView_Line_item_Impl:setWidth(newWidth)
	if self._width == newWidth then
		return
	end

	self._width = newWidth

	local refLineItem = self:_refLineItem()

	if refLineItem then
		self:setDummyWidth(0)
	else
		self:setActiveTopLight(newWidth > 0)
		recthelper.setWidth(self:transform(), newWidth)
	end
end

function V3a4_Chg_GameView_Line_item_Impl:getWidth()
	return self._width or 0
end

function V3a4_Chg_GameView_Line_item_Impl:setDummyWidth(newWidth)
	newWidth = newWidth + self:getWidth()

	if self:_refLineItem() then
		self:setActiveTopLight(false)
		self:_refLineItem():setDummyWidth(newWidth)
	else
		self:setActiveTopLight(newWidth > 0)
		recthelper.setWidth(self:transform(), newWidth)
	end
end

function V3a4_Chg_GameView_Line_item_Impl:reset(eDir)
	self._width = 0

	recthelper.setWidth(self:transform(), 0)
	self:setActive_finish(false)

	local isShowTopLight = eDir ~= ChgEnum.Dir.None

	if not self:_refLineItem() then
		self:setActiveTopLight(isShowTopLight)
	end

	self:setDir(eDir or ChgEnum.Dir.None)
	self:setActive(true)
end

local kZot = {
	[ChgEnum.Dir.Up] = 90,
	[ChgEnum.Dir.Down] = -90,
	[ChgEnum.Dir.Right] = 0,
	[ChgEnum.Dir.Left] = 180
}

function V3a4_Chg_GameView_Line_item_Impl:setDir(eDir)
	if eDir == self._dir then
		return
	end

	self._dir = eDir

	if not kZot[eDir] then
		self:localRotateZ(kZot[eDir])
	end
end

function V3a4_Chg_GameView_Line_item_Impl:getDir()
	return self._dir or ChgEnum.Dir.None
end

function V3a4_Chg_GameView_Line_item_Impl:_setActive_gohotArea(isActive)
	gohelper.setActive(self._gohotArea, isActive)
end

function V3a4_Chg_GameView_Line_item_Impl:_setActive_guaijiao(isActive)
	gohelper.setActive(self._guaijiao, isActive)
end

function V3a4_Chg_GameView_Line_item_Impl:setActiveTopLight(isActive)
	if self:_refLineItem() then
		self:_refLineItem():setActiveTopLight(isActive)
	end

	self:_setActive_gohotArea(isActive)
	self:_setActive_guaijiao(isActive)
end

function V3a4_Chg_GameView_Line_item_Impl:setActive_finish(isActive)
	gohelper.setActive(self._finish, isActive)
end

return V3a4_Chg_GameView_Line_item_Impl
