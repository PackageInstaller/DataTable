---@class StarUpPanel : StarUpPanel_Generate
---##################### 【StarUpPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【StarUpPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local StarUpPanel = require "StarUpPanel_Generate"
local Random = require "Random"

function StarUpPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
	}
    self.nowSelect = 1
    self.canStarUp = false
    self.heroId = nil
    self.roleData = {}
    self.uiModeType = {
        ["normal"] = 1, --普通模式
        ["hankBook"] = 2, --图鉴模式
    }

    self.uiMode = self.uiModeType.normal --默认界面模式
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.customBox.customBox:setMono(self)
    self.rewardBox.customBox:setMono(self)
    self.beforeStarUpAttrs = nil  -- 升星前六维快照
    self.upMsgPhase = 0           -- UpMsgView点击阶段：0=未显示 1=第一段 2=第二段
end

--function StarUpPanel:StartCreating(time)
--
--end

--function StarUpPanel:StartEnter(time)
--
--end

--function StarUpPanel:StartRemoving(time)
--
--end

--function StarUpPanel:StartExit(time)
--
--end

function StarUpPanel:OnOpen(data, initiative)
    self.heroId = data.id
    self.uiMode = data.uiMode or self.uiModeType.normal --界面模式
    if initiative then
        --导航栏
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.StarUpPanel)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
            self.animator:SetTrigger("Out")
            self.animOverCallBack:SetCallBack(function()
                UIMgr:closeSpecificUI(self)
                self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
            end)
            self.customBackPanel.customBackPanel:ClearBackFunc()
        end)
    end
    self.roleConfig = Config.GetCharacterInfo(self.heroId)
    self.roleData = Me:getPlayerHero(self.heroId)
    LuaLogger.ds("self.uiMode", self.uiMode)
    if self.uiMode == self.uiModeType.hankBook then
        self.roleData = {
            star = self.roleConfig.baseStar,
            equipSkin = self.roleConfig.baseSkinID,
        }
    end
    LuaLogger.ds(":self.roleData", tablex.dump(self.roleData))
    self:SetRoleImg()
    self:SetView()
    self:SelectBox(math.min(self.roleData.star + 1, Config.MaxRoleStar))
    --self:SetPostProcessing()
end

function StarUpPanel:SetView(needEffect)
    for i = 1, Config.MaxRoleStar do
        self["starBox_"..i].btn.scaleButton.onClick:RemoveAllListeners()
        local starPath = string.format(Config.SpritePath.StarLevelImg, i)
        self:LoadSpriteAsync(starPath, self["starBox_"..i].isOn.levelImg.image)
        if i >= self.roleConfig.baseStar then
            self["starBox_"..i].lockImg:SetActive(false)
            if self.roleData and self.roleData.star >= i then
                self["starBox_"..i].isOn:SetActive(true)
                self["starBox_"..i].unlock:SetActive(false)
            else
                self["starBox_"..i].isOn:SetActive(false)
                self["starBox_"..i].unlock:SetActive(true)
            end
            self["starBox_"..i].btn.scaleButton.onClick:AddListener(function()
                self:play2DSound(self.btnSoundPath)
                self:SelectBox(i)
            end)
            self["starBox_"..i].effectPoint:SetActive(i == self.roleData.star)
            self["starBox_"..i].effectLoop:SetActive(not needEffect)
        else
            self["starBox_"..i].unlock:SetActive(false)
        end
    end

    if needEffect then
        self:PlayStarUpEffect(self.roleData.star)
    end

    local UICamera = UIMgr.uiCamera
    UICamera.orthographic = true
end

function StarUpPanel:SetRoleImg()
    local skinConfig = Config.GetCharacterSkinInfo(self.roleData.equipSkin)
    UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, skinConfig.id, function(spineObject)
        --设置spine物理效果
        local objSpine = spineObject:GetComponent("SkeletonGraphic")
        objSpine.PhysicsPositionInheritanceFactor = Vector2.New(0.1, 0.1)
    end)
end

