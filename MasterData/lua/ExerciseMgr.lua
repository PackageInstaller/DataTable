
local ExerciseInfo = require "ExerciseInfo"
local this = MgrRegister("ExerciseMgr")

function this:Clear()
    self.info = {} -- 演习界面、个人信息
    self.objs = {} -- 模拟敌人信息
    self.rankInfos = {} -- 排行榜信息
    self.teamInfos = {} -- 排行榜队伍信息
    self.army_ix = 1
    self.fightBaseLogs = {}

    self.cur_rank = 0
    self.addCoin = 0
    self.addRankNum = 0
    self.isRankLevelUp = false
    self.delay = false
    self.isRankUp = false

    self.isOpen = false
    self._newSeasonData = nil
    self._isCheckNewJoinCnt = false
    self._isNewJoinCnt = false
    self._newJoinCntTime = nil

    self.isInit = false
end

function this:Init()
    self:Clear()

    -- 请求 infos
    self:GetPracticeInfo(true, false)
end

-- 是否已初始化
function this:CheckIsInit()
    return self.isInit
end

-- 敌人
function this:GetEnemy()
    local _datas = {}
    for k, v in ipairs(self.objs) do
        local info = ExerciseInfo.New()
        info:InitData(v)
        table.insert(_datas, info)
    end

    return _datas
end

-- 单个敌人信息
function this:GetEnemyInfo(uid)
    for i, v in ipairs(self.objs) do
        if (v.uid == uid) then
            return v
        end
    end
end

function this:UpdateEnemyInfo(proto)
    for i, v in ipairs(self.objs) do
        if (v.uid == proto.uid) then
            v.performance = proto.team.performance
            --
            if (proto.info) then
                for p, q in pairs(proto.info) do
                    v[p] = q
                end
            end
        end
    end
end

-- 挑战次数下次刷新时间
function this:GetNextTime()
    --     local tab = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
    --     local curHour = tab.hour
    --     local cnts = g_ArmyPracticeJoinCntFlushTime
    --    --table.insert(cnts, 24)
    --     local index = 1
    --     while curHour >= cnts[index] do
    --         index = index + 1
    --     end
    --     local nextTime = TimeUtil:GetTime2(tab.year, tab.month, tab.day, cnts[index], tab.min, tab.sec)
    --     return nextTime + 1

    return self.info.t_join_cnt or (TimeUtil:GetTime() + 1000)
end

-- 赛季结束时间
function this:GetEndTime()
    return self.info.end_time or 0
end

-- 赛季开始时间
function this:GetStartTime()
    return self.info.start_time or 0
end

-- 是不是休赛期
function this:IsLeisureTime()
    local curTime = TimeUtil:GetTime()
    if (curTime >= self:GetStartTime() and curTime < self:GetEndTime()) then
        return false
    end
    return true
end

-- 下次刷新时间
function this:GetRefreshTime()
    local isExerciseLOpen = MenuMgr:CheckModelOpen(OpenViewType.main, "ExerciseLView")
    if (isExerciseLOpen) then
        if (not self:IsLeisureTime()) then
            return self:GetEndTime()
        end
    end
    return nil
end

----------------------------------------新赛季new------------------------------------
-- 演习 new 
function this:IsExerciseLNew()
    if (not self:IsOpen()) then
        return false
    end
    if (self:IsNewJoinCnt()) then
        return true
    end
    if (self:IsNewSeason()) then
        return true
    end
    return false
end

-- 演习系统是否已开启
function this:IsOpen()
    if (not self.isOpen) then
        local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "ExerciseLView")
        self.isOpen = isOpen
    end
    return self.isOpen
end

function this:CheckNewSeason()
    local num = self:IsNewSeason() and 1 or nil
    RedPointMgr:UpdateData(RedPointType.ExerciseL, num)
    EventMgr.Dispatch(EventType.ExerciseL_New)
end

-- 是否是新赛季（新赛季New,进入界面后消失）
function this:IsNewSeason()
    if (not self:IsLeisureTime()) then
        local key = string.format("%s_IsNewSeason.txt", PlayerClient:GetID())
        if (not self._newSeasonData) then
            self._newSeasonData = FileUtil.LoadByPath(key)
            if (not self._newSeasonData) then
                local data = {}
                data[1] = self:GetEndTime()
                data[2] = 1 -- 1:未看 2：已看
                self._newSeasonData = data
                FileUtil.SaveToFile(key, data)
            end
        end
        if (self._newSeasonData) then
            -- 对比，是否已查看 1:未查看 2：已查看但赛季不同
            if (self._newSeasonData[2] == 1 or self._newSeasonData[1] ~= self:GetEndTime()) then
                return true
            end
        end
    end
    return false
