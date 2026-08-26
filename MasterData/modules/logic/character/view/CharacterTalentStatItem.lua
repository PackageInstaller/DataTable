-- chunkname: @modules/logic/character/view/CharacterTalentStatItem.lua

module("modules.logic.character.view.CharacterTalentStatItem", package.seeall)

local CharacterTalentStatItem = class("CharacterTalentStatItem", LuaCompBase)

function CharacterTalentStatItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "slot/#go_normal")
	self._imageicon = gohelper.findChildImage(self.viewGO, "slot/#image_icon")
	self._imageglow = gohelper.findChildImage(self.viewGO, "slot/#image_glow")
	self._gohot = gohelper.findChild(self.viewGO, "slot/#go_hot")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._imagepercent = gohelper.findChildImage(self.viewGO, "#image_percent")
	self._txtpercent = gohelper.findChildText(self.viewGO, "#txt_percent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentStatItem:addEvents()
	return
end

function CharacterTalentStatItem:removeEvents()
	return
end

function CharacterTalentStatItem:_editableInitView()
	return
end

function CharacterTalentStatItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function CharacterTalentStatItem:addEventListeners()
	self:addEvents()
end

function CharacterTalentStatItem:removeEventListeners()
	self:removeEvents()
end

function CharacterTalentStatItem:onStart()
	return
end

function CharacterTalentStatItem:onDestroy()
	return
end

function CharacterTalentStatItem:onRefreshMo(mo)
	local growTagIcon, nomalTagIcon = mo:getStyleTagIcon()
	local name, _ = mo:getStyleTag()

	UISpriteSetMgr.instance:setCharacterTalentSprite(self._imageicon, nomalTagIcon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(self._imageglow, growTagIcon, true)

	self._txtname.text = name

	local percent = mo:getUnlockPercent() * 0.01

	self._txtpercent.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), string.format("%.1f", percent))
	self._imagepercent.fillAmount = percent * 0.01

	gohelper.setActive(self._gohot, mo:isHotUnlock())

	local colorIndex = mo:isHotUnlock() and 1 or 2
	local statType = CharacterTalentStyleEnum.StatType[colorIndex]

	self._imagepercent.color = GameUtil.parseColor(statType.ProgressColor)
	self._txtpercent.color = GameUtil.parseColor(statType.TxtColor)
end

return CharacterTalentStatItem
