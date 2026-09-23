TowerMgr = MgrRegister("TowerMgr")
local this = TowerMgr;

function this:Init()
    self:Clear()
    PlayerProto:GetNewTowerResetCnt()
    PlayerProto:GetNewTowerCardInfo()
    FightProto:GetTowerDeepInfo()
    PlayerProto:GetEternalBattleCardInfo()
end

function this:Clear()
    self.datas = {}
    self.reset_cnt = {}
    self.cardInfos = {}
    self.assits = nil
    self.sectionId = nil
    self.towerRewardData = nil
    self.towerSids = nil
    -- deep
    self.deepDataList = {}
    self.newDeepDupId = 0
    self.deepUseCardTags = {}
    self.deepTotalScore = 0

    self.cardCache = nil
end
------------------------------------碎星虚影------------------------------------
-- 每周关卡开启状态
function this:IsTowerOpen(id)
    local cfg = Cfgs.MainLine:GetByID(id)
    if (cfg and cfg.nStartTime and cfg.nEndTime) then
        local _startTime = GCalHelp:GetTimeStampBySplit(cfg.nStartTime)
        local _endTime = GCalHelp:GetTimeStampBySplit(cfg.nEndTime)
        if (TimeUtil:GetTime() >= _startTime and TimeUtil:GetTime() < _endTime) then
            return true
        end
    else
        return true
    end
    return false
end

-- 更新塔数据
function this:UpdateTowerData(proto)
    local data = nil
    if proto then
        data = {}
        data.resetTime = proto.nTowerResetTime or -1
        data.max = proto.nTowerCeiling or 0
        data.baseCur = proto.nTowerCurrent or 0
        data.cur = proto.nTowerCurrent or 0
        data.times = proto.hadGetSectionReward
    end
    self.towerRewardData = data
    -- self:UpdateTowerCur()
    EventMgr.Dispatch(EventType.Tower_Update_Data, self.towerRewardData)
end

function this:UpdateTowerCur()
    if self.towerRewardData.times then
        self.towerRewardData.cur = self.towerRewardData.baseCur
        for k, v in pairs(self.towerRewardData.times) do
            if self:IsTowerGet(k) then
                local sData = DungeonMgr:GetSectionData(k)
                if sData then
                    self.towerRewardData.cur = self.towerRewardData.cur + sData:GetTowerNum()
                end
            end
        end
    end
end

-- 获取塔数据
function this:GetTowerData()
    return self.towerRewardData
end

--获取对应任务
function this:GetTowerMissionNum(sid)
    local cur, max = 0,0
    local cfgs = Cfgs.MainLine:GetGroup(sid)
    if cfgs then
        local mDatas = nil
        for k, cfg in pairs(cfgs) do
            if cfg.missionID then
                mDatas = MissionMgr:GetActivityDatas(eTaskType.TmpDupTower, cfg.missionID)
                if mDatas and #mDatas > 0 then
                    for i, v in ipairs(mDatas) do
                        if v:IsFinish() then
                            cur = cur + 1
                        end
                        max = max + 1
                    end
                end
            end
        end
    end
    return cur, max
end

--获取相关章节id
function this:GetTowerSids()
    if self.towerSids == nil then
        self.towerSids = {}
        local sDatas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.Tower)
        if sDatas and #sDatas > 0 then
            for i, v in ipairs(sDatas) do
                table.insert(self.towerSids,v:GetID())
            end
        end
    end    
    return self.towerSids
end

-- 变更塔数据
function this:AddTowerCur(num)
    if self.towerRewardData then
        self.towerRewardData.cur = self.towerRewardData.cur + num < self.towerRewardData.max and
                                       self.towerRewardData.cur + num or self.towerRewardData.max
    end
    return self.towerRewardData
end

-- 当前副本是否为爬塔关卡
function this:IsCurrTower()
    local targetId = DungeonMgr:GetCurrId();
    local cfgDungeon = targetId and Cfgs.MainLine:GetByID(targetId);
    return cfgDungeon and cfgDungeon.type == eDuplicateType.Tower;
end

--奖励已满
function this:IsTowerMax()
    if self.towerRewardData then
        return self.towerRewardData.cur >= self.towerRewardData.max
    end
    return false
end

-- 已领取
function this:IsTowerGet(sid)
    if self:IsTowerMax() then
        return true
    end
    if self.towerRewardData and self.towerRewardData.times and self.towerRewardData.times[sid] then --有下发就有领取 无需判断时间
        return true
    end
    return false
end

-- 已完成
function this:IsTowerFinish(sid)
    local cur,max = self:GetTowerMissionNum(sid)
    return cur >= max
end

--可以扫荡
function this:IsTowerSweep(sid)
    if self:IsTowerFinish(sid) and not self:IsTowerGet(sid) then
        return true
    end
    return false
end
 
