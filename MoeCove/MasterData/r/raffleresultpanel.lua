---@class RaffleResultPanel : RaffleResultPanel_Generate
---##################### 【RaffleResultPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RaffleResultPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RaffleResultPanel = require "RaffleResultPanel_Generate"

function RaffleResultPanel:InitLogic(data)
    self.resultNum = 10 --抽卡结果数量

    self.loadCount = self.resultNum * 7

    self.resultBoxList = {}

    self.boxEffectList = {}

    self.boxTimer = {}
    self.showBtnTimer = nil
end

--function RaffleResultPanel:StartCreating(time)
--
--end

--function RaffleResultPanel:StartEnter(time)
--
--end

--function RaffleResultPanel:StartRemoving(time)
--
--end

--function RaffleResultPanel:StartExit(time)
--
--end

function RaffleResultPanel:OnOpen(data, initiative)
    local btnSoundPath = string.format(Config.AudioPath.SE, "gacha_settlement")
    self:play2DSound(btnSoundPath)
    self:setRaffleResultData()
    self:SetUIVolume()
    UIMgr:endDepositToast(GE.DepositToastType.RaffleTen)
    RaffleMgr:setSceneCameraEnabled(false)
    self:setTextBatcher()
    RaffleMgr:destroyShowRole()
end

