local M = BaseClass("ResCopyActivityUICtrl", BaseUICtrl)

function M:Init()
    self.m_activityId = 0
    self.m_isAward = true -- 是否领奖
    local view = require("UI.View.Activity.ResCopyActivityItemView")
    local ctrl = require("UI.Ctrl.Activity.ResCopyActivityItemCtrl")
    self._view.looplist:Init(ctrl, view)
    self._view.btn_award:onClick(Bind(self, self.OnClickAward))
end

function M:OnEnter(actData)
    local chapters, datalist, roleActDic = CS.GameBase.JChapter.AllResource(), {}, {}
    self.m_activityId = actData:ActivityId()
    local timeFmt, endTime = "%y/%m/%d/%H:%M", actData:EndTime()
    local startTimeStr = TimeUtil.GetTimeFormat(actData:StartTime(), timeFmt)
    local endTimeStr = TimeUtil.GetTimeFormat(endTime, timeFmt)
    self._view.txt_actTime:SetText(startTimeStr .. "-" .. endTimeStr)
    self._view.txt_timer:SetTime(endTime)

    for _, value in ipairs(actData:RoleActivity() or {}) do
        local subId = value.SubActivityId
        if subId == 0 then
            self.m_isAward = TimeUtil.IsToday(value.Value1, TimeUtil.DailyRefreshTime)
            self._view.btn_award:SetState(self.m_isAward and 2 or 1)
        else
            roleActDic[subId] = value
        end
    end

    local cfgs = ConfigHelper.GetCfgsByLua("activityRes", { activityId = self.m_activityId }) or {}
    local activityRes = cfgs[1] or {}
    for i = 0, chapters.Length - 1 do
        local chapter = chapters[i]
        table.insert(datalist, {
            Chapter = chapter,
            LimitTimes = activityRes.times or 0,
            RoleAct = roleActDic[chapter.id]
        })
    end
    local itemId = activityRes.reward[1]
    self._view.img_icon:SetItemIcon(itemId)
    self._view.txt_name:SetItemName(itemId)
    self._view.txt_count:SetText('x' .. tostring(activityRes.reward[2]))

    table.sort(datalist, function(a, b) return a.Chapter.id < b.Chapter.id end)

    self._view.looplist:SetDataList(datalist)
end

function M:OnVisible()
    local data = ActivityDataMgr:GetInstance():GetActivityData(self.m_activityId)
    if data then
        local roleActDic = {}
        for _, v in ipairs(data:RoleActivity() or {}) do
            roleActDic[v.SubActivityId] = v
        end
        for _, v in ipairs(self._view.looplist:GetDataList()) do
            v.RoleAct = roleActDic[v.Chapter.id]
        end
        self._view.looplist:UpdateList()
    end
end

function M:OnClickAward(go)
    if (self.m_activityId <= 0) or self.m_isAward then return end
    ActivityDataMgr:GetInstance():SendCommonReward(self.m_activityId, { 0 }, Bind(self, self.OnRewardCallBack), { 0 })
end

function M:OnRewardCallBack(awardData)
    self.m_isAward = true
    self._view.btn_award:SetState(2)
    GameHelper.ShowGetItems(awardData)
    IRedPointMgr:ForceCheck(RedPointConst.ResActivityRewardRedPointChecker)
end

return M
