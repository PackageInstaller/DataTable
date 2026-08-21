---@class UseCountPanel : UseCountPanel_Generate
---##################### 【UseCountPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【UseCountPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local UseCountPanel = require "UseCountPanel_Generate"

function UseCountPanel:InitLogic(data)
    self.nowCount = 1
end

--function UseCountPanel:StartCreating(time)
--
--end

--function UseCountPanel:StartEnter(time)
--
--end

--function UseCountPanel:StartRemoving(time)
--
--end

--function UseCountPanel:StartExit(time)
--
--end

function UseCountPanel:OnOpen(data, initiative)
    local itemConfig = Config.GetItemInfo(data)
    self.itemData = Me:getItemById(data)
    self.countText.text.text = self.nowCount
end

function UseCountPanel:changeCount(count)
    if count > self.itemData.num or count <= 0 then
        return
    end
    self.nowCount = count
    self.countText.text.text = self.nowCount
end

--function UseCountPanel:OnClose(initiative)
--
--end

--function UseCountPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function UseCountPanel:OnRefresh(data)
--
--end

--[[
/mask onClick 
--]]
function UseCountPanel:mask_Button_onClick(mask)
    UIMgr:closeUI(self)
end

--[[
/PanelBg/Art/TitleBg/CloseBtn onClick 
--]]
function UseCountPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UIMgr:closeUI(self)
end

--[[
/PanelBg/PlusBtn onClick 
--]]
function UseCountPanel:plusBtn_ScaleButton_onClick(plusBtn)
    self:changeCount(self.nowCount + 1)
end

--[[
/PanelBg/MinusBtn onClick 
--]]
function UseCountPanel:minusBtn_ScaleButton_onClick(minusBtn)
    self:changeCount(self.nowCount - 1)
end

--[[
/PanelBg/CancelBtn onClick 
--]]
function UseCountPanel:cancelBtn_ScaleButton_onClick(cancelBtn)
    UIMgr:closeUI(self)
end

--[[
/PanelBg/OkBtn onClick 
--]]
function UseCountPanel:okBtn_ScaleButton_onClick(okBtn)
    --TODO: 暂无功能
end

return UseCountPanel
