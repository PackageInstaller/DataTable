---自动生成代码----start----
local ComNumSliderView = BaseClass( 'ComNumSliderView' , BaseView )
local M = ComNumSliderView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.numSlider = self:AddBaseCom( UISlider ,'numSlider')
  self.btn_less =   self._binder:GetValue('btn_less')  
  self.btn_more =   self._binder:GetValue('btn_more')  
  self.txt_numMin = self:AddBaseCom( GameUIText ,'txt_numMin')
  self.txt_numMax = self:AddBaseCom( GameUIText ,'txt_numMax')
  self.txt_numNow = self:AddBaseCom( GameUIText ,'txt_numNow')


end

return ComNumSliderView
---自动生成代码----end----