end
-- 本赛季已打开过界面
function this:SetNewSeason()
    local data = {}
    data[1] = self:GetEndTime()
    data[2] = 2 -- 1:未看 2：已看
    self._newSeasonData = data
    local key = string.format("%s_IsNewSeason.txt", PlayerClient:GetID())
    FileUtil.SaveToFile(key, data)
    self:CheckNewSeason()
end

----------------------------------------新赛季new------------------------------------

----------------------------------------演习次数刷新------------------------------

-- 时间大于下次参加次数刷新的时间，且未进入过演习界面推送new ，如果此时就在演习界面，则直接弹出提示，不显示new 
-- 进入界面会请求个人数据，那么可以重置为未进入过界面的状态
function this:CheckNewJoinCnt()
    if (self._isNewJoinCnt) then
        return
    end
    if (not self._newJoinCntTime) then
        local key = string.format("%s_CheckNewJoinCnt.txt", PlayerClient:GetID())
        self._newJoinCntTime = FileUtil.LoadByPath(key)
        if (not self._newJoinCntTime) then
            local data = {}
            data[1] = self:GetNextTime() - 1
            self._newJoinCntTime = data
            self._isNewJoinCnt = true
            FileUtil.SaveToFile(key, data)
        end
    end

    if (not self._isCheckNewJoinCnt and self:GetNextTime() > self._newJoinCntTime[1] and TimeUtil:GetTime() >
        self:GetNextTime()) then
        self._isCheckNewJoinCnt = true

        if (CSAPI.IsViewOpen("ExerciseLView")) then
            self._isNewJoinCnt = false
            -- 直接弹出提示 由界面播放
        else
            self._isNewJoinCnt = true
            EventMgr.Dispatch(EventType.ExerciseL_New)
        end
    end
end
function this:IsNewJoinCnt()
    return self._isNewJoinCnt
end
-- 已打开过界面
function this:SetNewJoinCnt()
    local key = string.format("%s_CheckNewJoinCnt.txt", PlayerClient:GetID())
    local data = {}
    data[1] = self:GetNextTime()
    self._newJoinCntTime = data
    FileUtil.SaveToFile(key, data)

    self._isCheckNewJoinCnt = false
    self._isNewJoinCnt = false
    EventMgr.Dispatch(EventType.ExerciseL_New)
end

-------------------------------演习次数刷新------------------------------
-- 自己的数据
function this:GetInfo()
    return self.info
end

-- 已购买次数
function this:GetCanBuy()
    local cnt = self.info.can_join_buy_cnt or 0
    return cnt, g_ArmyAttackBuyCnt
end

-- 可以参加的次数
function this:GetJoinCnt()
    local cnt = self.info.can_join_cnt or 0
    return cnt, g_ArmyPracticeJoinCnt
end
-- 已刷新次数
function this:GetFlushCnt()
    local cnt = self.info.flush_cnt or 0
    return cnt, g_ArmyPracticeFlushMax
end

function this:SetFlushCnt(cnt)
    self.info.flush_cnt = cnt
end
-- 段位
function this:GetRankLevel()
    return self.info.rank_level or 1
end
function this:GetDwName()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(self:GetRankLevel())
    return cfg.name or ""
end

-- 段位图标
function this:GetDwIcon()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(self:GetRankLevel())
    return cfg.icon or ""
end

-- 排名
function this:GetRank()
    return self.info.rank or 0
end
function this:GetRankStr()
    return self:GetRank() == 0 and "--" or (self.info.rank .. "")
end
-- 最高排名
function this:GetMaxRank()
    return self.info and self.info.max_rank or 0
end

function this:GetMaxRankLevel()
    return self.info and self.info.max_rank_level or 0
end

-- 最高段位
function this:GetMaxDwName()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(self:GetMaxRankLevel())
    return cfg and cfg.name or "--"
end

-- 积分
function this:GetScore()
    return self.info.score or 0
end

-- 一些新信息
function this:GetNewChange()
    local _addRankNum, _isRankLevelUp, _addCoin = 0, false, 0

    _addRankNum = self.addRankNum
    self.addRankNum = 0

    _isRankLevelUp = self.isRankLevelUp
    self.isRankLevelUp = false

    _addCoin = self.addCoin
    self.addCoin = 0

    return {_addRankNum, _isRankLevelUp, _addCoin}