--选中星级box
function StarUpPanel:SelectBox(index, isRefresh)
    if index == self.nowSelect and not isRefresh then
        return
    end
    self.nowSelect = index

    for i = 1, Config.MaxRoleStar do
        self["starBox_"..i].isSelect:SetActive(i == self.nowSelect)
    end
    local skillConfig = Config.GetSkillInfo(self.roleConfig.talentId[self.roleData.star])
    local selectConfig = Config.GetSkillInfo(self.roleConfig.talentId[self.nowSelect])

    --图标and名称显示
    self.iconImg:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), self.iconImg.image)
    self.skillNameTxt.text.text = skillConfig.nameKey

    self:refreshRewardBox()
    self.starUpView:SetActive(self.nowSelect <= self.roleData.star)
    self.needPanel:SetActive(self.nowSelect > self.roleData.star)
    self.selectEffect:SetActive(self.nowSelect > self.roleData.star)
    self.levelOkBtn:SetActive(self.nowSelect == self.roleData.star + 1 and self.nowSelect ~= self.roleData.star)
    self.isLock:SetActive(self.nowSelect ~= self.roleData.star + 1 and self.nowSelect > self.roleData.star)
    self.nowMsg.text.text = skillConfig.desKey
    local newColor = "#ff6600"
    local desText = selectConfig.desKey
    desText = string.gsub(desText, "<color=#%x%x%x%x%x%x>", "<color=" .. newColor .. ">")
    self.selectMsg.text.text = desText
    self:LoadSpriteAsync(string.format(Config.SpritePath.StarLevelImg, self.roleData.star), self.nowStarImg.image)
    self:LoadSpriteAsync(string.format(Config.SpritePath.StarLevelImg, self.nowSelect), self.selectStarImg.image)
    local itemData = Me:getItemById(self.roleConfig.patchCost[self.nowSelect][2])
    if itemData then
        if itemData.num < self.roleConfig.patchCost[self.nowSelect][3] then
            self.canStarUp = false
        else
            self.canStarUp = true
        end
    else
        self.canStarUp = false
    end
    local data = {
        id = self.roleConfig.patchCost[self.nowSelect][2],
        itemType = GE.ItemTypeIndex.item,
        itemNum = itemData and itemData.num .. "/" .. self.roleConfig.patchCost[self.nowSelect][3] or "0/" .. self.roleConfig.patchCost[self.nowSelect][3],
        navType = GE.NavigationType.StarUpPanel,
		tipsPassEventState = false,
        ownerPanelName = self.uiConfig.id,
    }
    self.customBox.customBox:setMono(self)
    self.customBox.customBox:refreshUI(data)
    self:changeUiModeView()
end

function StarUpPanel:refreshRewardBox()
    --到达哪个等级可以获得奖励
    local function setBoxListener(starAward)
        local data = {
            type = GE.CustomMsgType.Equip,
            config = Config.GetEquipmentInfo(starAward[2][2]),
            Id = starAward[2][2],
            CanLock = false,
        }
        self:OpenCustomMsgPanel(data)
    end
    local starAward = self.roleConfig.StarAward

    local isNull = tablex.next(starAward) == nil

    if isNull then
        self.rewardBg:SetActive(false)
        self.isNull:SetActive(true)
        return
    end
    self.isNull:SetActive(false)
    self.rewardBg:SetActive(true)
    local awardConfig = Config.GetEquipmentInfo(starAward[2][2])
    self.rewardBox:SetActive(next(starAward) ~= nil)
    self.isUnOpen:SetActive(next(starAward) == nil)
    self.isOnTxt:SetActive(next(starAward) ~= nil)
    self.unOpenTxt:SetActive(next(starAward) == nil)

    if awardConfig.quality == 5 then
        self.effectCai:SetActive(starAward[1] <= self.roleData.star and not self.roleData.getStarRewardFlag)
    elseif awardConfig.quality == 4 then
        self.effectJin:SetActive(starAward[1] <= self.roleData.star and not self.roleData.getStarRewardFlag)
    end

    self.rankIconImg:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.StarLevelImg, starAward[1]), self.rankIconImg.image)
    local customData = {
        id = starAward[2][2],
        itemType = GE.ItemTypeIndex.equip,
        isLock = false,
        itemNum = "Lv.1",
        isGet = self.roleData.getStarRewardFlag,
        ownerPanelName = self.uiConfig.id,
        listener = function()
            if self.roleData.getStarRewardFlag then
                setBoxListener(starAward)
            else
                if self.roleData.star < starAward[1] then   --星级未达到要求
                    setBoxListener(starAward)
                else
                    Me:getHeroStarRewardReq({id = self.roleData.id} , function(data)
                        self:RefreshUI()
                        Me:ReceiveReward(data.rewardList, function()
                        end)
                    end)
                end
            end
        end
    }

    self.rewardBox.customBox:setMono(self)
    self.rewardBox.customBox:refreshUI(customData)
end

function StarUpPanel:OpenCustomMsgPanel(data)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

