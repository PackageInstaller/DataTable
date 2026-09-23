-- OPENDEBUG(false)
------------------------------------------------
-- pvp战斗
PvpFightMgrBase = oo.class(FightMgrBase)

function PvpFightMgrBase:Init(id, groupID, ty, seed)
	FightMgrBase.Init(self, id, groupID, ty, seed)
	self.arrPrepare = {}
end

function PvpFightMgrBase:OnStart(data)
	local uid = data.uid
	self.arrPrepare[uid] = true
	for k, v in pairs(self.arrPlayer) do
		if not self.arrPrepare[uid] then
			return
		end
	end

	self.isStart = true
end

----------------------------------------------
-- 服务端管理器
PvpFightMgrServer = oo.class(PvpFightMgrBase)
function PvpFightMgrServer:Init(id, groupID, ty, seed)
	PvpFightMgrBase.Init(self, id, groupID, ty, seed)
end

-- 结束
function FightMgrServer:Over(stage, winer)
	LogDebug("FightMgrServer:Over")
	self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})
	FightMgrBase.Over(self, stage, winer)

	for uid, v in pairs(self.arrPrepare) do
		PvpMatchMgr:LeaveBattle(uid)
	end
	self:Destroy()
end

----------------------------------------------
-- 客户端管理器
PvpFightMgrClient = oo.class(PvpFightMgrBase)
function PvpFightMgrClient:Init(id, groupID, ty, seed)
	PvpFightMgrBase.Init(self, id, groupID, ty, seed)
end

----------------------------------------------
if IS_CLIENT then
	PvpFightMgr = PvpFightMgrClient
elseif IS_SERVER then
	PvpFightMgr = PvpFightMgrServer
end
