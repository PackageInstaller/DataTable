local RoleAwakeShowCtrl = BaseClass("RoleAwakeShowCtrl", BaseUICtrl)
local M = RoleAwakeShowCtrl

function M:Init()
    self._view.CloseBg.gameObject:onClick(Bind(self, self._OnClickClose))
end

function M:OnEnter(heroId, closeCallback)
    self._heroId = heroId
    self._closeCallback = closeCallback
    self._cfg = ConfigHelper.GetCfg("awakeShow", self._heroId)
    self:_SetShowInfo()

end

function M:OnShow()
    if self._timer then
        self._timer:Stop()
    end
    self._timer = TimerManager:GetInstance():GetTimer(0.3, Bind(self, self._WaitForAnim), self, true)
    self._timer:Start()

end

function M:_SetShowInfo()
    self._view.roleMask2:SetPic(self._cfg.roleMask2)
    self._view.head:SetPic(self._cfg.head)
    self._view.closeEye:SetPic(self._cfg.closeEye, true)
    self._view.closeEye.transform:SetLocalPos(self._cfg.closeEyeCoord[1] / 1000, self._cfg.closeEyeCoord[2] / 1000)
    self._view.openEye:SetPic(self._cfg.openEye, true)
    self._view.openEye.transform:SetLocalPos(self._cfg.openEyeCoord[1] / 1000, self._cfg.openEyeCoord[2] / 1000)
    self._view.roleIllustration:SetPic(self._cfg.roleIllustration)
    self._view.text1:SetPic(self._cfg.text1,true)
    self._view.text2:SetPic(self._cfg.text2,true)
    self._view.roleMask1:SetPic(self._cfg.roleMask1)
    self._view.illustrationImage:SetPic(self._cfg.illustrationImage)
    local r = self._cfg.titleBgShadow[1] -- /255
    local g = self._cfg.titleBgShadow[2] -- /255
    local b = self._cfg.titleBgShadow[3] -- /255
    self._view.titleBgShadow:SetColor(r, g, b, 255)
    self._view.engName:SetColor(r, g, b, 255)
    self._view.engName:SetAvatarEnName(self._heroId, RoleType.ERT_Hero)
end

function M:_LoadHeroAwakeShow()
    local cfg = ConfigHelper.GetCfg("resource", self._heroId)
    local go = ResourceManager:GetInstance():InstanceGameObject(cfg.awakeShow)
    go.transform:SetParent(self._view.transform)
    go.transform:Reset()
end

function M:_WaitForAnim()
    if self._timer then
        self._view.text1:SetPic(self._cfg.text1, true)
        self._view.text2:SetPic(self._cfg.text2, true)
        self._timer:Stop()
        self._timer = nil
    end
end

function M:_OnClickClose()
    self:Close()
end

function M:OnClose()
    if self._closeCallback then
        self._closeCallback()
    end
    self._closeCallback = nil
end

function M:OnDispose()
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
    M.super.OnDispose(self)
end

return RoleAwakeShowCtrl
