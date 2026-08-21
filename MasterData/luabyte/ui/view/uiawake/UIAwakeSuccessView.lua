---自动生成代码----start----
local UIAwakeSuccessView = BaseClass('UIAwakeSuccessView', BaseView)
local M = UIAwakeSuccessView
--desc

function M:__init(go)
    local trans = go.transform
    self.stateNum = self._binder:GetValue('stateNum')
    self.stateOpen1 = self._binder:GetValue('stateOpen1')
    self.stateOpen2 = self._binder:GetValue('stateOpen2')
    self.RawImageHero = self:AddBaseCom(GameRawImage, 'RawImageHero')
    self.stateItem1 = self._binder:GetValue('stateItem1')
    self.stateItem2 = self._binder:GetValue('stateItem2')
    self.stateItem3 = self._binder:GetValue('stateItem3')
    self.stateItem4 = self._binder:GetValue('stateItem4')
    self.stateItem5 = self._binder:GetValue('stateItem5')
    self.stateItem6 = self._binder:GetValue('stateItem6')
    self.stateItem7 = self._binder:GetValue('stateItem7')
    self.stateItem8 = self._binder:GetValue('stateItem8')
    self.stateItem9 = self._binder:GetValue('stateItem9')
    self.UIAwakeSuccess = self._binder:GetValue('UIAwakeSuccess')


end

return UIAwakeSuccessView
---自动生成代码----end----
