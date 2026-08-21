---自动生成代码----start----
local DormPuzzleRewardItemView = BaseClass( 'DormPuzzleRewardItemView' , BaseView )
local M = DormPuzzleRewardItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Text = self:AddBaseCom( GameUIText ,'Text')
  self.State =   self._binder:GetValue('State')  
  self.Btn = self:AddBaseCom( GameUIImage ,'Btn')
  self.Animator =   self._binder:GetValue('Animator')  

  self.rewardChildId = self:GetBaseValue('rewardChildId')
end

return DormPuzzleRewardItemView
---自动生成代码----end----