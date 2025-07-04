---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/4 15:00
---剧情进度数据
---@class StoryComponent
---@field StoryChapters {CompletedSections:{CompletedId:number, StoryLevelScoreInfoList:protocol.Level[]}[], LevelType:number, unlockedGroups:number[]}[]
local StoryComponent = BaseClass("StoryComponent",Component);
local base = Component

local function Awake(self)
    base.Awake(self)
    self.CompletedTestId = nil
    
    self.CompletedLordRoad = nil

    self.TowerA = nil
    self.TowerB = nil
    self.TowerC = nil
    self.TowerD = nil
    self.TowerHistoryA = nil
    self.TowerHistoryB = nil
    self.TowerHistoryC = nil
    self.TowerHistoryD = nil

    self.CompletedLordLandLayer = nil
    
    self.StoryChapters = {}
    self.AllStoryScores = {}
    
    self.LordRoadLevelScores = {}
    self.level_packs = {}
end

---@param self StoryComponent
local function CoLoadData(self)
    ----------------------------------2023新版关卡系统----------------------------------------
    local g2CStoryInfo = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
    PROTOCOL.LevelPackReq, {
        types = {
            LevelType.LevelTypeStory,
            LevelType.LevelTypeGameEvent,
        }
    })
    
    self.StoryChapters[LevelType.LevelTypeStory] = {
        CompletedSections = {},
        LevelType = LevelType.LevelTypeStory,
        unlockedGroups = {},
    }
    self.StoryChapters[LevelType.LevelTypeGameEvent] = {
        CompletedSections = {},
        LevelType = LevelType.LevelTypeGameEvent,
        unlockedGroups = {},
    }


    if g2CStoryInfo.level_packs ~= nil then
        self.level_packs = g2CStoryInfo.level_packs
        for i, v in pairs(g2CStoryInfo.level_packs) do
            if v.level_type == LevelType.LevelTypeStory or v.level_type == LevelType.LevelTypeGameEvent then
                self.StoryChapters[v.level_type].unlockedGroups = v.unlocked_groups
                for j, levelInfo in pairs(v.levels) do
                    local levelId = levelInfo.id
                    local chapterId
                    if v.level_type == LevelType.LevelTypeStory then
                        local levelData =  Z_StorySection[levelId]
                        if levelData ~= nil then
                            chapterId = levelData.ChapterId
                        end
                    else
                        local levelData = Z_GameEventsLevel[levelId]
                        if levelData ~= nil then
                            chapterId = levelData.ChapterId
                        end
                    end
                    if chapterId ~= nil then
                        if self.StoryChapters[v.level_type].CompletedSections[chapterId] == nil then
                            self.StoryChapters[v.level_type].CompletedSections[chapterId] = {}
                            self.StoryChapters[v.level_type].CompletedSections[chapterId].CompletedId = levelId
                        end
                        if self.StoryChapters[v.level_type].CompletedSections[chapterId].CompletedId < levelId and levelInfo.pass_times > 0 then
                            self.StoryChapters[v.level_type].CompletedSections[chapterId].CompletedId = levelId
                        end
                        -- if v.level_type == LevelType.LevelTypeStory then
                            self:AddStoryLevelScore(chapterId, Game.Registry:NewObject("StoryLevelScore", levelInfo, v.level_type))
                        -- end
                        if self.StoryChapters[v.level_type].CompletedSections[chapterId].StoryLevelScoreInfoList == nil then
                            self.StoryChapters[v.level_type].CompletedSections[chapterId].StoryLevelScoreInfoList = {}
                        end
                        self.StoryChapters[v.level_type].CompletedSections[chapterId].StoryLevelScoreInfoList[levelId] = levelInfo
                    end
                end
            end
        end
    end

    return coroutine.yieldbreak(g2CStoryInfo)
end

