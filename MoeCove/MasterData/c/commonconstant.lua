
Config.SpecialItemMap = {
    --[Config.Item_Silver] = "silver",
    --[Config.Item_Exp] = "exp",
    --[Config.Item_Gold] = "gold",
    --[Config.Item_payGold] = "paygold",
    --[Config.Item_Activity05Rep] = {
    --    name = "activity05Rep", -- proto 中 RewardsInfo
    --    getFuncName = "getActivity05Reputation",
    --    setFuncName = "setActivity05Reputation",
    --    addFuncName = "addActivity05Reputation",
    --    removeFuncName = "removeActivity05Reputation",
    --},
}

Config.SpecialItemStrMap = {}
for k, v in pairs(Config.SpecialItemMap) do
    if istable(v) then
        Config.SpecialItemStrMap[v.name] = v
    else
        Config.SpecialItemStrMap[v] = v
    end
end

function Config.GetSpecialItem(id)
    return Config.SpecialItemMap[id]
end

function Config.GetSpecialItemByKey(key)
    return Config.SpecialItemStrMap[key]
end

Config.CapitalNum = {
    "一", "二", "三", "四", "五", "六", "七", "八", "九", "十",
    "十一","十二","十三","十四","十五","十六","十七",
}

--玩家初始化体力数据
Config.TicketDefaultData = 
{
	num = Config.GetConfigInfo("InitialTicketNum"),
	lastRecoverTime = 0,
	todayBuyCount = 0,
}

--初始外出数据
Config.DefaultOutInfoData = 
{
    heroId = 0,
    outId = 0,
    outTime = 0,
    duration = 0
}

--初始外出信息
Config.GoOutDefaultInfo = 
{
	adventure = {
        heroId = 0,
        outId = 0,
        outTime = 0,
        duration = 0,
        moodValue = 0
    },
    hundredCats = {
        heroId = 0,
        outId = 0,
        outTime = 0,
        duration = 0,
        moodValue = 0
    }
}

Config.PicPieceDefaultData = {
    getRepeatedPieceTimes = 0,
    picData = {
        picPiece = {},
        picGetAll = {},
    }

}

Config.affectionDefaultData = {
    affectionEventMap = {},          --好感度事件列表
    delegateEventList = {},          --委托列表
    limitCount = 0,                  --每日已触发次数
}

Config.dispatchData = {
    finishRouteList = {},
    rewardRecordList = {},
    dispatchTaskList = {},
    dispatchRandomTaskList = {},
    chapterRecordList = {},
}

Config.genRoleFragData = {
    availableCount = 0,    --当日可生成次数
    genRoleList = {}, --当日已生成过的角色列表
}

--额外奖励关卡初始化数据
Config.extraRewardsDefaultData = {}
if Config.GetConfigInfo("PveExtraReward") then
    for _, value in pairs(Config.GetConfigInfo("PveExtraReward")) do
        Config.extraRewardsDefaultData[value[1]] = {
            count = 0,
            extraCount = 0,
        }
    end
end

--周期活动数据(包含模拟演习和危境攻坚)
Config.regularActivityDefaultData = {
    simulatedActivity = {
        simulatedLevelMap = {}, --模拟演习层数据
        maxFloor = 0, --最高层数
        nowPeriod = 1, --当前期数
        closingTime = 0, --结束时间
    },
    bossActivity = {
        nowPeriod = 1,             --当前期数
        bossLevelMap = {},         --Boss信息 key:bossId value:BossLevelInfo
        scoreRewardList = {},      --分数奖励列表 value:任务id
        closingTime = 0,           --结束时间
    },
}

--前端用
Config.PicClientDefaultData = {
    picPiece = {},
    picGetAll = {},
}

--初始战斗验证数据
Config.BattleVerifyDefaultData = {
    verifyLevel = 3,        --验证等级
    verifyPassedTimes = 0,  --验证通过次数
    skipTimes = 0,          --跳过次数
}

--验证等级对应跳过验证次数
Config.BattleVerifySkipTimes = {
    [1] = 0,
    [2] = 2,
    [3] = 5,
    [4] = 10,
    [5] = 20,
}

--初始签到信息
Config.SignInDefaultInfo = {
    signInIndex = 1;        --签到序号
    signInRound = 1;        --签到轮次
    signInAddClaimed = {};  --累计已签到序号
    signInAddRound = 1;     --累计签到轮次
    signInAddTimes = 0;     --累计签到次数
    lastSignInTime = 0;     --上次签到时间
    lastUpdateTime = 0;     --上次更新信息时间
}

