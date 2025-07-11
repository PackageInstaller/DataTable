---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/9 13:38
---
---@class UIThingsDetailView
---@field label UnityEngine.GameObject @ icon下 标题图标(目测表示item类型用的)
local UIThingsDetailView = BaseClass("UIThingsDetailView",UIBaseView)
local base = UIBaseView
local this = UIThingsDetailView

local stageConfig = {}
local labConfig = {}
local color1 = Color.New(155/255, 159/255, 180/255)

---@param self UIThingsDetailView
local function OnClickCardLevelBtn(self, level)
    -- self.maxLvBtn.transform:Find("Active").gameObject:SetActive(level == 100)
    -- self.minLvBtn.transform:Find("Active").gameObject:SetActive(level == 1)
    self.minLvText.color = level == 1 and Color.white or color1
    self.maxLvText.color = level == 100 and Color.white or color1
    
    local hpTxt = self.cardNumerical:Find("HP/Value"):GetComponent("Text")
    local atkTxt = self.cardNumerical:Find("ATK/Value"):GetComponent("Text")
    local speedTxt = self.cardNumerical:Find("SPEED/Value"):GetComponent("Text")
    local defTxt = self.cardNumerical:Find("DEF/Value"):GetComponent("Text")

    local zCard = Z_Card[self.model.data.tempId]
    local index = (level == 1 and {1} or {2})[1]
    hpTxt.text = zCard.Hp[index]
    atkTxt.text = zCard.Atk[index]
    speedTxt.text = zCard.Speed[index]
    defTxt.text = zCard.Def[index]
end

local function InitCardKind(zCard, transform)
    local rareImg = transform:Find("Rare/Value").gameObject
    --local formImg = transform:Find("From/Value"):GetComponent("Image")
    local kindImg = transform:Find("Kind/Value").gameObject
    local atkKindImg = transform:Find("AtkKind/Value").gameObject
    local mainPropImg = transform:Find("MainProp/Value").gameObject
    local subPropImg = transform:Find("SubProp/Value").gameObject

    UIPublic.InitRare(rareImg, zCard)
    --UIUtil.SetSprite(formImg, AtlasConfig.CardFrom,zCard.Sphere..".png")
    UIPublic.InitAbiliType(kindImg, zCard)
    UIPublic.InitAtkDistance(atkKindImg, zCard)
    UIPublic.InitSubProp(subPropImg, zCard)

    local zCharacter = Z_Character[zCard.Id]
    UIUtil.SetSprite(mainProp:GetComponent("Image"), AtlasConfig.Class, 
        zCharacter.Class .. "_" .. zCharacter.Rarity ..".png")

end

---@param self UIThingsDetailView
local function InitCardSkillDetail(self, z_skill, index)
    local desTab = loadtable(z_skill.SkillDesc)
    local tempId = self.model.data.tempId

    if z_skill.Id == Z_Card[tempId].PassiveSkill or z_skill.Id == Z_Card[tempId].GeneralAtk then
        self.cardCdText.text = ""
        self.cardMpText.text = ""
    else
        self.cardCdText.text = "CD:"..z_skill.CooldownTurn
    end
    
    UIUtil.SetSprite(self.CardDetailImg, AtlasConfig.SkillIcon, z_skill.SkillIcon)
    self.cardSkillNameText.text = z_skill.Name
    UIUtil.ScrollText(self.cardSkillNameText)
    self.cardLabelText.text = labConfig[index]

    local str = ""
    if table.count(desTab) == 1 then
        str = str..stageConfig[3]..":"..desTab[1]
    elseif table.count(desTab) == 2 then
        for k,v in table.pairsByKeys(desTab) do
            if k ~= 1 then
                str = str .. "\n"
            end
            str = str..stageConfig[k+1]..":"..v
        end

    elseif table.count(desTab) == 3 then
        for k,v in table.pairsByKeys(desTab) do
            if k ~= 1 then
                str = str .. "\n"
            end
            str = str..stageConfig[k]..":"..v
        end
        if not string.IsNullOrEmpty(z_skill.CloseFullEfx) then
            if not string.IsNullOrEmpty(str) then
                str = str .. "\n"
            end
            str = str..LangUtil.GetSysLang(625).."Max"..":"..z_skill.CloseFullEfx
        end
    end

    self.cardDes.text = str
    self.CardSkillDetail:SetActive(true)
    self.CardSkillEventBg:SetActive(true)
end

