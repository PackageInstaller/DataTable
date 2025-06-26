
--
-- <代码文件解释说明>
--

---@class UIBossraidTeamInfoCtrl
---@field model UIBossraidTeamInfoModel
local UIBossraidTeamInfoCtrl = BaseClass("UIBossraidTeamInfoCtrl",UIBaseCtrl)
local this = UIBossraidTeamInfoCtrl

function this:CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIBossraidTeamInfo)
end

return this
