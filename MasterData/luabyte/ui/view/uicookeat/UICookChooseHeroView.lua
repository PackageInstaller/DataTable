---自动生成代码----start----
local UICookChooseHeroView = BaseClass( 'UICookChooseHeroView' , BaseView )
local M = UICookChooseHeroView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnClose =   self._binder:GetValue('btnClose')  
  self.scrollHero = self:AddBaseCom( CircularScrollView ,'scrollHero')
  self.tfTips =   self._binder:GetValue('tfTips')  
  self.btnOk = self:AddBaseCom( UINewButton ,'btnOk')
  self.btnCancel = self:AddBaseCom( UINewButton ,'btnCancel')


end

return UICookChooseHeroView
---自动生成代码----end----