---自动生成代码----start----
local BattleResultFailAttrView = BaseClass( 'BattleResultFailAttrView' , BaseView )
local M = BattleResultFailAttrView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uiState =   self._binder:GetValue('uiState')  
  self.txt_recommadNum = self:AddBaseCom( GameUIText ,'txt_recommadNum')
  self.txt_currentNum = self:AddBaseCom( GameUIText ,'txt_currentNum')
  self.BgPress = self:AddBaseCom( GameUIImage ,'BgPress')


end

return BattleResultFailAttrView
---自动生成代码----end----