function RaffleResultPanel:setRaffleResultData()
    self.resultDataList = clone(RaffleMgr:getRaffleResultList())
    for index, resultData in ipairs(self.resultDataList) do
        resultData.resultIndex = index
        --根据稀有度赋值
        if resultData.isSSR then
            resultData.rarity = GE.HeroRankStar.SSR
        elseif resultData.isSR then
            resultData.rarity = GE.HeroRankStar.SR
        else
            resultData.rarity = GE.HeroRankStar.R
        end
    end
    --排序
    self.resultBoxList = {}
    local needDataList = self.resultDataList--self:sortByRarity(self.resultDataList)
    self:FillTemplateContent(self.resultBox, self.creatBoxRoot, self.resultNum, function(index, resultBox)
        resultBox.transform:SetParent(self["resultRoot"..index].transform)
        resultBox.transform.localPosition = Vector3.zero
        resultBox.transform.localScale = Vector3.one
        local resultData = needDataList[index]
        local roleConfig = Config.GetCharacterInfo(resultData.id)
        if not roleConfig then
            return
        end
        --角色品质框 1
        local raffleQualityBg = string.format(Config.SpritePath.RaffleBoxBg, roleConfig.rank)
        self:LoadSpriteAsync(raffleQualityBg, function (s)
            resultBox.image.sprite = s
            self:checkLoadComplete()
        end)
        --角色半身立绘 2
        local roleBreakBg = string.format(Config.SpritePath.CutRolePath, roleConfig.id, "CutRole_"..roleConfig.id)
        self:LoadSpriteAsync(roleBreakBg, function (s)
            resultBox.roleIcon.image.sprite = s
            self:checkLoadComplete()
        end)
        --角色品质框遮罩 3
        local raffleQualityMask = string.format(Config.SpritePath.RaffleBoxMask, roleConfig.rank)
        self:LoadSpriteAsync(raffleQualityMask, function (s)
            resultBox.rareMaskIcon.image.sprite = s
            self:checkLoadComplete()
        end)
        --抽卡序号 4
        local raffleIndex = string.format(Config.SpritePath.RaffleBoxIndex, resultData.resultIndex)
        self:LoadSpriteAsync(raffleIndex, function (s)
            resultBox.indexNum.image.sprite = s
            local offset = self:calculateIndexOffset(index)
            local numPos = resultBox.indexNum.rectTransform.anchoredPosition
            resultBox.indexNum.rectTransform.anchoredPosition = Vector2.New(0, numPos.y + offset)
            self:checkLoadComplete()
        end)
        --角色阵营图标 5
        local nationPath = string.format(Config.SpritePath.CharacterNationPath, roleConfig.nation)
        self:LoadSpriteAsync(nationPath, function (s)
            resultBox.nationIcon.image.sprite = s
            self:checkLoadComplete()
        end)
        --角色舰种 6
        local roleTypeIcon = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
        self:LoadSpriteAsync(roleTypeIcon, function (s)
            resultBox.typeIcon.image.sprite = s
            self:checkLoadComplete()
        end)
        --角色碎片图标 7
        local itemConfig = Config.GetItemInfo(roleConfig.getPatch[1][2])
        local fragmentIcon = string.format(Config.SpritePath.ItemIconPath, itemConfig.icon)
        self:LoadSpriteAsync(fragmentIcon, function (s)
            resultBox.itemIcon.image.sprite = s
            self:checkLoadComplete()
        end)
        resultBox.itemCountTxt.text.text = "x"..roleConfig.getPatch[1][3]

        --是否为新角色
        local isNewRole = not resultData.extraType and true or false
        resultBox.isNew:SetActive(isNewRole)
        resultBox.isGot:SetActive(not isNewRole)
        resultBox.itemCountTxt:SetActive(false)
        table.insert(self.resultBoxList, resultBox)
        resultBox.rectTransform.anchoredPosition = Vector2.New(0, 200)

        --初始化特效
        self:initBoxEffect(index, resultBox, roleConfig)

        --初始化界面Canvas,配合特效显示
        resultBox.canvasRoot.canvas.sortingLayerName = "UI"
    end)

    --加载对应消耗道具
    local poolId = RaffleMgr:getNowPoolId()
    local poolConfig = Config.GetGachaPoolInfo(poolId)
    local needResBoxCount = #poolConfig.ResourcesShow + 1
    self:FillTemplateContent(self.resBox, self.resBoxList, needResBoxCount, function(index, resBox)
        local resId =  poolConfig.ResourcesShow[index]
        if resId then
            local resConfig = Config.GetItemInfo(resId)
            local resIcon = string.format(Config.SpritePath.ItemIconPath, resConfig.icon)
            self:LoadSpriteAsync(resIcon, resBox.resIcon.image)
            local itemNum = Me:getItemNumById(resId)
            resBox.resNumTxt.text.text = itemNum
        else
            local itemInfo = Config.GetItemInfo(poolConfig.cost)
            local itemNum = Me:getItemNumById(poolConfig.cost)
            self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemInfo.icon), function (s)
                self.needIcon.image.sprite = s
                resBox.resIcon.image.sprite = s
            end)
            resBox.resNumTxt.text.text = itemNum
        end
    end)
    --self.oKBtn.canvas.sortingLayerName = "UI"
    --self.againBtn.canvas.sortingLayerName = "UI"
    --self.againTips.canvas.sortingLayerName = "UI"
end

--初始化稀有度特效
function RaffleResultPanel:initBoxEffect(index, resultBox, roleConfig)
    self.boxEffectList[index] = {}
    if roleConfig.rank == GE.HeroRankStar.R then
        self.boxEffectList[index].show = resultBox.effect_Ui_ChouKa_R_2
        --self.boxEffectList[index].show:SetActive(true)
        self.boxEffectList[index].loop = resultBox.effect_Ui_ChouKa_R_2_Loop
        --self.boxEffectList[index].loop:SetActive(true)
    elseif roleConfig.rank == GE.HeroRankStar.SR then
        self.boxEffectList[index].show = resultBox.effect_Ui_ChouKa_SR_2
        --self.boxEffectList[index].show:SetActive(true)
        self.boxEffectList[index].loop = resultBox.effect_Ui_ChouKa_SR_2_Loop
        --self.boxEffectList[index].loop:SetActive(true)
    elseif roleConfig.rank == GE.HeroRankStar.SSR then
        self.boxEffectList[index].show = resultBox.effect_Ui_ChouKa_SSR_6
        --self.boxEffectList[index].show:SetActive(true)
        self.boxEffectList[index].loop = resultBox.effect_Ui_ChouKa_SSR_6_Loop
        --self.boxEffectList[index].loop:SetActive(true)
    end
    --self.boxEffectList[index].show.transform:SetParent(self.effectTempRoot.transform)
    self.boxEffectList[index].show.transform.localPosition = Vector3.zero
    --self.boxEffectList[index].loop.transform:SetParent(self.effectTempRoot.transform)
    self.boxEffectList[index].loop.transform.localPosition = Vector3.zero
