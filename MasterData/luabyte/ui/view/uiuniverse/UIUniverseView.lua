---自动生成代码----start----
local UIUniverseView = BaseClass( 'UIUniverseView' , BaseView )
local M = UIUniverseView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnShop = self:AddBaseCom( GameUIImage ,'btnShop')
  self.btnTask = self:AddBaseCom( GameUIImage ,'btnTask')
  self.labTimer = self:AddBaseCom( GameUIText ,'labTimer')
  self.uiState1 =   self._binder:GetValue('uiState1')  
  self.uiState2 =   self._binder:GetValue('uiState2')  
  self.labTips = self:AddBaseCom( GameUIText ,'labTips')
  self.btn1 =   self._binder:GetValue('btn1')  
  self.btn2 =   self._binder:GetValue('btn2')  


end

return UIUniverseView
---自动生成代码----end----