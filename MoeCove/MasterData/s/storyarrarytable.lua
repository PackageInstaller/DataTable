---@class StoryArraryTable
---@field public id integer
---@field public chapter integer
---@field public type integer
---@field public storyArrary table
---@field public canNotSkip integer

---@type StoryArraryTable[]
local StoryArraryTable = {
                [10001] = {
                        id = 10001,
                        chapter = 0,
                        type = 1,
                        storyArrary = {"battle_10001"},
                        canNotSkip = 0,
                },

                [10002] = {
                        id = 10002,
                        chapter = 0,
                        type = 1,
                        storyArrary = {"battle_10002"},
                        canNotSkip = 0,
                },

                [10003] = {
                        id = 10003,
                        chapter = 0,
                        type = 1,
                        storyArrary = {"battle_10101"},
                        canNotSkip = 0,
                },

                [10022] = {
                        id = 10022,
                        chapter = 0,
                        type = 1,
                        storyArrary = {"story_pv01"},
                        canNotSkip = 0,
                },

                [99] = {
                        id = 99,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900101"},
                        canNotSkip = 0,
                },

                [20001] = {
                        id = 20001,
                        chapter = 0,
                        type = 1,
                        storyArrary = nil,
                        canNotSkip = 0,
                },

                [20002] = {
                        id = 20002,
                        chapter = 0,
                        type = 1,
                        storyArrary = nil,
                        canNotSkip = 0,
                },

                [101011] = {
                        id = 101011,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110001"},
                        canNotSkip = 0,
                },

                [101021] = {
                        id = 101021,
                        chapter = 101,
                        type = 1,
                        storyArrary = {"battle_10001"},
                        canNotSkip = 0,
                },

                [101022] = {
                        id = 101022,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110006"},
                        canNotSkip = 0,
                },

                [101023] = {
                        id = 101023,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110003"},
                        canNotSkip = 0,
                },

                [101031] = {
                        id = 101031,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110004"},
                        canNotSkip = 0,
                },

                [101032] = {
                        id = 101032,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110005"},
                        canNotSkip = 0,
                },

                [101041] = {
                        id = 101041,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110004"},
                        canNotSkip = 0,
                },

                [101042] = {
                        id = 101042,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110005"},
                        canNotSkip = 0,
                },

                [102011] = {
                        id = 102011,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110101"},
                        canNotSkip = 0,
                },

                [102012] = {
                        id = 102012,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110102"},
                        canNotSkip = 0,
                },

                [102021] = {
                        id = 102021,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110103"},
                        canNotSkip = 0,
                },

                [102031] = {
                        id = 102031,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110104"},
                        canNotSkip = 0,
                },

                [102051] = {
                        id = 102051,
                        chapter = 101,
                        type = 1,
                        storyArrary = {"battle_10205"},
                        canNotSkip = 0,
                },

                [102052] = {
                        id = 102052,
                        chapter = 101,
                        type = 1,
                        storyArrary = {"battle_10101"},
                        canNotSkip = 0,
                },

                [102053] = {
                        id = 102053,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110106"},
                        canNotSkip = 0,
                },

                [10205401] = {
                        id = 10205401,
                        chapter = 101,
                        type = 3,
                        storyArrary = {"dialog_102051"},
                        canNotSkip = 0,
                },

                [10205402] = {
                        id = 10205402,
                        chapter = 101,
                        type = 3,
                        storyArrary = {"dialog_102052"},
                        canNotSkip = 0,
                },

                [10205403] = {
                        id = 10205403,
                        chapter = 101,
                        type = 3,
                        storyArrary = {"dialog_102053"},
                        canNotSkip = 0,
                },

                [102055] = {
                        id = 102055,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110107"},
                        canNotSkip = 0,
                },

                [102061] = {
                        id = 102061,
                        chapter = 101,
                        type = 1,
                        storyArrary = {"battle_10206"},
                        canNotSkip = 0,
                },

                [10206201] = {
                        id = 10206201,
                        chapter = 101,
                        type = 3,
                        storyArrary = {"dialog_102061"},
                        canNotSkip = 0,
                },

                [10206202] = {
                        id = 10206202,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_1020601"},
                        canNotSkip = 0,
                },

                [102063] = {
                        id = 102063,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110108"},
                        canNotSkip = 0,
                },

                [102071] = {
                        id = 102071,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110109"},
                        canNotSkip = 0,
                },

                [102072] = {
                        id = 102072,
                        chapter = 101,
                        type = 3,
                        storyArrary = {"dialog_102071"},
                        canNotSkip = 0,
                },

                [102081] = {
                        id = 102081,
                        chapter = 101,
                        type = 1,
                        storyArrary = {"battle_10208"},
                        canNotSkip = 0,
                },

                [102091] = {
                        id = 102091,
                        chapter = 101,
                        type = 2,
                        storyArrary = {"avg_110111"},
                        canNotSkip = 0,
                },

                [103011] = {
                        id = 103011,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_110201"},
                        canNotSkip = 0,
                },

                [10301101] = {
                        id = 10301101,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_1030101"},
                        canNotSkip = 0,
                },

                [10301102] = {
                        id = 10301102,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_1030102"},
                        canNotSkip = 0,
                },

                [10301103] = {
                        id = 10301103,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_1030103"},
                        canNotSkip = 0,
                },

                [103012] = {
                        id = 103012,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_110202"},
                        canNotSkip = 0,
                },

                [103021] = {
                        id = 103021,
                        chapter = 102,
                        type = 1,
                        storyArrary = {"battle_10302"},
                        canNotSkip = 0,
                },

                [10302101] = {
                        id = 10302101,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_1030201"},
                        canNotSkip = 0,
                },

                [10302102] = {
                        id = 10302102,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_1030202"},
                        canNotSkip = 0,
                },

                [10302103] = {
                        id = 10302103,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_1030203"},
                        canNotSkip = 0,
                },

                [103031] = {
                        id = 103031,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_110204"},
                        canNotSkip = 0,
                },

                [103041] = {
                        id = 103041,
                        chapter = 102,
                        type = 1,
                        storyArrary = {"battle_10304"},
                        canNotSkip = 0,
                },

                [10304101] = {
                        id = 10304101,
                        chapter = 102,
                        type = 3,
                        storyArrary = {"dialog_103041"},
                        canNotSkip = 0,
                },

                [103042] = {
                        id = 103042,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_110205"},
                        canNotSkip = 0,
                },

                [103051] = {
                        id = 103051,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_110206"},
                        canNotSkip = 0,
                },

                [203051] = {
                        id = 203051,
                        chapter = 102,
                        type = 1,
                        storyArrary = {"battle_10305"},
                        canNotSkip = 0,
                },

                [20305102] = {
                        id = 20305102,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_1030502"},
                        canNotSkip = 0,
                },

                [103061] = {
                        id = 103061,
                        chapter = 102,
                        type = 1,
                        storyArrary = {"battle_10306"},
                        canNotSkip = 0,
                },

                [103062] = {
                        id = 103062,
                        chapter = 102,
                        type = 1,
                        storyArrary = {"battle_103062"},
                        canNotSkip = 0,
                },

                [103071] = {
                        id = 103071,
                        chapter = 102,
                        type = 2,
                        storyArrary = {"avg_110208"},
                        canNotSkip = 0,
                },

                [104011] = {
                        id = 104011,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110301"},
                        canNotSkip = 0,
                },

                [104012] = {
                        id = 104012,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110302"},
                        canNotSkip = 0,
                },

                [104021] = {
                        id = 104021,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110303"},
                        canNotSkip = 0,
                },

                [104031] = {
                        id = 104031,
                        chapter = 201,
                        type = 1,
                        storyArrary = {"battle_10403"},
                        canNotSkip = 0,
                },

                [10403101] = {
                        id = 10403101,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110304"},
                        canNotSkip = 0,
                },

                [104032] = {
                        id = 104032,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110305"},
                        canNotSkip = 0,
                },

                [104041] = {
                        id = 104041,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110306"},
                        canNotSkip = 0,
                },

                [104051] = {
                        id = 104051,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110307"},
                        canNotSkip = 0,
                },

                [104061] = {
                        id = 104061,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110308"},
                        canNotSkip = 0,
                },

                [104071] = {
                        id = 104071,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110309"},
                        canNotSkip = 0,
                },

                [104072] = {
                        id = 104072,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110310"},
                        canNotSkip = 0,
                },

                [104081] = {
                        id = 104081,
                        chapter = 201,
                        type = 2,
                        storyArrary = {"avg_110311"},
                        canNotSkip = 0,
                },

                [105011] = {
                        id = 105011,
                        chapter = 202,
                        type = 2,
                        storyArrary = {"avg_110401"},
                        canNotSkip = 0,
                },

                [105021] = {
                        id = 105021,
                        chapter = 202,
                        type = 1,
                        storyArrary = {"battle_10502"},
                        canNotSkip = 0,
                },

                [105022] = {
                        id = 105022,
                        chapter = 202,
                        type = 2,
                        storyArrary = {"avg_110403"},
                        canNotSkip = 0,
                },

                [105031] = {
                        id = 105031,
                        chapter = 202,
                        type = 2,
                        storyArrary = {"avg_110404"},
                        canNotSkip = 0,
                },

                [10503101] = {
                        id = 10503101,
                        chapter = 202,
                        type = 2,
                        storyArrary = {"avg_1050301"},
                        canNotSkip = 0,
                },

                [105032] = {
                        id = 105032,
                        chapter = 202,
                        type = 2,
                        storyArrary = {"avg_110405"},
                        canNotSkip = 0,
                },

                [105041] = {
                        id = 105041,
                        chapter = 202,
                        type = 2,
                        storyArrary = {"avg_110406"},
                        canNotSkip = 0,
                },

                [105051] = {
                        id = 105051,
                        chapter = 202,
                        type = 2,
                        storyArrary = {"avg_110407"},
                        canNotSkip = 0,
                },

                [105061] = {
                        id = 105061,
                        chapter = 202,
                        type = 2,
                        storyArrary = {"avg_110408"},
                        canNotSkip = 0,
                },

                [105071] = {
                        id = 105071,
                        chapter = 202,
                        type = 2,
                        storyArrary = {"avg_110409"},
                        canNotSkip = 0,
                },

                [105072] = {
                        id = 105072,
                        chapter = 202,
                        type = 2,
                        storyArrary = {"avg_110410"},
                        canNotSkip = 0,
                },

                [106011] = {
                        id = 106011,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110501"},
                        canNotSkip = 0,
                },

                [106012] = {
                        id = 106012,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110502"},
                        canNotSkip = 0,
                },

                [106021] = {
                        id = 106021,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110503"},
                        canNotSkip = 0,
                },

                [106022] = {
                        id = 106022,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110504"},
                        canNotSkip = 0,
                },

                [106031] = {
                        id = 106031,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110505"},
                        canNotSkip = 0,
                },

                [106041] = {
                        id = 106041,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110506"},
                        canNotSkip = 0,
                },

                [106042] = {
                        id = 106042,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110507"},
                        canNotSkip = 0,
                },

                [106051] = {
                        id = 106051,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110508"},
                        canNotSkip = 0,
                },

                [106061] = {
                        id = 106061,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110509"},
                        canNotSkip = 0,
                },

                [106071] = {
                        id = 106071,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110510"},
                        canNotSkip = 0,
                },

                [8888] = {
                        id = 8888,
                        chapter = 0,
                        type = 1,
                        storyArrary = {"battle_10001"},
                        canNotSkip = 0,
                },

                [50001] = {
                        id = 50001,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1000"},
                        canNotSkip = 0,
                },

                [50002] = {
                        id = 50002,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1000"},
                        canNotSkip = 0,
                },

                [50003] = {
                        id = 50003,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1000"},
                        canNotSkip = 0,
                },

                [30001] = {
                        id = 30001,
                        chapter = 0,
                        type = 3,
                        storyArrary = {"dialog_10001"},
                        canNotSkip = 0,
                },

                [1010101] = {
                        id = 1010101,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1010101"},
                        canNotSkip = 0,
                },

                [1010102] = {
                        id = 1010102,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1010102"},
                        canNotSkip = 0,
                },

                [1010201] = {
                        id = 1010201,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1010201"},
                        canNotSkip = 0,
                },

                [1010202] = {
                        id = 1010202,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1010202"},
                        canNotSkip = 0,
                },

                [1010203] = {
                        id = 1010203,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_110006"},
                        canNotSkip = 0,
                },

                [1010204] = {
                        id = 1010204,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1010204"},
                        canNotSkip = 0,
                },

                [1010205] = {
                        id = 1010205,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1010205"},
                        canNotSkip = 0,
                },

                [1010301] = {
                        id = 1010301,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1010301"},
                        canNotSkip = 0,
                },

                [1010302] = {
                        id = 1010302,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1010302"},
                        canNotSkip = 0,
                },

                [1010303] = {
                        id = 1010303,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1010303"},
                        canNotSkip = 0,
                },

                [1020101] = {
                        id = 1020101,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020101"},
                        canNotSkip = 0,
                },

                [1020102] = {
                        id = 1020102,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020102"},
                        canNotSkip = 0,
                },

                [1020103] = {
                        id = 1020103,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020103"},
                        canNotSkip = 0,
                },

                [1020104] = {
                        id = 1020104,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020104"},
                        canNotSkip = 0,
                },

                [1020301] = {
                        id = 1020301,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020301"},
                        canNotSkip = 0,
                },

                [1020302] = {
                        id = 1020302,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020302"},
                        canNotSkip = 0,
                },

                [1020303] = {
                        id = 1020303,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020303"},
                        canNotSkip = 0,
                },

                [1020304] = {
                        id = 1020304,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020304"},
                        canNotSkip = 0,
                },

                [1020305] = {
                        id = 1020305,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020305"},
                        canNotSkip = 0,
                },

                [1020306] = {
                        id = 1020306,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020306"},
                        canNotSkip = 0,
                },

                [1020307] = {
                        id = 1020307,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_1020307"},
                        canNotSkip = 0,
                },

                [99999] = {
                        id = 99999,
                        chapter = 0,
                        type = 1,
                        storyArrary = {"battle_999"},
                        canNotSkip = 0,
                },

                [3010101] = {
                        id = 3010101,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_3010101"},
                        canNotSkip = 0,
                },

                [3010201] = {
                        id = 3010201,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_3010201"},
                        canNotSkip = 0,
                },

                [3010202] = {
                        id = 3010202,
                        chapter = 0,
                        type = 2,
                        storyArrary = {"avg_3010202"},
                        canNotSkip = 0,
                },

                [40101] = {
                        id = 40101,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900101"},
                        canNotSkip = 1,
                },

                [40201] = {
                        id = 40201,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900201"},
                        canNotSkip = 0,
                },

                [40202] = {
                        id = 40202,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900202"},
                        canNotSkip = 0,
                },

                [40301] = {
                        id = 40301,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900301"},
                        canNotSkip = 0,
                },

                [40302] = {
                        id = 40302,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900302"},
                        canNotSkip = 0,
                },

                [40401] = {
                        id = 40401,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900401"},
                        canNotSkip = 0,
                },

                [40402] = {
                        id = 40402,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900402"},
                        canNotSkip = 0,
                },

                [40501] = {
                        id = 40501,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900501"},
                        canNotSkip = 0,
                },

                [40502] = {
                        id = 40502,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900502"},
                        canNotSkip = 0,
                },

                [40601] = {
                        id = 40601,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900601"},
                        canNotSkip = 0,
                },

                [40602] = {
                        id = 40602,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900602"},
                        canNotSkip = 0,
                },

                [40701] = {
                        id = 40701,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900701"},
                        canNotSkip = 0,
                },

                [40801] = {
                        id = 40801,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900801"},
                        canNotSkip = 0,
                },

                [40901] = {
                        id = 40901,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_900901"},
                        canNotSkip = 0,
                },

                [41001] = {
                        id = 41001,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_901001"},
                        canNotSkip = 0,
                },

                [41101] = {
                        id = 41101,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_901101"},
                        canNotSkip = 1,
                },

                [41201] = {
                        id = 41201,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_901201"},
                        canNotSkip = 1,
                },

                [41301] = {
                        id = 41301,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_901301"},
                        canNotSkip = 1,
                },

                [41401] = {
                        id = 41401,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_901401"},
                        canNotSkip = 0,
                },

                [41501] = {
                        id = 41501,
                        chapter = 0,
                        type = 4,
                        storyArrary = {"homestory_901501"},
                        canNotSkip = 1,
                },

}
return StoryArraryTable