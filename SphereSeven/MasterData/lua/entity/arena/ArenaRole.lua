---@class ArenaRole : Entity
---@field role_id number @ 角色id
---@field username string @ 名字
---@field rank number @ 排名
---@field score number @ 分数
---@field level number @ 等级
---@field portrait number @ 头像
---@field division number @ 段位
local ArenaRole = BaseClass("ArenaRole",Entity)
local base = Entity
local this = ArenaRole

---@param arenaRole protocol.ArenaRole
function this:Awake(arenaRole)
    base.Awake(self)
    --self.role = Game.Registry:NewObject("SocietyRole", friendInfo.role)

    self.roleId = arenaRole.role_id
	self.username = arenaRole.username
	self.rank = arenaRole.rank
	self.score = arenaRole.score
	self.level = arenaRole.level
	self.portrait = ""
	if Z_HeadPortrait[arenaRole.portrait] ~= nil then
		self.portrait = Z_HeadPortrait[arenaRole.portrait].Resourse
	end
	self.division = arenaRole.division
end

---@param arenaRole protocol.ArenaRole
function this:UpdateData(arenaRole)
    self.roleId = arenaRole.role_id
	self.username = arenaRole.username
	self.rank = arenaRole.rank
	self.score = arenaRole.score
	self.level = arenaRole.level
	self.portrait = ""
	if Z_HeadPortrait[arenaRole.portrait] ~= nil then
		self.portrait = Z_HeadPortrait[arenaRole.portrait].Resourse
	end
	self.division = arenaRole.division
end

function this.Dispose(self)
    base.Dispose(self)
end



return this