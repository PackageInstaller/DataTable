-- chunkname: @modules/logic/fight/view/FightDeviceCardItemUnique.lua

module("modules.logic.fight.view.FightDeviceCardItemUnique", package.seeall)

local FightDeviceCardItemUnique = class("FightDeviceCardItemUnique", FightDeviceCardItemBase)

FightDeviceCardItemUnique.prefabPath = "ui/viewres/fight/fight3_7device_unique_carditem.prefab"

function FightDeviceCardItemUnique.Create(goParent, cardItem)
	local deviceItem = FightDeviceCardItemUnique.New()

	deviceItem:init(goParent, cardItem)

	return deviceItem
end

function FightDeviceCardItemUnique:initViews()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)
	self.animator = self.go:GetComponent(gohelper.Type_Animator)
	self.goSelect = gohelper.findChild(self.go, "go_select")
	self.iconImage = gohelper.findChildSingleImage(self.go, "imgIcon")
	self.goGrayMask = gohelper.findChild(self.go, "gray_mask")
	self.goLock = gohelper.findChild(self.go, "lock")
	self.lockAnimPlayer = ZProj.ProjAnimatorPlayer.Get(gohelper.findChild(self.goLock, "anim"))
	self.txtLockList = self:getUserDataTb_()

	for _, path in ipairs(FightDeviceCardItemBase.LockTextPathList) do
		table.insert(self.txtLockList, gohelper.findChildText(self.goLock, "anim/" .. path))
	end

	self.loadedDone = true

	self:setSelectFrameActive(self.selectFrameActive)
	self:setLockActive(self.lockActive)
	self:setGrayMaskActive(self.grayMaskActive)
end

function FightDeviceCardItemUnique:refreshUI(deviceSkillInfo)
	self.deviceSkillInfo = deviceSkillInfo

	if not self.loadedDone then
		return
	end

	if not deviceSkillInfo then
		return
	end

	local skillCo = lua_skill.configDict[deviceSkillInfo.skillId]

	self.skillCo = skillCo

	local targetIconUrl = ResUrl.getSkillIcon(skillCo.icon)

	self.iconImage:LoadImage(targetIconUrl)

	if self.lockComp then
		self.lockComp:updateLock()
	end
end

function FightDeviceCardItemUnique:dispose()
	if self.iconImage then
		self.iconImage:UnLoadImage()

		self.iconImage = nil
	end

	FightDeviceCardItemUnique.super.dispose(self)
end

return FightDeviceCardItemUnique