function StoryComponent:GetLevelInfo(levelType, levelId)
    local chapterId = nil
    
    if levelType == LevelType.LevelTypeStory then
        local levelData =  Z_StorySection[levelId]
        if levelData ~= nil then
            chapterId = levelData.ChapterId
        end
    elseif levelType == LevelType.LevelTypeGameEvent then
        local levelData = Z_GameEventsLevel[levelId]
        if levelData ~= nil then
            chapterId = levelData.ChapterId
        end
    else
        return nil
    end

    if chapterId == nil then
        return nil
    end
    if self.StoryChapters[levelType] == nil then
        return nil
    end
    if self.StoryChapters[levelType].CompletedSections[chapterId] == nil then
        return nil
    end
    return self.StoryChapters[levelType].CompletedSections[chapterId].StoryLevelScoreInfoList[levelId]
end

local function CoLoadRoadData(self)
    ---帝王之路进度数据
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_LordInfo, {})
    if info and info.Error == ErrorCode.ERR_Success then
        local data= info
        self.CompletedLordRoad = data.CompletedRoad
        self.TowerA = data.TowerA
        self.TowerB = data.TowerB
        self.TowerC = data.TowerC
        self.TowerD = data.TowerD
        self.TowerHistoryA = data.TowerHistoryA
        self.TowerHistoryB = data.TowerHistoryB
        self.TowerHistoryC = data.TowerHistoryC
        self.TowerHistoryD = data.TowerHistoryD
        self.CompletedLordLandLayer = data.CompletedLand
    else
        Logger.LogError("ETModel_C2M_LordInfo:"..info.Error)
    end
    return coroutine.yieldbreak(info)
end

function StoryComponent:CheckLevelIsUnlock(levelType, levelId)
    local groupId = 0
    if levelType == LevelType.LevelTypeStory then
        groupId = Z_StorySection[levelId].Group
    elseif levelType == LevelType.LevelTypeGameEvent then
        groupId = Z_GameEventsLevel[levelId].Group
    end

    if table.contains(self.StoryChapters[levelType].unlockedGroups, groupId) then
        return true
    end
    return false
end


local function GetCompletedSection(self, ChapterId, levelType)
    if levelType == nil then
        levelType = LevelType.LevelTypeStory
    end

    local storyChapter = self.StoryChapters[levelType]
    if storyChapter == nil then
        return {0, 0, 0, 0}
    end
    if storyChapter.CompletedSections == nil then
        return {0, 0, 0, 0}
    end
    local sections = {0, 0, 0, 0}
    if storyChapter.CompletedSections[ChapterId] ~= nil then
        for Id, Info in pairs(storyChapter.CompletedSections[ChapterId].StoryLevelScoreInfoList) do
            local storyInfo = Z_StorySection[Id]
            if storyInfo == nil then storyInfo = Z_GameEventsLevel[Id] end
            if  Info.pass_times > 0 and Id > sections[storyInfo.Difficulty] then
                sections[storyInfo.Difficulty] = Id
            end
        end
    end
    
    return sections
end

function StoryComponent:HasCompletedSections(ChapterId, LevelType)
    if levelType == nil then
        levelType = LevelType.LevelTypeStory
    end

    local storyChapter = self.StoryChapters[levelType]
    if storyChapter == nil then
        return false
    end
    if storyChapter.CompletedSections == nil then
        return false
    end
    if storyChapter.CompletedSections[ChapterId] ~= nil then
        for Id, Info in pairs(storyChapter.CompletedSections[ChapterId].StoryLevelScoreInfoList) do
            local storyInfo = Z_StorySection[Id]
            if storyInfo == nil then storyInfo = Z_GameEventsLevel[Id] end
            if  Info.pass_times > 0 then
                return true
            end
        end
    end

    return false
end


local function GetLevelScores(self, chapterId)
    if self.AllStoryScores[chapterId] == nil then
        return {}
    end
    return self.AllStoryScores[chapterId]
end

local function AddStoryLevelScore(self, chapterId, storyLevelScore)
    if self.AllStoryScores[chapterId] == nil then
        self.AllStoryScores[chapterId] = {}
    end
    if storyLevelScore.LevelId == nil then
        return
    end
    if storyLevelScore.Difficulty ~= nil then
        self.AllStoryScores[chapterId][storyLevelScore.LevelId] = storyLevelScore
    end
end

local function AddLordRoadLevelScore(self,lordRoadLevelScore)
    if self.LordRoadLevelScores[lordRoadLevelScore.LevelId] == nil then
        self.LordRoadLevelScores[lordRoadLevelScore.LevelId] = {}
    end
    self.LordRoadLevelScores[lordRoadLevelScore.LevelId]=lordRoadLevelScore
