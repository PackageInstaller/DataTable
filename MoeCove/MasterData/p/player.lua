-- Desc: 玩家类
require "luaext"
local utf8util = require "utf8util"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end
-- require "user_proto_define"

---@class Player
local Player = class("Player")


--邮件收藏信息
---@class MailCollectInfo
---@field mailId integer 邮件ID
---@field state boolean 邮件状态
---@field pathKey string 路径key
---@field tempUrl? string 临时url
---@field periodEnd? integer 过期时间

--cos上传信息
---@class CosPutInfo
---@field pathKey string 上传路径
---@field tempUrl? string 临时url
---@field periodEnd? integer 过期时间

--抽卡记录数据
---@class GachaRecordData
---@field count integer 上传次数
---@field pathkeyList table<integer, CosPutInfo> cos上传信息
---@field recordList GachaRecord[] 抽卡记录

---@class GachaData
---@field countMap table<integer, GachaCountInfo> 卡池计数组数据
---@field recordData GachaRecordData 抽卡记录
---@field guarantMap table<integer, GachaGuarantInfo> 卡池保底次数

function Player:ctor()
    ---@type integer
	self.aid = nil			-- 游戏帐号id
    ---@type integer
	self.uid = nil			-- 帐号内角色id > 40000 为玩家
    ---@type integer
    self.platid = nil       -- 平台id
    ---@type integer
	self.icon = nil			-- icon
    ---@type string
	self.name = nil			-- 角色名
    ---@type string
	self.serverChannel = nil			-- 服务器渠道
    ---@type integer
	self.head = nil			-- 头像
    ---@type integer
	self.exp = nil			-- 经验
    ---@type integer
	self.level = nil		-- 等级
    ---@type integer
	self.borntime = nil		-- 创建时间
    ---@type integer
	self.lastlogintime = nil	-- 最后登录时间
    ---@type integer
	self.lastonlinetime = nil	-- 最后在线时间
    ---@type integer
	self.lastofflinetime = nil	-- 最后离线时间
    ---@type integer
	self.nextResetTime = nil	-- 下次重置时间
    ---@type integer
	self.lastResetTime = nil	-- 上次重置时间
    ---@type integer
	self.servertime = nil	-- 服务器时间
    ---@type integer
    self.zoneId = nil      -- 区服ID

    ---@type table<integer, HeroInfo>
	self.heroList = nil		-- 英雄列表

    ---@type table<integer, FormationData>
	self.formationMap = nil -- 阵型

    ---@type table<integer, ItemInfo>
	self.itemMap = nil		-- 物品

    ---@type TicketInfo
	self.ticket = nil		-- 体力

    ---@type table<integer, EquipInfo>
	self.equipMap = nil		-- 装备

    ---@type table<integer, PveLevelInfo>
	self.pveLevelMap = nil	-- pve关卡

    ---@type HomeLandinfo
	self.homeland = nil		-- 家园

    ---@type TechnologyTreeInfo
    self.technologyTree = nil	-- 科技树

    ---@type table<integer, TechnologyTreeNodeInfo[]>
    self.techTreeNodeInfoMap = nil  -- 科技树节点信息

    ---@type table<integer, WeaponInfo>
	self.weaponMap = nil	-- 武器

    ---@type table<integer, MissionInfo>
	self.missionList = nil	-- 任务列表

    ---@type UserData
	self.userData = nil		-- 用户数据

    ---@type table<integer, HandbookInfo>
	self.handbookData = nil	-- 图鉴数据

    ---@type boolean
	self.handbookMigrated = nil	-- 图鉴数据是否已迁移

    ---@type table<integer, SkinInfo>
	self.skinList = nil		-- 皮肤列表

    ---@type PosterData
	self.posterData = nil	-- 海报数据

    ---@type GachaData
	self.gachaData = nil	-- 卡池总信息

    ---@type table<integer, HeadData>
	self.headList = nil		-- 头像列表

    ---@type UserOnlyServerData 用户只在服务器上保存的数据
    self.onlyServerData = nil

    ---@type integer
    self.mailLastStamp = nil	-- 上次邮件时间戳

    ---@type table<integer, MailInfo>
    self.mails = nil		-- 邮件列表

    ---@type FormationInfo
    self.formation = nil			-- 阵容

    ---@type table<integer, ChapterAwardInfo>
    self.chapterAwardMap = nil    -- 章节奖励领取记录

    ---@type table<integer, MailCollectInfo>
    self.mailCollect = nil	-- 邮件收藏

    ---@type GeneralShopData
    self.generalShopData = nil	-- 普通商店数据

    ---@type table<integer, GoodsInfo>
    self.premiumShopMap = nil	-- 充值商城数据

    ---@type table<integer, integer>
    self.recordWaitOrderInfo = nil	-- 记录等待的订单信息

    --GM相关变量
    ---@type integer
    self.gmLevel = 0                --GM等级
    ---@type table
    self.workOrder = nil            --工单

    self.qnaireMap = nil    -- 问卷调查数据 key:问卷ID

    ---@type table<integer, ActivityInfo>
    self.activityMap = nil    -- 活动数据 key:活动ID

    ----------------------------------------------------------------------------
    ---@type integer
    self.yearsOld = nil		-- 年龄

    ---@type integer
    self.channel = nil		-- 渠道

    ---@type integer
    self.deviceType = nil	-- 设备类型

    ---@type boolean
    self._first_pay = false		--登录后是否首次支付

    --不保存到数据库的数据
    ---@type Random
    self.commonRandom = nil  -- 通用随机

    ---@type table<integer, integer[]>
    self.triggerList = {}    -- 任务触发列表

    ---@type table<integer, integer[]>
    self.LockList = {}

    ---@typoe table<integer, integer> 数数相关的统计信息
    self.shushuPresetProperties = nil

    ---@type boolean 是否进入场景
    self.isEnterScene = false

    ---@type integer 面板类型(不知道为啥要这个？)
    self.panelType = nil

    ---@type Player[] 多角色列表，但是，事实上，只有一个角色
    self.userList = nil

    ---@type boolean 是否加载完成
    self.isLoaded = false

    ---@type BattleStartInfo 战斗开始信息
    self.battleStartInfo = nil

    ---@type AffectionDataInfo 好感度数据
    self.affectionData = nil

    ---@type table<integer, integer> 新手引导数据
    self.guideInfoMap = nil

    self.limitTimeGoods = nil	-- 限时商品数据

    ---@type table<integer, integer[]> 按时刷新列表
    self.timeLimitList = {}

    ---@type table<integer, integer[]> 事件触发器列表 key:事件ID, value:触发器ID
    self.eventTriggerList = {}

    ---@type RegularActivityInfo 周期活动数据
    self.regularActivityData = nil

    ---@type table<integer, ExtraRewardsInfo> 额外奖励数据
    self.extraRewardsMap = nil

    ---@type table<integer, integer> 功能开启状态列表
    self.funtionOpenMap = {}

    ---@type table<string, string> 自定义数据
    self.userDefined = {} -- 自定义数据


    ---@type WeatherForecastData 天气系统
    self.weatherForecastData = nil  -- 天气系统

    ---@type table<integer, CycleCardData> 周期卡数据
    self.cycleCardDatas = nil  -- 周期卡数据


    ---@type table<integer, FriendInfo>   好友列表
    self.friends = {}

    ---@type table<integer, FriendInfo>   推荐好友
    self.suggestFriends = {}

    ---@type table<integer, FriendInfo>   请求列表
    self.requestFriends = {}

    ---@type table<integer, FriendInfo>   搜索列表
    self.searchFriends = {}

    ---@type table<integer, integer> 友情点赠送 uid => time
    self.friendPointGive = {}
    ---@type table<integer, boolean> 友情点领取 uid => bool 是否领取过友情点
    self.friendPointGet = {}


    ---@type integer[]  自己申请列表
    self.selfRequestTab = {}

    self.isPutCosLog = false  -- 是否上传cos日志

    ---@type table<integer, PassData>
    self.passDataMap = nil  -- 通行证数据

    ---@type table<integer, SignInfo> 签到数据
    self.signData = {}

    ---@type table<integer, MiniPassInfo> 简易通行证数据
    self.miniPassMap = {}  -- 简易通行证数据

    ---@type table<integer, CombatIntelligenceInfo> 情报数据
    self.combatIntelligenctInfo = {}  -- 情报数据

    ---@type table<integer, ShareInfo> 分享数据
    self.shareMap = {}  -- 分享数据

    ---@type integer
    self.curBattlLevelId = 0
