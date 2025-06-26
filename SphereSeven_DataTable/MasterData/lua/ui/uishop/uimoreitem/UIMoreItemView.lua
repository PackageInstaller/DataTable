--
-- <代码文件解释说明>
--

---@class UIMoreItemView : UIBaseView
---@field model UIMoreItemModel
---@field ctrl UIMoreItemCtrl
local UIMoreItemView = BaseClass("UIMoreItemView",UIBaseView)
local base = UIBaseView
local this = UIMoreItemView

local currentIndex = 0
local pfbName = "ItemPrefab"


function this:OnLangCreate()
    self.descriptionText = LangUtil.BindText(self.descriptionText)
    LangUtil.BindText(self.rc:GetObject("TitleText")).text = LangUtil.GetSysLang(229)
    self.countText = LangUtil.BindText(self.rc:GetObject("CountText"))
    self.countValue = LangUtil.BindText(self.rc:GetObject("CountValue"))
    self.nameText = LangUtil.BindText(self.rc:GetObject("NameText"))
end

function this:OnCreate()
    base.OnCreate(self)
    self.back_btn = self.rc:GetObject("Mask")
    self.descriptionText = self.rc:GetObject("DescriptionText")
    self.itemBg = self.rc:GetObject("ItemBg"):GetComponent("Image")
    self.avatar = self.rc:GetObject("Icon"):GetComponent("Image")

    self.itemData = {}
    local rc = self.rc:GetObject("ItemPrefab"):GetComponent("ReferenceCollector")
    self.itemData.icon = rc:GetObject("Icon"):GetComponent("Image")
    self.itemData.itemBg = rc:GetObject("ItemBg"):GetComponent("Image")
    self.itemData.frame = rc:GetObject("Frame"):GetComponent("Image")
    self.itemData.countText = rc:GetObject("Num"):GetComponent("Text")
    self.itemData.infoImage = self.rc:GetObject("InfoImage")
    UIUtil.AddBtnEventNoBug(self.rc:GetObject("ItemPrefab"), function()
        if self.showType == nil then
            return
        end

        UIUtil.OpenThingsDetailWindow({
            showType = self.showType,
            tempId = self.showTempId,
        })
    end)

    UIUtil.AddBtnEvent(self.back_btn,function()self.ctrl.CloseSelf()end,"Back")

    self.content = self.rc:GetObject("Content").transform

    self.zOptionalRewardPack = {}

    self.itemList = {}

    self.rawItemPrefab = self.rc:GetObject("RawItemPrefab")
    self.rawItemPrefab:SetActive(false)

end

function this:RefreshInfo()
    local data = self.zOptionalRewardPack[currentIndex]
    UIPublic.InitItemIconNew(self.itemData.icon, self.itemData.itemBg, data.Type, data.ObjId, data.Count, nil, false, self.itemData.frame)
    local rewardData = UIPublic.GetRewardDataNew(data.Type, data.ObjId, data.Count)
    self.descriptionText.text = rewardData.desc
    self.nameText.text = rewardData.name
    
    self.itemData.countText.text = ""
    if data.Type == RewardType.RewardTypeCharacter then
        if rewardData.hasCount > 0 then
            self.countValue.text = LangUtil.GetSysLang(1318)
        else
            self.countValue.text = LangUtil.GetSysLang(1319)
        end
        self.countText.text = ""
    else
        self.countValue.text = rewardData.hasCount
        self.countText.text = LangUtil.GetSysLang(1317)
    end

    if data.Type == RewardType.RewardTypeCharacter then
        self.showType = ShowType.Card
    elseif data.Type == RewardType.RewardTypeFightSoul then
        self.showType = ShowType.FightSoul

    elseif data.Type == RewardType.RewardTypeEquipment then
        self.showType = ShowType.Equip
    else
        self.showType = nil
    end

    self.itemData.infoImage:SetActive(self.showType ~= nil)
    self.showTempId = data.ObjId
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:RefreshItems()

    for index, data in ipairs(self.zOptionalRewardPack) do

        local gameObject = self.itemList[index]
        if gameObject == nil then
            gameObject = GameObject.Instantiate(self.rawItemPrefab)
            gameObject.transform:SetParent(self.content.transform, false)
            gameObject:SetActive(true)
            gameObject.transform:SetParent(self.content.transform)
            gameObject.transform.localPosition = Vector3.New(0,0,0)
            gameObject.transform.localScale = Vector3.New(1,1,1)
            self.itemList[index] = gameObject
        end
        gameObject:SetActive(true)
    
        ---@type {Id:number, RewardType:number, RewardId:number, RewardCount:number}
        local data = data

        local rc = gameObject:GetComponent("ReferenceCollector")
        local icon = rc:GetObject("Icon"):GetComponent("Image")
        local itemBg = rc:GetObject("ItemBg"):GetComponent("Image")
        local frame = rc:GetObject("Frame"):GetComponent("Image")
        UIPublic.InitItemIconNew(icon, itemBg, data.Type, data.ObjId, data.Count, nil, false, frame)
        rc:GetObject("Num"):GetComponent("Text").text = data.Count
        local select = rc:GetObject("Select")

        select:SetActive(index == currentIndex)
        UIUtil.AddBtnEventNoBug(gameObject, function()
            if index == currentIndex then
                return
            end
            currentIndex = index

            for i, go in ipairs(self.itemList) do
                if go ~= gameObject then
                    local rc2 = go:GetComponent("ReferenceCollector")
                    rc2:GetObject("Select"):SetActive(false)
                else
                    select:SetActive(index == currentIndex)
                end
            end
            self:RefreshInfo()
        end)
    end
    for i = table.count(self.zOptionalRewardPack) + 1, table.count(self.itemList) do
        self.itemList[i]:SetActive(false)
    end

    self.content:DOLocalMoveY(0, 0)
end


function this:OnRefresh()
    self.descriptionText.gameObject:SetActive(true)

    self.zOptionalRewardPack = self.model.rewards
    currentIndex = 1
    self:RefreshItems()

    self:RefreshInfo()
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
