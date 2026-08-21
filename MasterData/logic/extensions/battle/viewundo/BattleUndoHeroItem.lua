-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewundo/BattleUndoHeroItem.lua

module("logic.extensions.battle.viewundo.BattleUndoHeroItem", package.seeall)

local BattleUndoHeroItem = class("BattleUndoHeroItem", ReusableLuaBehavior)

function BattleUndoHeroItem:buildUI()
	self._transform = self.mainGO.transform
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._goSelect = goutil.findChild(self.mainGO, "pos/imgSelect")
	self._imgHeroIcon = goutil.findChildImageComponent(self.mainGO, "pos/normal/headScale/heroIcon")
	self._animation = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "pos/click"))

	self._btnClick:AddClickListener(self._onClick, self)

	self._clickHandler = Handler.New()
	self._index = false
	self._undoMO = false
end

function BattleUndoHeroItem:destroyUI()
	self._btnClick:RemoveClickListener()

	self._transform = false
	self._canvasGroup = false
	self._animation = false
	self._goSelect = false
	self._imgHeroIcon = false
	self._btnClick = false
	self._undoMO = false
end

function BattleUndoHeroItem:onEnter()
	self:setSelected(false)
end

function BattleUndoHeroItem:onExit()
	IconLoader.clearSprite(self._imgHeroIcon)
end

function BattleUndoHeroItem:setIndex(index)
	self._index = index
end

function BattleUndoHeroItem:getIndex()
	return self._index
end

function BattleUndoHeroItem:getPosition()
	return Astral.TransformUtil.GetAnchoredPos(self._transform, 0, 0)
end

function BattleUndoHeroItem:setSelected(isSelected)
	goutil.setActive(self._goSelect, isSelected)

	self._canvasGroup.ignoreParentGroups = isSelected
end

function BattleUndoHeroItem:setUndoMO(undoMO)
	self._undoMO = undoMO

	local entityCode = undoMO:getEntityCode()
	local entityType = undoMO:getEntityType()
	local entityCO = BattleEntityCOAdapter:getSharedEntityCOAdapter(entityCode, entityType)
	local modelCO = ModelConfig.instance:getModelConfig(entityCO:getModelCode())

	if string.nilorempty(modelCO.headIconName) then
		IconLoader.setSprite(self._imgHeroIcon, IconType.RoleCardIcon, modelCO.halfIconName)
	else
		IconLoader.setSprite(self._imgHeroIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	end
end

function BattleUndoHeroItem:getUndoMO()
	return self._undoMO
end

function BattleUndoHeroItem:setClickListener(callback, callbackSelf)
	self._clickHandler:setListener(callback, callbackSelf)
end

function BattleUndoHeroItem:playShiftAnimation()
	self._animation:Play("hero_item_hua")
end

function BattleUndoHeroItem:_onClick()
	self._clickHandler:call(self)
end

return BattleUndoHeroItem
