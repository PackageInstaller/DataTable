-- chunkname: @modules/logic/matchgame/outside/character/MatchGameCharacterIconComp.lua

module("modules.logic.matchgame.outside.character.MatchGameCharacterIconComp", package.seeall)

local MatchGameCharacterIconComp = class("MatchGameCharacterIconComp", LuaCompBase)

function MatchGameCharacterIconComp.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, MatchGameCharacterIconComp)
end

function MatchGameCharacterIconComp:init(go)
	self.go = go
	self._simageRole = gohelper.findChildSingleImage(self.go, "#image_CharacterIcon")
	self._imageRole = gohelper.findChildImage(self.go, "#image_CharacterIcon")
	self._uiMeshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.go, MatchGameFightRoleMesh)

	self:loadIconMat()
end

function MatchGameCharacterIconComp:setData(characterId)
	self._characterCo = lua_activity244_character.configDict[characterId]
	self._iconUrl = self._characterCo and self._characterCo.image

	self._simageRole:LoadImage(self._iconUrl, self.loadImageCallback, self)
	self._uiMeshComp:refreshMesh(self._characterCo, false)
end

function MatchGameCharacterIconComp:loadImageCallback(w, h)
	if self._imageRole then
		self._imageRole:SetNativeSize()
	end
end

function MatchGameCharacterIconComp:loadIconMat()
	self._matLoader = MultiAbLoader.New()

	self._matLoader:addPath(MatchGameEnum.CharacterIconMatUrl)
	self._matLoader:startLoad(self._onLoadMatDone, self)
end

function MatchGameCharacterIconComp:_onLoadMatDone(loader)
	local assetItem = loader:getAssetItem(MatchGameEnum.CharacterIconMatUrl)
	local effectPrefab = assetItem:GetResource(MatchGameEnum.CharacterIconMatUrl)
	local matRes = assetItem:GetResource(MatchGameEnum.CharacterIconMatUrl)

	self._iconMatInst = UnityEngine.GameObject.Instantiate(matRes)
	self._imageRole.material = self._iconMatInst
end

function MatchGameCharacterIconComp:onDestroy()
	if self._matLoader then
		self._matLoader:dispose()

		self._matLoader = nil
	end

	if self._iconMatInst then
		gohelper.destroy(self._iconMatInst)

		self._iconMatInst = nil
	end
end

return MatchGameCharacterIconComp
