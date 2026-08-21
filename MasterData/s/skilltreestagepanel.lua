---@class SkillTreeStagePanel : SkillTreeStagePanel_Generate
---##################### 【SkillTreeStagePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkillTreeStagePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkillTreeStagePanel = require "SkillTreeStagePanel_Generate"

function SkillTreeStagePanel:InitLogic(data)
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
end

--function SkillTreeStagePanel:StartCreating(time)
--
--end

--function SkillTreeStagePanel:StartEnter(time)
--
--end

--function SkillTreeStagePanel:StartRemoving(time)
--
--end

--function SkillTreeStagePanel:StartExit(time)
--
--end

function SkillTreeStagePanel:OnOpen(data, initiative)
    if data then
        self.boxBg:SetActive(true)
        self.upMsgView:SetActive(false)
        self.maxStage = data.maxStage
        self.treeData = data.treeData
        self.roleId = data.roleId
        self:SetView()
    end
end

function SkillTreeStagePanel:SetView()
    local roleData = Me:getPlayerHero(self.roleId)
    self:FillTemplateContent(self.stageBox, self.stageBoxList, self.maxStage, function(index, stageBox)
        stageBox:SetActive(true)
        local stageConfig = Config.GetTalentTreeStageInfoByTreeIdStageId(self.treeData[1].treeId, index)
        stageBox.titleText.text.text = "第" .. stageConfig.stageId .. "阶段"
        local isStageUnlocked = Me:getTalentTreeStageDataById(self.roleId, stageConfig.stageId) ~= nil
        stageBox.unSwitchBtn:SetActive(false)
        local stageConfigs = Config.GetTalentTreeInfoByTreeIdStageId(self.treeData[1].treeId, stageConfig.stageId)
        stageBox.unSwitchBtn:SetActive(false)
        stageBox.switchBtn:SetActive(true)
        stageBox.switchBtn.redPoint:SetActive(RedPointMgr:RoleTalentTreeStageLevelCanUp(self.roleId, stageConfig.stageId))
        if stageConfigs then
            for _, value in pairs(stageConfigs) do
                if not tablex.find(roleData.talentTreeList, value.id) then
                    stageBox.unSwitchBtn:SetActive(true)
                    stageBox.switchBtn:SetActive(false)
                    break
                end
            end
        end
        if isStageUnlocked then
            stageBox.unSwitchBtn:SetActive(false)
            stageBox.switchBtn:SetActive(false)
        end
            
        stageBox.isOn:SetActive(isStageUnlocked)
        stageBox.titleIsOnBg:SetActive(isStageUnlocked)

        stageBox.hpTxt.text.text = stageConfig.hp
        stageBox.bombardTxt.text.text = stageConfig.bombard
        stageBox.torpedoTxt.text.text = stageConfig.torpedo
        stageBox.armorTxt.text.text = stageConfig.armor
        stageBox.evadeTxt.text.text = stageConfig.evade
        stageBox.airdefenseTxt.text.text = stageConfig.airdefense
        stageBox.luckyTxt.text.text = stageConfig.lucky

        --根据解锁状态设置节点内容颜色
        local needTitleColor = isStageUnlocked and Color.NewFromStr("FFFFFF") or Color.NewFromStr("E7E7E7")
        local needTextColor = isStageUnlocked and Color.NewFromStr("333333") or Color.NewFromStr("7D7D7D")
        local needIconColor = isStageUnlocked and Color.NewFromStr("494949") or Color.NewFromStr("7D7D7D")
        stageBox.titleText.text.color = needTitleColor

        stageBox.hpTitle.text.color = needTextColor
        stageBox.bombardTitle.text.color = needTextColor
        stageBox.torpedoTitle.text.color = needTextColor
        stageBox.armorTitle.text.color = needTextColor
        stageBox.evadeTitle.text.color = needTextColor
        stageBox.airdefenseTitle.text.color = needTextColor
        stageBox.luckyTitle.text.color = needTextColor

        stageBox.hpTxt.text.color = needTextColor
        stageBox.bombardTxt.text.color = needTextColor
        stageBox.torpedoTxt.text.color = needTextColor
        stageBox.armorTxt.text.color = needTextColor
        stageBox.evadeTxt.text.color = needTextColor
        stageBox.airdefenseTxt.text.color = needTextColor
        stageBox.luckyTxt.text.color = needTextColor

        stageBox.hpIcon.image.color = needIconColor
        stageBox.bombardIcon.image.color = needIconColor
        stageBox.torpedoIcon.image.color = needIconColor
        stageBox.armorIcon.image.color = needIconColor
        stageBox.evadeIcon.image.color = needIconColor
        stageBox.airdefenseIcon.image.color = needIconColor
        stageBox.luckyIcon.image.color = needIconColor

        stageBox.hpImg:SetActive(stageConfig.hp ~= 0)
        stageBox.bombardImg:SetActive(stageConfig.bombard ~= 0)
        stageBox.torpedoImg:SetActive(stageConfig.torpedo ~= 0)
        stageBox.armorImg:SetActive(stageConfig.armor ~= 0)
        stageBox.evadeImg:SetActive(stageConfig.evade ~= 0)
        stageBox.airdefenseImg:SetActive(stageConfig.airdefense ~= 0)
        stageBox.luckyImg:SetActive(stageConfig.lucky ~= 0)

        stageBox.switchBtn.scaleButton.onClick:RemoveAllListeners()
        stageBox.switchBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            if self:GetStageFinishData(index) then
                local temp = {
                    stageID = stageConfig.stageId,
                    RoleId = self.roleId,
                }
                Me:talentTreeStageUnlockReq(temp, function()
                    --UICommonUtils.PopToast("激活成功")
                    --self:playCloseAnim()
                    self:showUp(stageConfig)
                    GameMsgMgr:sendEvent(GameMsgType.RedPointRefresh)
                end)
            end
            -- self:showUp(stageConfig)
        end)

        stageBox.unSwitchBtn.scaleButton.onClick:RemoveAllListeners()
        stageBox.unSwitchBtn.scaleButton.onClick:AddListener(function()
            UICommonUtils.PopToast("请激活所有该阶段下的节点")
        end)
    end)
