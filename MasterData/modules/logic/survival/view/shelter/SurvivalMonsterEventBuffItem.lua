-- chunkname: @modules/logic/survival/view/shelter/SurvivalMonsterEventBuffItem.lua

module("modules.logic.survival.view.shelter.SurvivalMonsterEventBuffItem", package.seeall)

local SurvivalMonsterEventBuffItem = class("SurvivalMonsterEventBuffItem", ListScrollCellExtend)

function SurvivalMonsterEventBuffItem:onInitView()
	self._gounfinish = gohelper.findChild(self.viewGO, "#go_unfinish")
	self._txtdec = gohelper.findChildText(self.viewGO, "scroll_buffDec/Viewport/Content/#txt_dec")
	self._txtdecfinished = gohelper.findChildText(self.viewGO, "scroll_buffDec/Viewport/Content/#txt_dec_finished")
	self._gofinished = gohelper.findChild(self.viewGO, "#go_finished")

	if self._editableInitView then
		self:_editableInitView()
	end

	self.icon = gohelper.findChildImage(self.viewGO, "#go_unfinish/icon")
end

function SurvivalMonsterEventBuffItem:addEvents()
	return
end

function SurvivalMonsterEventBuffItem:removeEvents()
	return
end

function SurvivalMonsterEventBuffItem:_editableInitView()
	self._ani = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function SurvivalMonsterEventBuffItem:_editableAddEvents()
	return
end

function SurvivalMonsterEventBuffItem:_editableRemoveEvents()
	return
end

function SurvivalMonsterEventBuffItem:initItem(id, survivalIntrudeSchemeMo)
	self.survivalIntrudeSchemeMo = survivalIntrudeSchemeMo
	self._co = SurvivalConfig.instance:getShelterIntrudeSchemeConfig(id)

	if self._co == nil then
		logError("SurvivalMonsterEventBuffItem:initItem id is nil" .. id)
	end

	if self._co then
		self._txtdec.text = self._co.desc or ""
	end

	if self._co then
		self._txtdecfinished.text = self._co.desc or ""
	end

	local path = self.survivalIntrudeSchemeMo:getDisplayIcon()

	UISpriteSetMgr.instance:setSurvivalSprite(self.icon, path)
end

function SurvivalMonsterEventBuffItem:updateItem(repress)
	gohelper.setActive(self._gofinished, repress)
	gohelper.setActive(self._txtdecfinished.gameObject, repress)
	gohelper.setActive(self._gounfinish, not repress)
	gohelper.setActive(self._txtdec.gameObject, not repress)

	if self._lastState == nil or self._lastState ~= repress then
		self:playAni(repress and "finished" or "open")
	end

	self._lastState = repress
end

function SurvivalMonsterEventBuffItem:playAni(name)
	if name then
		self._ani:Play(name, 0, 0)
	end
end

function SurvivalMonsterEventBuffItem:onDestroyView()
	return
end

return SurvivalMonsterEventBuffItem
