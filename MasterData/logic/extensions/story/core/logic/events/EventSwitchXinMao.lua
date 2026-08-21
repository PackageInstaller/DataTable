-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventSwitchXinMao.lua

module("logic.extensions.story.core.logic.events.EventSwitchXinMao", package.seeall)

local M = class("EventSwitchXinMao", StoryEventBase)

function M:_OnInitCtor()
	self._xinmaoBindTran = false
	self._isHideXinMao = false
end

function M:OnEventExecuteInternal()
	local characterRefId = self.config:GetArgValue(StoryArgKeyConst.RefTargetID)
	local m_proxyInst = self.binder:GetGameObjectInstProxy(characterRefId)

	if not m_proxyInst then
		return
	end

	local characterTarget = m_proxyInst.target

	if goutil.isNil(characterTarget) then
		return
	end

	self._isHideXinMao = self.config:GetArgValueBoolean(StoryArgKeyConst.HideXinMao)

	local storyCache = StoryBoneCache.Get(characterTarget)
	local tempXinMaoBindGo = storyCache and storyCache.xinMaoGo or nil

	if not goutil.isNil(tempXinMaoBindGo) then
		self._xinmaoBindTran = tempXinMaoBindGo.transform
	end

	local characterName = characterTarget.name

	characterName = string.gsub(characterName, "-show", "")

	if string.nilorempty(characterName) then
		return
	end

	local heroName = false
	local tempStr = string.split(characterName, "_")
	local modelId = tonumber(tempStr[1])

	if #tempStr == 2 then
		heroName = tempStr[2]
	end

	if self._xinmaoBindTran then
		goutil.clearChildren(self._xinmaoBindTran)
	end

	if not goutil.isNil(tempXinMaoBindGo) then
		local xinMao = Astral.SimpleLuaComponentContainer.Add(characterTarget, UnitCompHeroXinMao)

		xinMao:setDefaultHide(self._isHideXinMao)
		xinMao:setInfo(modelId, characterTarget)
	end
end

function M:OnStoryCleanInternal()
	self._xinmaoBindTran = nil
end

return M
