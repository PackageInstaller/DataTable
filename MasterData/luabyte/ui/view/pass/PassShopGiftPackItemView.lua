---自动生成代码----start----
local PassShopGiftPackItemView = BaseClass( 'PassShopGiftPackItemView' , BaseView )
local M = PassShopGiftPackItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uiState =   self._binder:GetValue('uiState')  
  self.item =   self._binder:GetValue('item')  
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')


end

return PassShopGiftPackItemView
---自动生成代码----end----