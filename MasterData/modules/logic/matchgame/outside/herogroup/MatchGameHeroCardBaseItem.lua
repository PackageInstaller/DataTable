-- chunkname: @modules/logic/matchgame/outside/herogroup/MatchGameHeroCardBaseItem.lua

module("modules.logic.matchgame.outside.herogroup.MatchGameHeroCardBaseItem", package.seeall)

local MatchGameHeroCardBaseItem = class("MatchGameHeroCardBaseItem", LuaCompBase)

function MatchGameHeroCardBaseItem:init(go)
	self.viewGO = go
	self.transform = self.viewGO.transform
	self._goOccupied = gohelper.findChild(self.viewGO, "go_occupied")
	self._goCharacterMesh = gohelper.findChild(self.viewGO, "go_occupied/#go_CharacterMesh")
	self._imageCareer = gohelper.findChildImage(self.viewGO, "go_occupied/image_career")
	self._txtLevel = gohelper.findChildText(self.viewGO, "go_occupied/txt_level")
	self._imageHpIcon = gohelper.findChildImage(self.viewGO, "go_occupied/simage_hpicon")
	self._txtHp = gohelper.findChildText(self.viewGO, "go_occupied/txt_hp")
	self._goSelect = gohelper.findChild(self.viewGO, "go_select")
	self._goCurrent = gohelper.findChild(self.viewGO, "go_current")
	self._goTeaming = gohelper.findChild(self.viewGO, "go_teaming")
	self._goBatch = gohelper.findChild(self.viewGO, "go_batch")
	self._txtTeamIndex = gohelper.findChildText(self.viewGO, "go_batch/txt_teamingindex")
	self._goEmpty = gohelper.findChild(self.viewGO, "go_empty")
	self._goLock = gohelper.findChild(self.viewGO, "go_empty/go_lock")
	self._goAdd = gohelper.findChild(self.viewGO, "go_empty/go_add")
	self._txtEmptyIndex = gohelper.findChildText(self.viewGO, "go_empty/go_add/txt_emptyindex")
	self._txtName = gohelper.findChildText(self.viewGO, "go_occupied/txt_Name")
	self._goTrial = gohelper.findChild(self.viewGO, "go_occupied/go_trial")
	self._btnClick = gohelper.getClickWithDefaultAudio(self.viewGO)
	self._posIndex = 0
	self._heroMo = nil
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._canvasGroup = gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)
	self._iconComp = MatchGameCharacterIconComp.Get(self._goCharacterMesh)

	self:setTeamVisible(false)
	self:setAddIconVisible(false)
	self:setLockIconVisible(false)
	self:setPosIndexVisible(false)
	self:setCurrentTeamVisible(false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameHeroCardBaseItem:addEventListeners()
	self._btnClick:AddClickListener(self._onClick, self)
end

function MatchGameHeroCardBaseItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function MatchGameHeroCardBaseItem:setPosIndex(posIndex)
	self._posIndex = posIndex
end

function MatchGameHeroCardBaseItem:getPosIndex()
	return self._posIndex
end

function MatchGameHeroCardBaseItem:onUpdateMO(heroMo)
	self._heroMo = heroMo
	self._heroCo = self._heroMo and self._heroMo.heroCo

	self:refreshUI()
end

function MatchGameHeroCardBaseItem:refreshUI()
	if self._heroMo then
		self:_showOccupied()
	else
		self:_showEmpty()
	end
end

function MatchGameHeroCardBaseItem:_showOccupied()
	gohelper.setActive(self._goOccupied, true)
	gohelper.setActive(self._goEmpty, false)

	self._txtName.text = self._heroCo.name

	self._iconComp:setData(self._heroCo.characterId)
	gohelper.setActive(self._goTrial, self._heroMo:isTrial())
	MatchGameHelper.setCharacterElement(self._heroCo.elementId, self._imageCareer)

	self._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_malllevelupview_level"), self._heroMo.level)
	self._txtHp.text = self._heroMo:getTotalAttrValue(MatchGameEnum.CharacterAttrType.Hp)

	MatchGameHelper.setCharacterAttr(MatchGameEnum.CharacterAttrType.Hp, self._imageHpIcon)
end

function MatchGameHeroCardBaseItem:_showEmpty()
	gohelper.setActive(self._goOccupied, false)
	gohelper.setActive(self._goEmpty, true)

	self._txtEmptyIndex.text = tostring(self._posIndex)
end

function MatchGameHeroCardBaseItem:onSelect(isSelect)
	gohelper.setActive(self._goSelect, isSelect)
end

function MatchGameHeroCardBaseItem:_onClick()
	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj)
	end
end

function MatchGameHeroCardBaseItem:setClickCallback(clickCallback, clickCallbackObj)
	self._clickCallback = clickCallback
	self._clickCallbackObj = clickCallbackObj
end

function MatchGameHeroCardBaseItem:setCurrentTeamVisible(isVisible)
	gohelper.setActive(self._goCurrent, isVisible)
end

function MatchGameHeroCardBaseItem:setTeamVisible(isVisible)
	gohelper.setActive(self._goTeaming, isVisible)
end

function MatchGameHeroCardBaseItem:setPosIndexVisible(isVisible, posIndex)
	gohelper.setActive(self._goBatch, isVisible)

	self._txtTeamIndex.text = posIndex or 1
end

function MatchGameHeroCardBaseItem:setAddIconVisible(isVisible)
	gohelper.setActive(self._goAdd, isVisible)
end

function MatchGameHeroCardBaseItem:setLockIconVisible(isVisible)
	gohelper.setActive(self._goLock, isVisible)
end

function MatchGameHeroCardBaseItem:setAnimatorEnabled(enabled)
	self._animator.enabled = enabled
end

function MatchGameHeroCardBaseItem:onDestroy()
	return
end

return MatchGameHeroCardBaseItem
