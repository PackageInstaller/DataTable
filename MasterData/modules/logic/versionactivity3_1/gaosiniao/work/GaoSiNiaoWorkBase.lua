-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoWorkBase.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWorkBase", package.seeall)

local GaoSiNiaoWorkBase = class("GaoSiNiaoWorkBase", BaseWork)
local kTimeout = 3

function GaoSiNiaoWorkBase:startBlock(optKey, optTimeout)
	local blockKey = optKey or self.class.__cname

	UIBlockHelper.instance:startBlock(blockKey, optTimeout or kTimeout)

	return blockKey
end

function GaoSiNiaoWorkBase:endBlock(blockKey)
	UIBlockHelper.instance:endBlock(blockKey or self.class.__cname)
end

function GaoSiNiaoWorkBase:onSucc()
	self:onDone(true)
end

function GaoSiNiaoWorkBase:onFail()
	self:onDone(false)
end

function GaoSiNiaoWorkBase:onStart()
	self:onSucc()
end

function GaoSiNiaoWorkBase:clearWork()
	self:endBlock()
end

return GaoSiNiaoWorkBase
