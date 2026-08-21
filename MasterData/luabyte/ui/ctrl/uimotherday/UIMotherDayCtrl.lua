-- baoruichang
-- 2023/4/4 16:42:08
local UIMotherDayCtrl = BaseClass("UIMotherDayCtrl", BaseUICtrl)
local M = UIMotherDayCtrl
local UIMotherDayItemCtrl = require("UI.Ctrl.UIMotherDay.UIMotherDayItemCtrl")
local UIMotherDayItemView = require("UI.View.UIMotherDay.UIMotherDayItemView")
local ItemType = BagConst.ItemType
local tInsert = table.insert
local tSort = table.sort
local HOURS5 = 18000
-- collectstars
function M:Init()
    self.grid = self._view.grid
    self.grid:Init(UIMotherDayItemCtrl, UIMotherDayItemView)
    self.grid:SetCreateItemCallback(Bind(self, self._OnCreateItem))
end

-- 进入UI，可传参数
function M:OnEnter(activityId, cRoleActivity, callBack)
    self.activityId = activityId
    self.cRoleActivity = cRoleActivity
    self._CallBack = callBack

    self:_initData()

    self:_RefreshTime()
    self:_RefreshSignItems()
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
    self.m_CurNum = self.m_CurNum > self.dataNum and self.dataNum or self.m_CurNum
end

function M.SortFunc(data1, data2)
    return data1.id < data2.id
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

    local str = startTime.Year .. "." .. startTime.Month .. "." .. startTime.Day .. "—" .. endTime.Year .. "." .. endTime.Month .. "." .. endTime.Day
    self._view.timeLabel:SetText(str)
end

function M:_RefreshSignItems()
    self.gridData = {}
    local name
    for _, activityLogin in ipairs(self.activityLogins) do
        local data = {}
        data.id = activityLogin.id
        data.day = activityLogin.day
        data.reward = activityLogin.reward
        data.effectPosition = activityLogin.effectPosition
        data.awardShow = activityLogin.awardShow

        local itemGroup = ConfigHelper.GetCfgByLua("itemGroup", data.reward)
        local itemId = itemGroup.items[1]
        local itenNum = itemGroup.cnts[1]
        name = ConfigHelper.GetCfgPropByLua("item", itemId, "name")
        name = ConfigHelper.GetLocalString(name) .. "x" .. itenNum

        data.name = name
        if activityLogin.day < self.m_CurNum then
            data.state = 3 -- 已经签到
        elseif activityLogin.day == self.m_CurNum then
            if not self.isSigned then
                data.state = 2 -- 可签到
            else
                data.state = 3 -- 已经签到
            end
        else
            data.state = 1 -- 不可签到
        end
        tInsert(self.gridData, data)
    end
    self.grid:SetDataList(self.gridData)
    if self.m_CurNum > 3 then
        self.grid:SetVerticalNormalizedByIndex(self.m_CurNum)
    end
end

function M:_OnCreateItem(UIMotherDayItemCtrl)
    UIMotherDayItemCtrl:ClickCallback(Bind(self, self._OnClickItem))
end

function M:_OnClickItem(id)
    ActivityDataMgr:GetInstance():SendCommonReward(self.activityId, {id}, Bind(self, self._OnRewardCallBack), {1})
end

function M:_OnRewardCallBack(award)
    local list = self.grid:GetItems()
    local UIMotherDayItemCtrl
    for _, tempUIMotherDayItemCtrl in pairs(list) do
        local data = tempUIMotherDayItemCtrl.data
        if data.day == self.m_CurNum then
            UIMotherDayItemCtrl = tempUIMotherDayItemCtrl
            break
        end
    end
    if UIMotherDayItemCtrl then
        local data = UIMotherDayItemCtrl.data
        data.state = 3
        UIMotherDayItemCtrl:UpdateItem(data)
        UIMotherDayItemCtrl:PlayReceiveAnim(Bind(self, self._RewardAnimCallBack, award))
    else
        self:_RewardAnimCallBack(award)
    end
end

function M:_RewardAnimCallBack(award)
    for itemId, num in pairs(award) do
        local itemType = ConfigHelper.GetCfgPropByLua("item", itemId, "type")
        if itemType == ItemType.EIT_Hero then
            self.heroId = itemId
        end
    end
    if self.heroId then
        local heroData = {ObjId=self.heroId}
        for ChipId, _ in pairs(award) do
            if self.heroId ~= ChipId then
                heroData.ChipId = ChipId
            end
        end
        self:_LuckDrawEnd({heroData})
    else
        GameHelper.ShowGetItems(award)
    end
end

-- 获得英雄 timeline表演
function M:_LuckDrawEnd(heroIds)
    self:Close()
    GameHelper.ShowRolesStarSuccess(heroIds, self._CallBack)
end

function M:OnClose()
    if self._CallBack then
        self._CallBack()
    end
end

return UIMotherDayCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O. = /O
--                        ____/`---'.____
--						  . ' ..| |// `.
--                       / ..||| : |||// .
--                     / _||||| -:- |||||- .
--                       | | ... - --/ | |
--                     | ._| ''.---/'' | |
--                      . .-.__ `-` ___/-. /
--                   ___`. .' /--.--. `. . __
--                ."" '< `.___._<|>_/___.' >'"".
--               | | : `- .`.;`. _ /`;.`/ - ` : | |
--                 . . `-. ._ __. /__ _/ .-` / /
--         ======`-.____`-.___._____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                  佛祖镇楼                  BUG辟易
--          佛曰:
--                  写字楼里写字间，写字间里程序员；
--                  程序人员写程序，又拿程序换酒钱。
--                  酒醒只在网上坐，酒醉还来网下眠；
--                  酒醉酒醒日复日，网上网下年复年。
--                  但愿老死电脑间，不愿鞠躬老板前；
--                  奔驰宝马贵者趣，公交自行程序员。
--                  别人笑我忒疯癫，我笑自己命太贱；
--                  不见满街漂亮妹，哪个归得程序员？

