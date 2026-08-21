---自动生成代码----start----
local UIPayChooseView = BaseClass( 'UIPayChooseView' , BaseView )
local M = UIPayChooseView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.toggleAli = self:AddBaseCom( UIToggle ,'toggleAli')
  self.toggleWechat = self:AddBaseCom( UIToggle ,'toggleWechat')
  self.btnBuy = self:AddBaseCom( UIButton ,'btnBuy')
  self.btnBack = self:AddBaseCom( GameUIImage ,'btnBack')


end

return UIPayChooseView
---自动生成代码----end----