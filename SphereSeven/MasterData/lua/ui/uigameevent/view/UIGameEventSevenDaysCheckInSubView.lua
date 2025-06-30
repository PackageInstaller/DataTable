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

    this.image = rc:GetObject("Image"):GetComponent("Image")
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
            cardImage = itemRc:GetObject("CardImage"):GetComponent("Image"),
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
    local cardId = tonumber(Z_Misc["INIT_CHARACTERS"].Value[Game.Scene.Player.first_character_selected])
    -- 1002 是李世民, 所以显示曹操
    if cardId == 1002 then
        -- 曹操
        this.image.sprite =  AtlasManager:GetInstance():CoLoadImageAsync("UI/GameEvent/SevenDaysCheckIn/banner_caocao.jpg")
    else
        -- 李世民
        this.image.sprite =  AtlasManager:GetInstance():CoLoadImageAsync("UI/GameEvent/SevenDaysCheckIn/banner_lishimin.jpg")
    end
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
            if i ~= table.count(checkInGroupData.group) then
                v.itemPrefab:SetActive(true)
                v.cardImage.gameObject:SetActive(false)
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
            else
                v.itemPrefab:SetActive(false)
                v.cardImage.gameObject:SetActive(true)
                if checkInItem.receiveStatus == CheckInReceiveStatus.CheckInReceiveNotReceived then
                    -- 大图
                    if cardId == 1002 then
                        -- 曹操
                        v.cardImage.sprite =  AtlasManager:GetInstance():CoLoadImageAsync("UI/GameEvent/SevenDaysCheckIn/img_qiandao_b_caocao.png")
                    else
                        -- 李世民
                        v.cardImage.sprite =  AtlasManager:GetInstance():CoLoadImageAsync("UI/GameEvent/SevenDaysCheckIn/img_qiandao_b_lishimin.png")
                    end
                else
                    -- 小图
                    if cardId == 1002 then
                        -- 曹操
                        v.cardImage.sprite =  AtlasManager:GetInstance():CoLoadImageAsync("UI/GameEvent/SevenDaysCheckIn/img_qiandao_s_caocao.png")
                    else
                        -- 李世民
                        v.cardImage.sprite =  AtlasManager:GetInstance():CoLoadImageAsync("UI/GameEvent/SevenDaysCheckIn/img_qiandao_s_lishimin.png")
                    end
                end
                v.cardImage:SetNativeSize()
            end

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
    -- local seconds
    -- if self.currentTaskType == TaskType.TaskTypeDaily then
    --     seconds = TimeUtil.GetWeekLastSeconds()
    -- elseif self.currentTaskType == TaskType.TaskTypeWeekly then
    --     seconds = TimeUtil.GetWeekLastSeconds(1)
    -- else
    --     seconds = 0
    -- end

    local tb = TimeUtil.ConvertTimeForm(seconds)
    -- if self.currentTaskType == 6 or self.currentTaskType == 5  then
    --     if tb.day > 0 then
    --         self.lastTimeText.text = string.format(LangUtil.GetSysLang(904).." %d"..LangUtil.GetSysLang(2005).." %02d:%02d:%02d", tb.day, tb.hour, tb.minute, tb.second)
    --     else
    --         self.lastTimeText.text = string.format(LangUtil.GetSysLang(904).." %02d:%02d:%02d", tb.hour, tb.minute, tb.second)
    --     end
    -- else
        if tb.day > 0 then
            return LangUtil.GetSysLang(1326) .. string.format("%d"..LangUtil.GetSysLang(2005).." %02d:%02d:%02d", tb.day, tb.hour, tb.minute, tb.second)
        else
            return LangUtil.GetSysLang(1326) .. string.format("%02d:%02d:%02d", tb.hour, tb.minute, tb.second)
        end
    -- end
end
return this