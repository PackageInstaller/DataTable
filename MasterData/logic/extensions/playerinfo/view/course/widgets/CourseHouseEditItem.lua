-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/CourseHouseEditItem.lua

module("logic.extensions.playerinfo.view.course.widgets.CourseHouseEditItem", package.seeall)

local M = class("CourseHouseEditItem", CourseEditItem)

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()

	self._clickHandler = nil
end

function M:buildUI()
	local registry = self._registry

	self._goNormal = registry:findUIElement("player_course_house_edit_item_-1780394259")
	self._goNone = registry:findUIElement("player_course_house_edit_item_-360974445")
	self._goSine = registry:findUIElement("player_course_house_edit_item_292941481")
	self._goTxt2 = registry:findUIElement("player_course_house_edit_item_-1380514693")
	self._imgBg = registry:findUIElement("player_course_house_edit_item_-1035881096", UIComponentType.Image)
	self._atsIcon = registry:findUIElement("player_course_house_edit_item_-1036279354", UIComponentType.Image)
	self._txtNum1 = registry:findUIElement("player_course_house_edit_item_-663733026", UIComponentType.Text)
	self._txtNum2 = registry:findUIElement("player_course_house_edit_item_-1985429096", UIComponentType.Text)
	self._txtName = registry:findUIElement("player_course_house_edit_item_-1124401899", UIComponentType.Text)
	self._btn = registry:findUIElement("player_course_house_edit_item_2085363601", UIComponentType.ButtonAdapter)
	self._clickHandler = Handler.New()

	goutil.setActive(self.mainGO, true)
end

function M:bindEvents()
	self._btn:AddClickListener(self.onClick, self)
end

function M:unbindEvents()
	self._btn:RemoveClickListener()
	self._clickHandler:clear()
end

function M:AddClickListener(callback, handler)
	self._clickHandler:setListener(callback, handler)
end

function M:setHouse(data)
	self:showHouse(true)

	self._txtName.text = data:getName()
	self._txtNum1.text = data:getAtmosphere()

	local specialType = data:getAtmosphereType()
	local typeName

	if specialType then
		local coList = LivingFacilitiesConfig.instance:getConfig(ConfigName.HouseAtmosType)

		typeName = coList and coList[specialType] and coList[specialType].name
	end

	if typeName then
		goutil.setActive(self._goTxt2, true)
		HouseMainUtil.changAtmosphereIcon(self._atsIcon, specialType)

		self._txtNum2.text = data:getAtmosphereSpecial() or 0
	else
		goutil.setActive(self._goTxt2, false)
	end

	self._houseId = data:getId()
end

function M:showHouse(active)
	goutil.setActive(self._goNormal, active)
	goutil.setActive(self._goNone, not active)
end

function M:showSign(active)
	goutil.setActive(self._goSine, active)
end

function M:showEntity(entity)
	if entity then
		self:setHouse(entity)
	else
		self:showHouse(false)
		self:showSign(false)
	end
end

function M:onClick()
	self._clickHandler:call(self._houseId)
end

return M
