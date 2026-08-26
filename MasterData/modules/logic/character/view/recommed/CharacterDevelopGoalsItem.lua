-- chunkname: @modules/logic/character/view/recommed/CharacterDevelopGoalsItem.lua

module("modules.logic.character.view.recommed.CharacterDevelopGoalsItem", package.seeall)

local CharacterDevelopGoalsItem = class("CharacterDevelopGoalsItem", ListScrollCell)

function CharacterDevelopGoalsItem:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "title/#image_icon")
	self._txttitle = gohelper.findChildText(self.viewGO, "title/#txt_title")
	self._gounselect = gohelper.findChild(self.viewGO, "title/traced/#go_unselect")
	self._goselect = gohelper.findChild(self.viewGO, "title/traced/#go_select")
	self._btntraced = gohelper.findChildButtonWithAudio(self.viewGO, "title/traced/#btn_traced")
	self._scrollgroup = gohelper.findChild(self.viewGO, "#scroll_group")
	self._contentgroup = gohelper.findChild(self.viewGO, "#scroll_group/Viewport/Content")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#scroll_group/#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDevelopGoalsItem:addEventListeners()
	self._btntraced:AddClickListener(self._btntracedOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self.refreshStatus, self)
end

function CharacterDevelopGoalsItem:removeEventListeners()
	self._btntraced:RemoveClickListener()
	self._btnjump:RemoveClickListener()
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self.refreshStatus, self)
end

function CharacterDevelopGoalsItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function CharacterDevelopGoalsItem:_btnjumpOnClick()
	CharacterRecommedController.instance:jump(self._mo)
end

function CharacterDevelopGoalsItem:_btntracedOnClick()
	local isTraced = self._mo:isTraced()

	self._mo:setTraced(not isTraced)
	CharacterRecommedModel.instance:setTracedHeroDevelopGoalsMO(not isTraced and self._mo)
end

function CharacterDevelopGoalsItem:_editableInitView()
	return
end

function CharacterDevelopGoalsItem:_editableAddEvents()
	return
end

function CharacterDevelopGoalsItem:_editableRemoveEvents()
	return
end

function CharacterDevelopGoalsItem:onUpdateMO(mo)
	self._mo = mo

	local data = mo:getItemList()

	if data then
		IconMgr.instance:getCommonPropItemIconList(self, self._onRewardItemShow, data, self._contentgroup.gameObject)
	end

	local txt, icon = self._mo:getTitleTxtAndIcon()

	self._txttitle.text = txt

	if icon then
		UISpriteSetMgr.instance:setUiCharacterSprite(self._imageicon, icon)
		gohelper.setActive(self._imageicon.gameObject, true)
	else
		gohelper.setActive(self._imageicon.gameObject, false)
	end

	self:refreshStatus()
	self:playViewAnim("goalsitem_open", 0, 0)
end

function CharacterDevelopGoalsItem:_onRewardItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setScale(0.7)
	cell_component:setConsume(true)
	cell_component:setCountFontSize(38)
	cell_component:setRecordFarmItem(data)
	cell_component:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, self)
	cell_component:setQuantityText("#cd5353")
end

function CharacterDevelopGoalsItem:refreshStatus()
	local isOwnHero = self._mo:isOwnHero()
	local isTraced = self._mo:isTraced()

	gohelper.setActive(self._btnjump.gameObject, isOwnHero and isTraced)
	gohelper.setActive(self._gounselect.gameObject, isOwnHero and not isTraced)
	gohelper.setActive(self._goselect.gameObject, isOwnHero and isTraced)
end

function CharacterDevelopGoalsItem:playViewAnim(animName, layer, normalizedTime)
	self._viewAnim = self._viewAnim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._viewAnim then
		self._viewAnim:Play(animName, layer, normalizedTime)
	end
end

function CharacterDevelopGoalsItem:onSelect(isSelect)
	return
end

function CharacterDevelopGoalsItem:onDestroy()
	return
end

return CharacterDevelopGoalsItem