--初始新手签到信息
Config.NewbieSignInDefaultInfo = {
    signInIndex = 1;        --签到序号
    lastSignInTime = 0;     --上次签到时间
}


Config.homeland = {
    buildingList = {},
    rolePreRoom = {},
    homeWalkHeroList = {},
    lastUpdateStorageTime = 0,
    storageItemList = {},
    lastUpdateEarningsTime = 0,
    earningsItemList = {},
    coveProps = {},
    prosperityInfo = {
        currentLevel = 0,
        dailyProsperityCount = 0,
        globalConditionProgress = {},
    },
}

Config.technologyTreeData = {
    researchLevelList = {1,1,1,1},
    researchExpList = {0,0,0,0},
    treeNodeMap = {}
}


Config.generalShopData = {
    shopRefreshMap = {},
    generalGoodsMap = {}
}

Config.weatherForecastData = {
    nextRefreshTime = 0,
    curWeekData = {},
    nextWeekData = {}
}


--初始签到额外奖励信息
Config.SignInAdditionalRewardDefaultInfo = {
    signInGetRewardTimes = 0;           --累计获得奖励次数
    signInAdditionalRewardIndex = 1;    --额外奖励序号
}

--初始活动信息
Config.ActivityDefaultInfo = {
    startTime = 0;              --活动开始时间
    endTime = 0;                --活动结束时间
    points = 0;                 --活动积分
    claimedRewards = {};        --积分奖励
    state = GE.ActivityState.NotOpen;   --活动状态
}

Config.FormationCatLimit = 5    --上阵最大猫猫数

Config.PVELevelConditionsLimit = 3    --PVE关卡最大通关条件数

Config.PVELevelNeedTickets = 1    --PVE关卡需求门票数

Config.LimitCatLevel = 100      --猫猫最大等级

Config.LimitCatSkillLevel = 4      --猫猫最大技能等级

Config.RecoverTicketTime = 300      --门票刷新时间（秒）

Config.LimitNormalTicketNum = 180      --普通门票恢复上限

Config.BattleItemPropsLimit = 3     --最大战斗道具携带类型数

Config.BuyTicketCountLimit = 6     --每日购买体力最大次数

Config.BuyTicketOnceCount = 120     --一次购买体力数

Config.BuyTicketNeedCountList = {   --每日购买体力所需钻石数
    50,50,100,100,200,200
}
Config.MiaoBuyID = 1201         --喵广场ID


Config.DailyResetTime = 5     --每日重置时间（24小时制）


Config.miaoBuyDefaultData = {          --喵广场数据
    miaoBuyList = nil,
    lastRecoverTime = 0,
    miaoBuyCount = 0,
    expirationTime = 0,
}

Config.RecovermiaoBuyTime = 3600      --喵广场刷新时间（秒）


Config.ResetHour_Default = 24 ---活动重置时间(北京时间24点)
Config.GuildMergeMemberCnt = 20
Config.GuildNameMaxWord = 7     -- 公会名字最大字数
Config.GuildDeclMaxWord = 100   -- 公会宣言最大字数
Config.GuildCreateSilver = 100000   -- 帮会创建所需银两
Config.GuildDefendSeason_EndWeek = 2
Config.GuildContrib_ResetWeek = 2
Config.GuildGameWhackMoleEnergyCost = 200
Config.ArenaSeanson_StartWeek = 3
Config.ArenaSeanson_EndWeek = 2
Config.HeroStateMaxValue = 90   --猫咪状态最大值
Config.HeroStateInitValue = 60  --猫咪状态初始值
Config.HeroStateKeyValue = 25 --猫咪状态关键值
Config.LoginFailedStr = 
{
    LocalStrEnum.LoginFailedCode1,
    LocalStrEnum.LoginFailedCode2,
    LocalStrEnum.LoginFailedCode3,
    LocalStrEnum.LoginFailedCode4,
    LocalStrEnum.LoginFailedCode5,
    LocalStrEnum.LoginFailedCode6,
    LocalStrEnum.LoginFailedCode7,
    LocalStrEnum.LoginFailedCode8,
}