---@param self UIThingsDetailView
local function InitCardPanel(self, data)
    local zCard = Z_Card[data.tempId]

    self.item_DescTxt.text = zCard.Archive
    self.item_NameTxt.text = zCard.Name

    self.item_CountText.text = ""

    UIUtil.NewSetCardSprite(self.item_AvaterImage, data.tempId, nil, CardPictureType.Little, false)
    self.item_AvaterBgImage.gameObject:SetActive(false)
end

---@param self UIThingsDetailView
local function InitEquipPanel(self,data)
    local z_data = Z_Equip[data.tempId]
    local transform = self.item_panel.transform
    local avatar = transform:Find("Avatar/Value"):GetComponent("Image")
    local avatarBg = transform:Find("Avatar/Bg"):GetComponent("Image")
    self.item_DescTxt.text = LangUtil.GetSysLang(242 + z_data.Part)
    self.item_NameTxt.text = z_data.Name
    UIPublic.InitItemIcon(avatar, avatarBg, GoodsKind.Equip, z_data.Id)
end

---@param self UIThingsDetailView
local function InitCardSkinPanel(self,data)
    local z_data = Z_Skin[data.tempId]
    local transform = self.item_panel.transform
    local avatar = transform:Find("Avatar/Value"):GetComponent("Image")
    local avatarBg = transform:Find("Avatar/Bg"):GetComponent("Image")
    self.item_DescTxt.text = string.gsub(LangUtil.GetSysLang(916), "XX", Z_Card[z_data.BelongCard].Name) 
    self.item_NameTxt.text = z_data.Name
    UIPublic.InitItemIcon(avatar, avatarBg, GoodsKind.CardSkin, z_data.BelongCard, {iconId = z_data.Stage})
end

---@param self UIThingsDetailView
local function InitItemPanel(self,data)
    local z_item = Z_Item[data.tempId]
    -- local transform = self.item_panel.transform
    -- if z_item.Type == 0 and not data.btn2Disable then -- 没看明白为什么会走到这里, btn2Disable为true就是抽卡送的星尘
    --     if z_item.UseType > 0 then
    --         LangUtil.BindText(self.itemBtn2.transform:Find("Text")).text = LangUtil.GetSysLang(891)
    --         self.itemBtn2:SetActive(true)
    --         UIUtil.AddBtnEventNoBug(self.itemBtn2, function()
    --             self.ctrl.CloseSelf()
    --             UIManager:GetInstance():OpenWindow(UIWindowNames.UIGeneralShop, {kind = z_item.UseType % 10000})
    --         end)
    --     end
    -- end

    self.item_DescTxt.text = z_item.Desc
    self.item_NameTxt.text = z_item.Name
    ---@type Item
    local item = Game.Scene.Player:GetComponent("ItemComponent"):GetItem(data.tempId)

    local count
    if item == nil then
        count = 0
    else
        count = item.Amount
    end
    self.item_CountText.text = ""
    self.item_AvaterBgImage.gameObject:SetActive(true)

    UIUtil.SetSprite(self.item_AvaterImage,AtlasConfig.Item,GetItemIcon(z_item))
    UIUtil.SetSprite(self.item_AvaterBgImage,AtlasConfig.ItemBg,z_item.IconBg)
end

---@param self UIThingsDetailView
local function InitFaithSkillPanel(self,data)
     local zFaithSkill = Z_FaithSkill[data.tempId]
    local transform = self.item_panel.transform
    local nameTxt = LangUtil.BindText(transform:Find("NameText"))
    local avatar = transform:Find("Avatar/Value"):GetComponent("Image")
    local itemDes = LangUtil.BindText(transform:Find("DescText"))
    local avatarBg = transform:Find("Avatar/Bg"):GetComponent("Image")
    nameTxt.text = zFaithSkill.Name
    itemDes.text = zFaithSkill.SkillDesc
    UIUtil.SetSprite(avatar,AtlasConfig.Faith,zFaithSkill.Id..".png")
    UIUtil.SetSprite(avatarBg,AtlasConfig.EquipBg,"def.png")
end

