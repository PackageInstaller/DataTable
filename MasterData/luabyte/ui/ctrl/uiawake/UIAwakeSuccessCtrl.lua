--baoruichang
--IllustrationPanel
local UIAwakeSuccessCtrl = BaseClass("UIAwakeSuccessCtrl", BaseUICtrl)
local M = UIAwakeSuccessCtrl
local EQuality = EnumConst.EQuality
local SSRLEVEL = 6
local SRLEVEL = 3

function M:Init()
end

--进入UI，可传参数
function M:OnEnter(heroId, closeCallBack)
    self.heroId = heroId
    self.closeCallBack = closeCallBack
    self.heroData = IHeroDataMgr:GetMyHeroDataById(self.heroId)
    self.awakeLevel = self.heroData:GetAwakeLevel()
    self:_InitUI()
end

function M:_InitUI()
    self.rare = ConfigHelper.GetCfgPropByLua("hero", self.heroId, "rare")
    self.levelNum = self.rare == EQuality.SSR and SSRLEVEL or SRLEVEL
    self.heroAwakes = ConfigHelper.GetCfgsByLua("heroAwake", { heroId = self.heroId })
    local resource = ConfigHelper.GetCfg("resource", self.heroId)
    self._view.RawImageHero:SetPic(resource.illustration)
    self._view.stateNum:SetState(self.rare == EQuality.SSR and 1 or 2)
    if self.levelNum == 6 then
        self._view.stateOpen1:SetState(self.awakeLevel + 1)
    else
        self._view.stateOpen2:SetState(self.awakeLevel + 1)
    end
    self._view.UIAwakeSuccess:SetCallBack(Bind(self, self.Close))
end

function M:OnClose()
    if self.closeCallBack then
        self.closeCallBack()
    end
end

return UIAwakeSuccessCtrl
