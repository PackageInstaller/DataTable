GameMsg = {}
GameMsg.map = {}
GameMsg.map["Test"] = {
	--32位数字 16位数字 8位数字 64位数字 布尔   字符串   浮点数  结构体         结构体数组   普通类型数组 双精度小数 
	{ "int",   "short", "byte", "long",  "bool","string","float","struts|Point","list|Point","array|byte","double",  },
	{ "num32", "num16", "num8", "num64", "boo", "str",   "flo",  "strc",        "strca",     "arr",       "double",  },
}
GameMsg.map["Point"] = {
	--x坐标   y坐标   z坐标   
	{ "float","float","float",},
	{ "x",    "y",    "z",    },
}
GameMsg.map["CardPoint"] = {
	--x坐标 行     列     
	{ "int","byte","byte",},
	{ "id", "row", "col", },
}
GameMsg.map["CardData"] = {
	--卡牌index 卡牌id 行     列     阵营     玩家id 模型    名字     技能        np    等级    攻击     最大血量 防御      速度    暴击     暴击率      命中     抵抗     同步率 同步率    同步率     血量  被伤害系数 伤害系数 被治疗系数 治疗系数 物理攻击系数    光线攻击系数  是否使用普攻  是否队长   好友id 玩家卡牌index npcid   突破等级      强化等级          技能        策略             变身同调机神皮肤 副天赋           被伤害系数(生活buff) 伤害系数     
	{ "byte",   "int", "byte","byte","byte",  "long","int",  "string","array|int","int","short","int",   "int",   "int",    "int",  "double","double",   "double","double","int", "double", "double",  "int","double",  "double","double",  "double","double",       "double",     "int",        "bool",    "int", "int",        "int",  "short",      "short",          "array|int","byte",          "int",           "array|int",     "double",            "double",    },
	{ "oid",    "id",  "row", "col", "teamID","uid", "model","name",  "skills",   "np", "level","attack","maxhp", "defense","speed","crit",  "crit_rate","hit",   "resist","sp",  "sp_race","sp_race2","hp", "bedamage","damage","becure",  "cure",  "damagePhysics","damageLight","isUseCommon","isLeader","fuid","cuid",       "npcid","break_level","intensify_level","eskills",  "nStrategyIndex","modelA",        "use_sub_talent","bedamage_add",      "damage_add",},
}
GameMsg.map["FightCardData"] = {
	--卡牌id 玩家id 行     列     卡牌数据          
	{ "int", "long","byte","byte","struts|CardData",},
	{ "cid", "uid", "row", "col", "data",           },
}
GameMsg.map["Coordinate"] = {
	--行     列     
	{ "byte","byte",},
	{ 1,     2,     },
}
GameMsg.map["SelectData"] = {
	--阵营     坐标                复活对象ID 变身状态        
	{ "byte",  "struts|Coordinate","byte",    "byte",         },
	{ "teamID","pos",              "reliveID","bTransfoState",},
}
GameMsg.map["sPveData"] = {
	--角色数据             指挥官技能        
	{ "list|FightCardData","array|int",      },
	{ "data",              "tCommanderSkill",},
}
GameMsg.map["CMD1"] = {
	--阵营     场景类型 随机种子 怪物组    pve数据           pvp数据              额外数据 玩家等级 队伍id       战斗id   
	{ "byte",  "byte",  "long",  "int",    "struts|sPveData","list|sPvpMatchData","json",  "short", "int",       "string",},
	{ "teamID","stype", "seed",  "groupID","data",           "tPvpData",          "exData","level", "nTeamIndex","fid",   },
}
GameMsg.map["CMD2"] = {
	--卡牌id 
	{ "byte",},
	{ "id",  },
}
GameMsg.map["CMD3"] = {
	--阵营     
	{ "byte",  },
	{ "teamID",},
}
GameMsg.map["CMD4"] = {
	--玩家id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["CMD5"] = {
	--阵营     
	{ "byte",  },
	{ "teamID",},
}
GameMsg.map["CMD6"] = {
	--卡牌id 
	{ "byte",},
	{ "id",  },
}
GameMsg.map["CMD7"] = {
	--释放者ID   技能ID    对象                对象         阵营     
	{ "byte",    "int",    "struts|SelectData","array|byte","byte",  },
	{ "casterID","skillID","target",           "targetIDs", "teamID",},
}
GameMsg.map["CMD8"] = {
	--周目    胜利阵营 
	{ "byte", "byte",  },
	{ "stage","winer", },
}
GameMsg.map["CMD15"] = {
	--状态    战斗数据    
	{ "byte", "list|CMD7",},
	{ "state","skill",    },
}
GameMsg.map["CMD"] = {
	--命令1         命令2         命令3         命令4         命令5         命令6         命令7         命令8         命令15         命令20指挥官技能 
	{ "struts|CMD1","struts|CMD2","struts|CMD2","struts|CMD2","struts|CMD2","struts|CMD6","struts|CMD7","struts|CMD8","struts|CMD15","struts|CMD7",   },
	{ "data1",      "data2",      "data3",      "data4",      "data5",      "data6",      "data7",      "data8",      "data15",      "data20",        },
}
GameMsg.map["ClientCMD"] = {
	--命令7         命令4         命令15         命令20指挥官技能 
	{ "struts|CMD7","struts|CMD4","struts|CMD15","struts|CMD7",   },
	{ "data7",      "data4",      "data15",      "data20",        },
}
GameMsg.map["sPairIntInt"] = {
	--值1     值2      
	{ "uint", "uint",  },
	{ "first","second",},
}
GameMsg.map["sNumInfo"] = {
	--id     数量   类型          装备的技能id 
	{ "uint","uint","byte","uint","array|uint",},
	{ "id",  "num", "type","c_id","eSkills",   },
}
GameMsg.map["sStrNumInfo"] = {
	--字符id 数量   
	{ "uint","uint",},
	{ "sid", "num", },
}
GameMsg.map["sReward"] = {
	--物品id 数量   类型          装备的技能id 
	{ "uint","uint","byte","uint","array|uint",},
	{ "id",  "num", "type","c_id","eSkills",   },
}
GameMsg.map["sPlrPaneInfo"] = {
	--头像模型  角色量     最大副本进度 创建时间 最大爬塔进度 军演历史最高段位 基地行星指挥部等级 头像框       性别序号      玩家称号     
	{ "uint",   "uint",    "uint",      "uint",  "uint",      "uint",          "short",           "uint",      "byte",       "uint",      },
	{ "icon_id","role_num","max_dup",   "c_time","max_tower", "max_rank_level","build_control_lv","icon_frame","sel_card_ix","icon_title",},
}
GameMsg.map["sCardCreateLog"] = {
	--获得的奖励(物品id,数量) 花费(物品id,数量) 品质提升     
	{ "list|sNumInfo",      "list|sNumInfo",  "array|uint",},
	{ "rewards",            "costs",          "quality_up",},
}
GameMsg.map["sFirstCreateInfo"] = {
	--是否已经首次十连 卡池id         已经尝试次数  
	{ "bool",          "ushort",      "int",        },
	{ "first_10",      "card_pool_id","had_try_cnt",},
}
GameMsg.map["sCardCreateLogInfo"] = {
	--卡池id         记录列表             最后一次操作的结果   
	{ "ushort",      "list|sCardCreateLog","struts|sCardCreateLog",},
	{ "card_pool_id","logs",              "last_op",           },
}
GameMsg.map["sLoginDevice"] = {
	--型号          品牌         分辨率     cpu         系统版本    gpu         内存        模拟器     跑分     低中高端  
	{ "string",     "string",    "string",  "string",   "string",   "string",   "string",   "string",  "string","string", },
	{ "phone_model","phone_logo","phone_px","phone_cpu","phone_sys","phone_gpu","phone_mem","emulator","score", "mobielv",},
}
GameMsg.map["sCardPoolRewardInfo"] = {
	--id     数量                   
	{ "uint","uint","list|sNumInfo",},
	{ "id",  "num", "items",        },
}
GameMsg.map["sDupSumStarReward"] = {
	--CfgSectionStarReward 的 id 领取的需要数组 
	{ "uint",              "array|byte",  },
	{ "id",                "indexs",      },
}
GameMsg.map["sChangeCardInfos"] = {
	--              
	{ "uint","uint",},
	{ "id",  "skin",},
}
GameMsg.map["sZiLongUserInfo"] = {
	--运营商      选择语言 设备id   紫龙上线渠道id 
	{ "string",   "string","string","string",      },
	{ "operators","langue","device","gameChannel", },
}
GameMsg.map["sPairStringInt"] = {
	--值1      值2      
	{ "string","uint",  },
	{ "first", "second",},
}
GameMsg.map["sPvpCardsData"] = {
	--        卡牌的唯一id 名字     技能         等级    跃升等级[以前的突破等级] 强化等级          血量   经验   性能（缓存显示、军演）使用 使用的皮肤 皮肤l2d     其他形态皮肤 皮肤l2d       副天赋       卡牌其他信息                                                                                                                  装备技能ids数组 
	{ "uint", "uint",      "string","array|uint","uint", "uint",              "uint",           "uint","uint","float",              "uint",    "byte",     "uint",      "byte",       "json",      "struts|sCardMixData","int",   "int",  "int",    "int",  "float",    "float","float","float", "int","int","float",  "float",   "array|uint",   },
	{ "cfgid","cid",       "name",  "skills",    "level","break_level",       "intensify_level","hp",  "exp", "performance",        "skin",    "skinIsl2d","skin_a",    "skinIsl2d_a","sub_talent","mix_data",          "attack","maxhp","defense","speed","crit_rate","crit", "hit",  "resist","np", "sp", "sp_race","sp_race2","equip_skills", },
}
GameMsg.map["sIntArray"] = {
	--id     数组         
	{ "uint","array|uint",},
	{ "id",  "data",      },
}
GameMsg.map["SystemProto:ServerError"] = {
	--账号     
	{ "string",},
	{ "msg",   },
}
GameMsg.map["ClientProto:GmCmd"] = {
	--账号     
	{ "string",},
	{ "cmd",   },
}
GameMsg.map["SystemProto:ServerWarning"] = {
	--账号     
	{ "string",},
	{ "msg",   },
}
GameMsg.map["sTipsInfo"] = {
	--参数类型 参数     
	{ "byte",  "string",},
	{ "type",  "param", },
}
GameMsg.map["SystemProto:Tips"] = {
	--错误id(CfgTipsSimpleChinese的key) 触发的协议id 触发的操作名称（协议名称or模块名称） 错误参数         
	{ "string",            "uint",      "string",             "list|sTipsInfo",},
	{ "strId",             "opId",      "opName",             "args",          },
}
GameMsg.map["SystemProto:TestMap"] = {
	--map                  json   
	{ "map|sTipsInfo|type","json",},
	{ "map",               "json",},
}
GameMsg.map["sSignRewardInfo"] = {
	--CfgSignReward.index 子序列号(CfgSignRewardItem.index) 最后签到时间戳（秒数），没签到过默认为空 nil 最初签到时间戳（秒数），没签到过为 nil 已补签次数      
	{ "int",              "json",              "uint",               "uint",               "uint",         },
	{ "index",            "indexs",            "lastSingTime",       "firstSingTime",      "muCheckinCost",},
}
GameMsg.map["ClientProto:GetSignInfo"] = {
	--签到活动id(CfgSignReward.id) CfgSignReward.index 
	{ "int",               "int",              },
	{ "id",                "index",            },
}
GameMsg.map["ClientProto:GetSignInfoRet"] = {
	--      CfgSignReward.index 签到记录             是否最后一个（申请id 发0过来） 是否开启补签   
	{ "int","int",              "struts|sSignRewardInfo","bool",              "bool",        },
	{ "id", "index",            "rewardsInfos",      "is_end",            "is_mucheckin",},
}
GameMsg.map["ClientProto:AddSign"] = {
	--签到活动id(CfgSignReward.id) 补签下标,不传为正常签到 
	{ "int",               "int",               },
	{ "id",                "index",             },
}
GameMsg.map["ClientProto:AddSignRet"] = {
	--       签到活动id(CfgSignReward.id) CfgSignReward.index 子序列号(CfgSignRewardItem.index) 签到记录             是否开启补签   
	{ "bool","int",               "int",              "int",               "struts|sSignRewardInfo","bool",        },
	{ "isOk","id",                "index",            "subIndex",          "rewardsInfos",      "is_mucheckin",},
}
GameMsg.map["sMemberReward"] = {
	--创建时间 物品id    剩余领取次数 
	{ "uint",  "uint",   "uint",      },
	{ "c_time","item_id","l_cnt",     },
}
GameMsg.map["ClientProto:GetMemberRewardInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["ClientProto:GetMemberRewardInfoRet"] = {
	--                     
	{ "list|sMemberReward",},
	{ "infos",             },
}
GameMsg.map["sGetDupSumStarReward"] = {
	--CfgSectionStarReward 的 id 序号    
	{ "uint",              "uint", },
	{ "id",                "index",},
}
GameMsg.map["ClientProto:GetDupSumStarReward"] = {
	--                     
	{ "list|sGetDupSumStarReward",},
	{ "infos",             },
}
GameMsg.map["ClientProto:DupSumStarRewardInfo"] = {
	--CfgSectionStarReward 的 ids/不发为获取全部 
	{ "array|uint",        },
	{ "ids",               },
}
GameMsg.map["ClientProto:DupSumStarRewardInfoRet"] = {
	--领取信息             
	{ "list|sDupSumStarReward",},
	{ "infos",             },
}
GameMsg.map["ClientProto:SetDupUseItem"] = {
	--副本id 副本配置表可以使用物品的的下标（取消发空）           
	{ "uint","uint",               "bool",   },
	{ "id",  "index",              "is_open",},
}
GameMsg.map["ClientProto:SetDupUseItemRet"] = {
	--副本id                   
	{ "uint","uint", "bool",   },
	{ "id",  "index","is_open",},
}
GameMsg.map["sActiveInfo"] = {
	--活动id 活动类型 开始时间   结束时间   第几季  积分    排名   领取记录   
	{ "uint","short", "uint",    "uint",    "uint", "uint", "uint","json",    },
	{ "id",  "type",  "beg_time","end_time","index","score","rank","had_gets",},
}
GameMsg.map["ClientProto:GetActiveInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["ClientProto:GetActiveInfoRet"] = {
	--                   
	{ "list|sActiveInfo",},
	{ "actives",         },
}
GameMsg.map["ClientProto:UpdateActiveInfo"] = {
	--Tips：仅包含，要更新的字段 
	{ "list|sActiveInfo",   },
	{ "actives",            },
}
GameMsg.map["ClientProto:GetActiveReward"] = {
	--活动id 奖励下标 
	{ "uint","short", },
	{ "id",  "index", },
}
GameMsg.map["ClientProto:GetActiveRewardRet"] = {
	--活动id 奖励下标 
	{ "uint","short", },
	{ "id",  "index", },
}
GameMsg.map["ClientProto:RewardNotice"] = {
	--奖励            是否发完    
	{ "list|sNumInfo","bool",     },
	{ "rewards",      "is_finish",},
}
GameMsg.map["ClientProto:BackstageChagne"] = {
	--后台刷新类型 
	{ "byte",      },
	{ "type",      },
}
GameMsg.map["ClientProto:ExeCode"] = {
	--代码     
	{ "string",},
	{ "cmd",   },
}
GameMsg.map["ClientProto:Heartbeat"] = {
	--
	{ },
	{ },
}
GameMsg.map["LoginProto:Heartbeat"] = {
	--
	{ },
	{ },
}
GameMsg.map["LoginProto:SvrReloading"] = {
	--配置表版本[ 客户端读取全局变量  g_svnVersion 做比较] app版本[ 客户端读取全局变量 g_appVersion 做比较 ] 
	{ "uint",               "uint",              },
	{ "v_svn",              "v_app",             },
}
GameMsg.map["SystemProto:ActiveZeroNotice"] = {
	--        
	{ "json", },
	{ "datas",},
}
GameMsg.map["ClientProto:SvrTime"] = {
	--
	{ },
	{ },
}
GameMsg.map["ClientProto:SvrTimeRet"] = {
	--当前时间戳（秒） 
	{ "uint",          },
	{ "time",          },
}
GameMsg.map["ClientProto:DelAcc"] = {
	--账号               
	{ "string", "string",},
	{ "account","pwd",   },
}
GameMsg.map["ClientProto:DelAccRet"] = {
	--0:成功，1:账号错误，2：密码错误，3:逻辑异常 
	{ "int",               },
	{ "result",            },
}
GameMsg.map["sDySetCfgNotice"] = {
	--配置表名字 修改的字段 配置表id 二级名字 二级id   配置的值 是否删除 
	{ "string",  "string",  "string","string","string","string","bool",  },
	{ "name",    "field",   "row_id","sub_tb","sub_id","val",   "is_del",},
}
GameMsg.map["ClientProto:DySetCfgNotice"] = {
	--                     
	{ "list|sDySetCfgNotice",},
	{ "infos",             },
}
GameMsg.map["ClientProto:PlrNotice"] = {
	--通知信息 
	{ "json",  },
	{ "notice",},
}
GameMsg.map["ClientProto:QueryPrePay"] = {
	--商品id      配置表的支付价格 
	{ "uint",     "uint",          },
	{ "productId","amount",        },
}
GameMsg.map["ClientProto:QueryPrePayRet"] = {
	--商品id      配置表的支付价格 
	{ "uint",     "uint",          },
	{ "productId","amount",        },
}
GameMsg.map["SystemProto:QianXiLogEvent"] = {
	--事件类型       
	{ "array|string",},
	{ "logTypeArr",  },
}
GameMsg.map["ClientProto:QueryAccount"] = {
	--账号      版本号                
	{ "string", "string",    "string",},
	{ "account","SvnVersion","pwd",   },
}
GameMsg.map["LoginProto:QueryAccount"] = {
	--账号                                  是否开启防沉迷(0:关闭，1：开启) 
	{ "long","string",     "json",          "byte",              },
	{ "uid", "svr_version","anti_addiction","is_anti_addiction", },
}
GameMsg.map["ClientProto:PreLoginGame"] = {
	--账号   数数游客id   
	{ "long","string",    },
	{ "uid", "distinctId",},
}
GameMsg.map["LoginProto:PreLoginGame"] = {
	--登陆秘钥 ip       端口    是否可以登陆 错误id(CfgTipsSimpleChinese的key) 错误参数         所在服务器集群 中台uid          第三方id        
	{ "string","string","short","bool",      "string",            "list|sTipsInfo","string",      "string",        "string",       },
	{ "key",   "ip",    "port", "is_ok",     "strId",             "args",          "svr_group",   "center_web_uid","third_part_id",},
}
GameMsg.map["ClientProto:LoginGame"] = {
	--登陆秘钥 版本号       账号   登陆设备信息         数数游客id   紫龙玩家信息         中台传的信息    
	{ "string","string",    "long","struts|sLoginDevice","string",    "struts|sZiLongUserInfo","json",         },
	{ "key",   "SvnVersion","uid", "device",            "distinctId","ziLongUserInfo",    "centerWebInfo",},
}
GameMsg.map["sPlrData"] = {
	--账号   名字     体能    等级    金币   钻石      服务器时间戳 经验  签名     创建时间      军演代币    tp值    tp开始时间    是否不统计日志(1:为不统计，0为统计) 支付钻石      
	{ "long","string","short","short","int", "int",    "long",      "int","string","long",       "int",      "short","long",       "byte",              "int",        },
	{ "uid", "name",  "hot",  "level","gold","diamond","currtime",  "exp","sign",  "create_time","army_coin","tp",   "tpBeginTime","notLog",            "diamond_pay",},
}
GameMsg.map["LoginProto:LoginGame"] = {
	--玩家信息          是否可以改名      头像模型id 面板角色id 能力点        当前登录逻辑服id 创建时候选择的性别序号 选择的台词id 下次体能恢复时间 体能已购买次数 {月，日}       头像框id     最后设置的角色看板ID 背景ID          玩家称号     玩家设置界面的表情 
	{ "struts|sPlrData","byte",           "uint",    "uint",    "int",        "short",         "byte",               "uint",      "uint",          "short",       "array|ushort","uint",      "uint",              "uint",         "uint",      "array|uint",      },
	{ "infos",          "can_modify_name","icon_id", "panel_id","ability_num","serverID",      "sel_card_ix",        "use_vid",   "t_hot",         "hot_buy_cnt", "birth",       "icon_frame","role_panel_id",     "background_id","icon_title","icon_emotes",     },
}
GameMsg.map["LoginProto:PlrUpdate"] = {
	--更新信息(不是所有字段都有) 添加的经验 下次体能恢复时间 
	{ "struts|sPlrData",   "uint",    "uint",          },
	{ "infos",             "add_exp", "t_hot",         },
}
GameMsg.map["ClientProto:RegisterAcc"] = {
	--账号      密码     
	{ "string", "string",},
	{ "account","pwd",   },
}
GameMsg.map["LoginProto:RegisterAccRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["ClientProto:UseExchangeCode"] = {
	--账号     
	{ "string",},
	{ "code",  },
}
GameMsg.map["ClientProto:UseExchangeCodeRet"] = {
	--        已经得到的奖励 
	{ "bool", "list|sReward",},
	{ "is_ok","rewards",     },
}
GameMsg.map["ClientProto:SetAntiAdiction"] = {
	--名字     身份证号 中宣部返回的pi 
	{ "string","string","string",      },
	{ "name",  "number","pi",          },
}
GameMsg.map["ClientProto:SetAntiAdictionRet"] = {
	--                 
	{ "json",          },
	{ "anti_addiction",},
}
GameMsg.map["ClientProto:AntiAdictionUpdate"] = {
	--                 
	{ "json",          },
	{ "anti_addiction",},
}
GameMsg.map["ClientProto:InitFinish"] = {
	--               
	{ "bool",        },
	{ "is_reconnect",},
}
GameMsg.map["ClientProto:InitFinishRet"] = {
	--               
	{ "bool",        },
	{ "is_reconnect",},
}
GameMsg.map["ClientProto:ChangeLine"] = {
	--是否延迟到处理完界面逻辑再处理 
	{ "bool",               },
	{ "delay",              },
}
GameMsg.map["ClientProto:Offline"] = {
	--
	{ },
	{ },
}
GameMsg.map["ClientProto:ExchangeItem"] = {
	--要换的的物品   如果是抽卡需要产生把卡池id发过来 兑换类型 
	{ "list|sReward","uint",               "uint",  },
	{ "exchanges",   "card_pool_id",       "ty",    },
}
GameMsg.map["ClientProto:ExchangeItemRet"] = {
	--获得的物品     如果是抽卡需要产生把卡池id发过来 兑换类型 
	{ "list|sReward","uint",               "uint",  },
	{ "rewards",     "card_pool_id",       "ty",    },
}
GameMsg.map["LoginProto:WaitingLogin"] = {
	--排队人数  是否等待排队 多久后再来链接（秒） 排队限制人数  
	{ "short",  "bool",      "short",             "short",      },
	{ "waitCnt","isWaiting", "waitingTime",       "lineLimtNum",},
}
GameMsg.map["LoginProto:WaitingLoginOk"] = {
	--
	{ },
	{ },
}
GameMsg.map["LoginProto:WaitingLoginUpdate"] = {
	--排队人数  多久后再来链接（秒） 
	{ "short",  "short",             },
	{ "waitCnt","waitingTime",       },
}
GameMsg.map["ClientProto:ActiveOpen"] = {
	--活动id  活动类型 开始时间   关闭时间   困难本开启时间 EX本开启时间 副本关闭时间     子章节的开放时间     是否登录下发  
	{ "short","short", "int",     "int",     "int",         "int",       "int",           "list|sSectionTable","bool",       },
	{ "id",   "type",  "nBegTime","nEndTime","nHardBegTime","nExBegTime","nBattleendTime","sectionTables",     "isFromLogin",},
}
GameMsg.map["sSectionTable"] = {
	--章节id  开始时间    关闭时间    
	{ "short","int",      "int",      },
	{ "id",   "startTime","closeTime",},
}
GameMsg.map["FightProtocol:StartMainLineFight"] = {
	--副本ID         怪物组    角色数据         队伍编号     
	{ "uint",        "uint",   "list|CardPoint","int",       },
	{ "nDuplicateID","groupID","data",          "nTeamIndex",},
}
GameMsg.map["FightProtocol:PvpMatch"] = {
	--角色数据         
	{ "list|CardPoint",},
	{ "data",          },
}
GameMsg.map["FightProto:RecvCmd"] = {
	--index   cmd    data         time   
	{ "short","byte","struts|CMD","long",},
	{ 1,      2,     3,           4,     },
}
GameMsg.map["FightProtocol:RecvCmd"] = {
	--index   cmd    data               
	{ "short","byte","struts|ClientCMD",},
	{ 1,      2,     3,                 },
}
GameMsg.map["FightProto:PvpMatch"] = {
	--结果   错误信息 
	{ "bool","string",},
	{ "ret", "msg",   },
}
GameMsg.map["sPvpMatchData"] = {
	--角色数据             玩家ID 指挥官技能        
	{ "list|FightCardData","long","array|int",      },
	{ "data",              "uid", "tCommanderSkill",},
}
GameMsg.map["FightProto:PvpFightResult"] = {
	--数据                 
	{ "list|sPvpMatchData",},
	{ "data",              },
}
GameMsg.map["FightProtocol:AutoFight"] = {
	--id     
	{ "byte",},
	{ "id",  },
}
GameMsg.map["sSyncFight"] = {
	--卡牌index 卡牌id 血量  进度       
	{ "byte",   "int", "int","int",     },
	{ "oid",    "id",  "hp", "progress",},
}
GameMsg.map["FightProto:SyncFight"] = {
	--数据                 
	{ "map|sSyncFight|oid",},
	{ "list",              },
}
GameMsg.map["FightProtocol:SetFocusFire"] = {
	--集火对象id     
	{ "byte",        },
	{ "nFocusFireID",},
}
GameMsg.map["FightProtocol:SetSkillAI"] = {
	--副本类型 数据                 
	{ "byte",  "list|sDuplicateAIData",},
	{ "index", "data",              },
}
GameMsg.map["FightProtocol:Quit"] = {
	--uid    是否撤退  
	{ "long","bool",   },
	{ "uid", "bIsQuit",},
}
GameMsg.map["FightProto:SingleFight"] = {
	--怪物组    副本id         我方的id 怪物的id     pve数据           额外数据 队伍编号     
	{ "int",    "uint",        "byte",  "byte",      "struts|sPveData","json",  "int",       },
	{ "groupID","nDuplicateID","myOID", "monsterOID","data",           "exData","nTeamIndex",},
}
GameMsg.map["FightProtocol:OnFightOver"] = {
	--胜利者  剩余血量 我方的id 怪物的id     击杀怪物数量   条件数据    设置技能      其他战斗数据 
	{ "byte", "json",  "byte",  "byte",      "byte",        "array|int","json",       "json",      },
	{ "winer","data",  "myOID", "monsterOID","nKillMonster","nGrade",   "tSetSkillAI","exdata",    },
}
GameMsg.map["FightProtocol:SetTrusteeship"] = {
	--是否托管       
	{ "bool",        },
	{ "bTrusteeship",},
}
GameMsg.map["FightProtocol:CountdownBegins"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:TrusteeshipState"] = {
	--条件数据      
	{ "array|bool", },
	{ "Trusteeship",},
}
GameMsg.map["FightProtocol:LeaveFight"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProtocol:ClientError"] = {
	--错误信息     
	{ "string",    },
	{ "errContent",},
}
GameMsg.map["FightProtocol:ReqDuplicateData"] = {
	--副本类型 副本id         
	{ "byte",  "uint",        },
	{ "index", "nDuplicateID",},
}
GameMsg.map["FightProtocol:EnterDuplicate"] = {
	--副本类型 副本id         编队信息             队伍列表     
	{ "byte",  "uint",        "list|sDuplicateTeamData","array|byte",},
	{ "index", "nDuplicateID","list",              "data",      },
}
GameMsg.map["FightProtocol:EnterFightDuplicate"] = {
	--副本类型 副本id         编队信息             是否用多倍奖励  已选择词条组（暂历战试炼用） 
	{ "byte",  "uint",        "list|sDuplicateTeamData","bool",         "array|uint",         },
	{ "index", "nDuplicateID","list",              "isMultiReward","selectBuffs",        },
}
GameMsg.map["FightProtocol:MoveTo"] = {
	--副本类型 对象id 移动路径      
	{ "byte",  "byte","array|short",},
	{ "index", "oid", "path",       },
}
GameMsg.map["FightProtocol:EnterFight"] = {
	--副本类型 我方的id 怪物的id     调整后的位置信息 是否用多倍奖励  
	{ "byte",  "byte",  "byte",      "list|sPosData", "bool",         },
	{ "index", "myOID", "monsterOID","posData",       "isMultiReward",},
}
GameMsg.map["FightProtocol:QuitDuplicate"] = {
	--副本类型 副本id         
	{ "byte",  "uint",        },
	{ "index", "nDuplicateID",},
}
GameMsg.map["sDuplicateCharData"] = {
	--对象id 角色类型 坐标    怪物组id          状态    我方队伍             队伍id    道具ID    助战好友信息        模型    是否新对象 怪物受到伤害比例 角色buff    副本技能   移动步数 跳跃高度 buffer     AI步数偏移量   预留sp         预留np       集火对象类型 
	{ "byte","byte",  "short","uint",           "byte", "list|sDuplicateCardData","uint",   "uint",   "struts|sCardsData","uint", "bool",    "float",         "array|int","json",    "byte",  "byte",  "json",    "int",         "bool",        "byte",      "byte",      },
	{ "oid", "type",  "pos",  "nMonsterGroupID","state","team",              "nTeamID","nPropID","friend",           "model","bIsNew",  "damage",        "tExBuff",  "arrSkill","nStep", "nJump", "buffData","nIntervaloff","bIsReserveSP","nReserveNP","nFocusFire",},
}
GameMsg.map["sDuplicateCardData"] = {
	--在队伍位置 角色配置id 助战卡牌玩家ID 角色唯一id 热值    剩余血量 行     列     强制npc的id 是否队长   血量比       使用普攻      同步率 策略             助战AI数据  卡牌等级(目前连锁助战卡牌显示用) 
	{ "byte",    "uint",    "long",        "uint",    "short","int",   "byte","byte","uint",     "bool",    "float",     "byte",       "int", "byte",          "json",     "int",               },
	{ "index",   "id",      "fuid",        "cid",     "hot",  "hp",    "row", "col", "npcid",    "isLeader","hp_percent","isUseCommon","sp",  "nStrategyIndex","aiSetting","level",             },
}
GameMsg.map["FightProto:DuplicateData"] = {
	--副本类型 副本id         波数    结束时间   角色列表             是否是新的一波怪 是否增量更新 当前步数 获得的宝箱数量 击杀怪物数量 
	{ "byte",  "uint",        "byte", "uint",    "list|sDuplicateCharData","bool",          "bool",      "byte",  "byte",        "byte",      },
	{ "index", "nDuplicateID","nWave","nEndTime","arrChar",           "bIsNewWave",    "bIsFresh",  "nStep", "nBox",        "nKillCount",},
}
GameMsg.map["FightProto:UpdateChar"] = {
	--对象id 角色类型 坐标    怪物组id          状态    我方队伍             队伍id    道具ID    怪物受到伤害比例 角色buff    
	{ "byte","byte",  "short","uint",           "byte", "list|sDuplicateCardData","uint",   "uint",   "float",         "array|int",},
	{ "oid", "type",  "pos",  "nMonsterGroupID","state","team",              "nTeamID","nPropID","damage",        "tExBuff",  },
}
GameMsg.map["FightProto:AskMoveTo"] = {
	--对象id 坐标    状态            
	{ "byte","short","byte", "",     },
	{ "oid", "pos",  "state","point",},
}
GameMsg.map["FightProto:DuplicateOver"] = {
	--结果     副本id 星级    条件数据    通关奖励          三星奖励           奖励使用的id 奖励           经验(经验池) 金币   玩家经验     星级数据    被动buf奖励     
	{ "bool",  "uint","short","array|int","list|sReward",   "list|sReward",    "uint",      "list|sReward","uint",      "uint","uint",      "array|int","list|sReward", },
	{ "bIsWin","id",  "star", "nGrade",   "fisrtPassReward","fisrt3StarReward","rewardId",  "reward",      "exp",       "gold","nPlayerExp","data",     "specialReward",},
}
GameMsg.map["FightProto:FightOver"] = {
	--结果     经验(经验池) 金币   奖励           奖励使用的id 参与战斗的卡牌(id：卡牌id, num:添加的经验) 战斗评级     玩家经验     副本id 星级    副本条件数据 翻倍                 通关奖励          三星奖励           被动buf奖励       参与战斗的卡牌(id：卡牌id, num:添加的好感度) 历史最高伤害   
	{ "bool",  "uint",      "uint","list|sReward","uint",      "list|sNumInfo",     "array|byte","uint",      "uint","short","array|int", "list|sReward",      "list|sReward",   "list|sReward",    "list|sReward",   "list|sNumInfo",     "int",         },
	{ "bIsWin","exp",       "gold","reward",      "rewardId",  "cards",             "nGrade",    "nPlayerExp","id",  "star", "nDupGrade", "sectionMultiReward","fisrtPassReward","fisrt3StarReward","passivBufReward","cardsExp",          "hisMaxDamage",},
}
GameMsg.map["FightProto:AskQuitDuplicate"] = {
	--结果   三星奖励           奖励           
	{ "bool","list|sReward",    "list|sReward",},
	{ "ret", "fisrt3StarReward","reward",      },
}
GameMsg.map["sCurrDuplicate"] = {
	--副本类型 副本id         队伍列表     
	{ "byte",  "uint",        "array|byte",},
	{ "index", "nDuplicateID","data",      },
}
GameMsg.map["FightProto:CurrDuplicate"] = {
	--结果                 副本中的队伍id 
	{ "list|sCurrDuplicate","array|int",   },
	{ "data",              "arrUsedTeam", },
}
GameMsg.map["FightProto:IsCanMove"] = {
	--是否可以移动 当前步数 
	{ "bool",      "short", },
	{ "nIsCanMove","nStep", },
}
GameMsg.map["sDuplicateTeamData"] = {
	--队伍编号     我方队伍             指挥官技能id  预留sp         预留np       集火对象类型 
	{ "int",       "list|sDuplicateCardData","int",        "bool",        "byte",      "byte",      },
	{ "nTeamIndex","team",              "nSkillGroup","bIsReserveSP","nReserveNP","nFocusFire",},
}
GameMsg.map["sDuplicateAIData"] = {
	--对象id 预留sp         预留np       集火对象类型 
	{ "byte","bool",        "byte",      "byte",      },
	{ "oid", "bIsReserveSP","nReserveNP","nFocusFire",},
}
GameMsg.map["sPosData"] = {
	--助战卡牌玩家ID 角色唯一id 行     列     
	{ "long",        "uint",    "byte","byte",},
	{ "fuid",        "cid",     "row", "col", },
}
GameMsg.map["FightProto:InBattle"] = {
	--副本类型 副本ID         军演地址信息         
	{ "byte",  "int",         "struts|sFightAddress",},
	{ "type",  "nDuplicateID","addr",              },
}
GameMsg.map["FightProto:UseProp"] = {
	--对象id 道具oid    道具类型 使用道具额外数据 
	{ "byte","byte",    "byte",  "json",          },
	{ "oid", "nPropOid","type",  "tParam",        },
}
GameMsg.map["FightProto:FocusFire"] = {
	--集火对象id     
	{ "byte",        },
	{ "nFocusFireID",},
}
GameMsg.map["FightProto:SetSkillAI"] = {
	--副本类型 数据                 
	{ "byte",  "list|sDuplicateAIData",},
	{ "index", "data",              },
}
GameMsg.map["FightProtocol:MapSetSkillAI"] = {
	--副本类型 oid    预留sp         预留np       
	{ "byte",  "byte","bool",        "byte",      },
	{ "index", "oid", "bIsReserveSP","nReserveNP",},
}
GameMsg.map["FightProto:MapSetSkillAI"] = {
	--副本类型 oid    预留sp         预留np       结果   
	{ "byte",  "byte","bool",        "byte",      "bool",},
	{ "index", "oid", "bIsReserveSP","nReserveNP","ret", },
}
GameMsg.map["FightProto:Quit"] = {
	--uid    
	{ "long",},
	{ "uid", },
}
GameMsg.map["FightProtocol:PushBox"] = {
	--副本类型 对象id 目标id  
	{ "byte",  "byte","byte", },
	{ "index", "oid", "desID",},
}
GameMsg.map["FightProtocol:DestroyProp"] = {
	--副本类型 对象id 目标id  
	{ "byte",  "byte","byte", },
	{ "index", "oid", "desID",},
}
GameMsg.map["FightProto:AskPushBox"] = {
	--对象id 坐标    目标id  目标坐标 
	{ "byte","short","byte", "short", },
	{ "oid", "pos",  "desID","desPos",},
}
GameMsg.map["FightProto:AskDestroyProp"] = {
	--对象id 目标id  
	{ "byte","byte", },
	{ "oid", "desID",},
}
GameMsg.map["FightProto:UpdateCharBuff"] = {
	--对象id buffer     
	{ "byte","json",    },
	{ "oid", "buffData",},
}
GameMsg.map["FightProto:Encounter"] = {
	--对象id 角色类型 坐标    怪物组id          状态    
	{ "byte","byte",  "short","uint",           "byte", },
	{ "oid", "type",  "pos",  "nMonsterGroupID","state",},
}
GameMsg.map["FightProto:EntryDupResult"] = {
	--是否进入成功 
	{ "bool",      },
	{ "isOk",      },
}
GameMsg.map["sSwitchAIStrategy"] = {
	--角色唯一id 助战卡牌玩家ID 策略             数据            
	{ "uint",    "long",        "byte",          "json",         },
	{ "cuid",    "fuid",        "nStrategyIndex","tStrategyData",},
}
GameMsg.map["FightProtocol:SwitchAIStrategy"] = {
	--副本类型 oid    数据                 
	{ "byte",  "byte","list|sSwitchAIStrategy",},
	{ "index", "oid", "data",              },
}
GameMsg.map["FightProtocol:RestoreFight"] = {
	--副本类型    
	{ "short",    },
	{ "nCmdIndex",},
}
GameMsg.map["FightProto:RestoreFightEnd"] = {
	--错误   
	{ "bool",},
	{ "err", },
}
GameMsg.map["FightProto:RestoreFightStart"] = {
	--重新开始  副本类型 副本ID         
	{ "bool",   "byte",  "int",         },
	{ "restart","type",  "nDuplicateID",},
}
GameMsg.map["FightProtocol:GetBossActivityInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:GetBossActivityInfo"] = {
	--活动数组             
	{ "list|FightProto:EnterBossRet",},
	{ "list",              },
}
GameMsg.map["FightProtocol:EnterBoss"] = {
	--活动id      
	{ "int",      },
	{ "nConfigID",},
}
GameMsg.map["FightProto:EnterBossRet"] = {
	--是否成功报名 活动id      boss唯一id 状态    ip       端口    boss创建时间  报名列表             血量  血量    boss所在逻辑服id 
	{ "bool",      "int",      "string",  "byte", "string","short","int",        "list|sBossPlayerInfo","int","int",  "short",         },
	{ "isApply",   "nConfigID","bossUUID","state","ip",    "port", "nCreateTime","list",              "hp", "maxhp","serverID",      },
}
GameMsg.map["FightProto:OnBossStart"] = {
	--活动id      boss唯一id 
	{ "int",      "string",  },
	{ "nConfigID","bossUUID",},
}
GameMsg.map["FightProtocol:EnterBossFight"] = {
	--boss唯一id 队伍         消耗tp    
	{ "string",  "byte",      "byte",   },
	{ "bossUUID","nTeamIndex","nCastTP",},
}
GameMsg.map["FightProto:OnBossOver"] = {
	--活动id      boss唯一id 击杀玩家id 奖励           击杀奖励       伤害      历史最高伤害 
	{ "int",      "string",  "int",     "list|sReward","list|sReward","int",    "int",       },
	{ "nConfigID","bossUUID","winner",  "reward",      "killReward",  "nDamage","nHightest", },
}
GameMsg.map["FightProto:UpdateBossHp"] = {
	--活动id      boss唯一id 血量  
	{ "int",      "string",  "int",},
	{ "nConfigID","bossUUID","hp", },
}
GameMsg.map["sBossPlayerInfo"] = {
	--uid    名字    等级    头像      
	{ "int","string","short","int",    },
	{ "uid","name",  "level","icon_id",},
}
GameMsg.map["FightProtocol:GetBossRank"] = {
	--活动id      
	{ "int",      },
	{ "nConfigID",},
}
GameMsg.map["FightProto:GetBossRankRet"] = {
	--活动数组             
	{ "list|sBossRankItem",},
	{ "list",              },
}
GameMsg.map["sBossRankItem"] = {
	--uid    名字    等级    头像      伤害      
	{ "int","string","short","int",    "int",    },
	{ "uid","name",  "level","icon_id","nDamage",},
}
GameMsg.map["FightProtocol:GetBossDamage"] = {
	--活动id      
	{ "int",      },
	{ "nConfigID",},
}
GameMsg.map["FightProto:GetBossDamageRet"] = {
	--伤害      
	{ "int",    },
	{ "nDamage",},
}
GameMsg.map["FightProtocol:GetBossHP"] = {
	--boss唯一id 
	{ "string",  },
	{ "bossUUID",},
}
GameMsg.map["FightProto:GetBossHPRet"] = {
	--血量  最大血量 状态    
	{ "int","int",   "byte", },
	{ "hp", "maxhp", "state",},
}
GameMsg.map["FightProtocol:ChangeLineToBoss"] = {
	--服务器id   
	{ "short",   },
	{ "serverID",},
}
GameMsg.map["FightProtocol:LeaveBoss"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:AddBossList"] = {
	--uid    名字    等级    头像      
	{ "int","string","short","int",    },
	{ "uid","name",  "level","icon_id",},
}
GameMsg.map["FightProtocol:EnterBattleFieldBossFight"] = {
	--队伍         
	{ "byte",      },
	{ "nTeamIndex",},
}
GameMsg.map["FightProtocol:ModUpFightDuplicate"] = {
	--副本类型 副本id         编队信息             是否用多倍奖励  进行扫荡次数 
	{ "byte",  "uint",        "list|sDuplicateTeamData","bool",         "uint",      },
	{ "index", "nDuplicateID","list",              "isMultiReward","modUpCnt",  },
}
GameMsg.map["FightProto:ModUpFightOver"] = {
	--经验(经验池) 金币   奖励                参与战斗的卡牌(id：卡牌id, num:添加的经验) 战斗评级     玩家经验     副本id 星级    被动buf奖励          参与战斗的卡牌(id：卡牌id, num:添加的好感度) 被动buf奖励         
	{ "uint",      "uint","list|sModUpReward","list|sNumInfo",     "array|byte","uint",      "uint","short","list|sModUpReward", "list|sNumInfo",     "list|sModUpReward",},
	{ "exp",       "gold","rewardList",       "cards",             "nGrade",    "nPlayerExp","id",  "star", "passivBufRewardList","cardsExp",          "specialRewardList",},
}
GameMsg.map["sModUpReward"] = {
	--第几次扫荡   奖励           
	{ "byte",      "list|sReward",},
	{ "modUpIndex","reward",      },
}
GameMsg.map["sRogueDuplicateData"] = {
	--关卡组ID 最高回合数 历史最小操作数 
	{ "uint",  "uint",    "uint",        },
	{ "id",    "maxRound","minSteps",    },
}
GameMsg.map["FightProtocol:GetRogueInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:GetRogueInfoRet"] = {
	--数据                 是否完了    已通关最大关卡组 是否战斗中   
	{ "list|sRogueDuplicateData","bool",     "uint",          "bool",      },
	{ "datas",             "is_finish","maxGroup",      "isFighting",},
}
GameMsg.map["FightProto:FightingRogueData"] = {
	--副本类型 关卡组ID 关卡轮次 已选择词条组  随机词条组    已选卡牌    编队信息             副本id        目前总操作数 
	{ "byte",  "uint",  "uint",  "array|uint", "array|uint", "json",     "list|sDuplicateTeamData","uint",       "uint",      },
	{ "index", "group", "round", "selectBuffs","randomBuffs","selectPos","list",              "duplicateID","steps",     },
}
GameMsg.map["FightProtocol:EnterRogueDuplicate"] = {
	--副本类型 关卡组ID 编队信息             
	{ "byte",  "uint",  "list|sDuplicateTeamData",},
	{ "index", "group", "list",              },
}
GameMsg.map["FightProtocol:RogueSelectBuff"] = {
	--所选BUFF 
	{ "uint",  },
	{ "buff",  },
}
GameMsg.map["FightProto:RogueSelectBuffRet"] = {
	--已选择词条组  
	{ "array|uint", },
	{ "selectBuffs",},
}
GameMsg.map["FightProtocol:RogueSelectPos"] = {
	--选择卡牌位置 
	{ "uint",      },
	{ "pos",       },
}
GameMsg.map["FightProto:RogueSelectPosRet"] = {
	--已选卡牌    
	{ "json",     },
	{ "selectPos",},
}
GameMsg.map["FightProtocol:EnterRogueFight"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProtocol:QuitRogueFight"] = {
	--是否保存进度 退出类型   
	{ "bool",      "short",   },
	{ "save",      "quitType",},
}
GameMsg.map["FightProto:RogueOver"] = {
	--结果     当前关卡轮次 关卡组ID 总操作数 通关奖励          是否保存进度 经验(卡牌) 玩家经验     参与战斗的卡牌(id：卡牌id, num:添加的好感度) 已选择词条组  退出类型   
	{ "bool",  "uint",      "uint",  "uint",  "list|sReward",   "bool",      "uint",    "uint",      "list|sNumInfo",     "array|uint", "short",   },
	{ "bIsWin","round",     "group", "steps", "fisrtPassReward","save",      "exp",     "nPlayerExp","cardsExp",          "selectBuffs","quitType",},
}
GameMsg.map["sRogueSDuplicateData"] = {
	--关卡组ID 目前总星数 星级数据     
	{ "uint",  "uint",    "array|byte",},
	{ "id",    "stars",   "star_data", },
}
GameMsg.map["FightProtocol:GetRogueSInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:GetRogueSInfoRet"] = {
	--数据                 是否完了    已通关最大关卡组 是否战斗中   星数奖励领取情况     
	{ "list|sRogueSDuplicateData","bool",     "uint",          "bool",      "list|sGetDupSumStarReward",},
	{ "datas",             "is_finish","maxGroup",      "isFighting","gained",            },
}
GameMsg.map["FightProto:FightingRogueSData"] = {
	--关卡组ID 关卡轮次 目前总操作数 
	{ "uint",  "uint",  "uint",      },
	{ "group", "round", "steps",     },
}
GameMsg.map["FightProtocol:EnterRogueSDuplicate"] = {
	--关卡组ID 编队信息             
	{ "uint",  "list|sDuplicateTeamData",},
	{ "id",    "list",              },
}
GameMsg.map["FightProtocol:EnterRogueSFight"] = {
	--选择的关卡轮次 
	{ "uint",        },
	{ "round",       },
}
GameMsg.map["FightProto:EnterRogueSFightRet"] = {
	--选择的关卡轮次 
	{ "uint",        },
	{ "round",       },
}
GameMsg.map["FightProto:RogueSOver"] = {
	--结果     当前关卡轮次 关卡组ID 总操作数 当前副本总星数 星级数据     参与战斗的卡牌(id：卡牌id, num:添加的好感度) 
	{ "bool",  "uint",      "uint",  "uint",  "uint",        "array|byte","list|sNumInfo",     },
	{ "bIsWin","round",     "group", "steps", "stars",       "star_data", "cardsExp",          },
}
GameMsg.map["FightProtocol:RogueSQuit"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:RogueSQuitRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProtocol:RogueSGain"] = {
	--类型   
	{ "uint",},
	{ "ty",  },
}
GameMsg.map["FightProto:RogueSGainRet"] = {
	--类型   星数奖励领取情况     
	{ "uint","list|sGetDupSumStarReward",},
	{ "ty",  "gained",            },
}
GameMsg.map["FightProto:GlobalBossInfoRet"] = {
	--bossid   开始时间    结束时间  血量     
	{ "int",   "uint",     "uint",   "double",},
	{ "bossId","beginTime","endTime","hp",    },
}
GameMsg.map["FightProtocol:GetGlobalBossData"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:GetGlobalBossDataRet"] = {
	--血量     最大血量 玩家排名 今日已挑战次数   最高伤害值  参与人数  词条id      
	{ "double","double","uint",  "uint",          "long",     "int",    "array|int",},
	{ "hp",    "maxHp", "rank",  "challengeTimes","maxDamage","joinNum","buffIds",  },
}
GameMsg.map["FightProtocol:EnterGlobalBossFight"] = {
	--队伍         
	{ "uint",      },
	{ "nTeamIndex",},
}
GameMsg.map["FightProtocol:GetGlobalBossRank"] = {
	--第几页  
	{ "int",  },
	{ "nPage",},
}
GameMsg.map["sGlobalBossRankItem"] = {
	--排名   伤害       名字    等级    头像      头像框       玩家称号     阵容卡牌缩略数据  
	{ "int", "long",   "string","short","int",    "int",       "uint",      "list|sCardsData",},
	{ "rank","nDamage","name",  "level","icon_id","icon_frame","icon_title","cardInfos",      },
}
GameMsg.map["FightProto:GetGlobalBossRankRet"] = {
	--排名数据             我的排名 我的伤害  
	{ "list|sGlobalBossRankItem","int",   "long",   },
	{ "data",              "rank",  "nDamage",},
}
GameMsg.map["FightProtocol:GetGlobalBossRankTeam"] = {
	--第几名    
	{ "int",    },
	{ "rankIdx",},
}
GameMsg.map["FightProto:GetGlobalBossRankTeamRet"] = {
	--第几名    队伍数据        
	{ "int",    "list|TeamItem",},
	{ "rankIdx","data",         },
}
GameMsg.map["sRogueTBuffs"] = {
	--下标   单个存档的buff数组 
	{ "uint","array|uint",      },
	{ "idx", "tBuff",           },
}
GameMsg.map["sRogueTDuplicateData"] = {
	--关卡组ID（难度ID） 历史最高伤害 已存档buff          首通奖励          是否通关(解锁无限血关) 当前使用buff组下标 
	{ "uint",            "string",    "list|sRogueTBuffs","bool",           "bool",              "uint",            },
	{ "id",              "maxDamage", "buffs",            "firstPassReward","pass",              "useBuff",         },
}
GameMsg.map["FightProtocol:GetRogueTInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:GetRogueTInfoRet"] = {
	--关卡组数据                       总积分（不重置） 阶段奖励等级（不重置） 本期累计分数（月重置） 周期奖励下标（月重置） 最大通关难度 打过的最大无限血关难度(关卡组ID)，只显示在排行榜 周期奖励最后一次弹窗时间（初始0） 等级奖励扩充下标 
	{ "list|sRogueTDuplicateData","bool",     "uint",          "uint",               "uint",               "uint",               "uint",      "uint",               "uint",               "uint",          },
	{ "data",              "is_finish","score",         "stageIdx",           "monthScore",         "periodIdx",          "maxGroup",  "maxBoss",            "win1",               "win2",          },
}
GameMsg.map["FightProtocol:EnterRogueTDuplicate"] = {
	--关卡组ID（难度ID） 是否无限血关 
	{ "uint",            "bool",      },
	{ "id",              "boss",      },
}
GameMsg.map["FightProto:FightingRogueTData"] = {
	--关卡组ID（难度ID） 当前关卡       当前积分 随机buffs     已选择buffs   剩余货币 已刷新buff次数 
	{ "uint",            "uint",        "uint",  "array|uint", "array|uint", "uint",  "uint",        },
	{ "id",              "nDuplicateID","score", "randomBuffs","selectBuffs","coin",  "times",       },
}
GameMsg.map["FightProtocol:EnterRogueTFight"] = {
	--编队信息             
	{ "list|sDuplicateTeamData",},
	{ "list",              },
}
GameMsg.map["FightProtocol:RogueTSelectBuff"] = {
	--buffid 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["FightProto:RogueTSelectBuffRet"] = {
	--已选择buffs   
	{ "array|uint", },
	{ "selectBuffs",},
}
GameMsg.map["FightProtocol:RogueTBuffUp"] = {
	--buffID 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["FightProto:RogueTBuffUpRet"] = {
	--原buffid 升级后的Buffid 
	{ "uint",  "uint",        },
	{ "id",    "new_id",      },
}
GameMsg.map["FightProto:RogueTOver"] = {
	--输赢     当前关卡       已选择buffs   本次获得货币 总货币 总积分  本次获得积分 玩家经验     参与战斗的卡牌(id：卡牌id, num:添加的好感度) 奖励           无限血关伤害 
	{ "bool",  "uint",        "array|uint", "uint",      "uint","uint", "uint",      "uint",      "list|sNumInfo",     "list|sReward","string",    },
	{ "bIsWin","nDuplicateID","selectBuffs","coinGet",   "coin","score","scoreGet",  "nPlayerExp","cardsExp",          "rewards",     "damage",    },
}
GameMsg.map["FightProtocol:RogueTBuffSave"] = {
	--是否存档 存档下标 
	{ "bool",  "uint",  },
	{ "save",  "idx",   },
}
GameMsg.map["FightProto:RogueTBuffSaveRet"] = {
	--是否存档 存档下标 已选择buffs   
	{ "bool",  "uint",  "array|uint", },
	{ "save",  "idx",   "selectBuffs",},
}
GameMsg.map["FightProtocol:RogueTQuit"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:RogueTQuitRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProtocol:RogueTUseBuff"] = {
	--关卡组ID（难度ID） 当前使用buff组下标 
	{ "uint",            "uint",            },
	{ "id",              "useBuff",         },
}
GameMsg.map["FightProto:RogueTUseBuffRet"] = {
	--关卡组ID（难度ID） 当前使用buff组下标 
	{ "uint",            "uint",            },
	{ "id",              "useBuff",         },
}
GameMsg.map["FightProtocol:RogueTDelBuff"] = {
	--关卡组ID（难度ID） 存档下标 
	{ "uint",            "uint",  },
	{ "id",              "idx",   },
}
GameMsg.map["FightProto:RogueTDelBuffRet"] = {
	--关卡组ID（难度ID） 存档下标 
	{ "uint",            "uint",  },
	{ "id",              "idx",   },
}
GameMsg.map["FightProtocol:RogueTGainReward"] = {
	--类型   
	{ "uint",},
	{ "ty",  },
}
GameMsg.map["FightProto:RogueTGainRewardRet"] = {
	--类型   对应类型的奖励下标 
	{ "uint","uint",            },
	{ "ty",  "idx",             },
}
GameMsg.map["FightProtocol:RogueTSetWindow"] = {
	--类型   值      
	{ "uint","uint", },
	{ "ty",  "value",},
}
GameMsg.map["FightProto:RogueTSetWindowRet"] = {
	--类型   值      
	{ "uint","uint", },
	{ "ty",  "value",},
}
GameMsg.map["FightProtocol:GlobalBossMopUp"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:GlobalBossMopUpRet"] = {
	--奖励           伤害      历史最高伤害 
	{ "list|sReward","long",   "long",      },
	{ "reward",      "nDamage","nHightest", },
}
GameMsg.map["FightProtocol:EnterFightBuffBattleDuplicate"] = {
	--副本类型 副本id         编队信息             是否用多倍奖励  词条列表    
	{ "byte",  "uint",        "list|sDuplicateTeamData","bool",         "array|int",},
	{ "index", "nDuplicateID","list",              "isMultiReward","buffs",    },
}
GameMsg.map["sRogueMapGroupData"] = {
	--关卡组ID 是否首通    
	{ "uint",  "bool",     },
	{ "id",    "firstPass",},
}
GameMsg.map["sRogueMapData"] = {
	--格子类型 id     坐标   状态    额外数据 
	{ "uint",  "uint","uint","byte", "json",  },
	{ "ty",    "id",  "pos", "state","exData",},
}
GameMsg.map["sRogueMapBuff"] = {
	--        类型   buffid 剩余场次 
	{ "uint", "uint","uint","uint",  },
	{ "index","ty",  "id",  "round", },
}
GameMsg.map["FightProtocol:GetRogueMapInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:GetRogueMapInfoRet"] = {
	--关卡组数据           今日剩余可摇骰子数 是否有正在进行中的小地图 局外危险等级经验 今日已支援次数  正在进行的小地图是否模拟 是否有支援奖励可领 是否有新好友求援   今日已求援次数  
	{ "list|sRogueMapGroupData","uint",            "uint",               "uint",          "uint",         "bool",               "bool",            "bool",            "uint",         },
	{ "groupData",         "rollCnt",         "nDuplicateID",       "nDupExp",       "nSupportTimes","isSimulated",        "hasRewardBubble", "hasSupportBubble","nRequireTimes",},
}
GameMsg.map["FightProtocol:EnterRogueMapDuplicate"] = {
	--关卡ID         是否模拟      编队信息             
	{ "uint",        "bool",       "list|sDuplicateTeamData",},
	{ "nDuplicateID","isSimulated","list",              },
}
GameMsg.map["FightProto:FightingRogueMapData"] = {
	--关卡ID         是否模拟      已行动步数 整个地图数据         已解锁格子   是否可摇骰子 角色列表             编队信息             局内危险等级经验 局内BUFF             是否弹求援窗口  今日已求援次数  是否弹过通关窗口 锁定危险等级 可触发战斗 
	{ "uint",        "bool",       "uint",    "list|sRogueMapData","array|uint","bool",      "list|sDuplicateCharData","list|sDuplicateTeamData","uint",          "list|sRogueMapBuff","bool",         "uint",         "bool",          "bool",      "bool",    },
	{ "nDuplicateID","isSimulated","nStep",   "map",               "unlockPos", "canRoll",   "arrChar",           "list",              "nExp",          "buffs",             "supportWindow","nRequireTimes","passWindow",    "lockLevel", "canFight",},
}
GameMsg.map["FightProtocol:RogueMapRoll"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:RogueMapRollRet"] = {
	--角色列表             是否可摇骰子 局内危险等级经验 今日剩余可摇骰子数 
	{ "list|sDuplicateCharData","bool",      "uint",          "uint",            },
	{ "arrChar",           "canRoll",   "nExp",          "rollCnt",         },
}
GameMsg.map["FightProtocol:RogueMapMove"] = {
	--路径         
	{ "array|uint",},
	{ "path",      },
}
GameMsg.map["FightProto:RogueMapMoveRet"] = {
	--路径         已解锁格子   角色列表             
	{ "array|uint","array|uint","list|sDuplicateCharData",},
	{ "path",      "unlockPos", "arrChar",           },
}
GameMsg.map["FightProtocol:RogueMapMoveEnd"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:RogueMapMoveEndRet"] = {
	--局内危险等级经验 是否可摇骰子 局内BUFF             已行动步数 今日剩余可摇骰子数 移动结束触发格子类型 触发格子额外数据 可触发战斗 
	{ "uint",          "bool",      "list|sRogueMapBuff","uint",    "uint",            "uint",              "json",          "bool",    },
	{ "nExp",          "canRoll",   "buffs",             "nStep",   "rollCnt",         "ty",                "tParam",        "canFight",},
}
GameMsg.map["FightProtocol:RogueMapUseProp"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:RogueMapUsePropRet"] = {
	--道具类型 使用道具额外数据 
	{ "uint",  "json",          },
	{ "ty",    "tParam",        },
}
GameMsg.map["FightProtocol:RogueMapEnterFight"] = {
	--队伍ID(进入战斗需要) BOSS位置 是否模拟      
	{ "uint",              "uint",  "bool",       },
	{ "id",                "pos",   "isSimulated",},
}
GameMsg.map["FightProto:RogueMapFightOver"] = {
	--输赢     参与战斗的卡牌(id：卡牌id, num:添加的好感度) 奖励           角色列表             局内危险等级经验 是否模拟      
	{ "bool",  "list|sNumInfo",     "list|sReward","list|sDuplicateCharData","uint",          "bool",       },
	{ "bIsWin","cardsExp",          "reward",      "arrChar",           "nExp",          "isSimulated",},
}
GameMsg.map["FightProtocol:RogueMapQuit"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProtocol:RogueMapFightQuit"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProtocol:RogueMapBuyRoll"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:RogueMapBuyRollRet"] = {
	--今日剩余可摇骰子数 本次购买骰子数 
	{ "uint",            "uint",        },
	{ "rollCnt",         "buyCnt",      },
}
GameMsg.map["FightProto:RogueMapOver"] = {
	--关卡ID         已行动步数 奖励           局内危险等级经验 局外危险等级经验 是否通关 
	{ "uint",        "uint",    "list|sReward","uint",          "uint",          "bool",  },
	{ "nDuplicateID","nStep",   "reward",      "nExp",          "nDupExp",       "isPass",},
}
GameMsg.map["sRogueMapSupport"] = {
	--求援类型 id     名字      头像     最大血量 剩余血量 支援中人数 发起时间 失效时间 求援序列值 求援类型 副本id   奖励           怪物组ID       
	{ "short", "uint","string","uint",   "uint",  "uint",  "uint",    "uint",  "uint",  "uint",    "short", "uint",  "list|sReward","uint",        },
	{ "ty",    "uid", "name",  "icon_id","max_hp","cur_hp","s_cnt",   "s_time","f_time","s_ix",    "ty",    "cfg_id","reward",      "monsterGroup",},
}
GameMsg.map["FightProtocol:RogueMapRequireHelp"] = {
	--求援类型 boss坐标 
	{ "short", "uint",  },
	{ "ty",    "pos",   },
}
GameMsg.map["FightProto:RogueMapRequireHelpRet"] = {
	--求援类型 boss坐标 求援信息更新         今日已求援次数  
	{ "short", "uint",  "struts|sRogueMapSupport","uint",         },
	{ "ty",    "pos",   "info",              "nRequireTimes",},
}
GameMsg.map["FightProtocol:RogueMapSupportList"] = {
	--求援类型(传空则优先返回好友的，好友为空时返回全体的) 章节分组 
	{ "short",             "uint",  },
	{ "ty",                "group", },
}
GameMsg.map["FightProto:RogueMapSupportListRet"] = {
	--求援类型 章节分组 求援列表             我的求援             是否有新日志 援助奖励限制（活动重置） 上次请求时间  
	{ "short", "uint",  "list|sRogueMapSupport","list|sRogueMapSupport","bool",      "array|uint",         "uint",       },
	{ "ty",    "group", "arr",               "myArr",             "hasNewLog", "supRewardLimit",     "lastReqTime",},
}
GameMsg.map["sRogueMapSupportLog"] = {
	--求援类型 玩家id 玩家名字 支援时间 剩余血量百分比[0为打死] 是否自己支援别人 副本id   怪物组ID       是否新日志未查看 
	{ "short", "uint","string","uint",  "float",              "bool",          "uint",  "uint",        "bool",          },
	{ "ty",    "id",  "name",  "time",  "left_hp_percent",    "isHelp",        "cfg_id","monsterGroup","isNew",         },
}
GameMsg.map["FightProtocol:RogueMapSupportLog"] = {
	--第几页[从0开始] 
	{ "short",        },
	{ "page",         },
}
GameMsg.map["FightProto:RogueMapSupportLogRet"] = {
	--第几页[从0开始] 求援日志             
	{ "short",        "list|sRogueMapSupportLog",},
	{ "page",         "arr",               },
}
GameMsg.map["FightProtocol:RogueMapOneSupport"] = {
	--好友id或者自己的id 
	{ "uint",            },
	{ "uid",             },
}
GameMsg.map["FightProto:RogueMapOneSupportRet"] = {
	--好友id或者自己的id 求援列表             
	{ "uint",            "list|sRogueMapSupport",},
	{ "uid",             "arr",               },
}
GameMsg.map["FightProtocol:RogueMapSupportApply"] = {
	--求援者uid 求援序列值 编队信息             章节分组 
	{ "uint",   "uint",    "list|sDuplicateTeamData","uint",  },
	{ "uid",    "s_ix",    "list",              "group", },
}
GameMsg.map["FightProto:RogueMapSupportFightOver"] = {
	--求援者uid 输赢     求援序列值 求援信息更新         求援日志信息更新     今日已支援次数  参与战斗的卡牌(id：卡牌id, num:添加的好感度) 奖励           援助奖励限制（活动重置） 
	{ "uint",   "bool",  "uint",    "struts|sRogueMapSupport","struts|sRogueMapSupportLog","uint",         "list|sNumInfo",     "list|sReward","array|uint",         },
	{ "uid",    "bIsWin","s_ix",    "info",              "log",               "nSupportTimes","cardsExp",          "reward",      "supRewardLimit",     },
}
GameMsg.map["FightProto:RogueMapSupportUpdate"] = {
	--求援信息更新         求援日志信息更新     
	{ "struts|sRogueMapSupport","struts|sRogueMapSupportLog",},
	{ "info",              "log",               },
}
GameMsg.map["FightProtocol:RogueMapSupportCancel"] = {
	--求援序列值 
	{ "uint",    },
	{ "s_ix",    },
}
GameMsg.map["FightProto:RogueMapSupportCancelRet"] = {
	--求援序列值 
	{ "uint",    },
	{ "s_ix",    },
}
GameMsg.map["FightProtocol:RogueMapRequireGainReward"] = {
	--领取类型 求援序列值 
	{ "uint",  "uint",    },
	{ "ty",    "s_ix",    },
}
GameMsg.map["FightProto:RogueMapRequireGainRewardRet"] = {
	--领取类型 领取成功的求援序列值 
	{ "uint",  "array|uint",        },
	{ "ty",    "s_ixs",             },
}
GameMsg.map["FightProtocol:RogueMapNeedSupport"] = {
	--是否需要求援  
	{ "bool",       },
	{ "needSupport",},
}
GameMsg.map["FightProto:RogueMapNeedSupportRet"] = {
	--是否需要求援  
	{ "bool",       },
	{ "needSupport",},
}
GameMsg.map["FightProto:RogueMapFriendNeedSupport"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProtocol:RogueMapPassWindow"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:RogueMapUpdateMap"] = {
	--变动格子数据列表     
	{ "list|sRogueMapData",},
	{ "changePos",         },
}
GameMsg.map["FightProtocol:RogueMapLevelSet"] = {
	--锁定危险等级 要降到的等级 
	{ "bool",      "uint",      },
	{ "lockLevel", "setLevel",  },
}
GameMsg.map["FightProto:RogueMapLevelSetRet"] = {
	--锁定危险等级 要降到的等级 降级完后当前局内经验 
	{ "bool",      "uint",      "uint",              },
	{ "lockLevel", "setLevel",  "nExp",              },
}
GameMsg.map["FightProtocol:RogueMapSelectBuff"] = {
	--槽位下标 延长回合或替换 
	{ "uint",  "uint",        },
	{ "idx",   "ty",          },
}
GameMsg.map["FightProto:RogueMapSelectBuffRet"] = {
	--槽位下标 延长回合或替换 局内BUFF             
	{ "uint",  "uint",        "list|sRogueMapBuff",},
	{ "idx",   "ty",          "buffs",             },
}
GameMsg.map["FightProtocol:GetMultTeamData"] = {
	--活动id 周目    
	{ "uint","uint", },
	{ "id",  "round",},
}
GameMsg.map["sMultTeamHpData"] = {
	--战斗周目 怪物血量     
	{ "int",   "array|uint",},
	{ "stage", "data",      },
}
GameMsg.map["sMultTeamDupData"] = {
	--关卡id  当前总血量 总最大血量   怪物血量数据         当前关卡已获得分数 
	{ "int",  "int",     "int",       "struts|sMultTeamHpData","int",             },
	{ "dupId","totalHp", "totalMaxHp","hpData",            "score",           },
}
GameMsg.map["FightProto:GetMultTeamDataRet"] = {
	--活动id 周目    关卡组ID 已通关关卡   今日已上阵过的卡牌id 是否已经领过结算奖励 关卡数据             
	{ "uint","uint", "uint",  "array|uint","array|uint",        "bool",              "list|sMultTeamDupData",},
	{ "id",  "round","group", "arrPass",   "arrCard",           "isSettle",          "dupData",           },
}
GameMsg.map["FightProtocol:EnterMultTeamFight"] = {
	--活动id 周目    关卡id  编队信息             
	{ "uint","uint", "uint", "list|sDuplicateTeamData",},
	{ "id",  "round","dupId","list",              },
}
GameMsg.map["FightProtocol:GetSettleReward"] = {
	--活动id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["FightProto:MultTeamFightOver"] = {
	--副本id 本次获得积分 关卡数据             结果     已通关关卡   奖励           今日已上阵过的卡牌id 
	{ "uint","uint",      "list|sMultTeamDupData","bool",  "array|uint","list|sReward","array|uint",        },
	{ "id",  "score",     "dupData",           "bIsWin","arrPass",   "reward",      "arrCard",           },
}
GameMsg.map["sTowerDeepDuplicateData"] = {
	--关卡组ID 积分    已获得奖励档位 是否通关 
	{ "uint",  "uint", "array|uint",  "bool",  },
	{ "id",    "score","getRwdLv",    "isPass",},
}
GameMsg.map["FightProtocol:GetTowerDeepInfo"] = {
	--活动id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["FightProto:GetTowerDeepInfoRet"] = {
	--活动id 关卡组数据           已通关最大关卡组 
	{ "uint","list|sTowerDeepDuplicateData","uint",          },
	{ "id",  "datas",             "maxGroup",      },
}
GameMsg.map["FightProtocol:EnterTowerDeepDuplicate"] = {
	--关卡组ID 编队信息             
	{ "uint",  "list|sDuplicateTeamData",},
	{ "id",    "list",              },
}
GameMsg.map["FightProtocol:EnterTowerDeepFight"] = {
	--选择的关卡轮次 
	{ "uint",        },
	{ "round",       },
}
GameMsg.map["FightProto:EnterTowerDeepFightRet"] = {
	--选择的关卡轮次 
	{ "uint",        },
	{ "round",       },
}
GameMsg.map["FightProto:TowerDeepFightOver"] = {
	--结果     当前关卡轮次 关卡组ID 总操作数 分数    参与战斗的卡牌(id：卡牌id, num:添加的好感度) 历史最高分数 奖励           
	{ "bool",  "uint",      "uint",  "uint",  "uint", "list|sNumInfo",     "uint",      "list|sReward",},
	{ "bIsWin","round",     "group", "steps", "score","cardsExp",          "maxScore",  "reward",      },
}
GameMsg.map["FightProtocol:GetChainFrontInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:GetChainFrontInfoRet"] = {
	--活动id 最高分     最近一次各怪物关卡分数 进度信息             
	{ "uint","uint",    "list|sPairIntInt",   "struts|sChainFrontProgressInfo",},
	{ "id",  "maxScore","dupScore",           "progressInfo",      },
}
GameMsg.map["FightProtocol:EnterChainFrontDuplicate"] = {
	--关卡组ID 编队信息             已选择词条组  
	{ "uint",  "list|sDuplicateTeamData","array|uint", },
	{ "id",    "list",              "selectBuffs",},
}
GameMsg.map["FightProtocol:EnterChainFrontFight"] = {
	--选择的关卡轮次 
	{ "uint",        },
	{ "round",       },
}
GameMsg.map["FightProto:EnterChainFrontFightRet"] = {
	--选择的关卡轮次 
	{ "uint",        },
	{ "round",       },
}
GameMsg.map["FightProto:ChainFrontFightOver"] = {
	--结果     当前关卡轮次 关卡组ID 分数    参与战斗的卡牌(id：卡牌id, num:添加的好感度) 
	{ "bool",  "uint",      "uint",  "uint", "list|sNumInfo",     },
	{ "bIsWin","round",     "group", "score","cardsExp",          },
}
GameMsg.map["FightProtocol:DuplicateBuild"] = {
	--操作类型 关卡ID         建造下标   
	{ "uint",  "uint",        "uint",    },
	{ "ty",    "nDuplicateID","buildIdx",},
}
GameMsg.map["FightProto:DuplicateBuildRet"] = {
	--操作类型 关卡ID         建造下标   关卡数据             
	{ "uint",  "uint",        "uint",    "struts|DuplicateItemData",},
	{ "ty",    "nDuplicateID","buildIdx","data",              },
}
GameMsg.map["sChainFrontProgressInfo"] = {
	--关卡组ID 当前轮次 是否在战斗中 已锁轮次     已锁轮次助战卡牌数据 
	{ "uint",  "uint",  "byte",      "array|uint","list|sChainFrontAssistRoleInfo",},
	{ "group", "round", "isFighting","lockRounds","lockAssistRoles",   },
}
GameMsg.map["FightProtocol:UpdateChainFrontTeam"] = {
	--关卡组ID 编队信息             已选择词条组  
	{ "uint",  "list|sDuplicateTeamData","array|uint", },
	{ "id",    "list",              "selectBuffs",},
}
GameMsg.map["FightProto:UpdateChainFrontTeamRet"] = {
	--结果码 进度信息             
	{ "int", "struts|sChainFrontProgressInfo",},
	{ "code","progressInfo",      },
}
GameMsg.map["FightProtocol:GiveUpChainFront"] = {
	--关卡组ID 
	{ "uint",  },
	{ "id",    },
}
GameMsg.map["FightProto:GiveUpChainFrontRet"] = {
	--结果码 进度信息             
	{ "int", "struts|sChainFrontProgressInfo",},
	{ "code","progressInfo",      },
}
GameMsg.map["sChainFrontAssistRoleInfo"] = {
	--轮次    当前轮次             
	{ "uint", "struts|sDuplicateCardData",},
	{ "round","role",              },
}
GameMsg.map["FightProto:TrialChallengeScoreRet"] = {
	--关卡组ID 分数    
	{ "uint",  "uint", },
	{ "dupId", "score",},
}
GameMsg.map["sPeriodicBossData"] = {
	--BOSSid 本期单次最高伤害 排名     已领取奖励下标 本期剩余挑战次数 
	{ "uint","string",        "string","uint",        "uint",          },
	{ "id",  "maxDamage",     "rank",  "rewardIdx",   "cnt",           },
}
GameMsg.map["FightProtocol:GetPeriodicBossInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["FightProto:GetPeriodicBossInfoRet"] = {
	--                     
	{ "list|sPeriodicBossData",},
	{ "info",              },
}
GameMsg.map["FightProtocol:PeriodicBossEnterFight"] = {
	--BOSSid 是否模拟战斗  编队信息             
	{ "uint","bool",       "list|sDuplicateTeamData",},
	{ "id",  "isSimulated","list",              },
}
GameMsg.map["FightProto:PeriodicBossFightOver"] = {
	--输赢     本次伤害 本期单次最高伤害 奖励           参与战斗的卡牌(id：卡牌id, num:添加的经验) 玩家经验     
	{ "bool",  "string","string",        "list|sReward","list|sNumInfo",     "uint",      },
	{ "bIsWin","damage","maxDamage",     "reward",      "cards",             "nPlayerExp",},
}
GameMsg.map["ItemData"] = {
	--id     数量  第一个获取时间 有效期序列值(结合配置表的sExpiry使用, 导表工具会生成nExpiry) 过期时间，不需要分开堆叠显示的使用[头像框] 分批获取的信息 
	{ "uint","int","uint",        "short",             "uint",               "json",        },
	{ "id",  "num","time",        "ix",                "expiry",             "get_infos",   },
}
GameMsg.map["PlayerProto:ItemBag"] = {
	--物品列表        序列值，每次发送从1开始 是否完结    
	{ "list|ItemData","short",             "bool",     },
	{ "item",         "ix",                "is_finish",},
}
GameMsg.map["PlayerProto:ItemFull"] = {
	--id     
	{ "uint",},
	{ "id",  },
}
GameMsg.map["sItemUpdate"] = {
	--id     增加或减少 数量  第一个获取时间 有效期序列值(结合配置表的sExpiry使用, 导表工具会生成nExpiry) 过期时间，不需要分开堆叠显示的使用[头像框] 分批获取的信息 
	{ "uint","int",     "int","uint",        "short",             "uint",               "json",        },
	{ "id",  "add",     "num","time",        "ix",                "expiry",             "get_infos",   },
}
GameMsg.map["PlayerProto:ItemUpdate"] = {
	--数据               
	{ "list|sItemUpdate",},
	{ "data",            },
}
GameMsg.map["sUseIteminfo"] = {
	--物品id 多过期时间，选择使用的下标 使用数量 使用参数1, 如选择类型的礼包发配置表的index 获得的物品      
	{ "uint","short",              "uint",  "uint",              "list|sNumInfo",},
	{ "id",  "ix",                 "cnt",   "arg1",              "gets",         },
}
GameMsg.map["PlayerProto:UseItem"] = {
	--                     
	{ "struts|sUseIteminfo",},
	{ "info",              },
}
GameMsg.map["PlayerProto:UseItemRet"] = {
	--                     是否需要前端合并 
	{ "struts|sUseIteminfo","bool",          },
	{ "info",              "isMerge",       },
}
GameMsg.map["TeamItemData"] = {
	--卡牌的唯一id 位置    行      列      卡牌的信息(排行榜阵容) 卡牌的信息(实时战斗才设置) 策略             是否是NPC 
	{ "uint",      "byte", "short","short","struts|sCardsData", "struts|sPvpCardsData","byte",          "bool",   },
	{ "cid",       "index","row",  "col",  "card_info",         "pvp_card_info",     "nStrategyIndex","bIsNpc", },
}
GameMsg.map["TeamItem"] = {
	--队伍类型 数据                队长cid  队伍名字 技能组id         技能组等级       性能          预留sp         预留np       
	{ "byte",  "list|TeamItemData","uint",  "string","uint",          "uint",          "uint",       "bool",        "byte",      },
	{ "index", "data",             "leader","name",  "skill_group_id","skill_group_lv","performance","bIsReserveSP","nReserveNP",},
}
GameMsg.map["PlayerProto:TeamData"] = {
	--数据            可以使用的数量 是否发完   
	{ "list|TeamItem","byte",        "bool",    },
	{ "data",         "count",       "isFinish",},
}
GameMsg.map["PlayerProto:SetTeamData"] = {
	--                  
	{ "struts|TeamItem",},
	{ "info",           },
}
GameMsg.map["PlayerProto:SetTeamResult"] = {
	--                  
	{ "struts|TeamItem",},
	{ "info",           },
}
GameMsg.map["PlayerProto:BuyTeam"] = {
	--队伍类型 
	{ "byte",  },
	{ "index", },
}
GameMsg.map["PlayerProto:BuyTeamResult"] = {
	--结果   可以使用的数量 
	{ "bool","byte",        },
	{ "ret", "count",       },
}
GameMsg.map["PlayerProto:SwitchAIStrategy"] = {
	--编队id       第几个卡牌   策略             
	{ "byte",      "byte",      "byte",          },
	{ "nTeamIndex","nCardIndex","nStrategyIndex",},
}
GameMsg.map["PlayerProto:SwitchAIStrategyRes"] = {
	--结果   
	{ "bool",},
	{ "ret", },
}
GameMsg.map["sSetAIStrategyData"] = {
	--编队id       第几个卡牌   策略             数据            是否应用 
	{ "byte",      "byte",      "byte",          "json",         "bool",  },
	{ "nTeamIndex","nCardIndex","nStrategyIndex","tStrategyData","bApply",},
}
GameMsg.map["PlayerProto:SetAIStrategy"] = {
	--数据                 
	{ "list|sSetAIStrategyData",},
	{ "data",              },
}
GameMsg.map["PlayerProto:SetAIStrategyRes"] = {
	--结果   
	{ "bool",},
	{ "ret", },
}
GameMsg.map["PlayerProto:GetAIStrategy"] = {
	--卡牌id       
	{ "array|uint",},
	{ "cid",       },
}
GameMsg.map["sGetAIStrategyRet"] = {
	--卡牌id 数据            
	{ "uint","json",         },
	{ "cid", "tStrategyData",},
}
GameMsg.map["PlayerProto:GetAIStrategyRet"] = {
	--数据                 
	{ "list|sGetAIStrategyRet",},
	{ "data",              },
}
GameMsg.map["sCardMixData"] = {
	--在远征为1, 不在为 nil 开始自动恢复热值的时间 核心等级（叫突破，突破等级上限) 专武等级   
	{ "byte",              "long",               "byte",               "uint",    },
	{ "inExp",             "tAHot",              "cl",                 "weaponLv",},
}
GameMsg.map["sCardsData"] = {
	--        卡牌的唯一id 名字     技能                等级    跃升等级[以前的突破等级] 强化等级          强化经验        血量   经验   当前热值  装备id      卡牌的装备(卡牌的装备信息，主要在军演，那边使用) 性能（缓存显示、军演）使用 使用的皮肤 皮肤l2d     其他形态皮肤 皮肤l2d       是否新   获取次数  副天赋       标签   卡牌其他信息         角色好感度(查看好友助战卡牌信息时使用,暂时只写入等级) 创建时间戳                                           卡牌光环信息   
	{ "uint", "uint",      "string","map|sSkillData|id","uint", "uint",              "uint",           "uint",         "uint","uint","uint",   "json",     "list|sEquip",       "float",              "uint",    "byte",     "uint",      "byte",       "bool",  "uint",   "json",      "byte","struts|sCardMixData","struts|sAddRole",   "uint",    "list|sChangeCardInfos","list|sChangeCardInfos","struts|sHalo",},
	{ "cfgid","cid",       "name",  "skills",           "level","break_level",       "intensify_level","intensify_exp","hp",  "exp", "cur_hot","equip_ids","equips",            "performance",        "skin",    "skinIsl2d","skin_a",    "skinIsl2d_a","is_new","get_cnt","sub_talent","tag", "mix_data",          "role",              "ctime",   "open_cards",        "open_mechas",       "haloInfo",    },
}
GameMsg.map["sCardsFriendlyData"] = {
	--配置id  卡牌的唯一id   
	{ "uint", "uint",        },
	{ "cfgid","friendlyRate",},
}
GameMsg.map["sSkillData"] = {
	--技能id 经验   技能类 
	{ "uint","uint","byte",},
	{ "id",  "exp", "type",},
}
GameMsg.map["PlayerProto:CardsData"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:CardsDataRet"] = {
	--装置剩余经验 修改记录(sid:卡牌id, num:上次修改时间) 
	{ "uint",      "map|sStrNumInfo|sid",},
	{ "store_exp", "rename_records",    },
}
GameMsg.map["sSectionMultiInfo"] = {
	--章节id 使用次数 下次重置时间 
	{ "uint","uint",  "uint",      },
	{ "id",  "cnt",   "pt",        },
}
GameMsg.map["PlayerProto:SectionMultiInfo"] = {
	--章节id （不填为申请全部） 
	{ "uint",              },
	{ "id",                },
}
GameMsg.map["PlayerProto:SectionMultiInfoRet"] = {
	--                     有时效的双倍掉落次数 
	{ "list|sSectionMultiInfo","list|sTimeSectionMultiInfo",},
	{ "infos",             "cntInfos",          },
}
GameMsg.map["DuplicateItemData"] = {
	--副本id 星级    条件数据    副本配置表可以使用物品的的下标 副本使用物品是否开启 星级数据    是否通关过，重置后也会完成 
	{ "uint","short","array|int","uint",               "bool",              "array|int","short",              },
	{ "id",  "star", "nGrade",   "nUseItemindex",      "bIsUse",            "data",     "isHisPass",          },
}
GameMsg.map["PlayerProto:DuplicateData"] = {
	--数据                 是否完了    
	{ "list|DuplicateItemData","bool",     },
	{ "mainLine",          "is_finish",},
}
GameMsg.map["PlayerProto:CardUpgrade"] = {
	--升级的卡牌id 使用存储经验值  
	{ "uint",      "int",          },
	{ "cid",       "use_store_exp",},
}
GameMsg.map["PlayerProto:CardUpgradeRet"] = {
	--升级的卡牌信息      装置剩余经验 升级暴击id(CardExpAddRand表) 
	{ "struts|sCardsData","uint",      "short",             },
	{ "card",             "store_exp", "id",                },
}
GameMsg.map["PlayerProto:CardDelete"] = {
	--id列表       当前卡牌数量 
	{ "array|uint","short",     },
	{ "card_ids",  "cur_size",  },
}
GameMsg.map["PlayerProto:CardAdd"] = {
	--卡牌信息          当前卡牌数量          
	{ "list|sCardsData","short",     "bool",  },
	{ "cards",          "cur_size",  "finish",},
}
GameMsg.map["PlayerProto:CardIntensify"] = {
	--卡牌id 
	{ "uint",},
	{ "cid", },
}
GameMsg.map["PlayerProto:CardIntensifyRet"] = {
	--卡牌信息            升级暴击id(CardExpAddRand表) 
	{ "struts|sCardsData","short",             },
	{ "card",             "id",                },
}
GameMsg.map["PlayerProto:CardBreak"] = {
	--卡牌id 
	{ "uint",},
	{ "cid", },
}
GameMsg.map["PlayerProto:CardBreakRet"] = {
	--卡牌信息            花费金额 
	{ "struts|sCardsData","uint",  },
	{ "card",             "gold",  },
}
GameMsg.map["PlayerProto:CardCoreLv"] = {
	--卡牌id 使用材料字段（costNum or costArr） 
	{ "uint","string",            },
	{ "cid", "uf",                },
}
GameMsg.map["PlayerProto:CardCoreLvRet"] = {
	--卡牌id 核心等级 
	{ "uint","byte",  },
	{ "cid", "cl",    },
}
GameMsg.map["sCardSkillUpgrade"] = {
	--升级技能id 开始时间 -秒 完成时间 -秒 
	{ "uint",    "uint",      "uint",      },
	{ "id",      "t_start",   "t_end",     },
}
GameMsg.map["PlayerProto:CardSkillUpgradelist"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:CardSkillUpgradelistRet"] = {
	--升级列表 是否完了    
	{ "json",  "bool",     },
	{ "infos", "is_finish",},
}
GameMsg.map["PlayerProto:CardSkillUpgrade"] = {
	--卡牌id 升级技能id 
	{ "uint","uint",    },
	{ "cid", "skill_id",},
}
GameMsg.map["PlayerProto:CardSkillUpgradeRet"] = {
	--卡牌id 升级技能id           
	{ "uint","struts|sCardSkillUpgrade",},
	{ "cid", "info",              },
}
GameMsg.map["sCardSkillUpFinish"] = {
	--卡牌id 卡牌信息            [升级技能id, 升级完技能id, 升级技能id, 升级完技能id] 长度为2的倍数 
	{ "uint","struts|sCardsData","array|uint",        },
	{ "cid", "card",             "ids",               },
}
GameMsg.map["PlayerProto:CardSkillUpgradeFinishRet"] = {
	--{ [cid] = sCardSkillUpFinish } 
	{ "map|sCardSkillUpFinish|cid",},
	{ "infos",             },
}
GameMsg.map["sCardLock"] = {
	--卡牌id 是否锁定 0：否 1：锁定 
	{ "uint","byte",               },
	{ "cid", "lock",               },
}
GameMsg.map["PlayerProto:CardLock"] = {
	--                 
	{ "list|sCardLock",},
	{ "ops",           },
}
GameMsg.map["PlayerProto:CardLockRet"] = {
	--                 
	{ "list|sCardLock",},
	{ "ops",           },
}
GameMsg.map["sCardCreateInfo"] = {
	--序列值  卡池id         需要时间    开始时间     创建时间      
	{ "uint", "uint",        "uint",     "uint",      "uint",       },
	{ "index","card_pool_id","need_time","start_time","create_time",},
}
GameMsg.map["PlayerProto:CardFactoryInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:CardFactoryInfoRet"] = {
	--是否已经首次十连     保底设置(id：卡池id, num:已中次数 ,type:设置的保底卡牌) 今日抽卡次数    服务器累计抽卡次数 建造次数(卡池id,建造次数) 动态开启的卡池 剩余可用免费次数 建造中的             等待中的             完成                 自选构建卡池信息     
	{ "map|sFirstCreateInfo|card_pool_id","map|sNumInfo|id",   "ushort",       "list|sNumInfo",   "json",               "json",        "ushort",        "list|sCardCreateInfo","list|sCardCreateInfo","list|sCardCreateInfo","map|sSelfChoiceCards|id",},
	{ "firt_create_infos", "sel_infos",         "daily_use_cnt","sum_pool_cnts",   "create_cnts",        "dy_open_pool","free_cnt",      "buildings",         "waitings",          "finishs",           "choice_infos",      },
}
GameMsg.map["PlayerProto:CardPoolOpen"] = {
	--服务器累计抽卡次数 
	{ "list|sNumInfo",   },
	{ "sum_pool_cnts",   },
}
GameMsg.map["PlayerProto:CardCreate"] = {
	--卡池id         操作次数 
	{ "uint",        "ushort",},
	{ "card_pool_id","cnt",   },
}
GameMsg.map["PlayerProto:CardCreateFinishRet"] = {
	--                     操作次数 卡池已建造次数 品质提升     卡池id         今日抽卡次数                    
	{ "list|sCardPoolRewardInfo","ushort","uint",        "array|uint","ushort",      "ushort",       "list|sNumInfo",},
	{ "infos",             "cnt",   "create_cnt",  "quality_up","card_pool_id","daily_use_cnt","costs",        },
}
GameMsg.map["PlayerProto:FirstCardCreate"] = {
	--卡池id         
	{ "ushort",      },
	{ "card_pool_id",},
}
GameMsg.map["PlayerProto:FirstCardCreateRet"] = {
	--卡池id         建造次数     获得的卡牌id列表(卡牌配置id,获取次数) 最后一次操作的结果   
	{ "ushort",      "uint",      "list|sNumInfo",     "struts|sCardCreateLog",},
	{ "card_pool_id","create_cnt","hadGetLog",         "last_op",           },
}
GameMsg.map["PlayerProto:FirstCardCreateAffirm"] = {
	--卡池id         使用记录的数组下标(没有表示，使用最后的结果) 
	{ "ushort",      "ushort",            },
	{ "card_pool_id","ix",                },
}
GameMsg.map["PlayerProto:FirstCardCreateAffirmRet"] = {
	--卡池id         使用记录的数组下标(没有表示，使用最后的结果) 今日抽卡次数    卡池已建造次数                 
	{ "ushort",      "ushort",            "ushort",       "uint",        "list|sNumInfo",},
	{ "card_pool_id","ix",                "daily_use_cnt","create_cnt",  "costs",        },
}
GameMsg.map["PlayerProto:FirstCardCreateLogs"] = {
	--卡池id(不填为获取全部记录) 
	{ "ushort",            },
	{ "card_pool_id",      },
}
GameMsg.map["PlayerProto:FirstCardCreateAddLog"] = {
	--卡池id         
	{ "ushort",      },
	{ "card_pool_id",},
}
GameMsg.map["PlayerProto:FirstCardCreateLogsRet"] = {
	--                     
	{ "map|sCardCreateLogInfo|card_pool_id",},
	{ "logs",              },
}
GameMsg.map["PlayerProto:CardDisintegrate"] = {
	--卡牌id列表   
	{ "array|uint",},
	{ "card_ids",  },
}
GameMsg.map["PlayerProto:CardDisintegrateRet"] = {
	--卡牌id列表   获得的奖励(物品id,数量) 删除卡牌的装备 
	{ "array|uint","list|sNumInfo",      "array|uint",  },
	{ "card_ids",  "rewards",            "equip_ids",   },
}
GameMsg.map["sCardCool"] = {
	--卡牌id 加入的位置 
	{ "uint","byte",    },
	{ "cid", "index",   },
}
GameMsg.map["sCardCoolRet"] = {
	--是否加速操作  卡牌id 消耗的道具(物品id,数量) 卡牌冷却信息         
	{ "bool",       "uint","list|sNumInfo",      "struts|sCardCoolBoxInfo",},
	{ "is_speed_up","cid", "costs",              "info",              },
}
GameMsg.map["sCardCoolSpeed"] = {
	--冷却配置表id 消耗的道具(物品id,数量) 
	{ "uint",      "list|sNumInfo",      },
	{ "index",     "costs",              },
}
GameMsg.map["sCardCoolBoxInfo"] = {
	--卡牌id 位置    开始时间 -秒 完成时间 -秒 原始结束时间（没加速过） 
	{ "uint","uint", "uint",      "uint",      "uint",               },
	{ "cid", "index","start_time","end_time",  "o_end",              },
}
GameMsg.map["PlayerProto:CardCoolBoxInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:CardCoolBoxInfoRet"] = {
	--列表       
	{ "json",    },
	{ "openInfo",},
}
GameMsg.map["PlayerProto:CardCoolFinishNotice"] = {
	--卡牌信息            位置    是否中止  
	{ "struts|sCardsData","uint", "bool",   },
	{ "card",             "index","isPause",},
}
GameMsg.map["PlayerProto:CardCool"] = {
	--                 
	{ "list|sCardCool",},
	{ "infos",         },
}
GameMsg.map["PlayerProto:CardCoolRet"] = {
	--                    
	{ "list|sCardCoolRet",},
	{ "infos",            },
}
GameMsg.map["PlayerProto:CardCoolGirdAdd"] = {
	--扩展配置id 
	{ "uint",    },
	{ "id",      },
}
GameMsg.map["PlayerProto:CardCoolGirdAddRet"] = {
	--扩展配置id 
	{ "uint",    },
	{ "id",      },
}
GameMsg.map["PlayerProto:CardUpdate"] = {
	--卡牌信息          装置经验    
	{ "list|sCardsData","uint",     },
	{ "cards",          "store_exp",},
}
GameMsg.map["PlayerProto:CardRename"] = {
	--卡牌id 名字     
	{ "uint","string",},
	{ "cid", "name",  },
}
GameMsg.map["PlayerProto:CardRenameRet"] = {
	--卡牌id 名字     下次可修改时间 
	{ "uint","string","uint",        },
	{ "cid", "name",  "rename_time", },
}
GameMsg.map["PlayerProto:SetPlrName"] = {
	--名字     全局表g_SexInitCardIds的下标 生日月  生日天 选择的台词id 
	{ "string","byte",              "byte", "byte","uint",      },
	{ "name",  "index",             "month","day", "use_vid",   },
}
GameMsg.map["PlayerProto:SetPlrNameRet"] = {
	--头像模型  看板id     最后设置的角色看板ID 
	{ "uint",   "uint",    "uint",              },
	{ "icon_id","panel_id","role_panel_id",     },
}
GameMsg.map["PlayerProto:DailyData"] = {
	--副本章节通过次数统计 
	{ "json",              },
	{ "data",              },
}
GameMsg.map["PlayerProto:UpdateDailyData"] = {
	--数据(k=v) 
	{ "json",   },
	{ "data",   },
}
GameMsg.map["PlayerProto:Sign"] = {
	--签名（50个字符） 
	{ "string",        },
	{ "sign",          },
}
GameMsg.map["PlayerProto:SignRet"] = {
	--         
	{ "string",},
	{ "sign",  },
}
GameMsg.map["PlayerProto:ChangeIcon"] = {
	--看板图片id 头像模型  
	{ "uint",    "uint",   },
	{ "panel_id","icon_id",},
}
GameMsg.map["PlayerProto:ChangeIconRet"] = {
	--看板图片id 头像模型  最后设置的角色看板ID 
	{ "uint",    "uint",   "uint",              },
	{ "panel_id","icon_id","role_panel_id",     },
}
GameMsg.map["PlayerProto:PlrPaneInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:PlrPaneInfoRet"] = {
	--面板信息             
	{ "struts|sPlrPaneInfo",},
	{ "info",              },
}
GameMsg.map["PlayerProto:PlrIconGrid"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:PlrIconGridRet"] = {
	--列表(id, 头像框id) 
	{ "list|sPairIntInt",},
	{ "grids",           },
}
GameMsg.map["PlayerProto:PlrPaneBg"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:PlrPaneBgRet"] = {
	--列表(id, 背景id)   
	{ "list|sPairIntInt",},
	{ "grids",           },
}
GameMsg.map["sLifeBuff"] = {
	--buffId(CfgLifeBuffer表格) 过期时间     值       
	{ "uint",               "uint",      "double",},
	{ "id",                 "expireTime","val",   },
}
GameMsg.map["PlayerProto:GetLifeBuff"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetLifeBuffRet"] = {
	--列表               
	{ "map|sLifeBuff|id",},
	{ "buffs",           },
}
GameMsg.map["sSkin"] = {
	--卡牌配置id 皮肤信息（1皮肤ID，2获取时间） 是否新增 限时皮肤             
	{ "uint",    "list|sPairIntInt",   "bool",  "list|sLimitedTimeSkins",},
	{ "cfgid",   "info",               "is_add","ltSkins",           },
}
GameMsg.map["PlayerProto:GetSkins"] = {
	--卡牌配置id(0获取全部) 
	{ "int",               },
	{ "cfgid",             },
}
GameMsg.map["PlayerProto:GetSkinsRet"] = {
	--皮肤         
	{ "list|sSkin",},
	{ "info",      },
}
GameMsg.map["PlayerProto:UseSkin"] = {
	--                       皮肤l2d     皮肤Al2d      
	{ "uint","uint","uint",  "byte",     "byte",       },
	{ "cid", "skin","skin_a","skinIsl2d","skinIsl2d_a",},
}
GameMsg.map["PlayerProto:GetCardGetCnt"] = {
	--        
	{ "uint", },
	{ "cfgid",},
}
GameMsg.map["PlayerProto:GetCardGetCntRet"] = {
	--               
	{ "uint", "uint",},
	{ "cfgid","cnt", },
}
GameMsg.map["PlayerProto:StartCombine"] = {
	--               
	{ "uint", "byte",},
	{ "cfgid","cnt", },
}
GameMsg.map["PlayerProto:StartCombineRet"] = {
	--               
	{ "uint", "byte",},
	{ "cfgid","cnt", },
}
GameMsg.map["PlayerProto:MainTalentUpgrade"] = {
	--卡牌id 技能id     使用材料字段（costNum or costArr） 
	{ "uint","uint",    "string",            },
	{ "cid", "skill_id","uf",                },
}
GameMsg.map["PlayerProto:MainTalentUpgradeRet"] = {
	--卡牌id 技能id     新技能id       使用材料字段（costNum or costArr） 
	{ "uint","uint",    "uint",        "string",            },
	{ "cid", "skill_id","new_skill_id","uf",                },
}
GameMsg.map["PlayerProto:UpgradeSubTalent"] = {
	--       副天赋had的下标 
	{ "uint","byte",         },
	{ "cid", "index",        },
}
GameMsg.map["PlayerProto:UpgradeSubTalentRet"] = {
	--       副天赋had的下标 
	{ "uint","byte",         },
	{ "cid", "index",        },
}
GameMsg.map["PlayerProto:SetUseSubTalent"] = {
	--       use 的技能id 
	{ "uint","array|uint",},
	{ "cid", "indexs",    },
}
GameMsg.map["PlayerProto:GetCardRole"] = {
	--
	{ },
	{ },
}
GameMsg.map["sAddRole"] = {
	--好感度 突破等级 满疲劳时间(0为不需要计算) 事件id 事件开始时间 剧情id    上次疲劳值更新时间 疲劳值( 疲劳值 0 ~ 100, 100 表示满了 ) 经验   剧情id       创建时间   建筑id     服装id       {[能力id] = 等级, -- [能力id] = 等级 播放过的声音 {[id] = 1} 是否新增（不是为nil) 催眠剧情进度 未查看的皮肤{ id1, id2 } 
	{ "uint","uint",  "uint",               "uint","uint",      "uint",   "uint",            "uint",              "uint","array|uint","uint",    "uint",    "array|uint","json",              "json",              "bool",              "uint",      "array|uint",        },
	{ "lv",  "b_lv",  "tf",                 "e_id","e_start",   "e_story","t_pre_tv",        "tv",                "exp", "story_ids", "t_create","build_id","clothes",   "abilitys",          "audio",             "new",               "sleep_ix",  "look_skins",        },
}
GameMsg.map["sCardRole"] = {
	--角色id 数据块            
	{ "uint","struts|sAddRole",},
	{ "id",  "data",           },
}
GameMsg.map["PlayerProto:AddCardRole"] = {
	--                 
	{ "list|sCardRole",},
	{ "roles",         },
}
GameMsg.map["PlayerProto:UpdateCardRole"] = {
	--                 是否结束    
	{ "list|sCardRole","bool",     },
	{ "roles",         "is_finish",},
}
GameMsg.map["PlayerProto:PassCardRoleStory"] = {
	--角色id         
	{ "uint","uint", },
	{ "id",  "index",},
}
GameMsg.map["PlayerProto:PassCardRoleStoryRet"] = {
	--角色id         
	{ "uint","uint", },
	{ "id",  "index",},
}
GameMsg.map["PlayerProto:UpdateLifeBuff"] = {
	--列表               
	{ "map|sLifeBuff|id",},
	{ "buffs",           },
}
GameMsg.map["PlayerProto:RemoveLifeBuff"] = {
	--列表         
	{ "array|uint",},
	{ "ids",       },
}
GameMsg.map["PlayerProto:GetCardRoleUpdate"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:CardCoolSpeedUp"] = {
	--                     
	{ "list|sCardCoolSpeed",},
	{ "infos",             },
}
GameMsg.map["PlayerProto:MultSetTeamData"] = {
	--                
	{ "list|TeamItem",},
	{ "infos",        },
}
GameMsg.map["PlayerProto:MultSetTeamResult"] = {
	--                
	{ "list|TeamItem",},
	{ "infos",        },
}
GameMsg.map["PlayerProto:SetCardTag"] = {
	--卡牌id 标签   
	{ "uint","byte",},
	{ "cid", "tag", },
}
GameMsg.map["PlayerProto:SetCardTagRet"] = {
	--卡牌id 标签   
	{ "uint","byte",},
	{ "cid", "tag", },
}
GameMsg.map["PlayerProto:CardCoolFinish"] = {
	--冷却配置表id 是否中止  
	{ "uint",      "bool",   },
	{ "index",     "isPause",},
}
GameMsg.map["PlayerProto:AddRoleAudio"] = {
	--角色id 音效id  
	{ "uint","uint", },
	{ "id",  "au_id",},
}
GameMsg.map["PlayerProto:FlushAutoAddHotCard"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:FlushAutoAddHotCardRet"] = {
	--卡牌信息（只有id和热值） 
	{ "list|sCardsData",    },
	{ "cards",              },
}
GameMsg.map["sCreateCardLogInfo"] = {
	--操作时间              卡池id    
	{ "uint",  "array|uint","uint",   },
	{ "t",     "cfgIds",    "pool_id",},
}
GameMsg.map["PlayerProto:GetCreateCardLogs"] = {
	--卡池id         偏移量（会跳过 g_CardCreateLogsCnt * skip 条数据返回） 
	{ "uint",        "ushort",            },
	{ "card_pool_id","skip",              },
}
GameMsg.map["PlayerProto:GetCreateCardLogsRet"] = {
	--卡池id                              还有没其他记录 
	{ "uint",        "list|sCreateCardLogInfo","bool",        },
	{ "card_pool_id","logs",              "is_end",      },
}
GameMsg.map["PlayerProto:SetCardInfo"] = {
	--                
	{ "uint","bool",  },
	{ "cid", "is_new",},
}
GameMsg.map["PlayerProto:SetCardInfoRet"] = {
	--                
	{ "uint","bool",  },
	{ "cid", "is_new",},
}
GameMsg.map["PlayerProto:SetCardPoolSelCard"] = {
	--卡池id                
	{ "uint",        "uint",},
	{ "card_pool_id","cid", },
}
GameMsg.map["PlayerProto:SetCardPoolSelCardRet"] = {
	--卡池id                
	{ "uint",        "uint",},
	{ "card_pool_id","cid", },
}
GameMsg.map["PlayerProto:ChangePlrHot"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:ChangePlrHotRet"] = {
	--剩余可兑换次数 购买后的热值 
	{ "short",       "short",     },
	{ "hot_buy_cnt", "hot",       },
}
GameMsg.map["PlayerProto:LookRole"] = {
	--查看的角色 
	{ "uint",    },
	{ "role_id", },
}
GameMsg.map["PlayerProto:TowerData"] = {
	--重置时间          奖励上限        当前值          已领取的章节任务奖励[ [章节id] = 领取时间 ] 
	{ "long",           "uint",         "uint",         "json",              },
	{ "nTowerResetTime","nTowerCeiling","nTowerCurrent","hadGetSectionReward",},
}
GameMsg.map["PlayerProto:GetTowerData"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetBattleFieldData"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:BattleFieldData"] = {
	--活动id  战场配置id  战场信息             状态    
	{ "short","short",    "list|BattleFieldData","byte", },
	{ "id",   "nConfigID","fields",            "state",},
}
GameMsg.map["BattleFieldData"] = {
	--初始怪物数量 总数量  当前击杀数量 对应关卡id 
	{ "int",       "int",  "int",       "int",     },
	{ "init",      "total","curr",      "enemy",   },
}
GameMsg.map["PlayerProto:GetBattleBossData"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:BattleBossData"] = {
	--对应关卡id 最大血量    当前血量 伤害      开始时间    结束时间   
	{ "int",     "int",      "int",   "int",    "uint",     "uint",    },
	{ "nBossID", "bossMaxHp","bossHp","nDamage","nBossTime","nEndTime",},
}
GameMsg.map["PlayerProto:GetBattleBossRank"] = {
	--第几页  
	{ "int",  },
	{ "nPage",},
}
GameMsg.map["BattleBossRankItem"] = {
	--排名   uid    名字    等级    头像      伤害      
	{ "int", "int","string","short","int",    "int",    },
	{ "rank","uid","name",  "level","icon_id","nDamage",},
}
GameMsg.map["PlayerProto:GetBattleBossRankRet"] = {
	--排名数据             我的排名 
	{ "list|BattleBossRankItem","short", },
	{ "data",              "rank",  },
}
GameMsg.map["PlayerProto:PlrNameCheckUse"] = {
	-- 名字    
	{ "string",},
	{ "name",  },
}
GameMsg.map["PlayerProto:PlrNameCheckUseRet"] = {
	--        
	{ "bool", },
	{ "isUse",},
}
GameMsg.map["ModUpDataItemData"] = {
	--副本id 是否开启扫荡  重置扫荡的时间(当关卡表次数为-1，没有重置时间) 已扫荡次数   
	{ "uint","bool",       "uint",              "uint",      },
	{ "id",  "isOpenModUp","modUpResetTime",    "modUpCount",},
}
GameMsg.map["PlayerProto:DuplicateModUpData"] = {
	--副本id（传id就只返回一个，不传全部返回） 
	{ "uint",               },
	{ "id",                 },
}
GameMsg.map["PlayerProto:DuplicateModUpDataRet"] = {
	--数据                 
	{ "list|ModUpDataItemData",},
	{ "modUpData",         },
}
GameMsg.map["PlayerProto:LookSkin"] = {
	--角色id 皮肤id 
	{ "uint","uint",},
	{ "id",  "skin",},
}
GameMsg.map["PlayerProto:LookSkinRet"] = {
	--角色id 皮肤id 
	{ "uint","uint",},
	{ "id",  "skin",},
}
GameMsg.map["PlayerProto:PayReward"] = {
	--订单id 支付类型   
	{ "uint","uint",    },
	{ "id",  "pay_type",},
}
GameMsg.map["PlayerProto:PayRewardRet"] = {
	--奖励            是否发完    是否需要邮件弹窗 
	{ "list|sNumInfo","bool",     "bool",          },
	{ "rewards",      "is_finish","is_notice",     },
}
GameMsg.map["PlayerProto:PayRecharge"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:PayRechargeRet"] = {
	--当前累充金额（单位分） 
	{ "uint",               },
	{ "c_amount",           },
}
GameMsg.map["PlayerProto:GetTaoFaCount"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetTaoFaCountRet"] = {
	--次数           下次重置时间      已经购买次数 
	{ "uint",        "uint",           "uint",      },
	{ "tao_fa_count","next_reset_time","buy_cnt",   },
}
GameMsg.map["PlayerProto:BuyTaoFaCount"] = {
	--次数      
	{ "uint",   },
	{ "buy_cnt",},
}
GameMsg.map["PlayerProto:BuyTaoFaCountRet"] = {
	--购买结果  
	{ "bool",   },
	{ "buy_res",},
}
GameMsg.map["PlayerProto:GetNoticeMsg"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:ChangeCardCfgId"] = {
	--               
	{ "uint","uint", },
	{ "cid", "cfgid",},
}
GameMsg.map["PlayerProto:ChangeCardCfgIdRet"] = {
	--               
	{ "uint","uint", },
	{ "cid", "cfgid",},
}
GameMsg.map["PlayerProto:ChangeCardTcSkill"] = {
	--                                 
	{ "uint","uint",      "uint",      },
	{ "cid", "oldSkillId","useSkillId",},
}
GameMsg.map["PlayerProto:ChangeCardTcSkillRet"] = {
	--                                 
	{ "uint","uint",      "uint",      },
	{ "cid", "oldSkillId","useSkillId",},
}
GameMsg.map["PlayerProto:SetIconFrame"] = {
	--头像框id     
	{ "uint",      },
	{ "icon_frame",},
}
GameMsg.map["PlayerProto:SetIconFrameRet"] = {
	--头像框id     
	{ "uint",      },
	{ "icon_frame",},
}
GameMsg.map["PlayerProto:BuyArachnidCount"] = {
	--数量      章节id      
	{ "uint",   "uint",     },
	{ "buy_cnt","sectionId",},
}
GameMsg.map["PlayerProto:BuyArachnidCountRet"] = {
	--返回剩余可购买的次数 章节id      
	{ "uint",              "uint",     },
	{ "can_buy_cnt",       "sectionId",},
}
GameMsg.map["PlayerProto:CardChangeOpenNotice"] = {
	--                                  
	{ "uint","array|uint","array|uint", },
	{ "cid", "open_cards","open_mechas",},
}
GameMsg.map["PlayerProto:SetIcon"] = {
	--头像id    
	{ "uint",   },
	{ "icon_id",},
}
GameMsg.map["PlayerProto:SetIconRet"] = {
	--头像id    
	{ "uint",   },
	{ "icon_id",},
}
GameMsg.map["sCardInfo"] = {
	--       hp百分比（整数,最大100） sp百分比（整数,最大100） 助战的好友id col    row    isSelect   
	{ "uint","uint",              "uint",              "uint",      "uint","uint","bool",    },
	{ "cid", "tower_hp",          "tower_sp",          "fuid",      "col", "row", "isSelect",},
}
GameMsg.map["PlayerProto:GetNewTowerCardInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetNewTowerCardInfoRet"] = {
	--章节id 角色的hp和sp     助战卡牌           是否最后一条 
	{ "uint","list|sCardInfo","struts|sCardInfo","bool",      },
	{ "sid", "card_infos",    "assit_card_info", "is_finish", },
}
GameMsg.map["PlayerProto:ResetNewTowerCardInfo"] = {
	--章节id 
	{ "uint",},
	{ "sid", },
}
GameMsg.map["PlayerProto:GetNewTowerResetCnt"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetNewTowerResetCntRet"] = {
	--剩余重置次数(sid 章节id，num数量) 
	{ "list|sStrNumInfo",  },
	{ "reset_cnt",         },
}
GameMsg.map["PlayerProto:GetDupMonsterHpInfo"] = {
	--副本id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["PlayerProto:GetDupMonsterHpInfoRet"] = {
	--副本的怪物hp         
	{ "list|sDupMonsterInfo",},
	{ "dup_monster_infos", },
}
GameMsg.map["sMonsterInfo"] = {
	--MonsterFormation.coordinate的第几个 hp百分比（整数，最大100） sp百分比（整数,最大100） 怪物id       
	{ "uint",              "uint",              "uint",              "uint",      },
	{ "configIndex",       "tower_hp",          "tower_sp",          "monster_id",},
}
GameMsg.map["sDupMonsterInfo"] = {
	--副本id MonsterFormation.coordinate的第几个 
	{ "uint","list|sMonsterInfo", },
	{ "id",  "monster_infos",     },
}
GameMsg.map["sTimeSectionMultiInfo"] = {
	--有效的时间 可用次数 道具id    
	{ "uint",    "uint",  "uint",   },
	{ "time",    "cnt",   "item_id",},
}
GameMsg.map["sEquip"] = {
	--配置id  装备的唯一id 等级    经验   是否锁定 随机技能点类型    随机技能点值       所属卡牌id(非空表示被装备了) 是否新   数量   技能ids数组  
	{ "uint", "uint",      "uint", "uint","short", "uint",           "uint",            "uint",              "byte",  "uint","array|uint",},
	{ "cfgid","sid",       "level","exp", "lock",  "rand_skill_type","rand_skill_value","card_id",           "is_new","num", "skills",    },
}
GameMsg.map["EquipProto:GetEquips"] = {
	--
	{ },
	{ },
}
GameMsg.map["EquipProto:GetEquipsRet"] = {
	--装备数据      当前存储量 最大存储量 v5.8新增 装备素材转换数量 
	{ "list|sEquip","uint",    "uint",    "uint",              },
	{ "equips",     "cur_size","max_size","materialNum",       },
}
GameMsg.map["EquipProto:EquipUpgrade"] = {
	--升级的装备id 吞噬的战斗卡(装备id) 素材(物品id,数量) 
	{ "uint",      "array|uint",        "list|sNumInfo",  },
	{ "sid",       "equip_ids",         "items",          },
}
GameMsg.map["EquipProto:EquipUpgradeRet"] = {
	--升级的装备信息  花费金额 升级暴击id(CfgEquipExpRand表) 
	{ "struts|sEquip","uint",  "short",             },
	{ "equip",        "gold",  "id",                },
}
GameMsg.map["EquipProto:EquipDelete"] = {
	--id列表       当前存储量 最大存储量 
	{ "array|uint","uint",    "uint",    },
	{ "sids",      "cur_size","max_size",},
}
GameMsg.map["EquipProto:EquipAdd"] = {
	--装备信息      当前存储量 最大存储量 发送完结    
	{ "list|sEquip","uint",    "uint",    "bool",     },
	{ "equips",     "cur_size","max_size","is_finish",},
}
GameMsg.map["EquipProto:EquipGridAdd"] = {
	--扩容数量 
	{ "short", },
	{ "num",   },
}
GameMsg.map["EquipProto:EquipAddGridRet"] = {
	--当前存储量 
	{ "short",   },
	{ "max_size",},
}
GameMsg.map["sEquipLockInfo"] = {
	--装备id 是否锁定 0：否 1：锁定 
	{ "uint","byte",               },
	{ "sid", "lock",               },
}
GameMsg.map["EquipProto:EquipLock"] = {
	--                     
	{ "list|sEquipLockInfo",},
	{ "infos",             },
}
GameMsg.map["EquipProto:EquipLockRet"] = {
	--                     
	{ "list|sEquipLockInfo",},
	{ "infos",             },
}
GameMsg.map["EquipProto:EquipUp"] = {
	--装备id     目标卡牌id       
	{ "uint",    "uint",          },
	{ "equip_id","target_card_id",},
}
GameMsg.map["EquipProto:EquipUpRet"] = {
	--装备id     目标卡牌id       目标位置      当前存储量 
	{ "uint",    "uint",          "short",      "uint",    },
	{ "equip_id","target_card_id","target_slot","cur_size",},
}
GameMsg.map["EquipProto:EquipSell"] = {
	--id列表       范围id  
	{ "array|uint","json", },
	{ "sids",      "rangs",},
}
GameMsg.map["EquipProto:EquipSellRet"] = {
	--id列表       范围id  当前存储量 
	{ "array|uint","json", "uint",    },
	{ "sids",      "rangs","cur_size",},
}
GameMsg.map["EquipProto:SetIsNew"] = {
	--id           是否为新 
	{ "array|uint","byte",  },
	{ "sids",      "is_new",},
}
GameMsg.map["EquipProto:SetIsNewRet"] = {
	--id           是否为新 
	{ "array|uint","byte",  },
	{ "sids",      "is_new",},
}
GameMsg.map["EquipProto:EquipUpdate"] = {
	--装备数据      当前存储量 最大存储量 
	{ "list|sEquip","uint",    "uint",    },
	{ "equips",     "cur_size","max_size",},
}
GameMsg.map["EquipProto:AddEquipLogSlot"] = {
	--
	{ },
	{ },
}
GameMsg.map["EquipProto:AddEquipLogSlotRet"] = {
	--当前空间大小 
	{ "byte",      },
	{ "cap",       },
}
GameMsg.map["EquipProto:EquipLogs"] = {
	--
	{ },
	{ },
}
GameMsg.map["EquipProto:EquipLogsRet"] = {
	--       当前空间大小 
	{ "json","byte",      },
	{ "logs","cap",       },
}
GameMsg.map["EquipProto:SetEquipLogs"] = {
	--       从1开始 
	{ "uint","byte", },
	{ "cid", "index",},
}
GameMsg.map["EquipProto:SetEquipLogsRet"] = {
	--       从1开始 
	{ "uint","byte", },
	{ "cid", "index",},
}
GameMsg.map["EquipProto:EquipUps"] = {
	--装备id       目标卡牌id       
	{ "array|uint","uint",          },
	{ "equip_ids", "target_card_id",},
}
GameMsg.map["EquipProto:EquipUpsRet"] = {
	--目标卡牌id       穿戴装备id   卸下装备id   
	{ "uint",          "array|uint","array|uint",},
	{ "target_card_id","up_ids",    "down_ids",  },
}
GameMsg.map["EquipProto:UseEquipLogs"] = {
	--       从1开始 
	{ "uint","byte", },
	{ "cid", "index",},
}
GameMsg.map["EquipProto:UseEquipLogsRet"] = {
	--       从1开始 穿戴装备id   卸下装备id   
	{ "uint","byte", "array|uint","array|uint",},
	{ "cid", "index","up_ids",    "down_ids",  },
}
GameMsg.map["EquipProto:EquipDown"] = {
	--装备id       
	{ "array|uint",},
	{ "equip_ids", },
}
GameMsg.map["EquipProto:EquipDownRet"] = {
	--装备id       当前存储量 
	{ "array|uint","uint",    },
	{ "equip_ids", "cur_size",},
}
GameMsg.map["EquipProto:EquipMerge"] = {
	--装备id       指定部位 
	{ "array|uint","uint",  },
	{ "equip_ids", "nSlot", },
}
GameMsg.map["EquipProto:EquipMergeRet"] = {
	--新装备id     当前存储量 
	{ "uint",      "uint",    },
	{ "newEquipId","cur_size",},
}
GameMsg.map["EquipProto:EquipRefresh"] = {
	--洗练的装备id 锁定词条id   是否锁定部位 
	{ "uint",      "array|uint","bool",      },
	{ "sid",       "lockSkills","isLockSlot",},
}
GameMsg.map["EquipProto:EquipRefreshRet"] = {
	--当前洗练的装备id 洗练后的装备配置id 技能ids数组  
	{ "uint",          "uint",            "array|uint",},
	{ "sid",           "newEquipId",      "skills",    },
}
GameMsg.map["EquipProto:EquipRefreshConfirm"] = {
	--洗练的装备id 
	{ "uint",      },
	{ "sid",       },
}
GameMsg.map["EquipProto:EquipRefreshConfirmRet"] = {
	--装备数据        
	{ "struts|sEquip",},
	{ "equipData",    },
}
GameMsg.map["EquipProto:EquipRefreshGetLastData"] = {
	--弱网状态    
	{ "bool",     },
	{ "isWeekNet",},
}
GameMsg.map["EquipProto:EquipRefreshGetLastDataRet"] = {
	--当前洗练的装备id 洗练后的装备配置id 技能ids数组  
	{ "uint",          "uint",            "array|uint",},
	{ "sid",           "newEquipId",      "skills",    },
}
GameMsg.map["EquipProto:EquipRefreshClearLastData"] = {
	--
	{ },
	{ },
}
GameMsg.map["EquipProto:EquipMaterialConvertWindow"] = {
	--
	{ },
	{ },
}
GameMsg.map["EquipProto:EquipMaterialConvertWindowRet"] = {
	--是否成功 
	{ "bool",  },
	{ "is_ok", },
}
GameMsg.map["sShopInfoData"] = {
	--配置id 最后购买时间    购买总量  重置时间     可购买数量    购买次数 
	{ "uint","uint",         "uint",   "uint",      "short",      "short", },
	{ "id",  "last_buy_time","buy_sum","reset_time","can_buy_cnt","cnt",   },
}
GameMsg.map["ShopProto:GetShopInfos"] = {
	--
	{ },
	{ },
}
GameMsg.map["ShopProto:GetShopInfosAdd"] = {
	--                     月卡剩余有效时间 是否发完    
	{ "list|sShopInfoData","uint",          "bool",     },
	{ "infos",             "m_cnt",         "is_finish",},
}
GameMsg.map["ShopProto:Buy"] = {
	--配置id 购买时间   购买总量  扣费方式[ price_1 / price_2 ] 使用的抵扣券    扣费方式[ jCosts / jCosts1 ] 自选格子1 自选格子2 
	{ "uint","uint",    "uint",   "string",            "list|sNumInfo","string",            "uint",   "uint",   },
	{ "id",  "buy_time","buy_sum","useCost",           "vouchers",     "useJCost",          "grid1",  "grid2",  },
}
GameMsg.map["ShopProto:BuyRet"] = {
	--配置id 购买记录信息         获得的物品      新加bufId的物品 月卡剩余有效时间 扣费方式[ jCosts / jCosts1 ] 
	{ "uint","struts|sShopCommodityData","list|sNumInfo","list|sNumInfo","uint",          "string",            },
	{ "id",  "info",              "gets",         "add_bufs",     "m_cnt",         "useJCost",          },
}
GameMsg.map["sExchangeItem"] = {
	--奖励id      奖励品id 能领取多少个                     折扣    掉落列表的下标 已经领取的(没领取过之前为nil) 可以兑换数量(不限购为nil) 
	{ "uint",     "uint",  "uint",      "array|uint","byte","float","byte",        "uint",              "uint",              },
	{ "reward_id","id",    "num",       "price",     "type","dis",  "index",       "had_get",           "buyLimit",          },
}
GameMsg.map["ShopProto:GetExchangeInfo"] = {
	--商店配置配置id 是否手动刷新 
	{ "uint",        "bool",      },
	{ "cfgid",       "is_flush",  },
}
GameMsg.map["ShopProto:GetExchangeInfoRet"] = {
	--商店配置配置id                      下次自动刷新的小时 
	{ "uint",        "list|sExchangeItem","uint",            },
	{ "cfgid",       "infos",             "next_hour",       },
}
GameMsg.map["ShopProto:Exchange"] = {
	--商店配置配置id 数组下标 兑换物品id 兑换数量 
	{ "uint",        "byte",  "uint",    "uint",  },
	{ "cfgid",       "index", "id",      "num",   },
}
GameMsg.map["ShopProto:ExchangeRet"] = {
	--商店配置配置id 数组下标 兑换物品id 还能领多少个 已经领取的 获得的物品      新加bufId的物品 可以兑换数量(不限购为-1) 
	{ "uint",        "byte",  "uint",    "uint",      "uint",    "list|sNumInfo","list|sNumInfo","uint",              },
	{ "cfgid",       "index", "id",      "num",       "had_get", "gets",         "add_bufs",     "buyLimit",          },
}
GameMsg.map["ShopProto:GetShopResetTime"] = {
	--
	{ },
	{ },
}
GameMsg.map["ShopProto:GetShopResetTimeRet"] = {
	--天重置时间 周重置时间 月重置时间 
	{ "uint",    "uint",    "uint",    },
	{ "d_time",  "w_time",  "m_time",  },
}
GameMsg.map["ShopProto:GetShopCommodity"] = {
	--商店id    子页签id   
	{ "uint",   "uint",    },
	{ "shop_id","group_id",},
}
GameMsg.map["ShopProto:GetShopCommodityRet"] = {
	--                     月卡剩余有效时间 是否发完    
	{ "list|sShopCommodityData","uint",          "bool",     },
	{ "infos",             "m_cnt",         "is_finish",},
}
GameMsg.map["sShopCommodityData"] = {
	--商店配置配置id 开启时间    关闭时间     商店id    子页签id   最后购买时间    购买总量  重置时间     可购买数量    购买次数 表的配置             
	{ "uint",        "uint",     "uint",      "uint",   "uint",    "uint",         "uint",   "uint",      "short",      "short", "struts|sShopCommodityCfg",},
	{ "id",          "open_time","close_time","shop_id","group_id","last_buy_time","buy_sum","reset_time","can_buy_cnt","cnt",   "shop_config",       },
}
GameMsg.map["ShopProto:GetShopOpenTime"] = {
	--
	{ },
	{ },
}
GameMsg.map["ShopProto:GetShopOpenTimeRet"] = {
	--                     
	{ "list|sShopOpenTimeData",},
	{ "infos",             },
}
GameMsg.map["sShopOpenTimeData"] = {
	--商店id    子页签id   开启时间    关闭时间     
	{ "uint",   "uint",    "uint",     "uint",      },
	{ "shop_id","group_id","open_time","close_time",},
}
GameMsg.map["sShopCommodityCfg"] = {
	--折扣开始时间     折扣结束时间   折扣        获得的物品id及数量 额外获得  消耗货币id 单次购买上限    总购买上限     重置类型     重置类型值    是否显示在列表 消耗货币id 售罄判断物品id 
	{ "uint",          "uint",        "float",    "json",            "json",   "json",    "uint",         "uint",        "uint",      "uint",       "uint",        "json",    "array|int",   },
	{ "nDiscountStart","nDiscountEnd","fDiscount","jGets",           "jExGets","jCosts",  "nOnecBuyLimit","nSumBuyLimit","nResetType","nResetValue","isShow",      "jCosts1", "BonusItemID", },
}
GameMsg.map["ShopProto:GetSkinRebateReward"] = {
	--商店配置配置id 
	{ "uint",        },
	{ "id",          },
}
GameMsg.map["ShopProto:GetSkinRebateRewardRet"] = {
	--商店配置配置id 获得的物品id及数量 
	{ "uint",        "json",            },
	{ "id",          "jGets",           },
}
GameMsg.map["ShopProto:GetSkinRebateRecord"] = {
	--皮肤组id，不传发全部 
	{ "uint",              },
	{ "skinId",            },
}
GameMsg.map["ShopProto:GetSkinRebateRecordRet"] = {
	--领取的商品id         
	{ "list|sSkinRebateRecord",},
	{ "skinRebateRecordList",},
}
GameMsg.map["sSkinRebateRecord"] = {
	--皮肤组id，不传发全部 领取的商品id 
	{ "uint",              "array|uint",},
	{ "skinId",            "infos",     },
}
GameMsg.map["ShopProto:GetSkinRebateCanTakeReward"] = {
	--皮肤组id，不传发全部 
	{ "uint",              },
	{ "skinId",            },
}
GameMsg.map["ShopProto:GetSkinRebateCanTakeRewardRet"] = {
	--领取的商品id         
	{ "list|sSkinRebateRecord",},
	{ "skinRebateRecordList",},
}
GameMsg.map["sMailContent"] = {
	--邮件名称 发件人名称 描述     获得的奖励(物品id,数量) 阅读后多少秒删除 附带邮件id 发件人名称参数列表 描述参数列表 
	{ "string","string",  "string","list|sNumInfo",      "uint",          "uint",    "json",            "json",      },
	{ "name",  "from",    "desc",  "rewards",            "read_del_sec",  "mCfgId",  "nameArgs",        "desArgs",   },
}
GameMsg.map["sMailInfo"] = {
	--邮件id（排序依据） 表id(无id则为gm邮件) 状态(1:未读 2:已读) 是否已领取(1:未领 2：已领取) 发件人     开始时间 -秒 完成时间 -秒 数据结构             创建时间      
	{ "uint",            "uint",              "byte",             "byte",              "uint",    "long",      "long",      "struts|sMailContent","long",       },
	{ "id",              "cfgid",             "is_read",          "is_get",            "from_uid","start_time","end_time",  "data",              "create_time",},
}
GameMsg.map["sMailData"] = {
	--数据结构           客户端不使用 
	{ "struts|sMailInfo","bool",      },
	{ "data",            "bIsChange", },
}
GameMsg.map["MailProto:GetMailsData"] = {
	--
	{ },
	{ },
}
GameMsg.map["MailProto:GetMailsDataRet"] = {
	--列表               
	{ "map|sMailData|id",},
	{ "mails",           },
}
GameMsg.map["MailProto:MailAddNotice"] = {
	--列表             
	{ "list|sMailInfo",},
	{ "adds",          },
}
GameMsg.map["MailProto:MailsOperate"] = {
	--列表         操作类型(1:读 2:领取 3:删除) 
	{ "array|uint","uint",              },
	{ "ids",       "operate_type",      },
}
GameMsg.map["MailProto:MailsOperateRet"] = {
	--有效列表     操作类型(1:读 2:领取 3:删除) 
	{ "array|uint","uint",              },
	{ "ids",       "operate_type",      },
}
GameMsg.map["MailProto:QueryMail"] = {
	--
	{ },
	{ },
}
GameMsg.map["MailProto:QueryMailRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["MailProto:GetAttachMail"] = {
	--邮件id 附带邮件id 
	{ "uint","uint",    },
	{ "id",  "mCfgId",  },
}
GameMsg.map["sTaskInfo"] = {
	--任务唯一索引 任务id  类型   是否已领 奖励物品        状态    列表(id =finishId, num =cnt) 
	{ "uint",      "uint", "byte","byte",  "list|sNumInfo","byte", "list|sNumInfo",     },
	{ "id",        "cfgid","type","is_get","rewards",      "state","finish_ids",        },
}
GameMsg.map["TaskProto:GetTasksData"] = {
	--
	{ },
	{ },
}
GameMsg.map["TaskProto:TaskAdd"] = {
	--列表             是否发完    
	{ "list|sTaskInfo","bool",     },
	{ "tasks",         "is_finish",},
}
GameMsg.map["TaskProto:TaskFlush"] = {
	--列表             
	{ "list|sTaskInfo",},
	{ "tasks",         },
}
GameMsg.map["sGetRewardInfo"] = {
	--任务唯一索引 是否已领 配置表id 任务类型 
	{ "uint",      "byte",  "uint",  "short", },
	{ "id",        "is_get","cfgid", "type",  },
}
GameMsg.map["TaskProto:GetReward"] = {
	--任务唯一索引 任务唯一索引 
	{ "uint",      "array|uint",},
	{ "id",        "ids",       },
}
GameMsg.map["TaskProto:GetRewardRet"] = {
	--                     多领取返回           每日星数    每周星数                    庆典任务星数       
	{ "struts|sGetRewardInfo","list|sGetRewardInfo","uint",     "uint",      "list|sReward","list|sPairIntInt",},
	{ "info",              "infos",             "dailyStar","weeklyStar","gets",        "anvsStarInfo",    },
}
GameMsg.map["TaskProto:GetRewardByType"] = {
	--任务类型 辅助字段[任务中细分类型] 
	{ "uint",  "uint",              },
	{ "type",  "nGroup",            },
}
GameMsg.map["TaskProto:GetRewardByTypeRet"] = {
	--任务唯一索引         每日星数    每周星数                    庆典任务星数       
	{ "list|sGetRewardInfo","uint",     "uint",      "list|sReward","list|sPairIntInt",},
	{ "infos",             "dailyStar","weeklyStar","gets",        "anvsStarInfo",    },
}
GameMsg.map["TaskProto:GetResetTaskInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["TaskProto:GetResetTaskInfoRet"] = {
	--每天任务过期时间 每周任务过期时间  每日星数    每周星数     庆典任务星数       
	{ "uint",          "uint",           "uint",     "uint",      "list|sPairIntInt",},
	{ "dailyResetTime","weeklyResetTime","dailyStar","weeklyStar","anvsStarInfo",    },
}
GameMsg.map["TaskProto:GetSevenTasksDay"] = {
	--类型   
	{ "byte",},
	{ "type",},
}
GameMsg.map["TaskProto:GetSevenTasksDayRet"] = {
	--当前天  类型   
	{ "uint", "byte",},
	{ "c_day","type",},
}
GameMsg.map["TaskProto:TaskReSet"] = {
	--
	{ },
	{ },
}
GameMsg.map["TaskProto:GetTasksDataRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["sDeleteTask"] = {
	--任务唯一索引 任务id  类型   
	{ "uint",      "uint", "byte",},
	{ "id",        "cfgid","type",},
}
GameMsg.map["TaskProto:TaskDelete"] = {
	--被删除的任务列表   
	{ "list|sDeleteTask",},
	{ "tasks",           },
}
GameMsg.map["sTaskType"] = {
	--任务类型 辅助字段[任务中细分类型] 
	{ "uint",  "uint",              },
	{ "type",  "nGroup",            },
}
GameMsg.map["TaskProto:GetRewardByTypes"] = {
	--任务类型         
	{ "list|sTaskType",},
	{ "taskType",      },
}
GameMsg.map["TaskProto:GetRoleGuideBaseInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["TaskProto:GetRoleGuideBaseInfoUpdate"] = {
	--更新替换现有的（当没有完成过任务时，没有记录） 
	{ "list|sIntArray",     },
	{ "infos",              },
}
GameMsg.map["TaskProto:GetRoleGuideReward"] = {
	--CfgRoleTrainGuide.id 
	{ "uint",              },
	{ "id",                },
}
GameMsg.map["TaskProto:GetRoleGuideRewardRet"] = {
	--CfgRoleTrainGuide.id 领取到的奖励下表                
	{ "uint",              "short",         "list|sReward",},
	{ "id",                "ix",            "gets",        },
}
GameMsg.map["sPracticeInfo"] = {
	--本季赛开始时间(时间前的都是休息时间） 本季赛结束时间 可以参加的计数 下次参加次数重置时间 已使用刷新次数 段位         最高段位         排名   最高排名   积分    可购买军演挑战次数 最后设置的角色看板ID 军演立绘live2d 
	{ "uint",              "uint",        "short",       "uint",              "byte",        "short",     "uint",          "uint","uint",    "uint", "short",           "uint",              "byte",        },
	{ "start_time",        "end_time",    "can_join_cnt","t_join_cnt",        "flush_cnt",   "rank_level","max_rank_level","rank","max_rank","score","can_join_buy_cnt","role_panel_id",     "live2d",      },
}
GameMsg.map["sPracticeObjInfo"] = {
	--id     姓名     玩家等级 段位         排名   综合能力      头像模型id 头像框       最后设置的角色看板ID 是否机器人 积分    性别序号      玩家称号     基础队伍卡牌信息  军演立绘live2d 
	{ "uint","string","uint",  "short",     "uint","uint",       "uint",    "uint",      "uint",              "byte",    "uint", "byte",       "uint",      "list|sCardsData","byte",        },
	{ "uid", "name",  "level", "rank_level","rank","performance","icon_id", "icon_frame","role_panel_id",     "is_robot","score","sel_card_ix","icon_title","baseCards",      "live2d",      },
}
GameMsg.map["sPracticeBaseTeam"] = {
	--是否机器人                   好友id 
	{ "byte",    "list|sCardsData","long",},
	{ "is_robot","team",           "uid", },
}
GameMsg.map["ArmyProto:GetPracticeInfo"] = {
	--获取自己军演信息 是否获取对手列表 
	{ "bool",          "bool",          },
	{ "selfInfo",      "listInfo",      },
}
GameMsg.map["ArmyProto:GetPracticeInfoRet"] = {
	--自己的军演信息       对手军演信息列表     获取自己军演信息 是否获取对手列表 第几个赛季 战绩简单信息    
	{ "struts|sPracticeInfo","list|sPracticeObjInfo","bool",          "bool",          "short",   "json",         },
	{ "info",              "objs",              "selfInfo",      "listInfo",      "army_ix", "fightBaseLogs",},
}
GameMsg.map["ArmyProto:PracticeInfoUpdate"] = {
	--                     结果     经验(卡牌) 玩家经验     增加的兑币 是否强行退出  参与战斗的卡牌(id：卡牌id, num:添加的好感度) 
	{ "struts|sPracticeInfo","bool",  "uint",    "uint",      "short",   "bool",       "list|sNumInfo",     },
	{ "info",              "bIsWin","exp",     "nPlayerExp","coin",    "isForceOver","cardsExp",          },
}
GameMsg.map["ArmyProto:FlushPracticeObj"] = {
	--
	{ },
	{ },
}
GameMsg.map["ArmyProto:FlushPracticeObjRet"] = {
	--                     已使用刷新次数 
	{ "list|sPracticeObjInfo","short",       },
	{ "objs",              "flush_cnt",   },
}
GameMsg.map["ArmyProto:Practice"] = {
	--id     是否机器人 
	{ "uint","byte",    },
	{ "uid", "is_robot",},
}
GameMsg.map["ArmyProto:GetPracticeOtherTeam"] = {
	--id     是否机器人 
	{ "long","byte",    },
	{ "uid", "is_robot",},
}
GameMsg.map["ArmyProto:GetPracticeOtherTeamRet"] = {
	--对方队伍          id     是否机器人 玩家信息             
	{ "struts|TeamItem","long","byte",    "struts|sPracticeObjInfo",},
	{ "team",           "uid", "is_robot","info",              },
}
GameMsg.map["ArmyProto:GetPracticeList"] = {
	--开始排名，最小1 结束排名   
	{ "byte",         "byte",    },
	{ "beg_rank",     "end_rank",},
}
GameMsg.map["ArmyProto:GetPracticeListRet"] = {
	--排名列表             最大排名   队伍信息             下次刷新时间 
	{ "list|sPracticeObjInfo","byte",    "list|sPracticeBaseTeam","uint",      },
	{ "objs",              "max_rank","teamInfos",         "tNextFlush",},
}
GameMsg.map["ArmyProto:BuyAttackCnt"] = {
	--购买次数 
	{ "short", },
	{ "cnt",   },
}
GameMsg.map["ArmyProto:BuyAttackCntRet"] = {
	--购买次数 已买次数           可以参加的计数 
	{ "short", "short",           "short",       },
	{ "cnt",   "can_join_buy_cnt","can_join_cnt",},
}
GameMsg.map["sArmyFightLog"] = {
	--                                                            对方分数变动                                 自己是否胜利 挑战时间 操作数     排名   
	{ "uint","string","uint", "int",    "uint",      "uint",      "uint",      "uint",       "list|sCardsData","bool",      "uint",  "short",   "uint",},
	{ "uid", "name",  "level","icon_id","icon_frame","icon_title","mod_score", "performance","baseCards",      "is_winer",  "time",  "turn_num","rank",},
}
GameMsg.map["ArmyProto:GetFightLogs"] = {
	--第几个开始，从1开始 数量    
	{ "short",            "short",},
	{ "ix",               "cnt",  },
}
GameMsg.map["ArmyProto:GetFightLogsRet"] = {
	--                     第几个开始，从1开始 数量    
	{ "list|sArmyFightLog","short",            "short",},
	{ "logs",              "ix",               "cnt",  },
}
GameMsg.map["ArmyProto:SetRolePanel"] = {
	--军演立绘id      军演立绘live2d 
	{ "uint",         "byte",        },
	{ "role_panel_id","live2d",      },
}
GameMsg.map["ArmyProto:SetRolePanelRet"] = {
	--军演立绘id      军演立绘live2d 
	{ "uint",         "byte",        },
	{ "role_panel_id","live2d",      },
}
GameMsg.map["ArmyProto:GetSelfPracticeInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["ArmyProto:GetSelfPracticeInfoRet"] = {
	--                     第几个赛季 
	{ "struts|sPracticeInfo","short",   },
	{ "info",              "army_ix", },
}
GameMsg.map["sInviteInfo"] = {
	--好友id 是否取消    邀请时间      
	{ "long","bool",     "uint",       },
	{ "uid", "is_cancel","invite_time",},
}
GameMsg.map["sInviteResponeInfo"] = {
	--好友id 是否接受     
	{ "long","bool",      },
	{ "uid", "is_receive",},
}
GameMsg.map["ArmyProto:InviteFriend"] = {
	--批量操作           
	{ "list|sInviteInfo",},
	{ "ops",             },
}
GameMsg.map["ArmyProto:InviteFriendRet"] = {
	--批量操作           
	{ "list|sInviteInfo",},
	{ "ops",             },
}
GameMsg.map["ArmyProto:BeInvite"] = {
	--好友id 邀请时间      
	{ "long","uint",       },
	{ "uid", "invite_time",},
}
GameMsg.map["ArmyProto:BeInviteRet"] = {
	--批量操作             
	{ "list|sInviteResponeInfo",},
	{ "ops",               },
}
GameMsg.map["ArmyProto:BeInviteRespond"] = {
	--好友id 是否接受     
	{ "long","bool",      },
	{ "uid", "is_receive",},
}
GameMsg.map["sFreeArmyMatch"] = {
	--机器人id       对手id          等级    积分    对方排名 头像      头像框       性别序号      最后设置的角色看板ID 玩家称号     对方队伍        是否动态看板 参与自由军演次数 
	{ "uint",        "uint","string","uint", "uint", "uint",  "uint",   "uint",      "byte",       "uint",              "uint",      "list|TeamItem","byte",      "short",         },
	{ "robot_cfg_id","uid", "name",  "level","score","rank",  "icon_id","icon_frame","sel_card_ix","role_panel_id",     "icon_title","teams",        "live2d",    "join_cnt",      },
}
GameMsg.map["sFriendInvite"] = {
	--好友id 积分    对方排名 最后设置的角色看板ID 是否动态看板 对方队伍        参与自由军演次数 
	{ "long","uint", "uint",  "uint",              "byte",      "list|TeamItem","short",         },
	{ "uid", "score","rank",  "role_panel_id",     "live2d",    "teams",        "join_cnt",      },
}
GameMsg.map["sFightAddress"] = {
	--ip       端口    战斗序号   服务器id 随机值 参与玩家     RealArmyType 比较大的段位 机器人id       差值a       差值b       
	{ "string","short","uint",    "uint",  "int", "array|long","byte",      "int",       "uint",        "int",      "int",      },
	{ "ip",    "port", "fight_ix","svr_id","key", "uids",      "type",      "max_rank",  "robot_cfg_id","dif_val_a","dif_val_b",},
}
GameMsg.map["ArmyProto:FightAddress"] = {
	--军演地址信息         自由匹配军演         好友邀请军演         
	{ "struts|sFightAddress","struts|sFreeArmyMatch","struts|sFriendInvite",},
	{ "addr",              "free_match_info",   "friend_invite_info",},
}
GameMsg.map["ArmyProto:FightServerInit"] = {
	--自己的id 军演地址信息         
	{ "long",  "struts|sFightAddress",},
	{ "uid",   "addr",              },
}
GameMsg.map["ArmyProto:FightServerInitRet"] = {
	--RealArmyType 倒计时结束时间    邀请方id     接受方方的id 
	{ "byte",      "uint",           "long",      "long",      },
	{ "type",      "auto_start_time","invite_uid","agreed_uid",},
}
GameMsg.map["ArmyProto:StartRealArmy"] = {
	--准备好的队伍      
	{ "struts|TeamItem",},
	{ "team",           },
}
GameMsg.map["ArmyProto:StartRealArmyRet"] = {
	--准备好的人的Id 
	{ "long",        },
	{ "uid",         },
}
GameMsg.map["ArmyProto:RealTimeFightFinish"] = {
	--结果     RealArmyType 是否强行退出  分数    排名   奖励            奖励领取相关记录     使用的队伍id 
	{ "bool",  "byte",      "bool",       "uint", "uint","list|sNumInfo","struts|sFreeMatchRewarInfo","uint",      },
	{ "bIsWin","type",      "isForceOver","score","rank","rewards",      "reward_info",       "teamId",    },
}
GameMsg.map["ArmyProto:RealArmyLogout"] = {
	--好友id RealArmyType 
	{ "long","byte",      },
	{ "uid", "type",      },
}
GameMsg.map["ArmyProto:HadPvpInfo"] = {
	--军演地址信息         是否断线重连   
	{ "struts|sFightAddress","bool",        },
	{ "addr",              "is_reconnect",},
}
GameMsg.map["ArmyProto:RecoverPvp"] = {
	--自己的id 军演地址信息         
	{ "long",  "struts|sFightAddress",},
	{ "uid",   "addr",              },
}
GameMsg.map["ArmyProto:RecoverPvpRet"] = {
	--是否已经结束（如果true,发送 ArmyProto:DelPvpInfo 给游戏服） 
	{ "bool",              },
	{ "finish",            },
}
GameMsg.map["ArmyProto:DelPvpInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["ArmyProto:JoinFreeArmy"] = {
	--
	{ },
	{ },
}
GameMsg.map["ArmyProto:JoinFreeArmyRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["ArmyProto:QuitFreeArmy"] = {
	--
	{ },
	{ },
}
GameMsg.map["ArmyProto:QuitFreeArmyRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["ArmyProto:QuitArmy"] = {
	--
	{ },
	{ },
}
GameMsg.map["sFreeArmyRank"] = {
	--                玩家等级 玩家称号     排名   积分    头像模型id 头像框                     
	{ "long","string","uint",  "uint",      "uint","uint", "uint",    "uint",      "byte",       },
	{ "uid", "name",  "level", "icon_title","rank","score","icon_id", "icon_frame","sel_card_ix",},
}
GameMsg.map["ArmyProto:FreeMatchInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["ArmyProto:FreeMatchInfoRet"] = {
	--当前赛季id[没有就发0] 分数    排名   最高排名   可以参加的计数 上一当前赛季id[没有就为空] 奖励领取相关记录     最后设置的角色看板ID 是否动态看板 上赛季分数  
	{ "short",             "uint", "uint","uint",    "short",       "short",             "struts|sFreeMatchRewarInfo","uint",              "byte",      "uint",     },
	{ "cfg_id",            "score","rank","max_rank","can_join_cnt","pre_cfg_id",        "reward_info",       "role_panel_id",     "live2d",    "pre_score",},
}
GameMsg.map["ArmyProto:GetFreeMatchRankList"] = {
	--开始排名，最小1 排名个数   
	{ "byte",         "short",   },
	{ "beg_rank",     "rank_cnt",},
}
GameMsg.map["ArmyProto:GetFreeMatchRankListRet"] = {
	--开始排名，最小1 排名个数   排名列表             
	{ "byte",         "short",   "list|sFreeArmyRank",},
	{ "beg_rank",     "rank_cnt","rank_objs",         },
}
GameMsg.map["sFreeMatchRewarInfo"] = {
	--参与自由军演次数 已领取参与次数id  已领取军演段位id 胜利次数  胜利次数获取到哪里 
	{ "short",         "short",          "short",         "short",  "short",           },
	{ "join_cnt",      "get_join_cnt_id","get_rank_lv_id","win_cnt","get_win_cnt_ix",  },
}
GameMsg.map["ArmyProto:GetPvpReward"] = {
	--类型    领取的列表   
	{ "short","array|uint",},
	{ "type", "ids",       },
}
GameMsg.map["ArmyProto:GetPvpRewardRet"] = {
	--奖励领取相关记录     
	{ "struts|sFreeMatchRewarInfo",},
	{ "reward_info",       },
}
GameMsg.map["ArmyProto:FreeMatchCfgChangeFix"] = {
	--
	{ },
	{ },
}
GameMsg.map["sBuildRoleAbility"] = {
	--能力类型值 参考角色能力表CfgCardRoleAbility的vals字段批注 [物品id] = 增加的数量 or 百分比 目前只有工程师有，上次执行时间 能力生效的角色ids 
	{ "short",   "array|short",       "json",              "uint",               "json",           },
	{ "id",      "vals",              "rewards",           "tPre",               "rids",           },
}
GameMsg.map["sProductAdd"] = {
	--gift的id 增减产量 增减上限 
	{ "uint",  "int",   "int",   },
	{ "id",    "num",   "limit", },
}
GameMsg.map["sBuildInfo"] = {
	--       配置表id 耐久度  等级   进去下一等级的时间(为0表示没升级) 建造完成时间 建筑当前时间(交易中心有) 起点坐标     产出    上次产生奖励的时间 产生奖励的时间 额外产出  上次额外产出的时间 额外产出的时间 入住角色id   运行中    血量电量百分比（100±100） 角色电量百分比（100±100） 生产效益百分比 建筑血量影响生产效益百分比 角色疲劳值影响生产效益百分比 角色能力影响生产效益百分比 停止时间 角色能力列表         角色电量增加数值(增) 刷新时间(0为不需要刷新,与服务器时间做对比)                      预设角色列表         当前使用的预设队伍id（默认1） 
	{ "uint","uint",  "short","uint","uint",              "uint",      "double",            "array|byte","json", "uint",            "uint",        "json",   "uint",            "uint",        "array|uint","bool",   "short",             "short",             "short",       "short",              "short",              "short",              "uint",  "map|sBuildRoleAbility|id","short",             "double",             "map|sProductAdd|id","list|sPresetRoleTeam","uint",               },
	{ "id",  "cfgId", "hp",   "lv",  "tUp",               "tBuild",    "tCur",              "pos",       "gifts","tPreGifs",        "tNexGifs",    "giftsEx","tPreGiftsEx",     "tNexGiftsEx", "roleIds",   "running","perHpPower",        "perRolePower",      "perBenefit",  "perHpBenefit",       "perRoleTiredBenefit", "perRoleAbilityBenefit", "tStop", "roleAbilitys",      "rolePower",         "tFlush",             "productAdd",        "presetRoles",       "curPresetId",        },
}
GameMsg.map["BuildingProto:AddNotice"] = {
	--建筑信息                      
	{ "list|sBuildInfo","bool",     },
	{ "builds",         "is_finish",},
}
GameMsg.map["BuildingProto:BuildsBaseInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["BuildingProto:BuildsBaseInfoRet"] = {
	--总人口    建筑类型数量 总电量  角色电量百分比（100±100) 角色产量增减百分比（100±100） 预警级别    运行状态配置id 额外预设队伍数       
	{ "uint",   "json",      "json", "short",             "short",             "byte",     "byte",        "uint",              },
	{ "roleCnt","buildCnts", "power","perRolePower",      "perRoleAbilityBenefit","warningLv","runTypeCfgId","extraPresetTeamNum",},
}
GameMsg.map["BuildingProto:BuildsList"] = {
	--
	{ },
	{ },
}
GameMsg.map["BuildingProto:BuildCreate"] = {
	--建筑配置id 起点坐标     
	{ "uint",    "array|byte",},
	{ "cfgId",   "pos",       },
}
GameMsg.map["BuildingProto:BuildCreateRet"] = {
	--建筑配置id 起点坐标     是否成功 
	{ "uint",    "array|byte","bool",  },
	{ "cfgId",   "pos",       "ok",    },
}
GameMsg.map["BuildingProto:BuildRemove"] = {
	--建筑id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["BuildingProto:BuildRemoveRet"] = {
	--建筑id 是否成功 
	{ "uint","bool",  },
	{ "id",  "ok",    },
}
GameMsg.map["sBuildSetRole"] = {
	--建筑id 角色id       当前预设队伍id 
	{ "uint","array|uint","uint",        },
	{ "id",  "roleIds",   "teamId",      },
}
GameMsg.map["BuildingProto:BuildSetRole"] = {
	--                     
	{ "list|sBuildSetRole",},
	{ "infos",             },
}
GameMsg.map["BuildingProto:BuildSetRoleRet"] = {
	--                     
	{ "list|sBuildSetRole",},
	{ "infos",             },
}
GameMsg.map["BuildingProto:GetRewards"] = {
	--建筑id       
	{ "array|uint",},
	{ "ids",       },
}
GameMsg.map["BuildingProto:GetRewardsRet"] = {
	--已经得到的奖励 
	{ "list|sReward",},
	{ "rewards",     },
}
GameMsg.map["BuildingProto:Upgrade"] = {
	--建筑id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["BuildingProto:UpgradeRet"] = {
	--建筑id        
	{ "uint","bool",},
	{ "id",  "ok",  },
}
GameMsg.map["BuildingProto:Trade"] = {
	--建筑id 订单id    
	{ "uint","uint",   },
	{ "id",  "orderId",},
}
GameMsg.map["BuildingProto:TradeRet"] = {
	--建筑id 订单id                   
	{ "uint","uint",   "list|sReward",},
	{ "id",  "orderId","rewards",     },
}
GameMsg.map["BuildingProto:Combine"] = {
	--建筑id 订单id    次数   
	{ "uint","uint",   "byte",},
	{ "id",  "orderId","cnt", },
}
GameMsg.map["BuildingProto:CombineRet"] = {
	--建筑id 订单id    次数                  是否足够材料 副产品         
	{ "uint","uint",   "byte","list|sReward","bool",      "list|sReward",},
	{ "id",  "orderId","cnt", "rewards",     "enoughItem","sub_rewards", },
}
GameMsg.map["BuildingProto:CombineFinish"] = {
	--建筑id 订单id    是否加速    
	{ "uint","uint",   "bool",     },
	{ "id",  "orderId","isSpeedUp",},
}
GameMsg.map["BuildingProto:CombineFinishRet"] = {
	--建筑id 订单id    是否加速    
	{ "uint","uint",   "bool",     },
	{ "id",  "orderId","isSpeedUp",},
}
GameMsg.map["BuildingProto:Remould"] = {
	--建筑id 订单id(改造池下标) 装备id    位置   
	{ "uint","uint",            "uint",   "byte",},
	{ "id",  "orderId",         "euqipId","slot",},
}
GameMsg.map["BuildingProto:RemouldRet"] = {
	--建筑id 订单id(改造池下标) 装备id    位置   
	{ "uint","uint",            "uint",   "byte",},
	{ "id",  "orderId",         "euqipId","slot",},
}
GameMsg.map["BuildingProto:RemouldFinish"] = {
	--建筑id 订单id    改造池id 
	{ "uint","uint",   "uint",  },
	{ "id",  "orderId","poolId",},
}
GameMsg.map["BuildingProto:RemouldFinishRet"] = {
	--建筑id 订单id    改造池id                
	{ "uint","uint",   "uint",  "list|sReward",},
	{ "id",  "orderId","poolId","rewards",     },
}
GameMsg.map["BuildingProto:AddHp"] = {
	--建筑id 加多少点血 
	{ "uint","short",   },
	{ "id",  "cnt",     },
}
GameMsg.map["BuildingProto:AddHpRet"] = {
	--建筑id 加多少点血 
	{ "uint","short",   },
	{ "id",  "cnt",     },
}
GameMsg.map["BuildingProto:SetWarningLv"] = {
	--级别   
	{ "byte",},
	{ "lv",  },
}
GameMsg.map["BuildingProto:SetWarningLvRet"] = {
	--级别   
	{ "byte",},
	{ "lv",  },
}
GameMsg.map["sAssualInfo"] = {
	--是否进行中 未打败的 已打败的 CfgBAssault表格openTimes数组的下标 已经得到的奖励 
	{ "bool",    "json",  "json",  "byte",              "list|sReward",},
	{ "running", "wIds",  "fIds",  "index",             "rewards",     },
}
GameMsg.map["BuildingProto:AssualtAttack"] = {
	--建筑id 怪物组数组下标 队伍id   指挥官技能id  
	{ "uint","uint",        "uint",  "int",        },
	{ "id",  "index",       "teamId","nSkillGroup",},
}
GameMsg.map["BuildingProto:AssualtAttackRet"] = {
	--建筑id 怪物组数组下标 结果     奖励           队伍id   是否强制退出  
	{ "uint","uint",        "bool",  "list|sReward","uint",  "bool",       },
	{ "id",  "index",       "bIsWin","rewards",     "teamId","isForceOver",},
}
GameMsg.map["BuildingProto:DeleteTradeOrder"] = {
	--建筑id 订单id    
	{ "uint","uint",   },
	{ "id",  "orderId",},
}
GameMsg.map["BuildingProto:DeleteTradeOrderRet"] = {
	--建筑id 订单id    
	{ "uint","uint",   },
	{ "id",  "orderId",},
}
GameMsg.map["BuildingProto:AssualtStart"] = {
	--                     
	{ "struts|sAssualInfo",},
	{ "info",              },
}
GameMsg.map["BuildingProto:AssualtStop"] = {
	--                     
	{ "struts|sAssualInfo",},
	{ "info",              },
}
GameMsg.map["BuildingProto:AssualtInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["BuildingProto:AssualtInfoRet"] = {
	--                     
	{ "struts|sAssualInfo",},
	{ "info",              },
}
GameMsg.map["sBuildMoveInfo"] = {
	--建筑id 位置         
	{ "uint","array|byte",},
	{ "id",  "pos",       },
}
GameMsg.map["BuildingProto:BuildMove"] = {
	--建筑id               
	{ "list|sBuildMoveInfo",},
	{ "infos",             },
}
GameMsg.map["BuildingProto:BuildMoveRet"] = {
	--建筑id               
	{ "list|sBuildMoveInfo",},
	{ "infos",             },
}
GameMsg.map["BuildingProto:GetBuildUpdate"] = {
	--建筑id列表   
	{ "array|uint",},
	{ "ids",       },
}
GameMsg.map["BuildingProto:UpdateNotices"] = {
	--建筑信息          是否完了    
	{ "list|sBuildInfo","bool",     },
	{ "builds",         "is_finish",},
}
GameMsg.map["BuildingProto:StoreBuild"] = {
	--建筑id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["BuildingProto:RecoverStoreBuild"] = {
	--建筑id 位置         
	{ "uint","array|byte",},
	{ "id",  "pos",       },
}
GameMsg.map["BuildingProto:StartExpedition"] = {
	--建筑id 任务类型   对应类型的任务下标 参加的卡牌ids 事件列表             
	{ "uint","byte",    "uint",            "array|uint", "list|sExpeditionEvent",},
	{ "id",  "taskType","index",           "cids",       "evens",             },
}
GameMsg.map["BuildingProto:FinishExpedition"] = {
	--建筑id 任务类型   对应类型的任务下标 
	{ "uint","byte",    "uint",            },
	{ "id",  "taskType","index",           },
}
GameMsg.map["sExpeditionEvent"] = {
	--事件id               
	{ "uint","array|short",},
	{ "id",  "indexs",     },
}
GameMsg.map["BuildingProto:DelExpTask"] = {
	--建筑id 任务类型   对应类型的任务下标 
	{ "uint","byte",    "uint",            },
	{ "id",  "taskType","index",           },
}
GameMsg.map["BuildingProto:GetOneReward"] = {
	--建筑id                          
	{ "uint","array|int","array|int", },
	{ "id",  "giftsIds", "giftsExIds",},
}
GameMsg.map["BuildingProto:GetOneRewardRet"] = {
	--建筑id 已经得到的奖励 
	{ "uint","list|sReward",},
	{ "id",  "rewards",     },
}
GameMsg.map["sBuildOpLog"] = {
	--好友id          头像   头像         操作类型 操作时间 等级   创建时候选择的性别序号 玩家称号     
	{ "uint","string","uint","uint",      "byte",  "uint",  "uint","byte",               "uint",      },
	{ "fid", "name",  "icon","icon_frame","type",  "time",  "lv",  "sel_card_ix",        "icon_title",},
}
GameMsg.map["BuildingProto:GetBuildOpLog"] = {
	--起始下标 [1,100) 获取数量 
	{ "byte",          "byte",  },
	{ "ix",            "cnt",   },
}
GameMsg.map["BuildingProto:GetBuildOpLogRet"] = {
	--获赞数目 记录               起始下标 [1,100) 获取数量 
	{ "int",   "list|sBuildOpLog","byte",          "byte",  },
	{ "agree", "infos",           "ix",            "cnt",   },
}
GameMsg.map["BuildingProto:TradeSpeedOrder"] = {
	--建筑id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["BuildingProto:TradeSpeedOrderRet"] = {
	--建筑id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["BuildingProto:Agree"] = {
	--好友id 
	{ "uint",},
	{ "fid", },
}
GameMsg.map["BuildingProto:AgreeRet"] = {
	--好友id 
	{ "uint",},
	{ "fid", },
}
GameMsg.map["sFlrOrder"] = {
	--       过期时间，0表示不过期 产生的角色id 可够买数量 
	{ "uint","uint",              "uint",      "short",   },
	{ "id",  "num",               "rid",       "bcnt",    },
}
GameMsg.map["BuildingProto:FlrTradeOrders"] = {
	--好友id 
	{ "uint",},
	{ "fid", },
}
GameMsg.map["BuildingProto:FlrTradeOrdersRet"] = {
	--好友id 建筑等级 订单列表         下次刷新时间点                  点赞次数   
	{ "uint","byte",  "list|sFlrOrder","uint",        "list|sCardRole","byte",    },
	{ "fid", "lv",    "giftsEx",       "tNexGiftsEx", "roles",         "agreeNum",},
}
GameMsg.map["BuildingProto:TradeFlrOrder"] = {
	--好友id           
	{ "uint","uint",   },
	{ "fid", "orderId",},
}
GameMsg.map["BuildingProto:TradeFlrOrderRet"] = {
	--好友id                          
	{ "uint","uint",   "list|sReward",},
	{ "fid", "orderId","rewards",     },
}
GameMsg.map["BuildingProto:PhySleep"] = {
	--建筑id          催眠游戏进度 
	{ "uint","uint",  "uint",      },
	{ "id",  "roleId","sleep_ix",  },
}
GameMsg.map["BuildingProto:PhySleepRet"] = {
	--建筑id                        剩余游戏次数 催眠游戏进度 
	{ "uint","uint",  "uint","uint","byte",      "uint",      },
	{ "id",  "roleId","lv",  "exp", "phyGameCnt","sleep_ix",  },
}
GameMsg.map["BuildingProto:BuildsListRet"] = {
	--建筑信息                      
	{ "list|sBuildInfo","bool",     },
	{ "builds",         "is_finish",},
}
GameMsg.map["sPresetRoleTeam"] = {
	--预设队伍id 预设队伍名称 预设队伍成员 
	{ "uint",    "string",    "array|uint",},
	{ "teamId",  "name",      "roleIds",   },
}
GameMsg.map["BuildingProto:BuildSetPresetRole"] = {
	--建筑id 预设队伍id 角色id       
	{ "uint","uint",    "array|uint",},
	{ "id",  "teamId",  "roleIds",   },
}
GameMsg.map["BuildingProto:BuildSetPresetRoleRet"] = {
	--建筑id 预设队伍信息         
	{ "uint","struts|sPresetRoleTeam",},
	{ "id",  "infos",             },
}
GameMsg.map["BuildingProto:BuildSetPresetTeamName"] = {
	--建筑id 预设队伍id 预设队伍名称 
	{ "uint","uint",    "string",    },
	{ "id",  "teamId",  "name",      },
}
GameMsg.map["BuildingProto:BuildSetPresetTeamNameRet"] = {
	--建筑id 预设队伍信息         
	{ "uint","struts|sPresetRoleTeam",},
	{ "id",  "infos",             },
}
GameMsg.map["BuildingProto:BuildAddPresetTeam"] = {
	--
	{ },
	{ },
}
GameMsg.map["BuildingProto:BuildAddPresetTeamRet"] = {
	--额外预设队伍数       
	{ "uint",              },
	{ "extraPresetTeamNum",},
}
GameMsg.map["sSkillGroup"] = {
	--技能组id 技能组等级 技能组等级   
	{ "uint",  "uint",    "array|uint",},
	{ "id",    "lv",      "skill_ids", },
}
GameMsg.map["AbilityProto:GetSkillGroup"] = {
	--
	{ },
	{ },
}
GameMsg.map["AbilityProto:GetSkillGroupRet"] = {
	--                     
	{ "map|sSkillGroup|id",},
	{ "groups",            },
}
GameMsg.map["AbilityProto:SkillGroupUpgrade"] = {
	--技能组id 
	{ "uint",  },
	{ "id",    },
}
GameMsg.map["AbilityProto:SkillGroupUpgradeRet"] = {
	--技能组id             
	{ "struts|sSkillGroup",},
	{ "group",             },
}
GameMsg.map["AbilityProto:SkillGroupUse"] = {
	--技能组id 队伍id    
	{ "uint",  "uint",   },
	{ "id",    "team_id",},
}
GameMsg.map["AbilityProto:SkillGroupUseRet"] = {
	--技能组id 队伍id    
	{ "uint",  "uint",   },
	{ "id",    "team_id",},
}
GameMsg.map["sAbility"] = {
	--能力id  
	{ "short",},
	{ "id",   },
}
GameMsg.map["AbilityProto:GetAbility"] = {
	--
	{ },
	{ },
}
GameMsg.map["AbilityProto:GetAbilityRet"] = {
	--能力点                 最后重置能力时间 
	{ "uint","list|sAbility","uint",          },
	{ "num", "abilitys",     "lastResetTime", },
}
GameMsg.map["AbilityProto:AddAbility"] = {
	--能力id  
	{ "short",},
	{ "id",   },
}
GameMsg.map["AbilityProto:ResetAbility"] = {
	--
	{ },
	{ },
}
GameMsg.map["sPermitGroup"] = {
	--ID通行证id 已经领取的下标index [1,2,3,5] 累计获得代币值 
	{ "int",     "array|byte",        "uint",        },
	{ "id",      "gets",              "total",       },
}
GameMsg.map["ExplorationProto:GetInfo"] = {
	--勘探表id(校对使用) 
	{ "uint",            },
	{ "id",              },
}
GameMsg.map["sExplorationInfo"] = {
	--勘探奖励模板id 已经领取的下标 [1,2,3,5] 
	{ "uint",        "array|uint",        },
	{ "rid",         "gets",              },
}
GameMsg.map["ExplorationProto:GetInfoRet"] = {
	--勘探表id               勘探类型 领取情况             超过上线等级可领取次数 超过上线等级可领取次数 
	{ "uint",  "uint","uint","byte",  "map|sExplorationInfo|rid","uint",               "uint",               },
	{ "id",    "lv",  "exp", "type",  "get_infos",         "can_get_cnt",        "ex_can_get_cnt",     },
}
GameMsg.map["ExplorationProto:Update"] = {
	--勘探表id               超过上线等级可领取次数 超过上线等级可领取次数 
	{ "uint",  "uint","uint","uint",               "uint",               },
	{ "id",    "lv",  "exp", "can_get_cnt",        "ex_can_get_cnt",     },
}
GameMsg.map["ExplorationProto:GetReward"] = {
	--勘探表id 勘探奖励模板id(-1:全部领取) 领取下标 
	{ "uint",  "int",                "uint",  },
	{ "id",    "rid",                "ix",    },
}
GameMsg.map["ExplorationProto:GetRewardRet"] = {
	--勘探表id 领取情况（仅包含，刚领取的） 
	{ "uint",  "map|sExplorationInfo|rid", },
	{ "id",    "get_infos",          },
}
GameMsg.map["ExplorationProto:Upgrade"] = {
	--勘探表id 提升到多少级 
	{ "uint",  "uint",      },
	{ "id",    "lv",        },
}
GameMsg.map["ExplorationProto:UpgradeRet"] = {
	--勘探表id 升级后等级 
	{ "uint",  "uint",    },
	{ "id",    "lv",      },
}
GameMsg.map["ExplorationProto:Open"] = {
	--勘探表id 开通的勘探类型 
	{ "uint",  "byte",        },
	{ "id",    "type",        },
}
GameMsg.map["ExplorationProto:OpenRet"] = {
	--勘探表id 开通后的类型 
	{ "uint",  "byte",      },
	{ "id",    "type",      },
}
GameMsg.map["ExplorationProto:GetTaskResetTime"] = {
	--
	{ },
	{ },
}
GameMsg.map["ExplorationProto:GetTaskResetTimeRet"] = {
	--每日任务的重置时间 每周任务的重置时间 赛期任务的重置时间 
	{ "uint",            "uint",            "uint",            },
	{ "d_time",          "w_time",          "m_time",          },
}
GameMsg.map["PermitProto:GetInfo"] = {
	--ID通行证id(-1:全部获取) 
	{ "int",                },
	{ "id",                 },
}
GameMsg.map["PermitProto:GetInfoRet"] = {
	--                    
	{ "list|sPermitGroup",},
	{ "list",             },
}
GameMsg.map["PermitProto:GetReward"] = {
	--ID通行证id 进度index(-1:全部领取) 
	{ "int",     "int",               },
	{ "id",      "index",             },
}
GameMsg.map["PermitProto:GetRewardRet"] = {
	--ID通行证id 领取信息     
	{ "int",     "array|byte",},
	{ "id",      "gets",      },
}
GameMsg.map["sGuildMemA"] = {
	--       名称     头像      职位    等级   上次在线时间 申请时间  
	{ "uint","string","uint",   "byte", "uint","uint",      "uint",   },
	{ "uid", "name",  "icon_id","title","lv",  "pre_online","t_apply",},
}
GameMsg.map["sGuildMemB"] = {
	--       好友数量 介绍     支援队伍/好友助战   
	{ "uint","uint",  "string","list|TeamItemData",},
	{ "uid", "f_num", "desc",  "team",             },
}
GameMsg.map["sGuildMem"] = {
	--       名称     头像      职位    等级   上次在线时间 好友数量 介绍     支援队伍/好友助战 
	{ "uint","string","uint",   "byte", "uint","uint",      "uint",  "string","list|sCardsData",},
	{ "uid", "name",  "icon_id","title","lv",  "pre_online","f_num", "desc",  "team",           },
}
GameMsg.map["sGuildMemRank"] = {
	--       名称     头像      排名   全局排名   总分        今日分数      
	{ "uint","string","uint",   "uint","uint",    "uint",     "uint",       },
	{ "uid", "name",  "icon_id","rank","sum_rank","sum_score","today_score",},
}
GameMsg.map["sGuildA"] = {
	--工会id/8位 工会名称/10字数内 工会头像 活动类型        1<= 申请等级 <= 创建者等级 成员数量  批准类型      
	{ "uint",    "string",         "uint",  "byte",         "uint",               "uint",   "byte",       },
	{ "id",      "name",           "icon",  "activity_type","apply_lv",           "mem_cnt","ratify_type",},
}
GameMsg.map["sGuildB"] = {
	--创建者id 创建者名字 现任会长 现任名字 排名   工会名片/简介 
	{ "uint",  "string",  "uint",  "string","uint","string",     },
	{ "c_uid", "c_name",  "n_uid", "n_name","rank","desc",       },
}
GameMsg.map["sGuild"] = {
	--工会id/8位 工会名称/10字数内 工会头像 活动类型        1<= 申请等级 <= 创建者等级 成员数量  创建者id 创建者名字 现任会长 现任名字 排名   批准类型      工会名片/简介 积分    排名分组   是否开启工会贡献 
	{ "uint",    "string",         "uint",  "byte",         "uint",               "uint",   "uint",  "string",  "uint",  "string","uint","byte",       "string",     "int",  "byte",    "byte",          },
	{ "id",      "name",           "icon",  "activity_type","apply_lv",           "mem_cnt","c_uid", "c_name",  "n_uid", "n_name","rank","ratify_type","desc",       "score","group_id","open_score_add",},
}
GameMsg.map["sGuildRank"] = {
	--工会id/8位 工会名称/10字数内 工会头像 积分    排名   排名分组   分组排名     
	{ "uint",    "string",         "uint",  "int",  "uint","byte",    "byte",      },
	{ "id",      "name",           "icon",  "score","rank","group_id","group_rank",},
}
GameMsg.map["GuildProto:GuildInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:GuildInfoRet"] = {
	--                自己的职位 
	{ "struts|sGuild","byte",    },
	{ "info",         "title",   },
}
GameMsg.map["GuildProto:Search"] = {
	--       
	{ "uint",},
	{ "id",  },
}
GameMsg.map["GuildProto:SearchRet"] = {
	--              
	{ "list|sGuild",},
	{ "info",       },
}
GameMsg.map["GuildProto:Recoment"] = {
	--是否刷新 
	{ "bool",  },
	{ "flush", },
}
GameMsg.map["GuildProto:RecomentRet"] = {
	--              
	{ "list|sGuild",},
	{ "info",       },
}
GameMsg.map["GuildProto:Join"] = {
	--       
	{ "uint",},
	{ "id",  },
}
GameMsg.map["GuildProto:JoinRet"] = {
	--                 
	{ "struts|sGuildA",},
	{ "info",          },
}
GameMsg.map["GuildProto:Create"] = {
	--                
	{ "struts|sGuild",},
	{ "info",         },
}
GameMsg.map["GuildProto:CreateRet"] = {
	--                
	{ "struts|sGuild",},
	{ "info",         },
}
GameMsg.map["GuildProto:SetBoss"] = {
	--对方Id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["GuildProto:SetBossRet"] = {
	--对方Id          
	{ "long","string",},
	{ "uid", "name",  },
}
GameMsg.map["GuildProto:SetSubBoss"] = {
	--对方Id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["GuildProto:SetSubBossRet"] = {
	--对方Id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["GuildProto:DelMem"] = {
	--对方Id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["GuildProto:DelMemRet"] = {
	--对方Id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["GuildProto:ApplyOp"] = {
	--对方Id 是否允许   
	{ "long","bool",    },
	{ "uid", "is_allow",},
}
GameMsg.map["GuildProto:ApplyOpRet"] = {
	--对方Id 是否允许   
	{ "long","bool",    },
	{ "uid", "is_allow",},
}
GameMsg.map["GuildProto:DelGuild"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:DelGuildRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:MemberInfo"] = {
	--对方Id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["GuildProto:MemberInfoRet"] = {
	--                    
	{ "struts|sGuildMemB",},
	{ "info",             },
}
GameMsg.map["GuildProto:Quit"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:QuitRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:ModInfo"] = {
	--                
	{ "struts|sGuild",},
	{ "info",         },
}
GameMsg.map["GuildProto:ModInfoRet"] = {
	--                
	{ "struts|sGuild",},
	{ "info",         },
}
GameMsg.map["GuildProto:LookTeam"] = {
	--对方Id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["GuildProto:LookTeamRet"] = {
	--对方Id                   
	{ "long","list|sCardsData",},
	{ "uid", "team",           },
}
GameMsg.map["GuildProto:LookPlrApplyLog"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:LookPlrApplyLogRet"] = {
	--              
	{ "list|sGuild",},
	{ "infos",      },
}
GameMsg.map["GuildProto:LookGuildApplyLog"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:LookGuildApplyLogRet"] = {
	--        
	{ "json", },
	{ "infos",},
}
GameMsg.map["GuildProto:DelNotice"] = {
	--工会id/8位 工会名称/10字数内 
	{ "uint",    "string",         },
	{ "id",      "name",           },
}
GameMsg.map["GuildProto:ApplyRetNotice"] = {
	--工会id/8位 工会名称/10字数内 是否加入  
	{ "uint",    "string",         "bool",   },
	{ "id",      "name",           "is_join",},
}
GameMsg.map["GuildProto:MemberList"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:MemberListRet"] = {
	--          
	{ "json",   },
	{ "members",},
}
GameMsg.map["GuildProto:DelGuildNotice"] = {
	--工会id/8位 
	{ "uint",    },
	{ "id",      },
}
GameMsg.map["GuildProto:CancleApply"] = {
	--       
	{ "uint",},
	{ "id",  },
}
GameMsg.map["GuildProto:CancleApplyRet"] = {
	--       
	{ "uint",},
	{ "id",  },
}
GameMsg.map["GuildProto:UnSetSubBoss"] = {
	--对方Id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["GuildProto:UnSetSubBossRet"] = {
	--对方Id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["GuildProto:JoinNotice"] = {
	--对方Id          
	{ "long","string",},
	{ "uid", "name",  },
}
GameMsg.map["GuildProto:AllowNotice"] = {
	--对方Id          
	{ "long","string",},
	{ "uid", "name",  },
}
GameMsg.map["GuildProto:LeaveNotice"] = {
	--对方Id          
	{ "long","string",},
	{ "uid", "name",  },
}
GameMsg.map["GuildProto:MemberUpdateNotice"] = {
	--                 
	{ "list|sGuildMem",},
	{ "infos",         },
}
GameMsg.map["sGFPlrInfo"] = {
	--玩家今天分值  玩家累计分值 玩家全服排名 玩家会内排名 对手工会名称 对手分数      对手工会id 对手工会头像 
	{ "int",        "int",       "int",       "int",       "string",    "int",        "int",     "int",       },
	{ "today_score","sum_score", "sum_rank",  "rank",      "guild_name","guild_score","guild_id","guild_icon",},
}
GameMsg.map["sGFRoom"] = {
	--房间id 房间配置id 创建者id 创建者名称 结束时间   总血量 当前血量 房间类型 
	{ "int", "int",     "int",   "string",  "int",     "int", "int",   "byte",  },
	{ "id",  "cfg_id",  "c_id",  "c_name",  "end_time","hp",  "cur_hp","type",  },
}
GameMsg.map["GuildProto:GFinfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:GFinfoRet"] = {
	--                                        是否参加工会战 
	{ "struts|sGFPlrInfo","struts|sGuildRank","bool",        },
	{ "plr_info",         "guild_info",       "inRange",     },
}
GameMsg.map["GuildProto:GFRooms"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:GFRoomsAdd"] = {
	--第一个协议消息 最后一个协议消息                
	{ "bool",        "bool",          "list|sGFRoom",},
	{ "first",       "last",          "rooms",       },
}
GameMsg.map["sGFSelfFightLog"] = {
	--季度id 当前季度第几回合 第几条从1开始 房间配置id    创建者名字 是否胜利 个人贡献分值 结束时间 
	{ "byte","byte",          "int",        "int",        "string",  "bool",  "int",       "int",   },
	{ "f_id","f_ix",          "ix",         "room_cfg_id","c_name",  "win",   "score",     "time",  },
}
GameMsg.map["sGFGuildFightLog"] = {
	--季度id 当前季度第几回合 第几条从1开始 结束时间 分组id     胜利的工会id 工会idA 工会头像 工会名字A 工会积分A 工会idB 工会头像 工会名字B 工会积分B 
	{ "byte","byte",          "int",        "int",   "byte",    "int",       "int",  "int",   "string", "int",    "int",  "int",   "string", "int",    },
	{ "f_id","f_ix",          "ix",         "time",  "group_id","win_id",    "id_a", "icon_a","name_a", "score_a","id_b", "icon_b","name_b", "score_b",},
}
GameMsg.map["GuildProto:GFSelfFightLog"] = {
	--开始下标(-1开始)从头开始 ix 是从大往小的 
	{ "short",              },
	{ "ix",                 },
}
GameMsg.map["GuildProto:GFSelfFightLogRet"] = {
	--开始下标                      
	{ "short", "list|sGFSelfFightLog",},
	{ "ix",    "infos",             },
}
GameMsg.map["GuildProto:GFGuildFightLog"] = {
	--开始下标(-1开始)从头开始 ix 是从大往小的 
	{ "short",              },
	{ "ix",                 },
}
GameMsg.map["GuildProto:GFGuildFightLogRet"] = {
	--开始下标                      
	{ "short", "list|sGFGuildFightLog",},
	{ "ix",    "infos",             },
}
GameMsg.map["GuildProto:GFGuildGobalRank"] = {
	--开始下标 
	{ "short", },
	{ "ix",    },
}
GameMsg.map["GuildProto:GFGuildGobalRankRet"] = {
	--开始下标 长度                       
	{ "short", "short", "list|sGuildRank",},
	{ "ix",    "max_ix","infos",          },
}
GameMsg.map["GuildProto:GFGuildGroupRank"] = {
	--开始下标 
	{ "byte",  },
	{ "ix",    },
}
GameMsg.map["GuildProto:GFGuildGroupRankRet"] = {
	--开始下标 长度                       
	{ "byte",  "short", "list|sGuildRank",},
	{ "ix",    "max_ix","infos",          },
}
GameMsg.map["GuildProto:GFMemberGuildRank"] = {
	--开始下标 
	{ "short", },
	{ "ix",    },
}
GameMsg.map["GuildProto:GFMemberGuildRankRet"] = {
	--开始下标 长度                          
	{ "short", "short", "list|sGuildMemRank",},
	{ "ix",    "max_ix","infos",             },
}
GameMsg.map["GuildProto:GFMemberGobalRank"] = {
	--开始下标 
	{ "short", },
	{ "ix",    },
}
GameMsg.map["GuildProto:GFMemberGobalRankRet"] = {
	--开始下标 长度                          
	{ "short", "short", "list|sGuildMemRank",},
	{ "ix",    "max_ix","infos",             },
}
GameMsg.map["GuildProto:GFJoinRoom"] = {
	--房间id 房间配置id 
	{ "int", "int",     },
	{ "id",  "cfg_id",  },
}
GameMsg.map["GuildProto:GFRoomsUpdate"] = {
	--暂时只有id与血量字段(血量为0表示胜利结束) 
	{ "list|sGFRoom",      },
	{ "infos",             },
}
GameMsg.map["GuildProto:GFInfoUpdate"] = {
	--                                        上一轮胜负 
	{ "struts|sGuildRank","struts|sGFPlrInfo","bool",    },
	{ "guild_info",       "plr_info",         "is_win",  },
}
GameMsg.map["GuildProto:GFCreateRoom"] = {
	--配置表id 房间类型 
	{ "int",   "byte",  },
	{ "cfg_id","type",  },
}
GameMsg.map["GuildProto:GFSchedue"] = {
	--
	{ },
	{ },
}
GameMsg.map["GuildProto:GFSchedueRet"] = {
	--是否在封闭操作期间 配置表 CfgGuildFightSchedule id 工会战阶段   
	{ "bool",            "int",               "byte",      },
	{ "inFighting",      "fightCfigId",       "fightIndex",},
}
GameMsg.map["GuildProto:GFRoomUpdateHp"] = {
	--暂时只有id与血量字段(血量为0表示胜利结束) 
	{ "struts|sGFRoom",    },
	{ "info",              },
}
GameMsg.map["sTheme"] = {
	--主题id 名称     创建时间 作者id 作者名称 作者头像 收藏量(收藏量小于1时候删除) 点赞    舒适度    图片名称 家具列表            房间等级 是否收藏到 是否点赞  
	{ "uint","string","long",  "uint","string","uint",  "int",                "uint", "uint",   "string","map|sFurniture|id","int",   "bool",    "bool",   },
	{ "id",  "name",  "cTime", "cId", "cName", "icon",  "store",              "agree","comfort","img",   "furnitures",       "lv",    "isStore", "isAgree",},
}
GameMsg.map["sFurniture"] = {
	--家具id = cfgId * 10000 + 自增id 位置           所在面      角度      父index    子index   
	{ "uint",              "struts|Point","int",      "int",    "int",     "int[]",  },
	{ "id",                "point",       "planeType","rotateY","parentID","childID",},
}
GameMsg.map["sDormA"] = {
	--宿舍id (楼层id * 100 + index) 人数(好友时才有) 入住角色id   等级    图片名称 舒适度    
	{ "uint",              "short",         "array|uint","short","string","uint",   },
	{ "id",                "num",           "roleIds",   "lv",   "img",   "comfort",},
}
GameMsg.map["sDormData"] = {
	--图片名称 入住角色id   家具列表            入住宠物信息 
	{ "string","array|uint","map|sFurniture|id","array|uint",},
	{ "img",   "roleIds",   "furnitures",       "petIds",    },
}
GameMsg.map["sDormB"] = {
	--宿舍id 人数    等级    舒适度                       
	{ "uint","short","short","uint",   "struts|sDormData",},
	{ "id",  "num",  "lv",   "comfort","data",            },
}
GameMsg.map["DormProto:GetOpenDorm"] = {
	--好友id(没有表示获取自己的） 
	{ "uint",              },
	{ "fid",               },
}
GameMsg.map["DormProto:GetOpenDormRet"] = {
	--好友id(没有表示获取自己的）               
	{ "uint",              "list|sDormA",},
	{ "fid",               "infos",      },
}
GameMsg.map["DormProto:GetDorm"] = {
	--好友id(没有表示获取自己的） 宿舍id 
	{ "uint",              "uint",},
	{ "fid",               "id",  },
}
GameMsg.map["DormProto:GetDormRet"] = {
	--好友id(没有表示获取自己的）                 
	{ "uint",              "struts|sDormB",},
	{ "fid",               "info",         },
}
GameMsg.map["DormProto:Upgrade"] = {
	--宿舍id 家具列表            图片名称 
	{ "uint","map|sFurniture|id","string",},
	{ "id",  "furnitures",       "img",   },
}
GameMsg.map["DormProto:UpgradeRet"] = {
	--宿舍id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["DormProto:Update"] = {
	--除了id，只会有更新的字段 
	{ "list|sDormB",        },
	{ "infos",              },
}
GameMsg.map["DormProto:UseGift"] = {
	--角色id   礼物列表        
	{ "uint",  "list|sNumInfo",},
	{ "roleId","items",        },
}
GameMsg.map["DormProto:UseGiftRet"] = {
	--角色id   
	{ "uint",  },
	{ "roleId",},
}
GameMsg.map["DormProto:ModFurniture"] = {
	--宿舍id 家具列表            图片名称 
	{ "uint","map|sFurniture|id","string",},
	{ "id",  "furnitures",       "img",   },
}
GameMsg.map["DormProto:ModFurnitureRet"] = {
	--宿舍id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["DormProto:GetSelfTheme"] = {
	--主题类型     
	{ "array|byte",},
	{ "themeTypes",},
}
GameMsg.map["DormProto:GetSelfThemeRet"] = {
	--主题类型    列表                       
	{ "byte",     "map|sTheme|id","bool",    },
	{ "themeType","themes",       "isFinish",},
}
GameMsg.map["DormProto:GetWroldTheme"] = {
	--从第几个开始获取 申请几个 获取类型(1:时间，2：收藏) 
	{ "short",         "byte",  "byte",               },
	{ "ix",            "len",   "byType",             },
}
GameMsg.map["DormProto:GetWroldThemeRet"] = {
	--列表          从第几个开始获取 申请几个 获取类型(1:时间，2：收藏)            
	{ "list|sTheme","short",         "byte",  "byte",               "bool",    },
	{ "themes",     "ix",            "len",   "byType",             "isFinish",},
}
GameMsg.map["DormProto:UseTheme"] = {
	--宿舍id 家具列表            图片名称 
	{ "uint","map|sFurniture|id","string",},
	{ "id",  "furnitures",       "img",   },
}
GameMsg.map["DormProto:UseThemeRet"] = {
	--宿舍id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["DormProto:BuyTheme"] = {
	--方案id    扣费方式[ price_1 / price_2 ] 
	{ "uint",   "string",            },
	{ "themeId","useCost",           },
}
GameMsg.map["DormProto:BuyThemeRet"] = {
	--方案id    购买的家具列表（家具配置id） 扣费方式[ price_1 / price_2 ] 是否买完    
	{ "uint",   "array|uint",         "string",            "bool",     },
	{ "themeId","ids",                "useCost",           "isFullBuy",},
}
GameMsg.map["DormProto:StoreTheme"] = {
	--方案id    是否取消   
	{ "uint",   "bool",    },
	{ "themeId","isCancel",},
}
GameMsg.map["DormProto:StoreThemeRet"] = {
	--方案id    是否取消   收藏量小于1的时候，删除图片 
	{ "uint",   "bool",    "struts|sTheme",     },
	{ "themeId","isCancel","info",              },
}
GameMsg.map["DormProto:AgreeTheme"] = {
	--方案id    是否取消   
	{ "uint",   "bool",    },
	{ "themeId","isCancel",},
}
GameMsg.map["DormProto:AgreeThemeRet"] = {
	--方案id    是否取消   
	{ "uint",   "bool",    },
	{ "themeId","isCancel",},
}
GameMsg.map["DormProto:ShareTheme"] = {
	--宿舍id（分享宿舍的） 分享的名字（分享宿舍的） 方案id(保存中分享) 
	{ "uint",              "string",             "uint",            },
	{ "id",                "name",               "themeId",         },
}
GameMsg.map["DormProto:ShareThemeRet"] = {
	--                
	{ "struts|sTheme",},
	{ "info",         },
}
GameMsg.map["DormProto:UnShareTheme"] = {
	--方案id    
	{ "uint",   },
	{ "themeId",},
}
GameMsg.map["DormProto:UnShareThemeRet"] = {
	--方案id    收藏量小于1的时候，删除图片 
	{ "uint",   "int",               },
	{ "themeId","store",             },
}
GameMsg.map["DormProto:SaveTheme"] = {
	--保存的名字 家具列表            舒适度    房间等级 图片名称 
	{ "string",  "map|sFurniture|id","uint",   "int",   "string",},
	{ "name",    "furnitures",       "comfort","lv",    "img",   },
}
GameMsg.map["DormProto:SaveThemeRet"] = {
	--                
	{ "struts|sTheme",},
	{ "info",         },
}
GameMsg.map["DormProto:UnSaveTheme"] = {
	--方案id    
	{ "uint",   },
	{ "themeId",},
}
GameMsg.map["DormProto:UnSaveThemeRet"] = {
	--方案id    
	{ "uint",   },
	{ "themeId",},
}
GameMsg.map["DormProto:TakeEvent"] = {
	--宿舍id 角色id   
	{ "uint","uint",  },
	{ "id",  "roleId",},
}
GameMsg.map["DormProto:TakeEventRet"] = {
	--宿舍id 奖励经验 
	{ "uint","short", },
	{ "id",  "exp",   },
}
GameMsg.map["DormProto:Open"] = {
	--宿舍id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["DormProto:OpenRet"] = {
	--宿舍id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["DormProto:UseClothes"] = {
	--                      
	{ "uint",  "array|uint",},
	{ "roleId","itemIds",   },
}
GameMsg.map["DormProto:UseClothesRet"] = {
	--                      
	{ "uint",  "array|uint",},
	{ "roleId","itemIds",   },
}
GameMsg.map["DormProto:BuyRecord"] = {
	--
	{ },
	{ },
}
GameMsg.map["DormProto:BuyRecordRet"] = {
	--        
	{ "json", },
	{ "infos",},
}
GameMsg.map["DormProto:BuyFurniture"] = {
	--                扣费方式[ price_1 / price_2 ] 
	{ "list|sNumInfo","string",            },
	{ "infos",        "useCost",           },
}
GameMsg.map["DormProto:BuyFurnitureRet"] = {
	--                扣费方式[ price_1 / price_2 ] 
	{ "list|sNumInfo","string",            },
	{ "infos",        "useCost",           },
}
GameMsg.map["DormProto:SearchTheme"] = {
	--方案id    
	{ "uint",   },
	{ "themeId",},
}
GameMsg.map["DormProto:SearchThemeRet"] = {
	--                
	{ "struts|sTheme",},
	{ "info",         },
}
GameMsg.map["DormProto:SetPet"] = {
	--宠物信息           
	{ "list|sDormSetPet",},
	{ "info",            },
}
GameMsg.map["DormProto:SetPetRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["sDormSetPet"] = {
	--宿舍id 宠物ID       
	{ "uint","array|uint",},
	{ "id",  "petIds",    },
}
GameMsg.map["sDormPet"] = {
	--宠物ID 宿舍ID     
	{ "uint","uint",    },
	{ "id",  "build_id",},
}
GameMsg.map["DormProto:DormPetInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["DormProto:DormPetInfoRet"] = {
	--宠物信息        
	{ "list|sDormPet",},
	{ "info",         },
}
GameMsg.map["sFriendInfo"] = {
	--好友id 头像id    头像框       名称     别名     好友度        状态    改变时间      是否在线    离线时间         等级    添加时间   请求信息    是否已读  战胜次数  战败次数   上次拒绝时间       是否在战斗中 卡牌信息携带 equip_ids 签名     基地开放情况  性别序号      玩家称号     
	{ "long","uint",   "uint",      "string","string","uint",       "byte", "long",       "bool",     "long",          "uint", "long",    "string",   "byte",   "uint",   "uint",    "uint",            "bool",      "struts|TeamItem",   "string","array|byte", "byte",       "uint",      },
	{ "uid", "icon_id","icon_frame","name",  "alias", "friend_rate","state","chagne_time","is_online","last_save_time","level","add_time","apply_msg","is_read","win_cnt","lost_cnt","army_refuse_time","in_pvp",    "assit_team",        "sign",  "build_opens","sel_card_ix","icon_title",},
}
GameMsg.map["FriendProto:GetFriendsData"] = {
	--
	{ },
	{ },
}
GameMsg.map["FriendProto:FriendAdd"] = {
	--列表               已删好友数    已申请好友数    
	{ "list|sFriendInfo","short",      "short",        },
	{ "friends",         "had_del_cnt","had_apply_cnt",},
}
GameMsg.map["FriendProto:FriendFlush"] = {
	--列表               
	{ "list|sFriendInfo",},
	{ "friends",         },
}
GameMsg.map["FriendProto:HelpFigtInfo"] = {
	--好友id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["FriendProto:HelpFigtInfoRet"] = {
	--好友id                   
	{ "long","list|sCardsData",},
	{ "uid", "team",           },
}
GameMsg.map["FriendProto:HelpFightCard"] = {
	--好友id 选择的卡牌id 
	{ "long","uint",      },
	{ "uid", "cid",       },
}
GameMsg.map["FriendProto:HelpFightCardRet"] = {
	--好友id 选择的卡牌id                   
	{ "long","uint",      "list|sCardsData",},
	{ "uid", "cid",       "cards",          },
}
GameMsg.map["FriendProto:Search"] = {
	--名称     
	{ "string",},
	{ "name",  },
}
GameMsg.map["FriendProto:SearchRet"] = {
	--                   
	{ "list|sFriendInfo",},
	{ "info",            },
}
GameMsg.map["FriendProto:GetFlush"] = {
	--sFriendInfo里面需要获取更新的字段(例如：{name, level}) 
	{ "array|string",      },
	{ "fileds",            },
}
GameMsg.map["sOpInfo"] = {
	--状态    好友id 请求信息    
	{ "byte", "long","string",   },
	{ "state","uid", "apply_msg",},
}
GameMsg.map["FriendProto:Op"] = {
	--               
	{ "list|sOpInfo",},
	{ "ops",         },
}
GameMsg.map["FriendProto:OpRet"] = {
	--               已删好友数    已申请好友数    
	{ "list|sOpInfo","short",      "short",        },
	{ "ops",         "had_del_cnt","had_apply_cnt",},
}
GameMsg.map["FriendProto:Alias"] = {
	--好友id          
	{ "long","string",},
	{ "uid", "alias", },
}
GameMsg.map["FriendProto:AliasRet"] = {
	--好友id          
	{ "long","string",},
	{ "uid", "alias", },
}
GameMsg.map["FriendProto:GetRecomend"] = {
	--是否手动刷新 
	{ "bool",      },
	{ "is_manual", },
}
GameMsg.map["FriendProto:GetRecomendRet"] = {
	--                   上次自动刷新时间 
	{ "list|sFriendInfo","long",          },
	{ "info",            "pre_flush_time",},
}
GameMsg.map["FriendProto:SendMsg"] = {
	--好友id          
	{ "long","string",},
	{ "uid", "msg",   },
}
GameMsg.map["FriendProto:SendMsgRet"] = {
	--好友id                 
	{ "long","string","long",},
	{ "uid", "msg",   "time",},
}
GameMsg.map["FriendProto:RecvNotice"] = {
	--好友id                 
	{ "long","string","long",},
	{ "uid", "msg",   "time",},
}
GameMsg.map["FriendProto:SetIsRead"] = {
	--好友id       
	{ "array|long",},
	{ "uid",       },
}
GameMsg.map["sAssitInfo"] = {
	--好友id 玩家名称 别名     助战的卡牌(获取单个玩家时，返回全部信息，否则只有 cfgid 和 cid)                                协战次数    最后登录时间     是否在线 是否好友 性别序号      玩家称号     
	{ "long","string","string","list|sCardsData",   "uint",   "uint",      "uint", "byte",     "uint",          "bool",  "bool",  "byte",       "uint",      },
	{ "uid", "name",  "alias", "cards",             "icon_id","icon_frame","level","assit_cnt","last_save_time","online","is_fls","sel_card_ix","icon_title",},
}
GameMsg.map["FriendProto:GetAssitInfo"] = {
	--好友id(无为获取全部) 
	{ "long",              },
	{ "uid",               },
}
GameMsg.map["FriendProto:AssitInfoAdd"] = {
	--好友id(无发为获取全部)                   新爬塔锁定的角色     
	{ "long",              "list|sAssitInfo","list|sNewTowerAssitInfo",},
	{ "uid",               "assits",         "new_tower_assits",  },
}
GameMsg.map["FriendProto:FriendPaneInfo"] = {
	--好友id 
	{ "long",},
	{ "uid", },
}
GameMsg.map["FriendProto:FriendPaneInfoRet"] = {
	--面板信息             好友id 玩家名称 等级    经验   签名     徽章的位置         
	{ "struts|sPlrPaneInfo","long","string","uint", "uint","string","list|sStrNumInfo",},
	{ "info",              "uid", "name",  "level","exp", "sign",  "badgedPos",       },
}
GameMsg.map["FriendProto:GetFriendCard"] = {
	--好友id 选择的卡牌id 0:协战，1：好友列表(除了搜索之外)，2：好友搜索 
	{ "long","array|uint","byte",               },
	{ "uid", "cids",      "ix",                 },
}
GameMsg.map["FriendProto:GetFriendCardRet"] = {
	--包含装备和技能信息 
	{ "list|sCardsData", },
	{ "cards",           },
}
GameMsg.map["sTeamBossRoom"] = {
	--房间id 创建者id 配置表id 模式下标(index,简单/普通/困难) 当前血量 最大血量 创建时间 房间状态 队伍信息             是否邀请   
	{ "int", "long",  "int",   "byte",               "int",   "int",   "long",  "byte",  "list|sTeamBossTeam","bool",    },
	{ "id",  "uid",   "cfgid", "ix",                 "curHp", "maxHp", "cTime", "state", "teams",             "isInvite",},
}
GameMsg.map["TeamBoss:Rooms"] = {
	--是否开启中的(false，返回完结的列表) 
	{ "bool",               },
	{ "isStarting",         },
}
GameMsg.map["TeamBoss:RoomsRet"] = {
	--是否开启中的 房间列表(包含邀请机制的房间) 创建限制时间(没有为 0 or nil) 是否发送完结 
	{ "bool",      "json",              "uint",              "bool",      },
	{ "isStarting","rooms",             "createLimitTime",   "isFinish",  },
}
GameMsg.map["sTeamBossTeam"] = {
	--玩家id 玩家名字 对方队伍          伤害累计  队伍状态 
	{ "long","string","struts|TeamItem","int",    "byte",  },
	{ "uid", "name",  "team",           "hurtCnt","state", },
}
GameMsg.map["TeamBoss:RoomCreate"] = {
	--配置表id 模式下标(index,简单/普通/困难) 是否邀请制 
	{ "int",   "byte",               "bool",    },
	{ "cfgid", "ix",                 "isInvite",},
}
GameMsg.map["TeamBoss:RoomCreateRet"] = {
	--                     
	{ "struts|sTeamBossRoom",},
	{ "room",              },
}
GameMsg.map["TeamBoss:JoinRoom"] = {
	--房间id 
	{ "int", },
	{ "id",  },
}
GameMsg.map["TeamBoss:JoinRoomRet"] = {
	--房间id        
	{ "int", "bool",},
	{ "id",  "isOk",},
}
GameMsg.map["TeamBoss:RoomUpdate"] = {
	--只更房间id、血量和状态,队伍的只更累计伤害、是否准备好 是否开启中的(false，返回完结的列表) 
	{ "struts|sTeamBossRoom", "bool",               },
	{ "room",               "isStarting",         },
}
GameMsg.map["TeamBoss:RoomInvite"] = {
	--被邀请玩家id 房间id 
	{ "long",      "int", },
	{ "uid",       "id",  },
}
GameMsg.map["TeamBoss:RoomInviteRet"] = {
	--被邀请玩家id 房间id        
	{ "long",      "int", "bool",},
	{ "uid",       "id",  "isOk",},
}
GameMsg.map["TeamBoss:RoomBeInvite"] = {
	--发起玩家id 房间id 邀请时间      配置表id 模式下标(index,简单/普通/困难) 
	{ "long",    "int", "uint",       "int",   "byte",               },
	{ "uid",     "id",  "invite_time","cfgid", "ix",                 },
}
GameMsg.map["TeamBoss:RoomBeInviteRet"] = {
	--发起玩家id 房间id 是否接受  
	{ "long",    "int", "bool",   },
	{ "uid",     "id",  "receive",},
}
GameMsg.map["TeamBoss:Prepare"] = {
	--房间id 设置状态 
	{ "int", "byte",  },
	{ "id",  "state", },
}
GameMsg.map["TeamBoss:PrepareRet"] = {
	--房间id 设置状态 
	{ "int", "byte",  },
	{ "id",  "state", },
}
GameMsg.map["TeamBoss:Start"] = {
	--房间id 
	{ "int", },
	{ "id",  },
}
GameMsg.map["TeamBoss:StartRet"] = {
	--房间id        
	{ "int", "bool",},
	{ "id",  "isOk",},
}
GameMsg.map["TeamBoss:LeaveRoom"] = {
	--房间id 
	{ "int", },
	{ "id",  },
}
GameMsg.map["TeamBoss:LeaveRoomRet"] = {
	--房间id 离开的玩家 创建限制时间(没有为 0 or nil) 
	{ "int", "long",    "uint",              },
	{ "id",  "uid",     "createLimitTime",   },
}
GameMsg.map["TeamBoss:CountDown"] = {
	--房间id 倒计时完成时间 
	{ "int", "uint",        },
	{ "id",  "time",        },
}
GameMsg.map["TeamBoss:TimeOutClose"] = {
	--房间id 
	{ "int", },
	{ "id",  },
}
GameMsg.map["sNewTowerAssitInfo"] = {
	--章节id 锁定的卡牌          
	{ "uint","struts|sAssitInfo",},
	{ "sid", "new_tower_assit",  },
}
GameMsg.map["PlayerProto:ChangePlrName"] = {
	--名字     使用的物品 
	{ "string","uint",    },
	{ "name",  "item_id", },
}
GameMsg.map["PlayerProto:ChangePlrNameRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:ChangePlrShpae"] = {
	--使用的物品 全局表g_SexInitCardIds的下标 生日月  生日天 选择的台词id 
	{ "uint",    "byte",              "byte", "byte","uint",      },
	{ "item_id", "index",             "month","day", "use_vid",   },
}
GameMsg.map["PlayerProto:ChangePlrShpaeRet"] = {
	--                    头像模型  看板id     最后设置的角色看板ID 
	{ "uint","array|uint","uint",   "uint",    "uint",              },
	{ "cid", "ocfgid",    "icon_id","panel_id","role_panel_id",     },
}
GameMsg.map["PlayerProto:CheckReturningPlr"] = {
	--回归类型 离开天数 触发回归时间戳 各个活动开启时间     
	{ "uint",  "uint",  "uint",        "list|sReturningTime",},
	{ "type",  "leave", "time",        "activity_times",    },
}
GameMsg.map["PlayerProto:ClickBoard"] = {
	--
	{ },
	{ },
}
GameMsg.map["sNewTowerAssitCard"] = {
	--章节id 助战卡牌           
	{ "uint","struts|sCardInfo",},
	{ "sid", "assit_card_info", },
}
GameMsg.map["PlayerProto:NewTowerAssitCardRet"] = {
	--新爬塔助战卡牌       
	{ "list|sNewTowerAssitCard",},
	{ "assit_card_infos",  },
}
GameMsg.map["PlayerProto:GetSpecialDropsInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetSpecialDropsInfoRet"] = {
	--掉落了数量         
	{ "list|sStrNumInfo",},
	{ "dropInfos",       },
}
GameMsg.map["PlayerProto:SetBackground"] = {
	--背景ID          
	{ "uint",         },
	{ "background_id",},
}
GameMsg.map["PlayerProto:SetBackgroundRet"] = {
	--背景ID          
	{ "uint",         },
	{ "background_id",},
}
GameMsg.map["PlayerProto:GetStarPalaceInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetStarPalaceInfoRet"] = {
	--副本信息             是否需要重置数据 结束时间   怪物血量  开放副本id 
	{ "list|sStarPalaceInfo","bool",          "uint",    "uint",   "uint",    },
	{ "infos",             "isReset",       "stopTime","boss_hp","dupId",   },
}
GameMsg.map["PlayerProto:DeathCardInfos"] = {
	--不可使用的卡牌  不可使用的好友卡牌 
	{ "list|sNumInfo","list|sNumInfo",   },
	{ "cards",        "f_cards",         },
}
GameMsg.map["PlayerProto:GiveUpStarPalaceChallenge"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetStarRank"] = {
	--第几页  排行榜类型（章节id） 
	{ "int",  "int",               },
	{ "nPage","rank_type",         },
}
GameMsg.map["sStarRank"] = {
	--排名   当前积分  名字    等级    头像      通关的最大副本id 头像框       性别序号      玩家称号     回合数     
	{ "int", "string","string","short","int",    "int",           "int",       "byte",       "uint",      "uint",    },
	{ "rank","score", "name",  "level","icon_id","dupId",         "icon_frame","sel_card_ix","icon_title","turn_num",},
}
GameMsg.map["PlayerProto:GetStarRankRet"] = {
	--排名数据         我的排名 排行榜类型（章节id） 当前积分 
	{ "list|sStarRank","int",   "int",               "int",   },
	{ "data",          "rank",  "rank_type",         "score", },
}
GameMsg.map["PlayerProto:GetColletData"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetColletDataRet"] = {
	--当前累充金额 已领取的     
	{ "int",       "array|uint",},
	{ "score",     "data",      },
}
GameMsg.map["PlayerProto:TakeColletReward"] = {
	--表的id 
	{ "int", },
	{ "id",  },
}
GameMsg.map["PlayerProto:TakeColletRewardRet"] = {
	--表的id 
	{ "int", },
	{ "id",  },
}
GameMsg.map["sNewPanel"] = {
	--位置   看板ids      细节      细节      背景ID 所属看板类型 
	{ "uint","array|uint","json",   "json",   "uint","uint",      },
	{ "idx", "ids",       "detail1","detail2","bg",  "ty",        },
}
GameMsg.map["PlayerProto:GetNewPanel"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:SetNewPanel"] = {
	--看板信息            设置      是否随机 当前使用 
	{ "map|sNewPanel|idx","uint",   "uint",  "uint",  },
	{ "panels",           "setting","random","using", },
}
GameMsg.map["PlayerProto:GetNewPanelRet"] = {
	--看板信息            轮换设置  是否随机 当前使用 最后更新时间  当前随机看板类型 当前随机看板信息   
	{ "map|sNewPanel|idx","uint",   "uint",  "uint",  "uint",       "uint",          "struts|sNewPanel",},
	{ "panels",           "setting","random","using", "update_time","random_type",   "random_panel",    },
}
GameMsg.map["PlayerProto:GetRandomPanelRet"] = {
	--随机看板信息        随机看板自增下标 预设队伍名称列表     是否发送完成 
	{ "map|sNewPanel|idx","uint",          "list|sPairStringInt","bool",      },
	{ "random_panels",    "random_idx",    "name_list",         "finish",    },
}
GameMsg.map["PlayerProto:SetNewPanelUsing"] = {
	--使用看板位置 
	{ "uint",      },
	{ "using",     },
}
GameMsg.map["PlayerProto:SetNewPanelUsingRet"] = {
	--当前使用 最后更新时间  当前看板信息       
	{ "uint",  "uint",       "struts|sNewPanel",},
	{ "using", "update_time","random_panel",    },
}
GameMsg.map["PlayerProto:SetRandomPanel"] = {
	--随机看板信息       
	{ "struts|sNewPanel",},
	{ "random_panel",    },
}
GameMsg.map["PlayerProto:SetRandomPanelRet"] = {
	--随机看板信息       随机看板自增下标 
	{ "struts|sNewPanel","uint",          },
	{ "random_panel",    "random_idx",    },
}
GameMsg.map["PlayerProto:GetRandomPanelDetail"] = {
	--随机看板下标 
	{ "uint",      },
	{ "idx",       },
}
GameMsg.map["PlayerProto:GetRandomPanelDetailRet"] = {
	--随机看板自增下标 随机看板信息       
	{ "uint",          "struts|sNewPanel",},
	{ "idx",           "random_panel",    },
}
GameMsg.map["PlayerProto:SetPanelRandomType"] = {
	--当前随机看板预设队伍ID 
	{ "uint",              },
	{ "random_type",       },
}
GameMsg.map["PlayerProto:SetPanelRandomTypeRet"] = {
	--当前随机看板预设队伍ID 
	{ "uint",              },
	{ "random_type",       },
}
GameMsg.map["PlayerProto:RemoveRandomPanel"] = {
	--随机看板下标 
	{ "uint",      },
	{ "idx",       },
}
GameMsg.map["PlayerProto:RemoveRandomPanelRet"] = {
	--随机看板下标 
	{ "uint",      },
	{ "idx",       },
}
GameMsg.map["PlayerProto:AddRandomSkinsAll"] = {
	--皮肤列表ID   随机看板预设队伍ID 
	{ "array|uint","uint",            },
	{ "ids",       "random_type",     },
}
GameMsg.map["PlayerProto:AddRandomSkinsAllRet"] = {
	--皮肤列表         随机看板预设队伍ID 随机看板自增下标 是否发送完成 
	{ "list|sNewPanel","uint",            "uint",          "bool",      },
	{ "panels",        "random_type",     "random_idx",    "finish",    },
}
GameMsg.map["PlayerProto:SetRandomPanelName"] = {
	--随机看板预设队伍ID 预设队伍名字 
	{ "uint",            "string",    },
	{ "random_type",     "name",      },
}
GameMsg.map["PlayerProto:SetRandomPanelNameRet"] = {
	--所有预设队伍名称列表 
	{ "list|sPairStringInt",},
	{ "name_list",         },
}
GameMsg.map["PlayerProto:RandomPanelClean"] = {
	--随机看板预设队伍ID 要保留的看板下标 
	{ "uint",            "uint",          },
	{ "random_type",     "idx",           },
}
GameMsg.map["PlayerProto:RandomPanelCleanRet"] = {
	--随机看板预设队伍ID 要保留的看板下标 
	{ "uint",            "uint",          },
	{ "random_type",     "idx",           },
}
GameMsg.map["sStarPalaceInfo"] = {
	--章节id    当前排名 当前章节的子副本数据 下次刷新时间        
	{ "uint",   "uint",  "list|sStarDupInfo", "int",              },
	{ "groupId","ranks", "starDupInfos",      "next_refresh_time",},
}
GameMsg.map["sStarDupInfo"] = {
	--当前积分 副本id  历史最高积分        
	{ "uint",  "uint", "int",              },
	{ "score", "dupId","history_max_score",},
}
GameMsg.map["sReturningTime"] = {
	--活动id 活动类型 开启时间     结束时间   
	{ "uint","uint",  "uint",      "uint",    },
	{ "id",  "ty",    "start_time","end_time",},
}
GameMsg.map["PlayerProto:GetOpenConditionTime"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetOpenConditionTimeRet"] = {
	--数据                 
	{ "list|sPairStringInt",},
	{ "times",             },
}
GameMsg.map["PlayerProto:GetRank"] = {
	--第几页  排行榜类型（eRankType） 
	{ "int",  "int",               },
	{ "nPage","rank_type",         },
}
GameMsg.map["PlayerProto:GetRankRet"] = {
	--排名数据         我的排名 排行榜类型（章节id） 当前积分 下次刷新时间        回合数     排行榜奖励数据 我的预估排名 
	{ "list|sStarRank","int",   "int",               "string","int",              "uint",    "json",        "string",    },
	{ "data",          "rank",  "rank_type",         "score", "next_refresh_time","turn_num","reward_issue","erank",     },
}
GameMsg.map["PlayerProto:GetAllMusic"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetAllMusicRet"] = {
	--拥有的音乐数据 是否发完    
	{ "array|uint",  "bool",     },
	{ "data",        "is_finish",},
}
GameMsg.map["PlayerProto:NotifyDupDrop"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:PayFinishOrderId"] = {
	--游戏订单id    中台订单id         
	{ "string",     "string",          },
	{ "gameOrderId","centerWebOrderId",},
}
GameMsg.map["PlayerProto:Setting"] = {
	--R5锁定状态    
	{ "bool",       },
	{ "equip_state",},
}
GameMsg.map["PlayerProto:SettingRet"] = {
	--设置状态 
	{ "bool",  },
	{ "res",   },
}
GameMsg.map["PlayerProto:GetRankTeamInfo"] = {
	--排行榜类型(eRankType) 第几名    
	{ "int",               "int",    },
	{ "rankType",          "rankIdx",},
}
GameMsg.map["PlayerProto:GetRankTeamInfoRet"] = {
	--排行榜类型(eRankType) 第几名    队伍数据        选择词条(积分战斗用） 支援技能（连锁战线用） 关卡id（连锁战线用） 
	{ "int",               "int",    "list|TeamItem","array|uint",        "array|uint",         "array|uint",        },
	{ "rankType",          "rankIdx","data",         "buffIds",           "assistSkillList",    "dupList",           },
}
GameMsg.map["PlayerProto:CopyRankTeam"] = {
	--排行榜类型(eRankType) 第几名    
	{ "int",               "int",    },
	{ "rankType",          "rankIdx",},
}
GameMsg.map["PlayerProto:SetIconTitle"] = {
	--玩家称号ID   
	{ "uint",      },
	{ "icon_title",},
}
GameMsg.map["PlayerProto:SetIconTitleRet"] = {
	--玩家称号ID   
	{ "uint",      },
	{ "icon_title",},
}
GameMsg.map["PlayerProto:ClearDuplicateRet"] = {
	--关卡id       
	{ "array|uint",},
	{ "dupIds",    },
}
GameMsg.map["PlayerProto:GetColletDataByType"] = {
	--活动类型（eCollectType） 
	{ "uint",              },
	{ "type",              },
}
GameMsg.map["PlayerProto:GetColletDataByTypeRet"] = {
	--活动类型（eCollectType） 开始时间(0则还没开启) 结束时间（-1或者nil，无限开） 当前累充金额 已领取的     
	{ "uint",              "int",               "int",               "int",       "array|uint",},
	{ "type",              "openTime",          "closeTime",         "score",     "data",      },
}
GameMsg.map["PlayerProto:TakeColletRewardByType"] = {
	--活动类型（eCollectType） 表的id 
	{ "uint",              "int", },
	{ "type",              "id",  },
}
GameMsg.map["PlayerProto:TakeColletRewardByTypeRet"] = {
	--活动类型（eCollectType） 表的id 
	{ "uint",              "int", },
	{ "type",              "id",  },
}
GameMsg.map["PlayerProto:ClearRank"] = {
	--排行榜类型（eRankType） 
	{ "int",               },
	{ "rank_type",         },
}
GameMsg.map["PlayerProto:GetMineRankInfo"] = {
	--排行榜类型（eRankType） 
	{ "int",               },
	{ "rank_type",         },
}
GameMsg.map["PlayerProto:GetMineRankInfoRet"] = {
	--排行榜类型（eRankType） 当前积分 当前排名 下次刷新时间        回合数     
	{ "int",               "uint",  "uint",  "int",              "uint",    },
	{ "rank_type",         "score", "rank",  "next_refresh_time","turn_num",},
}
GameMsg.map["PlayerProto:ConverItem"] = {
	--物品id 多过期时间，选择使用的下标 使用数量 
	{ "uint","short",              "uint",  },
	{ "id",  "ix",                 "cnt",   },
}
GameMsg.map["PlayerProto:ConverItemRet"] = {
	--物品id 多过期时间，选择使用的下标 使用数量 
	{ "uint","short",              "uint",  },
	{ "id",  "ix",                 "cnt",   },
}
GameMsg.map["sLimitedTimeSkins"] = {
	--皮肤   到期时间 是否新增 获取时间 
	{ "uint","uint",  "bool",  "uint",  },
	{ "id",  "t",     "is_add","nTime", },
}
GameMsg.map["PlayerProto:SkinExpired"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:SkinExpiredRet"] = {
	--过期的皮肤ID 
	{ "array|uint",},
	{ "ids",       },
}
GameMsg.map["PlayerProto:SetIconEmote"] = {
	--表情id        
	{ "array|uint", },
	{ "icon_emotes",},
}
GameMsg.map["PlayerProto:SetIconEmoteRet"] = {
	--表情id        
	{ "array|uint", },
	{ "icon_emotes",},
}
GameMsg.map["sSelfChoiceCards"] = {
	--卡池ID 目前设置的五个概率up角色 首次设置的两个角色（1是六星，2是五星) 
	{ "uint","array|uint",         "array|uint",        },
	{ "id",  "cids",               "firstCids",         },
}
GameMsg.map["PlayerProto:SetSelfChoiceCardPoolCard"] = {
	--卡池id 本次设置的五个概率up角色 
	{ "uint","array|uint",         },
	{ "id",  "cids",               },
}
GameMsg.map["PlayerProto:SetSelfChoiceCardPoolCardRet"] = {
	--卡池id 本次设置的五个概率up角色 首次设置的两个角色（1是六星，2是五星) 
	{ "uint","array|uint",         "array|uint",        },
	{ "id",  "cids",               "firstCids",         },
}
GameMsg.map["PlayerProto:ChangePlrNameAndSex"] = {
	--使用的物品 改名字(不改不发) 全局表g_SexInitCardIds的下标(改性别，不改不发) 生日月  生日天 选择的台词id 
	{ "uint",    "string",        "byte",              "byte", "byte","uint",      },
	{ "item_id", "name",          "index",             "month","day", "use_vid",   },
}
GameMsg.map["PlayerProto:ChangePlrNameAndSexRet"] = {
	--                   
	{ "bool",   "bool",  },
	{ "name_ok","sex_ok",},
}
GameMsg.map["PlayerProto:GetBuffBattleInfo"] = {
	--章节id 
	{ "int", },
	{ "sid", },
}
GameMsg.map["PlayerProto:GetBuffBattleInfoRet"] = {
	--历史最高分 累计分数      
	{ "int",     "int",        },
	{ "score",   "total_score",},
}
GameMsg.map["PlayerProto:UseItemList"] = {
	--                    
	{ "list|sUseIteminfo",},
	{ "infos",            },
}
GameMsg.map["PlayerProto:UseItemListRet"] = {
	--                    获得的物品      是否需要前端合并 
	{ "list|sUseIteminfo","list|sNumInfo","bool",          },
	{ "infos",            "gets",         "isMerge",       },
}
GameMsg.map["PlayerProto:UpgradeWeaponLv"] = {
	--卡牌id 
	{ "uint",},
	{ "cid", },
}
GameMsg.map["PlayerProto:UpgradeWeaponLvRet"] = {
	--卡牌id 升级后等级 
	{ "uint","uint",    },
	{ "cid", "weaponLv",},
}
GameMsg.map["PlayerProto:ResetEternalBattleCardInfo"] = {
	--章节id 
	{ "uint",},
	{ "sid", },
}
GameMsg.map["PlayerProto:GetEternalBattleCardInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetEternalBattleInfoRet"] = {
	--章节id 角色的hp和sp     助战卡牌           是否最后一条 
	{ "uint","list|sCardInfo","struts|sCardInfo","bool",      },
	{ "sid", "card_infos",    "assit_card_info", "is_finish", },
}
GameMsg.map["PlayerProto:EternalBattleAssitCardRet"] = {
	--永镜战域助战卡牌     
	{ "list|sNewTowerAssitCard",},
	{ "assit_card_infos",  },
}
GameMsg.map["PlayerProto:GetSkinPassData"] = {
	--
	{ },
	{ },
}
GameMsg.map["sSkinPassData"] = {
	--通行证id 通行证等级 通行证经验值 已经领取的下标     是否已经开通 
	{ "uint",  "uint",    "uint",      "map|sIntArray|id","uint",      },
	{ "id",    "lv",      "exp",       "gets",            "isopen",    },
}
GameMsg.map["PlayerProto:GetSkinPassDataRet"] = {
	--通行证数据           
	{ "list|sSkinPassData",},
	{ "data",              },
}
GameMsg.map["PlayerProto:SkinPassGetReward"] = {
	--通行证id 领取下标(-1:全部领取) 
	{ "uint",  "int",               },
	{ "id",    "idx",               },
}
GameMsg.map["PlayerProto:SkinPassGetRewardRet"] = {
	--通行证id 已经领取的下标     
	{ "uint",  "map|sIntArray|id",},
	{ "id",    "gets",            },
}
GameMsg.map["PlayerProto:EnterSkinPassFight"] = {
	--通行证id 下标   关卡id  
	{ "uint",  "uint","uint", },
	{ "id",    "idx", "dupId",},
}
GameMsg.map["PlayerProto:SkinPassUpgrade"] = {
	--通行证id 提升到多少级 
	{ "uint",  "uint",      },
	{ "id",    "lv",        },
}
GameMsg.map["PlayerProto:SkinPassUpgradeRet"] = {
	--通行证id 升级后等级 
	{ "uint",  "uint",    },
	{ "id",    "lv",      },
}
GameMsg.map["PlayerProto:MainUIChangeTheme"] = {
	--主题id    
	{ "uint",   },
	{ "themeId",},
}
GameMsg.map["PlayerProto:MainUIThemeDataRet"] = {
	--当前主题id   
	{ "uint",      },
	{ "curThemeId",},
}
GameMsg.map["sOneKeyMainTalentUpgradeInfo"] = {
	--卡牌id 技能id     
	{ "uint","uint",    },
	{ "cid", "skill_id",},
}
GameMsg.map["PlayerProto:OneKeyMainTalentUpgrade"] = {
	--                     
	{ "list|sOneKeyMainTalentUpgradeInfo",},
	{ "infoArr",           },
}
GameMsg.map["PlayerProto:OneKeyMainTalentUpgradeRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:SetIconCard"] = {
	--名片ID      
	{ "uint",     },
	{ "icon_card",},
}
GameMsg.map["PlayerProto:SetIconCardRet"] = {
	--名片ID      
	{ "uint",     },
	{ "icon_card",},
}
GameMsg.map["PlayerProto:SetProfileBackground"] = {
	--个人信息背景图       
	{ "struts|sNewPanel",  },
	{ "profile_background",},
}
GameMsg.map["PlayerProto:SetProfileBackgroundRet"] = {
	--个人信息背景图       
	{ "struts|sNewPanel",  },
	{ "profile_background",},
}
GameMsg.map["PlayerProto:GetPlrOnlineTime"] = {
	--
	{ },
	{ },
}
GameMsg.map["PlayerProto:GetPlrOnlineTimeRet"] = {
	--当天在线时长（3点重置，单位：秒） 
	{ "uint",              },
	{ "tody_online",       },
}
GameMsg.map["PlayerProto:GetSectionTaskReward"] = {
	--章节id列表   
	{ "array|uint",},
	{ "ids",       },
}
GameMsg.map["sChat"] = {
	--发送者id 接受信息的玩家 头像id   名称     发送时间 消息类型 消息内容  文本提示表CfgTipsSimpleChinese的id 错误参数(map的sTipsInfo) 
	{ "long",  "array|long",  "uint",  "string","uint",  "byte",  "string", "string",            "json",              },
	{ "uid",   "uids",        "iconId","name",  "sTime", "type",  "content","strId",             "args",              },
}
GameMsg.map["ChatProto:GetInfo"] = {
	--消息类型 
	{ "byte",  },
	{ "type",  },
}
GameMsg.map["ChatProto:GetInfoRet"] = {
	--             
	{ "list|sChat",},
	{ "infos",     },
}
GameMsg.map["ChatProto:SendMsg"] = {
	--               
	{ "struts|sChat",},
	{ "info",        },
}
GameMsg.map["ChatProto:SendMsgRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["ChatProto:RecvMsg"] = {
	--             
	{ "list|sChat",},
	{ "infos",     },
}
GameMsg.map["RegressionProto:GetInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["RegressionProto:GetInfoRet"] = {
	--资源找回是否已领取 
	{ "int",             },
	{ "resourcesIsGain", },
}
GameMsg.map["RegressionProto:ResourcesRecoveryGain"] = {
	--
	{ },
	{ },
}
GameMsg.map["RegressionProto:ResourcesRecoveryGainRet"] = {
	--资源找回是否已领取 
	{ "int",             },
	{ "resourcesIsGain", },
}
GameMsg.map["sItemPool"] = {
	--道具池ID 轮次    开始时间    已拿走奖励 已抽取次数  
	{ "uint",  "uint", "uint",     "json",    "uint",     },
	{ "id",    "round","startTime","drawArr", "drawTimes",},
}
GameMsg.map["RegressionProto:ItemPoolInfo"] = {
	--道具池ID 是否进入下一轮 
	{ "uint",  "bool",        },
	{ "id",    "nextRound",   },
}
GameMsg.map["RegressionProto:ItemPoolInfoRet"] = {
	--道具池信息       
	{ "list|sItemPool",},
	{ "info",          },
}
GameMsg.map["RegressionProto:ItemPoolDraw"] = {
	--道具池ID 抽取次数 
	{ "uint",  "uint",  },
	{ "id",    "times", },
}
GameMsg.map["RegressionProto:ItemPoolDrawRet"] = {
	--道具池信息         本次抽取奖励 抽取时的轮次 
	{ "struts|sItemPool","array|uint","uint",      },
	{ "info",            "drawArr",   "drawRound", },
}
GameMsg.map["RegressionProto:PlrBindInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["RegressionProto:PlrBindInfoRet"] = {
	--当前绑定活动id 邀请码[ 玩家类型_UID ] 绑定的其他玩家 绑定任务领取累计 申请次数   申请次数重置时间 当前阶段 任务完成总数  
	{ "uint",        "string",            "json",        "json",          "uint",    "uint",          "uint",  "uint",       },
	{ "activeId",    "code",              "plrs",        "taskGets",      "applyCnt","applyResetTime","stage", "doneTaskNum",},
}
GameMsg.map["RegressionProto:PlrBindInvite"] = {
	--邀请码          
	{ "string","uint",},
	{ "code",  "uid", },
}
GameMsg.map["RegressionProto:PlrBindInviteRet"] = {
	--是否邀请成功 被邀请人uid 
	{ "bool",      "uint",     },
	{ "isOk",      "beInviter",},
}
GameMsg.map["RegressionProto:PlrBindBeInvite"] = {
	--邀请人uid 
	{ "uint",   },
	{ "inviter",},
}
GameMsg.map["RegressionProto:PlrBindBeInviteRet"] = {
	--是否接受 邀请人uid 
	{ "bool",  "uint",   },
	{ "isOk",  "inviter",},
}
GameMsg.map["RegressionProto:PlrBindInviteResult"] = {
	--是否接受 被邀请人uid 
	{ "bool",  "uint",     },
	{ "isOk",  "beInviter",},
}
GameMsg.map["RegressionProto:PlrBindInviteList"] = {
	--页面值0开始 
	{ "uint",     },
	{ "page",     },
}
GameMsg.map["RegressionProto:PlrBindInviteListRet"] = {
	--页面值0开始 g_PlrBindListOnceCnt 配置返回数量         
	{ "uint",     "list|sFriendInfo",  "bool", },
	{ "page",     "friends",           "isEnd",},
}
GameMsg.map["RegressionProto:PlrBindRecoment"] = {
	--页面值0开始 
	{ "uint",     },
	{ "page",     },
}
GameMsg.map["RegressionProto:PlrBindRecomentRet"] = {
	--页面值0开始 g_PlrBindListOnceCnt 配置返回数量         
	{ "uint",     "list|sFriendInfo",  "bool", },
	{ "page",     "friends",           "isEnd",},
}
GameMsg.map["RegressionProto:PlrBindGainReward"] = {
	--
	{ },
	{ },
}
GameMsg.map["RegressionProto:PlrBindGainRewardRet"] = {
	--阶段    任务完成总数  
	{ "uint", "uint",       },
	{ "stage","doneTaskNum",},
}
GameMsg.map["RegressionProto:PlrBindBeInviteRetNotice"] = {
	--是否接受 邀请人uid 操作成功  
	{ "bool",  "uint",   "bool",   },
	{ "isOk",  "inviter","success",},
}
GameMsg.map["RegressionProto:PlrBindStageTaskInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["RegressionProto:PlrBindStageTaskInfoRet"] = {
	--当前阶段 任务完成总数  
	{ "uint",  "uint",       },
	{ "stage", "doneTaskNum",},
}
GameMsg.map["RegressionProto:PlrFundInfo"] = {
	--有效期（0或者过去的时间都是未购买基金） 
	{ "uint",              },
	{ "validity",          },
}
GameMsg.map["sResupply"] = {
	--活动ID 今日领取数组 
	{ "uint","array|uint",},
	{ "id",  "gainArr",   },
}
GameMsg.map["RegressionProto:ResupplyInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["RegressionProto:ResupplyInfoRet"] = {
	--燃料补给信息     
	{ "list|sResupply",},
	{ "info",          },
}
GameMsg.map["RegressionProto:ResupplyGain"] = {
	--活动ID 领取下标 
	{ "uint","uint",  },
	{ "id",  "idx",   },
}
GameMsg.map["RegressionProto:ActiveRewardsInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["RegressionProto:ActiveRewardsInfoRet"] = {
	--已购买方案下标 登录天数   已领取奖励下标 
	{ "uint",        "uint",    "array|uint",  },
	{ "idx",         "loginDay","gainArr",     },
}
GameMsg.map["RegressionProto:ActiveRewardsGain"] = {
	--奖励下标 
	{ "uint",  },
	{ "idx",   },
}
GameMsg.map["AchievementProto:GetFinishInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["AchievementProto:GetFinishInfoRet"] = {
	--成就条件的进度（CfgAchieveFinishVal的id，完成的次数） 是否最后一条 
	{ "list|sStrNumInfo",  "bool",      },
	{ "finish_list",       "is_finish", },
}
GameMsg.map["AchievementProto:GetRewardInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["AchievementProto:GetRewardInfoRet"] = {
	--领取的奖励返回       是否最后一条 
	{ "list|sAchievementRewardDetail","bool",      },
	{ "infos",             "is_finish", },
}
GameMsg.map["AchievementProto:GetReward"] = {
	--领取成就的id（CfgAchieve的id） 
	{ "int",               },
	{ "id",                },
}
GameMsg.map["AchievementProto:GetRewardRet"] = {
	--奖励返回             领取的奖励     
	{ "struts|sAchievementRewardDetail","list|sReward",},
	{ "achievementReward", "gets",        },
}
GameMsg.map["AchievementProto:GetAllReward"] = {
	--
	{ },
	{ },
}
GameMsg.map["AchievementProto:GetAllRewardRet"] = {
	--奖励返回             领取的奖励     
	{ "list|sAchievementRewardDetail","list|sReward",},
	{ "achievementRewards","gets",        },
}
GameMsg.map["sAchievementRewardDetail"] = {
	--成就id（CfgAchieve的id） 领取时间 完成时间      
	{ "uint",              "uint",  "uint",       },
	{ "id",                "time",  "finish_time",},
}
GameMsg.map["AchievementProto:UpdateFinishInfoRet"] = {
	--成就条件的进度（CfgAchieveFinishVal的id，完成的次数） 是否最后一条 
	{ "list|sStrNumInfo",  "bool",      },
	{ "finish_list",       "is_finish", },
}
GameMsg.map["BadgedProto:GetBadgedInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["BadgedProto:GetBadgedInfoRet"] = {
	--领取的奖励返回 是否最后一条 
	{ "list|sBadged","bool",      },
	{ "infos",       "is_finish", },
}
GameMsg.map["sBadged"] = {
	--徽章id 完成时间      是否需要new标识 
	{ "uint","uint",       "bool",         },
	{ "id",  "finish_time","is_new",       },
}
GameMsg.map["BadgedProto:UpdateBadged"] = {
	--徽章id       
	{ "array|uint",},
	{ "ids",       },
}
GameMsg.map["BadgedProto:GetSortBadgedInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["BadgedProto:GetSortBadgedInfoRet"] = {
	--徽章的位置         
	{ "list|sStrNumInfo",},
	{ "pos",             },
}
GameMsg.map["BadgedProto:UpdateSortBadged"] = {
	--徽章的位置         
	{ "list|sStrNumInfo",},
	{ "pos",             },
}
GameMsg.map["ZiLongProto:GetGuestBinding"] = {
	--设置了这个不领取，只返回能否领取 
	{ "bool",               },
	{ "isTry",              },
}
GameMsg.map["ZiLongProto:GetGuestBindingRet"] = {
	--设置了这个不领取，只返回能否领取 是否有奖励能领取 奖励            
	{ "bool",               "bool",          "list|sNumInfo",},
	{ "isTry",              "isHadReward",   "rewards",      },
}
GameMsg.map["sPet"] = {
	--宠物id 养成值 养成值奖励下标 清洁度 心情值  饱腹值 属性最近变更时间 当前运动 运动场景 运动持续时间 当前运动开始时间 
	{ "uint","uint","uint",        "uint","uint", "uint","uint",          "uint",  "uint",  "uint",      "uint",          },
	{ "id",  "feed","idx",         "wash","happy","food","last_time",     "sport", "scene", "keep_time", "start_time",    },
}
GameMsg.map["SummerProto:PetInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["SummerProto:PetInfoRet"] = {
	--宠物信息    当前宠物  已获取图鉴   已领取图鉴奖励 下次随机礼物奖励时间戳 当前是否有随机奖励 
	{ "list|sPet","uint",   "array|uint","array|uint",  "uint",               "bool",            },
	{ "info",     "cur_pet","locked",    "gained",      "tNextRandom",        "haveReward",      },
}
GameMsg.map["SummerProto:PetUpdate"] = {
	--宠物id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["SummerProto:PetPush"] = {
	--宠物信息      下次随机礼物奖励时间戳 
	{ "struts|sPet","uint",               },
	{ "info",       "tNextRandom",        },
}
GameMsg.map["SummerProto:PetSport"] = {
	--类型   运动时长 选择场景 
	{ "uint","uint",  "uint",  },
	{ "ty",  "time",  "scene", },
}
GameMsg.map["SummerProto:PetSportRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["SummerProto:PetSwitch"] = {
	--宠物id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["SummerProto:PetSwitchRet"] = {
	--当前宠物  下次随机礼物奖励时间戳 
	{ "uint",   "uint",               },
	{ "cur_pet","tNextRandom",        },
}
GameMsg.map["SummerProto:PetGainReward"] = {
	--
	{ },
	{ },
}
GameMsg.map["SummerProto:PetGainRewardRet"] = {
	--养成值奖励下标 获取奖励列表   
	{ "uint",        "list|sReward",},
	{ "idx",         "rewards",     },
}
GameMsg.map["SummerProto:GainRandomGift"] = {
	--
	{ },
	{ },
}
GameMsg.map["SummerProto:GainRandomGiftRet"] = {
	--下次随机礼物奖励时间戳 获取奖励列表   
	{ "uint",               "list|sReward",},
	{ "tNextRandom",        "rewards",     },
}
GameMsg.map["SummerProto:BestiaryPush"] = {
	--新解锁图鉴ID 
	{ "uint",      },
	{ "id",        },
}
GameMsg.map["SummerProto:GainBestiaryReward"] = {
	--图鉴表ID 
	{ "uint",  },
	{ "id",    },
}
GameMsg.map["SummerProto:GainBestiaryRewardRet"] = {
	--本次领取奖励ID 获取奖励列表   
	{ "uint",        "list|sReward",},
	{ "id",          "rewards",     },
}
GameMsg.map["OperateActiveProto:GetOperateActive"] = {
	--活动id（eOperateType） 
	{ "uint",               },
	{ "id",                 },
}
GameMsg.map["OperateActiveProto:GetOperateActiveRet"] = {
	--运营活动的数据       
	{ "list|sOperateActive",},
	{ "operateActiveList", },
}
GameMsg.map["sOperateActive"] = {
	--活动id（eOperateType） 开始时间   结束时间（-1或者nil，无限开） 充值金额（分） 弹窗id     开启状态(0未开，1已开） 
	{ "uint",               "int",     "int",               "int",         "int",     "int",               },
	{ "id",                 "openTime","closeTime",         "payRate",     "noticeId","state",             },
}
GameMsg.map["OperateActiveProto:GetActiveTimeList"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:GetActiveTimeListRet"] = {
	--运营活动的数据       是否发完   
	{ "list|sOperateActive","bool",    },
	{ "operateActiveList", "isFinish",},
}
GameMsg.map["OperateActiveProto:GetSkinRebateInfo"] = {
	--皮肤组id，不传发全部 
	{ "uint",              },
	{ "skinId",            },
}
GameMsg.map["OperateActiveProto:GetSkinRebateInfoRet"] = {
	--皮肤组开启数据   
	{ "list|sSkinInfo",},
	{ "skinIdList",    },
}
GameMsg.map["sSkinInfo"] = {
	--皮肤组id 结束时间   
	{ "uint",  "uint",    },
	{ "skinId","nEndTime",},
}
GameMsg.map["OperateActiveProto:DragonBoatFestivalRefuel"] = {
	--签到活动id(CfgSignReward.id) 加油类型eDragonBoatFestivalType 
	{ "int",               "int",               },
	{ "id",                "type",              },
}
GameMsg.map["OperateActiveProto:GetDragonBoatFestivalInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:GetDragonBoatFestivalInfoRet"] = {
	--端午签到数据    当天加油类型eDragonBoatFestivalType 第六天奖励是否领取，1已领取，0或nil 未领取 
	{ "list|sNumInfo","int",               "int",               },
	{ "infos",        "type",              "isTake",            },
}
GameMsg.map["OperateActiveProto:GetQuestionInfo"] = {
	--活动id（cfgQuestions.id） 
	{ "int",               },
	{ "id",                },
}
GameMsg.map["OperateActiveProto:GetQuestionInfoRet"] = {
	--活动id（cfgQuestions.id） 当前是开放的第几天 答对题目数量 已领取      获取题目列表         
	{ "int",               "int",             "int",       "array|int","list|sQuestionInfo",},
	{ "id",                "openTime",        "answerCnt", "reward",   "questionInfos",     },
}
GameMsg.map["OperateActiveProto:AnswerQuestion"] = {
	--活动id（cfgQuestions.id） sQuestionInfo.drawnQuestions 题目id sQuestionInfo.drawnAnswers的值 
	{ "int",               "int",               "int",               },
	{ "id",                "drawnQuestions",    "answerIndex",       },
}
GameMsg.map["OperateActiveProto:AnswerQuestionRet"] = {
	--活动id（cfgQuestions.id） sQuestionInfo.index 答题结果 获取奖励列表    sQuestionInfo.drawnQuestions 题目id sQuestionInfo.drawnAnswers的值 
	{ "int",               "int",              "bool",  "list|sNumInfo","int",               "int",               },
	{ "id",                "index",            "res",   "gets",         "drawnQuestions",    "answerIndex",       },
}
GameMsg.map["OperateActiveProto:TakeQuestionReward"] = {
	--活动id（cfgQuestions.id） cfgQuestionsReward.index 
	{ "int",               "int",               },
	{ "id",                "index",             },
}
GameMsg.map["OperateActiveProto:TakeQuestionRewardRet"] = {
	--答题结果 获取奖励列表    已领取      活动id（cfgQuestions.id） 
	{ "bool",  "list|sNumInfo","array|int","int",               },
	{ "res",   "gets",         "reward",   "id",                },
}
GameMsg.map["sQuestionInfo"] = {
	--题目id           答案           已回答      是否已领取 序号    当前题目是第几天开放的 
	{ "uint",          "array|int",   "array|int","uint",    "uint", "int",                },
	{ "drawnQuestions","drawnAnswers","answers",  "isTake",  "index","openTime",           },
}
GameMsg.map["OperateActiveProto:GetMaidCoffeeData"] = {
	--活动id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["OperateActiveProto:GetMaidCoffeeDataRet"] = {
	--活动id 奖励次数 剩余奖励次数 个人历史最高分 
	{ "uint","uint",  "uint",      "uint",        },
	{ "id",  "cnt",   "remainCnt", "maxScore",    },
}
GameMsg.map["OperateActiveProto:GetMaidCoffeeReward"] = {
	--活动id 获得积分 开始游戏时间 游戏总计时间 正确订单数量 错误订单数量 本次游戏结果（1正常结算，2为中途退出） 
	{ "uint","uint",  "int",       "int",       "uint",      "uint",      "uint",              },
	{ "id",  "score", "begTime",   "gameTime",  "rightNum",  "wrongNum",  "gameRet",           },
}
GameMsg.map["OperateActiveProto:GetMaidCoffeeRewardRet"] = {
	--活动id 奖励次数 剩余奖励次数 个人历史最高分 
	{ "uint","uint",  "uint",      "uint",        },
	{ "id",  "cnt",   "remainCnt", "maxScore",    },
}
GameMsg.map["OperateActiveProto:GetLimitRewardInfo"] = {
	--活动ID 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["OperateActiveProto:GetLimitRewardInfoRet"] = {
	--活动id 完成任务数    全服名额领取进度 是否弹过窗 第几名玩家 完成时间 当前第几阶段 
	{ "uint","uint",       "uint",          "bool",    "uint",    "uint",  "uint",      },
	{ "id",  "doneTaskNum","curQuota",      "isPopup", "quota",   "time",  "stage",     },
}
GameMsg.map["OperateActiveProto:LimitRewardCloseWindow"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:LimitRewardCloseWindowRet"] = {
	--是否弹过窗 
	{ "bool",    },
	{ "isPopup", },
}
GameMsg.map["OperateActiveProto:LimitRewardShowCode"] = {
	--物品id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["OperateActiveProto:LimitRewardShowCodeRet"] = {
	--活动id 第几名玩家 兑换码   物品ID   
	{ "uint","uint",    "string","uint",  },
	{ "id",  "quota",   "code",  "itemId",},
}
GameMsg.map["OperateActiveProto:GetPopupPackInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:GetPopupPackInfoRet"] = {
	--获取奖励列表         是否结束   
	{ "list|sPopupPackInfo","bool",    },
	{ "infos",             "isFinish",},
}
GameMsg.map["OperateActiveProto:UpdatePopupTime"] = {
	--礼包条件id  
	{ "array|int",},
	{ "cfgids",   },
}
GameMsg.map["OperateActiveProto:UpdatePopupTimeRet"] = {
	--礼包条件id  弹出时间（非nil 并且大于0 弹出过） 是否更新成功 
	{ "array|int","uint",               "bool",      },
	{ "cfgids",   "popupTime",          "res",       },
}
GameMsg.map["sPopupPackInfo"] = {
	--礼包条件id 礼包结束时间戳 弹出时间（非nil 并且大于0 弹出过） 
	{ "uint",    "uint",        "uint",               },
	{ "cfgid",   "finishTime",  "popupTime",          },
}
GameMsg.map["OperateActiveProto:GetHalloweenGameData"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:GetHalloweenGameDataRet"] = {
	--奖励次数 剩余奖励次数 个人历史最高分 
	{ "uint",  "uint",      "uint",        },
	{ "cnt",   "remainCnt", "maxScore",    },
}
GameMsg.map["OperateActiveProto:GetHalloweenGameReward"] = {
	--获得积分 开始游戏时间 游戏总计时间 积分糖果数量 骷髅糖果数量 时间糖果数量 本次游戏结果（1倒计时结束，2为血量扣完，3中途退出） 
	{ "uint",  "int",       "int",       "uint",      "uint",      "uint",      "uint",              },
	{ "score", "begTime",   "gameTime",  "rightNum",  "wrongNum",  "timeNum",   "gameRet",           },
}
GameMsg.map["OperateActiveProto:GetHalloweenGameRewardRet"] = {
	--奖励次数 剩余奖励次数 个人历史最高分 
	{ "uint",  "uint",      "uint",        },
	{ "cnt",   "remainCnt", "maxScore",    },
}
GameMsg.map["OperateActiveProto:GetChristmasGiftData"] = {
	--活动id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["OperateActiveProto:GetChristmasGiftDataRet"] = {
	--活动id 奖励次数 剩余奖励次数 个人历史最高分 
	{ "uint","uint",  "uint",      "uint",        },
	{ "id",  "cnt",   "remainCnt", "maxScore",    },
}
GameMsg.map["OperateActiveProto:GetChristmasGiftReward"] = {
	--活动id 获得积分 开始游戏时间 游戏总计时间 本次游戏结果（1正常结算，2为中途退出） 奖励时段次数 
	{ "uint","uint",  "int",       "int",       "uint",              "uint",      },
	{ "id",  "score", "begTime",   "gameTime",  "gameRet",           "gameBonus", },
}
GameMsg.map["OperateActiveProto:GetChristmasGiftRewardRet"] = {
	--活动id 奖励次数 剩余奖励次数 个人历史最高分 
	{ "uint","uint",  "uint",      "uint",        },
	{ "id",  "cnt",   "remainCnt", "maxScore",    },
}
GameMsg.map["sRichManGridReward"] = {
	--格子顺序 奖励           
	{ "uint",  "list|sReward",},
	{ "sort",  "rewards",     },
}
GameMsg.map["sRichManGridRewardInfo"] = {
	--格子模板id 格子奖励             
	{ "uint",    "list|sRichManGridReward",},
	{ "mapId",   "info",              },
}
GameMsg.map["OperateActiveProto:GetRichManData"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:GetRichManDataRet"] = {
	--配置id  当前所处格子序号 格子模板id 触发的事件  本圈已投掷次数（步数） 
	{ "uint", "uint",          "uint",    "array|int","uint",               },
	{ "cfgId","sort",          "mapId",   "eventList","throwCnt",           },
}
GameMsg.map["OperateActiveProto:RichManThrow"] = {
	--遥控点数（非遥控不发） 是否自动投掷 
	{ "uint",               "bool",      },
	{ "point",              "isAuto",    },
}
GameMsg.map["OperateActiveProto:RichManThrowRet"] = {
	--骰子点数 当前所处格子序号 格子模板id 触发的事件  本圈已投掷次数（步数） 奖励                 实际移动步数 是否是固定点数投掷 
	{ "uint",  "uint",          "uint",    "array|int","uint",               "list|sRichManGridRewardInfo","uint",      "bool",            },
	{ "point", "sort",          "mapId",   "eventList","throwCnt",           "rewards",           "stepCnt",   "isFixed",         },
}
GameMsg.map["OperateActiveProto:RichManStopAutoThrow"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:RichManStopAutoThrowRet"] = {
	--奖励           
	{ "list|sReward",},
	{ "rewards",     },
}
GameMsg.map["OperateActiveProto:NoticePhysicalReward"] = {
	--物品ID    奖励表ID 奖励下标 
	{ "uint",   "uint",  "uint",  },
	{ "item_id","id",    "index", },
}
GameMsg.map["OperateActiveProto:PhysicalRewardInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:PhysicalRewardInfoRet"] = {
	--各个奖励剩余数量 
	{ "array|uint",    },
	{ "nums",          },
}
GameMsg.map["OperateActiveProto:GetSkinDiscountInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:GetSkinDiscountInfoRet"] = {
	--每日奖励      已购买皮肤数量 
	{ "bool",       "array|uint",  },
	{ "dailyReward","nums",        },
}
GameMsg.map["OperateActiveProto:GetSkinDiscountDaily"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:GetSkinDiscountDailyRet"] = {
	--每日奖励      
	{ "bool",       },
	{ "dailyReward",},
}
GameMsg.map["sLittlePayActiveInfo"] = {
	--活动ID 开始时间    结束时间  进度数据 
	{ "uint","int",      "int",    "json",  },
	{ "id",  "startTime","endTime","data",  },
}
GameMsg.map["OperateActiveProto:LittlePayActiveDataRet"] = {
	--活动数据             
	{ "list|sLittlePayActiveInfo",},
	{ "data",              },
}
GameMsg.map["sBreakfastCardActiveInfo"] = {
	--活动ID 开始时间    结束时间  下个可购买的是第几天 
	{ "uint","int",      "int",    "int",               },
	{ "id",  "startTime","endTime","nextBuyDay",        },
}
GameMsg.map["OperateActiveProto:GetBreakfastCardData"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:BreakfastCardDataRet"] = {
	--活动列表             
	{ "list|sBreakfastCardActiveInfo",},
	{ "data",              },
}
GameMsg.map["sGoldenRebateInfo"] = {
	--活动id 开始时间    结束      今日已充值金额 累计充值天数 
	{ "uint","int",      "int",    "int",         "int",       },
	{ "id",  "startTime","endTime","chargeMoney", "chargeDay", },
}
GameMsg.map["OperateActiveProto:GoldenRebateDataRet"] = {
	--活动数据             
	{ "list|sGoldenRebateInfo",},
	{ "data",              },
}
GameMsg.map["sOldSkinRebateBuyInfo"] = {
	--商品Id        购买时间  购买时的价格 状态(0未领,1已领) 
	{ "uint",       "int",    "uint",      "uint",           },
	{ "commodityId","buyTime","buyMoney",  "state",          },
}
GameMsg.map["sOldSkinRebateInfo"] = {
	--是否已激活(0/1) 累计获得返利  
	{ "uint",         "uint",       },
	{ "isActive",     "totalRebate",},
}
GameMsg.map["OperateActiveProto:GetOldSkinRebateInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["OperateActiveProto:GetOldSkinRebateInfoRet"] = {
	--活动数据             购买记录列表         
	{ "struts|sOldSkinRebateInfo","list|sOldSkinRebateBuyInfo",},
	{ "info",              "buyInfos",          },
}
GameMsg.map["OperateActiveProto:GetOldSkinRebateReward"] = {
	--商品Id        
	{ "uint",       },
	{ "commodityId",},
}
GameMsg.map["LovePlusProto:GetChapterData"] = {
	--章节id      
	{ "uint",     },
	{ "chapterId",},
}
GameMsg.map["LovePlusProto:SaveChatData"] = {
	--章节id      聊天组id      聊天id       
	{ "uint",     "uint",       "array|uint",},
	{ "chapterId","chatGroupId","chatIds",   },
}
GameMsg.map["LovePlusProto:ChatDataRet"] = {
	--章节id      聊天组            
	{ "uint",     "list|sChatGroup",},
	{ "chapterId","chatGroupData",  },
}
GameMsg.map["LovePlusProto:GetNodeData"] = {
	--章节id      
	{ "uint",     },
	{ "chapterId",},
}
GameMsg.map["sSaveNode"] = {
	--节点id   剧情幕id     
	{ "uint",  "array|uint",},
	{ "nodeId","storyIds",  },
}
GameMsg.map["LovePlusProto:NodeDataRet"] = {
	--章节id      已完成节点   
	{ "uint",     "array|uint",},
	{ "chapterId","nodeIds",   },
}
GameMsg.map["LovePlusProto:FinishNode"] = {
	--节点信息           
	{ "struts|sNodeInfo",},
	{ "nodeInfo",        },
}
GameMsg.map["LovePlusProto:StartNode"] = {
	--章节id      节点id   
	{ "uint",     "uint",  },
	{ "chapterId","nodeId",},
}
GameMsg.map["LovePlusProto:StartNodeRet"] = {
	--章节id      节点id   
	{ "uint",     "uint",  },
	{ "chapterId","nodeId",},
}
GameMsg.map["LovePlusProto:SendUnlockItems"] = {
	--章节id      配图id       解锁数据             完成进度           是否显示红点 
	{ "uint",     "array|uint","struts|sUnlockData","uint",            "bool",      },
	{ "chapterId","imgIds",    "unlockData",        "completeProgress","isRed",     },
}
GameMsg.map["sChatGroup"] = {
	--聊天组id      聊天id       
	{ "uint",       "array|uint",},
	{ "chatGroupId","chatIds",   },
}
GameMsg.map["LovePlusProto:GetChapterSimpleInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["LovePlusProto:GetChapterSimpleInfoRet"] = {
	--章节信息            已解锁配图id 
	{ "list|sChapterInfo","array|uint",},
	{ "chapterInfo",      "imgIds",    },
}
GameMsg.map["sChapterInfo"] = {
	--章节id      完成进度           存档节点数据       解锁数据             已解锁购买商品id 是否显示红点 
	{ "uint",     "uint",            "struts|sSaveNode","struts|sUnlockData","array|uint",    "bool",      },
	{ "chapterId","completeProgress","saveNode",        "unlockData",        "shopItemIds",   "isRed",     },
}
GameMsg.map["LovePlusProto:GetChapterDataRet"] = {
	--章节id      
	{ "uint",     },
	{ "chapterId",},
}
GameMsg.map["LovePlusProto:DropOut"] = {
	--节点信息           
	{ "struts|sNodeInfo",},
	{ "nodeInfo",        },
}
GameMsg.map["LovePlusProto:SaveNode"] = {
	--节点信息           
	{ "struts|sNodeInfo",},
	{ "nodeInfo",        },
}
GameMsg.map["LovePlusProto:SaveNodeRet"] = {
	--节点信息           
	{ "struts|sNodeInfo",},
	{ "nodeInfo",        },
}
GameMsg.map["sNodeInfo"] = {
	--章节id      节点id   剧情幕id     
	{ "uint",     "uint",  "array|uint",},
	{ "chapterId","nodeId","storyIds",  },
}
GameMsg.map["sUnlockData"] = {
	--已解锁CGId   已解锁聊天组   已解锁节点   已解锁节点   
	{ "array|uint","array|uint",  "array|uint","array|uint",},
	{ "CGIds",     "chatGroupIds","nodeIds",   "labelIds",  },
}
GameMsg.map["sRandCard"] = {
	--卡牌id   装备信息      对应怪物id   
	{ "uint",  "list|sEquip","uint",      },
	{ "cardId","equips",     "monsterIdx",},
}
GameMsg.map["sScoreData"] = {
	--模式类型  总星数    最高回合 困难最高回合 
	{ "uint",   "uint",   "uint",  "uint",      },
	{ "modType","starNum","maxLv", "maxHardLv", },
}
GameMsg.map["sRandLevels"] = {
	--第几关 关卡id       已选关卡id 
	{ "uint","array|uint","uint",    },
	{ "idx", "dupIds",    "selectId",},
}
GameMsg.map["sSelectCard"] = {
	--待选卡牌组数据    已选卡牌数据     
	{ "list|sRandCard", "list|sRandCard",},
	{ "waitSelectCards","selectCards",   },
}
GameMsg.map["sRandModData"] = {
	--随机关卡数据       选卡数据             领奖状态 是否结束 
	{ "list|sRandLevels","struts|sSelectCard","bool",  "bool",  },
	{ "randLvs",         "selectCardData",    "isGet", "isOver",},
}
GameMsg.map["AbattoirProto:GetSeasonData"] = {
	--
	{ },
	{ },
}
GameMsg.map["AbattoirProto:GetSeasonDataRet"] = {
	--当前赛季id 开始时间    结束时间  结算时间     随机模式刷新时间  自选模式刷新时间    战绩数据          随机模式数据         随机模式是否已买门票 自选模式是否已买门票 免费次数  
	{ "uint",    "uint",     "uint",   "uint",      "uint",           "uint",             "list|sScoreData","struts|sRandModData","bool",              "bool",              "uint",   },
	{ "id",      "startTime","endTime","rewardTime","randRefreshTime","selectRefreshTime","scoreData",      "randModData",       "isRandPay",         "isSelectPay",       "freeCnt",},
}
GameMsg.map["AbattoirProto:StartMod"] = {
	--模式类型  门票类型 
	{ "uint",   "uint",  },
	{ "modType","tType", },
}
GameMsg.map["AbattoirProto:StartModRet"] = {
	--模式类型  门票类型 选卡数据             随机关卡数据       免费次数  
	{ "uint",   "uint",  "struts|sSelectCard","list|sRandLevels","uint",   },
	{ "modType","tType", "selectCardData",    "randLvs",         "freeCnt",},
}
GameMsg.map["AbattoirProto:SelectCard"] = {
	--选的第几张卡牌 
	{ "uint",        },
	{ "cardIdx",     },
}
GameMsg.map["AbattoirProto:SelectCardRet"] = {
	--选卡数据             选的第几张卡牌 
	{ "struts|sSelectCard","uint",        },
	{ "selectCardData",    "cardIdx",     },
}
GameMsg.map["AbattoirProto:SaveRoute"] = {
	--是否保存 
	{ "bool",  },
	{ "isSave",},
}
GameMsg.map["AbattoirProto:SaveRouteRet"] = {
	--是否保存 
	{ "bool",  },
	{ "isSave",},
}
GameMsg.map["AbattoirProto:RandModQuit"] = {
	--
	{ },
	{ },
}
GameMsg.map["AbattoirProto:RandModQuitRet"] = {
	--
	{ },
	{ },
}
GameMsg.map["AbattoirProto:RandModeGetRwd"] = {
	--
	{ },
	{ },
}
GameMsg.map["AbattoirProto:RandModeGetRwdRet"] = {
	--领奖状态 
	{ "bool",  },
	{ "isGet", },
}
GameMsg.map["ActivePuzzleProto:GetPuzzleData"] = {
	--活动id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["ActivePuzzleProto:GetPuzzleDataRet"] = {
	--活动id 已解锁格子    已领取奖励   
	{ "uint","array|uint", "array|uint",},
	{ "id",  "unlockGrids","getRwdIds", },
}
GameMsg.map["ActivePuzzleProto:DrawPuzzle"] = {
	--活动id 
	{ "uint",},
	{ "id",  },
}
GameMsg.map["ActivePuzzleProto:DrawPuzzleRet"] = {
	--活动id 奖励配置idx 
	{ "uint","uint",     },
	{ "id",  "idx",      },
}
GameMsg.map["ActivePuzzleProto:UnlockGrid"] = {
	--活动id 格子序号     
	{ "uint","array|uint",},
	{ "id",  "gridIdx",   },
}
GameMsg.map["ActivePuzzleProto:UnlockGridRet"] = {
	--活动id 已解锁格子    奖励           
	{ "uint","array|uint", "list|sReward",},
	{ "id",  "unlockGrids","gets",        },
}
GameMsg.map["ActivePuzzleProto:GetReward"] = {
	--活动id 奖励id  
	{ "uint","uint", },
	{ "id",  "rwdId",},
}
GameMsg.map["ActivePuzzleProto:GetRewardRet"] = {
	--活动id 已领取奖励   
	{ "uint","array|uint",},
	{ "id",  "getRwdIds", },
}
GameMsg.map["ActivePuzzleProto:BuyPuzzle"] = {
	--活动id 商品配置idx 购买消耗类型 
	{ "uint","uint",     "uint",      },
	{ "id",  "idx",      "costType",  },
}
GameMsg.map["ActivePuzzleProto:BuyPuzzleRet"] = {
	--活动id 商品配置idx 
	{ "uint","uint",     },
	{ "id",  "idx",      },
}
GameMsg.map["DownloadProto:GetDownloadReward"] = {
	--
	{ },
	{ },
}
GameMsg.map["DownloadProto:CheckDownloadRewardRet"] = {
	--是否已领取 
	{ "bool",    },
	{ "isGet",   },
}
GameMsg.map["DownloadProto:GetDownloadRewardRet"] = {
	--返回结果 
	{ "bool",  },
	{ "result",},
}
GameMsg.map["DownloadProto:CheckDownloadReward"] = {
	--
	{ },
	{ },
}
GameMsg.map["sQuestionna"] = {
	--问卷ID 标题     开始时间   结束时间    跳转路径        奖励           系统        渠道        领取状态（1已点击未领取） 
	{ "int", "string","uint",    "uint",     "string",       "list|sReward","array|int","array|int","byte",              },
	{ "id",  "name",  "openTime","closeTime","nTransferPath","reward",      "system",   "channel",  "getStatus",         },
}
GameMsg.map["QuestionnaireProto:GetInfo"] = {
	--
	{ },
	{ },
}
GameMsg.map["QuestionnaireProto:GetInfoRet"] = {
	--                   
	{ "list|sQuestionna",},
	{ "infos",           },
}
GameMsg.map["QuestionnaireProto:GetReward"] = {
	--问卷ID 
	{ "int", },
	{ "id",  },
}
GameMsg.map["QuestionnaireProto:GetRewardRet"] = {
	--问卷ID 
	{ "int", },
	{ "id",  },
}
GameMsg.map["QuestionnaireProto:Jump"] = {
	--问卷ID 
	{ "int", },
	{ "id",  },
}
GameMsg.map["QuestionnaireProto:JumpRet"] = {
	--问卷ID 
	{ "int", },
	{ "id",  },
}
GameMsg.map["sModSaveInfo"] = {
	--节点id   序号   分数    队伍卡牌     奖励           伤害      存档时间   
	{ "uint",  "uint","uint", "array|uint","list|sReward","long",   "uint",    },
	{ "nodeId","idx", "score","cards",     "rewards",     "nDamage","saveTime",},
}
GameMsg.map["sDupNodeInfo"] = {
	--节点id   关卡id  节点类型   该节点所属阶段 当前进度值    节点最大进度  节点状态 
	{ "uint",  "uint", "uint",    "uint",        "float",      "float",      "uint",  },
	{ "nodeId","dupId","nodeType","stageId",     "progressCur","progressMax","state", },
}
GameMsg.map["sCrossBossPlayerData"] = {
	--累计积分  当前选择的boss词条 存档数据            今日已上阵过的卡牌id 今日已上阵过的队伍id 已领取阶段奖励   
	{ "uint",   "uint",            "list|sModSaveInfo","array|uint",        "array|uint",        "array|uint",    },
	{ "score",  "chooseBuffId",    "modSaveData",      "arrCard",           "arrTeam",           "arrStageRwdGet",},
}
GameMsg.map["CrossBossProto:GetData"] = {
	--
	{ },
	{ },
}
GameMsg.map["CrossBossProto:GetDataRet"] = {
	--活动id  活动状态 当前阶段   阶段进度        节点列表            最终关卡刷出的buff 玩家个人数据         
	{ "uint", "uint",  "uint",    "uint",         "list|sDupNodeInfo","array|uint",      "struts|sCrossBossPlayerData",},
	{ "actId","state", "curStage","stageProgress","nodeList",         "buffList",        "playerData",        },
}
GameMsg.map["CrossBossProto:NodeStatePush"] = {
	--活动id  当前阶段   节点数据            
	{ "uint", "uint",    "list|sDupNodeInfo",},
	{ "actId","curStage","dirtyNodeList",    },
}
GameMsg.map["CrossBossProto:ChooseFinalBuff"] = {
	--活动id  选择的buffId 
	{ "uint", "uint",      },
	{ "actId","buffId",    },
}
GameMsg.map["CrossBossProto:ChooseFinalBuffRet"] = {
	--活动id  选择的buffId 是否成功 
	{ "uint", "uint",      "bool",  },
	{ "actId","buffId",    "isok",  },
}
GameMsg.map["CrossBossProto:CrossBossModUp"] = {
	--活动id  节点id   扫荡数据序号     
	{ "uint", "uint",  "uint",      "", },
	{ "actId","nodeId","idx",       " ",},
}
GameMsg.map["CrossBossProto:CrossBossModSave"] = {
	--活动id  节点id   要存的扫荡数据序号 
	{ "uint", "uint",  "uint",            },
	{ "actId","nodeId","idx",             },
}
GameMsg.map["CrossBossProto:CrossBossModSaveDel"] = {
	--活动id  节点id   要删除的扫荡数据序号 
	{ "uint", "uint",  "uint",              },
	{ "actId","nodeId","idx",               },
}
GameMsg.map["CrossBossProto:CrossBossSendModSaveData"] = {
	--活动id  节点id   存档数据            今日已上阵过的卡牌id 
	{ "uint", "uint",  "list|sModSaveInfo","array|uint",        },
	{ "actId","nodeId","modSaveData",      "arrCard",           },
}
GameMsg.map["CrossBossProto:EnterCrossBossFight"] = {
	--活动id  节点id   编队信息             是否模拟战斗  
	{ "uint", "uint",  "list|sDuplicateTeamData","bool",       },
	{ "actId","nodeId","list",              "isSimulated",},
}
GameMsg.map["CrossBossProto:CrossBossFightOver"] = {
	--活动id  节点id   本次获得积分 结果     奖励           今日已上阵过的卡牌id 今日已上阵过的队伍id 存档数据            是否模拟战斗  
	{ "uint", "uint",  "uint",      "bool",  "list|sReward","array|uint",        "array|uint",        "list|sModSaveInfo","bool",       },
	{ "actId","nodeId","score",     "bIsWin","reward",      "arrCard",           "arrTeam",           "modSaveData",      "isSimulated",},
}
GameMsg.map["CrossBossProto:CrossBossGetStageReward"] = {
	--活动id  档位id 
	{ "uint", "uint",},
	{ "actId","idx", },
}
GameMsg.map["sHalo"] = {
	--配置id  角色ID 等级    经验   装备槽            当前站位ID 
	{ "uint", "uint","uint", "uint","list|sHaloEquip","uint",    },
	{ "cfgid","cid", "level","exp", "equips",         "curCoor", },
}
GameMsg.map["HaloProto:HaloUp"] = {
	--角色ID 关环ID   素材(物品id,数量) 
	{ "uint","uint",  "list|sNumInfo",  },
	{ "cid", "haloId","items",          },
}
GameMsg.map["HaloProto:HaloUpRet"] = {
	--升级后的光环信息 素材(物品id,数量) 
	{ "struts|sHalo",  "list|sNumInfo",  },
	{ "info",          "items",          },
}
GameMsg.map["HaloProto:HaloChange"] = {
	--目标卡牌id 卡牌关环站位id 
	{ "uint",    "uint",        },
	{ "cid",     "hid",         },
}
GameMsg.map["HaloProto:HaloChangeRet"] = {
	--目标卡牌id 卡牌关环站位id 
	{ "uint",    "uint",        },
	{ "cid",     "hid",         },
}
GameMsg.map["PlayerProto:GetClientData"] = {
	--键值     
	{ "string",},
	{ "key",   },
}
GameMsg.map["PlayerProto:GetClientDataRet"] = {
	--键值     数据(json串) 类型   
	{ "string","string",    "byte",},
	{ "key",   "data",      "type",},
}
GameMsg.map["PlayerProto:SetClientData"] = {
	--键值     数据(json串) 类型(4,为删除数据） 
	{ "string","string",    "byte",             },
	{ "key",   "data",      "type",             },
}
GameMsg.map["shareReward"] = {
	--物品id 数量   类型   
	{ "uint","uint","byte",},
	{ "id",  "num", "type",},
}
GameMsg.map["ShareProto:AddShareCount"] = {
	--
	{ },
	{ },
}