function StarUpPanel:changeUiModeView()
    if self.uiMode == self.uiModeType.hankBook then
        self.needPanel:SetActive(false)
        self.levelOkBtn:SetActive(false)
        self.starUpView:SetActive(true)
        self.starOn:SetActive(false)
        self.isLock:SetActive(false)
    end
end

--设置相机的后处理
function StarUpPanel:SetPostProcessing()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--界面刷新
function StarUpPanel:RefreshUI(addShow)
    self.roleData = Me:getPlayerHero(self.roleConfig.id)
    if self.uiMode == self.uiModeType.hankBook then
        self.roleData = {
            star = self.roleConfig.baseStar,
            equipSkin = self.roleConfig.baseSkinID,
        }
    end
    self:SetView(true)
    self:SelectBox(math.min(self.nowSelect + (addShow ~= nil and addShow or 0), Config.MaxRoleStar), true)
end

--播放升星特效
function StarUpPanel:PlayStarUpEffect(index)
    self["starBox_"..index].effectStarUp:SetActive(true)
    self["starBox_"..index].effectLoop:SetActive(false)
    self.upTimer = DLuaTimer:DoAfter(0.9, function()
        self["starBox_"..index].effectStarUp:SetActive(false)
        self["starBox_"..index].effectLoop:SetActive(true)
    end)
end

--播放角色升星语音
function StarUpPanel:PlayVoice()
    local skinConfig = Config.GetCharacterSkinInfo(self.roleData.equipSkin)
    local lineWeightMain = {}
    local rankUpLine = skinConfig.rankUp
    for _, lineData in pairs(rankUpLine) do
        table.insert(lineWeightMain, {index = lineData[1], weight = lineData[2]})
    end
    if not next(lineWeightMain)then
        return
    end
    local voiceId = DLuaUtil.getRandomIndexLinear(lineWeightMain, Random:new(DLuaUtil.GetGreenwichTime()))
    local nowLineConfig = Config.GetScriptLinesInfo(voiceId)
    if not nowLineConfig then
        return
    end
    local voicePath = string.format(Config.AudioPath.CharacterVoice, nowLineConfig.resource)
    UICommonUtils.Play2DVoiceByLanguage(self.roleData.id, nowLineConfig.resource, nil, self.gameObject)
end

function StarUpPanel:OnClose(initiative)
    if self.upTimer then
        DLuaTimer:RemoveTimer(self.upTimer)
    end
end

function StarUpPanel:OnDestroy()
	local UICamera = UIMgr.uiCamera
    if UICamera then
        UICamera.orthographic = false
    end
    if self.upTimer then
        DLuaTimer:RemoveTimer(self.upTimer)
    end
    self.super:OnDestroy(self)
end

--function StarUpPanel:OnRefresh(data)
--
--end

--[[
/PanelBg/ItemBox/EquipBtn onClick 
--]]
function StarUpPanel:equipBtn_ScaleButton_onClick(equipBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/PanelBg/LevelOkBtn onClick 
--]]
function StarUpPanel:levelOkBtn_ScaleButton_onClick(levelOkBtn)
    self:play2DSound(self.btnSoundPath)
    if not self.canStarUp then
        UICommonUtils.PopToast("材料不足")
        return
    end
    self.beforeStarUpAttrs = self:GetAttrSnapshot(self.roleData)
    Me:roleStarUpReq({id = self.roleConfig.id} , function(data)
        self:PlayVoice()
        if data.rewardList and #data.rewardList > 0 then
            Me:ReceiveReward(data.rewardList, function()
                --弹出升星提示
                self:upMsgViewInit()
                self.upMsgView:SetActive(true)
            end)
        else
            self:RefreshUI(1)
            --弹出升星提示
            self:upMsgViewInit()
            self.upMsgView:SetActive(true)
        end
	end)
end

-- 获取角色六维快照
function StarUpPanel:GetAttrSnapshot(roleData)
    roleData = roleData or {}
    return {
        hp = tonumber(roleData.hp) or 0,
        bombard = tonumber(roleData.bombard) or 0,
        torpedo = tonumber(roleData.torpedo) or 0,
        armor = tonumber(roleData.armor) or 0,
        evade = tonumber(roleData.evade) or 0,
        airdefense = tonumber(roleData.airdefense) or 0,
        lucky = tonumber(roleData.lucky) or 0,
    }
end

