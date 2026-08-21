local M = BaseClass("StoryCmdResponseCtrl", require("UI.Ctrl.Story.BaseStoryCtrl"))
local tIsNullOrEmpty = table.isNullOrEmpty
local StoryMgr = StoryDataMgr:GetInstance()
local ResMgr = ResourceManager:GetInstance()

function M:Init()
    self.m_tempEffGos = {}
    self.m_setBgRaycast = nil
    self.m_animPanelTrans = self._view.rectAnimPanel.transform
    self.m_selectTexts = { self._view.txtSelect1, self._view.txtSelect2, self._view.txtSelect3 }
    self.m_selectStates = { self._view.stateSelect1, self._view.stateSelect2, self._view.stateSelect3 }
    self.m_bgEffectRTs = { self._view.rectBgEffect1, self._view.rectBgEffect2, self._view.rectBgEffect3 }
    self.m_magnifierRTs = { self._view.rectMagnifier1, self._view.rectMagnifier2, self._view.rectMagnifier3 }
    self.m_roleEffectRTs = { self._view.rectRoleEffect1, self._view.rectRoleEffect2, self._view.rectRoleEffect3 }

    for i, trans in ipairs(self.m_selectStates) do trans:onClick(Bind(self, self.OnClickSelect, i)) end
    for i, trans in ipairs(self.m_bgEffectRTs) do trans:onClick(Bind(self, self.OnClickBgEffect, i)) end
    for i, trans in ipairs(self.m_magnifierRTs) do trans:onClick(Bind(self, self.OnClickMagnifier, i)) end
    for i, trans in ipairs(self.m_roleEffectRTs) do trans:onClick(Bind(self, self.OnClickRoleEffect, i)) end
end

function M:OnDispose()
    self:_DestoryEffGos()
    self.m_tempEffGos = nil
    self.m_selectTexts = nil
    self.m_bgEffectRTs = nil
    self.m_setBgRaycast = nil
    self.m_magnifierRTs = nil
    self.m_selectStates = nil
    self.m_roleEffectRTs = nil
    self.m_animPanelTrans = nil
    M.super.OnDispose(self)
end

function M:_DestoryEffGos()
    for _, go in ipairs(self.m_tempEffGos) do
        GameUtil.DestroyGo(go)
    end
    self.m_tempEffGos = {}
end

function M:ShowSelections(storyCfg)
    local repeatSelects = StoryMgr:GetRepeatSelects() or {}
    local cmdType, cmderTalk = storyCfg.commanderType, storyCfg.commanderTalk
    local talkLen, nextStepIds = #cmderTalk, storyCfg.nextStepId
    local cmderMoon = storyCfg.commanderMoon or {}
    for i, txt in ipairs(self.m_selectTexts) do
        local uiState = self.m_selectStates[i]
        if i <= talkLen then
            StoryHelper.SetActive(uiState, true)
            local content = ConfigHelper.GetLocalStringByPlayerName(cmderTalk[i])
            if table.indexof(repeatSelects, nextStepIds[i]) then
                txt:SetText(content .. "(已确认)")
            else
                txt:SetText(content)
            end

            if cmdType == StoryConst.ResponseType.Selection then
                uiState:SetState(StoryConst.SelectState.Normal)
            else
                local value = cmderMoon[i] or 0
                if value > 0 then uiState:SetState(value) end
            end
        else
            StoryHelper.SetActive(uiState, false)
        end
    end
end

function M:ShowRoleEffect(storyCfg)
    self:_DestoryEffGos()
    local cmdEffPath = storyCfg.commanderEffect
    local cmderTalk = storyCfg.commanderTalk or {}
    for i, rTrans in ipairs(self.m_roleEffectRTs) do
        --0:无特效 1:索引Role表第一组坐标 2:索引Role表第二组坐标
        if (cmderTalk[i] or 0) ~= 0 then
            StoryHelper.SetActive(rTrans, true)
            self:_InstantiateEffect(rTrans, cmdEffPath)
        else
            StoryHelper.SetActive(rTrans, false)
        end
    end

    local roleShow = storyCfg.roleShow or {}
    for i, value in ipairs(cmderTalk) do
        local index, roleId = value - 1, roleShow[i]
        if (value ~= 0) and (roleId > 0) then
            local roleCfg = ConfigHelper.GetCfg("role", roleId)
            if roleCfg then
                local pos = roleCfg.effectPosition
                local coord = Vector2.New(pos[index * 2] / 100, pos[index * 2 + 1] / 100)
                self.m_roleEffectRTs[i].anchoredPosition = coord
            else
                Logger.LogError("role is nil, 请 <color=yellow>@杜老师</color>, id = " .. roleId)
            end
        end
    end
end

