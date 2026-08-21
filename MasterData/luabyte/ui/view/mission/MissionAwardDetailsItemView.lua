---自动生成代码----start----
local MissionAwardDetailsItemView = BaseClass( 'MissionAwardDetailsItemView' , BaseView )
local M = MissionAwardDetailsItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.passTag =   self._binder:GetValue('passTag')  
  self.textTag = self:AddBaseCom( GameUIText ,'textTag')
  self.dropState =   self._binder:GetValue('dropState')  
  self.tagState =   self._binder:GetValue('tagState')  


end

return MissionAwardDetailsItemView
---自动生成代码----end----