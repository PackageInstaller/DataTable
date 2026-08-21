---自动生成代码----start----
local Style02Image_TextView = BaseClass( 'Style02Image_TextView' , BaseView )
local M = Style02Image_TextView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Video =   self._binder:GetValue('Video')  
  self.TabTemplate = self:AddBaseCom( GameUIImage ,'TabTemplate')
  self.TabGroup =   self._binder:GetValue('TabGroup')  


end

return Style02Image_TextView
---自动生成代码----end----