---@param self UIThingsDetailView
local function InitMonsterPanel(self, data)
    local monster = data.monster

    local MonsterAttribute = monster.MonsterAttribute
    local MonsterCardInfo = monster.MonsterCardInfo

    local transform = self.monster_panel.transform
    local skillCtrl = transform:Find("SKill")
    local numerical = transform:Find("Numerical/BackGround")
    self.monster_NameTxt.text= Z_Card[tonumber(string.sub(MonsterCardInfo.Id,1,4))].Name -- MonsterCardInfo.Name

    numerical:Find("HP"):Find("Text"):GetComponent("Text").text = LangUtil.GetSysLang(1220)
    numerical:Find("ATK"):Find("Text"):GetComponent("Text").text = LangUtil.GetSysLang(1221)
    numerical:Find("DEF"):Find("Text"):GetComponent("Text").text = LangUtil.GetSysLang(1222)
    numerical:Find("SPEED"):Find("Text"):GetComponent("Text").text = LangUtil.GetSysLang(1224)
    numerical:Find("MAGICDEF"):Find("Text"):GetComponent("Text").text = LangUtil.GetSysLang(1223)

    local hp_text = numerical:Find("HP"):Find("Value"):GetComponent("Text")
    local atk_text = numerical:Find("ATK"):Find("Value"):GetComponent("Text")
    local def_text = numerical:Find("DEF"):Find("Value"):GetComponent("Text")
    local speed_text = numerical:Find("SPEED"):Find("Value"):GetComponent("Text")
    local magic_def_text = numerical:Find("MAGICDEF"):Find("Value"):GetComponent("Text")

    hp_text.text = MonsterAttribute.Hp
    atk_text.text = MonsterAttribute.Atk
    def_text.text = MonsterAttribute.Def
    speed_text.text = MonsterAttribute.Speed
    magic_def_text.text = MonsterAttribute.MagicDef

    skillCtrl:Find("Attack").gameObject:SetActive(MonsterAttribute.GeneralAtk ~= nil and MonsterAttribute.GeneralAtk ~= 0)
    skillCtrl:Find("Skill1").gameObject:SetActive(MonsterAttribute.Skill1 ~= nil and MonsterAttribute.Skill1 ~= 0)
    skillCtrl:Find("Skill2").gameObject:SetActive(MonsterAttribute.Skill2 ~= nil and MonsterAttribute.Skill2 ~= 0)
    skillCtrl:Find("PassiveSkill").gameObject:SetActive(MonsterAttribute.PassiveSkill ~= nil and MonsterAttribute.PassiveSkill ~= 0)

    if MonsterAttribute.GeneralAtk ~= nil and MonsterAttribute.GeneralAtk ~= 0 then
        UIPublic.SetSkillIcon(skillCtrl:Find("Attack"), MonsterAttribute.GeneralAtk)
        local zSkill = Z_Skill[MonsterAttribute.GeneralAtk]
        local data = {
            title = "技能详情",
            subTitle = zSkill.Name,
            message = zSkill.SkillDesc,
            id = zSkill.Id,
            cd = zSkill.CooldownTurn,
            character = data.monster,
            params = zSkill.Params,
            skillType = 1,
        }

        UIUtil.AddBtnEventNoBug(skillCtrl:Find("Attack/Mask/Icon"),function(go)
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIDetail,data)
        end)
    end

    if MonsterAttribute.Skill1 ~= nil and MonsterAttribute.Skill1 ~= 0 then
        UIPublic.SetSkillIcon(skillCtrl:Find("Skill1"), MonsterAttribute.Skill1)
        local zSkill = Z_Skill[MonsterAttribute.Skill1]
        local data = {
            title = "技能详情",
            subTitle = zSkill.Name,
            message = zSkill.SkillDesc,
            id = zSkill.Id,
            cd = zSkill.CooldownTurn,
            character = data.monster,
            params = zSkill.Params,
            skillType = 2,
        }

        UIUtil.AddBtnEventNoBug(skillCtrl:Find("Skill1/Mask/Icon"),function(go)
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIDetail,data)
        end)
    end

    if MonsterAttribute.Skill2 ~= nil and MonsterAttribute.Skill2 ~= 0 then
        UIPublic.SetSkillIcon(skillCtrl:Find("Skill2"), MonsterAttribute.Skill2)
        local zSkill = Z_Skill[MonsterAttribute.Skill2]
        local data = {
            title = "技能详情",
            subTitle = zSkill.Name,
            message = zSkill.SkillDesc,
            id = zSkill.Id,
            cd = zSkill.CooldownTurn,
            character = data.monster,
            params = zSkill.Params,
            skillType = 3,
        }

        UIUtil.AddBtnEventNoBug(skillCtrl:Find("Skill2/Mask/Icon"),function(go)
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIDetail,data)
        end)
    end

    if MonsterAttribute.PassiveSkill ~= nil and MonsterAttribute.PassiveSkill ~= 0 then
        UIPublic.SetSkillIcon(skillCtrl:Find("PassiveSkill"), MonsterAttribute.PassiveSkill)
        local zSkill = Z_Skill[MonsterAttribute.PassiveSkill]
        local data = {
            title = "技能详情",
            subTitle = zSkill.Name,
            message = zSkill.SkillDesc,
            id = zSkill.Id,
            cd = zSkill.CooldownTurn,
            character = data.monster,
            params = zSkill.Params,
            skillType = 4,
        }

        UIUtil.AddBtnEventNoBug(skillCtrl:Find("PassiveSkill/Mask/Icon"),function(go)
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIDetail,data)
        end)
    end

    local cardInfo = transform:Find("CardInfo")
    
    UIPublic.InitSubProp(cardInfo:Find("SubProp"):GetComponent("Image"), MonsterAttribute.Prop)
    UIUtil.NewSetCardSprite(cardInfo:Find("Avatar"):GetComponent("Image"), MonsterAttribute.CardId, MonsterCardInfo.Id, CardPictureType.Middle)

    transform:Find("IsBoss").gameObject:SetActive(MonsterAttribute.IsBoss == 1) 
