---自动生成代码----start----
local BridgeCabinUpgradeItemView = BaseClass( 'BridgeCabinUpgradeItemView' , BaseView )
local M = BridgeCabinUpgradeItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_label = self:AddBaseCom( GameUIText ,'txt_label')
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.img_number = self:AddBaseCom( GameUIImage ,'img_number')


end

return BridgeCabinUpgradeItemView
---自动生成代码----end----