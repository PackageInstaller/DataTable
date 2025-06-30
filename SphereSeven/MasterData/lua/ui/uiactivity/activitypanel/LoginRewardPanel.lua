
local LoginReward = {}
local this = LoginReward

local GAME_EVENT_ID = 4
local GAME_EVENT_MODULE_ID = 4002

function this.InitPanel(activitySelf)
    if not this.isInit then
        this.isInit = true
       
        -- this.OnRefresh(activitySelf)
    end
end

function this.isActive(activitySelf)
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    return gameEventComponent:CheckIsOpen(GAME_EVENT_ID, GAME_EVENT_MODULE_ID)
end

function this.OnCreate(activitySelf, item)
    this.panel = item.panelObj.transform
    local ItemPanel = this.panel:Find("ItemPanel")
    this.items = {}
    for i = 0, ItemPanel.transform.childCount - 1 do
        table.insert(this.items, ItemPanel.transform:GetChild(i).gameObject);
    end
    
    this.itemPanel = this.panel:Find("ShowItem").gameObject
    this.itemPanel:SetActive(false)
    local subEventBg = this.itemPanel.transform:Find("EventBg").gameObject    
    EventTriggerListener.Get(subEventBg).onLuaClick = function() this.itemPanel:SetActive(false) end
    this.desc = LangUtil.BindText(this.itemPanel.transform:Find("Item/TextScroll/Viewport/Content/Desc"))

end

function this.OnLangCreate(activitySelf)
    for _, v in pairs(this.items) do
        LangUtil.BindText(v.transform:Find("NumTxt"))
    end
end

---@param activitySelf UIActivityView
function this.OnRefresh(activitySelf)
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    local gameEventModule = gameEventComponent:GetGameEventModule(GAME_EVENT_MODULE_ID)

    ---@type CheckInComponent
    local checkInComponent = Game.Scene.Player:GetComponent("CheckInComponent")
    local checkInId = gameEventModule.config.ModuleParams[1]
    local checkInGroupData = checkInComponent:GetCheckInGroupData(checkInId)

    for i, v in ipairs(this.items) do
        local checkInItemm = checkInGroupData.group[i]

        if checkInItemm == nil then
            v:SetActive(false)
        else
            v:SetActive(true)
            v.transform:Find("get").gameObject:SetActive(checkInItemm.status == CommonCheckInStatus.CommonCheckInOnGoing and checkInItemm.receiveStatus == CheckInReceiveStatus.CheckInReceiveReceived)
            v.transform:Find("Active").gameObject:SetActive(i == checkInGroupData.count)

            local icon = v.transform:Find("Image"):GetComponent("Image")
            local numTxt = v.transform:Find("NumTxt"):GetComponent("Text")
            local rewards = Z_Reward[checkInItemm.config.Reward]
            local reward = rewards[1]
            numTxt.text = reward.Count

            local itemInfo = UIPublic.GetRewardDataNew(reward.Type, reward.ObjId, reward.Count)
            UIPublic.InitItemIconNew(icon, nil, itemInfo.type, itemInfo.id, itemInfo.count, true, false)

            -- UIUtil.AddBtnEvent(v.gameObject,function()
            --     local root = this.itemPanel.transform:Find("Item")

            --     local avatar = root:Find("Icon/Avatar"):GetComponent("Image")
            --     local starBg = root:Find("Icon/StarBg"):GetComponent("Image")
            --     local nameTxt = LangUtil.BindText(root:Find("Size/Name"))
            --     local kindTxt = LangUtil.BindText(root:Find("Kind"))
        
            --     starBg.sprite = nil
            --     coroutine.start(function()
            --         activitySelf:OnClickItem(itemInfo)
            --         -- nameTxt.text = itemInfo.name
            --         -- kindTxt.text = itemInfo.type
            --         -- this.desc.text = itemInfo.desc
            --         -- UIUtil.ScrollText(nameTxt)
        
            --         -- UIPublic.InitItemIconNew(avatar, starBg, itemInfo.type, itemInfo.id)
            --         -- starBg.gameObject:SetActive(starBg.sprite ~= nil)
                    
            --         -- UIPublic.SetPanelPosition(root, activitySelf.signInScroll.transform, v.transform.position)
            --         -- this.itemPanel:SetActive(true)
            --     end)
            -- end)
        end
    end

    if table.count(checkInGroupData.canReceiveIndex) > 0 then
        ---@param response protocol.CommonCheckInReceiveResp
        PublicRequest.SendRequest(
            PROTOCOL.CommonCheckInReceiveReq,
            {
                group_id = checkInId,
                id = checkInGroupData.canReceiveIndex[1],
            },
            function(response)
                UIPublic.OpenRewardUI(response.reward_result)
            end
        )
    end

    -- if checkInGroupData.group[checkInGroupData.count].status == CommonCheckInStatus.CommonCheckInOnGoing and
    --     checkInGroupData.group[checkInGroupData.count].receiveStatus == CheckInReceiveStatus.CheckInReceiveNotReceived then
    --         ---@param response protocol.CommonCheckInReceiveResp
    --         PublicRequest.SendRequest(
    --             PROTOCOL.CommonCheckInReceiveReq,
    --             {
    --                 group_id = checkInId,
    --                 id = checkInGroupData.count,
    --             },
    --             function(response)
    --                 UIPublic.OpenRewardUI(response.reward_result)
    --             end
    --         )
    -- end

    this.itemPanel:SetActive(false)
end

function this.OnInfoChg(activitySelf)
    this.isInit = nil
    this.OnRefresh(activitySelf)
end

function this.OnDisable(activitySelf)
    this.isInit = nil
end

return this