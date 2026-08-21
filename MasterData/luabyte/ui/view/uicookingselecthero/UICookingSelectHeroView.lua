---自动生成代码----start----
local UICookingSelectHeroView = BaseClass('UICookingSelectHeroView', BaseView)
local M = UICookingSelectHeroView
--desc

function M:__init(go)
    local trans = go.transform
    self.item = self._binder:GetValue('item')
    self.ScrollView = self:AddBaseCom(CircularScrollView, 'ScrollView')
    self.selectArea = self._binder:GetValue('selectArea')
    self.eaterNum = self:AddBaseCom(GameUIText, 'eaterNum')
    self.valueLabel = self:AddBaseCom(GameUIText, 'valueLabel')
    self.value = self:AddBaseCom(UISlider, 'value')
    self.skill1 = self:AddValue('', 'UI.View.Otaku.MainUI.DeployHero.OtakuDeployHeroToRoomSkillUI', 'skill1')
    self.skillContent = self._binder:GetValue('skillContent')
    self.btnClean = self._binder:GetValue('btnClean')
    self.btnOk = self._binder:GetValue('btnOk')
    self.mask = self._binder:GetValue('mask')
    self.curPlace = self:AddBaseCom(GameUIText, 'curPlace')
    self.curPlaceBg = self._binder:GetValue('curPlaceBg')
    self.tfHeroItem = self._binder:GetValue('tfHeroItem')
    self.HeroIcon = self:AddBaseCom(GameRawImage, 'HeroIcon')
    self.labLevel = self:AddBaseCom(GameUIText, 'labLevel')
    self.labName = self:AddBaseCom(GameUIText, 'labName')
    -- self.valueBg = self:AddBaseCom( GameUIImage ,'valueBg')
end


return UICookingSelectHeroView

---自动生成代码----end----