--满足一键全扫
function this:IsTowersSweep()
    if self:IsTowerMax() then --已满
        return false
    end
    local ids = self:GetTowerSids()
    if #ids > 0 then
        local _ids,finishNum,max = {},0,#ids
        for i, v in ipairs(ids) do
            if self:IsTowerFinish(v) then
                finishNum = finishNum + 1
                if not self:IsTowerGet(v) then
                    table.insert(_ids,v)
                end
            end
        end
        return finishNum >= max and #_ids > 0,_ids
    end
    return false
end

function this:IsTowerRed()
    local isRed = MissionMgr:CheckRed({eTaskType.TmpDupTower, eTaskType.DupTower})
    if not isRed then
        local ids  = self:GetTowerSids()
        if #ids > 0 then
            for i, v in ipairs(ids) do
                if self:IsTowerSweep(v) then
                    isRed = true
                    break
                end
            end
        end
    end
    return isRed
end
------------------------------------异构空间------------------------------------
function this:SetCardInfos(proto)
    if proto then
        if proto.card_infos and proto.sid then
            self.cardInfos = self.cardInfos or {};
            self.cardInfos[proto.sid] = {};
            for i, v in ipairs(proto.card_infos) do
                self.cardInfos[proto.sid][v.cid] = v
            end
        end
    end
    EventMgr.Dispatch(EventType.NewTower_CardInfo_Update_Finish)
end

function this:SetAssistCardInfos(proto)
    if proto and proto.assit_card_infos then
        self.assits = self.assits or {}
        for k, v in ipairs(proto.assit_card_infos) do
            if next(v.assit_card_info) == nil then
                self.assits[v.sid] = nil
            else
                self.assits[v.sid] = v.assit_card_info
            end
        end
        EventMgr.Dispatch(EventType.NewTower_AssistCardInfo_Update_Finish)
    end
end

function this:GetCardInfos()
    return self.cardInfos
end

-- 获取角色信息
function this:GetCardInfo(cid, fuid, sectionId)
    local info = {
        cid = cid,
        tower_hp = 100,
        tower_sp = 0
    }
    if self.assits and sectionId and self.assits[sectionId] and fuid and self.assits[sectionId].fuid == fuid and
        self.assits[sectionId].cid == cid then -- 获取锁定的助战卡牌
        return self.assits[sectionId]
    elseif fuid ~= nil or sectionId == nil or self.cardInfos[sectionId] == nil or
        (self.cardInfos[sectionId] and self.cardInfos[sectionId][cid] == nil) then
        return info
    end
    return self.cardInfos[sectionId][cid]
end

function this:GetLockAssistInfo(sectionId)
    if sectionId and self.assits then
        return self.assits[sectionId];
    end
    return nil;
end

-- 获取已退场的角色
function this:GetRecoverArr(sid)
    local infos = {}
    if self.cardInfos and self.cardInfos[sid] then
        for k, v in pairs(self.cardInfos[sid]) do
            if v.tower_hp <= 0 then -- 已退场
                local card = RoleMgr:GetData(v.cid)
                if card then
                    table.insert(infos, card)
                end
            end
        end
    end
    return infos
end

function this:SetDatas(proto)
    if proto and proto.dup_monster_infos then
        for k, v in pairs(proto.dup_monster_infos) do
            if self.datas[v.id] then
                self.datas[v.id]:Init(v)
            else
                local data = TowerData.New()
                data:Init(v)
                self.datas[v.id] = data
            end
        end
    end
end

-- 副本id
function this:GetData(id)
    return self.datas[id] or self:GetNewData(id)
end

function this:GetNewData(_id)
    local data = TowerData.New()
    data:Init({
        id = _id
    })
    self.datas[_id] = data
    return data
end

-- isOrder:顺序
function this:GetArr(sectionId, isOrder)
    local _datas = {}
    local cfgs = Cfgs.MainLine:GetGroup(sectionId)
    if cfgs then
        for k, v in pairs(cfgs) do
            table.insert(_datas, self:GetData(v.id))
        end
    end
    if #_datas > 0 then
        table.sort(_datas, function(a, b)
            if isOrder then
                return a:GetID() < b:GetID()
            else
                return a:GetID() > b:GetID()
            end
        end)
    end
    return _datas
end

function this:SetResetCnt(proto)
    if proto and proto.reset_cnt then
        for i, v in ipairs(proto.reset_cnt) do
            self.reset_cnt[v.sid] = v.num
        end
    end
    EventMgr.Dispatch(EventType.NewTower_ResetCnt_Update)
end

-- 获取当天重置次数
function this:GetResetCnt(sid)
    return self.reset_cnt and self.reset_cnt[sid] or 0
end