Config.NpcInteractProp = {  --猫咪互动道具ID
    Eat = {
        [2] = 101,
        [3] = 102
    },
    Bath = {
        [2] = 103,
        [3] = 104
    },
    Stroke = {
        [2] = 105,
        [3] = 106
    }
}

Config.RepeatedPieceReward = {{1,2,500}} --重复拼图碎片转换金币奖励

Config.UserData = {          --用户数据
    LoginDay = 0,           --登陆天数
    AchieveLevel = 1,          --成就等级
    AchieveExp = 0,             --成就经验值
    UserSign = "",
    TotalGachaNum = 0,      --抽卡总数
    GetSSRNum = 0,          --获得SSR个数
    LevelMainMax = 10101,       --主线当前关卡进度
    LevelDifficultMax = 20201, -- 困难关卡最大等级
    LastDailyRefreshTime = 0,        -- 上次跨天刷新时间（需要累计跨天次数的功能可用此字段）
    GotGuideGachaAward = false, -- 是否获得过引导抽卡奖励
    handbookMigrated = false, -- 图鉴数据是否已迁移
    GotGuideBlueprintAward = false, -- 是否获得过引导蓝图奖励
    CharInitVoice = 1, --角色初始语音
}

Config.OnlyServerData = {          --用户后端额外数据初始化
    nowEquipLimitId = 1000,         --当前装备最大实例化id
    nowWeaponLimitId = 1000,        --当前武器最大实例化id
}

Config.PosterData = {          --看板娘初始数据
    SkinId = 1000101,          --初始看板娘id
    PosX = 0,
    PosY = -315,
    Size = 1,
}

--抽卡初始数据
Config.GachaData = {
    countMap = {},           --抽卡次数 key:卡池id value:次数
    guarantMap = {},        --保底次数 key:卡池id value:次数
    recordData = {
        count = 0,              --抽卡记录总数
        pathkeyList = {},       --抽卡记录路径key列表
        recordList = {}         --抽卡记录列表
    },
}

---工单相关
Config.WorkOrderTitleMinBytes = 10
Config.WorkOrderTitleMaxBytes = 20

Config.WorkOrderContentMinBytes = 6
Config.WorkOrderContentMaxBytes = 60

--编队相关
Config.FormationCount = 5         --默认编队数量
Config.FormationHeroCount = 6      --默认编队舰娘数量


function Config.CommonGetElementOrigin(typeStr, type)
    if not type then
        LuaLogger.e("%s is nil", typeStr)
        return nil
    end

    local res = Config[typeStr][type]
    if not res then
        LuaLogger.e("%s %d hasn't been defined", typeStr, type)
    end

    return res
end

function Config.CommonGetElementStr(typeStr, type)
    return Config.CommonGetElementOrigin(typeStr, type) or ""
end

Config.ActionFailReasonStr = {}
for key, value in pairs(ActionFailReason) do
    local str = "ActionFailReason_" .. key
    Config.ActionFailReasonStr[value] = LocalStrEnum[str] or str
end

function Config.GetFailReasonStr(type)
    return Config.CommonGetElementStr("ActionFailReasonStr", type)
end


Config.ChannelGold = {
    Editor = -1,
    Abroad_GooglePlay = 1,
    Abroad_Apple = 2,
    Taptap_Android = 3,
    Formal_Apple = 4,
    Formal_Quick = 5,
    Formal_Official_Apple = 6,
    Formal_Official_Android = 7,

    Formal_Xipu = 8,
}

Config.ChannelGoldTo = {
    [Config.ChannelGold.Editor] = Config.ChannelGold.Editor,
    [Config.ChannelGold.Abroad_GooglePlay] = Config.ChannelGold.Abroad_GooglePlay,
    [Config.ChannelGold.Abroad_Apple] = Config.ChannelGold.Abroad_Apple,
    [Config.ChannelGold.Taptap_Android] = Config.ChannelGold.Taptap_Android,
    [Config.ChannelGold.Formal_Apple] = Config.ChannelGold.Formal_Apple,
    [Config.ChannelGold.Formal_Quick] = Config.ChannelGold.Formal_Quick,
    [Config.ChannelGold.Formal_Official_Apple] = Config.ChannelGold.Formal_Official_Apple,
    [Config.ChannelGold.Formal_Official_Android] = Config.ChannelGold.Formal_Official_Android,
    [Config.ChannelGold.Formal_Xipu] = Config.ChannelGold.Formal_Xipu,
}


