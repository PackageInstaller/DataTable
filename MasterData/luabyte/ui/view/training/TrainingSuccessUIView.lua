---自动生成代码----start----
local TrainingSuccessUIView = BaseClass( 'TrainingSuccessUIView' , BaseView )
local M = TrainingSuccessUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Value = self:AddBaseCom( GameUIText ,'Value')
  self.BG = self:AddBaseCom( GameUIImage ,'BG')


end

return TrainingSuccessUIView
---自动生成代码----end----