-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/MaLiAnNaSkillItem.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaSkillItem", package.seeall)

local MaLiAnNaSkillItem = class("MaLiAnNaSkillItem", ListScrollCellExtend)

function MaLiAnNaSkillItem:onInitView()
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._imageSkill = gohelper.findChildImage(self.viewGO, "image/#image_Skill")
	self._imageCD = gohelper.findChildImage(self.viewGO, "#image_CD")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MaLiAnNaSkillItem:addEvents()
	return
end

function MaLiAnNaSkillItem:removeEvents()
	return
end

function MaLiAnNaSkillItem:_editableInitView()
	self._click = gohelper.getClickWithDefaultAudio(self.viewGO)

	self._click:AddClickListener(self.onClick, self)

	self._goVx = gohelper.findChild(self.viewGO, "vx_tips")
end

function MaLiAnNaSkillItem:_editableAddEvents()
	return
end

function MaLiAnNaSkillItem:_editableRemoveEvents()
	return
end

function MaLiAnNaSkillItem:onClick()
	if self._skillData == nil or self._skillData:isInCD() then
		return
	end

	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnSelectActiveSkill, self._skillData)
end

function MaLiAnNaSkillItem:initData(data)
	self._skillData = data

	local skillConfig = self._skillData:getConfig()

	if skillConfig and skillConfig.icon then
		UISpriteSetMgr.instance:setMaliAnNaSprite(self._imageSkill, skillConfig.icon)
	end
end

function MaLiAnNaSkillItem:updateInfo(data)
	self._skillData = data

	if self._skillData == nil then
		return
	end

	local value = data:getCDPercent()

	if self._cdValue == nil or self._cdValue ~= value then
		self._imageCD.fillAmount = value

		if self._cdValue ~= nil and value <= 0 then
			AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_activity_level_chosen)
		end

		gohelper.setActive(self._goVx, value <= 0)

		self._cdValue = value
	end
end

function MaLiAnNaSkillItem:refreshSelect(skillData)
	if skillData == nil then
		gohelper.setActive(self._goSelected, false)

		return
	end

	gohelper.setActive(self._goSelected, self._skillData._id == skillData._id)
end

function MaLiAnNaSkillItem:onDestroyView()
	if self._click then
		self._click:RemoveClickListener()

		self._click = nil
	end
end

return MaLiAnNaSkillItem
