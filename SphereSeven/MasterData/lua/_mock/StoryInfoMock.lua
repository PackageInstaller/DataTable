local StoryInfoMock = BaseClass("StoryInfoMock", Singleton);

local function StoryInfo(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        StoryChapters = 
        {
            {
                ChapterId = 1,
                CompletedSections = 
                {
                    {
                        CompletedId = 101,
                        StoryLevelScoreInfoList = 
                        {
                            {
                                Difficulty = 1,
                                LevelId = 1,
                                IsReachRewardCond1 = 0,
                                IsReachRewardCond2 = 0,
                                IsReachRewardCond3 = 0,
                            }
                        }
                    }
                }
            }
        }            
    }
    return rspMsg
end

-- LevelTypeStory = 0;
-- LevelTypeSevenStar = 1;
-- LevelTypeChallenge = 5;
-- LeveLTypeGuide = 6;

local function LevelInfo(reqMsg)
    local respMsg = {}
    respMsg.level_packs = {}
    if reqMsg.types ~= nil then
        for _, type in ipairs(reqMsg.types) do
            if type == LevelType.LevelTypeStory then
                local storyTable = {}
                storyTable.level_type = LevelType.LevelTypeStory
                local storyLevels = {}
                for _, value in pairs(Z_StorySection) do
                    table.insert(storyLevels, 
                    {
                        id = value.Id,
                        star = 3,
                        pass_times = 1,
                        reached_goals = {
                            1,
                            1,
                            1,
                        },
                        first_drop_available = false,
                        first_perfect_drop_available = false,
                    })
                end
                storyTable.levels = storyLevels
                table.insert(respMsg.level_packs, storyTable)
            elseif type == LevelType.LevelTypeSevenStar then
                local sevenStarTable = {}
                sevenStarTable.level_type = LevelType.LevelTypeSevenStar
                local sevenStarLevels = {}
                for _, value in pairs(Z_SevenStar) do
                    table.insert(sevenStarLevels, 
                    {
                        id = value.Id,
                        star = 3,
                        pass_times = 1,
                        reached_goals = {
                            1,
                            1,
                            1,
                        },
                        first_drop_available = false,
                        first_perfect_drop_available = false,
                    })
                end
                sevenStarTable.levels = sevenStarLevels
                table.insert(respMsg.level_packs, sevenStarTable)
            elseif type == LevelType.LevelTypeTower then
                local towerTable = {}
                towerTable.level_type = LevelType.LevelTypeTower
                local towerLevels = {}
                for _, value in pairs(Z_LordTower) do
                    table.insert(towerLevels, 
                    {
                        id = value.Id,
                        star = 3,
                        pass_times = 1,
                        reached_goals = {
                            1,
                            1,
                            1,
                        },
                        first_drop_available = false,
                        first_perfect_drop_available = false,
                    })
                end
                towerTable.levels = towerLevels
                table.insert(respMsg.level_packs, towerTable)
            elseif type == LevelType.LevelTypeChallenge then
                local challengeTable = {}
                challengeTable.level_type = LevelType.LevelTypeChallenge
                local challengeLevels = {}
                for _, value in pairs(Z_Challenge) do
                    table.insert(challengeLevels, 
                    {
                        id = value.Id,
                        star = 3,
                        pass_times = 1,
                        reached_goals = {
                            1,
                            1,
                            1,
                        },
                        first_drop_available = false,
                        first_perfect_drop_available = false,
                    })
                end
                challengeTable.levels = challengeLevels
                table.insert(respMsg.level_packs, challengeTable)
            elseif type == LevelType.LevelTypeMonthlyTower then
                
            end
        end
    end
    
    return respMsg
end


local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_StoryInfo, StoryInfo)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.LevelPackReq, LevelInfo)
end

local function __delete(self)
end

StoryInfoMock.__init = __init
StoryInfoMock.__delete = __delete


return StoryInfoMock;