---自动生成代码----start----
local KeywordTipsView = BaseClass( 'KeywordTipsView' , BaseView )
local M = KeywordTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.container =   self._binder:GetValue('container')  
  self.txt_title = self:AddBaseCom( GameUIText ,'txt_title')
  self.txt_content = self:AddBaseCom( GameUIText ,'txt_content')
  self.clickArea =   self._binder:GetValue('clickArea')  


end

return KeywordTipsView
---自动生成代码----end----