--
-- <代码文件解释说明>
--

---@class UIBattlePassRewardView : UIBaseView
---@field model UIBattlePassRewardModel
---@field ctrl UIBattlePassRewardCtrl
local UIBattlePassRewardView = BaseClass("UIBattlePassRewardView",UIBaseView)
local base = UIBaseView
local this = UIBattlePassRewardView

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    LangUtil.BindText(self.rc:GetObject("UnlockButtonText")).text = LangUtil.GetSysLang(1406)
    LangUtil.BindText(self.rc:GetObject("NoteText")).text = LangUtil.GetSysLang(1404)
end

function this:OnCreate()
    base.OnCreate(self)

    local eventBg = self.rc:GetObject("eventBg")
    UIUtil.AddBtnEvent(eventBg,function()self.ctrl.CloseSelf()end,"Back")

    self.normalContent = self.rc:GetObject("NormalContent").transform
    self.specialContent = self.rc:GetObject("SpecialContent").transform
    self.rawItemPrefab = self.rc:GetObject("RawItemPrefab")
    self.rawItemPrefab:SetActive(false)
    self.normatItemPrefabList = {}
    self.specialItemPrefabList = {}

    self.unlock = self.rc:GetObject("Unlock")
    self.unlockButton = self.rc:GetObject("UnlockButton")
    UIUtil.AddBtnEvent(self.unlockButton,function()
        self.ctrl.CloseSelf()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattlePassBuyPass, {passId = self.model.pass.id})
    end)
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:RefreshRewardItem(isNormal, index, rewardType, rewardId, count)
    local go
    local content
    if isNormal then
        go = self.normatItemPrefabList[index]
        content = self.normalContent
    else
        go = self.specialItemPrefabList[index]
        content = self.specialContent
    end
    if go == nil then
        go = GameObject.Instantiate(self.rawItemPrefab)
        go.transform:SetParent(content, false)
        go.transform.localPosition = Vector3.New(0,0,0)
        go.transform.localScale = Vector3.New(1,1,1)

        if isNormal then
            self.normatItemPrefabList[index] = go
        else
            self.specialItemPrefabList[index] = go
        end
    end
    
    local func = function()
        local rc = go:GetComponent("ReferenceCollector")
        local icon = rc:GetObject("Icon"):GetComponent("Image")
        local itemBg = rc:GetObject("ItemBg"):GetComponent("Image")
        local frame = rc:GetObject("Frame"):GetComponent("Image")
        UIPublic.InitItemIconNew(icon, itemBg, rewardType, rewardId, count, true, false, frame)
        rc:GetObject("Num"):GetComponent("Text").text = count
    end
    go:SetActive(false)
        if rewardType ~= RewardType.RewardTypeHeadPortrait
                and rewardType ~= RewardType.RewardTypeCharacterSkin
                and rewardType ~= RewardType.RewardTypePassProgress
                and rewardType ~= RewardType.RewardTypePassProgressWithAddition
            then
                func()
                go:SetActive(true)
        elseif rewardType == RewardType.RewardTypeCharacterSkin then
            local zSkin = Z_Skin[templateId]
            if zSkin ~= nil and zSkin.IsShowInRewardUI == 1 then
                func()
                go:SetActive(true)
            end
        end
        
       
    end

function this:OnRefresh()

    local rewardIndex = 0
    for index, value in ipairs(self.model.response.normal_reward_result) do
        rewardIndex = rewardIndex + 1
        self:RefreshRewardItem(true, rewardIndex, value.type, value.id, value.count)
    end

    for i = rewardIndex + 1, table.count(self.normatItemPrefabList) do
        self.normatItemPrefabList[i]:SetActive(false)
    end


    rewardIndex = 0
    if self.model.pass.membership == PassMembership.PassMembershipSpecial or self.model.pass.membership == PassMembership.PassMembershipPremium then
        -- 已解锁

        if self.model.response.special_reward_result ~= nil then
            for index, value in ipairs(self.model.response.special_reward_result) do
                rewardIndex = rewardIndex + 1
                self:RefreshRewardItem(false, rewardIndex, value.type, value.id, value.count)
            end
        end
        self.unlock:SetActive(false)
    else
        -- 未解锁
        local zPassReward = Z_PassReward[self.model.pass.id]
        local allRewards = {} -- 记录id 有顺序
        local allRewardDic = {} -- 记录数量 会有变化 无序
        for level = self.model.beginLevel, self.model.endLevel do
            local passReward = zPassReward[level]
            if passReward == nil then
                passReward = zPassReward[table.count(zPassReward)]
            end
            local rewardId2 = passReward.SpecialRewards
            for index, value in ipairs(Z_Reward[rewardId2]) do
                if allRewardDic[value.Type] == nil then 
                    allRewardDic[value.Type] = {}
                end
                if allRewardDic[value.Type][value.ObjId] == nil then
                    allRewardDic[value.Type][value.ObjId] = value.Count
                    table.insert(allRewards, {
                        Type = value.Type,
                        ObjId = value.ObjId,
                    })
                else
                    allRewardDic[value.Type][value.ObjId] = allRewardDic[value.Type][value.ObjId] + value.Count
                end
            end
        end

        for index, value in ipairs(allRewards) do
            rewardIndex = rewardIndex + 1
            self:RefreshRewardItem(false, rewardIndex, value.Type, value.ObjId, allRewardDic[value.Type][value.ObjId])    
        end

        self.unlock:SetActive(true)
    end

    for i = rewardIndex + 1, table.count(self.specialItemPrefabList) do
        self.specialItemPrefabList[i]:SetActive(false)
    end

end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddUIListener(UIMessageNames.xxx, func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveUIListener(UIMessageNames.xxx)
end


function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this
