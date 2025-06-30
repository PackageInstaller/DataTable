---

---七星进度数据

local SevenStarComponent = BaseClass("SevenStarComponent",Component)
local base = Component
local selectType = 1 --七星副本使用
local selectDay = 1 --七星副本使用

local function Awake(self)
    base.Awake(self)
    self.Days={}
    self.Profession = {}
    --self.ServerDay = TimeUtil.GetServerTimeSplitData().wday
    if TimeUtil.GetServerTimeSplitData().wday == 1 then
        self.ServerDay = 7
    else
        self.ServerDay = TimeUtil.GetServerTimeSplitData().wday - 1
    end
end

local function CoLoadData(self)
    -- local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
    --         OuterOpcode.Name2Code.ETModel_C2M_SevenStarInfo, {})
    -- if info.Error == ErrorCode.ERR_Success then
    --     self:SetData(info)
    --     self.ServerDay = info.Week
    -- else
    --     Logger.LogError("ETModel_C2M_SevenStarInfo:"..info.Error)
    -- end
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            PROTOCOL.LevelPackReq, {
                types = {
                    LevelType.LevelTypeSevenStar
                }
            })
    self:SetData(info)
    return coroutine.yieldbreak(info)
end

local function SetData(self,data)
    -- self.Days[1]= data.Day1
    -- self.Days[2]= data.Day2
    -- self.Days[3]= data.Day3
    -- self.Days[4]= data.Day4
    -- self.Days[5]= data.Day5
    -- self.Days[6]= data.Day6
    -- self.Days[7]= data.Day7
    ---每个day包含
    --OpenDiff  开放难度
    --OpenTime  开放时间
    --Diff1Num  难度1已进入次数,
    --Diff2Num  难度2已进入次数,
    --Diff3Num  难度3已进入次数,
    --Diff4Num  难度4已进入次数,
    self.Days[1] = {} --1为属性
    self.Days[2] = {} --2为职业
    for i = 1, 8 do
        self.Days[1][i] = {}
        for j = 1, 4 do
            self.Days[1][i][j] = {}
        end
    end

    for i = 1, 6 do
        self.Days[2][i] = {}
        for j = 1, 4 do
            self.Days[2][i][j] = {}
        end
    end

    for i = 1, 8 do
        for _, value in pairs(Z_SevenStar) do
            if value.Day == i then
                local levelInfo = Z_SevenStar[value.Id]
                self.Days[levelInfo.TypeId][levelInfo.Day][levelInfo.Diff]=
                {
                    OpenDiff = levelInfo.Diff,
                    BoostDate = levelInfo.BoostDate,
                    Name = levelInfo.Name,
                    LevelId = levelInfo.Id,
                    PassTimes = 0,
                    IsUnlock = levelInfo.UnlockCondition == 0,
                    reached_goals = {}
                }
            end
        end
    end

    for _, value in ipairs(data.level_packs[1].levels) do
        local levelID = value.id
        local levelInfo = Z_SevenStar[levelID]
        if value.pass_times > 0 then
            self.Days[levelInfo.TypeId][levelInfo.Day][levelInfo.Diff].PassTimes = value.pass_times
            self.Days[levelInfo.TypeId][levelInfo.Day][levelInfo.Diff].IsUnlock = true
            self.Days[levelInfo.TypeId][levelInfo.Day][levelInfo.Diff].reached_goals = value.reached_goals
        end
        if levelInfo.UnlockCondition == nil then
            self.Days[levelInfo.TypeId][levelInfo.Day][levelInfo.Diff].IsUnlock = true
        end
        for _, sevenStarInfo in pairs(Z_SevenStar) do
            if levelID == sevenStarInfo.UnlockCondition and value.pass_times > 0 then
                self.Days[sevenStarInfo.TypeId][sevenStarInfo.Day][sevenStarInfo.Diff].IsUnlock = true
            end
        end
    end

    
    
    -- for _, value in ipairs(data.level_packs[1].levels) do
    --     local levelID = value.id
    --     local levelInfo = Z_SevenStar[levelID]
    --     if value.pass_times > 0 and levelInfo.Diff > self.Days[levelInfo.TypeId][levelInfo.Day].OpenDiff then
    --         self.Days[levelInfo.TypeId][levelInfo.Day].OpenDiff = levelInfo.Diff
    --     end
    -- end
end

local function Dispose(self)
    base.Dispose(self)
end
SevenStarComponent.Awake = Awake
SevenStarComponent.Dispose = Dispose
SevenStarComponent.SetData=SetData
SevenStarComponent.CoLoadData=CoLoadData
return SevenStarComponent