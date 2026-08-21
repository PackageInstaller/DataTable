---自动生成代码----start----
local OtakuOverviewItem1View = BaseClass( 'OtakuOverviewItem1View' , BaseView )
local M = OtakuOverviewItem1View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.selectState =   self._binder:GetValue('selectState')  
  self.roleNumState =   self._binder:GetValue('roleNumState')  
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.numText = self:AddBaseCom( GameUIText ,'numText')
  self.maxText = self:AddBaseCom( GameUIText ,'maxText')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.liveSpace =   self:AddValue('UI.Ctrl.Otaku.OtakuOverviewItemHeroCtrl','UI.View.Otaku.OtakuOverviewItemHeroView','liveSpace')  
  self.clickBtn =   self._binder:GetValue('clickBtn')  


end

return OtakuOverviewItem1View
---自动生成代码----end----