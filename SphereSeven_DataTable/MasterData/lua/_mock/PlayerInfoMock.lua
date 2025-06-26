local PlayerInfoMock = BaseClass("PlayerInfoMock", Singleton);

local function PlayerInfo(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        PlayerInfo = 
        {
            PlayerId = 1919810,
            AccountId = 1,
            Nickname = "Ame",
            Avatar = "",
            Level = 2,
            Exp = 500,
            Energy = 165,
            GoldCoin = 1000000000,
            PaidStarStone = 1000000000,
            FreeStarStone = 1000000000,
            StarSand = 1000000000,
            MagicCrystal = 2,
            EmperorStarPoint = 0,
            MainUICardId = -7799950073151619050,
            BedroomCardId = 0,
            LastRoomRestTime = 0,
            LastRoomMalTime = 0,
            IsAllowFreeCallCard = 0,
            CardMax = 120,
            EquipMax = 200,
            UnlimitedEnergyTime = 0,
            AddHaftPrTime = 2,
            LastLoginTime = 2,
            RegisterTime = 2,
            MailNum = 2,
            OnLineTime = 2,
            AidId = 0,
            SigninNum = 2,
            SigninToday = 2,
            NewNum = 1,
            NewToday = 2,
            FightSoulMax = 120,
            EnergyNextTime = 2,
            AbyssNextTime = 2,
            OnLineDay = 2,          
        }         
    }
    return rspMsg
end

local function RoleInfoPResp(reqMsg)
    local rspMsg = 
    {
        
            uid = 114514,
            username = "萧瑟",
            register_time = 3,
            exp = 1000,
            level = 5,
            last_power_recover_time = 6,--上次体力恢复时间 
            total_online_duration = 7,--总计在线时长(秒)
        
            head_portraits = {
                100101,
                2001
            }, -- 头像集合
            using_head_portrait = "",	-- 使用中的头像
        
            battle_info = {
                level_start_times = 1, -- // 战斗次数
	            enemy_slaved_count = 2, --// 杀敌数量
                most_used_characters = { 
                    {
                        character_id = 1001,
                        battle_times = 2
                    },
                    {
                        character_id = 1002,
                        battle_times = 1
                    }
                } --// 常用角色
            }, --战斗相关信息
            task_info = {
                achievement_finish_count = 1 -- // 成就完成数量
            },
            recruit_info = {
                total_recruit_times = 1-- // 总抽卡次数
            },
        
            show_girl = {
                character_id = 1001,
	            skin_id = 100101,
	            pos_x = 3,
	            pos_y = 4,
	            scale = 5,
            },
            house = {
                character_id = 1001,
	            last_rest_time = 0,
	            last_sleep_time = 0,
            },
        }
    return rspMsg
end

local function RoleInfoUpdatePush()
    local rspMsg = 
    {
            exp = 4,
            level = 5,
            last_power_recover_time = 6,--上次体力恢复时间
            total_online_duration = 7,--总计在线时长(秒)
        
            using_head_portrait = 100101,	-- 使用中的头像
        
            battle_info = {
                level_start_times = 1, -- // 战斗次数
	            enemy_slaved_count = 2 --// 杀敌数量
            }, --战斗相关信息
            task_info = {
                achievement_finish_count = 1 -- // 成就完成数量
            },
            recruit_info = {
                total_recruit_times = 1-- // 总抽卡次数
            },
        
            show_girl = {
                character_id = 1001,
	            skin_id = 2,
	            pos_x = 3,
	            pos_y = 4,
	            scale = 5,
            },
            house = {
                character_id = 1001,
	            last_rest_time = 0,
	            last_sleep_time = 0,
            },
        }
    return rspMsg
end

local function HouseRestReq()
    local rspMsg = {
        last_rest_time = os.time(),
    }

    --RoleInfoUpdatePush()
    return rspMsg
end

local function HouseSleepReq()
    local rspMsg = {
        last_sleep_time = os.time(),
    }

    --RoleInfoUpdatePush()
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_PlayerInfo, PlayerInfo)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.RoleInfoReq, RoleInfoPResp)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.RoleInfoUpdatePush, RoleInfoUpdatePush)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.HouseRestReq, HouseRestReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.HouseSleepReq, HouseSleepReq)
end

local function __delete(self)
end

PlayerInfoMock.__init = __init
PlayerInfoMock.__delete = __delete


return PlayerInfoMock;