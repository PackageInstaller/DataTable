-- chunkname: @modules/logic/player/view/PlayerBgComp.lua

module("modules.logic.player.view.PlayerBgComp", package.seeall)

local PlayerBgComp = class("PlayerBgComp", LuaCompBase)

function PlayerBgComp:init(go)
	self.go = go
	self._gobg = gohelper.findChild(go, "#go_bg")
	self._gospine = gohelper.findChild(go, "#go_spine")
	self._gospine2 = gohelper.findChild(go, "dynamiccontainer/#go_spine")
	self._black = gohelper.findChild(go, "#go_black")
	self._uiSpine = GuiSpine.Create(self._gospine, true)
	self._uiSpine2 = GuiModelAgent.Create(self._gospine2, true)
	self._bgLoader = PrefabInstantiate.Create(self._gobg)
end

function PlayerBgComp:showBg(bgCo)
	self._bgCo = bgCo

	self:_loadSpine()

	local prePath = self._bgLoader:getPath()
	local nowPath = string.format("ui/viewres/player/bg/%s.prefab", bgCo.bgEffect)

	if prePath ~= nowPath then
		self._bgLoader:dispose()
		self._bgLoader:startLoad(nowPath)
	end

	gohelper.setActive(self._black, bgCo.item ~= 0)
end

function PlayerBgComp:setPlayerInfo(otherPlayerInfo, heroCover)
	self._otherPlayerInfo = otherPlayerInfo
	self._otherPlayerHeroCover = heroCover
end

function PlayerBgComp:_loadSpine()
	gohelper.setActive(self._gospine, self._bgCo.item == 0)
	gohelper.setActive(self._gospine2, self._bgCo.item ~= 0)

	if self._bgCo.item == 0 then
		local spineName = CommonConfig.instance:getConstStr(ConstEnum.PlayerViewSpine)
		local resPath = ResUrl.getRolesCgStory(spineName)

		if self._uiSpine:getResPath() ~= resPath then
			self._uiSpine:setResPath(resPath, self._onSpineLoaded, self)
		end
	else
		local skinCo

		if self._otherPlayerHeroCover then
			local arr = string.splitToNumber(self._otherPlayerHeroCover, "#")
			local heroId, skinId = arr[1], arr[2]

			skinCo = lua_skin.configDict[skinId]

			if not lua_skin.configDict[skinId] then
				local heroCo = lua_character.configDict[heroId]

				heroCo = heroCo or lua_character.configDict[3028]
				skinCo = lua_skin[heroCo.skinId]
			end
		else
			local heroId, skinId = CharacterSwitchListModel.instance:getMainHero()
			local hero = HeroModel.instance:getByHeroId(heroId)

			skinCo = SkinConfig.instance:getSkinCo(skinId or hero and hero.skin)
		end

		if skinCo == self._nowSkinCo then
			return
		end

		self._nowSkinCo = skinCo

		self._uiSpine2:setResPath(skinCo, self._onSpineLoaded2, self)

		local offsets = SkinConfig.instance:getSkinOffset(skinCo.characterViewOffset)

		recthelper.setAnchor(self._gospine2.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._gospine2.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	end
end

function PlayerBgComp:_onSpineLoaded()
	self._uiSpine:changeLookDir(SpineLookDir.Left)

	if not self._otherPlayerInfo then
		local info = PlayerModel.instance:getPlayinfo()
		local eyeEpisodeId = CommonConfig.instance:getConstNum(ConstEnum.PlayerViewEyeEpisodeId)
		local openEye = eyeEpisodeId == info.lastEpisodeId or DungeonConfig.instance:isPreEpisodeList(eyeEpisodeId, info.lastEpisodeId)

		if openEye then
			self._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "b_idle", true, 0)
		else
			self._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "b_idle_1", true, 0)
		end
	end
end

function PlayerBgComp:_onSpineLoaded2()
	self._uiSpine2:setModelVisible(true)
end

function PlayerBgComp:onDestroy()
	if self._uiSpine then
		gohelper.destroy(self._gospine)

		self._gospine = nil
		self._uiSpine = nil
	end

	if self._bgLoader then
		self._bgLoader:dispose()

		self._bgLoader = nil
	end
end

return PlayerBgComp
