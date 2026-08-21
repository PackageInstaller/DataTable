---自动生成代码----start----
local MusicBoxView = BaseClass( 'MusicBoxView' , BaseView )
local M = MusicBoxView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.sc = self:AddBaseCom( CircularScrollView ,'sc')
  self.bg = self:AddBaseCom( GameUIImage ,'bg')
  self.cell =   self:AddValue('UI.Ctrl.MusicBox.MusicBoxCellCtrl','UI.View.MusicBox.MusicBoxCell','cell')  
  self.anim =   self._binder:GetValue('anim')  
  self.wave =   self._binder:GetValue('wave')  


end

return MusicBoxView
---自动生成代码----end----