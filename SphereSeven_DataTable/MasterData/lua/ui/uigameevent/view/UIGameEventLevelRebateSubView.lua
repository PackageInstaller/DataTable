-- UIGameEventRechargeSubView
---@class UIGameEventLevelRebateSubView
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

    local entryModuleId = self.model.data[self.model.index].gameEvent.entryModuleId

    this.getAllButton = rc:GetObject("GetAllButton")
    UIUtil.AddBtnEvent(this.getAllButton, function()
        local beginLevel = this.pass.normal_received_stage + 1
        local endLevel = this.pass.level
        PublicRequest.SendRequest(
            PROTOCOL.ReceivePassRewardsReq,
            {
                pass_id = this.pass.id,
            },
            function(response)
                UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattlePassReward,
                    {
                        beginLevel = beginLevel,
                        endLevel = endLevel,
                        passId = this.pass.id,
                        response = response,
                    }
                )
            end,
            function(error)
                Logger.LogError(error)
            end
        )
    end)
    LangUtil.BindText(this.getAllButton.transform:Find("Text")).text = LangUtil.GetSysLang(311) -- 一键领取

    this.unlockButton = rc:GetObject("UnlockButton")
    UIUtil.AddBtnEvent(this.unlockButton, function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattlePassBuyPass, {passId = this.pass.id})
    end)
    LangUtil.BindText(this.unlockButton.transform:Find("Text")).text = LangUtil.GetSysLang(1385) -- 解锁高级奖励

    this.itemList = {}
    this.rawItem = rc:GetObject("RawItem")
    this.rawItem:SetActive(false)
end

---@param self UIGameEventMainView
function this.OnRefresh(self)
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    local passId
    for index, value in pairs(this.config) do
        if value.ModuleType == GameEventModuleType.GameEventModulePass then
            if value.ModuleParams ~= nil and value.ModuleParams[1] ~= nil then
                passId = value.ModuleParams[1]
                break
            end
        end
    end
    if passId == nil then
        Logger.LogError("GameEventModulePass not found")
        return
    end

    ---@type PassComponent
    local passComponent = Game.Scene.Player:GetComponent("PassComponent")
    this.pass = passComponent:GetPass(passId)

    local zPassRewad = Z_PassReward[this.pass.id]
    for index, value in ipairs(zPassRewad) do
        local go = this.itemList[index]
        if go == nil then
            go = GameObject.Instantiate(this.rawItem)
            go.transform:SetParent(this.rawItem.transform.parent, false)
            go:SetActive(true)
            go.transform:SetParent(this.rawItem.transform.parent)
            go.transform.localPosition = Vector3.New(0,0,0)
            go.transform.localScale = Vector3.New(1,1,1)
            this.itemList[index] = go
        end
        go:SetActive(true)

        ---@type ReferenceCollector
        local rc = go:GetComponent("ReferenceCollector")

        LangUtil.BindText(rc:GetObject("LevelText")).text = value.Name
        rc:GetObject("Mask1"):SetActive(this.pass.level < index)
        rc:GetObject("Mask2"):SetActive(this.pass.level < index)
        rc:GetObject("Lock"):SetActive(this.pass.membership ~= PassMembership.PassMembershipPremium and this.pass.membership ~= PassMembership.PassMembershipSpecial)
        
        local itemPrefab1 = rc:GetObject("ItemPrefab1")
        UIPublic.InitRewardItem(
            {
                rewardId = value.NormalRewards,
                itemPrefab = itemPrefab1,
                isShowCount = true,
                isShowThingsDetail = true,
            }
        )
        local itemPrefab2 = rc:GetObject("ItemPrefab2")
        UIPublic.InitRewardItem(
            {
                rewardId = value.SpecialRewards,
                itemPrefab = itemPrefab2,
                isShowCount = true,
                isShowThingsDetail = true,
            }
        )
        itemPrefab1.transform:Find("Mask").gameObject:SetActive(this.pass.normal_received_stage >= index)
        itemPrefab2.transform:Find("Mask").gameObject:SetActive(this.pass.special_received_stage >= index)
    end


    UIPublic.InitButton(this.getAllButton, this.pass.canReceiveNormal or this.pass.canReceiveSpecial)
    this.unlockButton:SetActive(this.pass.membership == PassMembership.PassMembershipNormal)

end

---@param self UIGameEventMainView
function this.OnGameEventUpdate(self)
    this.OnRefresh(self)
end

---@param self UIGameEventMainView
function this.OnPassUpdatePush(self)
    this.OnRefresh(self)
end

---@param self UIGameEventMainView
function this.OnTaskUpdate(self, type)
    this.OnRefresh(self, type)
end

return this