local LevelUpdatePush = BaseClass("LevelUpdatePush",IMHandler)

-- 断线重连触发事件
LevelUpdatePush.__init = function(self)

end

LevelUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end
        local levelType = pbMsg.level_type
        local levelInfo = pbMsg.levels[1]
        if levelInfo == nil then
            if levelType == LevelType.LevelTypeStory or levelType == LevelType.LevelTypeGameEvent then
                local storyComponent = Game.Scene.Player:GetComponent("StoryComponent")
                if storyComponent.StoryChapters[pbMsg.level_type] == nil then
                    storyComponent.StoryChapters[pbMsg.level_type] = {}
                    storyComponent.StoryChapters[pbMsg.level_type].LevelType = levelType
                    storyComponent.StoryChapters[pbMsg.level_type].CompletedSections = {}
                end
                
                if pbMsg.unlocked_groups ~= nil then
                    if pbMsg.unlocked_groups.add ~= nil then
                        for i, v in ipairs(pbMsg.unlocked_groups.add) do
                            table.insert(storyComponent.StoryChapters[pbMsg.level_type].unlockedGroups, v)
                        end
                    end
                    if pbMsg.unlocked_groups.remove ~= nil then
                        for i, v in ipairs(pbMsg.unlocked_groups.remove) do
                            table.removebyvalue(storyComponent.StoryChapters[pbMsg.level_type].unlockedGroups, v)
                        end
                    end
                end
            end
            return
        end
        local levelId = levelInfo.id
        local latestLevelId = pbMsg.latest_level_id

        if levelType == LevelType.LevelTypeStory or levelType == LevelType.LevelTypeGameEvent then
            local storyComponent = Game.Scene.Player:GetComponent("StoryComponent")
            local chapterWithCompletedIds = {}
            local chapterId
            local excel
            if levelType == LevelType.LevelTypeStory then
                local levelData = Z_StorySection[levelInfo.id]
                if levelData ~= nil then
                    chapterId = Z_StorySection[levelInfo.id].ChapterId
                    excel = Z_StorySection
                end
            else
                local levelData = Z_GameEventsLevel[levelInfo.id]
                if levelData ~= nil then
                    chapterId = Z_GameEventsLevel[levelInfo.id].ChapterId
                    excel = Z_GameEventsLevel  
                end
            end
            if chapterId ~= nil and table.count(storyComponent.StoryChapters[pbMsg.level_type].CompletedSections) == 0 then
                if storyComponent.StoryChapters[pbMsg.level_type] == nil then
                    storyComponent.StoryChapters[pbMsg.level_type] = {}
                    storyComponent.StoryChapters[pbMsg.level_type].LevelType = levelType
                    storyComponent.StoryChapters[pbMsg.level_type].CompletedSections = {}
                end

                chapterWithCompletedIds[chapterId] = {}
                chapterWithCompletedIds[chapterId].StoryLevelScoreInfoList = {}
                chapterWithCompletedIds[chapterId].StoryLevelScoreInfoList[levelId] = levelInfo
                chapterWithCompletedIds[chapterId].CompletedId = latestLevelId
                storyComponent.StoryChapters[pbMsg.level_type].CompletedSections = chapterWithCompletedIds
            elseif chapterId ~= nil then
                local StoryLevelScoreInfoList = {}
                for i, v in pairs(storyComponent.level_packs) do
                    if v.level_type == levelType then
                        local levelPack = table.first(storyComponent.level_packs, function(v)
                            return v.level_type == levelType
                        end)
                        local isNew = true
                        for j, lvInfo in pairs(v.levels) do
                            if lvInfo.id == levelId then
                                isNew = false
                                levelPack.levels[j] = levelInfo
                            end
                        end
    
                        if isNew then
                            table.insert(v.levels, levelInfo)
                        end
                    end
                end


                local lastestId = 0
                local levelPack = table.first(storyComponent.level_packs, function(v)
                    return v.level_type == levelType
                end)
                for index, value in pairs(levelPack.levels) do
                    if excel[value.id] ~= nil and excel[value.id].ChapterId == chapterId then
                        StoryLevelScoreInfoList[value.id] = {}
                        StoryLevelScoreInfoList[value.id] = value
                        if value.id > lastestId then
                            lastestId = value.id
                        end
                        storyComponent:AddStoryLevelScore(chapterId, Game.Registry:NewObject("StoryLevelScore", value, levelType))
                    end
                end
                if storyComponent.StoryChapters[pbMsg.level_type].CompletedSections[chapterId] == nil then
                    storyComponent.StoryChapters[pbMsg.level_type].CompletedSections[chapterId] = {}
                end
                storyComponent.StoryChapters[pbMsg.level_type].CompletedSections[chapterId].CompletedId = lastestId
                storyComponent.StoryChapters[pbMsg.level_type].CompletedSections[chapterId].StoryLevelScoreInfoList = StoryLevelScoreInfoList
            end
            if pbMsg.unlocked_groups ~= nil then
                storyComponent.StoryChapters[pbMsg.level_type].unlockedGroups = pbMsg.unlocked_groups
            end
            UIPublic.UnlockCGEncyclopedia(levelId)
            DataManager:GetInstance() :Broadcast(DataMessageNames.ON_MAIN_STORY_CHG, {})
        elseif levelType == LevelType.LevelTypeChallenge then
            local CommonLevelComponent = Game.Scene.Player:GetComponent("CommonLevelComponent")
            local challengeInfo = Z_Challenge[levelId]
            local thisChallengeInfo = CommonLevelComponent.CommonLevels[LevelType.LevelTypeChallenge][challengeInfo.TypeId]
            for _, value in ipairs(thisChallengeInfo) do
                if value.id == levelId then
                    value.passTimes = levelInfo.pass_times
                    value.firstDropAvailable = levelInfo.first_drop_available
                    value.firstPerfectDropAvailable = levelInfo.first_perfect_drop_available
                    value.reached_goals = levelInfo.reached_goals
                    value.isLocked = false
                end
            end

            for _, value in pairs(Z_Challenge) do
                if value.UnlockCondition == levelId and levelInfo.pass_times > 0 then
                    for _, v in ipairs(thisChallengeInfo) do
                        if v.id == value.Id then
                            v.isLocked = false
                        end
                    end
                end
            end
        elseif levelType == LevelType.LevelTypeSevenStar then
            local sevenStarComponent = Game.Scene.Player:GetComponent("SevenStarComponent")
            local sevenStarInfo = Z_SevenStar[levelId]
            local thisSevenStarInfo = sevenStarComponent.Days[sevenStarInfo.TypeId][sevenStarInfo.Day][sevenStarInfo.Diff]
            thisSevenStarInfo.PassTimes = levelInfo.pass_times
            thisSevenStarInfo.IsUnlock = true
            thisSevenStarInfo.reached_goals = levelInfo.reached_goals
            for _, value in pairs(Z_SevenStar) do
                if value.UnlockCondition == levelId and levelInfo.pass_times > 0 then
                    sevenStarComponent.Days[value.TypeId][value.Day][value.Diff].IsUnlock = true
                end
            end
        elseif levelType == LevelType.LevelTypeMonthlyTower then
            local CommonLevelComponent = Game.Scene.Player:GetComponent("CommonLevelComponent")
            local thisChallengeInfo = CommonLevelComponent.CommonLevels[LevelType.LevelTypeMonthlyTower]
            for _, value in ipairs(thisChallengeInfo) do
                if value.id == levelId then
                    value.passTimes = levelInfo.pass_times
                    value.firstDropAvailable = levelInfo.first_drop_available
                    value.firstPerfectDropAvailable = levelInfo.first_perfect_drop_available
                    value.reached_goals = levelInfo.reached_goals
                    value.isLocked = false
                end
            end

            for _, value in pairs(Z_MonthlyTowerLevel) do
                if value.UnlockCondition == levelId and levelInfo.first_drop_available == false then
                    for _, v in ipairs(thisChallengeInfo) do
                        if v.id == value.Id then
                            v.isLocked = false
                        end
                    end
                end
            end
            
        elseif levelType == LevelType.LevelTypeTower then
            local CommonLevelComponent = Game.Scene.Player:GetComponent("CommonLevelComponent")
            local thisChallengeInfo = CommonLevelComponent.CommonLevels[LevelType.LevelTypeTower]
            for _, value in ipairs(thisChallengeInfo) do
                if value.id == levelId then
                    value.passTimes = levelInfo.pass_times
                    value.firstDropAvailable = levelInfo.first_drop_available
                    value.firstPerfectDropAvailable = levelInfo.first_perfect_drop_available
                    value.reached_goals = levelInfo.reached_goals
                    value.isLocked = false
                end
            end

            for _, value in pairs(Z_LordTower) do
                if value.UnlockCondition == levelId and levelInfo.pass_times > 0 then
                    for _, v in ipairs(thisChallengeInfo) do
                        if v.id == value.Id then
                            v.isLocked = false
                        end
                    end
                end
            end
        end

        
        --LAUNCHATK_BLUR
    end)
end

return LevelUpdatePush