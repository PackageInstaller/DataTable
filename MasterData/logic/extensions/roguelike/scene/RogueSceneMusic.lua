-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/RogueSceneMusic.lua

module("logic.extensions.roguelike.scene.RogueSceneMusic", package.seeall)

local M = class("RogueSceneMusic", SceneComponentBase)

function M:onInit()
	return
end

function M:onEnterScene(sceneId, bornX, bornZ)
	CriwareAudioFacade.instance:loadCueSheet("character_skill", "character_skill.acb", "")
	self:_setEvent(true)
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	local bgmCueName = "music_main_mengjingdangan_block"
	local ambCueName = "amb_battle_city"

	CriwareAudioFacade.instance:PlayBgmInnerBgName(bgmCueName)
	CriwareAudioFacade.instance:playSEByName(ambCueName)
end

function M:onExitScene()
	CriwareAudioFacade.instance:unloadCueSheet("character_skill")
	self:_setEvent(false)
end

function M:_onPlayBlockIndex(index)
	print("criware switch block with music:", index)
	CriwareAudioFacade.instance:setBgmNextBlockIndex(index)
end

function M:_onSwitchBlock(evt, index)
	self:_onPlayBlockIndex(index - 1)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.EventType.ROGUE_SWITCH_BG_MUSIC, self._onSwitchBlock, self)
	else
		GlobalDispatcher:removeEventListener(EventType.EventType.ROGUE_SWITCH_BG_MUSIC, self._onSwitchBlock, self)
	end
end

return M
