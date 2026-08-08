---@class ShowCharacterPanel : ShowCharacterPanel_Generate
---##################### 【ShowCharacterPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ShowCharacterPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ShowCharacterPanel = require "ShowCharacterPanel_Generate"

function ShowCharacterPanel:InitLogic(data)
    self.loadCount = 10

    self.nowShowEffect1 = nil

    self.nowShowEffect2 = nil
end

--function ShowCharacterPanel:StartCreating(time)
--
--end

--function ShowCharacterPanel:StartEnter(time)
--
--end

--function ShowCharacterPanel:StartRemoving(time)
--
--end

--function ShowCharacterPanel:StartExit(time)
--
--end

function ShowCharacterPanel:OnOpen(data, initiative)
    self.closeFunc = data.closeFunc
    self.passInResultData = data.resultData
    self:SetUIVolume()
    self:setShowCharacterData()
    local isSingle = RaffleMgr:getIsSingle()
    if isSingle then
        UIMgr:endDepositToast(GE.DepositToastType.RaffleOne)
    end
end

function ShowCharacterPanel:setShowCharacterData()
    self.resultData = self.passInResultData or RaffleMgr:getCurrentResultData()
    if not self.resultData then
        return
    end
    self.roleConfig = Config.GetCharacterInfo(self.resultData.id)
    if not self.roleConfig then
        return
    end
    local roleConfig = self.roleConfig
    if self.roleConfig.rank == GE.HeroRankStar.R or self.roleConfig.rank == GE.HeroRankStar.SR then
        local btnSoundPath = string.format(Config.AudioPath.SE, "gacha_sr")
        self:play2DSound(btnSoundPath)
    elseif self.roleConfig.rank == GE.HeroRankStar.SSR then
        local btnSoundPath = string.format(Config.AudioPath.SE, "gacha_ssr")
        self:play2DSound(btnSoundPath)
    end

    local skinConfig = Config.GetCharacterSkinInfo(roleConfig.baseSkinID)
    if not skinConfig then
        return
    end

    --初始化节点位置
    self:initUIRootPos()

    

    --角色稀有度背景 1
    local raffleQualityBg = string.format(Config.SpritePath.RaffleQualityBg, roleConfig.rank)
    self:LoadSpriteAsync(raffleQualityBg, function (s)
        self.rareTypeBg.image.sprite = s
        self:checkLoadComplete()
    end)
    --角色稀有度标志 2
    local qualityIcon = string.format(Config.SpritePath.RaffleShowRare, roleConfig.rank)
    self:LoadSpriteAsync(qualityIcon, function (s)
        self.rareTypeIcon.image.sprite = s
        self:checkLoadComplete()
    end)
    --角色突破立绘 3
    local breakSkinConfig = Config.GetCharacterSkinInfo(roleConfig.breakSkinID)
    if not breakSkinConfig then
        return
    end
    local roleBreakBg = string.format(Config.SpritePath.RoleBreakPortrait, roleConfig.id, roleConfig.id)
    self:LoadSpriteAsync(roleBreakBg, function (s)
        self.roleBreakIcon.image.sprite = s
        self.roleBreakIcon.rectTransform.anchoredPosition = Vector2.New(breakSkinConfig.GachaOffset[1], breakSkinConfig.GachaOffset[2])
        self.roleBreakIcon.transform.localScale = Vector3.New(breakSkinConfig.GachaimgRate, breakSkinConfig.GachaimgRate, 1)
        self:checkLoadComplete()
    end)
    --角色舰种 4
    local roleTypeIcon = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
    self:LoadSpriteAsync(roleTypeIcon, function (s)
        self.roleTypeIcon.image.sprite = s
        self:checkLoadComplete()
    end)
    --角色舰种灰色 5
    local roleTypeOff = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
    self:LoadSpriteAsync(roleTypeOff, function (s)
        self.roleTypeIconBg.image.sprite = s
        self:checkLoadComplete()
    end)
    --角色阵营图标 6
    local CharacterNationPath = string.format(Config.SpritePath.CharacterNationPath, roleConfig.nation)
    self:LoadSpriteAsync(CharacterNationPath, function (s)
        self.roleNationIcon.image.sprite = s
        self:checkLoadComplete()
    end)
    --角色阵营图标背景 7
    local RaffleNationBg = string.format(Config.SpritePath.RaffleNationBg, roleConfig.rank)
    self:LoadSpriteAsync(RaffleNationBg, function (s)
        self.roleNationIconBg.image.sprite = s
        self:checkLoadComplete()
    end)
    --角色稀有度tips条带 8
    local raffleQualityTips = string.format(Config.SpritePath.RaffleQualityTips, roleConfig.rank)
    self:LoadSpriteAsync(raffleQualityTips, function (s)
        self.roleTypeTipsIcon.image.sprite = s
        self:checkLoadComplete()
    end)
    --角色稀有度背景遮罩 9
    local raffleQualityBg = string.format(Config.SpritePath.RaffleQualityBgMask, roleConfig.rank)
    self:LoadSpriteAsync(raffleQualityBg, function (s)
        self.rareTypeBgMask.image.sprite = s
        self:checkLoadComplete()
    end)
    --角色立绘spine 10
    UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, skinConfig.id, function(spineObject)
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
             GameObject.Destroy(self.nowShowSpineObj)
        end
        self.nowShowSpineObj = spineObject
        --修改位置
        local headPointPos = self.nowShowSpineObj.transform:Find("HeadPoint").transform.localPosition
        self.nowShowSpineObj.transform.localPosition = Vector3.New(-headPointPos.x, -headPointPos.y, 0)
        self.nowShowSpineObj:SetActive(false)
        self:checkLoadComplete()
    end)

    --初始化特效
    self:initShowRoleEffect(roleConfig)

    --角色名字
    self.roleNameTxt.text.text = roleConfig.name
    --角色类型
    self.roleTypeTxt.text.text = roleConfig.typeName
    --是否为新角色
    self.isNewRole = not self.resultData.extraType and true or false
    self.isNew:SetActive(self.isNewRole)
    --台词文字
    local nowLineConfig
    if self.isNewRole then
        nowLineConfig = Config.GetScriptLinesInfo(roleConfig.getLines[1])
    else
        nowLineConfig = Config.GetScriptLinesInfo(roleConfig.getLines[2])
    end
    if not nowLineConfig then
        self.dialogueBg:SetActive(false)
    else
        local textLength = string.len(nowLineConfig.line)
        -- 计算文字实际渲染宽度，动态调整文字节点宽度（不超过最大宽度）
        local maxDialogueWidth = 1580  -- 台词框最大宽度（像素）
        local preferredValues = self.dialogueTxt.text:GetPreferredValues(nowLineConfig.line)
        local preferredWidth = preferredValues.x
        local finalWidth = math.min(preferredWidth, maxDialogueWidth)
        local sizeDelta = self.dialogueTxt.rectTransform.sizeDelta
        self.dialogueTxt.rectTransform.sizeDelta = Vector2.New(finalWidth, sizeDelta.y)
        self.dialogueCanvas.canvas.sortingLayerName = "UI"
        local playTime = textLength / 2.5 * 0.05
        self.text_tweener = self.dialogueTxt.text:DoTextMesh(nowLineConfig.line, playTime, function()
            self.text_tweener = nil
        end)
        self.text_tweener:Pause()
        local textColor
        if roleConfig.rank == GE.HeroRankStar.SSR then
            textColor = Color.New(255/255, 245/255, 254/255, 225/255)
        elseif roleConfig.rank == GE.HeroRankStar.SR then
            textColor = Color.New(255/255, 252/255, 237/255, 225/255)
        else
            textColor = Color.New(237/255, 246/255, 255/255, 225/255)
        end
        self.dialogueBg.image.color = textColor
        self.whiteLeft.image.color = textColor
        self.whiteRight.image.color = textColor
    end
