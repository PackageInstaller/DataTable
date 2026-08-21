---自动生成代码----start----
local BannerImageView = BaseClass( 'BannerImageView' , BaseView )
local M = BannerImageView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img = self:AddBaseCom( GameUIImage ,'img')
  self.tfTips =   self._binder:GetValue('tfTips')  
  self.redPoint =   self._binder:GetValue('redPoint')  


end

return BannerImageView
---自动生成代码----end----