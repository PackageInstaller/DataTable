---自动生成代码----start----
local EncounterSeasonOpenView = BaseClass( 'EncounterSeasonOpenView' , BaseView )
local M = EncounterSeasonOpenView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.title =   self:AddValue('UI.Ctrl.Mission.EncounterTitleCtrl','UI.View.Mission.EncounterTitleView','title')  
  self.txt_newSeasonTitle = self:AddBaseCom( GameUIText ,'txt_newSeasonTitle')
  self.txt_entryName = self:AddBaseCom( GameUIText ,'txt_entryName')
  self.img_entryIcon = self:AddBaseCom( GameUIImage ,'img_entryIcon')
  self.txt_entryDesc = self:AddBaseCom( GameUIText ,'txt_entryDesc')
  self.trans_bg =   self._binder:GetValue('trans_bg')  


end

return EncounterSeasonOpenView
---自动生成代码----end----