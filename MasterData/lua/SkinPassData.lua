local this = {};

function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins;
end

-- 获取配置表数据
function this:Init(cfg)
    self.cfg = cfg
end

-- 获取协议数据
function this:SetData(v)
    self.data = v
end

-- 配置表
function this:GetCfg()
    return self.cfg
end

-- id
function this:GetID()
    return self.cfg and self.cfg.id
end

-- 名称
function this:GetName()
    return self.cfg and self.cfg.name
end

-- 图标
function this:GetIcon()
    return self.cfg and self.cfg.icon
end

-- 图标选中颜色
function this:GetIconCode()
    return self.cfg and self.cfg.imgColor
end

function this:GetSortIndex()
    return self.cfg and self.cfg.sort
end

function this:GetBaseID()
    return self.cfg and self.cfg.baseRewardID
end

function this:GetFullID()
    return self.cfg and self.cfg.fullRewardID
end

-- 界面配置
function this:GetViewCfg()
    if not self.viewCfg and self.cfg and self.cfg.viewId then
        self.viewCfg = Cfgs.CfgSkinPassInfo:GetByID(self.cfg.viewId)
    end
    return self.viewCfg
end
function this:GetRewardInfos()
    if not self.rewardInfos then
        local infos = {}
        local cfg1 = Cfgs.CfgSkinPassReward:GetByID(self:GetBaseID())
        if cfg1 and cfg1.item then
            for k, v in pairs(cfg1.item) do
                infos[v.level] = v
            end
        end
        local cfg2 = Cfgs.CfgSkinPassReward:GetByID(self:GetFullID())
        if cfg2 and cfg2.item then
            for k, v in pairs(cfg2.item) do
                if infos[v.level] and v.reward then
                    infos[v.level].fullReward = v.reward
                end
            end
        end
        self.rewardInfos = {}
        for k, v in pairs(infos) do
            table.insert(self.rewardInfos, v)
        end
        if #self.rewardInfos > 0 then
            table.sort(self.rewardInfos, function(a, b)
                return a.level < b.level
            end)
        end
    end
    return self.rewardInfos
end

-- 列表奖励
function this:GetShowRewardInfos(isDungeon)
    local infos = {}
    for i, v in ipairs(self:GetRewardInfos()) do
        if (not isDungeon and v.rewardType == 1) or (isDungeon and v.rewardType == 2) then
            table.insert(infos, v)
        end
    end
    return infos
end

