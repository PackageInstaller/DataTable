
--
-- <代码文件解释说明>
--

---@class UIFightSoulInfoCtrl
---@field model UIFightSoulInfoModel
local UIFightSoulInfoCtrl = BaseClass("UIFightSoulInfoCtrl",UIBaseCtrl)
local this = UIFightSoulInfoCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIFightSoulInfo)
end

function this:ChangeLock()
    PublicRequest.SendRequest(
        PROTOCOL.FightSoulSetLockingReq,
        {
            uid = self.model.id,
            lock = not self.model.fightSoul.Lock
        },
        nil
    )
end

return this
