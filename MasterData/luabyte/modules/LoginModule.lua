local LoginModule = BaseClass("LoginModule", require("Framework.Module.BaseGameModule"))
local M = LoginModule

function M:OnEnter(state)
    self._state = state
    --self:LoadScene("LandShow", Bind(self, self.OnLoadComplete))
    self:OnLoadComplete()
end

function M:OnLoadComplete(tops)
    self:ShowUI("LoginUI")
    self:ShowUI("ScreenTapUI")
    self:Ready()
    INetPack.gameNetState = CS.NetBase.EGameNetState.EGNS_Login
    self:ShowUI("WalkingLanternTips")
    if self._state ~= 0 then
        self:ShowUI("Notice", true, true)
    end
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.LoginInterface)
end

function M:OnExit()
    M.super.OnExit(self)
    self:CloseUI("LoginUI")
end

return LoginModule
