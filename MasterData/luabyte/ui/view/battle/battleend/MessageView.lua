---自动生成代码----start----
local MessageView = BaseClass( 'MessageView' , BaseView )
local M = MessageView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tip1 =   self:AddValue('UI.Ctrl.Battle.BattleEnd.MessageItemCtrl','UI.View.Battle.BattleEnd.MessageItemView','tip1')  
  self.tip2 =   self:AddValue('UI.Ctrl.Battle.BattleEnd.MessageItemCtrl','UI.View.Battle.BattleEnd.MessageItemView','tip2')  
  self.tip3 =   self:AddValue('UI.Ctrl.Battle.BattleEnd.MessageItemCtrl','UI.View.Battle.BattleEnd.MessageItemView','tip3')  
  self.tip4 =   self:AddValue('UI.Ctrl.Battle.BattleEnd.MessageItemCtrl','UI.View.Battle.BattleEnd.MessageItemView','tip4')  
  self.tip5 =   self:AddValue('UI.Ctrl.Battle.BattleEnd.MessageItemCtrl','UI.View.Battle.BattleEnd.MessageItemView','tip5')  


end

return MessageView
---自动生成代码----end----