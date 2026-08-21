---自动生成代码----start----
local NoticePopupImageSytel = BaseClass( 'NoticePopupImageSytel' , BaseView )
local M = NoticePopupImageSytel 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ScrollView =   self._binder:GetValue('ScrollView')  
  self.ToggleDots = self:AddBaseCom( DotsToggler ,'ToggleDots')
  self.BtnL = self:AddBaseCom( UIButton ,'BtnL')
  self.BtnR = self:AddBaseCom( UIButton ,'BtnR')
  self.PageTemplate = self:AddBaseCom( GameRawImage ,'PageTemplate')
  self.close = self:AddBaseCom( UIButton ,'close')
  self.tipAgain = self:AddBaseCom( UIToggle ,'tipAgain')
  self.closeMask =   self._binder:GetValue('closeMask')  


end

return NoticePopupImageSytel
---自动生成代码----end----