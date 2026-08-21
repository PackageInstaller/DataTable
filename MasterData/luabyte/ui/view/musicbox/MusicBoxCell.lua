---自动生成代码----start----
local MusicBoxCell = BaseClass( 'MusicBoxCell' , BaseView )
local M = MusicBoxCell 
--desc

function M:__init(go)
  local trans = go.transform 
  self.titleTf = self:AddBaseCom( GameUIText ,'titleTf')
  self.state =   self._binder:GetValue('state')  
  self.playBtn = self:AddBaseCom( GameUIImage ,'playBtn')
  self.numberTxt = self:AddBaseCom( GameUIText ,'numberTxt')
  self.triangle = self:AddBaseCom( GameUIImage ,'triangle')
  self.bar = self:AddBaseCom( GameUIImage ,'bar')
  self.imgNum2 = self:AddBaseCom( GameUIImage ,'imgNum2')
  self.imgNum1 = self:AddBaseCom( GameUIImage ,'imgNum1')
  self.wave =   self._binder:GetValue('wave')  
  self.anim =   self._binder:GetValue('anim')  


end

return MusicBoxCell
---自动生成代码----end----