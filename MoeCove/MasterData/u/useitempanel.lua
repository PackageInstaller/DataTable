---@class UseItemPanel : UseItemPanel_Generate
---##################### 【UseItemPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【UseItemPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local UseItemPanel = require "UseItemPanel_Generate"
local SetNumView = require("SetNumView")
function UseItemPanel:InitLogic(data)

    ---@type SetNumView
    local lua_setNumView = SetNumView:new(self.setNumView.gameObject)
    lua_setNumView:InitGenerate()
    self.lua_setNumView = lua_setNumView
end

--function UseItemPanel:StartCreating(time)
--
--end

--function UseItemPanel:StartEnter(time)
--
--end

--function UseItemPanel:StartRemoving(time)
--
--end

--function UseItemPanel:StartExit(time)
--
--end

function UseItemPanel:OnOpen(data, initiative)
    local itemId = data.itemId
    self.itemId = data.itemId
    self.callback = data.callback

    local itemInfo = Me:getItemById(itemId)
    if itemInfo == nil then
       return 
    end
    local itemCfg = Config.GetItemInfo(itemId)
    if itemCfg == nil then
        return    
    end

    local name = itemCfg.itemName
    local desc = itemCfg.describe
    local icon = string.format(Config.SpritePath.ItemIconPath, itemCfg.icon)	
    local quality = itemCfg.quality
    self:LoadSpriteAsync(icon, self.iconImg.image)

    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme3, quality), self.qualityImg.image)
    self.nameText.text.text = name
    self.discribeText.text.text = desc

    local ownCount = Me:getItemCountById(itemId)
    self.ownItemText.text.text = string.format("拥有:" .. tostring(ownCount))
   
    self.maxNum = ownCount
    self.lua_setNumView:SetData({
        maxNum = ownCount,
        onValueChange = function(curVal)
            self:SetItemCount(curVal)
        end
    })

    self:playOpenAnim()
end

--function UseItemPanel:OnClose(initiative)
--
--end

--function UseItemPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function UseItemPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function UseItemPanel:mask_Button_onClick(mask)
    self:playCloseAnim()
end

--[[
/BoxBg/titleInfo/closeBtn onClick 
--]]
function UseItemPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:playCloseAnim()
end

--[[
/BoxBg/SetNumView/minusBtn onClick 
--]]
function UseItemPanel:minusBtn_ScaleButton_onClick(minusBtn)

end

--[[
/BoxBg/SetNumView/plusBtn onClick 
--]]
function UseItemPanel:plusBtn_ScaleButton_onClick(plusBtn)

end

--[[
/BoxBg/SetNumView/maxBtn onClick 
--]]
function UseItemPanel:maxBtn_ScaleButton_onClick(maxBtn)

end

--[[
/BoxBg/SetNumView/numSlider onValueChanged 
--]]
function UseItemPanel:numSlider_Slider_onValueChanged(numSlider,value)

end

--[[
/BoxBg/buyInfo/cancleBtn onClick 
--]]
function UseItemPanel:cancleBtn_ScaleButton_onClick(cancleBtn)

end

--[[
/BoxBg/buyInfo/buyBtn onClick 
--]]
function UseItemPanel:buyBtn_ScaleButton_onClick(buyBtn)

end

--[[
/BoxBg/buyInfo/disableBuyBtn onClick 
--]]
function UseItemPanel:disableBuyBtn_ScaleButton_onClick(disableBuyBtn)

end

--[[
/BoxBg/useBtn onClick 
--]]
function UseItemPanel:useBtn_ScaleButton_onClick(useBtn)
    Me:openGiftPackReq({id = self.itemId, num = self.selectNum}, function()
        GameMsgMgr:sendEvent(GameMsgType.RefreshWarehousePanel)
        self:playCloseAnim()
    end)
end

function UseItemPanel:SetItemCount(val)
    self.selectNum = val
end

function UseItemPanel:playOpenAnim()
    self.animation:Play("Init")
end

function UseItemPanel:playCloseAnim()
    self.animation:Play("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

return UseItemPanel