end

--------------------------------------
--设置随机种子
function Player:setRandomSeed(seed)
	self.commonRandom = require "Random":new(seed)        -- 通用随机
end

--获取随机种子
function Player:getRandom()
	return self.commonRandom
end

function Player:calcProp()
end

--创建角色结构
---@param aid integer
---@param ip string
---@param payload table
---@return Player
function Player:createUserStructure(aid, ip, payload)
    local new_user = CommonLogic.LoadPlayerInitSettings()
    new_user.aid = aid
    new_user.borntime = luautil.getGmtStamp()

    new_user.name = payload.name
    new_user.head = payload.head
    new_user.sex = payload.sex

    return new_user
end

--设置渠道号
---@param channel integer
---@param deviceType integer
---@param deviceSubType integer
function Player:setChannel(channel, deviceType, deviceSubType)
	self.channel = GF.loginChannelTransition and GF.loginChannelTransition(channel) or channel
	self.deviceType = deviceType
    self.deviceSubType = deviceSubType
end

----------------------------------------------------------------------------

--添加玩家经验值
---@param expCount integer
---@param proto table
function Player:addUserExp(expCount, proto)
    if not expCount or expCount < 1 then
        return ActionFailReason.ParameterInvalid
    end

    local nowLevel = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.user, self.level)
    if not nowLevel then
        return ActionFailReason.CfgNotFind
    end

    --等级已满无法获得经验
    if nowLevel.max_level == self.level and self.exp >= nowLevel.exp_sum then
        return ActionFailReason.UserLevelMax
    end

    self.exp = self.exp + expCount

    --获得经验后判断是否升级
    local levelDataList = Config.GetLevelconfigInfoByType(GE.LevelDataType.user)
    local newLevel = self.level
    for _, v in pairs(levelDataList) do
        if v.level > newLevel and self.exp >= v.exp_sum then
            newLevel = v.level
        end
    end

    --升级
    if newLevel > self.level then
        --恢复体力
        for i = (self.level + 1), newLevel do
            local newLevelCfg = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.user, i)
            if not newLevelCfg then
                return ActionFailReason.CfgNotFind
            end
            self:addNormalTicket(newLevelCfg.apRestore, nil, GE.EventItemType.UserLevelUp, 0)
        end
        proto.ticket = self:getTicketData()

        self.level = newLevel
        self:missionTrigger(GE.MissionFinishType.UserLevel, {newLevel = self.level}, proto)
        self:FunctionOpenTrigger(GE.CommonLockJudgeType.UserLevel, proto) -- 玩家等级提升触发功能开放

        --更新社交数据
        self:socialUpdateLevel(newLevel)
    end

    if proto then
        proto.exp = self.exp
        proto.level = self.level
    end

    return ActionFailReason.None
