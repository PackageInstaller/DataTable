
---@class Pass : Entity
---@field id number @
---@field progress number @ 经验
---@field status number @ 状态constant.PassStatus
---@field normal_received_stage number @ 普通奖励领取到哪一阶段
---@field special_received_stage number @ 高级奖励领取到哪一阶段
---@field membership number @ 权限级别(constant.PassMembership)
---@field oldLevel number @ 上次更新时的等级(用于判断是否升级)
---@field level number @ 当前等级
---@field currentExp number @ 当前经验
local Pass = BaseClass("Pass",Entity)
local base = Entity
local this = Pass

---@param self Pass
local function CheckLevel(self)
    self.oldLevel = self.level
    self.level = self.progress // self.config.ProgressPerStage
    self.currentExp = self.progress % self.config.ProgressPerStage

    if self.level > self.normal_received_stage then
        self.canReceiveNormal = true
    else
        self.canReceiveNormal = false
    end

    if self.membership == PassMembership.PassMembershipSpecial or self.membership == PassMembership.PassMembershipPremium then
        if self.level > self.special_received_stage then
            self.canReceiveSpecial = true
        else
            self.canReceiveSpecial = false
        end
    else
        self.canReceiveSpecial = false
    end
end

---@param pass protocol.Pass
function this:Awake(pass)
    base.Awake(self)

    self.oldLevel = nil
    self.level = nil
    self.currentExp = nil
    self.canReceiveNormal = nil
    self.canReceiveSpecial = nil

    self.id = pass.id --
	self.progress = pass.progress -- 经验
	self.status = pass.status -- 状态constant.PassStatus
	self.normal_received_stage = pass.normal_received_stage -- 普通奖励领取到哪一阶段
	self.special_received_stage = pass.special_received_stage -- 高级奖励领取到哪一阶段
	self.membership = pass.membership -- 权限级别(constant.PassMembership)

    self.config = Z_Pass[self.id]

    CheckLevel(self)
end

---@param pass protocol.Pass
function this:UpdateData(pass)
    self.id = pass.id
    self.progress = pass.progress
    self.status = pass.status
    self.normal_received_stage = pass.normal_received_stage
    self.special_received_stage = pass.special_received_stage
    self.membership = pass.membership

    CheckLevel(self)
end

function this.Dispose(self)
    base.Dispose(self)
end



return this