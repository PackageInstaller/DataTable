--卡牌剧情 基类
local this = {}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

--==============================--
--desc:
--time:2019-08-20 03:35:57
--@_cRoleId: 卡牌角色id
--@_cfg:  CfgCardRoleStory 单条数据
--@return 
--==============================--
function this:InitData(_cRoleId, _cfg)
	self.cRoleId = _cRoleId
	self.cfg = _cfg

	self:Check()
end

function this:GetCRoleId()
	return self.cRoleId
end

--剧情id （跳转）
function this:GetStoryId()
	return self.cfg.story_id
end

--模型id
function this:GetModuleId()
	return self.cfg.moduleId
end

--奖励
function this:GetRewards()
	if(self.rewards) then
		return self.rewards
	end
	self.rewards = {}
	local datas = self.cfg.rewards
	if(datas) then
		for i, v in ipairs(datas) do
			local data = {id = v[1], num = v[2], type = v[3]}
			table.insert(self.rewards, data)
		end
	end
	return self.rewards
end

--是否锁住
function this:GetIsLock()
	return self.isLock or false
end

--是否已完成
function this:GetIsSuccess()
	return self.isSuccess or false
end

--index
function this:GetIndex()
	return self.cfg.index
end

--锁住描述
function this:GetLockStr()
	return self.lockStr or ""
end

--是否有战斗
function this:GetHavWar()
	return self.cfg.war or false 
end

function this:GetIconName()
	return self.cfg.story_icon or nil 
end

function this:Check()
	self.isLock = true
	self.isSuccess = false
	
	local cRoleData = CRoleMgr:GetData(self.cRoleId)
	---是否锁住
	local unlock_id = self.cfg.unlock_id
	if(cRoleData == nil or unlock_id == nil) then
		self.isLock = false
	end
	local cfg = Cfgs.CfgCardRoleUnlock:GetByID(unlock_id)
	if(cfg) then
		if(unlock_id == 1) then
			self.isLock = cRoleData:GetLv() < cfg.value
		end
		self.lockStr = cfg.sDesc
	end
	---是否完成
	local unLockIds = cRoleData:GetStoryIds()
	for i, v in ipairs(unLockIds) do
		if(v == self.cfg.index) then
			self.isSuccess = true
		end
	end
end


return this 