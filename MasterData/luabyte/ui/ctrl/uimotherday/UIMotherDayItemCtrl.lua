local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIMotherDayItemCtrl = BaseClass("UIMotherDayItemCtrl", CircularScrollViewItem)
local M = UIMotherDayItemCtrl
local dayPicPath = "UI/SpritePics/activity/ui_threeday_collectstars_list_text_"

function M:__init(view)
    self._view = view
    self._view.btn:onClick(Bind(self, self._OnClick))
end

function M:UpdateItem(data)
    self.data = data
    self._view.state:SetState(data.state)
    self._view.imgDay:SetPic(dayPicPath .. self.data.day)
    self._view.labName:SetText(data.name)
    local items = ConfigHelper.GetCfgByLua("itemGroup", self.data.reward) or {}
    self._view.itemPfb:SetInfo(items.items[1], ItemNumberType.TOTLE, items.cnts[1])
    self._view.itemPfb:EnablePopItem(true)
    if self.data.state == 2 then
        self._view.itemPfb.onClick = Bind(self, self._OnClick)
    else
        self._view.itemPfb.onClick = nil
    end
end

function M:_OnClick()
    if self.data.state ~= 2 then
        return
    end
    if self.callBack then
        self.callBack(self.data.id)
    end
end

function M:ClickCallback(callBack)
    self.callBack = callBack
end

function M:PlayReceiveAnim(callback)
    self.receiveAnimCallBack = callback
    self._view.animReward:Play("MonthlySignUI_eff", 0, 0)
    local animTime = self._view.animReward.runtimeAnimatorController.animationClips[0].length
    self._timer = TimerManager:GetInstance():GetTimer(animTime, Bind(self, self._OnEndAnimCallBack), self, true)
    self._timer:Start()
end

function M:_OnEndAnimCallBack()
    if self.receiveAnimCallBack then
        self.receiveAnimCallBack()
    end
    self._timer = nil
end

function M:OnDispose()
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
    M.super.OnDispose(self)
end

return UIMotherDayItemCtrl
