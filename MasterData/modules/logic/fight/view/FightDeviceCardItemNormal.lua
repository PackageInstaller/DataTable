-- chunkname: @modules/logic/fight/view/FightDeviceCardItemNormal.lua

module("modules.logic.fight.view.FightDeviceCardItemNormal", package.seeall)

local FightDeviceCardItemNormal = class("FightDeviceCardItemNormal", FightDeviceCardItemBase)

FightDeviceCardItemNormal.prefabPath = "ui/viewres/fight/fight3_7device_normal_carditem.prefab"

function FightDeviceCardItemNormal.Create(goParent, cardItem)
	local deviceItem = FightDeviceCardItemNormal.New()

	deviceItem:init(goParent, cardItem)

	return deviceItem
end

function FightDeviceCardItemNormal:initViews()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)
	self.animator = self.go:GetComponent(gohelper.Type_Animator)
	self.goSelect = gohelper.findChild(self.go, "go_select")
	self.iconImage = gohelper.findChildSingleImage(self.go, "imgIcon")
	self.cardCoverImage = gohelper.findChildImage(self.go, "#image_cardCareer")
	self.tagIcon = gohelper.findChildSingleImage(self.go, "tag/tagIcon")
	self.imageCareerBg = gohelper.findChildImage(self.go, "cost/#image_numCareer")
	self.txtPower = gohelper.findChildText(self.go, "cost/#txt_enough")
	self.goGrayMask = gohelper.findChild(self.go, "gray_mask")
	self.goLock = gohelper.findChild(self.go, "lock")
	self.lockAnimPlayer = ZProj.ProjAnimatorPlayer.Get(gohelper.findChild(self.goLock, "anim"))
	self.txtLockList = self:getUserDataTb_()

	for _, path in ipairs(FightDeviceCardItemBase.LockTextPathList) do
		table.insert(self.txtLockList, gohelper.findChildText(self.goLock, "anim/" .. path))
	end

	self.goMask = gohelper.findChild(self.go, "mask")

	gohelper.setActive(self.goMask, false)

	self.loadedDone = true

	self:setSelectFrameActive(self.selectFrameActive)
	self:setLockActive(self.lockActive)
	self:setGrayMaskActive(self.grayMaskActive)
end

function FightDeviceCardItemNormal:refreshUI(deviceSkillInfo)
	self.deviceSkillInfo = deviceSkillInfo

	if not self.loadedDone then
		return
	end

	if not deviceSkillInfo then
		return
	end

	local skillCo = lua_skill.configDict[deviceSkillInfo.skillId]

	if not skillCo then
		logError(string.format("skill co is nil, skillId : %s", deviceSkillInfo.skillId))

		return
	end

	self.skillCo = skillCo

	local targetIconUrl = ResUrl.getSkillIcon(skillCo.icon)

	self.iconImage:LoadImage(targetIconUrl)

	local tagUrl = ResUrl.getAttributeIcon("attribute_" .. skillCo.showTag)

	self.tagIcon:LoadImage(tagUrl)
	UISpriteSetMgr.instance:setFightSprite(self.imageCareerBg, FightDeviceHelper.getCareerImage(deviceSkillInfo.costType))

	self.txtPower.text = deviceSkillInfo.costValue

	UISpriteSetMgr.instance:setFightSprite(self.cardCoverImage, FightDeviceHelper.getCareerCoverImage(deviceSkillInfo.costType))

	if self.lockComp then
		self.lockComp:updateLock()
	end
end

function FightDeviceCardItemNormal:dispose()
	if self.iconImage then
		self.iconImage:UnLoadImage()

		self.iconImage = nil
	end

	if self.tagIcon then
		self.tagIcon:UnLoadImage()

		self.tagIcon = nil
	end

	FightDeviceCardItemNormal.super.dispose(self)
end

return FightDeviceCardItemNormal
