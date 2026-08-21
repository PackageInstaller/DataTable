local M = BaseClass("LimitDataMgr",Singleton)

function M:__init()
    self.m_gettingCallbacks = {}
    self.m_OnResponseExtremeBattleAwardHandler = NetPack:RegistResponse(Proto.MessageId.ResponseExtremeBattleAward,Bind(self,self._OnResponseExtremeBattleAward))
    self.m_NotifyExtremeBattleTaskHandler = NetPack:RegistResponse(Proto.MessageId.NotifyExtremeBattleTask,Bind(self,self._NotifyExtremeBattleTask))
    self.m_LimitChallgeData = nil
    self.m_ResponseResetExtremeBattleSkillsHandler = NetPack:RegistResponse(Proto.MessageId.ResponseResetExtremeBattleSkills,Bind(self,self._OnResponseResetExtremeBattleSkills))
    self.m_resetSkillCallback = nil
    self.m_ResponseChooseExtremeBattleSkillsHandler = NetPack:RegistResponse(Proto.MessageId.ResponseChooseExtremeBattleSkills,Bind(self,self._OnResponseChooseExtremeBattleSkills))
    self.m_chooseSkilCallback = nil
    self.m_ResponseResetExtremeBattleMissionsHandler = NetPack:RegistResponse(Proto.MessageId.ResponseResetExtremeBattleMissions,Bind(self,self._OnResponseResetExtremeBattleMissions))
    self.m_resetBattleMission = nil
    self.m_ResponseGetExtremeBattleBuyInfoHandler =  NetPack:RegistResponse(Proto.MessageId.ResponseGetExtremeBattleBuyInfo,Bind(self,self._OnResponseGetExtremeBattleBuyInfo))
    self.m_ResponseBuyExtremeBattleShopHandler =  NetPack:RegistResponse(Proto.MessageId.ResponseBuyExtremeBattleShop,Bind(self,self._OnResponseBuyExtremeBattleShop))
    self.m_ResponseExtremeBattleEndHandler = NetPack:RegistResponse(Proto.MessageId.ResponseExtremeBattleEnd,Bind(self,self._OnResponseExtremeBattleEnd))
end

--获得周期信息 返回多个参数  周期开始字符串，周期结束字符串，是否在休赛期
function M:GetCycleInfo()
    local curTime = TimeUtil.GetNowTimeStamp()
    local firstStartTick = ConfigHelper.GetSystemParam(370)
    local cycleTime = ConfigHelper.GetSystemParam(371)
    local offSeasonTime = ConfigHelper.GetSystemParam(372)
    local cycle = math.floor(( curTime - firstStartTick ) / cycleTime)
    local curCycleStart = firstStartTick + cycle * cycleTime
    local curCycleEnd = curCycleStart + cycleTime
    local startLabel = TimeUtil.GetTimeFormat(curCycleStart,"%y/%m/%d %H:%M")
    local endLabel = TimeUtil.GetTimeFormat(curCycleEnd,"%y/%m/%d %H:%M")
    if curTime >= curCycleStart and curTime < curCycleEnd - offSeasonTime then 
        return startLabel,endLabel,false
    else
        return startLabel,endLabel,true
    end
end

--获得极限挑战数据
function M:GetLimitChallgeData(callback)
    --未上线的内容
    callback(nil)
    print("未上线请求")

    -- if callback == nil then 
    --     return
    -- end
    -- if not table.indexof(self.m_gettingCallbacks,callback) then 
    --     table.insert(self.m_gettingCallbacks ,callback)
    -- end
    -- if self.m_LimitChallgeData then 
    --     local callbacks = self.m_gettingCallbacks
    --     self.m_gettingCallbacks = {}
    --     for _, callback in ipairs(callbacks) do
    --         -- body
    --         if callback then 
    --             callback(self.m_LimitChallgeData)
    --         end
    --     end
    --     return 
    -- end
    
    -- if not self.m_isGetting then 
    --     self.m_ResponseGetExtremeBattleInfoHandler = NetPack:RegistResponse(Proto.MessageId.ResponseGetExtremeBattleInfo,Bind(self,self._OnResponseGetExtremeBattleInfo))
    --     local RequestGetExtremeBattleInfo = {}
    --     NetPack:SendMessage(Proto.MessageId.RequestGetExtremeBattleInfo,RequestGetExtremeBattleInfo)
    -- end
    -- self.m_isGetting = true
