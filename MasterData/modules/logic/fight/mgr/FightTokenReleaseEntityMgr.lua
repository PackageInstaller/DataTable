-- chunkname: @modules/logic/fight/mgr/FightTokenReleaseEntityMgr.lua

module("modules.logic.fight.mgr.FightTokenReleaseEntityMgr", package.seeall)

local FightTokenReleaseEntityMgr = class("FightTokenReleaseEntityMgr", FightBaseClass)

function FightTokenReleaseEntityMgr:onConstructor()
	self.entityDic = {}
end

function FightTokenReleaseEntityMgr:addEntity(token, entity)
	local tab = self.entityDic[token]

	if not tab then
		tab = {}
		self.entityDic[token] = tab
	end

	table.insert(tab, entity)
end

function FightTokenReleaseEntityMgr:getEntity(token)
	return self.entityDic[token] and self.entityDic[token][1]
end

function FightTokenReleaseEntityMgr:removeEntity(token)
	local tab = self.entityDic[token]

	if tab then
		for _, entity in ipairs(tab) do
			entity:disposeSelf()
		end
	end

	self.entityDic[token] = nil
end

function FightTokenReleaseEntityMgr:onDestructor()
	return
end

return FightTokenReleaseEntityMgr
