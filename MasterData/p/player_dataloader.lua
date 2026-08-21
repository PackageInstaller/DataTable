-- Desc: 玩家数据加载和处理数据

---@class Player
local Player = require "Player"
local GameGlobal
if GV.IsServer then
    GameGlobal = require "GameGlobal"
end

--玩家数据加载完成后处理
--数据加载后，内存中 有数据结构类型转换或者加载缓存数据的，可以在此加载转换
function Player:loadOver(isNew)

    ---@type UserInfo
    local userinfo = {}

    self:saveAccOpenId()
    ---------------------------------初始化数据-------------------------------
    --登陆时初始化任务信息
    self:missionInit(userinfo)

    --登录若是新的一天重置需要的数据
    self:resetDailyData(userinfo)

    self.curBattlLevelId = 0
    --初始化家园工作区数据
    self:initHomelandWorkArea()

    --登陆时刷新门票数据
    self:recoverNormalTicket(userinfo)

    --登陆时刷新过期道具数据
    self:updataTimeLimitItem(userinfo)

    --登陆时更新家园产出数据
    self:getConstructionReward(userinfo)

    --初始化更新玩家成就等级
    self:updateAchieveLevel(userinfo)

    --登陆时初始化事件列表
    self:affectionEventInit(userinfo)

    --初始社交数据
    self:initSocialInfo(isNew)

    --登录时检测普通商店数据
    self:checkGeneralShopData(userinfo)

    --登录时检测氪金商店数据
    self:loginCheckKJShopData()

    --初始化触发器数据
    self:initEventTriggerData(userinfo)

    --登录时检查更新功能开关配置
    self:checkFunctionOpenState(userinfo)

    ---检测天气系统
    self:CheckWeatherData(userinfo)

    self:CheckCycleCardData(userinfo)

    self:ClearAllHeroAction(userinfo)
    self:UpdateHomelandStorageItemData(true, userinfo)
    self:UpdateHomelandHeroOutLineAttribute(userinfo)
    self:UpdateHomelandBattleBoxData(userinfo)

    --引导数据检测
    self:checkGuideDataSafety()
    -- --检测cosUrl更新
    -- self:loginUpdateCosUrls()

    local TestOn = false

    --测试用增加物品 道具 装备
    if TestOn and not GV.IsServer then
        -- 英雄升级经验
        -- self:addResNumByType(110011, 9000000, userinfo, GE.EventItemType.Test, 0)
        -- self:addResNumByType(100004, 500000, userinfo, GE.EventItemType.Test, 0)
        -- self:addResNumByType(100006, 500000, userinfo, GE.EventItemType.Test, 0)
        --抽卡券
        self:addItem(110014, 50000, userinfo, GE.EventItemType.Test, 0)

        --测试+全角色
        local needRoleList = Config.GetAllConfig("CharacterTable")
        for _, data in pairs(needRoleList) do
            self:addPlayerHero(data.id, userinfo, GE.EventItemType.Test, 0)
        end

        local ItemList = Config.GetAllConfig("ItemTable")
        for _, data in pairs(ItemList) do
            self:addItem(data.id, 100000, userinfo, GE.EventItemType.Test, 0)
        end

        local EquipList = Config.GetAllConfig("EquipmentTable")
        for _, data in pairs(EquipList) do
            self:addPlayerEquip(data.id, userinfo, GE.EventItemType.Test, 0)
        end

        local WeaponList = Config.GetAllConfig("WeaponTable")
        for _, data in pairs(WeaponList) do
            self:addPlayerWeapon(data.id, userinfo, GE.EventItemType.Test, 0)
    	end
    end
end

--玩家登出时操作
function Player:loginOperation()
    --更新社交数据
    self:updateSocialInfo()

    --邮件收藏删除,退出登录后删除
    self:deleteMailCollect()
