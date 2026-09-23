local this = MgrRegister("ColosseumMgr")

function this:Init()
    self:Clear()
    self:InitCfg()
end

function this:Clear()
    self.seasonData = nil
    self.endTime = nil
    self.sectionData = nil
end

function this:InitCfg()
    --
    self.endTime = nil
    --
    self.sectionData = DungeonMgr:GetActivitySectionDatas(SectionActivityType.Colosseum)[1]

    AbattoirProto:GetSeasonData()
end

-- 请求赛季数据返回
function this:GetSeasonDataRet(proto)
    self.seasonData = proto
    self.cfg = Cfgs.cfgColosseum:GetByID(self.seasonData.id)

    self:CheckRewardRed()
end

--  修改选卡数据
function this:SetSelectCardData(selectCardData)
    self.seasonData.randModData = self.seasonData.randModData or {}
    self.seasonData.randModData.selectCardData = selectCardData
end

-- 购买入场
function this:StartModRet(proto)
    if (proto.modType == 1) then
        self.seasonData.isSelectPay = true
    elseif (proto.modType == 2) then
        self.seasonData.isRandPay = true
        --
        self:SetSelectCardData(proto.selectCardData)
        -- 
        self.seasonData.randModData = self.seasonData.randModData or {}
        self.seasonData.randModData.randLvs = proto.randLvs
    end
end

function this:GetSectionData()
    return self.sectionData
end

-- 赛季数据
function this:GetSeasonData()
    return self.seasonData
end

function this:GetSeasonID()
    if (self:GetSeasonData()) then
        return self:GetSeasonData().id
    end
    return nil
end

function this:GetRealSeasonID()
    if (self:GetSeasonData()) then
        local id = self:GetSeasonData().id
        return Cfgs.cfgColosseum:GetByID(id).dupSeasonId
    end
    return nil
end

function this:GetCfg()
    return self.cfg
end

function this:GetScoreData(modType)
    if (self.seasonData ~= nil and self.seasonData.scoreData ~= nil) then
        for k, v in pairs(self.seasonData.scoreData) do
            if (v.modType == modType) then
                return v
            end
        end
    end
    return nil
end

-- 赛季刷新最近的时间 {time,类型：1自选 2随机}
function this:GetRefreshTimes()
    local refreshTimes = nil
    local curTime = TimeUtil:GetTime()
    if (self.seasonData) then
        if (self.cfg.optionalSwitch == 1 and self.seasonData.selectRefreshTime and curTime <
            self.seasonData.selectRefreshTime) then
            refreshTimes = {self.seasonData.selectRefreshTime, 1}
        end
        if (self.cfg.randomSwitch == 1 and self.seasonData.randRefreshTime and curTime < self.seasonData.randRefreshTime) then
            if (refreshTimes == nil or self.seasonData.randRefreshTime < refreshTimes[1]) then
                refreshTimes = {self.seasonData.randRefreshTime, 2}
            end
        end
    end
    return refreshTimes
end

-- 商店货币
function this:GetGoodsID()
    local cfg = self.sectionData:GetCfg()
    if (cfg) then
        return cfg.info[1].goodsId
    end
    return nil
end

-- 获取选中的标签索引
function this:GetSelTabIndex()
    local index1 = self.tabIndex1 ~= nil and self.tabIndex1 or 1
    return index1
end
-- 设置选中的标签索引
function this:SetSelTabIndex(index1)
    self.tabIndex1 = index1;
end

-- 是否已购买入场 1:自选 2：随机
function this:CheckIsBuy(type)
    if (type == 1) then
        return self.seasonData.isSelectPay
    else
        return self.seasonData.isRandPay
    end
end

function this:GetTeamIndex(modeType)
    return eTeamType.Colosseum + (modeType - 1)
end

--------------------------------------随机模式----------------------------------------------------
-- 随机模式数据
function this:GetRandModData()
    return self.seasonData.randModData