Config.ChannelSetting = {

    ---编辑器
    [GE.Channel.Editor] = {
        channel = GE.Channel.Editor,    ---渠道号
        pay_sdk = GE.PaySDK.Editor,
        pay = {

            [GE.DeviceType.Editor] = {
                ---谷歌支付
                channels = { GE.PayChannel.TestPay},
                ---支付宝微信支付
                --channels = { GE.PayChannel.Alipay, GE.PayChannel.WXpay},
                ---华为支付
                --channels = { GE.PayChannel.HuaWei},
                ---聚合sdk支付
                --channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Editor,
            },
        }
    },

    ---内网测试服
    [GE.Channel.InternalTest] = {
        channel = GE.Channel.InternalTest,    ---渠道号
        pay_sdk = GE.PaySDK.Editor,
        pay = {

            [GE.DeviceType.Editor] = {
                ---谷歌支付
                channels = { GE.PayChannel.TestPay},
                ---支付宝微信支付
                --channels = { GE.PayChannel.Alipay, GE.PayChannel.WXpay},
                ---华为支付
                --channels = { GE.PayChannel.HuaWei},
                ---聚合sdk支付
                --channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.TestPay},
                gold = Config.ChannelGold.Formal_Official_Android,
            },
            [GE.DeviceType.IOS] = {
                channels = { GE.PayChannel.TestPay},
                gold = Config.ChannelGold.Formal_Official_Apple,
            },
        }
    },

    [GE.Channel.Formal_Official] = {
        channel = GE.Channel.Formal_Official,    ---渠道号
        pay_sdk = GE.PaySDK.Official,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.Alipay, GE.PayChannel.WXpay},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                --channels = { GE.PayChannel.GooglePlay},
                channels = { GE.PayChannel.Alipay, GE.PayChannel.WXpay},
                gold = Config.ChannelGold.Formal_Official_Android,
            },
            [GE.DeviceType.IOS] = {
                channels = { GE.PayChannel.Apple},
                --channels = { GE.PayChannel.UnionPayWeb},
                gold = Config.ChannelGold.Formal_Official_Apple,
            },
        }
    },
    ---taptap
    [GE.Channel.Formal_TapTap] = {
        channel = GE.Channel.Formal_TapTap,    ---渠道号
        pay_sdk = GE.PaySDK.Official,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.Alipay},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.Alipay, GE.PayChannel.WXpay},
                gold = Config.ChannelGold.Formal_Official_Android,
            },
--[[            [GE.DeviceType.IOS] = {
                channels = { GE.PayChannel.Apple},
                gold = Config.ChannelGold.Formal_Apple,
            },]]
        }
    },

    ---好游
    [GE.Channel.Formal_HaoYou] = {
        channel = GE.Channel.Formal_HaoYou,    ---渠道号
        pay_sdk = GE.PaySDK.Official,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.Alipay},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.Alipay, GE.PayChannel.WXpay},
                gold = Config.ChannelGold.Formal_Official_Android,
            },
            --[[            [GE.DeviceType.IOS] = {
                            channels = { GE.PayChannel.Apple},
                            gold = Config.ChannelGold.Formal_Apple,
                        },]]
        }
    },

    ---B站
    [GE.Channel.Channel_bilibili] = {
        channel = GE.Channel.Channel_bilibili,    ---渠道号
        pay_sdk = GE.PaySDK.Official,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.Alipay},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.Alipay, GE.PayChannel.WXpay},
                gold = Config.ChannelGold.Formal_Official_Android,
            },
        }
    },

    ---xipu
    [GE.Channel.Channel_Xipu] = {
        channel = GE.Channel.Channel_Xipu,    ---渠道号
        pay_sdk = GE.PaySDK.XipuSDK,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.XipuSDK},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.XipuSDK},
                gold = Config.ChannelGold.Formal_Xipu,
            },
        }
    },

    --微信小程序
    [GE.Channel.Channel_Xipu_Mini_WX] = {
        channel = GE.Channel.Channel_Xipu_Mini_WX,    ---渠道号
        pay_sdk = GE.PaySDK.XipuMiniSDK,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.XipuMiniSDK},
                gold = Config.ChannelGold.Editor,
            },

            [GE.DeviceType.WebGLPlayer] = {
                channels = { GE.PayChannel.XipuMiniSDK},
                --channels = { GE.PayChannel.UnionPayWeb},
                gold = Config.ChannelGold.Formal_Xipu,
            },
        }
    },

    ---quick 母包
    [GE.Channel.Quick_Origin] = {
        channel = GE.Channel.Quick_Origin,    ---渠道号
        pay_sdk = GE.PaySDK.QuickSDK,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Formal_Quick,
            },
            --[[            [GE.DeviceType.IOS] = {
                            channels = { GE.PayChannel.Apple},
                            gold = Config.ChannelGold.Formal_Apple,
                        },]]
        }
    },

    ---quick huawei
    [GE.Channel.Quick_HuaWei] = {
        channel = GE.Channel.Quick_HuaWei,    ---渠道号
        pay_sdk = GE.PaySDK.QuickSDK,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Formal_Quick,
            },
