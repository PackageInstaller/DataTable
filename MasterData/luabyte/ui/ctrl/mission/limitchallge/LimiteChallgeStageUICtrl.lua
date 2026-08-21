local M = BaseClass("LimiteChallgeStageUICtrl",BaseUICtrl)

function M:__init()
    self.view.clickArea:onClick(Bind(self,self._OnClickMask))
    self._curItem = nil
    self.m_mission2MD = {}
    self.m_limitChallgeData = nil
    self.m_missionId2limitMissionId = {}
    self.view.taskBtn:onClick(Bind(self,self._OnClickTask))
    self.view.skillBtn:onClick(Bind(self,self._OnClickSkill))
    self.view.resetBtn:onClick(Bind(self,self._OnClickReset))
    self.view.shopBtn:onClick(Bind(self,self._OnClickShop))
    self._view.txt_timerLabel:SetActive(false)
    self._view.img_timer:SetActive(false)
end

function M:OnBack()
    if self.view.stageInfo:GetActive() then 
        self.view.clickArea:SetActive(false)
        self.view.stageInfo:SetActive(false)
        return false
    end
    return true
end

function M:OnEnter(limitChallgeData)
    self.m_limitChallgeData = limitChallgeData
    local limitMissionDatas = limitChallgeData:GetMissions()
    local curMissionId = 801207
    self.m_starDic = {}
    --当前选择的破限技
    local limitSkills = self.m_limitChallgeData:GetLimitSkills()
    self.m_breakLimitSkills = {}
    for _, skill in ipairs(limitSkills) do
        local selectSkills = skill:GetSelectIds()
        for __, conId in ipairs(selectSkills) do
            table.insert(self.m_breakLimitSkills,conId)
        end
    end
    --进度定位
    self.m_locationIdx = {0,0,0,0,0,0.3,0.3,0.3,0.3,0.3,1,1}
    --已选中的词条
    self.m_allCurItems = self.m_allCurItems or {}
    local clickItemCallback = Bind(self,self._OnClickItem)
    self.m_allCurItems = {}
    local isFirstUnFinish = true
    local horLocationIdx = 0
    for i = 1 , 12 do 
        local md = limitMissionDatas[i]
        if md then
            local missionId = md:GetMissionId()
            self.m_missionId2limitMissionId[missionId]=i
            self.m_mission2MD[missionId] = md
            local item = self:_GetItem(i-1)
            local star = md:GetStar()
            if missionId > 0 then 
                self.m_allCurItems[missionId]=item
            end
            if star > 0 then 
                item:SetActive(star>0)
                self.m_starDic[missionId]=star
                item:SetInfo(missionId,false,missionId==curMissionId,star,clickItemCallback,i==12)
                item:SetActive(true)
            else
                if isFirstUnFinish then 
                    isFirstUnFinish = false
                    item:SetActive(true)
                    self.m_starDic[missionId]=star
                    item:SetInfo(missionId,false,missionId==curMissionId,star,clickItemCallback,true)
                    item:SetActive(true)
                    horLocationIdx = self.m_locationIdx[i]
                else
                    item:SetActive(false)
                end
            end
        end
    end
    
    self.view.clickArea:SetActive(false)
    self.view.stageInfo:SetActive(false)
    self.view.scrollView:SetHorizontalValue( horLocationIdx)
    local startStr,endStr,isInOffTime = LimitDataMgr:GetInstance():GetCycleInfo()
    self.view.cycleTimeLabel:SetText("周期时间:" .. startStr .. " - " .. endStr )
    self.view.txt_curGameScore:SetText("" ..self.m_limitChallgeData:GetTotalGameStars())
    self.view.txt_curSeasonScore:SetText("" ..self.m_limitChallgeData:GetTotalSeasonStars())
    
end

function M:_OnClickReset(go)
    self.m_lastResetTime = self.m_lastResetTime or 0
    local cdTime = ConfigHelper.GetSystemParam(373)
    if Time.realtimeSinceStartup - self.m_lastResetTime < cdTime then 
        return
    end
    GameHelper.Confirm(ConfigHelper.GetLocalString(8012),function(isYes)
        self.m_countDownTotal = cdTime
        self.m_countDown = 0
        LimitDataMgr:GetInstance():RequestResetExtremeBattleMissions(Bind(self,self._OnResetBattle))
    end)
end

function M:_StartResetTimer()
    if self.m_resetTimer then 
        self.m_resetTimer:Stop()
    end
    Logger.Log("开始")
    self.m_timerFunc = self.m_timerFunc or function(dontCrease)
        if not dontCrease then 
            self.m_countDown = self.m_countDown + 1
        end
        
        self._view.txt_timerLabel:SetActive(true)
        self._view.img_timer:SetActive(true)
        self._view.txt_timerLabel:SetText(tostring(self.m_countDownTotal-self.m_countDown))
        local rate = (self.m_countDownTotal - self.m_countDown )/ self.m_countDownTotal
        self._view.img_timer:SetFillAmount(rate)
        Logger.Log("开始" .. self.m_countDown .. ",rate:" .. rate)
        if self.m_countDown >= self.m_countDownTotal then
            if self.m_resetTimer then 
                self.m_resetTimer:Stop()
            end
            self._view.txt_timerLabel:SetActive(false)
            self._view.img_timer:SetActive(false)
            Logger.Log("关闭" .. self.m_countDown .. ",rate:" .. rate)
        end
    end
    self.m_resetTimer = TimerManager:GetInstance():GetTimer(1,self.m_timerFunc)
    self.m_resetTimer:Start()
    self.m_timerFunc(true)
end

function M:_OnResetBattle()
    self.m_lastResetTime = Time.realtimeSinceStartup
    self:_StartResetTimer()
    self:OnEnter(self.m_limitChallgeData)
end

function M:_OnClickShop(go)
    IUIContextMgr:Show(UIDefine.UIExtremeShop)
end

function M:_OnClickItem(missionId)
    self.view.clickArea:SetActive(true)
    self.view.stageInfo:SetActive(true)
    
    local md = self.m_mission2MD[missionId]
    local star = md:GetStar()
    local extremeMissionId = self.m_missionId2limitMissionId[missionId]
    self.view.stageInfo:SetStageInfo(extremeMissionId,missionId, md:GetConditionWords(),self.m_breakLimitSkills ,star,md:GetSelectConditionWords())
    for m, item in pairs(self.m_allCurItems) do
        item:SetSelect(item:GetMissionId() == missionId)
        if item:GetMissionId() == missionId then 
            self._curItem = item
        end
    end
end

function M:_OnClickMask(go)
    self.view.clickArea:SetActive(false)
    self.view.stageInfo:SetActive(false)
    if self._curItem then 
        self._curItem:SetSelect(false)
        self._curItem = nil
    end
end

function M:_GetItem(index)
    local item = self.view["item"..index]
    return item
end

function M:_OnClickTask(go)
    UIContextMgr:GetInstance():Show("LimitChallgeTaskUI",self.m_limitChallgeData)
end

function M:_OnClickSkill(go)
    UIContextMgr:GetInstance():Show("LimitBreakLimitSkill",self.m_limitChallgeData)
end

function M:OnClose()
    M.super.OnClose(self)
    if self.m_resetTimer then 
        self.m_resetTimer:Stop()
    end
    self.m_resetTimer = nil
end

function M:OnDispose()
    M.super.OnDispose(self)
    if self.m_resetTimer then 
        self.m_resetTimer:Stop()
    end
    self.m_resetTimer = nil
end

return M