end

function RaffleResultPanel:getGroup(index)
    local total = self.resultNum
    return math.min(index, total - index + 1)
end

--计算序号位置偏移值
function RaffleResultPanel:calculateIndexOffset(index)
    -- 计算组号，组号范围1~5
    local group = self:getGroup(index)
    if group == 1 then
        return 0
    end
    local offset = (group * group) + 5
    -- 返回值：组号越大，值越大
    return offset
end

--根据稀有度排序
function RaffleResultPanel:sortByRarity(resultDataList)
-- 先根据稀有度降序排序
    table.sort(resultDataList, function(a, b)
        if a.rarity == b.rarity then
            return a.resultIndex < b.resultIndex
        else
            return a.rarity > b.rarity
        end
    end)

    -- 物体编号对应组号
    local groups = {}
    for i = 1, self.resultNum do
        groups[i] = self:getGroup(i)
    end

    -- 物体编号按组号降序排序，组号相同按编号升序
    local indices = {}
    for i = 1, self.resultNum do
        table.insert(indices, i)
    end
    table.sort(indices, function(a, b)
        if groups[a] == groups[b] then
            return a < b
        else
            return groups[a] > groups[b]
        end
    end)

    -- 分配小物体给物体编号
    local result = {}
    for i, idx in ipairs(indices) do
        result[idx] = resultDataList[i]
    end

    -- 返回按物体编号顺序排列的结果
    local orderedResult = {}
    for i = 1, self.resultNum do
        orderedResult[i] = result[i]
    end

    return orderedResult
end

--异步加载计数判断是否加载完成
function RaffleResultPanel:checkLoadComplete()
    self.loadCount = self.loadCount - 1
    if self.loadCount <= 0 then
        --加载完成，播放动画
        RaffleMgr:hideWriteMask(function ()
            self:showCharacterAnim()
        end)
    end
end

function RaffleResultPanel:showCharacterAnim()

    local baseInterval = 0.2  -- 初始间隔，可以调整
    local totalDelay = 0      -- 累积延迟时间
    for i = 1, self.resultNum do
        local interval = baseInterval / i  -- 间隔递减
        if i <= 5 then
            totalDelay = totalDelay + interval
        else
            totalDelay = totalDelay + 0.05
        end
        self.boxEffectList[i].loop:SetActive(false)
        self.boxTimer[i] = DLuaTimer:DoAfter(totalDelay, function()

            --self.boxEffectList[i].show.transform:SetParent(self.resultBoxList[i].transform)
            self.boxEffectList[i].show:SetActive(true)
            self.boxEffectList[i].show.transform.localPosition = Vector3.zero
            local particleSys = self.boxEffectList[i].show.transform:Find("Effect"):GetComponent("ParticleSystem")
            particleSys:Simulate(0)
            particleSys:Play()
            self.boxEffectList[i].loop:SetActive(true)
            --self.boxEffectList[i].loop.transform:SetParent(self.resultBoxList[i].transform)
            self.boxEffectList[i].loop.transform.localPosition = Vector3.zero
            self.resultBoxList[i].rectTransform:DOAnchorPos(Vector2.zero, 0.2):SetEase(DG.Tweening.Ease.OutQuad)
            self.resultBoxList[i].itemCountTxt:SetActive(true)
            self["resultRoot"..i].canvasGroup:DOFade(1, 0.2):OnComplete(function()
                if self.resultBoxList[i].isGot.activeSelf then
                    self.resultBoxList[i].itemCountTxt.textBatcher:InitBatcher()
                end
                self.boxTimer[i] = nil
            end)
        end)

    end
    self.showBtnTimer = DLuaTimer:DoAfter(0.2, function()
        self.animator:SetTrigger("ShowResult")
        self.showBtnTimer = nil
    end)
    self.bgColorTimer = DLuaTimer:DoAfter(totalDelay, function()
        self.resultBg.image:DOColor(Color.New(1, 1, 1, 1), 0.2)
        self.bgColorTimer = nil
    end)

    self.btnsRt.canvas.sortingLayerName = "UI"
    self.textcanvas.canvas.sortingLayerName = "UI"
