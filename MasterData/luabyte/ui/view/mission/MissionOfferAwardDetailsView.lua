---自动生成代码----start----
local MissionOfferAwardDetailsView = BaseClass( 'MissionOfferAwardDetailsView' , BaseView )
local M = MissionOfferAwardDetailsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_back = self:AddBaseCom( GameUIImage ,'btn_back')
  self.txt_level = self:AddBaseCom( GameUIText ,'txt_level')
  self.txt_slevel = self:AddBaseCom( GameUIText ,'txt_slevel')
  self.img_fill = self:AddBaseCom( GameUIImage ,'img_fill')
  self.txt_expL = self:AddBaseCom( GameUIText ,'txt_expL')
  self.txt_expR = self:AddBaseCom( GameUIText ,'txt_expR')
  self.btn_award =   self._binder:GetValue('btn_award')  
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')


end

return MissionOfferAwardDetailsView
---自动生成代码----end----