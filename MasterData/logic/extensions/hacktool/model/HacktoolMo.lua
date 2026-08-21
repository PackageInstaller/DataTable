-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/model/HacktoolMo.lua

module("logic.extensions.hacktool.model.HacktoolMo", package.seeall)

local M = class("HacktoolMo", BaseModel)

function M:ctor()
	self._tabId = false
	self._isOpenedBattle = false
	self._isHideBtns = false
	self._levelCodeVisible = true
	self._hideUIEnable = false
end

function M:setTabId(type)
	self._tabId = type
end

function M:getTabId()
	return self._tabId
end

function M:setOpenBattle(open)
	self._isOpenedBattle = open
end

function M:getOpenedBattle()
	return self._isOpenedBattle
end

function M:setHideBtns(status)
	self._isHideBtns = status
end

function M:getHideBtns()
	return self._isHideBtns
end

function M:setLevelCodeVisible(status)
	self._levelCodeVisible = status
end

function M:getLevelCodeVisible()
	return self._levelCodeVisible
end

function M:setHideUIEnable(status)
	self._hideUIEnable = status
end

function M:getHideUIEnable()
	return self._hideUIEnable
end

M.instance = M.New()

return M