end

--获取玩家昵称
---@return string
function Player:getUserName()
    return self.name
end

--获取玩家等级
---@return integer
function Player:getUserLevel()
    return self.level
end

--获取玩家经验
---@return integer
function Player:getUserEXP()
    return self.exp
end

--根据角色ID获取头像
---@param headId integer
---@return HeadData
function Player:getHeadById(headId)
    return self.headList[headId]
end

--获取当前头像
---@return integer
function Player:getCurHead()
    return self.head
end

--获得玩家其他数据
---@return UserData
function Player:getUserData()
    return self.userData
end

--获取玩家临时数据
function Player:getUserTempData()
    local userData = self:getUserData()
    if not userData then
        return
    end

    if not userData.tempData then
        userData.tempData = {}
    end

    return userData.tempData
end

--获取玩家只在服务器上保存的数据
---@return UserOnlyServerData
function Player:getOnlyServerData()
    return self.onlyServerData
end

--获取玩家注册至今的天数（至少为1天）
---按照每日刷新时间计算，每过一个刷新点算一天
---@return integer 注册至今的天数
function Player:getRegisteredDayCount()
    local borntime = self.borntime or 0
    if borntime == 0 then
        return 1  -- 如果没有注册时间，返回1天
    end

    local currentTime = DLuaUtil.GetGreenwichTime()
    local dailyResetTime = Config.GetConfigInfo("DailyResetTime")

    -- 获取注册时的刷新点时间
    local bornResetTime = DLuaUtil.GetCurInitiationTime(borntime, nil, dailyResetTime)
    -- 获取当前的刷新点时间
    local currentResetTime = DLuaUtil.GetCurInitiationTime(currentTime, nil, dailyResetTime)

    -- 计算跨过的刷新点数量（天数）
    local diffSeconds = currentResetTime - bornResetTime
    local days = math.floor(diffSeconds / 86400) + 1

    return math.max(1, days)
