-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/model/ThemePostMo.lua

module("logic.extensions.controlaction.model.ThemePostMo", package.seeall)

local M = class("ThemePostMo")

function M:ctor()
	self._id = 1
	self._code = 1
	self._playerCode = 1
	self._time = 0
	self._likeCount = 0
	self._isTop = false
	self._postCo = false
	self._playerCo = false
end

function M:init(dataNO, id)
	if id then
		self._id = id
	else
		self._id = dataNO.id
	end

	self._code = dataNO.contentCode
	self._playerCode = dataNO.author
	self._time = dataNO.time
	self._likeCount = dataNO.likesCount
	self._isTop = dataNO.isTop

	if not self._postCo then
		if id then
			self._postCo = ControlActionConfig.instance:getReplyPostCfg(self._code)

			if not self._postCo then
				-- block empty
			end
		else
			self._postCo = ControlActionConfig.instance:getThemePostCfg(self._code)

			if not self._postCo then
				printError("===the theme post code error.=== code= ", self._code)
			end
		end
	end

	if not self._playerCo then
		self._playerCo = ControlActionConfig.instance:getPlayerCfg(self._playerCode)

		if not self._playerCo then
			printError("===the player code error.=== code= ", self._playerCode)
		end
	end
end

function M:getThemePostCo()
	return self._postCo
end

function M:getPlayerCo()
	return self._playerCo
end

function M:getId()
	return self._id
end

function M:getCode()
	return self._code
end

function M:getTime()
	return self._time
end

function M:getLikeCount()
	return self._likeCount
end

function M:isTop()
	return self._isTop
end

return M
