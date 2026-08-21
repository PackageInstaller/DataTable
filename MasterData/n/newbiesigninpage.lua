---@class NewbieSignInPage : NewbieSignInPage__Generate
---##################### 【NewbieSignInPage Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【NewbieSignInPage Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local NewbieSignInPage = require "NewbieSignInPage_Generate"

function NewbieSignInPage:InitLogic(data)
    self.pageContent = nil
end

--function NewbieSignInPage:OnDestroy()
--	self.super:OnDestroy(self)
--end

function NewbieSignInPage:RefreshPage(activityId, content)
    --7日签到
    local signInInfo = ClientData:GetNewbieSignInInfo()
    self.pageContent = content
    local itemIconPath = Config.SpritePath.Item
    for index, info in ipairs(self.pageContent) do
        local awardInfo = info[2]
        -- print("NewbieSignInPage:RefreshPage Signin awardInfo",tablex.dump(awardInfo))
        local iconPath = string.format(itemIconPath, awardInfo[2])
        self["rewardBtn"..index].icon:SetActive(true)
        self:LoadSpriteAsync(iconPath, self["rewardBtn"..index].icon.image)
        self["rewardBtn"..index].numText.text.text = awardInfo[3]

        local isClaimed = signInInfo.signInIndex > index
        self["rewardBtn"..index].getMask:SetActive(isClaimed)
        local lastRefreshTime = ClientData:GetLastResetTime()
        local claimedToday = lastRefreshTime < signInInfo.lastSignInTime
        self["rewardBtn"..index].rewardMask:SetActive(not claimedToday and index == signInInfo.signInIndex)
    end
    self.rewardInfoBox:SetActive(false)
    self.tipCloseMask:SetActive(false)
    self.tipCloseMask.pointerListener.onPointerDownEvent = function ()
        self.rewardInfoBox:SetActive(false)
        self.tipCloseMask:SetActive(false)
    end
end

function NewbieSignInPage:_GetSignInReward(index, btnObj, offset)
    --print("SigninPanel:_GetSignInReward", index)
    local signInInfo = ClientData:GetNewbieSignInInfo()
    local lastRefreshTime = ClientData:GetLastResetTime()
    local isClaimed = lastRefreshTime < signInInfo.lastSignInTime
    --print("SigninPanel:_GetSignInReward isClaimed",isClaimed, refreshTm, signInInfo.lastSignInTime,DLuaUtil.GetCurrZeroHourTime())
    if (not isClaimed and index == signInInfo.signInIndex) then
        --领取新手签到奖励
        Me:GetNewbieSignInRewardReq(function ()
            LuaLogger.ds("GetNewbieSignInRewardReq")
        end)
    else
        --展示签到奖励信息
        LuaLogger.ds("展示签到奖励信息")
        self:_RefreshRewardInfoBox(index, btnObj, offset)
    end
end

function NewbieSignInPage:_RefreshRewardInfoBox(index, btnObj, offset)
    local info = self.pageContent[index]
    local awardInfo = info[2]
    if (awardInfo) then
        local propConfig = Config.GetItemPropInfo(awardInfo[2])
        self.rewardInfoBox.nameText.text.text = LocalStrEnum[propConfig.NameKey]
        local propNum = 0
        if (propConfig.Type == GE.ItemPropType.Currency) then
            propNum = Me:getMoneyById(propConfig.id)
        else
            local propData = ClientData:GetItemPropData(propConfig.id)
            propNum = propData and propData.num or 0
        end
        self.rewardInfoBox.numText.text.text = propNum
        self.rewardInfoBox.decText.text.text = LocalStrEnum[propConfig.DesKey]
        self.rewardInfoBox.transform.localPosition = btnObj.transform.localPosition + Vector3.up * offset
        self.rewardInfoBox:SetActive(true)
        self.tipCloseMask:SetActive(true)
    end
end

--[[
/Root onClick 
--]]
function NewbieSignInPage:button_Button_onClick(button)

end

--[[
/RewardsGroup/RewardBtn1 onClick 
--]]
function NewbieSignInPage:rewardBtn1_ScaleButton_onClick(rewardBtn1)
    self:_GetSignInReward(1, rewardBtn1, -240)
end

--[[
/RewardsGroup/RewardBtn2 onClick 
--]]
function NewbieSignInPage:rewardBtn2_ScaleButton_onClick(rewardBtn2)
    self:_GetSignInReward(2, rewardBtn2, -240)
end

--[[
/RewardsGroup/RewardBtn3 onClick 
--]]
function NewbieSignInPage:rewardBtn3_ScaleButton_onClick(rewardBtn3)
    self:_GetSignInReward(3, rewardBtn3, -240)
end

--[[
/RewardsGroup/RewardBtn4 onClick 
--]]
function NewbieSignInPage:rewardBtn4_ScaleButton_onClick(rewardBtn4)
    self:_GetSignInReward(4, rewardBtn4, 240)
end

--[[
/RewardsGroup/RewardBtn5 onClick 
--]]
function NewbieSignInPage:rewardBtn5_ScaleButton_onClick(rewardBtn5)
    self:_GetSignInReward(5, rewardBtn5, 240)
end

--[[
/RewardsGroup/RewardBtn6 onClick 
--]]
function NewbieSignInPage:rewardBtn6_ScaleButton_onClick(rewardBtn6)
    self:_GetSignInReward(6, rewardBtn6, 240)
end

--[[
/RewardsGroup/RewardBtn7 onClick 
--]]
function NewbieSignInPage:rewardBtn7_ScaleButton_onClick(rewardBtn7)
    self:_GetSignInReward(7, rewardBtn7, 240)
end

return NewbieSignInPage
