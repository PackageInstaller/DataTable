---@class CombatIntelligenctPanel_BattleDetails : CombatIntelligenctPanel_BattleDetails_Generate
---##################### 【CombatIntelligenctPanel_BattleDetails Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【CombatIntelligenctPanel_BattleDetails Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local CombatIntelligenctPanel_BattleDetails = require "CombatIntelligenctPanel_BattleDetails_Generate"

function CombatIntelligenctPanel_BattleDetails:InitLogic(data)

end

---@param ui CombatIntelligenctPanel
function CombatIntelligenctPanel_BattleDetails:SetParentUI(ui)
    self.parentUI = ui
    self.LoadSpriteAsync = function(self, path, callBack)
        self.parentUI:LoadSpriteAsync(path, callBack)
    end
    self.LoadGameObjectAsync = function(self, path, callBack)
        self.parentUI:LoadGameObjectAsync(path, callBack)
    end
end

function CombatIntelligenctPanel_BattleDetails:setLevelDetails(levelId)
    local levelConfig = Config.GetPveLevelInfo(levelId)
    if levelConfig == nil then
       return 
    end

    self.selectLevelId = levelConfig.id
    local iconPath = string.format(Config.SpritePath.LevelTypeIconPath, levelConfig.type)
    local cc = Config.GetIntelligenceById(levelId)
    if cc ~= nil then
        iconPath = string.format(Config.SpritePath.IntelligenceSignName, cc.sign)
    end

    self:LoadSpriteAsync(iconPath, function (s)
        self.typeIconImg.image.sprite = s
        self.typeIconImg.image:SetNativeSize()
        self.typeIconImg:SetActive(true)
    end)

    self.levelNameBg:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.MaterialLevelBanner, levelConfig.MaterialLevelBanner), self.levelNameBg.image)

    self.levelNameText.text.text = levelConfig.nameKey

    self.starList:SetActive(levelConfig.type == GE.LevelType.Battle)
    self.typeNameTxt:SetActive(false)
    self.levelNameEng:SetActive(true)
    self.levelCountTxt.text.text = levelConfig.title
    self.typeNameTxt.text.text = levelConfig.title
    self.recLevelText.text.text = tostring(levelConfig.recommendLevel)

    local monsterShow = tablex.size(levelConfig.monsterShow)
    self.enemyBtn:SetActive(monsterShow > 0)
    if levelConfig.type == GE.LevelType.Once then
        self.recLevelText.rectTransform.anchoredPosition = Vector2.New(65, self.recLevelText.rectTransform.anchoredPosition.y)
    else
        self.recLevelText.rectTransform.anchoredPosition = Vector2.New(48, self.recLevelText.rectTransform.anchoredPosition.y)
    end

    self.starBg:SetActive(false)
    self.msgBg:SetActive(tablex.size(levelConfig.achieve) ~= 0)
    local levelData = Me:getLevelDataByid(levelConfig.id)
    if levelData then
        local finishTask = levelData.achieveList
        self.nowProgressTxt.text.text = tostring(tablex.size(finishTask))
        self.allProgressTxt.text.text = "/"..tablex.size(levelConfig.achieve)
    else
        self.nowProgressTxt.text.text = "0"
        self.allProgressTxt.text.text = "/"..tablex.size(levelConfig.achieve)
    end
    self.closeDetailBtn:SetActive(true)

    self.winCondition.conditionTxt.text.text = levelConfig.victoryDesKey
    self.defCondition.conditionTxt.text.text = levelConfig.failDesKey
    self.conditionBox_1.conditionTxt.text.text = levelConfig.starDesKey1
    self.conditionBox_2.conditionTxt.text.text = levelConfig.starDesKey2

    if string.isNullOrEmpty(levelConfig.starDesKey1) and string.isNullOrEmpty(levelConfig.starDesKey1) then
        self.specialView:SetActive(false)
    else
        self.specialView:SetActive(true)
    end
    

    local rewardList = {}
    for i = 1, 3 do
        self.starList["star"..i]:SetActive(levelData and i <= levelData.star)
    end
    
    local fristClear = false
    --首通奖励 第一次且配置有第一次配置才会显示首通奖励
    if (levelData == nil or levelData.completeNum == 0) and levelConfig.firstDrop ~= nil and #levelConfig.firstDrop > 0 then
        fristClear = true
    end

    if fristClear then
        local fristDrop = clone(levelConfig.firstDrop)
        for _, reward in pairs(fristDrop) do
            reward.isFrist = true
            table.insert(rewardList, reward)
        end
    else
        for _, reward in pairs(levelConfig.nomalDropShow) do
            table.insert(rewardList, reward)
        end
    end

    self:FillTemplateContent(self.customBox, self.rewardList, tablex.size(rewardList), function (index, itemObj)
        local rewardData = rewardList[index]
        local customBox = itemObj.customBox
        local data = {
            isFrist = rewardData.isFrist
        }
        if rewardData[1] == GE.RewardType.ItemProp then
            local itemConfig = Config.GetItemInfo(rewardData[2])
            data.isFrist = rewardData.isFrist
        elseif rewardData[1] == GE.RewardType.Equipment then
            data.isFrist = rewardData.isFrist
            data.CanLock = false
        elseif rewardData[1] == GE.RewardType.Weapon then
            data.CanLock = false
        end
        -- if rewardData[3] ~= 0 then
        --     data.itemNum = rewardData[3]
        -- end
        customBox:setMono(self)
        customBox:SetUIData(rewardData, data)
    end)
    if levelConfig.type ~= GE.LevelType.Story then
        self.needStrenigthNum = levelConfig.enterCost[2] + levelConfig.victoryCost[2]

        local isEnough = Me:checkNormalTicket(self.needStrenigthNum)
        if isEnough then
            self.goStrengthText.text.text = "x"..self.needStrenigthNum
        else
            self.goStrengthText.text.text = "<color=#FF3131x>"..self.needStrenigthNum.."</color>"
        end
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..GE.ResourceType.Strength), self.strengthIcon.image)
    end
    self.autoBattle:SetActive(levelData and levelData.state == GE.LevelStateType.Finish and false)
    self.needStrengthBg:SetActive(levelConfig.type ~= GE.LevelType.Story)

    self.isHard:SetActive(levelConfig.typemain == GE.LevelTypeMain.Difficulty)
    self:RefreshLevelCount()

    self.gameObject:SetActive(true)