function M:ShowBgEffects(storyCfg)
    self:_DestoryEffGos()
    local cmderTalk = storyCfg.commanderTalk
    if not tIsNullOrEmpty(cmderTalk) then
        local cmdEffPath = storyCfg.commanderEffect
        local nextStepIds = storyCfg.nextStepId or {}
        local repeatSelects = StoryMgr:GetRepeatSelects() or {}
        for i = 1, (#cmderTalk / 2) do
            local rTrans = self.m_bgEffectRTs[i]
            if not table.indexof(repeatSelects, nextStepIds[i]) then
                StoryHelper.SetActive(rTrans, true)
                self:_InstantiateEffect(rTrans, cmdEffPath)
            end
            --commandTalk中是bgEffect的坐标点
            local coord = Vector2.New(cmderTalk[i * 2 - 1], cmderTalk[i * 2])
            rTrans.anchoredPosition = coord
        end
    end
end

function M:ShowRoleMagnifiers(storyCfg)
    self:_DestoryEffGos()
    local cmderTalk = storyCfg.commanderTalk
    if not tIsNullOrEmpty(cmderTalk) then
        local roleShow = storyCfg.roleShow or {}
        local nextStepIds = storyCfg.nextStepId
        local cmdEffPath = storyCfg.commanderEffect
        local repeatSelects = StoryMgr:GetRepeatSelects() or {}
        for i, value in ipairs(cmderTalk or {}) do
            local rTrans = self.m_magnifierRTs[i]
            if not table.indexof(repeatSelects, nextStepIds[i]) then
                StoryHelper.SetActive(rTrans, true)
                self:_InstantiateEffect(rTrans, cmdEffPath)
            end
            local index, roleId = value - 1, roleShow[i] or 0
            --0 无 1 第一组坐标 2 第二组坐标 ...
            if (value ~= 0) and (roleId > 0) then
                local roleCfg = ConfigHelper.GetCfg("role", roleId)
                if roleCfg then
                    local position = roleCfg.effectPosition
                    local coord = Vector2.New(position[index * 2] / 100, position[index * 2 + 1] / 100)
                    rTrans.anchoredPosition = coord
                else
                    Logger.LogError("role is nil, 请 <color=yellow>@杜老师</color>, id = " .. roleId)
                end
            end
        end
    end
end

function M:ShowAnimSeries(animPath)
    self:_ShowAnimation(animPath, "StoryAnimSeries")
end

function M:ShowAnimParallel(animPath)
    self:_ShowAnimation(animPath, "StoryAnimParallel")
end

function M:ShowAnimSwipe(animPath)
    self:_ShowAnimation(animPath, "StoryAnimSwipe")
end

function M:ShowGiftStory(storyCfg)
    self._view.imgAnimItem:SetPic(storyCfg.animPath, true)
    self._view.giftTrigger:AddClickListener(function()
        self._view.giftTrigger:RemoveClickListener()
        StoryDataMgr:GetInstance():CheckAndSendStoryReward(storyCfg, 1)
        self._view.giftTrigger:SetTrigger(StoryConst.AnimName.AnimTrigger)
        self._view.giftTrigger:SetAnimEndCallback(function() StoryMgr:NextStory() end)
    end)
end

function M:ShowAnimAuto(storyCfg)
    self._view.imgAnimItem:SetPic(storyCfg.animPath, true)
    self._view.giftTrigger:AddClickListener(function()
        UIContextMgr:GetInstance():Show("StoryTextPopup", storyCfg, false, function()
            self._view.giftTrigger:RemoveClickListener()
            self._view.giftTrigger:SetTrigger(StoryConst.AnimName.AnimTrigger)
            self._view.giftTrigger:SetAnimEndCallback(function() StoryMgr:NextStory() end)
        end)
    end)
end

function M:SetBgRaycastCallback(callback)
    self.m_setBgRaycast = callback
end

function M:SetRaycasterVisible(storyCfg)
    -- local cmdType = storyCfg.commanderType
    -- local unMag = cmdType ~= ResponseType.RoleMagnifier
    -- local unEff = cmdType ~= ResponseType.RoleEffect
    -- local unVdo = cmdType ~= ResponseType.Video
    -- self:_SetRaycasterEnable(unEff or unMag or unVdo)
end

function M:OnClickMagnifier(index, _)
    self:SelectMagnifier(index)
    self:_HideEffects(self.m_magnifierRTs)
end

function M:OnClickSelect(index, _)
    self:SelectDialogue(index)
    for _, state in ipairs(self.m_selectStates) do StoryHelper.SetActive(state, false) end
end

function M:OnClickRoleEffect(index, _)
    self:SelectRoleEffect(index)
    self:_HideEffects(self.m_roleEffectRTs)
end

function M:OnClickBgEffect(index, _)
    self:SelectBgEffect(index)
    self:_HideEffects(self.m_bgEffectRTs)
end

function M:_HideEffects(list)
    for _, rTrans in ipairs(list) do
        rTrans:SetActive(false)
        self:_DestoryEffect(rTrans)
    end
end

function M:_InstantiateEffect(parent, cmdEffPath)
    local go = ResMgr:InstanceGameObject(cmdEffPath)
    local trans = go.transform
    trans:SetParent(parent.transform, false)
    trans.localPosition = Vector3.zero
    trans:SetActive(true)
    table.insert(self.m_tempEffGos, go)
end

function M:_DestoryEffect(parent)
    local storyCfg = StoryMgr:GetStory()
    if string.isNullOrEmpty(storyCfg.animPath) then
        local pTrans = parent.transform
        local count = pTrans.childCount
        if count > 0 then
            for i = 0, count - 1 do
                GameUtil.DestroyGo(pTrans:GetChild(i).gameObject)
            end
        end
    end
end

function M:_ShowAnimation(animPath, typeName)
    local go = ResMgr:InstanceGameObject(animPath)
    go.transform:SetParent(self.m_animPanelTrans, false)
    go.transform.localPosition = Vector3.zero
    local animTrigger = go:GetComponent(typeName)
    if not IsNull(animTrigger) then
        animTrigger:SetAnimEndCallback(function()
            StoryMgr:NextStory()
            self:_DestoryEffect(self.m_animPanelTrans)
            if self.m_setBgRaycast then self.m_setBgRaycast(true) end
        end)
    end
end

return M
