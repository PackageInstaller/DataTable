-- baoruichang
-- 2022/6/14 10:36:04
-- MissionHeroLvTips
local UIMissionLvCtrl = BaseClass("UIMissionLvCtrl", BaseUICtrl)
local M = UIMissionLvCtrl

function M:Init()
    self._view.btnMask:SetOnClick(self,self._OnBtnMaskClick)
    self._view.toggleNoTips:OnToggleClick(Bind(self,self._OnToggleChanged))
    self._view.btnDevelop:SetOnClick(self,self._OnBtnDevelop)
end

-- 进入UI，可传参数
function M:OnEnter(callback, isOffToggle)
    self._callback = callback
    self._view.tfTips.gameObject:SetActive(false)
    self.resTimer = ConfigHelper.GetSystemParam(253) or 10000
    self.resTimer =  self.resTimer/1000
    self._timer = TimerManager:GetInstance():GetTimer(self.resTimer, Bind(self, self.TimerCallBack), self,true)
    self._timer:Start()
    self:SetToggle(not isOffToggle)
end

function M:SetToggle(isShow)
    self._view.toggle:SetActive(isShow)
end

function M:_OnBtnMaskClick()
    if self.resTimer>0 then
        return
    end
    self:Close()

    if self._callback then
        self._callback()
    end 
end

function M:_OnBtnDevelop()
    self:Close()
    TeamConfMgr:GetInstance():SetBattle(true)
    JumpMgr:GetInstance():Execute(68)
end

function M:_OnToggleChanged(isOn)
    -- Logger.LogError("isOn".. tostring(isOn))
    GlobalTeamConfMgr:GetInstance().Mgr:SetNotTips(isOn)
end

function M:TimerCallBack()
    
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
    self.resTimer = 0
    self._view.tfTips.gameObject:SetActive(true)
end


function M:OnDispose()
    M.super.OnDispose(self)
end

return UIMissionLvCtrl
