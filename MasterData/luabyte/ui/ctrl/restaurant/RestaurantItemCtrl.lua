-- 总览餐厅吃饭item
local RestaurantItemCtrl = BaseClass("RestaurantItemCtrl", UIBaseComponent)
local M = RestaurantItemCtrl
local ETableState = EnumConst.ETableState
local sfmt = string.format

function M:__init(view)
    self._view = view
    self._view:onClick(Bind(self, self._OnClick))
end

function M:UpdateData(data)
    self.data = data
    self:RefreshState()
end

function M:RefreshState()
    self._view.state:SetState(self.data.state)

    if self.data.state == ETableState.Use then
        -- 使用中
        self.resTimer = self.data.EndTick

        if self._timer then
            self._timer:Stop()
            self._timer = nil
        end

        self.useTime = 0
        self._timer = TimerManager:GetInstance():GetTimer(0.2, Bind(self, self.UpdateState), self)
        self._timer:Start()
        self._view.headImg:SetAvatarIcon(self.data.heroId, 1)
        self._view.bar.size = self.data.value
    elseif self.data.state == ETableState.Cleaning then
        -- 清洁中
        self.resTimer = self.data.EndTick

        if self._timer then
            self._timer:Stop()
            self._timer = nil
        end

        self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
        self._timer:Start()
        local strTimer = TimeUtil.SecToStringFormat(self.resTimer)
        self._view.labTime:SetText(strTimer)
    elseif self.data.state == ETableState.Lock then
        -- 未解锁
        local lockTips = ConfigHelper.GetLocalString(5606)
        lockTips = sfmt(lockTips, self.data.lockTips)
        self._view.lockText:SetText(lockTips)
    end
end

function M:TimerCallBack()
    self.resTimer = self.resTimer - 1

    if self.resTimer <= 0 then
        if self._timer then
            self._timer:Stop()
            self._timer = nil
            self.data.state = ETableState.None
            self:RefreshState()
        end

        self.resTimer = 0
    end

    local strTimer = TimeUtil.SecToStringFormat(self.resTimer)
    self._view.labTime:SetText(strTimer)
end

function M:GetUserId()
    if not self.data then
        return
    end
    return self.data.heroId
end

function M:UpdateState()
    self.useTime = self.useTime + 0.2
    self._view.bar.size = self.data.value + (1 - self.data.value) * self.useTime / 2

    if self.useTime >= 2 then
        self._timer:Stop()
        self._timer = nil
        self.data.state = ETableState.Cleaning
        self:RefreshState()
        EventMgr:Broadcast(UIMessageNames.COOKING_EATSUCCESS, self:GetUserId())
    end
end

function M:_OnClick()
    if self.data.state ~= ETableState.None then
        return
    end
    UIContextMgr:GetInstance():Show(UIDefine.UICookChooseHero, self.data.callBack, self.data.nullNum)
end


function M:OnDestroy()
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end

    M.super.OnDestroy(self)
end

return RestaurantItemCtrl
