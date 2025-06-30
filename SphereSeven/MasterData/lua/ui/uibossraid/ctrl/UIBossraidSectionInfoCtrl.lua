
--
-- <代码文件解释说明>
--

---@class UIBossraidSectionInfoCtrl
---@field model UIBossraidSectionInfoModel
local UIBossraidSectionInfoCtrl = BaseClass("UIBossraidSectionInfoCtrl",UIBaseCtrl)
local this = UIBossraidSectionInfoCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIBossraidSectionInfo)
end

return this
