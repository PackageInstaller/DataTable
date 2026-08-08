---@class RaffleMainPanel : RaffleMainPanel_Generate
---##################### 【RaffleMainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RaffleMainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RaffleMainPanel = require "RaffleMainPanel_Generate"

function RaffleMainPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
	}
    self.nowSelectToggle = nil

    self.nowSelectIndex = 1

    self.nowShowSpineObj = nil

    self.nowShowBreakSpineObj = nil

    self.loadCount = 0

    self.nowPoolId = nil

    self.nowPoolCfg = nil

    self.fristOpenId = nil
end

function RaffleMainPanel:InitPanel()
    --导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.RaffleMainPanel)
    --接管返回方法
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        UIMgr:closeSpecificUI(self)
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(true)
        end
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)
    self.editorBtn:SetActive(GV.IsEditor)
    self:initBackgroundSize()
    self:initToggleBox()

    CoveManager.instance():SetHomelandShowOrHide(false)

    --RaffleMgr:initRecordData()
end

--function RaffleMainPanel:StartCreating(time)
--
--end

--function RaffleMainPanel:StartEnter(time)
--
--end

--function RaffleMainPanel:StartRemoving(time)
--
--end

--function RaffleMainPanel:StartExit(time)
--
--end

function RaffleMainPanel:OnOpen(data, initiative)
    if initiative then
        self.fristOpenId = data and data.poolId or nil
        self.isOpened = true
        self:InitPanel()
    else
        self:refreshRealTimeChangesInfo()
        self:refreshTopRes(self.nowPoolCfg)
        GuideMgr:StartGuideTrigger("RaffleMainPanel")
    end
end

---初始化卡池toggle
function RaffleMainPanel:initToggleBox()
    LuaLogger.ds(">>>>>raffleData<<<<<<", tablex.dump(Me.gachaData))
    local gachaPoolList = Config.GetAllConfig("GachaPoolTable")
    local needRaffleList = {}
    local nowTime = math.modf(Me:getLocalStamp())
    for _, value in pairs(gachaPoolList) do
        if nowTime < value.startTime or
        (nowTime > value.endTime and value.endTime ~= 0) then
            --时间以外剔除
        else
            table.insert(needRaffleList, value)
        end
    end

    table.sort(needRaffleList, function(a, b)
        return a.display > b.display
    end )

    self:FillTemplateContent(self.raffleToggleBox, self.toggleList, #needRaffleList, function(index, toggleBox)
        --初始化选中(适配跳转及引导)
        local selectedData = needRaffleList[index] --选中数据
        local userData = Me:getUserData()
        if not userData.GotGuideGachaAward then
            self.fristOpenId = 10001--引导打开普池
        end
        if self.fristOpenId and self.fristOpenId == selectedData.id then
            self.nowSelectIndex = index--有外部数据则打开对应卡池
        end
        if index == self.nowSelectIndex then
            self.nowSelectToggle = toggleBox
        end
        toggleBox.titleTypeTxt.text.text = selectedData.Name
        toggleBox.scaleButton.onClick:RemoveAllListeners()
        toggleBox.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if self.nowSelectIndex == index then
                return
            end
            self:selectToggleBox(index, toggleBox)
            self:refreshTopRes(selectedData)
            self:refreshRaffleInfo(selectedData)
        end)
        --卡池图标
        local iconPath = string.format(Config.SpritePath.RaffleToggleIcon, selectedData.PoolToggle)
        self:LoadSpriteAsync(iconPath, toggleBox.toggleIcon.image)
        if index == #needRaffleList then
            --初始化默认选中
            self:selectToggleBox(self.nowSelectIndex, self.nowSelectToggle)
            self:refreshTopRes(needRaffleList[self.nowSelectIndex])
            self:refreshRaffleInfo(needRaffleList[self.nowSelectIndex])
        end
    end)

    local one, ten = 1, 10
    self.raffleOneTxt.text.text = string.format(LocalStrEnum.Gacha_Recruit, one)
    self.raffleTenTxt.text.text = string.format(LocalStrEnum.Gacha_Recruit, ten)
    self.raffleOneBtn.needNumTxt.text.text = tostring(one)
    self.raffleTenBtn.needNumTxt.text.text = tostring(ten)
