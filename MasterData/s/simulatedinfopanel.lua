---@class SimulatedInfoPanel : SimulatedInfoPanel_Generate
---##################### 【SimulatedInfoPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SimulatedInfoPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SimulatedInfoPanel = require "SimulatedInfoPanel_Generate"

function SimulatedInfoPanel:InitLogic(data)
    self.maxRewardCount = 8 --最大奖励数
end

--function SimulatedInfoPanel:StartCreating(time)
--
--end

--function SimulatedInfoPanel:StartEnter(time)
--
--end

--function SimulatedInfoPanel:StartRemoving(time)
--
--end

--function SimulatedInfoPanel:StartExit(time)
--
--end

function SimulatedInfoPanel:OnOpen(data, initiative)
    self.levelId = data.levelId
    self:setLevelInfo()
end

function SimulatedInfoPanel:setLevelInfo()
    local exeLevelConfig = Config.GetPveExerciseLevelInfo(self.levelId)
    if not exeLevelConfig then
        return
    end
    local levelConfig = Config.GetPveLevelInfo(exeLevelConfig.LevelId)
    if not levelConfig then
        return
    end
    self.selectLevelId = levelConfig.id
    self.levelNameTxt.text.text = levelConfig.nameKey
    self.levelDescTxt.text.text = levelConfig.desKey
    self.recommendLevelText.text.text = string.format("<size=26><color=#F4E177>%s</color></size> 级", levelConfig.recommendLevel)
    self.victoryTxt.text.text = levelConfig.victoryDesKey
    self.failureTxt.text.text = levelConfig.failDesKey

    local rewardList = {}
    local activityData = Me:getSimulatedActivityData()
    local isFrist = true
    for _, levelData in pairs(activityData.simulatedLevelMap or {}) do
        for _, levelId in pairs(levelData.levelList) do
            if levelId == self.levelId then
                isFrist = false
                break
            end
        end
    end
    if isFrist then
        local fristDrop = clone(levelConfig.firstDrop)
        for _, reward in pairs(fristDrop) do
            table.insert(rewardList, reward)
        end
    else
        for _, reward in pairs(levelConfig.nomalDropShow) do
            table.insert(rewardList, reward)
        end
    end

    self:FillTemplateContent(self.customBox, self.rewardBoxList, self.maxRewardCount, function (index, itemObj)
        local customBox = itemObj.customBox
        local rewardData = rewardList[index]
        local data = {}
        --[[if rewardData then
            data = {
                id = rewardData[2],
            }
            if rewardData[1] == GE.RewardType.ItemProp then
                data.itemType = GE.ItemTypeIndex.item
            elseif rewardData[1] == GE.RewardType.Equipment then
                data.itemType = GE.ItemTypeIndex.equip
            elseif rewardData[1] == GE.RewardType.Weapon then
                data.itemType = GE.ItemTypeIndex.weapon
            end
            if rewardData[3] ~= 0 then
                data.itemNum = rewardData[3]
            end
        else
            data = {
                nullReward = true,
            }
        end]]
        customBox:setMono(self)
        customBox:SetUIData(rewardData)
    end)

    local buffConfig = levelConfig.levelSkillDes
    local buffTypePath = string.format(Config.SpritePath.SimulatedLevelBuffBg, buffConfig.type)
    self:LoadSpriteAsync(buffTypePath, self.enemyInfoTitleBg.image)
    self.enemyInfoTitleTxt.text.text = LocalStrEnum["PveExerciseBuff_"..buffConfig.type]
    self.buffTxt.text.text = LocalStrEnum[buffConfig.key]

    self.needStrenigthNum = levelConfig.enterCost[2] + levelConfig.victoryCost[2]
    self.goStrengthText.text.text = "x"..self.needStrenigthNum
end

--界面关闭
function SimulatedInfoPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--function SimulatedInfoPanel:OnClose(initiative)
--
--end

--function SimulatedInfoPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SimulatedInfoPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function SimulatedInfoPanel:mask_Button_onClick(mask)
    self:playCloseAnim()
end

--[[
/PanelBg/ConfirmBtn onClick 
--]]
function SimulatedInfoPanel:confirmBtn_ScaleButton_onClick(confirmBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local isEnough = Me:checkNormalTicket(self.needStrenigthNum)
    if not isEnough then
        UIMgr:popUICover("BuyTicketPanel", {})
        return
    end
    UIMgr:closeSpecificUI(self)
    Me:setNowSelectLevel(self.selectLevelId)
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "SimulatedInfoPanel")
end

return SimulatedInfoPanel
