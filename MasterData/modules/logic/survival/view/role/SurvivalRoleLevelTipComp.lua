-- chunkname: @modules/logic/survival/view/role/SurvivalRoleLevelTipComp.lua

module("modules.logic.survival.view.role.SurvivalRoleLevelTipComp", package.seeall)

local SurvivalRoleLevelTipComp = class("SurvivalRoleLevelTipComp", LuaCompBase)

function SurvivalRoleLevelTipComp:init(viewGO)
	self.viewGO = viewGO
	self.textLevelTipLv = gohelper.findChildTextMesh(self.viewGO, "txt_grade/lv")
	self.textLevelTipProgress = gohelper.findChildTextMesh(self.viewGO, "#txt_num")
	self.survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
end

function SurvivalRoleLevelTipComp:onStart()
	local level = self.survivalShelterRoleMo.level
	local isMaxLevel = SurvivalRoleConfig.instance:isMaxLevel(level)

	self.textLevelTipLv.text = "Lv." .. level

	if not isMaxLevel then
		local curNeed = SurvivalRoleConfig.instance:getLevelNeedExp(level)
		local nextNeed = SurvivalRoleConfig.instance:getLevelNeedExp(level + 1)

		self.textLevelTipProgress.text = string.format("<color=#BB7E47>%s</color>/%s", self.survivalShelterRoleMo.roleExp - curNeed, nextNeed - curNeed)
	else
		self.textLevelTipProgress.text = ""
	end
end

function SurvivalRoleLevelTipComp:setShow(v)
	gohelper.setActive(self.viewGO, v)
end

return SurvivalRoleLevelTipComp