end

--选中卡池toggle格子逻辑
function RaffleMainPanel:selectToggleBox(index, toggleBox)
    self.nowSelectToggle.isSelect:SetActive(false)
    self.nowSelectToggle.notSelect:SetActive(true)
    self.nowSelectIndex = index
    self.nowSelectToggle = toggleBox
    self.nowSelectToggle.isSelect:SetActive(true)
    self.nowSelectToggle.notSelect:SetActive(false)
    --黑色遮罩效果
    self.blackCut.canvasGroup.alpha = 1
end

---根据卡池Cost字段动态刷新顶部资源
---@param data GachaPoolTable
function RaffleMainPanel:refreshTopRes(poolData)
    local targetRes = {}
    if next(poolData.Resources) then
        targetRes = poolData.Resources
    end
    --设置特殊资源列表
    self.customBackPanel.customBackPanel:OverrideSpecificRes(targetRes)
    local itemInfo = Config.GetItemInfo(poolData.cost)
    --资源icon
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemInfo.icon), function (s)
        self.raffleOneBtn.needItem.image.sprite = s
        self.raffleTenBtn.needItem.image.sprite = s
    end)
    local itemHaveNum = Me:getItemNumById(poolData.cost)
    if itemHaveNum >= tonumber(self.raffleOneBtn.needNumTxt.text.text) then
        self.raffleOneBtn.needNumTxt.text.color = Color.NewFromStr("FFFFFF")
        self.raffleOneBtn.xTxt.text.color = Color.NewFromStr("FFFFFF")
    else
        self.raffleOneBtn.needNumTxt.text.color = Color.NewFromStr("FF5B57")
        self.raffleOneBtn.xTxt.text.color = Color.NewFromStr("FF5B57")
    end
    if itemHaveNum >= tonumber(self.raffleTenBtn.needNumTxt.text.text) then
        self.raffleTenBtn.needNumTxt.text.color = Color.NewFromStr("FFFFFF")
        self.raffleTenBtn.xTxt.text.color = Color.NewFromStr("FFFFFF")
    else
        self.raffleTenBtn.needNumTxt.text.color = Color.NewFromStr("FF5B57")
        self.raffleTenBtn.xTxt.text.color = Color.NewFromStr("FF5B57")
    end
end

--刷新卡池详细信息
function RaffleMainPanel:refreshRaffleInfo(poolData)
    self.nowPoolId = poolData.id
    self.nowPoolCfg = poolData
    --根据卡池类型调用不同显示逻辑
    self.normalInfo:SetActive(poolData.poolType == GE.RaffleType.Normal)
    self.specialInfo:SetActive(poolData.poolType == GE.RaffleType.LimitUp)
    self.mixedInfo:SetActive(poolData.poolType == GE.RaffleType.Mixed)
    if poolData.poolType ~= GE.RaffleType.LimitUp then
        if self.rotateRoleTimer then
            DLuaTimer:RemoveTimer(self.rotateRoleTimer)
            self.rotateRoleTimer = nil
        end
    end
    if poolData.poolType == GE.RaffleType.Normal then -- 普通卡池
        self.loadCount = 1
        self:setNormalInfo(poolData)
    elseif poolData.poolType == GE.RaffleType.LimitUp then -- 限定卡池
        self.loadCount = 8
        self:setSpecialInfo(poolData)
    elseif poolData.poolType == GE.RaffleType.Mixed then -- 混合卡池
        self.loadCount = 4
        self:setMixedInfo(poolData)
    end
    self:refreshRealTimeChangesInfo()
end

