---自动生成代码----start----
local BossWarWordsUIView = BaseClass( 'BossWarWordsUIView' , BaseView )
local M = BossWarWordsUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_confirm = self:AddBaseCom( UINewButton ,'btn_confirm')
  self.wordsState =   self._binder:GetValue('wordsState')  
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.btn_back =   self._binder:GetValue('btn_back')  


end

return BossWarWordsUIView
---自动生成代码----end----