
--
-- <代码文件解释说明>
--

---@class UIEquipScrapCtrl
---@field model UIEquipScrapModel
local UIEquipScrapCtrl = BaseClass("UIEquipScrapCtrl",UIBaseCtrl)
local this = UIEquipScrapCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIEquipScrap)
end

return this
