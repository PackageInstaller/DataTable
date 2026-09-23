-- 决斗场
AbattoirProto = {}

-- 请求赛季数据
function AbattoirProto:GetSeasonData(cb)
    self.GetSeasonDataCB = cb
    local proto = {"AbattoirProto:GetSeasonData"}
    NetMgr.net:Send(proto)
end
function AbattoirProto:GetSeasonDataRet(proto)
    ColosseumMgr:GetSeasonDataRet(proto)
    if (self.GetSeasonDataCB) then
        self.GetSeasonDataCB()
    end
    self.GetSeasonDataCB = nil
    EventMgr.Dispatch(EventType.Colosseum_GetData)
end

-- 请求进入随机模式
function AbattoirProto:StartMod(_modType,_tType, cb)
    self.StartRandModCB = cb
    local proto = {"AbattoirProto:StartMod", {modType = _modType,
        tType = _tType
    }}
    NetMgr.net:Send(proto)
end
function AbattoirProto:StartModRet(proto)
    ColosseumMgr:StartModRet(proto)
    if (self.StartRandModCB) then
        self.StartRandModCB(proto)
    end
    self.StartRandModCB = nil
end

-- 随机模式选人
function AbattoirProto:SelectCard(_cardIdx)
    local proto = {"AbattoirProto:SelectCard", {
        cardIdx = _cardIdx
    }}
    NetMgr.net:Send(proto)
end
function AbattoirProto:SelectCardRet(proto)
    ColosseumMgr:SetSelectCardData(proto.selectCardData)
    EventMgr.Dispatch(EventType.Colosseum_SelectCard,proto.cardIdx)
end

-- 随机模式请求保存路线
function AbattoirProto:SaveRoute(_isSave, cb)
    self.SaveRouteCB = cb
    local proto = {"AbattoirProto:SaveRoute", {
        isSave = _isSave
    }}
    NetMgr.net:Send(proto)
end
function AbattoirProto:SaveRouteRet(proto)
    if (self.SaveRouteCB) then
        self.SaveRouteCB()
    end
    self.SaveRouteCB = nil
end

-- 请求随机模式弃权
function AbattoirProto:RandModQuit(cb)
    self.RandModQuitCB = cb
    local proto = {"AbattoirProto:RandModQuit"}
    NetMgr.net:Send(proto)
end
function AbattoirProto:RandModQuitRet()
    ColosseumMgr:SetRamdonOver(true)
    if (self.RandModQuitCB) then
        self.RandModQuitCB()
    end
    self.RandModQuitCB = nil
end

-- 随机模式请求领奖
function AbattoirProto:RandModeGetRwd(_cb)
    self.RandModeGetRwdCB = _cb
    local proto = {"AbattoirProto:RandModeGetRwd"}
    NetMgr.net:Send(proto)
end
function AbattoirProto:RandModeGetRwdRet(proto)
    ColosseumMgr:SetRewardIsGet(true)
    if (self.RandModeGetRwdCB) then
        self.RandModeGetRwdCB()
    end
    EventMgr.Dispatch(EventType.Colosseum_RandomReward)
end

--[[
1、自选购买入场
2、任务类型需要更改
3、关卡表没group，themeType暂时默认上中下三路

]]