--加载卡池背景图
function RaffleMainPanel:loadPoolBackground(poolData)
    local backGroundPath = string.format(Config.SpritePath.AVGScene, poolData.background, poolData.background)
    self:LoadSpriteAsync(backGroundPath, function(s)
        self.background.image.sprite = s
        self.background.transform.localScale = Vector3(1.05,1.05,1)
        self.background.image:SetNativeSize()
        self:checkLoadComplete()
    end)
end

--设置普通卡池信息
function RaffleMainPanel:setNormalInfo(poolData)
    --TODO 设置普通卡池信息
    --卡池背景图 1
    self:loadPoolBackground(poolData)
end

---设置限定卡池信息
function RaffleMainPanel:setSpecialInfo(poolData)
    local limitRoleId = poolData.limit and poolData.limit[1] or nil
    if limitRoleId then
        local roleConfig = Config.GetCharacterInfo(limitRoleId)
        self.specialInfo.nameTypeTxt.text.text = roleConfig.class
        self.specialInfo.nameTxt.text.text = roleConfig.name
        --舰种图标 1
        local roleTypeIcon = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
        self:LoadSpriteAsync(roleTypeIcon, function (s)
            self.specialInfo.roleTypeIcon.image.sprite = s
            self:checkLoadComplete()
        end)
        --角色稀有度标志 2
        local qualityIcon = string.format(Config.SpritePath.roleQualityIcon, roleConfig.rank)
        self:LoadSpriteAsync(qualityIcon, function (s)
            self.specialInfo.rareIcon.image.sprite = s
            self:checkLoadComplete()
        end)
        --角色头像 3
        local skinConfig = Config.GetCharacterSkinInfo(roleConfig.baseSkinID)
        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end
        local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
        self:LoadSpriteAsync(iconPath, function(s)
            self.specialInfo.sSRHeadIcon.image.sprite = s
            self:checkLoadComplete()
        end)

        --角色spine 4
        UICommonUtils:ShowRolePicOrSpine(self, self.specialInfo.showCharacter, skinConfig.id, function(spineObject)
            if UICommonUtils.Checkobj(self.nowShowSpineObj) then
                GameObject.Destroy(self.nowShowSpineObj)
            end
            local objSpine = spineObject:GetComponent("SkeletonGraphic")
            objSpine.PhysicsPositionInheritanceFactor = Vector2.zero
            self.nowShowSpineObj = spineObject
            self.specialInfo.showCharacter.rectTransform.anchoredPosition = Vector2(0, self.specialInfo.showCharacter.rectTransform.anchoredPosition.y)
            self.nowShowSpineObj:SetActive(false)
            self:checkLoadComplete()
        end)

        --角色突破spine 5
        local breakSkinConfig = Config.GetCharacterSkinInfo(roleConfig.breakSkinID)
        UICommonUtils:ShowRolePicOrSpine(self, self.specialInfo.showCharacterBreak, breakSkinConfig.id, function(spineObject)
            if UICommonUtils.Checkobj(self.nowShowBreakSpineObj) then
                GameObject.Destroy(self.nowShowBreakSpineObj)
            end
            local objSpine = spineObject:GetComponent("SkeletonGraphic")
            objSpine.PhysicsPositionInheritanceFactor = Vector2.zero
            self.nowShowBreakSpineObj = spineObject
            self.specialInfo.showCharacterBreak.rectTransform.anchoredPosition = Vector2(0, self.specialInfo.showCharacterBreak.rectTransform.anchoredPosition.y)
            self.nowShowBreakSpineObj:SetActive(false)
            self:checkLoadComplete()
        end)
    end

    --卡池图标 6
    local iconPath = string.format(Config.SpritePath.RafflePoolName, poolData.PoolName)
    self:LoadSpriteAsync(iconPath, function(s)
        self.specialInfo.nameIcon.image.sprite = s
        self:checkLoadComplete()
    end)

    --时间底图 7
    local iconPath = string.format(Config.SpritePath.RaffleTimeBg, poolData.PoolTimeBg)
    self:LoadSpriteAsync(iconPath, function(s)
        self.specialInfo.timeBg.image.sprite = s
        self:checkLoadComplete()
    end)

    --人物名称底图
    -- local iconPath = string.format(Config.SpritePath.RaffleRoleInfoBg, poolData.id)
    -- self:LoadSpriteAsync(iconPath, function(s)
    --     if s then
    --         self.specialInfo.roleInfoBg.image.sprite = s
    --     end
    --     self:checkLoadComplete()
    -- end)

    --卡池背景图 8
    self:loadPoolBackground(poolData)