end

---@param self UIThingsDetailView
local function InitFightSoulPanel(self,data)
    local z_data = Z_FightSoul[data.tempId]
    self.label:SetActive(true)
    self.item_DescTxt.text = z_data.Desc
    self.item_NameTxt.text = z_data.Name
    self.item_CountText.text = ""
    UIPublic.InitItemIcon(self.item_AvaterImage, self.item_AvaterBgImage, GoodsKind.FightSoul, z_data.Id)
end

---@param self UIThingsDetailView
local function InitCurrencyPanel(self,data)
    local z_data = Z_Currency[data.Id]
    if data.Id == 7 then
        if not data.tempId then data.tempId = 1001 end
        z_data = Z_ActivityStory[data.tempId]
    end
    self.item_DescTxt.text = z_data.Desc
    self.item_NameTxt.text = z_data.Name
    UIPublic.InitItemIcon(self.item_AvaterImage, self.item_AvaterBgImage, UIPublic.GetCurrencyKind(data.Id), data.tempId)
end

---@param self UIThingsDetailView
local function OnLangCreate(self)
    stageConfig = {LangUtil.GetSysLang(150), LangUtil.GetSysLang(151), LangUtil.GetSysLang(152)}
    labConfig = {LangUtil.GetSysLang(141), LangUtil.GetSysLang(142),
                 LangUtil.GetSysLang(143), LangUtil.GetSysLang(144), LangUtil.GetSysLang(140)}
    
    self.item_DescTxt = LangUtil.BindText(self.langRc:GetObject("Item_DescText"))
    self.item_NameTxt = LangUtil.BindText(self.langRc:GetObject("Item_NameText"))
    self.item_CountText = LangUtil.BindText(self.langRc:GetObject("ItemCountText"))
    self.monster_NameTxt = LangUtil.BindText(self.langRc:GetObject("MonsterNameText"))
    
    UIPublic.CreateNumericalLang(self.langRc:GetObject("Monster_Numerical"))
    
    LangUtil.BindText(self.langRc:GetObject("CardTitleText")).text = LangUtil.GetSysLang(889)
    -- LangUtil.BindText(self.CardRight:Find("TipText")).text = LangUtil.GetSysLang(888)
    -- local cardBgTitle = self.CardRight:Find("Title").transform
    local titleStr = {LangUtil.GetSysLang(280), LangUtil.GetSysLang(664), LangUtil.GetSysLang(147)}
    -- for i = 0, cardBgTitle.childCount - 1 do
    --     LangUtil.BindText(cardBgTitle:GetChild(i):Find("Text")).text = titleStr[i + 1]
    -- end
    LangUtil.BindText(self.label.transform:Find("Text")).text = LangUtil.GetSysLang(259)

end

