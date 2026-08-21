---@class SimulatedRewardPanel : SimulatedRewardPanel_Generate
---##################### 【SimulatedRewardPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SimulatedRewardPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SimulatedRewardPanel = require "SimulatedRewardPanel_Generate"

function SimulatedRewardPanel:InitLogic(data)

end

--function SimulatedRewardPanel:StartCreating(time)
--
--end

--function SimulatedRewardPanel:StartEnter(time)
--
--end

--function SimulatedRewardPanel:StartRemoving(time)
--
--end

--function SimulatedRewardPanel:StartExit(time)
--
--end

function SimulatedRewardPanel:OnOpen(data, initiative)
    self:setRewardData()
end

function SimulatedRewardPanel:setRewardData()
    local activityData = Me:getSimulatedActivityData()
    local floorConfigMap = Config.GetAllConfig("PveExerciseStoreyTable")
    local floorConfigList = {}
    for _, value in pairs(floorConfigMap) do
        table.insert(floorConfigList, value)
    end
    table.sort(floorConfigList, function(a, b)
        return a.storeyNum < b.storeyNum
    end)
    --LuaLogger.ds(">>>>>>>floorConfigList<<<<<", tablex.dump(floorConfigList))
    self:FillTemplateContent(self.rewardBox, self.content, #floorConfigList, function (index,rewardBox)
        rewardBox.canvasGroup.alpha = 0
        local floorConfig = floorConfigList[index]
        rewardBox.levelTips.text.text = "通关层数"
        rewardBox.levelTxt.text.text = string.format("通关%s层领取", floorConfig.storeyNum)
        self:FillTemplateContent(self.customBox, rewardBox.rewardList, #floorConfig.Reward, function (index2,itemObj)
            local customBox = itemObj.customBox
            local rewardData = floorConfig.Reward[index2]
            --[[local data = {
                id = rewardData[2],
            }
            local needConfig, needType = nil, 1
            if rewardData[1] == GE.RewardType.ItemProp then
                needType = GE.CustomMsgType.Item
                needConfig = Config.GetItemInfo(rewardData[2])
                data.itemType = GE.ItemTypeIndex.item
            elseif rewardData[1] == GE.RewardType.Equipment then
                needType = GE.CustomMsgType.Equip
                needConfig = Config.GetEquipmentInfo(rewardData[2])
                data.itemType = GE.ItemTypeIndex.equip
            elseif rewardData[1] == GE.RewardType.Weapon then
                needType = GE.CustomMsgType.Weapon
                needConfig = Config.GetWeaponInfo(rewardData[2])
                data.itemType = GE.ItemTypeIndex.weapon
            end
            if rewardData[3] ~= 0 then
                data.itemNum = rewardData[3]
            end]]
            customBox:setMono(self)
            customBox:SetUIData(rewardData)
        end)
        local isGetReward = activityData.simulatedLevelMap and activityData.simulatedLevelMap[floorConfig.id]
            and activityData.simulatedLevelMap[floorConfig.id].getReward or false
        rewardBox.taskOkBtn:SetActive(isGetReward)
        rewardBox.mask:SetActive(isGetReward)

        --显示动画
        DLuaTimer:DoAfter(0.05 * index, function()
            rewardBox.canvasGroup:DOFade(1, 0.2)
        end)
    end)
end

function SimulatedRewardPanel:OpenCustomMsgPanel(data)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:SetPassEventState(false)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

--界面关闭
function SimulatedRewardPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--function SimulatedRewardPanel:OnClose(initiative)
--
--end

--function SimulatedRewardPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SimulatedRewardPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function SimulatedRewardPanel:mask_Button_onClick(mask)
    self:playCloseAnim()
end

--[[
/BoxBg/CloseBtn onClick 
--]]
function SimulatedRewardPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

return SimulatedRewardPanel
