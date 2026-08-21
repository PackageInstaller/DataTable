local BaseOtakuRoomData = BaseClass("BaseOtakuRoomData", require("DataCenter.BaseSubDataCenter"))
local M = BaseOtakuRoomData
local RoomStateLiveType = OtakuType.RoomStateLiveType
local OtakuRoomType = OtakuType.OtakuRoomType


-- 房间id
function M:RoomId()
    return self.m_RoomData.StudioId
end

-- 舱室名称
function M:Name()
    return self:ResConfig().name
end

-- 舱室图标
function M:Icon()
    return self:ResConfig().icon
end

-- 舱室类型
function M:Type()
    return self.m_RoomData.Type
end

-- 舱室等级
function M:Level()
    return self.m_RoomData.Level
end

-- 开始修建时间
function M:StartTick()
    return self.m_RoomData.BuildTick - self.m_BuildTime
end

-- 预计修建完成时间
function M:BuildTick()
    return self.m_RoomData.BuildTick - 1
end

-- 是否修建完成
function M:Builded()
    return GameUtil.GetCurTimeTick() >= self:BuildTick()
end

-- 入驻列表 RoleLive = { HeroId = 英雄id  Position = 入驻房间的坑位 }
function M:RoleLives()
    return self.m_RoomData.RoleLives or {}
end

-- 全部舱位状态 入驻改变会刷新在里面
function M:LiveSpace()
    return self.m_LiveSpace
end

-- 等级表 houseLevel
function M:LevelConfig()
    return self.m_LevelConfig
end

-- 资源表 houseRes
function M:ResConfig()
    return OtakuRoomDataMgr:GetInstance():GetHouseResByTypeIndex(self.m_RoomData.Type,self:RoomIndex()==0 and 1 or self:RoomIndex())
end

-- 最高等级
function M:MaxLevel()
    return self.m_MaxLevel
end

-- 升级需要材料
function M:NextUpCost()
    return self.m_LevelConfig[self:NextLevel()].levelCost, self.m_LevelConfig[self:NextLevel()].costNum
end

-- 入驻最大人数
function M:RoleLiveMaxNum()
    return self.m_LevelConfig[self:MaxLevel()].num
end

--当前入驻可配置最大人数
function M:RoleDeployMaxNum()
    return self.m_LevelConfig[self:Level()].num
end

-- 下一级入驻人数
function M:NextRoleDeployMaxNum()
    return self.m_LevelConfig[self:NextLevel()].num
end

-- 是否最高等级
function M:IsMaxLevel()
    return self:Level() >= self:MaxLevel()
end

-- 剩余建造时间
function M:RemainTime()
    if self:Builded() then
        return 0
    end

    return self:BuildTick() - GameUtil.GetCurTimeTick()
end

-- 建造时间
function M:BuildTime()
    local endTime = self:BuildTick()
    local startTime = self:StartTick()
    return endTime - startTime
end

-- 获取当前入驻人数
function M:CurRoleLiveNum()
    if not self.m_RoomData.RoleLives then
        return 0
    end

    return #self.m_RoomData.RoleLives
end

-- 获取当前入驻英雄Id
function M:CurRoleLiveHeros()
    if not self.m_RoomData.RoleLives then
        return {}
    end

    local heroId = {}
    for i,v in ipairs(self.m_RoomData.RoleLives) do
        table.insert( heroId, v.HeroId )
    end

    return heroId
end

-- 下一级 不超过最高级
function M:NextLevel()
    local maxLevel = self:MaxLevel()
    local nextLevel = self:Level() + 1

    if nextLevel >= maxLevel then
        return maxLevel
    end

    return nextLevel
end

--入驻舱室
function M:SettleType()
    local type = nil

    if self:Type() == OtakuRoomType.EST_Bridge then
        type = RoomStateLiveType.Bridge
    elseif self:Type() == OtakuRoomType.EST_Produce then
        type = RoomStateLiveType.Produce
    elseif self:Type() == OtakuRoomType.EST_Compose then
        type = RoomStateLiveType.Compound
    elseif self:Type() == OtakuRoomType.EST_Canteen or self:Type() == OtakuRoomType.EST_Kitchen then
        type = RoomStateLiveType.Cook
    end

    return type
