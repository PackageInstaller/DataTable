---自动生成代码----start----
local MissionMapUIView = BaseClass( 'MissionMapUIView' , BaseView )
local M = MissionMapUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.mapPic = self:AddBaseCom( GameRawImage ,'mapPic')
  self.closeBtn =   self._binder:GetValue('closeBtn')  


end

return MissionMapUIView
---自动生成代码----end----