---自动生成代码----start----
local ChoukaHolder = BaseClass( 'ChoukaHolder' , BaseView )
local M = ChoukaHolder 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ChouKa_1 =   self:AddValue('','Scenes.Objects.Chouka','ChouKa_1')  
  self.ChouKa_10 =   self:AddValue('','Scenes.Objects.Chouka','ChouKa_10')  
  self.cameraBrain =   self._binder:GetValue('cameraBrain')  


end

return ChoukaHolder
---自动生成代码----end----