end

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--新玩家初始化，增加初始数据
function Player:newUserInitData()
    if tablex.size(self.heroList) >= 1 then
        return false
    end

    --新玩家增加初始舰娘数据
    for _, cid in pairs(Config.GetConfigInfo("InitialCharacter")) do
        self:addPlayerHero(cid, nil, GE.EventItemType.Init, 0)
    end

    --添加默认拥有头像
    for _, headId in pairs(Config.GetConfigInfo("HeadportraitStart")) do
        self:addhead(headId, nil, GE.EventItemType.Init, 0)
    end

    --添加默认拥有图纸
    for _, blueprintId in pairs(Config.GetConfigInfo("blueprintBasic")) do
        self:addItem(blueprintId, 1, nil, GE.EventItemType.Init, 0)
    end

    --新玩家默认增加额外奖励次数
    self:refreshExtraRewardsData(nil)

    --测试版添加初始资源
    local rewardList = {}
    for _, randomAwardId in pairs(Config.GetConfigInfo("InitialResource")) do
        rewardList = tablex.combine(rewardList, self:getRandomAward(randomAwardId))
    end
    self:addRewardList(rewardList, nil, GE.EventItemType.Init, 0)

    --测试版本根据配置提供满级武器
    local needMaxIdLIst = Config.GetConfigInfo("InitialLevelMaxWeapon")
    for _, needId in pairs(needMaxIdLIst) do
        for _, weaponData in pairs(self.weaponMap) do
            if weaponData.cid == needId then
                self:addWeaponExperience(weaponData.id, {{
                    id = 110010,
                    type = GE.RewardType.ItemProp,
                    num = 17,
                }})
                break
            end
        end
    end

    --测试版设置玩家等级
    self:addUserExp(Config.GetConfigInfo("InitialPlayerExp"))
    local WalkBoxCount = Config.GetConfigInfo("homeCharacterShowBase")
    local temp = {}
    for i = 1, WalkBoxCount do
        table.insert(temp, 0)
    end
    self:setHomeWalkHero(temp)
    return true
end

--转换初始的数据结构
function Player:transformInitialData()
    --self.xxx 找到指定字段的数据，判断是否有老的数据结构特点，转换为新的数据结构
    --to do...
    LuaLogger.ds("-------------------transformInitialData----------------")

    --为角色增加voiceType字段，默认为1（开发逻辑，上线删除）
    for _, heroData in pairs(self.heroList) do
        if heroData.voiceType then
            break
        end
        if not heroData.voiceType then
            heroData.voiceType = 1
        end
    end

    --给玩家杂项数据增加CharInitVoice字段，默认为1（开发逻辑，上线删除）
    if not self.userData.CharInitVoice then
        self.userData.CharInitVoice = 1
    end

    if self.formationMap then
        for _, formationData in pairs(self.formationMap) do
            if formationData.FormationList then
                formationData.FormationList = nil
            end
            if formationData.formationListData then
                formationData.formationListData = nil
            end
        end
    end

    --家园建筑互动奖励转换为掉落库
    if self.homeland and self.homeland.coveProps then
        for _, coveProps in pairs(self.homeland.coveProps) do
            local dropList = {}
            if coveProps.rewards then
                for _, reward in pairs(coveProps.rewards) do
                    if reward.id then
                        tablex.insertproxy(dropList, reward.id)
                    end
                end
                coveProps.rewards = nil
            end
            if not coveProps.dropList then
                coveProps.dropList = {}
            end
            if tablex.size(dropList) > 0 then
                coveProps.dropList = dropList
            end
        end
    end
end

function Player:saveAccOpenId()
    if not GV.IsServer then
        return
    end

    if not self.loginAccInfo then
        return
    end

    -- 用户数据
    ---@class UserData
    ---@field openId integer 登陆天数
    ---@field loginType integer 登录类型
    ---@field loginChannel integer 登录渠道

    self.userData.openId = self.loginAccInfo.openId
    self.userData.loginType = self.loginAccInfo.loginType
    self.userData.loginChannel = self.loginChannel
end

-----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--重置每日需要重置的数据
---@param userinfo UserInfo
function Player:resetDailyData(userinfo)
    if self.nextResetTime == 0 then
        self:setNextResetTime(userinfo)
        self.lastResetTime = self.nextResetTime - 24 * 3600
        --增加登陆天数
        self:setLoginDay(userinfo)
    elseif DLuaUtil.GetGreenwichTime() > self.nextResetTime then
        LuaLogger.ds("resetDailyData",self.uid,self.nextResetTime)
        local oldTime = self.lastResetTime
        self:setNextResetTime(userinfo)
        local isSameWeek = DLuaUtil.IsSameWeek(oldTime)
        local isSameMonth = DLuaUtil.IsSameMonth(oldTime)
        --重置各种数据方法

        --优先重置每日触发器计数，避免后续操作使用旧的计数值
        self:resetTriggerByTimeType(GE.EventTriggerlimitType.Daily ,userinfo)

        --周刷新
        if not isSameWeek then
            self:resetWeekData(userinfo)
        end

        if not isSameMonth then
            --重置月签到数据
            self:resetMonthSignData(userinfo)
        end

        --增加登陆天数
        self:setLoginDay(userinfo)

        --重置每日购买体力次数
        self:resetTodayBuyCount(userinfo)

        -- --重置每日送礼物提醒
        -- UnityEngine.PlayerPrefs.SetInt("giftTodayMsg", 0)

        --每日检测普通商店数据
        self:checkGeneralShopData(userinfo)

        --每日检测氪金商店数据
        self:dailyCheckKJShopData()

        --每日检测额外奖励更新
        self:refreshExtraRewardsData(userinfo)

        ---检测pve 关卡每日刷新次数
        self:CheckDailyPveLevelInfo(userinfo)

        --重置跑片数据
        self:reSetGenRoleFragData(userinfo)

        --签到更新
        self:updateSignData(userinfo)

        --图鉴迁移功能
        -- self:loginCheckHandbookMigration(userinfo)

        self:UpdateCovePropsData(userinfo)

        --检测活动是否已完成
        self:checkActivityIsCompleted(userinfo)

        --每日检测情报数据
        self:checkCombatIntelligence(userinfo)

        --每日检测对话数据
        self:checkHeroInteraction(userinfo)

        --重置繁荣度每日行为累计量
        self:resetDailyProsperityCount(userinfo)

        --重置分享数据
        self:resetShareData(userinfo)

        --通知公共服务每日刷新数据
        if GameGlobal then
            GameGlobal.NotifyPublicServiceDailyRefreshData(self.uid, self.lastResetTime)
        end
    end
