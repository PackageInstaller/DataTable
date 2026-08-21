local OtakuMainMoudule = BaseClass("OtakuMainMoudule", require("Framework.Module.BaseGameModule"))
local M = OtakuMainMoudule

function M:__init()
    self._isPlayTimeLine = true
    self._vmNameDic = {}
    self._enterHouseData = nil
end

function M:OnEnter()
    local dataLoaded = OtakuRoomDataMgr:GetInstance():IsLoaded()
    if dataLoaded then
        self:CheckLoadScene()
    else
        OtakuRoomDataMgr:GetInstance():RequestBrowseStudio(Bind(self, self.CheckLoadScene))
    end
end

function M:CheckLoadScene()
    if self:GetCurSceneName() ~= "Display02" then
        self:LoadScene("Display02", Bind(self, self.LoadSceneComplete))
    else
        self:LoadSceneComplete(self:GetViewAndCtrl("Display02"))
    end
end

function M:LoadSceneComplete(_, ctrl)
    --local _,ctrl = self:GetViewAndCtrl("Display02")
    ctrl:ChangeDisplay("Otaku")
    -- view.mainsceneObjs:SetActive(false)
    -- view.CameraNode:SetActive(false)
    -- view.developObjs:SetActive(false)
    -- view.shopObjs:SetActive(false)
    -- view.lotteryObjs:SetActive(false)
    -- view.otakuObjs:SetActive(true)
    -- view.luckdrawObjs:SetActive(false)
    RoleBehaviorCtrl:GetInstance():RemoveAllGirls()
    self:Ready()
    self:_PlayTimeLine()
end

function M:_PlayTimeLine()
    if self._isPlayTimeLine and
        GameHelper.GetPlayerPrefsInt(SettingConst.Dorm.CabinEnterAnim, SettingDefault.Dorm.CabinEnterAnim) > 0 then
        GameHelper.SetPlayerPrefsInt(SettingConst.Dorm.CabinEnterAnim, 0)
        GameHelper.PlayTimlineById(20005, Bind(self, self._PlayCallBack))
        return
    end

    self:_ShowOtakuMain()
end

function M:_PlayCallBack()
    self._isPlayTimeLine = false
    self:_ShowOtakuMain()
end

function M:_ShowOtakuMain()
    -- local view = self:GetViewAndCtrl("Display02")
    -- view.otakuObjs:SetActive(false)
    UIContextMgr:GetInstance():Show("OtakuMainUI")
end

function M:OnExit()
    UIContextMgr:GetInstance():Close("BridgeUI")
    UIContextMgr:GetInstance():Close("WishjourneyUI")
    UIContextMgr:GetInstance():Close("ComChooseHero")
    UIContextMgr:GetInstance():Close("OtakuUpgradeUI")
    UIContextMgr:GetInstance():Close("OtakuSynthesisUI")
    UIContextMgr:GetInstance():Close("OtakuChooseHeroUI")
    UIContextMgr:GetInstance():Close("WishjourneySelectItemUI")
    UIContextMgr:GetInstance():Close("OtakuManufacturingCabin")
    UIContextMgr:GetInstance():Close("BridgeCmdSkill")
    UIContextMgr:GetInstance():Close("BridgeUI")
    M.super.OnExit(self)
end

return OtakuMainMoudule
