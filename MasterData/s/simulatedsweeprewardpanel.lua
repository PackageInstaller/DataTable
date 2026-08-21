---@class SimulatedSweepRewardPanel : SimulatedSweepRewardPanel_Generate
---##################### 【SimulatedSweepRewardPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SimulatedSweepRewardPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SimulatedSweepRewardPanel = require "SimulatedSweepRewardPanel_Generate"

function SimulatedSweepRewardPanel:InitLogic(data)

end

--function SimulatedSweepRewardPanel:StartCreating(time)
--
--end

--function SimulatedSweepRewardPanel:StartEnter(time)
--
--end

--function SimulatedSweepRewardPanel:StartRemoving(time)
--
--end

--function SimulatedSweepRewardPanel:StartExit(time)
--
--end

function SimulatedSweepRewardPanel:OnOpen(data, initiative)
    self.rewardList = data and data.rewardList

    self:setAllRewardData()
end

function SimulatedSweepRewardPanel:setAllRewardData()
    --扫荡层数
    local activityData = Me:getSimulatedActivityData()
    local hisMaxFloor = activityData and activityData.maxFloor or 0
    local quickFloor = hisMaxFloor - Config.GetConfigInfo("PveExerciseStoreyPass")
    local nowFloor = quickFloor + 1
    self.levelNameText.text.text = string.format("第%s层", nowFloor)

    -- 玩家等级显示
    local userLevel = Me:getUserLevel()
    self.levelText.text.text = userLevel

    local allAddExp = 0
    local floorConfigMap = Config.GetAllConfig("PveExerciseStoreyTable")
    for _, floorConfig in pairs(floorConfigMap) do
        if floorConfig.storeyNum <= quickFloor then
            local floorData = activityData.simulatedLevelMap[floorConfig.id]
            if floorData and not next(floorData.levelList) then
                allAddExp = allAddExp + floorConfig.userExp
            end
        end
    end
    self.addExpText.text.text = "EXP+" .. allAddExp

    local levelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.user, userLevel)
    local nowExp = Me:getUserEXP() - levelData.exp_sum
    local oldExp = nowExp - allAddExp
    --等级已满特殊显示
    if levelData.max_level == Me:getUserLevel() and Me:getUserEXP() >= levelData.exp_sum then
        self.nowExpText.text.text = "已达上限"
        self.expSlider.slider.value = 0
    else
        self.nowExpText.text.text = nowExp.."/"..levelData.exp
        self.expSlider.slider.value = oldExp / levelData.exp
        self.expSlider.slider:DOValue(nowExp / levelData.exp, 1)
    end

    -- 总奖励显示
    local needBoxNum = tablex.size(self.rewardList)
    self:FillTemplateContent(self.customBox, self.allRewardList, needBoxNum, function(index, itemObj)
        local customBox = itemObj.customBox
        local rewardData = self.rewardList[index]
        --[[local data = {}
        data.id = rewardData.id
        if rewardData.type == GE.RewardType.ItemProp then
            data.isFrist = rewardData.isFrist
            data.itemType = GE.ItemTypeIndex.item
        elseif rewardData.type == GE.RewardType.Equipment then
            data.itemType = GE.ItemTypeIndex.equip
            data.id = Me:getEquipDataByid(rewardData.id).cid
        elseif rewardData.type == GE.RewardType.Weapon then
            data.itemType = GE.ItemTypeIndex.weapon
            data.id = Me:getWeaponDataById(rewardData.id).cid
        end
        if rewardData.num ~= 0 then
            data.itemNum = rewardData.num
        end]]
        customBox:setMono(self)
        customBox:SetUIData(rewardData)
    end)
end

--function SimulatedSweepRewardPanel:OnClose(initiative)
--
--end

--function SimulatedSweepRewardPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SimulatedSweepRewardPanel:OnRefresh(data)
--
--end

--[[
/OkBtn onClick 
--]]
function SimulatedSweepRewardPanel:okBtn_ScaleButton_onClick(okBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    UIMgr:closeSpecificUI(self)
end

return SimulatedSweepRewardPanel
