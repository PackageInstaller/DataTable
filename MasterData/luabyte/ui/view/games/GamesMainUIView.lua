---自动生成代码----start----
local GamesMainUIView = BaseClass( 'GamesMainUIView' , BaseView )
local M = GamesMainUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.closeBtn =   self._binder:GetValue('closeBtn')  
  self.game =   self._binder:GetValue('game')  
  self.content =   self._binder:GetValue('content')  


end

return GamesMainUIView
---自动生成代码----end----