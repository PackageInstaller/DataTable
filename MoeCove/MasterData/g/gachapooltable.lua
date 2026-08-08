---@class GachaPoolTable
---@field public id integer
---@field public poolType integer
---@field public display integer
---@field public content table
---@field public startTime string
---@field public endTime string
---@field public countGroup table
---@field public countShow integer
---@field public incrementalRules table
---@field public limit table
---@field public position table
---@field public namePosition table
---@field public getPosition 
---@field public PoolNameTitle LocalStrEnum
---@field public PoolNameDes1 LocalStrEnum
---@field public PoolNameDes2 LocalStrEnum
---@field public Name LocalStrEnum
---@field public PoolName string
---@field public PoolTimeBg string
---@field public PoolToggle string
---@field public characterBg string
---@field public background string
---@field public charaPosition1 table
---@field public charaPosition2 table
---@field public banner string
---@field public cost integer
---@field public shopID integer
---@field public Resources table
---@field public ResourcesShow table
---@field public explainTips table

---@type GachaPoolTable[]
local GachaPoolTable = {
                [10001] = {
                        id = 10001,
                        poolType = 2,
                        display = 1,
                        content = {{100,10},{200,100},{300,890}},
                        startTime = "2024-10-31 16:48:00",
                        endTime = "",
                        countGroup = {100,200},
                        countShow = 10003,
                        incrementalRules = {100,65,50},
                        limit = nil,
                        position = {{20,50}},
                        namePosition = {{50,20}},
                        getPosition = nil,
                        PoolNameTitle = LocalStrEnum.PoolName_001,
                        PoolNameDes1 = LocalStrEnum.PoolNameDes1_10001,
                        PoolNameDes2 = LocalStrEnum.PoolNameDes2_10001,
                        Name = LocalStrEnum.name_001,
                        PoolName = "",
                        PoolTimeBg = "",
                        PoolToggle = "pool_toggle_01",
                        characterBg = "",
                        background = "scene_headquarters",
                        charaPosition1 = nil,
                        charaPosition2 = nil,
                        banner = "",
                        cost = 110014,
                        shopID = 2004002,
                        Resources = {100001,100002,110014,110016},
                        ResourcesShow = {100001,100002},
                        explainTips = {{boxname="GachaTitle_001",value={{type="RulesTxt",txt="GachaDes_009"},{type="RulesTxt",txt="GachaDes_011"},{type="RulesTxt",txt="GachaDes_010"}}},{boxname="GachaTitle_002",value={{type="RulesTxt",txt="GachaDes_002",Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="5",txt="GachaTips_001"},{type="MsgView",value={{id=10013,txt="8.33%"},{id=10008,txt="8.33%"},{id=10012,txt="8.33%"},{id=10015,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="4",txt="GachaTips_004"},{type="MsgView",value={{id=10001,txt="6.25%"},{id=10002,txt="6.25%"},{id=10003,txt="6.25%"},{id=10004,txt="6.25%"},{id=10006,txt="6.25%"},{id=10009,txt="6.25%"},{id=10019,txt="6.25%"},{id=10032,txt="6.25%"},{id=10037,txt="6.25%"},{id=10038,txt="6.25%"},{id=901,txt="6.25%"},{id=901,txt="6.25%"},{id=901,txt="6.25%"},{id=901,txt="6.25%"},{id=901,txt="6.25%"},{id=901,txt="6.25%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="3",txt="GachaTips_005"},{type="MsgView",value={{id=10039,txt="20%"},{id=10040,txt="20%"},{id=900,txt="20%"},{id=900,txt="20%"},{id=900,txt="20%"}}},{type="cube"},{type="cube"}}}},
                },

                [20001] = {
                        id = 20001,
                        poolType = 3,
                        display = 2,
                        content = {{101,10},{201,100},{300,890}},
                        startTime = "2025-10-31 16:48:00",
                        endTime = "2026-6-26 05:00:00",
                        countGroup = {101,201},
                        countShow = 10011,
                        incrementalRules = {101,65,50},
                        limit = nil,
                        position = {[1002]={10,10},[1003]={12,13},[1007]={15,13},[1005]={17,13}},
                        namePosition = nil,
                        getPosition = nil,
                        PoolNameTitle = LocalStrEnum.PoolName_002,
                        PoolNameDes1 = LocalStrEnum.PoolNameDes1_20001,
                        PoolNameDes2 = LocalStrEnum.PoolNameDes2_20001,
                        Name = LocalStrEnum.name_002,
                        PoolName = "pool_title_02",
                        PoolTimeBg = "pool_timebox_03",
                        PoolToggle = "pool_toggle_02",
                        characterBg = "poolchar_01",
                        background = "scene_nomal_pool_01",
                        charaPosition1 = nil,
                        charaPosition2 = nil,
                        banner = "",
                        cost = 110016,
                        shopID = 2004001,
                        Resources = {100001,100002,110014,110016},
                        ResourcesShow = {100001,100002},
                        explainTips = {{boxname="GachaTitle_001",value={{type="RulesTxt",txt="GachaDes_012"}}},{boxname="GachaTitle_002",value={{type="RulesTxt",txt="GachaDes_002",Line=1},{type="cube"},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="5",txt="GachaTips_001"},{type="MsgTxt",txt="GachaTips_006"},{type="MsgView",value={{id=10005,txt="14.28%"},{id=10007,txt="14.28%"},{id=10012,txt="14.28%"},{id=10013,txt="14.28%"},{id=10015,txt="14.28%"},{id=10017,txt="14.28%"},{id=10022,txt="14.28%"}},Line=1},{type="cube"},{type="cube"},{type="MsgTxt",txt="GachaTips_007"},{type="MsgView",value={{id=10008,txt="20%"},{id=10014,txt="20%"},{id=10027,txt="20%"},{id=10029,txt="20%"},{id=10033,txt="20%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="4",txt="GachaTips_004"},{type="MsgView",value={{id=10001,txt="6.25%"},{id=10002,txt="6.25%"},{id=10003,txt="6.25%"},{id=10004,txt="6.25%"},{id=10006,txt="6.25%"},{id=10009,txt="6.25%"},{id=10010,txt="6.25%"},{id=10016,txt="6.25%"},{id=10019,txt="6.25%"},{id=10021,txt="6.25%"},{id=10028,txt="6.25%"},{id=10031,txt="6.25%"},{id=10032,txt="6.25%"},{id=10037,txt="6.25%"},{id=10038,txt="6.25%"},{id=10043,txt="6.25%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="3",txt="GachaTips_005"},{type="MsgView",value={{id=10039,txt="20%"},{id=10040,txt="20%"},{id=10050,txt="20%"},{id=10052,txt="20%"},{id=10053,txt="20%"}}},{type="cube"},{type="cube"}}},{boxname="GachaTitle_003",value={{type="RulesTxt",txt="GachaDes_004"}}}},
                },

                [20002] = {
                        id = 20002,
                        poolType = 3,
                        display = 3,
                        content = {{101,10},{201,100},{300,890}},
                        startTime = "2025-10-31 16:48:00",
                        endTime = "2026-6-26 05:00:00",
                        countGroup = {101,201},
                        countShow = 10021,
                        incrementalRules = {101,65,50},
                        limit = nil,
                        position = {[1002]={10,10},[1003]={12,13},[1007]={15,13},[1005]={17,13}},
                        namePosition = nil,
                        getPosition = nil,
                        PoolNameTitle = LocalStrEnum.PoolName_003,
                        PoolNameDes1 = LocalStrEnum.PoolNameDes1_20002,
                        PoolNameDes2 = LocalStrEnum.PoolNameDes2_20002,
                        Name = LocalStrEnum.name_002,
                        PoolName = "pool_title_03",
                        PoolTimeBg = "pool_timebox_03",
                        PoolToggle = "pool_toggle_03",
                        characterBg = "poolchar_02",
                        background = "scene_nomal_pool_02",
                        charaPosition1 = nil,
                        charaPosition2 = nil,
                        banner = "",
                        cost = 110016,
                        shopID = 2004001,
                        Resources = {100001,100002,110014,110016},
                        ResourcesShow = {100001,100002},
                        explainTips = {{boxname="GachaTitle_001",value={{type="RulesTxt",txt="GachaDes_013"}}},{boxname="GachaTitle_002",value={{type="RulesTxt",txt="GachaDes_002",Line=1},{type="cube"},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="5",txt="GachaTips_001"},{type="MsgTxt",txt="GachaTips_006"},{type="MsgView",value={{id=10008,txt="20%"},{id=10014,txt="20%"},{id=10027,txt="20%"},{id=10029,txt="20%"},{id=10033,txt="20%"}},Line=1},{type="cube"},{type="cube"},{type="MsgTxt",txt="GachaTips_007"},{type="MsgView",value={{id=10005,txt="14.28%"},{id=10007,txt="14.28%"},{id=10012,txt="14.28%"},{id=10013,txt="14.28%"},{id=10015,txt="14.28%"},{id=10017,txt="14.28%"},{id=10022,txt="14.28%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="4",txt="GachaTips_004"},{type="MsgView",value={{id=10001,txt="6.25%"},{id=10002,txt="6.25%"},{id=10003,txt="6.25%"},{id=10004,txt="6.25%"},{id=10006,txt="6.25%"},{id=10009,txt="6.25%"},{id=10010,txt="6.25%"},{id=10016,txt="6.25%"},{id=10019,txt="6.25%"},{id=10021,txt="6.25%"},{id=10028,txt="6.25%"},{id=10031,txt="6.25%"},{id=10032,txt="6.25%"},{id=10037,txt="6.25%"},{id=10038,txt="6.25%"},{id=10043,txt="6.25%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="3",txt="GachaTips_005"},{type="MsgView",value={{id=10039,txt="20%"},{id=10040,txt="20%"},{id=10050,txt="20%"},{id=10052,txt="20%"},{id=10053,txt="20%"}}},{type="cube"},{type="cube"}}},{boxname="GachaTitle_003",value={{type="RulesTxt",txt="GachaDes_004"}}}},
                },

                [20003] = {
                        id = 20003,
                        poolType = 1,
                        display = 4,
                        content = {{101,10},{201,100},{300,890}},
                        startTime = "2026-6-26 05:00:00",
                        endTime = "2026-8-1 05:00:00",
                        countGroup = {101,201},
                        countShow = 10031,
                        incrementalRules = {101,65,50},
                        limit = {10007},
                        position = {[1002]={10,10},[1003]={12,13},[1007]={15,13},[1005]={17,13}},
                        namePosition = nil,
                        getPosition = nil,
                        PoolNameTitle = LocalStrEnum.PoolName_004,
                        PoolNameDes1 = LocalStrEnum.PoolNameDes1_20003,
                        PoolNameDes2 = LocalStrEnum.PoolNameDes2_20003,
                        Name = LocalStrEnum.name_003,
                        PoolName = "pool_title_10007",
                        PoolTimeBg = "pool_timebox_04",
                        PoolToggle = "pool_toggle_10007",
                        characterBg = "",
                        background = "scene_sea_day",
                        charaPosition1 = nil,
                        charaPosition2 = nil,
                        banner = "",
                        cost = 110016,
                        shopID = 2004001,
                        Resources = {100001,100002,110014,110016},
                        ResourcesShow = {100001,100002},
                        explainTips = {{boxname="GachaTitle_001",value={{type="RulesTxt",txt="GachaDes_017"},{type="RulesTxt",txt="GachaDes_003"}}},{boxname="GachaTitle_002",value={{type="RulesTxt",txt="GachaDes_002",Line=1},{type="cube"},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="5",txt="GachaTips_001"},{type="MsgTxt",txt="GachaTips_002"},{type="MsgView",value={{id=10007,txt="100%"}}},{type="cube"},{type="cube"},{type="MsgTxt",txt="GachaTips_003"},{type="MsgView",value={{id=10013,txt="8.33%"},{id=10008,txt="8.33%"},{id=10012,txt="8.33%"},{id=10015,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"},{id=902,txt="8.33%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="4",txt="GachaTips_004"},{type="MsgView",value={{id=10001,txt="6.25%"},{id=10002,txt="6.25%"},{id=10003,txt="6.25%"},{id=10004,txt="6.25%"},{id=10006,txt="6.25%"},{id=10009,txt="6.25%"},{id=10019,txt="6.25%"},{id=10032,txt="6.25%"},{id=10037,txt="6.25%"},{id=10038,txt="6.25%"},{id=901,txt="6.25%"},{id=901,txt="6.25%"},{id=901,txt="6.25%"},{id=901,txt="6.25%"},{id=901,txt="6.25%"},{id=901,txt="6.25%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="3",txt="GachaTips_005"},{type="MsgView",value={{id=10039,txt="20%"},{id=10040,txt="20%"},{id=900,txt="20%"},{id=900,txt="20%"},{id=900,txt="20%"}}},{type="cube"},{type="cube"}}},{boxname="GachaTitle_003",value={{type="RulesTxt",txt="GachaDes_004"}}}},
                },

                [20004] = {
                        id = 20004,
                        poolType = 1,
                        display = 99,
                        content = {{101,10},{201,100},{300,890}},
                        startTime = "2026-6-26 05:00:00",
                        endTime = "2026-6-26 05:00:00",
                        countGroup = {101,201},
                        countShow = 10042,
                        incrementalRules = {101,65,50},
                        limit = {10020},
                        position = {[1002]={10,10},[1003]={12,13},[1007]={15,13},[1005]={17,13}},
                        namePosition = nil,
                        getPosition = nil,
                        PoolNameTitle = LocalStrEnum.PoolName_005,
                        PoolNameDes1 = LocalStrEnum.PoolNameDes1_20004,
                        PoolNameDes2 = LocalStrEnum.PoolNameDes2_20004,
                        Name = LocalStrEnum.name_003,
                        PoolName = "pool_title_10020",
                        PoolTimeBg = "pool_timebox_01",
                        PoolToggle = "pool_toggle_10020",
                        characterBg = "",
                        background = "scene_sea_night3",
                        charaPosition1 = nil,
                        charaPosition2 = nil,
                        banner = "",
                        cost = 110016,
                        shopID = 2004001,
                        Resources = {100001,100002,110014,110016},
                        ResourcesShow = {100001,100002},
                        explainTips = {{boxname="GachaTitle_001",value={{type="RulesTxt",txt="GachaDes_015"},{type="RulesTxt",txt="GachaDes_003"}}},{boxname="GachaTitle_002",value={{type="RulesTxt",txt="GachaDes_002",Line=1},{type="cube"},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="5",txt="GachaTips_001"},{type="MsgTxt",txt="GachaTips_002"},{type="MsgView",value={{id=10020,txt="100%"}}},{type="cube"},{type="cube"},{type="MsgTxt",txt="GachaTips_003"},{type="MsgView",value={{id=10005,txt="8.33%"},{id=10007,txt="8.33%"},{id=10008,txt="8.33%"},{id=10012,txt="8.33%"},{id=10013,txt="8.33%"},{id=10014,txt="8.33%"},{id=10015,txt="8.33%"},{id=10017,txt="8.33%"},{id=10022,txt="8.33%"},{id=10027,txt="8.33%"},{id=10029,txt="8.33%"},{id=10033,txt="8.33%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="4",txt="GachaTips_004"},{type="MsgView",value={{id=10001,txt="6.25%"},{id=10002,txt="6.25%"},{id=10003,txt="6.25%"},{id=10004,txt="6.25%"},{id=10006,txt="6.25%"},{id=10009,txt="6.25%"},{id=10010,txt="6.25%"},{id=10016,txt="6.25%"},{id=10019,txt="6.25%"},{id=10021,txt="6.25%"},{id=10028,txt="6.25%"},{id=10031,txt="6.25%"},{id=10032,txt="6.25%"},{id=10037,txt="6.25%"},{id=10038,txt="6.25%"},{id=10043,txt="6.25%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="3",txt="GachaTips_005"},{type="MsgView",value={{id=10039,txt="20%"},{id=10040,txt="20%"},{id=10050,txt="20%"},{id=10052,txt="20%"},{id=10053,txt="20%"}}},{type="cube"},{type="cube"}}},{boxname="GachaTitle_003",value={{type="RulesTxt",txt="GachaDes_004"}}}},
                },

                [20005] = {
                        id = 20005,
                        poolType = 1,
                        display = 98,
                        content = {{101,10},{201,100},{300,890}},
                        startTime = "2026-6-26 05:00:00",
                        endTime = "2026-6-26 05:00:00",
                        countGroup = {101,201},
                        countShow = 10052,
                        incrementalRules = {101,65,50},
                        limit = {10042},
                        position = {[1002]={10,10},[1003]={12,13},[1007]={15,13},[1005]={17,13}},
                        namePosition = nil,
                        getPosition = nil,
                        PoolNameTitle = LocalStrEnum.PoolName_006,
                        PoolNameDes1 = LocalStrEnum.PoolNameDes1_20005,
                        PoolNameDes2 = LocalStrEnum.PoolNameDes2_20005,
                        Name = LocalStrEnum.name_003,
                        PoolName = "pool_title_10042",
                        PoolTimeBg = "pool_timebox_02",
                        PoolToggle = "pool_toggle_10042",
                        characterBg = "",
                        background = "scene_sea_day",
                        charaPosition1 = nil,
                        charaPosition2 = nil,
                        banner = "",
                        cost = 110016,
                        shopID = 2004001,
                        Resources = {100001,100002,110014,110016},
                        ResourcesShow = {100001,100002},
                        explainTips = {{boxname="GachaTitle_001",value={{type="RulesTxt",txt="GachaDes_016"},{type="RulesTxt",txt="GachaDes_003"}}},{boxname="GachaTitle_002",value={{type="RulesTxt",txt="GachaDes_002",Line=1},{type="cube"},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="5",txt="GachaTips_001"},{type="MsgTxt",txt="GachaTips_002"},{type="MsgView",value={{id=10042,txt="100%"}}},{type="cube"},{type="cube"},{type="MsgTxt",txt="GachaTips_003"},{type="MsgView",value={{id=10005,txt="8.33%"},{id=10007,txt="8.33%"},{id=10008,txt="8.33%"},{id=10012,txt="8.33%"},{id=10013,txt="8.33%"},{id=10014,txt="8.33%"},{id=10015,txt="8.33%"},{id=10017,txt="8.33%"},{id=10022,txt="8.33%"},{id=10027,txt="8.33%"},{id=10029,txt="8.33%"},{id=10033,txt="8.33%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="4",txt="GachaTips_004"},{type="MsgView",value={{id=10001,txt="6.25%"},{id=10002,txt="6.25%"},{id=10003,txt="6.25%"},{id=10004,txt="6.25%"},{id=10006,txt="6.25%"},{id=10009,txt="6.25%"},{id=10010,txt="6.25%"},{id=10016,txt="6.25%"},{id=10019,txt="6.25%"},{id=10021,txt="6.25%"},{id=10028,txt="6.25%"},{id=10031,txt="6.25%"},{id=10032,txt="6.25%"},{id=10037,txt="6.25%"},{id=10038,txt="6.25%"},{id=10043,txt="6.25%"}},Line=1},{type="cube"},{type="cube"},{type="RankMsgTxt",rank="3",txt="GachaTips_005"},{type="MsgView",value={{id=10039,txt="20%"},{id=10040,txt="20%"},{id=10050,txt="20%"},{id=10052,txt="20%"},{id=10053,txt="20%"}}},{type="cube"},{type="cube"}}},{boxname="GachaTitle_003",value={{type="RulesTxt",txt="GachaDes_004"}}}},
                },

}
return GachaPoolTable