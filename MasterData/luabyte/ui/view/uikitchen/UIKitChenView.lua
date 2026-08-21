---自动生成代码----start----
local UIKitChenView = BaseClass( 'UIKitChenView' , BaseView )
local M = UIKitChenView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')
  self.OtakuTitleCtrl =   self:AddValue('UI.Ctrl.Otaku.OtakuTitleCtrl','UI.View.Otaku.OtakuTitleView','OtakuTitleCtrl')  
  self.OtakuSettleHeroItemCtrl =   self:AddValue('UI.Ctrl.Otaku.OtakuSettleHeroItemCtrl','UI.View.Otaku.OtakuSettleHeroItemView','OtakuSettleHeroItemCtrl')  
  self.btnBatch = self:AddBaseCom( UINewButton ,'btnBatch')
  self.btnOk = self:AddBaseCom( UINewButton ,'btnOk')
  self.labSkillDes = self:AddBaseCom( GameUIText ,'labSkillDes')
  self.labSkillName = self:AddBaseCom( GameUIText ,'labSkillName')
  self.imgMat1 = self:AddBaseCom( GameUIImage ,'imgMat1')
  self.imgMat2 = self:AddBaseCom( GameUIImage ,'imgMat2')
  self.imgMat3 = self:AddBaseCom( GameUIImage ,'imgMat3')
  self.imgMat4 = self:AddBaseCom( GameUIImage ,'imgMat4')
  self.tfMat =   self._binder:GetValue('tfMat')  
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.tfStart =   self._binder:GetValue('tfStart')  
  self.labLockTips = self:AddBaseCom( GameUIText ,'labLockTips')
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.heroUIState =   self._binder:GetValue('heroUIState')  


end

return UIKitChenView
---自动生成代码----end----