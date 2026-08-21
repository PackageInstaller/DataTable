-- baoruichang
-- 2023/6/12 15:19:16
-- UITurntableTask
local UITurntableTaskCtrl = BaseClass("UITurntableTaskCtrl", BaseUICtrl)
local M = UITurntableTaskCtrl
local ECycleEvent = protocol.ECycleEvent
local UITurnTaskItemCtrl = require("UI.Ctrl.UITurntable.UITurnTaskItemCtrl")
local UITurnTaskItemView = require("UI.View.UITurntable.UITurnTaskItemView")
local EActivityState = EnumConst.EActivityState

function M:Init()
    self.grid = self._view.grid
    self.grid:Init(UITurnTaskItemCtrl, UITurnTaskItemView)
    self.grid:SetCreateItemCallback(Bind(self, self._createItemCallBack))
end

-- 进入UI，可传参数
function M:OnEnter(activityData)
    self.activityData = activityData
    self.activityId = activityData:ActivityId()
    -- 每日任务活跃度
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(ECycleEvent.ECET_Daily_Task)
    local currentValue = cycleData:GetField0()
    self.activityTurntableTasks = ConfigHelper.GetCfgsByLua("activityTurntableTask", {activityId=self.activityId})
    for _, activityTurntableTask in pairs(self.activityTurntableTasks) do
        activityTurntableTask.currentValue = currentValue
        -- 刚哥说从第0位开始所有用id-1
        if self.activityData:CheckReward(activityTurntableTask.id - 1) then
            activityTurntableTask.state = EActivityState.Completed
        elseif currentValue >= activityTurntableTask.limitValue1 then
            activityTurntableTask.state = EActivityState.Finished
        else
            activityTurntableTask.state = EActivityState.Doing
        end
    end
    self.grid:SetDataList(self.activityTurntableTasks)
end

function M:_createItemCallBack(UITurnTaskItemCtrl)
    UITurnTaskItemCtrl:SetClickCallBack(Bind(self, self._onClick))
end

function M:_onClick(id)
    self.selelctId = id
    ActivityDataMgr:GetInstance():SendCommonReward(self.activityId, {id}, Bind(self, self._OnRewardCallBack))
end

-- 领取回调函数
function M:_OnRewardCallBack(awardData)
    GameHelper.ShowGetItems(awardData)
    local tempActivityTurntableTask
    for _, activityTurntableTask in pairs(self.activityTurntableTasks) do
        if activityTurntableTask.id == self.selelctId then
            if self.activityData:CheckReward(activityTurntableTask.id - 1) then
                activityTurntableTask.state = EActivityState.Completed
                tempActivityTurntableTask = activityTurntableTask
                break
            end
        end
    end
    -- 只刷新这一个item 
    local UITurnTaskItemCtrls = self.grid:GetItems()
    for _, UITurnTaskItemCtrl in pairs(UITurnTaskItemCtrls) do
        if UITurnTaskItemCtrl:GetData() == self.selelctId then
            if tempActivityTurntableTask then
                UITurnTaskItemCtrl:UpdateItem(tempActivityTurntableTask)
            end
            break
        end
    end
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return UITurntableTaskCtrl
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
--                     | ._| ''.---/'' |_. |
--                     \ .-.\__ `-` ___/-. /
--                   ___`. .' /--.--. `. . __
--                ."" '< `.___._<|>_/___.' >'"".
--               | | : `- .`.;`. _ /`;.`/ - ` : | |
--                 \ \ `-. ._ __. /__ _/ .-` / /
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