end

-- 当前第几关(已通关)
function this:GetRandomCurIdx()
    local index = 0
    local randLvs = self:GetRandModData().randLvs
    for k, v in ipairs(randLvs) do
        local isPass = false
        for p, q in pairs(v.dupIds) do
            local _data = DungeonMgr:GetDungeonData(q)
            if (_data and _data:GetStar() > 0) then
                isPass = true
                index = k
            end
        end
        if (not isPass) then
            break
        end
    end
    return index
end

-- 当前所在回合
function this:GetRandomCurIdx2()
    local index = self:GetRandomCurIdx()
    return (index + 1) > 9 and 9 or (index + 1)
end

-- 模式表
function this:GetOptionalCfg(themeType)
    local id = self.seasonData.id
    local cfg = Cfgs.cfgColosseumOptional:GetByID(id)
    for k, v in pairs(cfg.infos) do
        if (v.modeId == themeType) then
            return v
        end
    end
    return nil
end

-- 是否可以保存路线
function this:IsNeedSaveRoute()
    if (self.cfg.savePoint and self:GetRandomCurIdx() >= self.cfg.savePoint) then
        return true
    end
    return false
end

-- 领奖
function this:SetRewardIsGet(b)
    self:GetRandModData().isGet = b
    self:CheckRewardRed()
end

-- 弃权
function this:SetRamdonOver(b)
    self:GetRandModData().isOver = b
    self:CheckRewardRed()
end

-- 是否需要继续选人
function this:IsNeedToSelect()
    local cur = self:GetRoleCur()
    local max = self:GetRoleMax()
    return cur < max
end

function this:GetRoleCur()
    local selectCardData = self:GetRandModData().selectCardData
    return selectCardData and #selectCardData.selectCards or 0
end

-- 当前可选人数上限
function this:GetRoleMax()
    local optional = self:GetOptionalCfg(2) or {}
    local modeId = optional.turnNum or 8 -- 人数上限
    local reChooseTurn = optional.reChooseTurn -- 再抽回合数
    local idx = self:GetRandomCurIdx2()
    if (reChooseTurn) then
        for k, v in ipairs(reChooseTurn) do
            if (idx > v) then
                modeId = modeId + 1
            end
        end
    end
    return modeId
end

-- 随机模式是否已结束
function this:CheckRandomIsOver()
    return self:GetRandModData().isOver
end

-- 回合通关位置(保存的路线也算)
function this:GetPassIndex(idx)
    local randLvs = self:GetRandModData().randLvs
    if (randLvs and randLvs[idx]) then
        local ids = randLvs[idx].dupIds
        local selectId = randLvs[idx].selectId
        for k, v in ipairs(ids) do
            if (selectId) then
                if (v == selectId) then
                    return k
                end
            else
                local _data = DungeonMgr:GetDungeonData(v)
                if (_data and _data:IsPass()) then
                    return k
                end
            end
        end
    end
    return 1
end

-- 随机模式当前编队角色
function this:GetEditTeamArr()
    local arr = {}
    local selectCardData = self:GetRandModData().selectCardData
    local selectCards = selectCardData.selectCards or {}
    for k, v in ipairs(selectCards) do
        local cardData = self:MonsterCardData(v.monsterIdx)
        table.insert(arr, cardData)
    end
    return arr
end

function this:MonsterCardData(monsterIdx)
    local cid = FormationUtil.FormatNPCID(monsterIdx)
    return FormationUtil.FindTeamCard(cid)
end

function this:GetEquipDatas(equips)
    local datas = {}
    for k, v in ipairs(equips) do
        local equip = EquipData(v)
        table.insert(datas, equip)
    end
    return datas
end

-- 关卡属于第几回合
function this:GetIndexByID(id, type)
    if (type == 1) then
        local cfg = Cfgs.MainLine:GetByID(id)
        return cfg.turn
    else
    end
end

