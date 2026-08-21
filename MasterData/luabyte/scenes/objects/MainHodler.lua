---自动生成代码----start----
local MainHodler = BaseClass( 'MainHodler' , BaseView )
local M = MainHodler 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Display02 =   self:AddValue('','Scenes.Objects.RoleDevelopScene','Display02')  
  self.CharacterShow =   self._binder:GetValue('CharacterShow')  
  self.Lottery =   self:AddValue('','Scenes.Objects.ChoukaHolder','Lottery')  
  self.Otaku =   self._binder:GetValue('Otaku')  
  self.LuckDraw =   self:AddValue('','Scene.Objects.LuckDrawholder','LuckDraw')  
  self.ShopBg =   self._binder:GetValue('ShopBg')  
  self.FashionShow =   self:AddValue('','Scenes.Objects.RoleFashionScene','FashionShow')  
  self.lateState =   self._binder:GetValue('lateState')  


end

return MainHodler
---自动生成代码----end----