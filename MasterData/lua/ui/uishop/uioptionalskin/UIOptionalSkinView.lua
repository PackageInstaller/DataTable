--
-- <代码文件解释说明>
--

---@class UIOptionalSkinView : UIBaseView
---@field model UIOptionalSkinModel
---@field ctrl UIOptionalSkinCtrl
local UIOptionalSkinView = BaseClass("UIOptionalSkinView",UIBaseView)
local base = UIBaseView
local this = UIOptionalSkinView

local OptionalType = {
    Card = 1,
    Skin = 2,
    FightSoul = 3,
}

local ItemTextColor = {
    [Rarity.R] = "B4A8C2",
    [Rarity.SR] = "CC68FF",
    [Rarity.SSR] = "E4A15B",
}

function this:OnLangCreate()
    self.infoText = LangUtil.BindText(self.rc:GetObject("InfoText"))
    self.useText = LangUtil.BindText(self.rc:GetObject("UseText"))
    LangUtil.BindText(self.rc:GetObject("TitleText")).text = LangUtil.GetSysLang(229)
end

function this:OnCreate()
    base.OnCreate(self)
    cardItem = self.rc:GetObject("CardItem")
    skinItem = self.rc:GetObject("SkinItem")
    fightSoulItem = self.rc:GetObject("FightSoulItem")
    self.content = self.rc:GetObject("Content")
    self.itemList = {
        [OptionalType.Card] = {},
        [OptionalType.Skin] = {},
        [OptionalType.FightSoul] = {},
    }
    cardItem:SetActive(false)
    skinItem:SetActive(false)
    fightSoulItem:SetActive(false)
    self.rawItem = {
        [OptionalType.Card] = cardItem,
        [OptionalType.Skin] = skinItem,
        [OptionalType.FightSoul] = fightSoulItem,
    }

    UIUtil.AddBtnEvent(self.rc:GetObject("Mask"), function()
        self.ctrl.CloseSelf()
    end)
    self.confirmButton = self.rc:GetObject("ConfirmButton")
    UIUtil.AddBtnEvent(self.confirmButton, function()
        if self.choose.index <= 0 or self.choose.index == nil then
            return
        end

        local func = function()
            PublicRequest.SendRequest(
                    PROTOCOL.UseItemReq,
                    {
                        items = {
                            {
                                uid = self.model.id,
                                count = 1,
                                args = {
                                    self.choose.index
                                }
                            }
                        }
                    },
                    function(response)
                        UIPublic.OpenRewardUI(response.reward_result)
                    end
            )
            self.ctrl.CloseSelf()
        end
        
        local str = ""
        local color = ItemTextColor[self.choose.targetRarity]
        if self.optionalType == OptionalType.Card then
            str = string.gsub(LangUtil.GetSysLang(1458), "XXX", "<color=#" .. color .. ">" .. Z_Item[self.model.tempId].Name .. "</color>")
            str = string.gsub(str, "YYY", "<color=#" .. color .. ">" .. self.choose.targetName .. "</color>")
        elseif self.optionalType == OptionalType.FightSoul then
            str = string.gsub(LangUtil.GetSysLang(1460), "XXX", "<color=#" .. color .. ">" .. Z_Item[self.model.tempId].Name .. "</color>")
            str = string.gsub(str, "YYY", "<color=#" .. color .. ">" .. self.choose.targetName .. "</color>")
        elseif self.optionalType == OptionalType.Skin then
            str = string.gsub(LangUtil.GetSysLang(1459), "XXX", Z_Item[self.model.tempId].Name)
            str = string.gsub(str, "YYY", self.choose.targetName)
        end
        
        if self.optionalType == OptionalType.Card and self.choose.isHas then
            local doubleConfirmFunc = function(callBack)
                ---@type ToolTipFirstData
                local tipData = {}
                tipData.message = string.gsub(LangUtil.GetSysLang(1461), "XXX", "<color=#" .. color .. ">" .. self.choose.targetName .. "</color>") -- 已存在 是否使用
                tipData.callBack = function()
                    if callBack ~= nil then
                        callBack()
                    end
                end
                UIUtil.ToolTipFirstStarLight(tipData)
            end
            ---@type ToolTipFirstData
            local tipData = {}
            tipData.message = str -- 是否使用道具
            tipData.callBack = function()
                doubleConfirmFunc(func)
            end
            UIUtil.ToolTipFirstStarLight(tipData)
        else
            ---@type ToolTipFirstData
            local tipData = {}
            tipData.message = str -- 是否使用道具
            tipData.callBack = function()
                func()
            end
            UIUtil.ToolTipFirstStarLight(tipData)
        end
    end)
