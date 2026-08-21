---自动生成代码----start----
local HeroAtlasPopUpUIView = BaseClass( 'HeroAtlasPopUpUIView' , BaseView )
local M = HeroAtlasPopUpUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.gridItem = self:AddBaseCom( CircularScrollView ,'gridItem')
  self.btnMask = self:AddBaseCom( GameUIImage ,'btnMask')
  self.btn_award =   self._binder:GetValue('btn_award')  


end

return HeroAtlasPopUpUIView
---自动生成代码----end----