end

--重置每周需要重置的数据
---@param userinfo UserInfo
function Player:resetWeekData(userinfo)
    --每周任务重置
    self:refreshMissionTypeTask(GE.MissionRefreshType.Weekly, userinfo)
    self:resetTriggerByTimeType(GE.EventTriggerlimitType.Weekly ,userinfo)
end

--重置每月需要重置的数据
---@param userinfo UserInfo
function Player:resetMonthSignData(userinfo)
    self:resetTriggerByTimeType(GE.EventTriggerlimitType.Monthly ,userinfo)
end

--设置下次刷新时间
---@param proto UserInfo
function Player:setNextResetTime(proto)
    self.lastResetTime = self.nextResetTime
    self.nextResetTime = DLuaUtil.GetNextResetTime(DLuaUtil.GetGreenwichTime(), tonumber(Config.GetConfigInfo("DailyResetTime")) * 3600)     --TODO: 
    if proto then
        proto.nextResetTime = self.nextResetTime
        proto.lastResetTime = self.lastResetTime
    end
end


-----------------------------------------------------------------------------------
--定时更新
-----------------------------------------------------------------------------------
--每秒钟执行一次
function Player:runOnce1Sec()
    local userinfo = {}
    --刷新体力(门票)数据
    if self.ticket then
        self:recoverNormalTicket(userinfo)
    end

    --刷新道具有时间限制的道具信息
    if self.itemMap then
        self:updataTimeLimitItem(userinfo)
    end

    --刷新派遣数据
    if self.dispatchData then
        self:refreshDispatchData(userinfo)
    end

    -- if self.isPutCosLog then
    --     self:updateCosUrls(userinfo)
    --     self.isPutCosLog = false
    -- end

    --更新活动数据
    if self.activityMap then
        self:updateActivityInfo(userinfo)
    end

    --若是新的一天重置需要的数据
    if self.nextResetTime then
        self:resetDailyData(userinfo)
    end

    if not tablex.empty(userinfo) then
        self:notifyDirect({ "user.UserInfoUpdate", { userinfo = userinfo } })
    end

end

--每10秒执行一次
function Player:runOnce10Sec()
    local userinfo = {}
    --刷新周期活动数据数据
    if self.regularActivityData then
        self:refreshRegularActivityData(userinfo)
    end

    self:writeServerLogSnapshot()
end

--每分钟(60秒)执行一次
function Player:runOnce60Sec()
    ---更新玩家在线时间
    self.lastonlinetime = DLuaUtil.GetGreenwichTime()

    local userinfo = {}

    --家园功能建筑产出收益
    if self.homeland then
        self:getConstructionReward(userinfo)
    end

    --更新角色数据
    if self.heroList then
        self:updateHeroData(userinfo)
    end

    if userinfo and not tablex.empty(userinfo) then
        self:notifyDirect({ "user.UserInfoUpdate", { userinfo = userinfo } })
    end

    -- --商店限时商品刷新
    -- self:refreshShopGoods(userinfo)
    -- --支付商品刷新
    -- self:CheckBeBuyGoodsTimeOut()
end


--每5分钟执行一次
function Player:runOnce5min()
    if GV.IsServer then
        self:CalcOnlineTime()
    end
end

--每10分钟执行一次
function Player:runOnce10min()
    --更新社交数据
    self:updateSocialInfo()
end

--每一个小时执行一次
function Player:runOnce1Hour()

end



return Player