end

function CombatIntelligenctPanel_BattleDetails:RefreshLevelCount()
    local lastCount = self:GetPveLevelLastCount()
    self.lastCountInfo:SetActive(lastCount ~= -1)
    if lastCount == -1 then
        return
    end
    local str = lastCount
    if lastCount == 0 then
        str = "<color=red>" .. lastCount .. "</color>" 
    end
    self.lastCountText.text.text = string.format(LocalStrEnum.leveltips_001, str)
end

function CombatIntelligenctPanel_BattleDetails:GetPveLevelLastCount()
    if self.selectLevelId == nil then
        return -1
    end
    local levelConfig = Config.GetPveLevelInfo(self.selectLevelId)
    if levelConfig == nil then
        return -1
    end
    local showCount = levelConfig.cleanNum ~= -1
    self.lastCountInfo:SetActive(showCount)
    if showCount then
        local levelInfo = Me:getLevelDataByid(levelConfig.id)
        local curCount = (levelInfo and levelInfo.dailyBattleNum) or 0
        local addCount = Me:GetCycleCardPrivilegeAddCount(PrivilegeType["LevelMapCleanAddCount_" .. levelConfig.typemain])
        local lastCount = levelConfig.cleanNum + addCount - (curCount)
        lastCount = math.max(0, lastCount)
        return lastCount
    end
    return -1
end

function CombatIntelligenctPanel_BattleDetails:Close()
    --self.gameObject:SetActive(false)
    self.parentUI:OnCloseBattleDetailsView()
end

--function CombatIntelligenctPanel_BattleDetails:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/StarBg/MsgBg/MsgBtn onClick 
--]]
function CombatIntelligenctPanel_BattleDetails:msgBtn_ScaleButton_onClick(msgBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    UIMgr:popUICover("LevelMapMsgPanel", {id = ClientData:GetNowSelectChatperId(), levelId = self.selectLevelId, mode = 2})
end

--[[
/EnemyBtn onClick 
--]]
function CombatIntelligenctPanel_BattleDetails:enemyBtn_ScaleButton_onClick(enemyBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    UIMgr:popUICover("LevelMapMsgPanel", {id = ClientData:GetNowSelectChatperId(), levelId = self.selectLevelId, mode = 1})
end

--[[
/AutoBattle onClick 
--]]
function CombatIntelligenctPanel_BattleDetails:autoBattle_ScaleButton_onClick(autoBattle)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    local levelData = Me:getLevelDataByid(self.selectLevelId)

    local lastCount = self:GetPveLevelLastCount()
    if lastCount == 0 then
        UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_CleanNumNotEnough)
        return
    end

    if levelData and levelData.state == GE.LevelStateType.Finish then
        UIMgr:popUICover("BattleRepeatPanel",{levelId = self.selectLevelId})
    else
        UICommonUtils.PopToast("扫荡战斗未解锁，请三星通关关卡！")
    end
end

--[[
/GoBattle onClick 
--]]
function CombatIntelligenctPanel_BattleDetails:goBattle_ScaleButton_onClick(goBattle)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    Me:BattleEnterLevelReq(self.selectLevelId, function()
    
        Me:setNowSelectLevel(self.selectLevelId)
        --UIMgr:closeUI(self)
        --判断体力是否充足
        local isEnough = Me:checkNormalTicket(self.needStrenigthNum)
        if not isEnough then
            UIMgr:popUICover("BuyTicketPanel", {})
            return
        end

        local levelId =  self.selectLevelId
        local levelConfig = Config.GetPveLevelInfo(levelId)
        if levelConfig.cleanNum ~= -1 then
            local levelInfo = Me:getLevelDataByid(levelId)
            local curCount = (levelInfo and levelInfo.dailyBattleNum) or 0
            local lastCount = levelConfig.cleanNum - (curCount)
            if lastCount <= 0 then
                UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_CleanNumNotEnough)
                return
            end
        end

        --TODO: 这里记录上次的模式和章节id  来了看这里
        LoadingMgr:SetLoadingStart(function()
            StateMgr:ChangeToState(GameFlowState.BattleState)
        end, nil, nil, "CombatIntelligenctPanel_BattleDetails")

    end)

end

--[[
/closeDetailBtn onClick 
--]]
function CombatIntelligenctPanel_BattleDetails:closeDetailBtn_Button_onClick(closeDetailBtn)

    self:Close()

end

return CombatIntelligenctPanel_BattleDetails
