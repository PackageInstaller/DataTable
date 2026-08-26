-- chunkname: @modules/logic/fight/mgr/FightEntrustedWorkMgr.lua

module("modules.logic.fight.mgr.FightEntrustedWorkMgr", package.seeall)

local FightEntrustedWorkMgr = class("FightEntrustedWorkMgr", FightBaseClass)

function FightEntrustedWorkMgr:onConstructor()
	self.workList = {}

	self:com_registMsg(FightMsgId.EntrustFightWork, self.onEntrustFightWork)
	self:com_registMsg(FightMsgId.GetEmptyWorkFromEntrustedWorkMgr, self.onGetEmptyWorkFromEntrustedWorkMgr)
end

function FightEntrustedWorkMgr:onEntrustFightWork(fightWorkItem)
	fightWorkItem.FIGHT_WORK_ENTRUSTED = true

	local parentRoot = fightWorkItem.PARENT_ROOT_OBJECT

	if parentRoot then
		local instantiateClassList = parentRoot.INSTANTIATE_CLASS_LIST

		if instantiateClassList then
			for i, v in ipairs(instantiateClassList) do
				if v == fightWorkItem then
					local obj = setmetatable({}, FightBaseClass)

					obj.class = FightBaseClass
					obj.PARENT_ROOT_OBJECT = parentRoot

					obj:ctor()

					instantiateClassList[i] = obj

					break
				end
			end
		end
	end

	table.insert(self.workList, fightWorkItem)
	FightMsgMgr.replyMsg(FightMsgId.EntrustFightWork, true)
end

function FightEntrustedWorkMgr:onGetEmptyWorkFromEntrustedWorkMgr()
	FightMsgMgr.replyMsg(FightMsgId.GetEmptyWorkFromEntrustedWorkMgr, self:com_registWork(FightEmptyWork))
end

function FightEntrustedWorkMgr:onDestructor()
	for i = #self.workList, 1, -1 do
		local workItem = self.workList[i]

		workItem.FIGHT_WORK_ENTRUSTED = nil

		workItem:disposeSelf()
	end
end

return FightEntrustedWorkMgr
