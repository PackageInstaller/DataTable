-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzWorkBase.lua

module("modules.logic.versionactivity3_7.wmz.flow.WmzWorkBase", package.seeall)

local WmzWorkBase = class("WmzWorkBase", BaseWork)
local kTimeout = 3

function WmzWorkBase:startBlock(optKey, optTimeout)
	local blockKey = optKey or self.class.__cname

	UIBlockHelper.instance:startBlock(blockKey, optTimeout or kTimeout)

	return blockKey
end

function WmzWorkBase:endBlock(blockKey)
	UIBlockHelper.instance:endBlock(blockKey or self.class.__cname)
end

function WmzWorkBase:onSucc()
	self:onDone(true)
end

function WmzWorkBase:onFail()
	self:onDone(false)
end

function WmzWorkBase:insertWork(work)
	return self.root:insertWork(work)
end

function WmzWorkBase:onStart()
	self:onSucc()
end

function WmzWorkBase:clearWork()
	self:endBlock()
end

function WmzWorkBase:episodeId()
	return self.root:episodeId()
end

function WmzWorkBase:restartBattle()
	self.root:battleInst():restart(self:episodeId())
end

return WmzWorkBase