end

--异步加载计数判断是否加载完成
function ShowCharacterPanel:checkLoadComplete()
    self.loadCount = self.loadCount - 1
    if self.loadCount <= 0 then
        --加载完成，播放动画
        self.canvasGroup.alpha = 1
        self.rareTypeBg.canvasGroup.alpha = 1
        RaffleMgr:setSceneCameraEnabled(false)
        self:showEffect()
        --角色获得语音
        RaffleMgr:playRoleGetVoice(self.resultData)
    end
end

--初始化UI节点位置
function ShowCharacterPanel:initUIRootPos()
    self.skipBtn.canvasGroup.alpha = 0
    self.skipBtn.canvasGroup.interactable = false
    self.rareTypeBg.canvasGroup.interactable = false
    --角色突破立绘
    local breakRootPos = self.roleBreakRoot.rectTransform.anchoredPosition
    self.roleBreakRoot.rectTransform.anchoredPosition = Vector2.New(breakRootPos.x + 100, breakRootPos.y)
    --角色阵营
    local nationRootPos = self.roleNationIconBg.rectTransform.anchoredPosition
    self.roleNationIconBg.rectTransform.anchoredPosition = Vector2.New(nationRootPos.x - 100, nationRootPos.y)
end

--播放界面动画
function ShowCharacterPanel:playShowCharAnim()
    --UI动画
    self.animator:SetTrigger("ShowCharacter")
    local moveTime = 30
    --角色突破立绘
    self.showCharacter.transform.localPosition = Vector3.zero
    self.nowShowSpineObj:SetActive(true)
    local breakRootPos = self.roleBreakRoot.rectTransform.anchoredPosition
    self.roleBreakRoot.rectTransform:DOAnchorPos(Vector2.New(breakRootPos.x - 100, breakRootPos.y), moveTime):SetEase(DG.Tweening.Ease.OutQuad)
    --角色阵营
    local nationRootPos = self.roleNationIconBg.rectTransform.anchoredPosition
    self.roleNationIconBg.rectTransform:DOAnchorPos(Vector2.New(nationRootPos.x + 100, nationRootPos.y), moveTime):SetEase(DG.Tweening.Ease.OutQuad)

    self.newtimer = DLuaTimer:DoAfter(1, function()
        self.skipBtn.canvasGroup.alpha = 1
        self.skipBtn.canvasGroup.interactable = true
        self.rareTypeBg.canvasGroup.interactable = true
        self.newtimer = nil
        RaffleMgr:hideWriteMask()
    end)

    --台词
    if self.text_tweener then
        self.text_tweener:Play()
    end