end

--更换头像
---@param headId integer
---@param proto UserInfo
---@return ActionFailReason
function Player:setUserHead(headId, proto)
    if not self.headList[headId] then
        return ActionFailReason.HeadNothas
    end

    self.head = headId

    --更新社交数据
    self:socialUpdateHead(headId)

    if proto then
        proto.head = headId
    end

    return ActionFailReason.None
end

--刷新头像数据
---@param data HeadData[]
function Player:updateHeadData(data)
    for key, value in pairs(data) do
        self.headList[key] = value
    end
end

--添加头像
---@param headId integer
---@param proto UserInfo?
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail integer 产出消耗渠道详细内容
---@return ActionFailReason
function Player:addhead(headId, proto, balance_channel_id, balance_channel_detail)
    local headCfg = Config.GetHeadportraitInfo(headId)
    if not headCfg then
        return ActionFailReason.CfgNotFind
    end

    if self.headList[headId] then
        return ActionFailReason.HeadAlready
    end

    self.headList[headId] = {
        getTime = luautil.getGmtStamp(),
    }

    --添加日志
    if DataLogMgr then
        DataLogMgr.LogPokedexAdd({
            pokedexId = headId,
            type = "head",
            balance_channel_id = balance_channel_id,
            balance_channel_detail = balance_channel_detail,
        }, self)
    end

    if proto then
        if not proto.headList then
            proto.headList = {}
        end
        proto.headList[headId] = self.headList[headId]
    end

    return ActionFailReason.None
end

--修改玩家昵称
---@param newName string
---@param ip string IP地址
---@param proto UserInfo
---@return ActionFailReason
function Player:setUserName(newName, ip, proto)
    --入参检测
    if not newName or string.len(newName) <= 0 then
        return ActionFailReason.ParameterInvalid
    end

    --无效修改
    if self.name == newName then
        return ActionFailReason.None
    end

    --去除两端空白
    newName = newName:trim()

    local ok, reason = self:CheckUserName(newName, GE.NameChangeType.ChangeUserName, ip)
    if not ok then
        return reason
    end

    self.name = newName

    --更新社交数据
    self:socialUpdateUserName(newName)

    if proto then
        proto.name = newName
    end

    return ActionFailReason.None
end

