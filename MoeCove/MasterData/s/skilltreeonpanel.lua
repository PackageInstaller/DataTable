---@class SkillTreeOnPanel : SkillTreeOnPanel_Generate
---##################### 【SkillTreeOnPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkillTreeOnPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkillTreeOnPanel = require "SkillTreeOnPanel_Generate"

function SkillTreeOnPanel:InitLogic(data)
    self._isClosing = false
    self.effectToIconMap = {
        [GE.TalentTypeNew.naturePoint] = {iconIndex = 1, name = "属性节点", EngName = "Nature node", mode = 1},
        [GE.TalentTypeNew.skillChosePoint] = {iconIndex = 2, name = "技能选择节点", EngName = "Skill Unlocker node", mode = 1},
        [GE.TalentTypeNew.getSkillPoint] = {iconIndex = 2, name = "技能节点", EngName = "Skill node", mode = 2},
        [GE.TalentTypeNew.unlockWeaponPoint] = {iconIndex = 3, name = "武器解锁节点", EngName = "Weapon node", mode = 1},
        [GE.TalentTypeNew.getTagPoint] = {iconIndex = 4, name = "标签节点", EngName = "Tag node", mode = 1},
        [GE.TalentTypeNew.changeTagPoint] = {iconIndex = 4, name = "标签节点", EngName = "Tag node", mode = 1},
        [GE.TalentTypeNew.delTagPoint] = {iconIndex = 4, name = "负载节点", EngName = "Tag node", mode = 1},
        [GE.TalentTypeNew.loadUpPoint] = {iconIndex = 5, name = "标签节点", EngName = "Load node", mode = 1},
        [GE.TalentTypeNew.skinPoint] = {iconIndex = 6, name = "皮肤节点", EngName = "Skin node", mode = 2},
    }
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
end

--function SkillTreeOnPanel:StartCreating(time)
--
--end

--function SkillTreeOnPanel:StartEnter(time)
--
--end

--function SkillTreeOnPanel:StartRemoving(time)
--
--end

--function SkillTreeOnPanel:StartExit(time)
--
--end

function SkillTreeOnPanel:OnOpen(data, initiative)
    local btnSoundPath = string.format(Config.AudioPath.SE, "pointsuccess")
    self:play2DSound(btnSoundPath)
    if data then 
        self.roleUid = data.roleUid
        self.configData = Config.TalentTreeInfo(data.id)
        self:SetView()
    end
end

--设置显示
function SkillTreeOnPanel:SetView()
    local specialEffect = self.configData.specialEffect[1]

    LuaLogger.ds("specialEffect", specialEffect)

    local isSkillPoint = specialEffect == GE.TalentTypeNew.getSkillPoint
    local isSkinPoint = specialEffect == GE.TalentTypeNew.skinPoint

    self.pointBox.mainMode:SetActive(not (isSkillPoint or isSkinPoint))
    self.pointBox.skillMode:SetActive(isSkillPoint or isSkinPoint)
    self.pointBox.skillMode.mainView:SetActive(not isSkillPoint)
    self.pointBox.skillMode.skillView:SetActive(isSkillPoint)

    if isSkillPoint then
        local skillConfig = Config.GetSkillInfo(self.configData.specialEffect[2])
        LuaLogger.ds("self.configData.specialEffect[2]", self.configData.specialEffect[2])
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), self.pointBox.skillMode.skillView.iconImg.image)
    end

    local iconIndex = self.effectToIconMap[specialEffect].iconIndex
    local TreeIconPath = string.format(Config.SpritePath.TreeIconPath, iconIndex)
    self:LoadSpriteAsync(TreeIconPath, function(s)
        self.pointBox.mainMode.iconImg.image.sprite = s
        self.pointBox.skillMode.iconImg.image.sprite = s
        self.pointBox.mainMode.iconImg:SetActive(true)
        self.pointBox.skillMode.iconImg:SetActive(true)
    end)
    local UICamera = UIMgr.uiCamera
    UICamera.orthographic = true
    self.pointBox.skillNameTxt.text.text = self.configData.name
    self:resetSortingOrder()
    self:SetPostProcessing()
end

-- 打开技能树选择面板
function SkillTreeOnPanel:OpenSkillTreeChosePanel()
    local chose_1 = Config.TalentTreeInfo(self.configData.after[1])
    local chose_2 = Config.TalentTreeInfo(self.configData.after[2])
    UIMgr:popUICover("SkillTreeChosePanel", {chose_1 = chose_1, chose_2 = chose_2, roleUid = self.roleUid})
end

--重置sortingOrder
function SkillTreeOnPanel:resetSortingOrder()
    local nowOrder = self.transform:GetComponent("Canvas").sortingOrder
    local effects = {self.effect_Ui_SkillTreeOn}
    for _, effect in ipairs(effects) do
        local effectTransform = effect.transform
        for j = 1, effectTransform.childCount do
            local particleSystemRenderer = effectTransform:GetChild(j - 1):GetComponent("ParticleSystemRenderer")
            particleSystemRenderer.sortingOrder = nowOrder + 1
        end
    end

    self.art.canvas.sortingLayerName = "UI"
    self.art.canvas.sortingOrder = nowOrder + 2
end

--- 设置相机的后处理
function SkillTreeOnPanel:SetPostProcessing()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--function SkillTreeOnPanel:OnClose(initiative)
--
--end

function SkillTreeOnPanel:OnDestroy()
	local UICamera = UIMgr.uiCamera
    if UICamera then
        UICamera.orthographic = false
    end
    self.super:OnDestroy(self)
end

--function SkillTreeOnPanel:OnRefresh(data)
--
--end

--[[
/ImgBg onClick 
--]]
function SkillTreeOnPanel:imgBg_Button_onClick(imgBg)
    if self._isClosing or UIMgr:getCurUIName() ~= "SkillTreeOnPanel" then
        return
    end
    self._isClosing = true
    self:play2DSound(self.btnSoundPath)
    local needOpenChose = self.configData and self.configData.specialEffect[1] == GE.TalentTypeNew.skillChosePoint
    UIMgr:closeSpecificUI(self, nil, function()
        self._isClosing = false
        if needOpenChose then
            self:OpenSkillTreeChosePanel()
        end
    end)
end

return SkillTreeOnPanel
