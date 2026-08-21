local RewardCtrl = require("UI.Ctrl.Achievement.AchievementRewardCtrl")
local RewardView = require("UI.View.Achievement.AchievementRewardView")
local AchievementContentItemCtrl = BaseClass("AchievementContentItemCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = AchievementContentItemCtrl



function M:ClickCallback(callback)
    self._callback = callback
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data
    local cfg = data:Config()
    local state = data:State()
    local reward = cfg.reward
    local progress = string.format("%d/%d", data:CurProgress()[1], data:MaxProgress()[1])

    self._view.icon:SetPic(cfg.icon)
    self._view.name:SetText(cfg.name)
    self._view.desc:SetText(cfg.des)
    self._view.num:SetText(progress)

    self:_SetReward(cfg)
    self:_SetState(state)
end

function M:_SetReward(data)
    for i = 1, 2 do
        local viewName = string.format("reward%d", i)
        local view = RewardView.New(self._view[viewName])
        local ctrl = RewardCtrl.New(view)
        local name = string.format("_rewardCtrl%d", i)
        ctrl:SetActive(false)
        self[name] = ctrl
    end
   
    if #data.reward > 0 then
        self._rewardCtrl1:UpdateItem(data.reward[1], data.reward[2])
    end
    self._rewardCtrl1:SetActive(#data.reward > 0)
    if   data.integral>0 then
        self._rewardCtrl2:UpdateItem(75, data.integral, data.integralIcon)
    end
    self._rewardCtrl2:SetActive(data.integral>0)
end

function M:_SetState(state)
    for i = 0, 2 do
        local name = string.format("state%d", i)
        local isShow = state == i
        self._view[name]:SetActive(isShow)
    end

    if state == 2 then
        local time = self._data:FinishTime()
        local date = GameHelper.GetDateTime(time)
        local str = date.Year .. "/" .. date.Month .. "/" .. date.Day
        self._view.day:SetText(str)
    end
end

function M:Init()
    self._rewardCtrl1 = nil
    self._rewardCtrl2 = nil
    self._view.rewardBtn:onClick(Bind(self, self._OnClickItem))
    self:ShowPanel()
end

function M:_OnClickItem()
    self._callback(self._data:Id())
end

function M:OnRewardCallBack(data)
    self:UpdateItem(data)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
    M.super.OnDispose(self)
end

return AchievementContentItemCtrl