end

--速通
local function SendFastPass(self, sendFastData,func)
    local player = Game.Scene.Player
    --时间旅券
    local item = table.first(Game.Scene.Player:GetComponent("ItemComponent").Items,function(v) return v.TemplateId == 3013 end)
   
    local tipData={}
    tipData.title = LangUtil.GetSysLang(9)--"提示"
    tipData.type = 3
    --local message = string.gsub( LangUtil.GetSysLang(1095),"X",item)
    tipData.message = item == nil and LangUtil.GetSysLang(735) or LangUtil.GetSysLang(1096)--{string.gsub(LangUtil.GetSysLang(1096),"X",Z_Item[item.TemplateId].Name)} )[1]
    tipData.TemplateId = 3013
    tipData.ExpenseNum = 1  --需要消耗一张
    tipData.Amount = item and item.Amount or 0 --(item~=nil and {item.Amount} or {1})[1]
    tipData.Energy = sendFastData.Energy
    tipData.maxNum = sendFastData.maxNum
    tipData.But1 = function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipFirstPlus)
    end
    tipData.But2 = function(ItemNUm)
        if item ==nil then
            UIManager:GetInstance():CloseWindow(UIWindowNames[sendFastData.info])
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIGeneralShop)
        else
            ----喵动
            --local item1 = table.first(Game.Scene.Player:GetComponent("ItemComponent").Items,function(v) return v.TemplateId == 3001 end)
            if sendFastData.Energy > player.Energy then --player.Energy

                --local tipData1 = {}
                --local zItem= Z_Item[3001]
                --local num =(item1 == nil and {0} or{1})[1]
                --tipData1.title = LangUtil.GetSysLang(9)--"提示"
                --tipData1.type=4
                --tipData1.item = item1
                --
                --local str = string.gsub(LangUtil.GetSysLang(798),"XX",zItem.Name)
                --str = string.gsub(str,"Y",num)
                --tipData1.message = (player.Energy + num * 50  >= 9999 and {LangUtil.GetSysLang(1092)} or { str })[1]
                --tipData1.AddNum = num * 50
                --tipData1.But1 = function()
                --    UIManager:GetInstance():CloseWindow(UIWindowNames[sendFastData.info])
                --    UIManager:GetInstance():OpenWindow(UIWindowNames.UIRoom)
                --end
                --tipData1.But2 = function(curNum)
                --    if item1 == nil then
                --        UIManager:GetInstance():CloseWindow(UIWindowNames[sendFastData.info])
                --        UIManager:GetInstance():OpenWindow(UIWindowNames.UIGeneralShop)
                --    else
                --        Game.Scene.Player:GetComponent("ItemComponent"):SendUseRequest(3001,curNum)
                --        --self.ctrl:SendUseRequest(templateId,curNum)
                --    end
                --end
                --UIUtil.ToolTipFirstPlus(tipData1)
                UIUtil.ToolTipFourth(LangUtil.GetSysLang(1022));--"体力不足"
                return
            end
            --Game.Scene.Player:GetComponent("ItemComponent"):SendUseRequest(3013,ItemNUm)
            if func then
                func(ItemNUm)
            end
        end
    end
    UIUtil.ToolTipFirstPlus(tipData)
end

local function ActiveStoryIsOpen(self, activityType, type)--活动物语、是否开启
    -- gh: 之前是通过活动component获取    
    return nil
end

local function Dispose(self)
    base.Dispose(self)
end

StoryComponent.Awake = Awake
StoryComponent.AddStoryLevelScore = AddStoryLevelScore
StoryComponent.AddLordRoadLevelScore = AddLordRoadLevelScore
StoryComponent.Dispose = Dispose
StoryComponent.SendFastPass = SendFastPass
StoryComponent.CoLoadData=CoLoadData
StoryComponent.GetCompletedSection=GetCompletedSection
StoryComponent.GetLevelScores=GetLevelScores
StoryComponent.CoLoadRoadData = CoLoadRoadData
StoryComponent.ActiveStoryIsOpen = ActiveStoryIsOpen

return StoryComponent