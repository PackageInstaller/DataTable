---自动生成代码----start----
local EncounterStageEntryItemView = BaseClass( 'EncounterStageEntryItemView' , BaseView )
local M = EncounterStageEntryItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_cnName = self:AddBaseCom( GameUIText ,'txt_cnName')


end

return EncounterStageEntryItemView
---自动生成代码----end----