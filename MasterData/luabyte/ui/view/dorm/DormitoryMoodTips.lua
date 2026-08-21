---自动生成代码----start----
local DormitoryMoodTips = BaseClass( 'DormitoryMoodTips' , BaseView )
local M = DormitoryMoodTips 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtContent = self:AddBaseCom( GameUIText ,'txtContent')
  self.rectClose =   self._binder:GetValue('rectClose')  
  self.txtTitle = self:AddBaseCom( GameUIText ,'txtTitle')


end

return DormitoryMoodTips
---自动生成代码----end----