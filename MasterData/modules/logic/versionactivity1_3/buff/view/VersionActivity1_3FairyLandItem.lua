-- chunkname: @modules/logic/versionactivity1_3/buff/view/VersionActivity1_3FairyLandItem.lua

module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3FairyLandItem", package.seeall)

local VersionActivity1_3FairyLandItem = class("VersionActivity1_3FairyLandItem", ListScrollCellExtend)

function VersionActivity1_3FairyLandItem:onInitView()
	self._imagecard = gohelper.findChildImage(self.viewGO, "root/#image_card")
	self._txtname = gohelper.findChildText(self.viewGO, "root/image_namebg/#txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/desc/Viewport/Content/#txt_desc")
	self._goselected = gohelper.findChild(self.viewGO, "root/#go_selected")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3FairyLandItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function VersionActivity1_3FairyLandItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function VersionActivity1_3FairyLandItem:_btnclickOnClick()
	self._landView:landItemClick(self)
end

function VersionActivity1_3FairyLandItem:ctor(param)
	self._landView = param[1]
	self.config = param[2]
end

function VersionActivity1_3FairyLandItem:_editableInitView()
	local skillId = self.config.skillId
	local effectConfig = lua_skill_effect.configDict[skillId]

	self._txtdesc.text = FightConfig.instance:getSkillEffectDesc(nil, effectConfig)

	local skillConfig = lua_skill.configDict[skillId]

	self._txtname.text = skillConfig and skillConfig.name

	UISpriteSetMgr.instance:setV1a3FairyLandCardSprite(self._imagecard, "v1a3_fairylandcard_" .. self.config.id - 2130000)
	self:setSelected(false)
end

function VersionActivity1_3FairyLandItem:setSelected(value)
	self._isSelected = value

	gohelper.setActive(self._goselected, self._isSelected)
end

function VersionActivity1_3FairyLandItem:_editableRemoveEvents()
	return
end

function VersionActivity1_3FairyLandItem:onUpdateMO(mo)
	return
end

function VersionActivity1_3FairyLandItem:onSelect(isSelect)
	return
end

function VersionActivity1_3FairyLandItem:onDestroyView()
	return
end

return VersionActivity1_3FairyLandItem
