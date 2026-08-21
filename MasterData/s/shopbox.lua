---@class ShopBox : ShopBox_Generate
---##################### 【ShopBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ShopBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ShopBox = require "ShopBox_Generate"

function ShopBox:InitLogic(data)
    self._buyBtnFunc = nil
end

--购买监听
function ShopBox:SetBuyListener(func)
    self._buyBtnFunc = func
end

--设置图片
function ShopBox:SetIconSprite(sprite)
    self.icon.image.sprite = sprite
end

--购买按钮txt
function ShopBox:SetBuyText(str)
    self.buyBtn.txt.text.text = str
end

--商品描述txt
function ShopBox:SetDescText(str)
    self.priceTxt.text.text = str
end

--首充双倍显隐
function ShopBox:DoubleTipsSetActive(bool)
    self.double:SetActive(bool)
end
--function ShopBox:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/bg/BuyBtn onClick  购买
--]]
function ShopBox:buyBtn_ScaleButton_onClick(buyBtn)
    if self._buyBtnFunc then
        self._buyBtnFunc()
    end
end

return ShopBox
