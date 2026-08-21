---自动生成代码----start----
local EncounterMagneticView = BaseClass( 'EncounterMagneticView' , BaseView )
local M = EncounterMagneticView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.text = self:AddBaseCom( GameUIText ,'text')


end

return EncounterMagneticView
---自动生成代码----end----