---@param self UIThingsDetailView
local function OnCreate(self)
    base.OnCreate(self)
    local rc = self.rc
    EventTriggerListener.Get(rc:GetObject("EventBg")).onLuaClick = self.ctrl.CloseSelf
    
    local close = rc:GetObject("CloseButton")
    self.label = rc:GetObject("label")
    
    --UIUtil.AddBtnEvent(close,function() self.ctrl.CloseSelf() end)
    
    self.item_panel = rc:GetObject( "Item")--物品界面
    self.monster_panel = rc:GetObject("Monster")--敌人界面
    self.card_panel = rc:GetObject("Card")--角色情报
    rc:GetObject("CardObject"):SetActive(true)
    
    self.item_AvaterImage = rc:GetObject("AvaterImage").transform:GetComponent("Image")
    self.item_AvaterBgImage = rc:GetObject("AvaterBgImage").transform:GetComponent("Image")
    self.item_scrollRect = rc:GetObject("ItemScrollRect").transform:GetComponent("ScrollRect")
    -- self.CardRight = self.card_panel.transform:Find("Right/Bg").transform
    -- self.cardSKillsObj = self.CardRight:Find("SKill").gameObject
    -- self.cardNumerical = self.card_panel.transform:Find("Left/Numerical")
    -- self.maxLvBtn = self.cardNumerical:Find("MaxLv")
    -- self.minLvBtn = self.cardNumerical:Find("MinLv")
    -- UIUtil.AddBtnEvent(self.minLvBtn, function() OnClickCardLevelBtn(self, 1) end)
    -- UIUtil.AddBtnEvent(self.maxLvBtn, function() OnClickCardLevelBtn(self, 100) end)
    -- UIUtil.AddBtnEvent(self.card_panel.transform:Find("CardClose"), function() self.ctrl.CloseSelf() end)

    self.CardSkillDetail = rc:GetObject("CardSkillDetail")
    self.CardSkillEventBg = rc:GetObject("CardSkillEventBg")
    self.CardDetailImg = self.CardSkillDetail.transform:Find("Panel/SkillCell/Icon"):GetComponent("Image")
    local closeSkillDetail = function()
        self.CardSkillDetail:SetActive(false)
        self.CardSkillEventBg:SetActive(false)
    end
    closeSkillDetail()
    UIUtil.AddBtnEvent(self.CardSkillEventBg, closeSkillDetail)
end

---@param self UIThingsDetailView
local function OnEnable(self)
    base.OnEnable(self)
    coroutine.start(function()
        self.gameObject:SetActive(false)
        self:OnRefresh()
        self.gameObject:SetActive(true)
    end)
end

---@param self UIThingsDetailView
local function OnRefresh(self)
    self.item_scrollRect.verticalScrollbar.value = 1

    self.label:SetActive(false)
    local panel_tab = {[ShowType.Card] = self.item_panel,[ShowType.Equip] = self.item_panel,[ShowType.Item] = self.item_panel,[4] = self.monster_panel,
                       [ShowType.FightSoul] = self.item_panel,[6] = self.item_panel , [7] = self.item_panel, [8] = self.item_panel}
    for k,v in table.pairsByKeys({
        self.card_panel,
        self.item_panel,
        self.monster_panel
    }) do
        v:SetActive(false)
    end
    local func_init_tab = {[1] = InitCardPanel,[2] = InitEquipPanel,[ShowType.Item] = InitItemPanel,[4] = InitMonsterPanel,
                           [5] = InitFightSoulPanel,[6] = InitCurrencyPanel, [7] = InitFaithSkillPanel, [8] = InitCardSkinPanel}
    panel_tab[self.model.data.showType]:SetActive(true)
    func_init_tab[self.model.data.showType](self,self.model.data)
end

local function OnAddListener(self)
    base.OnAddListener(self)
end

local function OnRemoveListener(self)
    base.OnRemoveListener(self)
end

---@param self UIThingsDetailView
local function OnDisable(self)
    if self.temp_battle_component then -- 临时的战斗组件
        Game.Scene:RemoveComponent("BattleComponent")
    end
    if not IsNull(self.CardInfoObj) then
        self.CardInfoObj.transform:Find("Avatar"):GetComponent("Image").sprite = DeActiveSprite
    end
    if not IsNull(self.cardItem) then
        self.cardItem.transform:Find("Avatar"):GetComponent("Image").sprite = DeActiveSprite
    end
end

local function OnDestroy(self)
    base.OnDestroy(self)
end



UIThingsDetailView.OnCreate = OnCreate
UIThingsDetailView.OnEnable = OnEnable
UIThingsDetailView.OnRefresh = OnRefresh
UIThingsDetailView.OnAddListener = OnAddListener
UIThingsDetailView.OnRemoveListener = OnRemoveListener
UIThingsDetailView.OnDisable= OnDisable
UIThingsDetailView.OnDestroy = OnDestroy
UIThingsDetailView.OnLangCreate = OnLangCreate

return UIThingsDetailView