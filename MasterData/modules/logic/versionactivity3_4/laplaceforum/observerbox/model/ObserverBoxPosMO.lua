-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/model/ObserverBoxPosMO.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.model.ObserverBoxPosMO", package.seeall)

local ObserverBoxPosMO = class("ObserverBoxPosMO")

function ObserverBoxPosMO:ctor()
	self.pos = 0
	self.bonusId = 0
end

function ObserverBoxPosMO:init(info)
	self.pos = info.pos
	self.bonusId = info.bonusId
end

function ObserverBoxPosMO:update(info)
	self.pos = info.pos
	self.bonusId = info.bonusId
end

return ObserverBoxPosMO