-- 随机模式已获得星数
function this:GetRandomStar()
    local star = 0
    local randLvs = self:GetRandModData().randLvs
    for k, v in ipairs(randLvs) do
        local _star = 0
        for p, q in pairs(v.dupIds) do
            local _data = DungeonMgr:GetDungeonData(q)
            if (_data) then
                _star = _data:GetStar()
                break
            end
        end
        star = star + _star
        if (_star == 0) then
            break
        end
    end
    return star
end

-- 免费信息 刷新时间（除了不免费，每日3点都刷新一次）
function this:GetFreeInfo()
    local timer = nil
    local timeData = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
    local sec = 0
    local freeType = self:GetCfg().freeType
    if (freeType ~= 1) then
        if (timeData.hour < 3) then
            sec = 3 * 3600 - timeData.hour * 3600 - timeData.min * 60 - timeData.sec
        else
            sec = 24 * 3600 - timeData.hour * 3600 - timeData.min * 60 - timeData.sec
        end
    end
    local freeCnt = self:GetSeasonData().freeCnt or 0
    return freeCnt, TimeUtil:GetTime() + sec
end

function this:GetFreeCnt()
    return self:GetCfg().freeNum, self:GetCfg().freeMax
end

-----------------------------------------------------------------------------------------

-- 入口是否有红点 任务，随机模式奖励
function this:IsRed()
    if (self:IsMissionRed()) then
        return true
    end
    if (self:IsRewardRed()) then
        return true
    end
    return false
end
function this:CheckMissionRed()
    local _data = nil
    for i = 1, 2 do
        if (MissionMgr:CheckRed3({eTaskType.AbattoirMoon, eTaskType.AbattoirSeason}, i)) then
            _data = 1
            break
        end
    end
    local data = RedPointMgr:GetData(RedPointType.Colosseum)
    if (data ~= _data) then
        RedPointMgr:UpdateData(RedPointType.Colosseum, _data)
        -- EventMgr.Dispatch(EventType.Section_Red_Update)
    end
end
-- 任务红点
function this:IsMissionRed()
    local data = RedPointMgr:GetData(RedPointType.Colosseum)
    return data ~= nil
end
function this:CheckRewardRed()
    local _data = nil
    if (self:GetRandModData().isOver and not self:GetRandModData().isGet) then
        _data = 1
    end
    local data = RedPointMgr:GetData(RedPointType.ActiveEntry26)
    if (data ~= _data) then
        RedPointMgr:UpdateData(RedPointType.ActiveEntry26, _data)
        -- EventMgr.Dispatch(EventType.Section_Red_Update)
    end
end
-- 奖励红点
function this:IsRewardRed()
    local data = RedPointMgr:GetData(RedPointType.ActiveEntry26)
    return data ~= nil
end

function this:Quit(id)
    CSAPI.OpenView("ColosseumView", id)
end

-- 基础人数上限
function this:GetBaseRoleMax(modelId)
    local optional = self:GetOptionalCfg(modelId) or {}
    return optional.turnNum or 8 -- 人数上限
end

-- 随机是否保存了线路
function this:IsSaveSelect()
    local randLvs = self:GetRandModData().randLvs
    if (randLvs and randLvs[1].selectId ~= nil) then
        return true
    end
    return false
end

-- 入口是否显示，即下次刷新时间
function this:CheckEnterOpen()
    local isOpen, refreshTime = false, nil
    local cfgs = Cfgs.cfgColosseum:GetAll()
    local curTime = TimeUtil:GetTime()
    for k, v in ipairs(cfgs) do
        local endTime = TimeUtil:GetTimeStampBySplit(v.endTime)
        if(endTime > curTime)then 
            local begTime = TimeUtil:GetTimeStampBySplit(v.begTime)
            isOpen = curTime>=begTime
            refreshTime = isOpen and endTime or begTime
            break 
        end 
    end
    return isOpen, refreshTime
end

return this
