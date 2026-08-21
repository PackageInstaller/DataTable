-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/HeroDetailInfoModel.lua

module("logic.extensions.playerinfo.model.HeroDetailInfoModel", package.seeall)

local M = class("HeroDetailInfoModel", BaseModel)

function M:ctor()
	self._heroDetailInfos = nil
end

function M:onInit()
	self._heroDetailInfos = {}
end

function M:onReset()
	table.clear(self._heroDetailInfos)
end

function M:getHeroDetailInfo(userId, heroId)
	if self._heroDetailInfos[userId] then
		return self._heroDetailInfos[userId][heroId]
	end

	return nil
end

function M:addHeroDetailInfo(msg)
	self._heroDetailInfos[msg.userId] = self._heroDetailInfos[msg.userId] or {}

	local heroId = msg.info.hero.id
	local heroData = CharacterDataOthers.New(msg.info)

	self._heroDetailInfos[msg.userId][heroId] = heroData
end

M.instance = M.New()

return M
