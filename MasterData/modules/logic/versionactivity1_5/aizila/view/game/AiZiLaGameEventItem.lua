-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameEventItem.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventItem", package.seeall)

local AiZiLaGameEventItem = class("AiZiLaGameEventItem", ListScrollCellExtend)

function AiZiLaGameEventItem:onInitView()
	self._goEnable = gohelper.findChild(self.viewGO, "#go_Enable")
	self._goDisable = gohelper.findChild(self.viewGO, "#go_Disable")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaGameEventItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AiZiLaGameEventItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function AiZiLaGameEventItem:_btnclickOnClick()
	if self._mo then
		AiZiLaGameController.instance:selectOption(self._mo.optionId)
	end
end

function AiZiLaGameEventItem:_editableInitView()
	return
end

function AiZiLaGameEventItem:_editableAddEvents()
	return
end

function AiZiLaGameEventItem:_editableRemoveEvents()
	return
end

function AiZiLaGameEventItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function AiZiLaGameEventItem:refreshUI()
	if not self._mo then
		return
	end

	local actId = self._mo.actId
	local optionId = self._mo.optionId
	local isBranchLine = self._mo.eventType == AiZiLaEnum.EventType.BranchLine
	local optionCfg = AiZiLaConfig.instance:getOptionCo(actId, optionId)
	local isSelect = AiZiLaModel.instance:isSelectOptionId(optionId)

	if optionCfg then
		if not optionCfg.name then
			local nameStr = optionId

			if not isBranchLine and isSelect then
				nameStr = string.format("%s\n<color=#85541b>%s</color>", nameStr, (optionCfg or nil) and (optionCfg.optionDesc or optionId))
			end

			self._txtname.text = nameStr

			gohelper.setActive(self._goEnable, not isSelect)
			gohelper.setActive(self._goEnable, not isSelect)
			gohelper.setActive(self._goDisable, isSelect)
			SLFramework.UGUI.GuiHelper.SetColor(self._txtname, isSelect and "#7c684f" or "#442a0d")
		end
	end
end

function AiZiLaGameEventItem:onSelect(isSelect)
	return
end

function AiZiLaGameEventItem:onDestroyView()
	return
end

return AiZiLaGameEventItem
