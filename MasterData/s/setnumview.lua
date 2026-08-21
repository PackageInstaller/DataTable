---@class SetNumView : SetNumView_Generate
---##################### 【SetNumView Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SetNumView Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SetNumView = require "SetNumView_Generate"

function SetNumView:InitLogic(data)

end

---@param data {maxNum:int, minNum:int?, curVal:int?, titleText:string?, onValueChange:fun(curVal:int)}
function SetNumView:SetData(data)
    self.data = data
    data.minNum = data.minNum or 1
    data.curVal = data.curVal or 1

    if data.titleText ~= nil then
        self.titleText.text.text = data.titleText
    end

    self.minText.text.text = tostring(data.minNum)
    self.maxText.text.text = tostring(math.max(data.minNum, data.maxNum))

    
    self.ignoreSliderEvent = true
    self.numSlider.slider.minValue = data.minNum
    self.numSlider.slider.maxValue = math.max(data.minNum, data.maxNum)
    if data.maxNum <= 1 then
       self.numSlider.slider.minValue = 0
       self.numSlider.slider.maxValue = 1
       data.curVal = 1
    end
    self.ignoreSliderEvent = nil
    self.curNumText.text.text = tostring(data.curVal)
    self:SetCurVal(data.curVal)

end

--function SetNumView:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/minusBtn onClick 
--]]
function SetNumView:minusBtn_ScaleButton_onClick(minusBtn)
    self:SetCurVal(self.data.curVal - 1)
end

--[[
/plusBtn onClick 
--]]
function SetNumView:plusBtn_ScaleButton_onClick(plusBtn)
    self:SetCurVal(self.data.curVal + 1)
end

--[[
/maxBtn onClick 
--]]
function SetNumView:maxBtn_ScaleButton_onClick(maxBtn)
    self:SetCurVal(self.data.maxNum)
end

--[[
/numSlider onValueChanged 
--]]
function SetNumView:numSlider_Slider_onValueChanged(numSlider, value)
    if self.ignoreSliderEvent then
       return 
    end
    local val = math.floor(value)
    self:SetCurVal(val)
end

function SetNumView:SetCurVal(val, a)
    if self.data.maxNum < self.data.minNum then
        if val ~= 1 then
            LuaLogger.es("設置數量錯誤 curVal:" .. val .. "  dump:" .. tablex.dump(self.data))
            return
        end
    else
        if val < self.data.minNum or val > self.data.maxNum then
            LuaLogger.es("設置數量錯誤 curVal:" .. val .. "  dump:" .. tablex.dump(self.data))
        end
    end

    self.data.curVal = val
    self.ignoreSliderEvent = true
    self.numSlider.slider.value = val
    self.ignoreSliderEvent = nil

    self.minusBtn.scaleButton.interactable = val > 1
    self.plusBtn.scaleButton.interactable = val < self.data.maxNum
    self.maxBtn.scaleButton.interactable = val < self.data.maxNum
    self.numSlider.slider.interactable = self.data.maxNum > self.data.minNum
    self.curNumText.text.text = tostring(val)

    if self.data.onValueChange ~= nil and not a then
       self.data.onValueChange(val) 
    end
end

return SetNumView
