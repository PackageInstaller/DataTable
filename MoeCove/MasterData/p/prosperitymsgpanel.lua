---@class ProsperityMsgPanel : ProsperityMsgPanel_Generate
---##################### 【ProsperityMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ProsperityMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ProsperityMsgPanel = require "ProsperityMsgPanel_Generate"

function ProsperityMsgPanel:InitLogic(data)

end

--function ProsperityMsgPanel:StartCreating(time)
--
--end

--function ProsperityMsgPanel:StartEnter(time)
--
--end

--function ProsperityMsgPanel:StartRemoving(time)
--
--end

--function ProsperityMsgPanel:StartExit(time)
--
--end

function ProsperityMsgPanel:OnOpen(data, initiative)
    local todayValue = 0
    local homeland = Me and Me:getHomeland()
    local prosperityInfo = homeland and homeland.prosperityInfo
    if prosperityInfo then
        todayValue = tonumber(prosperityInfo.dailyProsperityCount) or 0
    end

    local dailyLimit = tonumber(Config.GetConfigInfo("DailyPpLimit")) or 0
    if self.todayValuetTxt and self.todayValuetTxt.text then
        self.todayValuetTxt.text.text = string.format("<color=#1B8AE6>%s</color>/%s", todayValue, dailyLimit)
    end
end

--function ProsperityMsgPanel:OnClose(initiative)
--
--end

--function ProsperityMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ProsperityMsgPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function ProsperityMsgPanel:mask_Button_onClick(mask)
    UIMgr:closeUI(self)
end

--[[
/BoxBg/TitleSideBg/CloseBtn onClick 
--]]
function ProsperityMsgPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UIMgr:closeUI(self)
end

return ProsperityMsgPanel
