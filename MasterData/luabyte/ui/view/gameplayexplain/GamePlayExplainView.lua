---自动生成代码----start----
local GamePlayExplainView = BaseClass( 'GamePlayExplainView' , BaseView )
local M = GamePlayExplainView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Display =   self._binder:GetValue('Display')  
  self.Mask = self:AddBaseCom( GameUIImage ,'Mask')
  self.Style01 =   self:AddValue('','UI.View.GamePlayExplain.Style01Image_TextView','Style01')  
  self.Style02 =   self:AddValue('','UI.View.GamePlayExplain.Style02Image_TextView','Style02')  
  self.DormHelpPopupAnimator =   self._binder:GetValue('DormHelpPopupAnimator')  
  self.Style03 =   self:AddValue('','UI.View.GamePlayExplain.Style03Image_TextView','Style03')  


end

return GamePlayExplainView
---自动生成代码----end----