end

--设置混合卡池信息
function RaffleMainPanel:setMixedInfo(poolData)
    --描述
    self.mixedInfo.mixedUpTxt1.text.text = poolData.PoolNameDes1
    self.mixedInfo.mixedUpTxt2.text.text = poolData.PoolNameDes2

    --卡池图标 1
    local iconPath = string.format(Config.SpritePath.RafflePoolName, poolData.PoolName)
    self:LoadSpriteAsync(iconPath, function(s)
        self.mixedInfo.rafflePoolTitle.image.sprite = s
        self:checkLoadComplete()
    end)
    
    --卡池人物图标 2
    local iconPath = string.format(Config.SpritePath.RafflePoolChar, poolData.characterBg)
    self:LoadSpriteAsync(iconPath, function(s)
        self.mixedInfo.showImage.image.sprite = s
        self:checkLoadComplete()
    end)

    --时间底图 3
    local iconPath = string.format(Config.SpritePath.RaffleTimeBg, poolData.PoolTimeBg)
    self:LoadSpriteAsync(iconPath, function(s)
        self.mixedInfo.timeLimitBg.image.sprite = s
        self:checkLoadComplete()
    end)
    
    --卡池背景图 4
    self:loadPoolBackground(poolData)
end

--刷新卡池详细信息
function RaffleMainPanel:refreshRealTimeChangesInfo()
    local poolData = self.nowPoolCfg
    local nowCount, totalCount = 0, 0
    if poolData.poolType == GE.RaffleType.Normal then -- 普通卡池
        --保底进度
        local poolId = poolData.id
        local guarantId = poolData.countShow
        local guarantConfig = Config.GetGachaGuarantInfo(guarantId)
        local countGroupId = guarantConfig.countGroupID
        local guarantCfgList = Config.GetGachaGuarantInfoByPoolIdGroupId(poolId, countGroupId)
        local countData = Me:getGachaCountDataById(countGroupId)
        local guarantCount = Me:getGachaGuarantCountById(poolId, countGroupId)
        for _, guarantCfg in ipairs(guarantCfgList or {}) do
            if guarantCfg.num ~= 0 and guarantCount < guarantCfg.num then
                totalCount = guarantCfg.commonGuarant
                break
            elseif guarantCfg.num == 0 then
                totalCount = guarantCfg.commonGuarant
            end
        end
        nowCount = countData and countData.num or 0
    elseif poolData.poolType == GE.RaffleType.LimitUp then -- 限定卡池
        --限定角色是否获得
        local poolId = poolData.id
        local countGroupId = poolData.countGroup[1]
        local guarantCount = Me:getGachaGuarantCountById(poolId, countGroupId)
        local isGetLimitRole = guarantCount >= 1
        self.specialInfo.isGetSSR:SetActive(isGetLimitRole)
        self.specialInfo.notGetSSR:SetActive(not isGetLimitRole)

        --保底进度
        local guarantId = poolData.countShow
        local guarantConfig = Config.GetGachaGuarantInfo(guarantId)
        local countGroupId = guarantConfig.countGroupID
        local countData = Me:getGachaCountDataById(countGroupId)
        nowCount = countData and countData.num or 0
        totalCount = guarantConfig and guarantConfig.commonGuarant or 0

        --卡池剩余时间
        self.specialInfo.timeTxt.text.text = LocalStrEnum.Gacha_RemainingTime .. self:calculatePoolEndTime(poolData)
    elseif poolData.poolType == GE.RaffleType.Mixed then -- 混合卡池
        --保底进度
        local guarantId = poolData.countShow
        local guarantConfig = Config.GetGachaGuarantInfo(guarantId)
        local countGroupId = guarantConfig.countGroupID
        local countData = Me:getGachaCountDataById(countGroupId)
        nowCount = countData and countData.num or 0
        totalCount = guarantConfig and guarantConfig.commonGuarant or 0

        --卡池剩余时间
        self.mixedInfo.timeLimitTxt.text.text = LocalStrEnum.Gacha_RemainingTime .. self:calculatePoolEndTime(poolData)
    end

    --保底数据
    self.tipsTitleFront.text.text = string.format(LocalStrEnum.Gacha_GuaranteedDesc_1, totalCount)
    self.tipsTitleAfter.text.text = LocalStrEnum.Gacha_GuaranteedDesc_2
    self.guarantNumTxt.text.text = string.format("<color=#3DADF2>%s</color><color=#8C8C8C>/%s</color>", nowCount, totalCount)
