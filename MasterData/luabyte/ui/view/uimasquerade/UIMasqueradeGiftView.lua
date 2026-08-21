---自动生成代码----start----
local UIMasqueradeGiftView = BaseClass( 'UIMasqueradeGiftView' , BaseView )
local M = UIMasqueradeGiftView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnBack =   self._binder:GetValue('btnBack')  
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labDes = self:AddBaseCom( GameUIText ,'labDes')
  self.tfContent =   self._binder:GetValue('tfContent')  


end

return UIMasqueradeGiftView
---自动生成代码----end----