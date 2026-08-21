---自动生成代码----start----
local MissionMonsterInfoItemView = BaseClass( 'MissionMonsterInfoItemView' , BaseView )
local M = MissionMonsterInfoItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.iconImg = self:AddBaseCom( GameUIImage ,'iconImg')
  self.lv = self:AddBaseCom( GameUIText ,'lv')
  self.boss =   self._binder:GetValue('boss')  
  self.toggle = self:AddBaseCom( UIToggle ,'toggle')


end

return MissionMonsterInfoItemView
---自动生成代码----end----