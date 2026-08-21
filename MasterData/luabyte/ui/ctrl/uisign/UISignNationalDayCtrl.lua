-- 七日签到
local UISignCtrl = BaseClass("UISignNationalDayCtrl", BaseUICtrl)
local M = UISignCtrl
local HOURS5 = 18000
local ItemType = BagConst.ItemType
local tInsert = table.insert
local tSort = table.sort
local sfmt = string.format

function M:Init()
    self._view.signMask.gameObject:onClick(Bind(self, self._OnSignClick))
    self.tabUISignItemCtrl = {}
    tInsert(self.tabUISignItemCtrl, self._view.UISignItemCtrl)
end

function M:OnEnter(activityId, cRoleActivity)
    self.activityId = activityId
    self.cRoleActivity = cRoleActivity
    self:_initData()

    self:_RefreshTime()
    self:_RefreshSignItems()
    self._view.signMask:SetActive(not self.isSigned)
    GameHelper.DoPlayerAction(PlayerAction.OpenSevenDay)
end

-- 整理数据
function M:_initData()
    -- 缺省值
    if not self.cRoleActivity then
        self.cRoleActivity = {}
        self.cRoleActivity.State = 0
        self.cRoleActivity.Value0 = 0 -- 已经签到的次数
        self.cRoleActivity.Value1 = 0 -- 最后一次签到的时间
    end

    self.activityLogins = ConfigHelper.GetCfgsByLua("activityLogin", {activityId=self.activityId})
    self.dataNum = #self.activityLogins
    tSort(self.activityLogins, self.SortFunc)

    local nowTimer = TimeUtil.GetNowTimeStamp()
    self.isSigned = TimeUtil.IsOneDay(nowTimer - HOURS5, self.cRoleActivity.Value1 - HOURS5) -- 今天是否签到
    self.m_CurNum = self.isSigned and self.cRoleActivity.Value0 or (self.cRoleActivity.Value0 + 1) -- 今天是应该签到第几天 
end

function M:_RefreshTime()
    local actCfg = ConfigHelper.GetCfgByLua("activity", self.activityId)
    local startTime, endTime = ActivityDataMgr:GetInstance():GetActivityTime(self.activityId)

    -- 拿到时间戳
    startTime = actCfg.openType == 4 and startTime or actCfg.startTime
    endTime = actCfg.openType == 4 and endTime or actCfg.endTime

    -- 转换成date
    startTime = GameHelper.GetDateTime(startTime)
    endTime = GameHelper.GetDateTime(endTime)
    self._view.labTimer1:SetText(sfmt("%02d/%02d", startTime.Month, startTime.Day))
    self._view.labTimer2:SetText(sfmt("%02d/%02d", endTime.Month, endTime.Day))
end

function M.SortFunc(data1, data2)
    return data1.id < data2.id
end

function M:_RefreshSignItems()
    for key, activityLogin in ipairs(self.activityLogins) do
        local UISignItemCtrl = self.tabUISignItemCtrl[key]
        if not UISignItemCtrl then
            UISignItemCtrl = self._view.UISignItemCtrl:Instantiate()
            tInsert(self.tabUISignItemCtrl, UISignItemCtrl)
        end
        local data = {}
        data.day = activityLogin.day
        data.reward = activityLogin.reward
        data.effectPosition = activityLogin.effectPosition
        data.awardShow = activityLogin.awardShow
        if activityLogin.day < self.m_CurNum then
            data.state = 2 -- 已经签到
        elseif activityLogin.day == self.m_CurNum then
            if not self.isSigned then
                data.state = 1 -- 可签到
            else
                data.state = 2 -- 已经签到
            end
        else
            data.state = 3 -- 不可签到
        end
        UISignItemCtrl:UpdateData(data)
        UISignItemCtrl:SetActive(true)
    end
    for i = #self.activityLogins + 1, #self.tabUISignItemCtrl do
        self.tabUISignItemCtrl[i]:SetActive(false)
    end
end

function M:_OnSignClick()
    self._view.signMask:SetActive(false)
    ActivityDataMgr:GetInstance():SendCommonReward(self.activityId, {1}, Bind(self, self._OnRewardCallBack), {1})
end

function M:_OnRewardCallBack(rewardData)
    self.tabUISignItemCtrl[self.m_CurNum]:SignFinish(Bind(self, self._RewardAnimCallBack, rewardData))
end

function M:_RewardAnimCallBack(award)
    local activityLogins = ConfigHelper.GetCfgsByLua("activityLogin", {day=self.m_CurNum, activityId=self.activityId})
    if #activityLogins <= 0 then
        Logger.LogError("活动配置错误")
        return
    end
    local rewardItemGroupId = activityLogins[1].reward
    local items = ConfigHelper.GetCfgPropByLua("itemGroup", rewardItemGroupId, "items")
    local itemId = items[1]

    local itemType = ConfigHelper.GetCfgPropByLua("item", itemId, "type")
    if itemType == ItemType.EIT_Hero then
        self.heroId = itemId
    end

    if self.heroId then
        local heroData = {ObjId=self.heroId}
        if not award.heroId then
            for ChipId, _ in pairs(award) do
                if self.heroId ~= ChipId then
                    heroData.ChipId = ChipId
                end
            end
        end
        self:_LuckDrawEnd({heroData})
    else
        GameHelper.ShowGetItems(award)
    end
    RedPointMgr:ForceCheck(RedPointConst.LoginAwardChecker)
end

-- 获得英雄 timeline表演
function M:_LuckDrawEnd(heroIds)
    -- self:Close()
    GameHelper.ShowRolesStarSuccess(heroIds)
end

function M:_AddItemInTab(tab, item)
    if tab[item.Id] then
        tab[item.Id] = tab[item.Id] + item.Cnt
        return
    end

    tab[item.Id] = item.Cnt
end

function M:OnDispose()
    self.m_ResponseCommonActivityAward = nil
    for _, value in ipairs(self.tabUISignItemCtrl) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end
    M.super.OnDispose(self)
end

return UISignCtrl
