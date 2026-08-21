---自动生成代码----start----
local SettingUIView = BaseClass( 'SettingUIView' , BaseView )
local M = SettingUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.leftTab =   self._binder:GetValue('leftTab')  
  self.btn_exitGame = self:AddBaseCom( UINewButton ,'btn_exitGame')
  self.btn_Back = self:AddBaseCom( UIButton ,'btn_Back')
  self.btn_Cdk = self:AddBaseCom( UINewButton ,'btn_Cdk')
  self.btn_Revert = self:AddBaseCom( UINewButton ,'btn_Revert')
  self.SetVoice =   self:AddValue('','UI.View.Setting.SetVoiceView','SetVoice')  
  self.SetQuality =   self:AddValue('','UI.View.Setting.SetQualityView','SetQuality')  
  self.SetFight =   self:AddValue('','UI.View.Setting.SetFightView','SetFight')  
  self.SetRoom =   self:AddValue('','UI.View.Setting.SetRoomView','SetRoom')  
  self.SetCV =   self:AddValue('','UI.View.Setting.SetCVView','SetCV')  
  self.btn_logout =   self._binder:GetValue('btn_logout')  
  self.SetAccount =   self:AddValue('','UI.View.Setting.SetAccountView','SetAccount')  
  self.customer = self:AddBaseCom( UINewButton ,'customer')
  self.btn_rebate = self:AddBaseCom( UINewButton ,'btn_rebate')


end

return SettingUIView
---自动生成代码----end----