end

-- 是否可以升级
function M:IsUpLevel()
    if self:IsMaxLevel() then
        return false
    end

    if self:Type() ~= OtakuRoomType.EST_Bridge then
        local level = OtakuRoomDataMgr:GetInstance():GetRoomCurUpLimitByType(self:Type())
        if self:Level() >= level then
            return false
        end
    end

    local costId, costNum = self:NextUpCost()
    for i, v in ipairs(costId) do
        if not GameHelper.CheckItem(v, costNum[i]) then
            return false
        end
    end
    return true
end

-- 是否有饱食度为0的英雄
function M:IsHaveHunger()
    if self:CurRoleLiveNum() <= 0 then
        return false
    end

    local roleLive = self:RoleLives()
    for i, v in ipairs(roleLive) do
        local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(v.HeroId)
        local eater = rshd:GetEater()
        if eater <= 0 then
            return true
        end
    end

    return false
end

-- 所有已入驻战员饱食度
function M:SettleRolesEater()
    local eaterNum = 0
    for _, v in ipairs(self:RoleLives()) do
        local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(v.HeroId)
        eaterNum = eaterNum + rshd:GetEater()
    end

    return eaterNum
end

-- 舱室Id
function M:RoomIndex()
    if self:Type() == OtakuRoomType.EST_Bridge or
        self:Type() == OtakuRoomType.EST_Survey then
        return 0
    end

    local roomsData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(self:Type())

    for index, roomData in pairs(roomsData) do
        if roomData:RoomId() == self:RoomId() then
            return index
        end
    end
end

-- 判断英雄是否入驻当前舱室
function M:_IsContainHero(heroId)
    local roles = self:RoleLives()

    for i = 1, #roles do
        if roles[i].HeroId == heroId then
            return true
        end
    end
    return false
end

-- 拿取选择的英雄位置
function M:GetSettleIndex()
    for i, v in ipairs(self.m_LiveSpace) do
        if v:Select() then
            return v:Position()
        end
    end
end

-- 拿取确定位置的英雄id
function M:GetLiveSpaceByIndex(position)
    return self.m_LiveSpace[position]
end

-- 拿取升级需要的材料
function M:GetUpgradeCost()
    local nextLevel = self:Level() + 1

    if nextLevel > self:MaxLevel() then
        return {}, {}
    end

    local cfg = self:LevelConfig()[nextLevel]
    return cfg.levelCost, cfg.costNum
end

function M:GetUpgradeConsumeData()
    local itemsData, coinData = {}, {}
    local itemIds, itemNums = self:GetUpgradeCost()

    for i = 1, #itemIds do
        local itemId = itemIds[i]
        local itemNum = itemNums[i]

        if (i == 1) and (itemId == 1) then
            -- 第一个为金币道具
            coinData.itemId = itemId
            coinData.itemNum = itemNum
        else
            table.insert(itemsData, {
                itemId = itemId,
                itemNum = itemNum,
                numType = ItemNumberType.BALANCE
            })
        end
    end
    return itemsData, coinData
end

-- 拿取解锁的数量
function M:GetUnlockLiveSpaceNum()
    local num = 0
    for k, v in pairs(self.m_LiveSpace) do
        if not v:IsLock() then
            num = num + 1
        end
    end
    return num
end