end

function this:OnEnable()
    base.OnEnable(self)
    self.choose = {
        isHas = false,
        index = nil,
        targetName = "",
        targetRarity = 0,
    }
    self:OnRefresh()
end

function this:OnRefresh()
    local zOptionalRewardPack = Z_OptionalRewardPack[Z_Item[self.model.tempId].UseParams[1]]
    self.optionalType = nil
    for i, v in ipairs(zOptionalRewardPack) do
        if v.RewardType == RewardType.RewardTypeCharacter then
            self.optionalType = OptionalType.Card
            break
        end
        if v.RewardType == RewardType.RewardTypeCharacterSkin then
            self.optionalType = OptionalType.Skin
            break
        end
        if v.RewardType == RewardType.RewardTypeFightSoul then
            self.optionalType = OptionalType.FightSoul
            break
        end
    end
    if self.optionalType == 0 or self.optionalType == nil then
       Logger.LogError("optional is error, item id : " .. self.model.tempId)
        return
    end

    local hideIndex = 0
    local defaultCount = 0
    local defaultName = ""
    for index, data in ipairs(zOptionalRewardPack) do
        if data.IsHide == 1 then
            defaultCount = data.RewardCount
            defaultName = Z_Item[data.RewardId].Name
            hideIndex = index
            break
        end
    end
    if self.model.isUse then
        self.infoText.text = ""
        self.confirmButton:SetActive(true)
    else
        self.confirmButton:SetActive(false)
        if self.optionalType == OptionalType.Card then
            self.infoText.text = LangUtil.GetSysLang(1430)
        elseif self.optionalType == OptionalType.FightSoul then
                self.infoText.text = LangUtil.GetSysLang(1433)
        elseif self.optionalType == OptionalType.Skin then
            local text = string.gsub(LangUtil.GetSysLang(1431), "XXX", defaultCount)
            text = string.gsub(text, "YYY", defaultName)
            self.infoText.text = text
        end
    end
    self.useText.text = ""

    local count = 0
    self.chooseList = {}
    local hasAllSkin = true
    for _, items in pairs(self.itemList) do
        for _, item in pairs(items) do
            item:SetActive(false)
        end
    end
    for index, data in ipairs(zOptionalRewardPack) do
        if data.IsHide ~= 1 then
            count = count + 1
            local go = self.itemList[self.optionalType][count]
            if go == nil then
                go = GameObject.Instantiate(self.rawItem[self.optionalType])
                go.transform:SetParent(self.content.transform, false)
                go:SetActive(true)
                go.transform:SetParent(self.content.transform)
                go.transform.localPosition = Vector3.New(0,0,0)
                go.transform.localScale = Vector3.New(1,1,1)
                self.itemList[self.optionalType][count] = go
            end
            go:SetActive(true)
            local isHas = false

            ---@type CardComponent
            local cardComponent = Game.Scene.Player:GetComponent("CardComponent")
            
            ---@type FightSoulComponent
            local fightSoulComponent = Game.Scene.Player:GetComponent("FightSoulComponent")
            
            local name = ""
            local rarity = 0
            
            if self.optionalType == OptionalType.Card then
                go.transform:Find("CardItemNew/CardInfo/New").gameObject:SetActive(false)
                UIPublic.InitCardItemDataNew(Game.Registry:NewObject("Card",
                        {
                            id = data.RewardId,
                            level = 1,
                            exp = 0,
                            intimacy = 0,
                            bead = 0,
                            constellation = 0,
                            star = 1,
                            skin = nil,
                            skills = {},
                        }
                ), go.transform:Find("CardItemNew/CardInfo").gameObject)
                
                name = Z_Card[data.RewardId].Name
                rarity = Z_Character[data.RewardId].Rarity
                
                local card = cardComponent:Get(data.RewardId)
                isHas = card ~= nil
                hasAllSkin = false
            elseif self.optionalType == OptionalType.Skin then
                local zSkin = Z_Skin[data.RewardId]
                UIUtil.NewSetCardSprite(go.transform:Find("CardImage"):GetComponent("Image"), zSkin.CharacterId, data.RewardId, CardPictureType.Middle)
                LangUtil.BindText(go.transform:Find("NameText")).text = zSkin.Name
                isHas = cardComponent.UnLockSkinList[data.RewardId] ~= nil
                name = zSkin.Name
                if not isHas then
                    hasAllSkin = false
                end
            elseif self.optionalType == OptionalType.FightSoul then
                UIPublic.InitVsFightSoulItem(
                        {
                            TemplateId = data.RewardId,
                            Star = 0,
                            level = nil,
                            maxLevel = nil,
                            isEquip = false,
                            Lock = false,
                            config = Z_FightSoul[data.RewardId]
                        },
                        go.transform:Find("FightVisitItem"))

                go.transform:Find("FightVisitItem").localScale = Vector2.New(0.83, 0.83)
                local fightSouls = fightSoulComponent:GetSameFightSoulList(data.RewardId)
                name = Z_FightSoul[data.RewardId].Name
                rarity = Z_FightSoul[data.RewardId].Rare
                
                isHas = table.count(fightSouls) > 0
                hasAllSkin = false
            end
            local chooseImage = go.transform:Find("ChooseImage").gameObject
            chooseImage:SetActive(self.model.isUse)
            local choose = go.transform:Find("ChooseImage/IsChoose").gameObject
            self.chooseList[index] = choose
            choose:SetActive(false)
            go.transform:Find("Mask").gameObject:SetActive(isHas)
            LangUtil.BindText(go.transform:Find("Mask/Text")).text = LangUtil.GetSysLang(1429)
            
            UIUtil.AddBtnEvent(go, function()
                if not self.model.isUse then
                    return
                end
                if self.optionalType == OptionalType.Skin and isHas then
                    -- 已拥有的皮肤 不能选择
                    return
                end
                self.choose.index = index
                self.choose.isHas = isHas
                self.choose.targetName = name
                self.choose.targetRarity = rarity
                for i, v in ipairs(self.chooseList) do
                    v:SetActive(i==index)
                end
                UIPublic.InitButton(self.confirmButton, self.choose.index ~= nil)
            end)
            UIUtil.AddBtnEvent(go.transform:Find("InfoButton"), function()
                if self.optionalType == OptionalType.Card then
                    UIUtil.OpenThingsDetailWindow({
                        showType = ShowType.Card,
                        tempId = data.RewardId,
                    })
                elseif self.optionalType == OptionalType.Skin then
                    UIUtil.OpenThingsDetailWindow({
                        showType = ShowType.CardSkin,
                        tempId = data.RewardId,
                    })
                else
                    UIUtil.OpenThingsDetailWindow({
                        showType = ShowType.FightSoul,
                        tempId = data.RewardId,
                    })
                end
            end)
        end
    end
    if self.model.isUse and hasAllSkin then
        self.choose.index = hideIndex
        local text = string.gsub(LangUtil.GetSysLang(1432), "XXX", defaultCount)
        text = string.gsub(text, "YYY", defaultName)
        self.useText.text = text
    end
    for i, v in ipairs(self.chooseList) do
        v:SetActive(i==index)
    end

    UIPublic.InitButton(self.confirmButton, self.choose.index ~= nil)
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
