-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/ToolTipsFackEquipComp.lua

module("logic.extensions.charactersystem.view.preinstall.ToolTipsFackEquipComp", package.seeall)

local M = class("ToolTipsFackEquipComp", ToolTipsEquipComp)

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._equipDetailComp = Astral.LuaComponentContainer.Add(self.mainGO, EquipTipsDetailInfoComponent)

	self._equipDetailComp:buildUI()
end

return M
