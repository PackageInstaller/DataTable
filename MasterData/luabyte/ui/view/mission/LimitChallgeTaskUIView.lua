---自动生成代码----start----
local LimitChallgeTaskUIView = BaseClass( 'LimitChallgeTaskUIView' , BaseView )
local M = LimitChallgeTaskUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tgl_challge = self:AddBaseCom( UIToggle ,'tgl_challge')
  self.tgl_season = self:AddBaseCom( UIToggle ,'tgl_season')
  self.season_subTab =   self._binder:GetValue('season_subTab')  
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.btn_quick =   self._binder:GetValue('btn_quick')  
  self.txt_back =   self._binder:GetValue('txt_back')  
  self.chestTips =   self._binder:GetValue('chestTips')  
  self.firstTips =   self._binder:GetValue('firstTips')  


end

return LimitChallgeTaskUIView
---自动生成代码----end----