function this:GetDungeonId(index)
    local showInfos = self:GetShowRewardInfos()
    local infos = self:GetRewardInfos()
    if infos and infos[#showInfos + index] and infos[#showInfos + index].group then
        return infos[#showInfos + index].group[1]
    end
end

function this:GetDungeonRewards(index)
    local rewardInfos = {}
    local cfg = Cfgs.MainLine:GetByID(self:GetDungeonId(index))
    if cfg and cfg.fisrtPassReward then
        for i, v in ipairs(cfg.fisrtPassReward) do
            local gData = GridFakeData({id = v[1],num = v[2],type = v[3]});
            table.insert(rewardInfos, {data = gData,elseData = {tag = ITEM_TAG.FirstPass}});
        end
    end
    local infos = self:GetShowRewardInfos(true)
    if infos and infos[index] and infos[index].fullReward then
        for k, m in ipairs(infos[index].fullReward) do
            local gData = GridFakeData({id = m[1],num = m[2],type = m[3]});
            table.insert(rewardInfos, {data = gData,elseData = {tag = ITEM_TAG.Other}});
        end
    end
    return rewardInfos
end

-- 模型表皮肤id
function this:GetSkinId()
    return self.cfg and self.cfg.skinId
end

-- 皮肤商品id
function this:GetSkinShopId()
    return self.cfg and self.cfg.skinshopId
end

-- 角色id
function this:GetRoleId()
    return self.cfg and self.cfg.roleId
end

-- 角色商品id
function this:GetRoleShopId()
    return self.cfg and self.cfg.roleshopId
end

-- 关卡组数据
function this:GetDungeonGroupData()
    if self.cfg and self.cfg.groupId then
        return DungeonMgr:GetDungeonGroupData(self.cfg.groupId)
    end
end

-- 等级
function this:GetLv()
    return self.data and self.data.lv or 0
end

-- 经验
function this:GetExp()
    local cur, max = self.data and self.data.exp or 0, 1
    local infos = self:GetRewardInfos()
    if infos and #infos > 0 then
        for i, v in ipairs(infos) do
            if (v.level - 1) == self:GetLv() then
                max = v.exp
                break
            end
        end
    end
    return cur, max
end

-- 开始时间
function this:GetStartTime()
    if self.cfg and self.cfg.begTime then
        return TimeUtil:GetTimeStampBySplit(self.cfg.begTime)
    end
    return 0
end

-- 结束时间
function this:GetEndTime()
    if self.cfg and self.cfg.endTime then
        return TimeUtil:GetTimeStampBySplit(self.cfg.endTime)
    end
    return 0
end

-- 对应下标的奖励是否已经领取
function this:IsRewardGet(index)
    local isGet1,isGet2 = false,false
    if self.data and self.data.gets then
        if self.data.gets[self:GetBaseID()] and self.data.gets[self:GetBaseID()].data then
            for i, v in ipairs(self.data.gets[self:GetBaseID()].data) do
                if v == index then
                    isGet1 = true
                    break
                end
            end
        end
        if self.data.gets[self:GetFullID()] and self.data.gets[self:GetFullID()].data then
            for i, v in ipairs(self.data.gets[self:GetFullID()].data) do
                if v == index then
                    isGet2 = true
                    break
                end
            end
        end
    end
    return isGet1,isGet2
end

function this:IsDungeonCanGet(index)
    if not self:IsBuy() then
        return false
    end
    local infos = self:GetShowRewardInfos(true)
    if infos and infos[index] then
        local _,isGet = self:IsRewardGet(infos[index].level)
        local dungeonData = DungeonMgr:GetDungeonData(infos[index].group[1])
        local isFinish = dungeonData and dungeonData:IsPass()
        if not isGet and isFinish then
            return true
        end
    end
    return false
end

-- 开启
function this:IsOpen()
    if self:GetStartTime() == 0 and self:GetEndTime() == 0 then -- 常驻
        return true
    end

    if TimeUtil:GetTime() >= self:GetStartTime() and TimeUtil:GetTime() < self:GetEndTime() then
        return true
    end

    return false
end

function this:IsFinish()
    -- 角色
    if RoleMgr:GetData(self:GetRoleId()) == nil then
        return false
    end
    -- 皮肤
    local skinInfo = RoleSkinMgr:GetRoleSkinInfo(self:GetRoleId(), self:GetSkinId())
    if not skinInfo or not skinInfo:CheckCanUseByMaxLV() then
        return false
    end
    -- 等级
    local infos = self:GetRewardInfos()
    if infos and infos[#infos].level > self:GetLv() then
        return false
    end
    -- 等级奖励
    if self:IsCanGetRed() then
        return false
    end
    -- 任务
    if not MissionMgr:IsTaskGet(eTaskType.SkinPass, self:GetID()) then
        return false
    end

    return true
end

function this:IsRed()
    local isRed = false
    if self:IsCanGetRed() then
        isRed = true
    elseif self:IsTaskRed() then
        isRed = true
    end
    return isRed
end

function this:IsCanGetRed()
    local infos = self:GetRewardInfos()
    if infos and #infos > 0 then
        local isGet1,isGet2 = false,false
        local isBuy = self:IsBuy()
        local dungeonData = nil
        for i, v in ipairs(infos) do
            if v.level and v.level <= self:GetLv() then
                isGet1,isGet2 = self:IsRewardGet(i)
                if v.rewardType == 1 then
                    if (not isGet1) or (isBuy and not isGet2) then
                        return true
                    end
                elseif v.rewardType == 2 and v.group and isBuy then
                    dungeonData = DungeonMgr:GetDungeonData(v.group[1])
                    if dungeonData and dungeonData:IsPass() and not isGet2 then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function this:IsTaskRed()
    if self:IsMaxLv() then
        return false
    end
    return MissionMgr:CheckRed2(eTaskType.SkinPass, self:GetID())
end

function this:IsBuy()
    local comm = ShopMgr:GetFixedCommodity(self:GetSkinShopId())
    return comm and comm:IsOver()
end

function this:IsMaxLv()
    local infos = self:GetRewardInfos()
    if infos and #infos > 0 then
        if infos[#infos].level then
            return self:GetLv() >= infos[#infos].level
        end
    end
    return false
end

-- 存在对应关卡
function this:HasDungeon(dungeonId)
    local info = self:GetRewardInfos()[#self:GetRewardInfos()]
    if info and info.group then
        for i, v in ipairs(info.group) do
            if dungeonId and dungeonId == v then
                return true
            end
        end
    end
    return false
end

return this
