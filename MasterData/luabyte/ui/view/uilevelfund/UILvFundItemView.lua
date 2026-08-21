---自动生成代码----start----
local UILvFundItemView = BaseClass( 'UILvFundItemView' , BaseView )
local M = UILvFundItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labTitle = self:AddBaseCom( GameUIText ,'labTitle')
  self.ItemPfb1 =   self:AddValue('UI.Ctrl.UILevelFund.UILvFundItemPfbCtrl','UI.View.UILevelFund.UILvFundItemPfbView','ItemPfb1')  
  self.ItemPfb2 =   self:AddValue('UI.Ctrl.UILevelFund.UILvFundItemPfbCtrl','UI.View.UILevelFund.UILvFundItemPfbView','ItemPfb2')  


end

return UILvFundItemView
---自动生成代码----end----