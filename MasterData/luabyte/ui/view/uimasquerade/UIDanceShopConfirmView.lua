---自动生成代码----start----
local UIDanceShopConfirmView = BaseClass( 'UIDanceShopConfirmView' , BaseView )
local M = UIDanceShopConfirmView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labName1 = self:AddBaseCom( GameUIText ,'labName1')
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labDesc = self:AddBaseCom( GameUIText ,'labDesc')
  self.imgCost1 = self:AddBaseCom( GameUIImage ,'imgCost1')
  self.labPrice = self:AddBaseCom( GameUIText ,'labPrice')
  self.labHave = self:AddBaseCom( GameUIText ,'labHave')
  self.labName2 = self:AddBaseCom( GameUIText ,'labName2')
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.btnMin = self:AddBaseCom( GameUIImage ,'btnMin')
  self.btnSub = self:AddBaseCom( GameUIImage ,'btnSub')
  self.labSelectNum = self:AddBaseCom( GameUIText ,'labSelectNum')
  self.btnAdd = self:AddBaseCom( GameUIImage ,'btnAdd')
  self.btnMax = self:AddBaseCom( GameUIImage ,'btnMax')
  self.labCanBuyNum = self:AddBaseCom( GameUIText ,'labCanBuyNum')
  self.btn = self:AddBaseCom( GameUIImage ,'btn')
  self.imgCost2 = self:AddBaseCom( GameUIImage ,'imgCost2')
  self.labAllCost = self:AddBaseCom( GameUIText ,'labAllCost')
  self.btnMask =   self._binder:GetValue('btnMask')  


end

return UIDanceShopConfirmView
---自动生成代码----end----