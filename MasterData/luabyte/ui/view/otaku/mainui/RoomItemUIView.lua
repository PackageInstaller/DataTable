---自动生成代码----start----
local RoomItemUIView = BaseClass( 'RoomItemUIView' , BaseView )
local M = RoomItemUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.followTarget =   self._binder:GetValue('followTarget')  
  self.name = self:AddBaseCom( GameUIText ,'name')
  self.level = self:AddBaseCom( GameUIText ,'level')
  self.workingText = self:AddBaseCom( GameUIText ,'workingText')
  self.stopText = self:AddBaseCom( GameUIText ,'stopText')


end

return RoomItemUIView
---自动生成代码----end----