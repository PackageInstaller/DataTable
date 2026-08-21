---自动生成代码----start----
local EncounterAwardDetailsItemView = BaseClass( 'EncounterAwardDetailsItemView' , BaseView )
local M = EncounterAwardDetailsItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.nameTf = self:AddBaseCom( GameUIText ,'nameTf')
  self.item1 =   self._binder:GetValue('item1')  
  self.item2 =   self._binder:GetValue('item2')  
  self.item3 =   self._binder:GetValue('item3')  
  self.item4 =   self._binder:GetValue('item4')  
  self.item5 =   self._binder:GetValue('item5')  
  self.gainBtn = self:AddBaseCom( UINewButton ,'gainBtn')
  self.cannotGainBtn = self:AddBaseCom( UINewButton ,'cannotGainBtn')
  self.state =   self._binder:GetValue('state')  


end

return EncounterAwardDetailsItemView
---自动生成代码----end----