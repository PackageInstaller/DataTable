---@class WeeklyBossRewardPanel : WeeklyBossRewardPanel_Generate
---##################### 【WeeklyBossRewardPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeeklyBossRewardPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeeklyBossRewardPanel = require "WeeklyBossRewardPanel_Generate"

function WeeklyBossRewardPanel:InitLogic(data)

end

--function WeeklyBossRewardPanel:StartCreating(time)
--
--end

--function WeeklyBossRewardPanel:StartEnter(time)
--
--end

--function WeeklyBossRewardPanel:StartRemoving(time)
--
--end

--function WeeklyBossRewardPanel:StartExit(time)
--
--end

function WeeklyBossRewardPanel:OnOpen(data, initiative)
    self.closeFunc = data.closeFunc
    self:setRewardData()
end

--设置奖励数据
function WeeklyBossRewardPanel:setRewardData()
    local canGetReward = false
    local bossActData = Me:getBossActivityData()
    local allScore = 0
    for _, bossData in pairs(bossActData.bossLevelMap or {}) do
        allScore = allScore + (bossData.nowScore or 0)
    end
    local rewardCfg = Config.GetAllConfig("PveBossBattleScoreTable")
    local rewardConfigList = {}
    for _, value in pairs(rewardCfg) do
        table.insert(rewardConfigList, value)
    end
    table.sort(rewardConfigList, function(a, b)
        return a.id < b.id
    end)
    self:FillTemplateContent(self.rewardBox, self.content, #rewardConfigList, function (index,rewardBox)
        rewardBox.canvasGroup.alpha = 0
        local rewardConfig = rewardConfigList[index]
        rewardBox.taskDesc.text.text = string.format("总积分达到%s领取", rewardConfig.scoreNum)
        self:FillTemplateContent(self.customBox, rewardBox.rewardList, #rewardConfig.Reward, function (index2,itemObj)
            local customBox = itemObj.customBox
            local rewardData = rewardConfig.Reward[index2]
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
            end
            data.listener = function()
                UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
                local data = {
                    type = needType,
                    config = needConfig,
                    Id = rewardData[2],
                }
                self:OpenCustomMsgPanel(data)
            end]]
            customBox:setMono(self)
            customBox:SetUIData(rewardData)
        end)

        --领取奖励按钮逻辑
        --点击事件
        rewardBox.taskGetBtn.button.onClick:RemoveAllListeners()
        rewardBox.taskGetBtn.button.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            Me:getBossScoreAwardReq({scoreId = rewardConfig.id}, function()
                self:setRewardData()
            end)
        end)

        local isGetReward = false--判断是否已领取
        if tablex.find(bossActData.scoreRewardList or {}, rewardConfig.id) then
            isGetReward = true
        end
        local isFinish = false--判断积分是否达成
        if allScore >= rewardConfig.scoreNum then
            isFinish = true
        end
        rewardBox.taskOkBtn:SetActive(isGetReward)
        rewardBox.mask:SetActive(isGetReward)
        rewardBox.taskGetBtn:SetActive(isFinish)
        if not canGetReward then
            canGetReward = isFinish and not isGetReward
        end
        if index == #rewardConfigList then
            self.oneClickBtn:SetActive(canGetReward)
            self.oneClickDisable:SetActive(not canGetReward)
        end

        --显示动画
        DLuaTimer:DoAfter(0.05 * index, function()
            rewardBox.canvasGroup:DOFade(1, 0.2)
        end)
    end)

    --当前总积分
    self.allScoreTxt.text.text = string.format("%s分", allScore)
end

function WeeklyBossRewardPanel:OpenCustomMsgPanel(data)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:SetPassEventState(false)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

--界面关闭

function WeeklyBossRewardPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        if self.closeFunc then
            self.closeFunc()
        end
        UIMgr:closeSpecificUI(self)
    end)
end

--function WeeklyBossRewardPanel:OnClose(initiative)
--
--end

--function WeeklyBossRewardPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function WeeklyBossRewardPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function WeeklyBossRewardPanel:mask_Button_onClick(mask)
    self:playCloseAnim()
end

--[[
/BoxBg/CloseBtn onClick 
--]]
function WeeklyBossRewardPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

--[[
/BoxBg/OneClickBtn onClick 
--]]
function WeeklyBossRewardPanel:oneClickBtn_ScaleButton_onClick(oneClickBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:getBossScoreAwardReq({scoreId = 0}, function()
        self:setRewardData()
        GameMsgMgr:sendEvent(GameMsgType.RedPointRefresh)
    end)
end

return WeeklyBossRewardPanel
