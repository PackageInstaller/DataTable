---自动生成代码----start----
local OtakuMainUIView = BaseClass( 'OtakuMainUIView' , BaseView )
local M = OtakuMainUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.produceClaim =   self._binder:GetValue('produceClaim')  
  self.surveyClaim =   self._binder:GetValue('surveyClaim')  
  self.roleBtn =   self._binder:GetValue('roleBtn')  
  self.Bridge1 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Bridge1')  
  self.Communication1 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Communication1')  
  self.Drom1 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Drom1')  
  self.Produce1 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Produce1')  
  self.Produce2 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Produce2')  
  self.Produce3 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Produce3')  
  self.Canteen1 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Canteen1')  
  self.Canteen2 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Canteen2')  
  self.scrollView = self:AddBaseCom( UIScrollView ,'scrollView')
  self.Survey1 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Survey1')  
  self.Compose1 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Compose1')  
  self.content =   self._binder:GetValue('content')  
  self.animator =   self._binder:GetValue('animator')  
  self.redPointRoot =   self._binder:GetValue('redPointRoot')  
  self.Kitchen1 =   self:AddValue('UI.Ctrl.Otaku.OtakuRoomCtrl','UI.View.Otaku.MainUI.OtakuRoomItemView','Kitchen1')  
  self.surveyEnter =   self._binder:GetValue('surveyEnter')  


end

return OtakuMainUIView
---自动生成代码----end----