-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/panel/UnitCompNameBar.lua

module("logic.scene.unit.component.panel.UnitCompNameBar", package.seeall)

local M = class("UnitCompNameBar", UnitComponentBase)
local URL_NAMEBAR = ResName.Unit_name

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = SingleResLoader.New()
	self._goInst = nil
	self._followUIComp = nil
	self._isVisible = nil
end

function M:onInit()
	self._followUIComp = self._unit.uiFollow

	HouseDispatcher:addEventListener(HouseEventType.CHANGE_HERO_NAMEBAR_VISIBLE, self._onChangeVisible, self)
end

function M:onReuse()
	HouseDispatcher:addEventListener(HouseEventType.CHANGE_HERO_NAMEBAR_VISIBLE, self._onChangeVisible, self)
end

function M:onReset()
	HouseDispatcher:removeEventListener(HouseEventType.CHANGE_HERO_NAMEBAR_VISIBLE, self._onChangeVisible, self)
	self:_clearInst()

	self._isVisible = false
end

function M:onDestroy()
	HouseDispatcher:removeEventListener(HouseEventType.CHANGE_HERO_NAMEBAR_VISIBLE, self._onChangeVisible, self)
	self:_clearInst()

	self._resLoader = nil
	self._followUIComp = nil
	self._isVisible = false
end

function M:showByData()
	self:setVisible(HouseController.instance:getNamebarVisible())
end

function M:setVisible(visible)
	self._isVisible = visible

	if visible == false then
		self:_clearInst()

		return
	end

	if self._goInst then
		self:_setVisible()
	elseif self._resLoader then
		self._resLoader:load(URL_NAMEBAR, self._onResLoaded, self)
	end
end

function M:_setVisible()
	goutil.setActive(self._goInst, self._isVisible)
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	self:_buildUI(self._goInst)

	local parentGo = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	goutil.addChildToParent(self._goInst, parentGo)
	self._followUIComp:addBottomFollowGameObject(self._goInst)
	self:_setVisible()
end

function M:_buildUI(mainGO)
	self._bg = goutil.findChild(mainGO, "bg")
	self._txtName = goutil.findChildTextComponent(self._bg, "txtName")

	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._unit.heroId)

	self._txtName.text = heroMO:getName()

	RectTransformUtils.ForceRebuildLayoutImmediate(self._txtName.gameObject.transform)
	RectTransformUtils.SetWidth(self._bg.transform, self._txtName.preferredWidth)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._bg.transform)
end

function M:_clearInst()
	if self._goInst then
		self._followUIComp:removeBottomFollowGameObject(self._goInst)
		goutil.destroy(self._goInst)
	end

	self._goInst = false

	if self._resLoader then
		self._resLoader:clear()
	end
end

function M:_onChangeVisible()
	self:showByData()
end

return M