end

--显示特效
function ShowCharacterPanel:showEffect()
    local roleConfig = self.roleConfig
    if not roleConfig then
        return
    end
    self.effectMask.canvasGroup:DOFade(1, 0.2):OnComplete(function()
        --播放特效
        self:setEffectPosition()
        if UICommonUtils.Checkobj(self.nowShowEffect1) then
            local particleSys = self.nowShowEffect1.transform:Find("Effect"):GetComponent("ParticleSystem")
            particleSys:Simulate(0)
            particleSys:Play()
        end
        if UICommonUtils.Checkobj(self.nowShowEffect2) then
            local particleSys = self.nowShowEffect2.transform:Find("Effect"):GetComponent("ParticleSystem")
            particleSys:Simulate(0)
            particleSys:Play()
        end

        DLuaTimer:DoAfter( 0.1, function()
            self:playShowCharAnim()
        end)
        self.effectMask.canvasGroup:DOFade(0, 1)
    end)
end

--初始化特效
function ShowCharacterPanel:initShowRoleEffect(roleConfig)
    if roleConfig.rank == GE.HeroRankStar.R then
        self.nowShowEffect1 = self.effect_Ui_ChouKa_R
    elseif roleConfig.rank == GE.HeroRankStar.SR then
        self.nowShowEffect1 = self.effect_Ui_ChouKa_SR
        self.nowShowEffect2 = self.effect_Ui_ChouKa_SR_3
    elseif roleConfig.rank == GE.HeroRankStar.SSR then
        self.nowShowEffect1 = self.effect_Ui_ChouKa_SSR
        self.nowShowEffect2 = self.effect_Ui_ChouKa_SSR_2
        self.nowShowEffect3 = self.effect_Ui_ChouKa_SSR_7
    end
    self.nowShowEffect1:SetActive(true)
    self.nowShowEffect1.transform:SetParent(self.effectTempRoot.transform)
    self.nowShowEffect1.transform.localPosition = Vector3.zero
    if UICommonUtils.Checkobj(self.nowShowEffect2) then
        self.nowShowEffect2:SetActive(true)
        self.nowShowEffect2.transform:SetParent(self.effectTempRoot.transform)
        self.nowShowEffect2.transform.localPosition = Vector3.zero
    end
    if UICommonUtils.Checkobj(self.nowShowEffect3) then
        self.nowShowEffect3:SetActive(true)
        self.nowShowEffect3.transform:SetParent(self.effectTempRoot.transform)
        self.nowShowEffect3.transform.localPosition = Vector3.zero
    end
