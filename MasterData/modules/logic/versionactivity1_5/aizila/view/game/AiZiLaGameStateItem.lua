-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameStateItem.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameStateItem", package.seeall)

local AiZiLaGameStateItem = class("AiZiLaGameStateItem", ListScrollCellExtend)

function AiZiLaGameStateItem:onInitView()
	self._goState = gohelper.findChild(self.viewGO, "#go_State")
	self._goeffdown = gohelper.findChild(self.viewGO, "#go_State/#go_effdown")
	self._goeffup = gohelper.findChild(self.viewGO, "#go_State/#go_effup")
	self._txteffDesc = gohelper.findChildText(self.viewGO, "#go_State/#txt_effDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaGameStateItem:addEvents()
	return
end

function AiZiLaGameStateItem:removeEvents()
	return
end

function AiZiLaGameStateItem:_editableInitView()
	return
end

function AiZiLaGameStateItem:_editableAddEvents()
	return
end

function AiZiLaGameStateItem:_editableRemoveEvents()
	return
end

function AiZiLaGameStateItem:onUpdateMO(mo)
	self._mo = mo
end

function AiZiLaGameStateItem:onSelect(isSelect)
	return
end

function AiZiLaGameStateItem:onDestroyView()
	return
end

function AiZiLaGameStateItem:setStateStr(str)
	self._txteffDesc.text = str
end

function AiZiLaGameStateItem:setShowUp(isShowUp)
	gohelper.setActive(self._goeffdown, not isShowUp)
	gohelper.setActive(self._goeffup, isShowUp)
end

return AiZiLaGameStateItem
