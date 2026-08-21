-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsidehint/BattleSideHintItem.lua

module("logic.extensions.battle.viewsidehint.BattleSideHintItem", package.seeall)

local BattleSideHintItem = class("BattleSideHintItem", UIReusableLuaBehavior)

function BattleSideHintItem:buildUI()
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._imgSignIcon = goutil.findChildImageComponent(self.mainGO, "signIcon")
end

function BattleSideHintItem:destroyUI()
	self._txtTitle = nil
	self._txtDesc = nil
	self._imgSignIcon = nil
end

function BattleSideHintItem:show()
	goutil.setActive(self.mainGO, true)
end

function BattleSideHintItem:hide()
	goutil.setActive(self.mainGO, false)
end

function BattleSideHintItem:setDungeonStarCode(dungeonStarCode)
	local dungeonStarCOWrapper = DungeonConfig.instance:getDungeonStarCOWrapper(dungeonStarCode)

	ChatUtil.adaptForFixedWidth(self._txtDesc, dungeonStarCOWrapper:getDescription(), 307, 0)
end

return BattleSideHintItem