end

--计算卡池结束时间
function RaffleMainPanel:calculatePoolEndTime(poolData)
    local timeDiffDay = DLuaUtil.GetDayDiff(poolData.endTime, Me.servertime)
    if timeDiffDay == 0 then
        local timeDiff = DLuaUtil.GetTimeDiff(poolData.endTime, Me.servertime)
        return string.format(LocalStrEnum.timehour, timeDiff.hour)
    else
        return string.format(LocalStrEnum.timeday, timeDiffDay)
    end
end

--异步加载计数判断是否加载完成
function RaffleMainPanel:checkLoadComplete()
    self.loadCount = self.loadCount - 1
    if self.loadCount <= 0 then
        --加载完成，播放动画
        self.baseMask.canvasGroup.alpha = 1
        if self.nowPoolCfg.poolType == GE.RaffleType.LimitUp then
            --人物spine动画
            if self.isOpened then
                local defaultTime = 0.5
                local breakRoot = self.specialInfo.showCharacterBreak.spineRoot
                breakRoot.rectTransform.anchoredPosition = Vector2(0, -1400)
                breakRoot.rectTransform.localScale = Vector3(2, 2, 2)
                breakRoot.rectTransform:DOAnchorPos(Vector2.zero, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
                breakRoot.transform:DOScale(Vector3.one, defaultTime):SetEase(DG.Tweening.Ease.InCubic):OnComplete(function()
                    self:rotateShowSpine()
                end)
            else
                self:rotateShowSpine()
            end
            self.nowShowBreakSpineObj:SetActive(true)
            self:showSpecialInfoAnimation()
        elseif self.nowPoolCfg.poolType == GE.RaffleType.Mixed then
            self:showMixedInfoAnimation()
        end
        local defaultTime = 0.5
        --背景图片动画
        self.background.transform:DOScale(Vector3.one, defaultTime)
        --卡池保底信息显示
        local guarantTipsRoot = self.guarantTipsBg
        guarantTipsRoot.canvasGroup.alpha = 0
        guarantTipsRoot.canvasGroup:DOFade(1, defaultTime):SetEase(DG.Tweening.Ease.OutCubic)
        --界面动画
        self:playInitAnimation()
        --引导
        GuideMgr:StartGuideTrigger("RaffleMainPanel")
        --关闭遮罩效果动画
        self.blackCut.canvasGroup:DOFade(0, 0.2):SetEase(DG.Tweening.Ease.InCubic)
    end
end

--轮换显示up角色spine
function RaffleMainPanel:rotateShowSpine()
    if self.rotateRoleTimer then
        DLuaTimer:RemoveTimer(self.rotateRoleTimer)
        self.rotateRoleTimer = nil
    end
    local defaultTime = 1
    local rootTransform =  UIMgr:GetUICanvasRoot():GetComponent("RectTransform")
    local screen_width = rootTransform.rect.width
    self.rotateRoleTimer = DLuaTimer:DoRepeatForever( 10, function()
        local normalRoot = self.specialInfo.showCharacter
        local breakRoot = self.specialInfo.showCharacterBreak
        if breakRoot.canvasGroup.alpha == 0 then
            --显示突破spine
            breakRoot.rectTransform.anchoredPosition = Vector2(screen_width, breakRoot.rectTransform.anchoredPosition.y)
            breakRoot.rectTransform:DOAnchorPosX(0, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
            normalRoot.rectTransform:DOAnchorPosX(-screen_width, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
            breakRoot.canvasGroup:DOFade(1, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
            normalRoot.canvasGroup:DOFade(0, defaultTime-0.2):SetEase(DG.Tweening.Ease.InCubic)
        else
            --显示普通spine
            if not self.nowShowSpineObj.activeSelf then
                self.nowShowSpineObj:SetActive(true)
            end
            normalRoot.rectTransform.anchoredPosition = Vector2(screen_width, normalRoot.rectTransform.anchoredPosition.y)
            normalRoot.rectTransform:DOAnchorPosX(0, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
            breakRoot.rectTransform:DOAnchorPosX(-screen_width, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
            normalRoot.canvasGroup:DOFade(1, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
            breakRoot.canvasGroup:DOFade(0, defaultTime-0.2):SetEase(DG.Tweening.Ease.InCubic)
            --表情切换
            self:showCharacterEmote()
        end
    end)
end

--up池信息显示动画
function RaffleMainPanel:showSpecialInfoAnimation()
    local defaultTime = 0.5
    local moveY = 50
    --卡池名称
    local nameRoot = self.specialInfo.nameIcon
    nameRoot.canvasGroup.alpha = 0
    nameRoot.rectTransform.anchoredPosition = Vector2(nameRoot.rectTransform.anchoredPosition.x, nameRoot.rectTransform.anchoredPosition.y - moveY)
    nameRoot.rectTransform:DOAnchorPosY(nameRoot.rectTransform.anchoredPosition.y + moveY, defaultTime):SetEase(DG.Tweening.Ease.OutCubic)
    nameRoot.canvasGroup:DOFade(1, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
    --角色信息
    local roleInfoRoot = self.specialInfo.roleInfoBg
    roleInfoRoot.canvasGroup.alpha = 0
    roleInfoRoot.rectTransform.anchoredPosition = Vector2(roleInfoRoot.rectTransform.anchoredPosition.x, roleInfoRoot.rectTransform.anchoredPosition.y - moveY)
    roleInfoRoot.rectTransform:DOAnchorPosY(roleInfoRoot.rectTransform.anchoredPosition.y + moveY, defaultTime):SetEase(DG.Tweening.Ease.OutCubic)
    roleInfoRoot.canvasGroup:DOFade(1, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
    --角色获得情况
    local getInfoRoot = self.specialInfo.sSRGetTipsBg
    getInfoRoot.canvasGroup.alpha = 0
    getInfoRoot.canvasGroup:DOFade(1, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
end

--混合池信息显示动画
function RaffleMainPanel:showMixedInfoAnimation()
    local defaultTime, defaultTime2, defaultTime3 = 0.5, 0.3, 0.7
    local moveX, moveY = 400, 50
    --卡池名称
    local nameRoot = self.mixedInfo.rafflePoolTitle
    nameRoot.canvasGroup.alpha = 0
    nameRoot.rectTransform.anchoredPosition = Vector2(nameRoot.rectTransform.anchoredPosition.x, nameRoot.rectTransform.anchoredPosition.y - moveY)
    nameRoot.rectTransform:DOAnchorPosY(nameRoot.rectTransform.anchoredPosition.y + moveY, defaultTime):SetEase(DG.Tweening.Ease.OutCubic)
    nameRoot.canvasGroup:DOFade(1, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
    --up信息
    local upInfoRoot = self.mixedInfo.upTextGroup
    upInfoRoot.canvasGroup.alpha = 0
    upInfoRoot.rectTransform.anchoredPosition = Vector2(upInfoRoot.rectTransform.anchoredPosition.x, upInfoRoot.rectTransform.anchoredPosition.y - moveY)
    upInfoRoot.rectTransform:DOAnchorPosY(upInfoRoot.rectTransform.anchoredPosition.y + moveY, defaultTime):SetEase(DG.Tweening.Ease.OutCubic)
    upInfoRoot.canvasGroup:DOFade(1, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
    --英文背景
    local engInfoRoot = self.mixedInfo.engTitleIcon
    engInfoRoot.canvasGroup.alpha = 0
    engInfoRoot.rectTransform.anchoredPosition = Vector2(engInfoRoot.rectTransform.anchoredPosition.x + moveX, engInfoRoot.rectTransform.anchoredPosition.y)
    engInfoRoot.rectTransform:DOAnchorPosX(engInfoRoot.rectTransform.anchoredPosition.x - moveX, defaultTime3)
    engInfoRoot.canvasGroup:DOFade(1, defaultTime3):SetEase(DG.Tweening.Ease.InCubic)
    --人物图标
    local showImageRoot = self.mixedInfo.showImage
    showImageRoot.canvasGroup.alpha = 0
    showImageRoot.rectTransform.anchoredPosition = Vector2(showImageRoot.rectTransform.anchoredPosition.x - moveX, showImageRoot.rectTransform.anchoredPosition.y)
    showImageRoot.rectTransform:DOAnchorPosX(showImageRoot.rectTransform.anchoredPosition.x + moveX, defaultTime2):SetEase(DG.Tweening.Ease.OutCubic)
    showImageRoot.canvasGroup:DOFade(1, defaultTime2):SetEase(DG.Tweening.Ease.InCubic)
end

--显示角色表情
function RaffleMainPanel:showCharacterEmote()
    if not UICommonUtils.Checkobj(self.nowShowSpineObj) then
        return
    end
    local spineAnim = self.nowShowSpineObj:GetComponent("SkeletonAnimation")
    if not UICommonUtils.Checkobj(spineAnim) then
        return
    end

    local emoteName = "idle"
    local emoteList = {shy = 5,laugh = 10}
    local randomIndex = math.random(1, 100)
    if randomIndex <= emoteList.shy then
        emoteName = "shy"
    elseif randomIndex <= emoteList.laugh then
        emoteName = "laugh"
    end

    spineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, emoteName, true)
end

--初始化背景适配
function RaffleMainPanel:initBackgroundSize()
    local rootTransform =  UIMgr:GetUICanvasRoot():GetComponent("RectTransform")
    local screen_width = rootTransform.rect.width
    local screen_height = rootTransform.rect.height
    local kv_width = 2160
    local kv_height = 1080
    local scale_width = screen_width / kv_width
    local scale_height = screen_height / kv_height
    local scale = math.max(scale_width, scale_height)
    self.backgrondRoot.rectTransform.localScale = Vector3.New(scale, scale, 1)
end

--界面入场动画
function RaffleMainPanel:playInitAnimation()
    if self.isOpened == true then
        self.animator:SetTrigger("Init")
        self.isOpened = false
    end
end

function RaffleMainPanel:OnClose(initiative)

end

function RaffleMainPanel:OnDestroy()
	self.super:OnDestroy(self)
    if self.rotateRoleTimer then
        DLuaTimer:RemoveTimer(self.rotateRoleTimer)
        self.rotateRoleTimer = nil
    end
end

--function RaffleMainPanel:OnRefresh(data)
--
--end

--引导单抽逻辑
function RaffleMainPanel:guideRaffleOneFunc()
    local resultFunc = function (data)
        LoadingMgr:SetUIQuickSwitchStart(function()
            RaffleMgr:setRaffleResultList(data.rewardList)
            RaffleMgr:jumpToRaffleScene()
        end)
    end
    --寄存Toast
    UIMgr:startDepositToast(GE.DepositToastType.RaffleOne)
    Me:guideRaffleReq(function(data)
        resultFunc(data)
    end)
end

--单抽逻辑
function RaffleMainPanel:raffleOneFunc()
    local resultFunc = function (data)
        LoadingMgr:SetUIQuickSwitchStart(function()
            RaffleMgr:setRaffleResultList(data.rewardList)
            RaffleMgr:jumpToRaffleScene()
        end)
    end
    --寄存Toast
    UIMgr:startDepositToast(GE.DepositToastType.RaffleOne)
    Me:startRaffleReq({raffleId = self.nowPoolId, count = self.doRaffleCount}, function(data)
        resultFunc(data)
    end)

end

--十连抽逻辑
function RaffleMainPanel:raffleTenFunc()
    --寄存Toast
    UIMgr:startDepositToast(GE.DepositToastType.RaffleTen)
    Me:startRaffleReq({raffleId = self.nowPoolId, count = self.doRaffleCount}, function(data)
        LoadingMgr:SetUIQuickSwitchStart(function()
            RaffleMgr:setNowPoolId(self.nowPoolId)
            RaffleMgr:setRaffleResultList(data.rewardList)
            RaffleMgr:jumpToRaffleScene()
        end)
    end)
end

--抽卡卷数量不足时补齐
function RaffleMainPanel:fillRaffleItemNeed(callBack)
    local costCount = self.doRaffleCount
    RaffleMgr:fillRaffleTicketLack(self.nowPoolId, costCount, callBack)
end

--[[
/CustomBackPanel/BackMainlBtn onClick 
--]]
function RaffleMainPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)

end

--[[
/CustomBackPanel/HelpBtn onClick 
--]]
function RaffleMainPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/RaffleInfo/InfoDetailsBtn onClick 
--]]
function RaffleMainPanel:infoDetailsBtn_ScaleButton_onClick(infoDetailsBtn)
    --UIMgr:popUICover("InstructionsPanel", {tabId = 2301, closeFunc = nil})
    UIMgr:popUICover("RaffleMsgPanel", {poolId = self.nowPoolId})
end

--[[
/RaffleInfo/RaffleOneBtn onClick 
--]]
function RaffleMainPanel:raffleOneBtn_ScaleButton_onClick(raffleOneBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --判断是否获取过首次引导奖励
    local userData = Me:getUserData()
    if not userData.GotGuideGachaAward then
        self:guideRaffleOneFunc()
        return
    end
    self.doRaffleCount = 1
    self:fillRaffleItemNeed(function()
        self:raffleOneFunc()
    end)
end

--[[
/RaffleInfo/RaffleTenBtn onClick 
--]]
function RaffleMainPanel:raffleTenBtn_ScaleButton_onClick(raffleTenBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.doRaffleCount = 10
    self:fillRaffleItemNeed(function()
        self:raffleTenFunc()
    end)
end

--[[
/RaffleInfo/HistoryBtn onClick 
--]]
function RaffleMainPanel:historyBtn_ScaleButton_onClick(historyBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUICover("RaffleRecordPanel")
end

--[[
/EditorBtn onClick 
--]]
function RaffleMainPanel:editorBtn_ScaleButton_onClick(editorBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUICover("RaffleEditorPanel",{gachaPoolId = self.nowPoolId})
end

--[[
/SpecialInfo/RoleInfoBg/NameTxt/RoleInfoBtn onClick 
--]]
function RaffleMainPanel:roleInfoBtn_ScaleButton_onClick(roleInfoBtn)
    LoadingMgr:SetUISwitchStart(function()
        UIMgr:popUI("DockRolePanel", {uiMode = 3, characterId = self.nowPoolCfg.limit[1]})
    end)
end

return RaffleMainPanel