-- 获取通关数
function this:GetCount(group)
    local cur, max = 0, 0
    local cfgs = Cfgs.MainLine:GetGroup(group)
    if cfgs then
        for k, v in pairs(cfgs) do
            local dungeonData = DungeonMgr:GetDungeonData(v.id)
            if dungeonData and dungeonData:IsPass() then
                cur = cur + 1
            end
            max = max + 1
        end
    end
    return cur, max
end

-- 获取所有通关数
function this:GetCounts()
    local tab = {}
    local datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.NewTower)
    if #datas > 0 then
        local _cur, _max = 0, 0
        for i, v in ipairs(datas) do
            _cur, _max = self:GetCount(v:GetID())
            table.insert(tab, {
                cur = _cur,
                max = _max
            })
        end
    end
    return tab
end

function this:SetSectionId(_id)
    self.sectionId = _id
end

function this:GetSectionId()
    return self.sectionId
end

function this:ClearSectionId()
    self.sectionId = nil
end

function this:GetDirllMonsterInfos(id)
    if self.datas and self.datas[id] then
        return self.datas[id]:GetDirllMonsterInfos()
    end
end
------------------------------------深塔计划------------------------------------
function this:SetDeepDatas(proto)
    if proto then
        self.newDeepDupId = proto.maxGroup or self.newDeepDupId
        self.deepDataList = {}
        for k, v in ipairs(proto.datas) do
            self.deepDataList[v.id] = {
                id = v.id,
                score = v.score,
                rewardIndex = v.getRwdLv,
                isPass = v.isPass
            }
        end
        self:UpdateDeepTotalScore()
    end
end

function this:UpdateDeepTotalScore()
    self.deepTotalScore = 0
    for k, v in pairs(self.deepDataList) do
        self.deepTotalScore = self.deepTotalScore + v.score
    end
end

-- 获取关卡组数据 activeId:活动入口表id
function this:GetDeepDatas()
    return self.deepDataList
end

-- 获取最新通关关卡组id
function this:GetNewPassDeepId()
    return self.newDeepDupId or 0
end

-- 获取当前累计积分
function this:GetDeepTotalScore()
    return self.deepTotalScore or 0
end

-- 获取关卡组积分
function this:GetDeepScore(groupId)
    return (self.deepDataList[groupId] and self.deepDataList[groupId].score) or 0
end

function this:IsDeepPass(groupId)
    return self.deepDataList[groupId] and self.deepDataList[groupId].isPass
end

function this:IsDeepOpen(groupId)
    local cfg = Cfgs.DungeonGroup:GetByID(groupId)
    local lockStr, targetTime = "", 0
    local isOpen = GCalHelp:isTowerDeepDupGroupUnlock(groupId, self:GetDeepTotalScore())
    if isOpen then
        if cfg and cfg.perLevel then
            isOpen = self:IsDeepPass(cfg.perLevel)
            lockStr = LanguageMgr:GetByID(130034)
        end
    else
        if cfg.perPoint and cfg.perPoint > self:GetDeepScore(groupId) then
            lockStr = LanguageMgr:GetByID(130012, cfg.perPoint)
        end
        if cfg.openTime then
            targetTime = TimeUtil:GetTimeStampBySplit(cfg.openTime)
        end
    end
    return isOpen, lockStr, targetTime
end

function this:GetTowerDeepGoals(groupId)
    local cfg = Cfgs.DungeonGroup:GetByID(groupId)
    local infos = nil
    if cfg and self.deepDataList and self.deepDataList[groupId] then
        infos = {}
        for i = 1, 3 do
            if cfg["star" .. i] then
                table.insert(infos, {
                    isComplete = (self.deepDataList[groupId].score >= cfg["star" .. i]) or false,
                    tips = LanguageMgr:GetByID(130008, cfg["star" .. i])
                })
            end
        end
    end
    return infos
end

-- 奖励全领完
function this:IsDeepRewardGet(groupId)
    local cfg = Cfgs.DungeonGroup:GetByID(groupId)
    if cfg and self.deepDataList and self.deepDataList[groupId] then
        local cur, max = 0, 3
        for i = 1, 3 do
            if cfg["star" .. i] then
                cur = self.deepDataList[groupId].score >= cfg["star" .. i] and cur + 1 or cur
            end
        end
        return cur >= max
    end
    return false
end

------------------------------------永境战域------------------------------------
function this:SetCardInfos2(proto)
    if proto then
        if proto.sid then
            if proto.card_infos then
                self.cardCache = self.cardCache or {}
                for i, v in ipairs(proto.card_infos) do
                    self.cardCache[v.cid] = v
                end
            end
            if proto and proto.is_finish and self.cardCache then
                self.cardInfos = self.cardInfos or {};
                self.cardInfos[proto.sid] = self.cardCache
                self.cardCache = nil
                EventMgr.Dispatch(EventType.NewTower_CardInfo_Update_Finish)
            end
        end
    end
end

return this
