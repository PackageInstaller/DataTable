-- UIGameEventRechargeSubView
---@class UIGameEventNewbieTaskSubView
local PropSubView = {}
local this = PropSubView

-- 初始化
---@param self UIGameEventMainView
---@param gameObject UnityEngine.GameObject
---@param eventId number
function this.OnCreate(self, gameObject, eventId)
    ---@type ReferenceCollector
    local rc = gameObject:GetComponent("ReferenceCollector")

    this.eventId = eventId
    this.config = Z_GameEvents[eventId]

    this.dayLayout = rc:GetObject("DayLayout").transform
    this.dayItemList = {}
    for i = 0, this.dayLayout.childCount - 1 do
        local item = this.dayLayout:GetChild(i)
        local day = i + 1
        local itemRc = item:GetComponent("ReferenceCollector")
        this.dayItemList[day] = {
            day = day,
            active = itemRc:GetObject("Avtive").gameObject,
            isOn = itemRc:GetObject("IsOn").gameObject,
            receive = itemRc:GetObject("Receive").gameObject,
            unavailable = itemRc:GetObject("Unavailable").gameObject,
            statusText = LangUtil.BindText(itemRc:GetObject("StatusText")),
            itemPrefab = itemRc:GetObject("ItemPrefab"),
            maskImage = itemRc:GetObject("MaskImage"),
            nameText = LangUtil.BindText(itemRc:GetObject("Value")),
        }
        LangUtil.BindText(this.dayItemList[day].isOn.transform:Find("Text")).text = string.gsub(LangUtil.GetSysLang(1342), "XX", day)
        LangUtil.BindText(this.dayItemList[day].receive.transform:Find("Text")).text = string.gsub(LangUtil.GetSysLang(1342), "XX", day)
        LangUtil.BindText(this.dayItemList[day].unavailable.transform:Find("Text")).text = string.gsub(LangUtil.GetSysLang(1342), "XX", day)
    end
end

---@param self UIGameEventMainView
function this.OnRefresh(self)
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")

    for key, value in pairs(this.config) do
        if value.ModuleType == GameEventModuleType.GameEventModuleCheckIn then
            local module = gameEventComponent:GetGameEventModule(value.ModuleId)
            if module.status == GameEventStatus.GameEventStatusInProgress then
                this.gameEventModule = module
                break
            end
        end
    end

    ---@type CheckInComponent
    local checkInComponent = Game.Scene.Player:GetComponent("CheckInComponent")
    local checkInId = this.gameEventModule.config.ModuleParams[1]
    local checkInGroupData = checkInComponent:GetCheckInGroupData(checkInId)

    for i, v in ipairs(this.dayItemList) do
        ---@type CheckInItem
        local checkInItem = checkInGroupData.group[i]
        if checkInItem == nil then
        
        else
            v.itemPrefab:SetActive(true)
            ---@type RewardItemData
            local rewardItemData = {}
            rewardItemData.itemPrefab = v.itemPrefab
            rewardItemData.rewardId = checkInItem.config.Reward
            rewardItemData.isShowThingsDetail = true
            rewardItemData.isBag = false
            rewardItemData.isShowCount = true
            -- rewardItemData.nameText = v.nameText
            UIPublic.InitRewardItem(
                rewardItemData
            )

            v.active:SetActive(checkInItem.receiveStatus == CheckInReceiveStatus.CheckInReceiveNotReceived)
            v.isOn:SetActive(checkInItem.receiveStatus == CheckInReceiveStatus.CheckInReceiveNotReceived)
            v.receive:SetActive(checkInItem.receiveStatus == CheckInReceiveStatus.CheckInReceiveReceived)
            v.maskImage:SetActive(checkInItem.receiveStatus == CheckInReceiveStatus.CheckInReceiveReceived)
            v.unavailable:SetActive(checkInItem.receiveStatus == CheckInReceiveStatus.CheckInReceiveUnavailable)
            if checkInItem.receiveStatus == CheckInReceiveStatus.CheckInReceiveNotReceived then
                v.statusText.text = LangUtil.GetSysLang(4111)
            elseif i == checkInGroupData.count + 1 and checkInItem.receiveStatus == CheckInReceiveStatus.CheckInReceiveUnavailable then
                v.statusText.text = LangUtil.GetSysLang(1344)
            else
                v.statusText.text = ""
            end

            UIUtil.AddBtnEvent(v.active,function()
                if checkInItem.receiveStatus == CheckInReceiveStatus.CheckInReceiveNotReceived then
                    ---@param response protocol.CommonCheckInReceiveResp
                    PublicRequest.SendRequest(
                        PROTOCOL.CommonCheckInReceiveReq,
                        {
                            group_id = checkInId,
                            id = i,
                        },
                        function(response)
                            UIPublic.OpenRewardUI(response.reward_result)
                        end
                    )
                end
            end)
        end
    end
end

---@param self UIGameEventMainView
function this.OnGameEventUpdate(self)
    this.OnRefresh(self)
end

---@param self UIGameEventMainView
function this.OnTaskUpdate(self)
end

function this.OnCheckInUpdate()
    this.OnRefresh(self)
end

---@param self UIGameEventMainView
function this.showEndTime(self)
    local entryModuleId = self.model.data[self.model.index].gameEvent.entryModuleId
    ---@type GameEventModule
    local module = Game.Scene.Player:GetComponent("GameEventComponent"):GetGameEventModule(entryModuleId)
    if module.config.GameEventType == GameEventType.Normal then
        return ""
    end
    local seconds = module.endTime - TimeUtil.GetServerTime()
    local tb = TimeUtil.ConvertTimeForm(seconds)
        if tb.day > 0 then
            return LangUtil.GetSysLang(1326) .. string.format("%d"..LangUtil.GetSysLang(2005).." %02d:%02d:%02d", tb.day, tb.hour, tb.minute, tb.second)
        else
            return LangUtil.GetSysLang(1326) .. string.format("%02d:%02d:%02d", tb.hour, tb.minute, tb.second)
        end
    -- end
end
return this