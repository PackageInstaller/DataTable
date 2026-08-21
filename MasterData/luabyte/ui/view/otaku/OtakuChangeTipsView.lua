---自动生成代码----start----
local OtakuChangeTipsView = BaseClass( 'OtakuChangeTipsView' , BaseView )
local M = OtakuChangeTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Content =   self._binder:GetValue('Content')  
  self.OtakuTip =   self:AddValue('','UI.View.Otaku.OtakuTipsPanelView','OtakuTip')  


end

return OtakuChangeTipsView
---自动生成代码----end----