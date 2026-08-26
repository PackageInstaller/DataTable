-- chunkname: @modules/logic/survival/view/tech/item/SurvivalTechLockArea.lua

module("modules.logic.survival.view.tech.item.SurvivalTechLockArea", package.seeall)

local SurvivalTechLockArea = class("SurvivalTechLockArea", SimpleListItem)

function SurvivalTechLockArea:onInit()
	self.root = gohelper.findChild(self.viewGO, "root")
	self.anim = self.root:GetComponent(gohelper.Type_Animator)
	self.lock = gohelper.findChild(self.root, "lock")
	self.txt_lock = gohelper.findChildTextMesh(self.lock, "#txt_lock")
end

function SurvivalTechLockArea:onAddListeners()
	return
end

function SurvivalTechLockArea:onItemShow(data)
	self.level = data.level

	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo

	self.isUnLock = self.level <= survivalShelterRoleMo.level
	self.txt_lock.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalTechLockArea_1"), {
		self.level
	})

	if self.isUnLock then
		self.anim:Play("unlock", 0, 1)

		return
	end

	self.anim:Play("lock", 0, 1)
end

function SurvivalTechLockArea:playUnLockAnim()
	self.anim:Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
end

return SurvivalTechLockArea
