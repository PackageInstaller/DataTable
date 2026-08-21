-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingWinConditionItem.lua

module("logic.extensions.battle.viewsetting.BattleSettingWinConditionItem", package.seeall)

local M = class("BattleSettingWinConditionItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self.mainGO = self._compContainer.gameObject

	self:onInit()
end

function M:onInit()
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "txtContent")
	self._keyTxt = goutil.findChildTextComponent(self.mainGO, "else/Text")
	self._keyGo = goutil.findChild(self.mainGO, "else")
end

function M:setData(str, contactKey)
	self._descTxt.text = str

	if contactKey then
		goutil.setActive(self._keyGo, true)

		self._keyTxt.text = contactKey
	else
		goutil.setActive(self._keyGo, false)
	end
end

function M:destroyUI()
	return
end

return M
