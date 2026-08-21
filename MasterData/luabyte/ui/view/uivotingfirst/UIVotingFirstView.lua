---自动生成代码----start----
local UIVotingFirstView = BaseClass( 'UIVotingFirstView' , BaseView )
local M = UIVotingFirstView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.textName =   self._binder:GetValue('textName')  
  self.textNum = self:AddBaseCom( GameUIText ,'textNum')
  self.btnReward = self:AddBaseCom( UIButton ,'btnReward')
  self.btnDetails = self:AddBaseCom( UIButton ,'btnDetails')
  self.imgProfession = self:AddBaseCom( GameUIImage ,'imgProfession')
  self.imageQuality = self:AddBaseCom( GameUIImage ,'imageQuality')
  self.girlPos =   self._binder:GetValue('girlPos')  
  self.layGroup =   self._binder:GetValue('layGroup')  


end

return UIVotingFirstView
---自动生成代码----end----