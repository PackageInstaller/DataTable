-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/CourseHouseItem.lua

module("logic.extensions.playerinfo.view.course.widgets.CourseHouseItem", package.seeall)

local M = class("CourseHouseItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:buildUI()
end

function M:buildUI()
	local registry = ViewElementsRegistry.New(self.mainGO)

	self._goNormal = registry:findUIElement("player_course_house_item_1299981684")
	self._goNone = registry:findUIElement("player_course_house_item_-855452509")
	self._goTxt2 = registry:findUIElement("player_course_house_item_836299860")
	self._imgBg = registry:findUIElement("player_course_house_item_680208201", UIComponentType.Image)
	self._atsIcon = registry:findUIElement("player_course_house_item_1763464843", UIComponentType.Image)
	self._btnJump = registry:findUIElement("player_course_house_item_1535208208", UIComponentType.Button)
	self._txtNum1 = registry:findUIElement("player_course_house_item_94652185", UIComponentType.Text)
	self._txtNum2 = registry:findUIElement("player_course_house_item_1083265390", UIComponentType.Text)
	self._txtName = registry:findUIElement("player_course_house_item_914208038", UIComponentType.Text)

	goutil.setActive(self.mainGO, true)
end

function M:setData(data)
	if not data then
		goutil.setActive(self._goNormal, false)
		goutil.setActive(self._goNone, true)

		return
	end

	goutil.setActive(self._goNormal, true)
	goutil.setActive(self._goNone, false)

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
end

return M
