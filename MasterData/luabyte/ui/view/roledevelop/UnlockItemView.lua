---自动生成代码----start----
local UnlockItemView = BaseClass( 'UnlockItemView' , BaseView )
local M = UnlockItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labTips = self:AddBaseCom( GameUIText ,'labTips')
  self.labDes = self:AddBaseCom( GameUIText ,'labDes')

  self.inatsfasdf = self:GetBaseValue('inatsfasdf')
end

return UnlockItemView
---自动生成代码----end----