end

--设置相机的后处理
function RaffleResultPanel:SetUIVolume()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--节点Canvas开关
function RaffleResultPanel:canvasSwitch(isAuto)
    for index, resultBox in ipairs(self.resultBoxList) do
        resultBox.canvasRoot.canvas.overrideSorting = isAuto
        if UICommonUtils.Checkobj(self.boxEffectList[index].loop) then
            self.boxEffectList[index].loop:SetActive(isAuto)
        end
        if UICommonUtils.Checkobj(self.boxEffectList[index].show) then
            self.boxEffectList[index].show:SetActive(isAuto)
        end
    end
    --self.oKBtn.canvas.overrideSorting = isAuto
    --self.againBtn.canvas.overrideSorting = isAuto
    --self.againTips.canvas.overrideSorting = isAuto
    --self.btnsRt.canvas.overrideSorting = isAuto
    --self.textcanvas.canvas.overrideSorting = isAuto
end

--静态文字节点设置TextBatcher
function RaffleResultPanel:setTextBatcher()
    self.txtOK.text.text = LocalStrEnum.Gacha_Prompt_Confirm
    self.txtAgain.text.text = LocalStrEnum.Gacha_Prompt_OnceAgain
    self.againTipsTitle.text.text = LocalStrEnum.Gacha_Prompt_Consume
    self.txtOK.textBatcher:InitBatcher()
    self.txtAgain.textBatcher:InitBatcher()
    self.againTipsTitle.textBatcher:InitBatcher()
    self.needNumTxt.textBatcher:InitBatcher()
end

function RaffleResultPanel:OnClose(initiative)
    for _, timer in ipairs(self.boxTimer) do
        if timer then
            DLuaTimer:RemoveTimer(timer)
        end
    end

    if self.showBtnTimer then
        DLuaTimer:RemoveTimer(self.showBtnTimer)
    end
    if self.bgColorTimer then
        DLuaTimer:RemoveTimer(self.bgColorTimer)
    end
end

--function RaffleResultPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function RaffleResultPanel:OnRefresh(data)
--
--end

--[[
/ResultBg/OKBtn onClick 
--]]
function RaffleResultPanel:oKBtn_ScaleButton_onClick(oKBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.oKBtn.canvasGroup.blocksRaycasts = false
    self:canvasSwitch(false)
    RaffleMgr:backToMainScene(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--[[
/ResultBg/AgainBtn onClick 
--]]
function RaffleResultPanel:againBtn_ScaleButton_onClick(againBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local againCount = 10
    local poolId = RaffleMgr:getNowPoolId()
    RaffleMgr:fillRaffleTicketLack(poolId, againCount, function()
        self.againBtn.canvasGroup.blocksRaycasts = false
        Me:startRaffleReq({raffleId = poolId, count = againCount}, function(data)
            RaffleMgr:creatRaffleRoleRoot()
            RaffleMgr:setSceneCameraEnabled(true)
            UIMgr:closeSpecificUI(self)
            RaffleMgr:raffleAgain(data.rewardList)
        end)
    end)

end

return RaffleResultPanel
