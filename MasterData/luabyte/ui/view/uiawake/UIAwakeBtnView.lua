---自动生成代码----start----
local UIAwakeBtnView = BaseClass( 'UIAwakeBtnView' , BaseView )
local M = UIAwakeBtnView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.tipsState =   self._binder:GetValue('tipsState')  
  self.imgNum = self:AddBaseCom( GameUIImage ,'imgNum')
  self.iconSkill = self:AddBaseCom( GameUIImage ,'iconSkill')


end

return UIAwakeBtnView
---自动生成代码----end----