end

--获取阶段是否全部完成
function SkillTreeStagePanel:GetStageFinishData(stageId)
    for _, value in pairs(self.treeData) do
        if value.stageId == stageId then
            local treeData = Me:getTalentTreeDataById(self.roleId ,value.id)
            if treeData == nil then
                return false
            end
        end
    end
    return true
end

function SkillTreeStagePanel:showUp(stageConfig)
    self.upMsgView.hpImg.hpTxt.text.text = stageConfig.hp
    self.upMsgView.bombardImg.bombardTxt.text.text = stageConfig.bombard
    self.upMsgView.torpedoImg.torpedoTxt.text.text = stageConfig.torpedo
    self.upMsgView.armorImg.armorTxt.text.text = stageConfig.armor
    self.upMsgView.evadeImg.evadeTxt.text.text = stageConfig.evade
    self.upMsgView.airdefenseImg.airdefenseTxt.text.text = stageConfig.airdefense
    self.upMsgView.luckyImg.luckyTxt.text.text = stageConfig.lucky

    
    self.upMsgView.hpImg:SetActive(stageConfig.hp ~= 0)
    self.upMsgView.bombardImg:SetActive(stageConfig.bombard ~= 0)
    self.upMsgView.torpedoImg:SetActive(stageConfig.torpedo ~= 0)
    self.upMsgView.armorImg:SetActive(stageConfig.armor ~= 0)
    self.upMsgView.evadeImg:SetActive(stageConfig.evade ~= 0)
    self.upMsgView.airdefenseImg:SetActive(stageConfig.airdefense ~= 0)
    self.upMsgView.luckyImg:SetActive(stageConfig.lucky ~= 0)

    for i = 1, 4 do
        self["img"..i].canvas.sortingLayerName = "UI"
        self["img"..i].canvas.sortingOrder = 10
    end

    self.boxBg:SetActive(false)
    self.upMsgView:SetActive(true)
end

--界面关闭
function SkillTreeStagePanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--function SkillTreeStagePanel:OnClose(initiative)
--
--end

--function SkillTreeStagePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SkillTreeStagePanel:OnRefresh(data)
--
--end

--[[
/StagePanel/Art/TitleBg/CloseBtn onClick 
--]]
function SkillTreeStagePanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:play2DSound(self.btnSoundPath)
    self:playCloseAnim()
end

--[[
/Mask onClick 
--]]
function SkillTreeStagePanel:mask_Button_onClick(mask)
    self:play2DSound(self.btnSoundPath)
    self:playCloseAnim()
end

--[[
/UpMsgView onClick 
--]]
function SkillTreeStagePanel:upMsgView_Button_onClick(upMsgView)
    self:play2DSound(self.btnSoundPath)
    self.upMsgView.animator:SetTrigger("Out")
    self.upMsgView.button.interactable = false
    self.upMsgView.animOverCallBack:SetCallBack(function()
        self.upMsgView.button.interactable = true
        self.upMsgView:SetActive(false)
        UIMgr:closeSpecificUI(self)
    end)
end

return SkillTreeStagePanel
