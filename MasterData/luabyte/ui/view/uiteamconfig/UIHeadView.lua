---自动生成代码----start----
local UIHeadView = BaseClass( 'UIHeadView' , BaseView )
local M = UIHeadView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeroHeadItem =   self._binder:GetValue('HeroHeadItem')  
  self.stateBreak =   self:AddValue('UI.Ctrl.UITeamConfig.UIBreakCtrl','UI.View.UITeamConfig.UIBreakView','stateBreak')  
  self.tfSame =   self._binder:GetValue('tfSame')  


end

return UIHeadView
---自动生成代码----end----