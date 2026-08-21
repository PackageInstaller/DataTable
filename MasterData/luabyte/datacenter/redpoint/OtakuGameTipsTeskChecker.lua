local OtakuGameTipsTeskChecker = BaseClass("OtakuGameTipsTeskChecker" , require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = OtakuGameTipsTeskChecker


function M:Check(id)
    if not self:OnChanged(id) then
        self.checkResult = 0
        return
    end

    local isLook = PlayerPrefabHelper.GetBool("GamePlayExplain".. id)
    self.checkResult = isLook and 0 or 1
end


return OtakuGameTipsTeskChecker