-- 刷新六维显示（基础值 + 提升值）
function StarUpPanel:RefreshAttrPanel(beforeAttrs, afterAttrs)
    local attrMap = {
        {key = "hp", txt = self.hpTxt, upTxt = self.hpUpTxt, upImg = self.hpImg and self.hpImg.upImg},
        {key = "bombard", txt = self.bombardTxt, upTxt = self.bombardUpTxt, upImg = self.bombardImg and self.bombardImg.upImg},
        {key = "torpedo", txt = self.torpedoTxt, upTxt = self.torpedoUpTxt, upImg = self.torpedoImg and self.torpedoImg.upImg},
        {key = "armor", txt = self.armorTxt, upTxt = self.armorUpTxt, upImg = self.armorImg and self.armorImg.upImg},
        {key = "evade", txt = self.evadeTxt, upTxt = self.evadeUpTxt, upImg = self.evadeImg and self.evadeImg.upImg},
        {key = "airdefense", txt = self.airdefenseTxt, upTxt = self.airdefenseUpTxt, upImg = self.airdefenseImg and self.airdefenseImg.upImg},
        {key = "lucky", txt = self.luckyTxt, upTxt = self.luckyUpTxt, upImg = self.luckyImg and self.luckyImg.upImg},
    }

    local beforeData = beforeAttrs or afterAttrs or {}
    local afterData = afterAttrs or beforeData
    local canShowUp = beforeAttrs ~= nil and afterAttrs ~= nil

    for i = 1, #attrMap do
        local item = attrMap[i]
        local beforeVal = tonumber(beforeData[item.key]) or 0
        local afterVal = tonumber(afterData[item.key]) or 0
        local delta = afterVal - beforeVal
        local isUp = canShowUp and delta > 0

        if item.txt and item.txt.text then
            item.txt.text.text = tostring(beforeVal)
        end
        if item.upTxt and item.upTxt.text then
            item.upTxt.text.text = isUp and ("+" .. tostring(delta)) or ""
        end
        if item.upTxt then
            item.upTxt:SetActive(isUp)
        end
        if item.upImg then
            item.upImg:SetActive(isUp)
        end
    end
end

function StarUpPanel:upMsgViewInit()
    -- 刷新角色数据以获取升星后的最新属性
    self.roleData = Me:getPlayerHero(self.roleConfig.id)
    local afterAttrs = self:GetAttrSnapshot(self.roleData)
    self:RefreshAttrPanel(self.beforeStarUpAttrs, afterAttrs)
    self.beforeStarUpAttrs = nil

    local skillConfig = Config.GetSkillInfo(self.roleConfig.talentId[self.roleData.star])
    self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), self.skillBox.iconImg.image)
    local newColor = "#ff6600"
    local desText = skillConfig.desKey
    desText = string.gsub(desText, "<color=#%x%x%x%x%x%x>", "<color=" .. newColor .. ">")
    self.skillUpMsgTxt.text.text = desText
    local charCount = DLuaUtil.GetStrLenWithoutRichText(desText)
    if charCount > 36 then
        self.skillUpMsgTxt.text.alignment = TMPro.TextAlignmentOptions.Left
    else
        self.skillUpMsgTxt.text.alignment = TMPro.TextAlignmentOptions.Center
    end
    self.upMsgPhase = 1
end

--[[
/UpMsgView onClick 
--]]
function StarUpPanel:upMsgView_Button_onClick(upMsgView)
    if self.upMsgPhase == 1 then
        -- 第一次点击：播放 Next 动画
        self.upMsgView.button.interactable = false
        self.upMsgView.animator:SetTrigger("Next")
        self.upMsgView.animOverCallBack:SetCallBackOfName(function(name)
            if name ~= "Next" then return end
            self.upMsgPhase = 2
            self.upMsgView.button.interactable = true
        end)
    elseif self.upMsgPhase == 2 then
        -- 第二次点击：播放 Out 动画后关闭
        self.upMsgView.button.interactable = false
        self.upMsgView.animator:SetTrigger("Out")
        self.upMsgView.animOverCallBack:SetCallBackOfName(function(name)
            if name ~= "Out" then return end
            self.upMsgPhase = 0
            self.upMsgView.button.interactable = true
            self.upMsgView:SetActive(false)
            self:RefreshUI()
        end)
    end
end

--[[
/UpMsgView/SkillBg/SkillBox/Btn onClick 
--]]
function StarUpPanel:btn_ScaleButton_onClick(btn)

end

--[[
/AdjustRoot/IsNull onClick 
--]]
function StarUpPanel:isNull_ScaleButton_onClick(isNull)
    UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_EquipIsLock)
end

return StarUpPanel