-- 拿取当前已有入驻的舱室
function M:GetLiveSpaceUpRoleNum()
    local liveSpace = {}
    for k, v in pairs(self.m_LiveSpace) do
        if v:IsUp() then
            liveSpace[#liveSpace + 1] = v
        end
    end
    return liveSpace
end

-- 房间是否停产 目前只加在制造仓里 其他的需要重写此方法
function M:IsRoomStop()
    return false
end

-- 更新选择信息
function M:UpdateSettleSelect(index)
    if not index then
        self:_UnSelectRoleLive()
    else
        self:_UpdateRoleLiveSelect(index)
    end
end

-- 更新基础信息
function M:Update(studioRoom, netUpdateType)
    self.m_RoomData = studioRoom
    self:OnUpdate(netUpdateType)

    if netUpdateType == OtakuType.NetUpdateType.Garrison then
        self:_RemoveAllRoleLive()
        self:_RefreshRoleLive()
        self:_NextSettleSelect()
        EventMgr:Broadcast(UIMessageNames.OTAKU_SETTLE_UPDATE, self:RoomId())
    elseif netUpdateType == OtakuType.NetUpdateType.CancelGarrison then --取消入驻
        self:_RemoveAllRoleLive()
        self:_RefreshRoleLive()
        EventMgr:Broadcast(UIMessageNames.OTAKU_SETTLE_UPDATE, self:RoomId())
    elseif netUpdateType == OtakuType.NetUpdateType.Upgrade then
        self:_RefreshLiveSpace()
        EventMgr:Broadcast(UIMessageNames.OTAKU_UPGRADE, self:RoomId())
    end
end

-- 数据结构说明
-- StudioId = 房间id
-- Name = 舱室名称
-- Type = 3 舱室类型
-- Level = 4 舱室等级
-- BuildTick = 5 预计修建完成时间
-- RoleLives = 6 入驻列表
function M:Init(studioRoom)
    self.m_RoomData = studioRoom
    self.m_LevelConfig = OtakuRoomDataMgr:GetInstance():GetHouseLevelByType(self.m_RoomData.Type)
    --self.m_ResConfig = OtakuRoomDataMgr:GetInstance():GetHouseResByTypeIndex(self.m_RoomData.Type,self:RoomIndex())
    self.m_BuildTime = GameHelper.GetParamter(118)
    self.m_MaxLevel = #self.m_LevelConfig
    self.m_LiveSpace = {}
    self:_InitLiveSpace()
    self:_RefreshRoleLive()
    self:OnInit()
end

-- 以下是内部方法
function M:_InitLiveSpace()
    local maxDeployNum = self:RoleDeployMaxNum()
    local maxSettleNum = self:RoleLiveMaxNum()
    local roomId = self:RoomId()
    local settleType = self:SettleType()

    local ctrl = require("DataCenter.Otaku.OtakuRoomLiveSpace")
    for i = 1, maxSettleNum do
        local data = ctrl.New()
        data:Init(i, roomId, settleType, self.m_LevelConfig)

        local lock = i > maxDeployNum
        if not lock then
            data:UnLock()
        end

        self.m_LiveSpace[i] = data
    end
end

function M:_RefreshLiveSpace()
    local maxDeployNum = self:RoleDeployMaxNum()

    for i, v in ipairs(self.m_LiveSpace) do
        local lock = i > maxDeployNum
        if not lock and v:IsLock() then
            v:UnLock()
        end
    end
end

function M:_RefreshRoleLive()
    local roleLive = self:RoleLives()

    for i, v in ipairs(roleLive) do
        local index = v.Position
        self.m_LiveSpace[index]:UpHero(v)
    end
end

function M:RemoveRoleLive(index)
    -- 餐厅不走这个流程
    if self:Type() == OtakuRoomType.EST_Canteen then
        return
    end

    self.m_LiveSpace[index]:RemoveHero()
end

function M:_RemoveAllRoleLive()
    for i, v in ipairs(self.m_LiveSpace) do
        v:RemoveHero()
    end
end

function M:_UpdateRoleLiveSelect(index)
    local liveSpace = MapUtil.Find(self.m_LiveSpace, function(v) return v:Position() == index end)
    liveSpace:SetSelect(not liveSpace:Select())
end

function M:_UnSelectRoleLive()
    for _, v in ipairs(self.m_LiveSpace) do
        v:SetSelect(false)
    end
end

function M:_NextSettleSelect()
    self:_NextOtherSelect()
end

function M:_NextOtherSelect()
    local num = #self.m_LiveSpace
    for i = 1, num do
        local liveSpace = self.m_LiveSpace[i]

        if i == num then
            return
        end

        if self.m_LiveSpace[i + 1]:IsLock() then
            return
        end

        if liveSpace:Select() and i ~= num then
            liveSpace:SetSelect(false)
            self.m_LiveSpace[i + 1]:SetSelect(true)
            return
        end
    end
end

function M:OnDispose()
    self:OnDestory()
end

-- 初始化需要继承接口
function M:OnInit()
end

-- 更新需要继承接口
function M:OnUpdate()
end

-- 删除需要继承接口
function M:OnDestory()
end

return BaseOtakuRoomData
