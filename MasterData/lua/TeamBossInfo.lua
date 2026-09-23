function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

function this:InitData(info, isStarting)
	self.info = info
	self.isStarting = isStarting
	self:InitCfg()
	--
	self.inviteDatas = {}--该房间邀请过的玩家
end


function this:InitCfg()
	local cfg = Cfgs.CfgTeamBoss:GetByID(self.info.cfgid)
	self.forceDelCd = cfg.forceDelCd
	self.cfg = cfg.infos[self.info.ix]
end

function this:GetData()
	return self.info
end

--是否是进行中的列表
function this:GetIsStarting()
	return self.isStarting
end

function this:GetId()
	return self.info.id
end

--id中的某一条数据
function this:GetCfg()
	return self.cfg
end

--创建者
function this:GetCreateId()
	return self.info.uid
end
--创建者信息
function this:GetCreateInfo()
	local roles = self:GetRoles()
	local uid = self:GetCreateId()
	for i, v in ipairs(roles) do
		if(v.uid == uid) then
			return v
		end
	end
	return nil
end

--自己的信息
function this:GetMyInfo()
	local roles = self:GetRoles()
	local uid = PlayerClient:GetID()
	for i, v in ipairs(roles) do
		if(v.uid == uid) then
			return v
		end
	end
	return nil
end

--创建时间
function this:CreateTime()
	return self.info.cTime
end

--血量
function this:GetHP()
	return self.info.curHp, self.info.maxHp
end

--房间状态
function this:GetState()
	return self.info.state
end

--玩家列表
function this:GetRoles()
	return self.info.teams
end
--房间总人数
function this:GetRolesCount()
	local roles = self:GetRoles()
	return roles and #roles or 0
end

--是否是限制房 (不会显示在公共列表)
function this:GetIsInvite()
	return self.info.isInvite
end

--难度
function this:GetDifficultIndex()
	return self.info.ix
end

--惩罚时间
function this:GetForceDelCd()
	return self.forceDelCd
end

-----------------------------------------------------------------------------------------------------
--记录已邀请的id
function this:RoomInviteRet(uid)
	self.inviteDatas[uid] = 1
end

--是否邀请过
function this:CheckIsInvite(uid)
	return self.inviteDatas[uid] ~= nil
end

--是否已在房间
function this:CheckIsIn(uid)
	local roles = self:GetRoles()
	for i, v in ipairs(roles) do
		if(v.uid == uid) then
			return true 
		end
	end
	return false
end

--有玩家离开房间
function this:LeaveRoomRet(uid)
	local roles = self:GetRoles()
	for i, v in ipairs(roles) do
		if(v.uid == uid) then
			table.remove(roles, i)
			break
		end
	end
end


return this 