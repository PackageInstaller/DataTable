---自动生成代码----start----
local MissionOfferRewardsView = BaseClass( 'MissionOfferRewardsView' , BaseView )
local M = MissionOfferRewardsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_mstInfo =   self._binder:GetValue('btn_mstInfo')  
  self.btn_mapInfo =   self._binder:GetValue('btn_mapInfo')  
  self.btn_reward = self:AddBaseCom( UINewButton ,'btn_reward')
  self.btn_battle = self:AddBaseCom( UINewButton ,'btn_battle')
  self.tgl_power =   self._binder:GetValue('tgl_power')  
  self.txt_itemName = self:AddBaseCom( GameUIText ,'txt_itemName')
  self.txt_itemDesc = self:AddBaseCom( GameUIText ,'txt_itemDesc')
  self.txt_timer = self:AddBaseCom( GameUIText ,'txt_timer')
  self.txt_label = self:AddBaseCom( GameUIText ,'txt_label')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_desc1 = self:AddBaseCom( GameUIText ,'txt_desc1')
  self.entryItem1 =   self:AddValue('','UI.View.Mission.MissionOfferRewardsItemView','entryItem1')  
  self.entryItem2 =   self:AddValue('','UI.View.Mission.MissionOfferRewardsItemView','entryItem2')  
  self.entryItem3 =   self:AddValue('','UI.View.Mission.MissionOfferRewardsItemView','entryItem3')  
  self.currency =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','currency')  
  self.txt_desc2 = self:AddBaseCom( GameUIText ,'txt_desc2')
  self.btn_change =   self._binder:GetValue('btn_change')  
  self.openTag =   self._binder:GetValue('openTag')  
  self.listRect =   self._binder:GetValue('listRect')  
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.listMask =   self._binder:GetValue('listMask')  
  self.img_map = self:AddBaseCom( GameRawImage ,'img_map')


end

return MissionOfferRewardsView
---自动生成代码----end----