end

function M:_OnResponseGetExtremeBattleInfo(messageId,result,msg)
    self.m_isGetting = false
    if self.m_ResponseGetExtremeBattleInfoHandler then 
        NetPack:UnRegistResponse(Proto.MessageId.ResponseGetExtremeBattleInfo,self.m_ResponseGetExtremeBattleInfoHandler)
    end
    if result ~= 0 then 
        return
    end
    local data = require("DataCenter.Mission.LimitChallgeData").New(msg)
    local callbacks = self.m_gettingCallbacks
    self.m_gettingCallbacks = {}
    self.m_LimitChallgeData = data
    for _, callback in ipairs(callbacks) do
        -- body
        if callback then 
            callback(data)
        end
    end
end

--领取奖励   taskId , type 为类型，1-挑战奖励，2-赛季奖励
function M:RequestExtremeBattleAward(taskId,type,seasonType,callback)
    self.m_gainTaskCallback = callback
    self.m_gainTaskId = taskId
    local RequestExtremeBattleAward = {}
    RequestExtremeBattleAward.TaskId = taskId
    RequestExtremeBattleAward.Type = type
    RequestExtremeBattleAward.SeasonType = seasonType
    NetPack:SendMessage(Proto.MessageId.RequestExtremeBattleAward,RequestExtremeBattleAward)
end

function M:_OnResponseExtremeBattleAward(messageId,result,msg)
    if result ~= 0 then 
        return
    end
    self.m_LimitChallgeData:UpdateTask(self.m_gainTaskId,2)
    GameHelper.ShowGetItemsByItems(msg.Awards,nil,false)
    if self.m_gainTaskCallback then 
        self.m_gainTaskCallback()
    end
    RedPointMgr:GetInstance():ForceCheck(RedPointConst.LimitTaskChecker)
end

-- 重置破限技
function M:RequestResetExtremeBattleSkills(callback)
    self.m_resetSkillCallback = callback
    local RequestResetExtremeBattleSkills = {}
    NetPack:SendMessage(Proto.MessageId.RequestResetExtremeBattleSkills,RequestResetExtremeBattleSkills)
end

function M:_OnResponseResetExtremeBattleSkills(messageId,result,msg)
    if result ~= 0 then 
        return
    end
    if self.m_LimitChallgeData then 
        self.m_LimitChallgeData:SetSkillResetTimes(msg.ResetTimes)
    end
    if self.m_resetSkillCallback then 
        self.m_resetSkillCallback()
    end
end

-- 选择破限技
function M:RequestChooseExtremeBattleSkills(groupIdx,selectedIds,callback)
    if selectedIds == nil or #selectedIds == 0 then
        return
    end
    self.m_chooseSkilCallback = callback
    self.m_groupIdx = groupIdx
    self.m_selectedIdx = selectedIds
    local RequestChooseExtremeBattleSkills = {}
    RequestChooseExtremeBattleSkills.Group = groupIdx
    RequestChooseExtremeBattleSkills.Selected = selectedIds
    NetPack:SendMessage(Proto.MessageId.RequestChooseExtremeBattleSkills,RequestChooseExtremeBattleSkills)

end

function M:_OnResponseChooseExtremeBattleSkills(messageId,result,msg)
    if result ~= 0 then 
        return
    end
    self.m_LimitChallgeData:SetLimitSkill(self.m_groupIdx+1,self.m_selectedIdx)
    if self.m_chooseSkilCallback then 
        self.m_chooseSkilCallback()
    end
    RedPointMgr:GetInstance():ForceCheck(RedPointConst.LimitBreakSkillChecker)
end

function M:_NotifyExtremeBattleTask(messageId,result,msg)
    if result ~= 0 then 
        return
    end
    local taskId = msg.TaskId
    local state = msg.State
    self.m_LimitChallgeData:UpdateTask(taskId,state)
end

--重置极限挑战
function M:RequestResetExtremeBattleMissions(callback)
    self.m_resetBattleMission = callback
    local RequestResetExtremeBattleMissions = {}
    NetPack:SendMessage(Proto.MessageId.RequestResetExtremeBattleMissions,RequestResetExtremeBattleMissions)
end

