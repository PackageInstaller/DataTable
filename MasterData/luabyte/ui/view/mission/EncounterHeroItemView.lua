---自动生成代码----start----
local EncounterHeroItemView = BaseClass( 'EncounterHeroItemView' , BaseView )
local M = EncounterHeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.heroItem =   self._binder:GetValue('heroItem')  
  self.select =   self._binder:GetValue('select')  
  self.numberText = self:AddBaseCom( GameUIText ,'numberText')
  self.same =   self._binder:GetValue('same')  
  self.numBg = self:AddBaseCom( GameUIImage ,'numBg')
  self.lock =   self._binder:GetValue('lock')  


end

return EncounterHeroItemView
---自动生成代码----end----