---@class TrialPanel : TrialPanel_Generate
---##################### 【TrialPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【TrialPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local TrialPanel = require "TrialPanel_Generate"

function TrialPanel:InitLogic(data)

end

--function TrialPanel:StartCreating(time)
--
--end

--function TrialPanel:StartEnter(time)
--
--end

--function TrialPanel:StartRemoving(time)
--
--end

--function TrialPanel:StartExit(time)
--
--end

function TrialPanel:OnOpen(data, initiative)
    if initiative then
    end
    self:initData(data)
    self:initLeftList()
    self:refreshBtnState()
    self:showRole()
    LoadingMgr:SetLoadingOver(function()
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
    end, nil, "TrialPanel")
end

function TrialPanel:initData(data)
    self.curSelRoleId = nil
    self.curSkinId = nil
    self.btnInfoList = {}
    self.roleTrialDataList = {}
    self.skinTrialDataList = {}
    for _, cfg in pairs(data) do
        if cfg[1] == 1 then
            table.insert(self.roleTrialDataList, cfg)
        elseif cfg[1] == 2 then
            table.insert(self.skinTrialDataList, cfg)
        end
    end
end

function TrialPanel:initLeftList()
    self.box1.btnRoot:SetActive(true)
    self.box2.btnRoot:SetActive(false)
    self.roleUseBtn.sel:SetActive(true)
    self.skinUseBtn.sel:SetActive(false)
    self:fillBtn(self.box1.btnRoot, tablex.size(self.roleTrialDataList), self.roleTrialDataList, true)
    self:fillBtn(self.box2.btnRoot, tablex.size(self.skinTrialDataList), self.skinTrialDataList)
end

function TrialPanel:fillBtn(root, num, dataList, isInit)
    self:FillTemplateContent(self.btnNode, root, num, function (index, itemObj)
        local data = dataList[index]
        if not data then return end
        local roleId = data[2]
        if not roleId then
            LuaLogger.e("角色id不存在，index:"..index)
            return
        end
        local roleConfig = Config.GetCharacterInfo(roleId)
        if not roleConfig then
            LuaLogger.e("角色配置不存在，roleId:"..roleId)
            return
        end
        table.insert(self.btnInfoList, {
            itemObj = itemObj,
            roleId = roleId
        })

        local skinId, levelId = nil, nil
        if data[1] == 1 then
            --角色
            skinId = roleConfig.baseSkinID
            levelId = data[3]
        else
            --皮肤
            skinId = data[3]
            levelId = data[4]
        end
        if isInit and index == 1 then
            self.curSelRoleId = roleId
            self.curSkinId = skinId
            self.levelId = levelId
            self:refreshBtnState()
            self:showRole()
        end
        itemObj.nameTex.text.text = roleConfig.name
        itemObj.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.curSelRoleId = roleId
            self.curSkinId = skinId
            self.levelId = levelId
            self:refreshBtnState()
            self:showRole()
        end)
    end)
    DLuaTimer:DoAfter(0.1, function()
        UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.box1.transform)
        UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.box2.transform)
        UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content.transform)
    end)
end

--刷新按钮状态
function TrialPanel:refreshBtnState()
    for _, info in pairs(self.btnInfoList) do
        local isSel = self.curSelRoleId == info.roleId
        info.itemObj.sel:SetActive(isSel)
    end
end
function TrialPanel:showRole()
    if not self.curSelRoleId or not self.curSkinId or not self.levelId then return end
    local roleConfig = Config.GetCharacterInfo(self.curSelRoleId)
    if not roleConfig then return end
    --舰种图标 1
    local roleTypeIcon = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
    self:LoadSpriteAsync(roleTypeIcon, self.specialInfo.roleTypeIcon.image)
    self.specialInfo.nameTypeTxt.text.text = roleConfig.class
    self.specialInfo.nameTxt.text.text = roleConfig.name
    --角色稀有度标志 2
    local qualityIcon = string.format(Config.SpritePath.roleQualityIcon, roleConfig.rank)
    self:LoadSpriteAsync(qualityIcon, self.specialInfo.rareIcon.image)
        --角色spine 4
    UICommonUtils:ShowRolePicOrSpine(self, self.specialInfo.showCharacter, self.curSkinId, function(spineObject)
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
            GameObject.Destroy(self.nowShowSpineObj)
        end
        local objSpine = spineObject:GetComponent("SkeletonGraphic")
        objSpine.PhysicsPositionInheritanceFactor = Vector2.zero
        self.nowShowSpineObj = spineObject
        self.specialInfo.showCharacter.rectTransform.anchoredPosition = Vector2(0, self.specialInfo.showCharacter.rectTransform.anchoredPosition.y)
        --self.nowShowSpineObj:SetActive(false)
        self.nowShowSpineObj:SetActive(true)
        --self:checkLoadComplete()
    end)
    local levelConfig = Config.GetPveLevelInfo(self.levelId)
    if levelConfig then
        for i = 1, 2 do
            local rewardData = levelConfig.nomalDropShow[i]
            local obj = self["reward"..i]
            if rewardData then
                obj:SetActive(true)
                obj.customBox:setMono(self)
                obj.customBox:SetUIData(rewardData)
            else
                obj:SetActive(false)
            end
        end
    end
end

--function TrialPanel:OnClose(initiative)
--
--end

--function TrialPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function TrialPanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/TrialBtn onClick 
--]]
function TrialPanel:trialBtn_ScaleButton_onClick(trialBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:setNowSelectLevel(self.levelId)
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "TrialPanel2")
end

--[[
/AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1/RoleUseBtn onClick 
--]]
function TrialPanel:roleUseBtn_ScaleButton_onClick(roleUseBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local state = self.box1.btnRoot.activeSelf
    self.box1.btnRoot:SetActive(not state)
    self.roleUseBtn.sel:SetActive(not state)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.box1.transform)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.box2.transform)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content.transform)
end

--[[
/AdjustRoot/ListBg/Scroll View/Viewport/Content/Box1/BtnRoot/BtnNode onClick 
--]]
function TrialPanel:btnNode_ScaleButton_onClick(btnNode)

end

--[[
/AdjustRoot/ListBg/Scroll View/Viewport/Content/Box2/SkinUseBtn onClick 
--]]
function TrialPanel:skinUseBtn_ScaleButton_onClick(skinUseBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local state = self.box2.btnRoot.activeSelf
    self.box2.btnRoot:SetActive(not state)
    self.skinUseBtn.sel:SetActive(not state)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.box1.transform)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.box2.transform)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content.transform)
end

--[[
/SpecialInfo/RoleInfoBg/NameTxt/RoleInfoBtn onClick 
--]]
function TrialPanel:roleInfoBtn_ScaleButton_onClick(roleInfoBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    LoadingMgr:SetUISwitchStart(function()
        UIMgr:popUI("DockRolePanel", {uiMode = 3, characterId = self.curSelRoleId}, function()
            LoadingMgr:SetUISwitchOver()
        end)
    end)
end

--[[
/AdjustRoot/RaffleBtn onClick 
--]]
function TrialPanel:raffleBtn_ScaleButton_onClick(raffleBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    LoadingMgr:SetUISwitchStart(function()
        UIMgr:popUI("RaffleMainPanel", {}, function()
            LoadingMgr:SetUISwitchOver()
        end)
    end)
end

return TrialPanel