function M:_OnResponseResetExtremeBattleMissions(messageId,result,msg)
    if result ~= 0 then 
        return
    end
    self.m_LimitChallgeData:ResetBattleMission(msg)
    if self.m_resetBattleMission then 
        self.m_resetBattleMission()
    end
    RedPointMgr:GetInstance():ForceCheck(RedPointConst.LimitBreakSkillChecker)
end

--获得商店信息
function M:RequestGetExtremeBattleBuyInfo(callback)
    self.m_RequestGetExtremeBattleBuyInfoCallback = callback
    local RequestGetExtremeBattleBuyInfo = {}
    NetPack:SendMessage(Proto.MessageId.RequestGetExtremeBattleBuyInfo,RequestGetExtremeBattleBuyInfo)

end

function M:_OnResponseGetExtremeBattleBuyInfo(messageId,result,msg)
    if result ~= 0 then 
        return
    end
    local myShopDataDic = {} 
    local limitShopDatCls = require("DataCenter.Mission.LimitShopData")
    for _, protoData in ipairs(msg.Items) do
        local shopId = protoData.Id
        myShopDataDic[shopId] = limitShopDatCls.New(shopId,protoData)
    end
    self.m_allShopDatas = {}
    local cfgs = ConfigHelper.GetCfgs("extremeMissionShop")
    for _, cfg in ipairs(cfgs) do
        if cfg.seasonId == self:GetSeason() then --筛选是否为当前赛季
            if myShopDataDic[cfg.id] then 
                table.insert(self.m_allShopDatas,myShopDataDic[cfg.id])
            else
                table.insert(self.m_allShopDatas,limitShopDatCls.New(cfg.id,nil))
            end
        end
    end
    if self.m_RequestGetExtremeBattleBuyInfoCallback then 
        self.m_RequestGetExtremeBattleBuyInfoCallback(self.m_allShopDatas)
    end
end

function M:RequestBuyExtremeBattleShop(id,num,callback)
    if id == nil or id == nil or ConfigHelper.GetCfg("extremeMissionShop",id) == nil then
        Logger.LogError("extremeMissionShop id error , id = " .. tostring(id))
        return
    end
    if num == nil or num < 0 then 
        Logger.LogError("数量选择错误")
        return
    end

    if not self.m_allShopDatas[id]:GetBuyMore(num) then 
        GameHelper.Tips("购买次数已达上限")
        return
    end
    self.m_RequestBuyExtremeBattleShopCallback = callback
    self.m_curBuyShopId = id
    self.m_curBuyShopNum = num
    local RequestBuyExtremeBattleShop = {}
    RequestBuyExtremeBattleShop.Id = id 
    RequestBuyExtremeBattleShop.Num = num
    NetPack:SendMessage(Proto.MessageId.RequestBuyExtremeBattleShop,RequestBuyExtremeBattleShop)
end

function M:_OnResponseBuyExtremeBattleShop(messageId,result,msg)
    if result ~= 0 then 
        return
    end
    GameHelper.ShowGetItemsByItems(msg.Items,nil,false)
    self.m_allShopDatas[self.m_curBuyShopId]:UpdateBuyInfo(self.m_curBuyShopNum)
    if self.m_RequestBuyExtremeBattleShopCallback then 
        self.m_RequestBuyExtremeBattleShopCallback()
    end
    EventMgr:Broadcast(UIMessageNames.LIMITSHOP_UPDATE, self.m_allShopDatas)

end

--设置当前的极限关卡
function M:SetCurExtremeMissionId(extremeMissionId)
    self.m_extremeMissionId = extremeMissionId
end

function M:CheckBreakSkillUI()
    local isShow = self.m_showBreakSkill
    self.m_showBreakSkill = false
    return isShow
end

function M:_OnResponseExtremeBattleEnd(messageId,result,msg)
    --战后重新拉数据
    self.m_LimitChallgeData = nil
    if msg.IsWin == "WIN" then 
        local cfg = ConfigHelper.GetCfg("extremeMission",self.m_extremeMissionId)
        --是否显示破限技
        if cfg.superSkills > 0 then 
            self.m_showBreakSkill = true
        else
            self.m_showBreakSkill = false
        end
    end
end

function M:GetSeason()
    if self.m_LimitChallgeData ~= nil then
        return self.m_LimitChallgeData:GetSeason()
    end
end

return M