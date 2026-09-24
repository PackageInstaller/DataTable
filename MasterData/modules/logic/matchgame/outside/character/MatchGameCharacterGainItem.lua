-- chunkname: @modules/logic/matchgame/outside/character/MatchGameCharacterGainItem.lua

module("modules.logic.matchgame.outside.character.MatchGameCharacterGainItem", package.seeall)

local MatchGameCharacterGainItem = class("MatchGameCharacterGainItem", LuaCompBase)

function MatchGameCharacterGainItem:init(go)
	self.go = go
	self._goCharacterMesh = gohelper.findChild(self.go, "#go_CharacterMesh")
	self._imageCareer = gohelper.findChildImage(self.go, "image_Career")
	self._iconComp = MatchGameCharacterIconComp.Get(self._goCharacterMesh)
end

function MatchGameCharacterGainItem:onUpdateMO(characterId)
	self._characterId = characterId
	self._characterCo = lua_activity244_character.configDict[self._characterId]
	self._elementId = self._characterCo and self._characterCo.elementId

	self._iconComp:setData(characterId)
	MatchGameHelper.setCharacterElement(self._elementId, self._imageCareer)
end

return MatchGameCharacterGainItem
