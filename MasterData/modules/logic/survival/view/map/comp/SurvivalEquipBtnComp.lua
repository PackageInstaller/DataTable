-- chunkname: @modules/logic/survival/view/map/comp/SurvivalEquipBtnComp.lua

module("modules.logic.survival.view.map.comp.SurvivalEquipBtnComp", package.seeall)

local SurvivalEquipBtnComp = class("SurvivalEquipBtnComp", LuaCompBase)

function SurvivalEquipBtnComp:init(go)
	self._gohas = gohelper.findChild(go, "#go_icon/#go_Has")
	self._goempty = gohelper.findChild(go, "#go_icon/#go_Empty")
	self._imageIcon = gohelper.findChildSingleImage(go, "#go_icon/#go_Has/image_icon")
	self._golevel32 = gohelper.findChild(go, "#go_icon/#go_Has/#level3_2")
	self._golevel1 = gohelper.findChild(go, "#go_icon/#go_Has/#level1")
	self._golevel2 = gohelper.findChild(go, "#go_icon/#go_Has/#level2")
	self._golevel3 = gohelper.findChild(go, "#go_icon/#go_Has/#level3")
	self._txtplan = gohelper.findChildTextMesh(go, "#txt_index")
	self._gored = gohelper.findChild(go, "go_arrow")

	self:_refreshView()
end

function SurvivalEquipBtnComp:addEventListeners()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipInfoUpdate, self._refreshView, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipRedUpdate, self._refreshView, self)
end

function SurvivalEquipBtnComp:removeEventListeners()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipInfoUpdate, self._refreshView, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipRedUpdate, self._refreshView, self)
end

function SurvivalEquipBtnComp:_refreshView()
	local equipBox = SurvivalShelterModel.instance:getWeekInfo().equipBox
	local tagCo = lua_survival_equip_found.configDict[equipBox.maxTagId]
	local icon = tagCo and tagCo.icon

	gohelper.setActive(self._goempty, not tagCo)
	gohelper.setActive(self._gohas, tagCo)

	if tagCo then
		local level = 0

		if not equipBox.values[tagCo.value] then
			local arr = string.splitToNumber(tagCo.level, "#") or {}

			for k, v in ipairs(arr) do
				if v <= equipBox.values[tagCo.value] then
					level = k
				end
			end

			self._imageIcon:LoadImage(ResUrl.getSurvivalEquipIcon(icon))
			gohelper.setActive(self._golevel32, level == 3)
			gohelper.setActive(self._golevel1, level == 1)
			gohelper.setActive(self._golevel2, level == 2)
			gohelper.setActive(self._golevel3, level == 3)
		end
	end

	self._txtplan.text = string.format("%02d", equipBox.currPlanId)

	gohelper.setActive(self._gored, SurvivalEquipRedDotHelper.instance.reddotType >= 0)
end

return SurvivalEquipBtnComp