--请求更换签名
---@param signTxt string
---@param ip string IP地址
---@param proto UserInfo
---@return ActionFailReason
function Player:setUserSign(signTxt, ip, proto)
    --签名允许为空
    signTxt = signTxt or ""

    --去除两端空白
    signTxt = signTxt:trim()

    --无效修改
    if self.userData.UserSign == signTxt then
        return ActionFailReason.None
    end

    if signTxt ~= "" then
        local ok, reason = self:CheckUserName(signTxt, GE.NameChangeType.ChangeUserSign, ip)
        if not ok then
            return reason
        end
    end

    self.userData.UserSign = signTxt

    --更新社交数据
    self:socialUpdateUserSign(signTxt)

    if proto then
        if not proto.userData then
            proto.userData = {}
        end
        proto.userData.UserSign = signTxt
    end

    return ActionFailReason.None
end

--修改记录的引导id
---@param groupId integer
---@param guideId integer
---@return ActionFailReason
---@return table<integer, integer>
function Player:changeGuideIdByGroupId(groupId, guideId)
    --参数判空
    if not groupId or not guideId then
        return ActionFailReason.ParameterInvalid, {}
    end
    --检测id对应性
    local guideInfo = Config.GetGuideMainInfo(guideId)
    if not guideInfo then
        return ActionFailReason.CfgNotFind, {}
    end
    if guideInfo.Group ~= groupId then
        return ActionFailReason.ParameterInvalid, {}
    end
    self:setGuideIdByGroupId(groupId, guideId)
    return ActionFailReason.None, self:getGuideInfoMap()
end

---获取新手引导信息
---@return table<integer, integer>
function Player:getGuideInfoMap()
    return self.guideInfoMap
end

--TODO: 暂时不用，后续再优化
-- ---通过groupId获取新手引导数据
-- ---@param groupId integer
-- ---@return integer
-- function Player:getGuideDataByGroupId(groupId)
--     if isnumber(groupId) then
--         return 0
--     end
--     local guideInfoMap = self:getGuideInfoMap()
--     if not guideInfoMap[groupId] then
--         guideInfoMap[groupId] = 0
--     end
--     return guideInfoMap[groupId]
-- end

--设置新手引导的信息
---@param groupId integer
---@param guideId integer
function Player:setGuideIdByGroupId(groupId, guideId)
    local guideInfoMap = self:getGuideInfoMap()
    guideInfoMap[groupId] = guideId
end

--初始化修改玩家记录的引导id(当玩家错过引导时后端进行检测，赋值为最新的引导id)
function Player:checkGuideDataSafety()
    local guideMainList = Config.GetAllConfig("GuideMainTable")
    if not guideMainList then
        return
    end

    local guideInfoMap = self:getGuideInfoMap()

    for _, guideEntry in pairs(guideMainList) do
        local conditions = guideEntry.Condition
        -- 只处理有通过条件的条目
        if conditions and tablex.size(conditions) > 0 then
            local groupId = guideEntry.Group
            local currentGuideId = guideInfoMap[groupId] or 0
            -- 只处理id比当前记录更大的条目
            if guideEntry.id > currentGuideId then
                local conditionMet = true
                for _, condition in ipairs(conditions) do
                     if condition[1] == 1 then
                        -- 条件类型1：通关指定关卡（completeNum > 0 表示已通关）
                        local levelId = condition[2]
                        local levelData = self.pveLevelMap and self.pveLevelMap[levelId]
                        if not levelData or levelData.completeNum <= 0 then
                            conditionMet = false
                            break
                        end
                    end
                end
                if conditionMet then
                    self:setGuideIdByGroupId(groupId, guideEntry.id)
                end
            end
        end
    end
end

--设置自定义数据
--@param {string} info
function Player:SetUserDefined(info, proto)
    if not info or string.len(info) <= 0 then
        return ActionFailReason.ParameterInvalid
    end

	local maxLen = 200*1024
    -- if string.len(info) > maxLen then
    --     return ActionFailReason.userDefinedTooLong
    -- end

    local jsonstr = luautil.serialize(self.userDefined)
    if string.len(jsonstr) + string.len(info) > maxLen then
        return ActionFailReason.userDefinedTooLong
    end

	local temp = luautil.unserialize(info)
    for k, v in pairs(temp) do
        self.userDefined[k] = v
    end

	proto.userDefined = self:propToProto("userDefined")
	return ActionFailReason.None
