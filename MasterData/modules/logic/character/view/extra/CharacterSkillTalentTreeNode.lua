-- chunkname: @modules/logic/character/view/extra/CharacterSkillTalentTreeNode.lua

module("modules.logic.character.view.extra.CharacterSkillTalentTreeNode", package.seeall)

local CharacterSkillTalentTreeNode = class("CharacterSkillTalentTreeNode", ListScrollCellExtend)

function CharacterSkillTalentTreeNode:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._godark = gohelper.findChild(self.viewGO, "#go_dark")
	self._imagedarkIcon = gohelper.findChildImage(self.viewGO, "#go_dark/#image_darkIcon")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._gocanlvup = gohelper.findChild(self.viewGO, "#go_canlvup")
	self._gomaxEffect = gohelper.findChild(self.viewGO, "#go_canlvup/#go_maxEffect")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_canlvup/#image_icon")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkillTalentTreeNode:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function CharacterSkillTalentTreeNode:removeEvents()
	self._btnclick:RemoveClickListener()
end

function CharacterSkillTalentTreeNode:_btnclickOnClick()
	CharacterController.instance:dispatchEvent(CharacterEvent.onClickTalentTreeNode, self._sub, self._level)
end

function CharacterSkillTalentTreeNode:_editableInitView()
	self:showSelect(false)

	self._goprelit = gohelper.findChild(self.viewGO, "#pre_lit")
	self._canlvupanim = self._gocanlvup:GetComponent(typeof(UnityEngine.Animator))
	self._lockanim = self._golock:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterSkillTalentTreeNode:onUpdateMO(mo)
	self._mo = mo

	local co = self._mo.co

	self._sub = co.sub
	self._level = co.level

	local iconPath = mo:getIconPath()

	if not string.nilorempty(iconPath) then
		UISpriteSetMgr.instance:setSp01TalentIconSprite(self._imageicon, iconPath, true)
		UISpriteSetMgr.instance:setSp01TalentIconSprite(self._imagedarkIcon, iconPath, true)
	end

	self._light = self._mo:isLight()
end

function CharacterSkillTalentTreeNode:setLineGo(line)
	if line then
		self._line = self:getUserDataTb_()
		self._line.anim = line:GetComponent(typeof(UnityEngine.Animator))
		self._line.light = gohelper.findChild(line, "go_linelight")
	end
end

function CharacterSkillTalentTreeNode:refreshStatus()
	gohelper.setActive(self._gocanlvup, self._mo:isLight())
	gohelper.setActive(self._golock, self._mo:isLock())

	if self._mo:isLight() then
		if self._line then
			gohelper.setActive(self._line.light, true)
		end

		if not self._light then
			self._canlvupanim:Play(CharacterExtraEnum.SkillTreeAnimName.Click, 0, 0)

			if self._line and self._line.anim then
				self._line.anim:Play(CharacterExtraEnum.SkillTreeAnimName.Click, 0, 0)
			end

			AudioMgr.instance:trigger(AudioEnum2_9.Character.ui_role_kashan_jihuo)
		end
	else
		if self._line then
			gohelper.setActive(self._line.light, false)
		end

		if self._mo:isLock() and not self._lock then
			self._lockanim:Play(CharacterExtraEnum.SkillTreeAnimName.Lock, 0, 0)
		end
	end

	self._light = self._mo:isLight()
	self._lock = self._mo:isLock()
end

function CharacterSkillTalentTreeNode:showSelect(isShow)
	gohelper.setActive(self._goselect, isShow)
end

function CharacterSkillTalentTreeNode:showSelectEffect(isShow)
	gohelper.setActive(self._goprelit, isShow)
end

function CharacterSkillTalentTreeNode:getAnchoredPosition()
	return self.viewGO.transform.anchoredPosition
end

return CharacterSkillTalentTreeNode
