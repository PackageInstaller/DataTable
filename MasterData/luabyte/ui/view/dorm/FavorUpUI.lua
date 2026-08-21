---自动生成代码----start----
local FavorUpUI = BaseClass( 'FavorUpUI' , BaseView )
local M = FavorUpUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.LockScrollView = self:AddBaseCom( CircularScrollView ,'LockScrollView')
  self.MaskClose =   self._binder:GetValue('MaskClose')  


end

return FavorUpUI
---自动生成代码----end----