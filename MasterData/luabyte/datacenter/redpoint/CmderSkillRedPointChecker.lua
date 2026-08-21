local CmderSkillRedPointChecker = BaseClass("CmderSkillRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = CmderSkillRedPointChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    self.checkResult = CmderSkillMgr:CheckSkillLvUpRedPoint(param) and 1 or 0
end

return CmderSkillRedPointChecker