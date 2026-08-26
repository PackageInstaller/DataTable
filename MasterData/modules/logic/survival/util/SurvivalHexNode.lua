-- chunkname: @modules/logic/survival/util/SurvivalHexNode.lua

module("modules.logic.survival.util.SurvivalHexNode", package.seeall)

local SurvivalHexNode = {}

function SurvivalHexNode.New(q, r, s)
	local node = setmetatable({}, SurvivalHexNode)

	node:set(q, r, s)

	return node
end

function SurvivalHexNode:set(q, r, s)
	self.q = q or 0
	self.r = r or 0
	self.s = s or -self.q - self.r
	self.gCost = 0
	self.hCost = 0
	self.parent = nil

	return self
end

function SurvivalHexNode:copyFrom(node)
	self.q = node.q
	self.r = node.r
	self.s = node.s
	self.gCost = 0
	self.hCost = 0
	self.parent = nil

	return self
end

function SurvivalHexNode:clone()
	return SurvivalHexNode.New(self.q, self.r)
end

function SurvivalHexNode:fCost()
	return self.gCost + self.hCost
end

function SurvivalHexNode:rotateDir(center, rotateDir)
	if rotateDir < 0 then
		rotateDir = rotateDir + 6
	end

	local dq_new, dr_new, ds_new
	local delta_q = self.q - center.q
	local delta_r = self.r - center.r
	local delta_s = self.s - center.s

	if rotateDir == 0 then
		ds_new = delta_s
		dr_new = delta_r
		dq_new = delta_q
	elseif rotateDir == 1 then
		dq_new = -delta_r
		dr_new = -delta_s
		ds_new = -delta_q
	elseif rotateDir == 2 then
		dq_new = delta_s
		dr_new = delta_q
		ds_new = delta_r
	elseif rotateDir == 3 then
		dq_new = -delta_q
		dr_new = -delta_r
		ds_new = -delta_s
	elseif rotateDir == 4 then
		dq_new = delta_r
		dr_new = delta_s
		ds_new = delta_q
	elseif rotateDir == 5 then
		dq_new = -delta_s
		dr_new = -delta_q
		ds_new = -delta_r
	end

	self.q = center.q + dq_new
	self.r = center.r + dr_new
	self.s = center.s + ds_new
end

function SurvivalHexNode:Add(point)
	self.q = self.q + point.q
	self.r = self.r + point.r
	self.s = self.s + point.s

	return self
end

function SurvivalHexNode.__eq(a, b)
	return a.q == b.q and a.r == b.r
end

function SurvivalHexNode.__add(a, b)
	return SurvivalHexNode.New(a.q + b.q, a.r + b.r)
end

function SurvivalHexNode.__sub(a, b)
	return SurvivalHexNode.New(a.q - b.q, a.r - b.r)
end

function SurvivalHexNode.__tostring(t)
	return string.format("[%d,%d,%d]", t.q, t.r, t.s)
end

SurvivalHexNode.__index = SurvivalHexNode

return SurvivalHexNode
