-- chunkname: @modules/logic/fight/entity/FightEntityBuffMgr.lua

module("modules.logic.fight.entity.FightEntityBuffMgr", package.seeall)

local FightEntityBuffMgr = class("FightEntityBuffMgr", FightBaseClass)

function FightEntityBuffMgr:onConstructor()
	self.buffDic = {}
end

function FightEntityBuffMgr:addBuff(buff)
	local uid = buff.uid

	if self.buffDic[uid] then
		return
	end

	self.buffDic[uid] = self:newClass(FightEntityBuffObject, buff)

	self.buffDic[uid]:onAddBuff()
end

function FightEntityBuffMgr:removeBuff(uid)
	if not self.buffDic[uid] then
		return
	end

	self.buffDic[uid]:onRemoveBuff(uid)
	self.buffDic[uid]:disposeSelf()

	self.buffDic[uid] = nil
end

function FightEntityBuffMgr:updateBuff(buff)
	local uid = buff.uid

	if not self.buffDic[uid] then
		return
	end

	self.buffDic[uid]:onUpdateBuff(uid, buff)
end

function FightEntityBuffMgr:onDestructor()
	return
end

return FightEntityBuffMgr