--[[            [GE.DeviceType.IOS] = {
                channels = { GE.PayChannel.Apple},
                gold = Config.ChannelGold.Formal_Apple,
            },]]
        }
    },

    ---quick vivo
    [GE.Channel.Quick_Vivo] = {
        channel = GE.Channel.Quick_Vivo,    ---渠道号
        pay_sdk = GE.PaySDK.QuickSDK,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Formal_Quick,
            },
--[[            [GE.DeviceType.IOS] = {
                channels = { GE.PayChannel.Apple},
                gold = Config.ChannelGold.Formal_Apple,
            },]]
        }
    },

    ---quick oppo
    [GE.Channel.Quick_Oppo] = {
        channel = GE.Channel.Quick_Oppo,    ---渠道号
        pay_sdk = GE.PaySDK.QuickSDK,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Formal_Quick,
            },
--[[            [GE.DeviceType.IOS] = {
                channels = { GE.PayChannel.Apple},
                gold = Config.ChannelGold.Formal_Apple,
            },]]
        }
    },

    ---quick 小米
    [GE.Channel.Quick_Mi] = {
        channel = GE.Channel.Quick_Mi,    ---渠道号
        pay_sdk = GE.PaySDK.QuickSDK,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Formal_Quick,
            },
            --[[            [GE.DeviceType.IOS] = {
                            channels = { GE.PayChannel.Apple},
                            gold = Config.ChannelGold.Formal_Apple,
                        },]]
        }
    },
    ---quick UC九游(阿里游戏)
    [GE.Channel.Quick_UC] = {
        channel = GE.Channel.Quick_UC,    ---渠道号
        pay_sdk = GE.PaySDK.QuickSDK,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Formal_Quick,
            },
            --[[            [GE.DeviceType.IOS] = {
                            channels = { GE.PayChannel.Apple},
                            gold = Config.ChannelGold.Formal_Apple,
                        },]]
        }
    },
    ---quick 4399
    [GE.Channel.Quick_4399] = {
        channel = GE.Channel.Quick_4399,    ---渠道号
        pay_sdk = GE.PaySDK.QuickSDK,
        pay = {
            [GE.DeviceType.Editor] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Editor,
            },
            [GE.DeviceType.Android] = {
                channels = { GE.PayChannel.QuickSDK},
                gold = Config.ChannelGold.Formal_Quick,
            },
            --[[            [GE.DeviceType.IOS] = {
                            channels = { GE.PayChannel.Apple},
                            gold = Config.ChannelGold.Formal_Apple,
                        },]]
        }
    },


}

Config.PayDiscountChannelSetting = {
    -- 渠道-1，unity，不走官方折扣
    -- 渠道5、10走官方折扣
    [GE.Channel.Formal_Official] = GE.PayDiscountChannel.Official,
    [GE.Channel.InternalTest] = GE.PayDiscountChannel.Official,
    --[GE.Channel.Bilibili] = GE.PayDiscountChannel.Bilibili,
}

--喜扑小程序支付配置
for i = GE.Channel.Channel_Xipu_Mini_WX + 1, GE.Channel.Channel_Xipu_Mini_ZFB do
    local info = shallowclone(Config.ChannelSetting[GE.Channel.Channel_Xipu_Mini_WX])
    info.channel = i
    Config.ChannelSetting[i] = info
end
for i = GE.Channel.Test_Xipu_Mini_WX, GE.Channel.Test_Xipu_Mini_ZFB do
    local info = shallowclone(Config.ChannelSetting[GE.Channel.Channel_Xipu_Mini_WX])
    info.channel = i
    Config.ChannelSetting[i] = info
end