end

--检测用户名称
---@param name string
---@param scene NameChangeType
---@param ip string
---@return boolean
---@return ActionFailReason
function Player:CheckUserName(name, scene, ip)
    if not name or string.len(name) <= 0 then
        return false, ActionFailReason.NameEmpty
    end

    --机器人测试不检测敏感字
    if GV.IsServer and GF.robotTest() then
        return true, ActionFailReason.None
    end

    local utf8util = require "utf8util"

    if utf8util.len(name) <= 0 then
		return false, ActionFailReason.NameTooShort
	end

    --如果是签名，则长度限制为99，其他为7，todo: 配置
    local maxLen = 7
    if scene == GE.NameChangeType.ChangeUserSign then
        maxLen = 99
    end
	if utf8util.len(name) > maxLen then
		return false, ActionFailReason.NameTooLong
	end

    -- 不能有空白字符、标点符号、emoji
	-- 看不少人还是会起类似Mr.这种名字的，所以只是引号以及反斜杠不让用了
	local findPoint = name:find("['\"\\]")
	if findPoint or utf8util.hasEmoji(name) then
		return false, ActionFailReason.NameContainsInvalidChar
	end

    --如果不是签名，检测名称合法性
    if scene ~= GE.NameChangeType.ChangeUserSign then
        --允许中文多区 + 数字 + 大小写字母 + 常用符号
        if not utf8util.isNameLegal(name) then
            return false, ActionFailReason.NameNotLegal
        end
    end

    --敏感字检测
    local ForbiddenWords = require "ForbiddenWords"
    local res = ForbiddenWords.ContainsForbiddenWord(name)
    if res then
        if DataLogMgr then
            DataLogMgr.LogSensitiveWord(
                {
                    content = name,
                    scene = scene,
                    ip = ip,
                },
                self
            )
        end
        return false, ActionFailReason.NameContainsInvalidChar
    end

    return true, ActionFailReason.None
end


function Player:Clear()

    self.friends = {}
    self.suggestFriends = {}
    self.requestFriends = {}
    self.searchFriends = {}
    self.friendPointGive = {}
    self.friendPointGet = {}
    self.selfRequestTab = {}

end

--记录日志快照
---@param snapshotType GE.LogSnapshotType
---@param id integer
---@param data table
---@return boolean
function Player:recordServerLogSnapshot(snapshotType, id, data)
    if not GV.IsServer or not snapshotType 
     or snapshotType < GE.LogSnapshotType.hero 
     or snapshotType >= GE.LogSnapshotType.max then
        return false
    end

    if not  self._serverLogSnapshotRecord then
        self._serverLogSnapshotRecord = {}
    end
    if not self._serverLogSnapshotRecord[snapshotType] then
        self._serverLogSnapshotRecord[snapshotType] = {}
    end

    self._serverLogSnapshotRecord[snapshotType][id] = data
    return true
end

--写日志快照
function Player:writeServerLogSnapshot()
    if not GV.IsServer or not self._serverLogSnapshotRecord or tablex.empty(self._serverLogSnapshotRecord) then
        return
    end

    local tempData = clone(self._serverLogSnapshotRecord)
    self._serverLogSnapshotRecord = nil
    for snapshotType, idList in pairs(tempData) do
        if snapshotType == GE.LogSnapshotType.hero then
            for id, data in pairs(idList) do
                DataLogMgr.LogSnapshotHero(data, self)
            end
        elseif snapshotType == GE.LogSnapshotType.equip then
            for id, data in pairs(idList) do
                DataLogMgr.LogSnapshotEquip(data, self)
            end
        elseif snapshotType == GE.LogSnapshotType.weapon then
            for id, data in pairs(idList) do
                DataLogMgr.LogSnapshotWeapon(data, self)
            end
        end
    end
end


return Player