end

--设置特效位置
function ShowCharacterPanel:setEffectPosition()
    local roleConfig = self.roleConfig
    if UICommonUtils.Checkobj(self.nowShowEffect1) then
        self.nowShowEffect1.transform:SetParent(self.effectRoot.transform)
        if roleConfig.rank == GE.HeroRankStar.R then
            self.nowShowEffect1.transform.localPosition = Vector3.zero
        elseif roleConfig.rank == GE.HeroRankStar.SR then
            self.nowShowEffect1.transform.localPosition = Vector3.New(-175, 0, 0)
        elseif roleConfig.rank == GE.HeroRankStar.SSR then
            self.nowShowEffect1.transform.localPosition = Vector3.New(-175, 0, 0)
        end
    end
    if UICommonUtils.Checkobj(self.nowShowEffect2) then
        self.nowShowEffect2.transform:SetParent(self.effectRoot.transform)
        if roleConfig.rank == GE.HeroRankStar.SSR then
            self.nowShowEffect2.transform.localPosition = Vector3.New(-650, -104, 0)
        else
            self.nowShowEffect2.transform.localPosition = Vector3.zero
        end
    end
    if UICommonUtils.Checkobj(self.nowShowEffect3) then
        self.nowShowEffect3.transform:SetParent(self.effectRoot.transform)
        self.nowShowEffect3.transform.localPosition = Vector3.zero
    end
end

--设置相机的后处理
function ShowCharacterPanel:SetUIVolume()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--关闭方法
function ShowCharacterPanel:doCloseFunc()
    local isSingle = RaffleMgr:getIsSingle()
    if isSingle then
        RaffleMgr:backToMainScene(function()
            UIMgr:closeSpecificUI(self)
        end)
        return
    end
    RaffleMgr:stopCurrentRoleVoice()

    if not RaffleMgr.isSimpleShow then
        RaffleMgr:setSceneCameraEnabled(true)
        UIMgr:closeSpecificUI(self)
    end
    if self.closeFunc then
        self.closeFunc()
    end
end

function ShowCharacterPanel:OnClose(initiative)
    if self.newtimer then
        DLuaTimer:RemoveTimer(self.newtimer)
        self.skipBtn.canvasGroup.alpha = 1
        self.skipBtn.canvasGroup.interactable = true
        self.rareTypeBg.canvasGroup.interactable = true
        self.newtimer = nil
        RaffleMgr:hideWriteMask()
    end
end

--function ShowCharacterPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ShowCharacterPanel:OnRefresh(data)
--
--end

--[[
/RareTypeBg onClick 
--]]
function ShowCharacterPanel:rareTypeBg_Button_onClick(rareTypeBg)
    if self.text_tweener then
        self.text_tweener:Complete(true)
        self.text_tweener = nil
        return
    end
    self.rareTypeBg.canvasGroup.interactable = false

    --外界直接打开则直接关闭本界面
    if self.passInResultData then
        if self.closeFunc then
            self.closeFunc()
        end
        UIMgr:closeSpecificUI(self)
        return
    end

    self:doCloseFunc()
end

--[[
/SkipBtn onClick 
--]]
function ShowCharacterPanel:skipBtn_ScaleButton_onClick(skipBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.skipBtn.canvasGroup.interactable = false

    --外界直接打开则直接关闭本界面
    if self.passInResultData then
        if self.closeFunc then
            self.closeFunc()
        end
        UIMgr:closeSpecificUI(self)
        return
    end

    local isSingle = RaffleMgr:getIsSingle()
    if isSingle then
        RaffleMgr:backToMainScene(function()
            UIMgr:closeSpecificUI(self)
        end)
        return
    end
    if not RaffleMgr.isSimpleShow then
        RaffleMgr:setSceneCameraEnabled(true)
        UIMgr:closeSpecificUI(self)
    end
    --UIMgr:closeSpecificUI(self)
    RaffleMgr:stopCurrentRoleVoice()
    RaffleMgr:skipRaffleAnimation(true)
end

return ShowCharacterPanel