end

-- 退出战斗，返回演习界面
function this:Quit(armyType)
    SceneLoader:Load("MajorCity", function()
        self:OnQuit(armyType)
    end)
end

function this:OnQuit(armyType)
    CSAPI.OpenView("Section", {
        type = 3
    })
    CSAPI.OpenView("ExerciseLView")
end

function this:GetRankInfos()
    -- local arr = {}
    -- for i, v in pairs(self.rankInfos) do
    --     table.insert(arr, v)
    -- end
    -- if (#arr > 0) then
    --     table.sort(arr, function(a, b)
    --         return a:GetRank() < b:GetRank()
    --     end)
    -- end
    -- self.cur_rank = #arr
    -- return arr
end

function this:AddNextRankList()
    self.cur_rank = self.cur_rank or 0
    self.max_rank = self.max_rank or g_ArmyRankNumMax
    if (self.cur_rank < (self.max_rank - 1)) then
        local max = self.cur_rank + 10 > self.max_rank and self.max_rank or self.cur_rank + 10
        self:GetPracticeList(self.cur_rank + 1, max)
    end
end

-- 清空演习排行榜缓存数据
function this:ClearRankData()
    -- if (not self.clearTime) then
    --     self.clearTime = Time.time + 1800
    -- else
    --     if (Time.time > self.clearTime) then
    --         self.cur_rank = 0
    --         self.rankInfos = 0
    --         self.clearTime = Time.time + 1800
    --     end
    -- end

    self.cur_rank = 0
    -- self.rankInfos = {}
end

-- --当前邀请或接受邀请的好友
-- function this:GetYqUid()
-- 	return self.YqUid
-- end
function this:GetYqTeam()
    return self.YqTeam
end

-- -- 获取对手卡牌数据
-- function this:GetData(cid)
--     return self.armyCardDatas[cid]
-- end

-- -- 下一级是否是最高段位
-- function this:NextIsMaxLevel(lv)
--     local cfg = Cfgs.CfgPracticeRankLevel:GetByID(lv + 1)
--     return cfg == nil
-- end

-- -- 排行榜队伍信息
-- function this:GetTeanInfo(uid)
--     return self.teamInfos[uid]
-- end

-----------------------------------------------协议------------------------

-- 获取军演信息
function this:GetPracticeInfo(_selfInfo, _listInfo)
    local proto = {"ArmyProto:GetPracticeInfo", {
        selfInfo = _selfInfo,
        listInfo = _listInfo
    }}
    NetMgr.net:Send(proto)
end

-- 获取军演信息
function this:GetPracticeInfoRet(proto)
    if (proto) then
        self.army_ix = proto.army_ix
        self.fightBaseLogs = proto.fightBaseLogs
        if (proto.selfInfo) then
            self.info = proto.info or {}
            EventMgr.Dispatch(EventType.Exercise_Update)
        end
        if (proto.listInfo) then
            self.objs = proto.objs
            EventMgr.Dispatch(EventType.Exercise_Enemy_Update)
        end

        self.isInit = true
    end
end

-- 刷新对手
function this:FlushPracticeObj()
    local proto = {"ArmyProto:FlushPracticeObj"}
    NetMgr.net:Send(proto)
end
-- 刷新对手
function this:FlushPracticeObjRet(proto)
    if (proto) then
        self.objs = proto.objs
        self:SetFlushCnt(proto.flush_cnt)
        EventMgr.Dispatch(EventType.Exercise_Enemy_Update)
    end
end

-- 查看卡牌信息  
function this:GetPracticeOtherTeam(_uid, _is_robot)
    local proto = {"ArmyProto:GetPracticeOtherTeam", {
        uid = _uid,
        is_robot = _is_robot
    }}
    NetMgr.net:Send(proto)
end
-- 查看对手卡牌信息
function this:GetPracticeOtherTeamRet(proto)
    if (proto) then
        -- 更新战斗力
        self:UpdateEnemyInfo(proto)
        EventMgr.Dispatch(EventType.Exercise_Enemy_Info, proto)
    end
end

-- 请求排名
function this:GetPracticeList(_beg_rank, _end_rank)
    local proto = {"ArmyProto:GetPracticeList", {
        beg_rank = _beg_rank,
        end_rank = _end_rank
    }}
    NetMgr.net:Send(proto)
end
function this:GetPracticeListRet(proto)
    if (proto) then
        self.max_rank = proto.max_rank or 0
        -- if (proto.objs and #proto.objs > 0) then
        --     for i, v in pairs(proto.objs) do
        --         local info = ExerciseInfo.New()
        --         info:InitData(v)
        --         if (info:GetRank() ~= 0) then
        --             self.rankInfos[info:GetRank()] = info
        --         end
        --     end
        -- end
        --通用排行榜信息
        local infos = {}
        infos.rank_type = eRankId.Exercise
        infos.rank = proto.max_rank or 0
        infos.score = self:GetScore()
        infos.data = proto.objs
        infos.next_refresh_time = proto.tNextFlush
        RankMgr:GetRankRet(infos)
        -- 队伍信息
        if (proto.teamInfos and #proto.teamInfos > 0) then
            for i, v in ipairs(proto.teamInfos) do
                self.teamInfos[v.uid] = v
            end
        end
        EventMgr.Dispatch(EventType.Exercise_Rank_Info)
    end
end

-- 封装自己的排行榜数据
function this:SetMyRankData()
    local _data = {}
    _data.id = PlayerClient:GetUid()
    _data.name = PlayerClient:GetName()
    _data.level = PlayerClient:GetLv()
    _data.rank_level = self:GetRankLevel()
    _data.rank = self:GetRank()
    _data.performance = self.info and self.info.performance or 0
    _data.score = self:GetScore()
    _data.icon_id = PlayerClient:GetIconId()
    _data.is_robot = false
    local info = ExerciseInfo.New()
    info:InitData(_data)
    return info
end

-- 封装自己的排行榜数据
function this:GetHistoryData(_data)
    local info = ExerciseInfo.New()
    info:InitData(_data)
    return info
end

-- 结果 演习
function this:PracticeInfoUpdate(proto)
    local score = proto.info.score - self.info.score
    -- local _oldInfo = {}
    -- table.copy(self.info, _oldInfo)
    -- self.info = proto.info
    -- self.addCoin = proto.coin
    -- local data = {bIsWin = proto.bIsWin, oldInfo = _oldInfo, result = proto, armyType = RealArmyType.Mirror}
    -- FightActionMgr:Push(FightActionMgr:Apply(FightActionType.FightEnd, data))
    --
    -- 是否有升段位
    if (proto.info.max_rank_level > self.info.max_rank_level) then
        self.isRankLevelUp = true
    else
        self.isRankLevelUp = false
    end
    -- 是否刷新最高排名
    if (proto.info.max_rank and proto.info.max_rank ~= 0 and proto.info.max_rank < self.info.max_rank) then
        self.addRankNum = self.info.max_rank - proto.info.max_rank
    else
        self.addRankNum = 0
    end

    -- 排名提升
    if (proto.info.rank and proto.info.rank ~= 0 and proto.info.rank < self.info.rank) then
        self.isRankUp = true
    else
        self.isRankUp = false
    end

    self.info = proto.info or {}
    self.addCoin = proto.coin

    FightOverTool.PracticeInfoUpdate(proto, score)
end

function this:IsRankUp()
    return self.isRankUp
end

-- -- 获取旧等级，积分 
-- function this:GetOldInfo(jf)
--     local lv = self:GetRankLevel()
--     local cur = self:GetScore() - jf
--     if (cur < 0) then
--         lv = self:GetRankLevel() - 1
--         local cfg = Cfgs.CfgPracticeRankLevel:GetByID(lv)
--         cur = cfg.nScore + cur
--     end
--     return lv, cur
-- end

-- 购买军演次数返回
function this:BuyAttackCntRet(proto)
    if (self.info) then
        self.info.can_join_buy_cnt = proto.can_join_buy_cnt
        self.info.can_join_cnt = proto.can_join_cnt
        EventMgr.Dispatch(EventType.ExerciseL_BuyCount)
    end
end

-- 战绩简单信息 
-- {
--     {对方uid, 对方名称, 对方是否胜利},
--     {对方uid, 对方名称, 对方是否胜利},
-- }
function this:GetFightBaseLogs()
    return self.fightBaseLogs or {}
end

function this:SetRolePanelRet(_role_panel_id, _live2d)
    self.info.role_panel_id = _role_panel_id
    self.info.live2d = _live2d
    -- EventMgr.Dispatch(EventType.Exercise_Role_Panel)
end

function this:GetRolePanel()
    local modelID = self.info.role_panel_id or PlayerClient:GetIconId()
    local isLive2D = self.info.live2d or false
    return modelID, isLive2D
end



return this
