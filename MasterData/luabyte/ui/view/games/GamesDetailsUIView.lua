---自动生成代码----start----
local GamesDetailsUIView = BaseClass( 'GamesDetailsUIView' , BaseView )
local M = GamesDetailsUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.startBtn =   self._binder:GetValue('startBtn')  
  self.closeBtn =   self._binder:GetValue('closeBtn')  
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.descText = self:AddBaseCom( GameUIText ,'descText')
  self.text1Text = self:AddBaseCom( GameUIText ,'text1Text')
  self.text1Value = self:AddBaseCom( GameUIText ,'text1Value')
  self.text2Text = self:AddBaseCom( GameUIText ,'text2Text')
  self.text2Value = self:AddBaseCom( GameUIText ,'text2Value')
  self.game =   self._binder:GetValue('game')  


end

return GamesDetailsUIView
---自动生成代码----end----