-- chunkname: @modules/logic/gm/view/Checker_BaseWork.lua

module("modules.logic.gm.view.Checker_BaseWork", package.seeall)

local Checker_BaseWork = class("Checker_BaseWork", BaseWork)

function Checker_BaseWork:endBlock(blockKey)
	if not self:isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock(blockKey)
end

function Checker_BaseWork:startBlock(blockKey)
	if self:isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock(blockKey)
end

function Checker_BaseWork:isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

function Checker_BaseWork:readAllText(filename)
	local fh = io.open(filename, "r")

	if not fh then
		logError("[readAllText] file open failed: " .. filename)

		return false
	end

	local res = fh:read("*a")

	fh:close()

	return true, res
end

function Checker_BaseWork:writeAllText(filename, str)
	local fh = io.open(filename, "w+")

	if not fh then
		logError("[writeAllText] file open failed: " .. filename)

		return false
	end

	fh:write(str)
	fh:close()

	return true
end

return Checker_BaseWork
