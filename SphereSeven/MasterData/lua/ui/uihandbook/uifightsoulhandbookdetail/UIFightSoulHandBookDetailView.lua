---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/7/1 16:21
---
---@class UIFightSoulHandBookDetailView
---@field model UIFightSoulHandBookDetailModel
local UIFightSoulHandBookDetailView = BaseClass("UIFightSoulHandBookDetailView",UIBaseView)
local base = UIBaseView;
local this = UIFightSoulHandBookDetailView;
local isBusying = false

local showPropertySort = {
    [1] = NumericType.Hp,
    [2] = NumericType.Atk,
    [3] = NumericType.Def,
    [4] = NumericType.MagicDef,
}

local FIGHT_SOUL_MERGE_COUNT_LIMIT = tonumber(Z_Misc["FIGHT_SOUL_MERGE_COUNT_LIMIT"].Value[1])

local screeY = 1080
local defPox = Vector2.New(423,-37)
local delayTime = 0.3

local function PlayState1(self)
    self.fightSoulFace.transform:SetParent(self.minRoot.transform)
    self.animBg:GetComponent("Image"):DOFade(0,delayTime).onComplete = function() self.animBg:SetActive(false) end
    self.fightSoulFace:GetComponent("RectTransform"):DOLocalMove(defPox,delayTime).onComplete = function()
        isBusying = false
    end
    self.fightSoulFace.transform:DOScale(Vector2.New(1,1),delayTime)
    self.fightSoulFace.transform:DORotate(Vector3.New(0,0,0),delayTime)
    table.csenuObject(self.fightSoulFace.transform,function(v)
        if v.name ~= "Face" and v.name ~= "Mask" then
            local txt = v:GetComponent("Text")
            local img = v:GetComponent("Image")
            if txt  then txt:DOFade(1,delayTime-0.2) end
            if img then img:DOFade(1,delayTime-0.2) end
        end
    end)
end


local function PlayState2(self)
    local scale = screeY/self.width
    self.fightSoulFace.transform:SetParent(self.maxRoot.transform)
    self.fightSoulFace:GetComponent("RectTransform"):DOLocalMove(Vector2.New(0,0),delayTime).onComplete = function()
        self.animBg:SetActive(true)
        self.animBg:GetComponent("Image"):DOFade(1,delayTime)
        isBusying = false
    end
    self.fightSoulFace.transform:DOScale(Vector2.New(scale,scale),delayTime)
    self.fightSoulFace.transform:DORotate(Vector3.New(0,0,90),delayTime)
end

local function PlayState3(self)
    isBusying = true
    table.csenuObject(self.fightSoulFace.transform,function(v)
        if v.name ~= "Face" and v.name ~= "Mask" then
            local txt = v:GetComponent("Text")
            local img = v:GetComponent("Image")
            if txt  then txt:DOFade(0,delayTime) end
            if img then img:DOFade(0,delayTime) end
        end
    end)
    coroutine.start(function()
        coroutine.waitforseconds(delayTime)
        isBusying = false
    end)

end

---@param self UIFightSoulHandBookDetailView
local function OnLevelButton(self, isMax)
    if isMax then
        self.level = Game.Scene.Player:GetComponent("FightSoulComponent"):GetMaxLevelByStar(FIGHT_SOUL_MERGE_COUNT_LIMIT)
    else
        self.level = 1
    end
    self.levelIsMax = isMax
    self.levelMask:SetActive(isMax)
    self.levelMaxMask:SetActive(not isMax)
    for k, v in pairs(self.propertyList) do
        local value = UIPublic.GetFightSoulProperty(self.zFightSoul.Id, self.level, v.property)
        v.value.text = value
    end
end

---@param self UIFightSoulHandBookDetailView
local function OnStarButton(self, isMax)
    if isMax then
        self.star = FIGHT_SOUL_MERGE_COUNT_LIMIT
    else
        self.star = 1
    end
    self.starIsMax = isMax
    self.starMask:SetActive(isMax)
    self.starMaxMask:SetActive(not isMax)
    self.desc.text = UIPublic.GetFightSoulEffectText(self.model.isOnCidList[self.model.index], self.star)
end

local function OnClickFightSoulFace(self)
    if isBusying == false then
        isBusying =  true
        if self.state == 1 then
            PlayState2(self)
            self.state = 2
        elseif self.state == 2 then
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIOriginalPainting,
                    {
                        state = 1,
                        image = self.image,
                        scale = self.fightSoulFace.transform.localScale.x,
                        cardOffset = self.fightSoulFace.transform:Find("Mask/Face").localPosition,
                        scaleRot =  screeY/self.height,
                        callBack = function()
                             PlayState1(self)
                             self.state = 1
                         end
                    })
            PlayState3(self)
            self.state = 3
        elseif self.state == 3 then

        end
    end
end

local function InitProp(self)
    local transform = self.prop.transform
    local rareImg = transform:Find("Info/Rare/Value"):GetComponent("Image")
    -- local hunImg = transform:Find("Hun/Value"):GetComponent("Image")
    local classImage = transform:Find("Info/Class/Value"):GetComponent("Image")
    local class = UIPublic.GetFightSoulClass(self.zFightSoul.ClassLimit)
    rareImg.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Common/Raility/"..UIPublic.RareNames[self.zFightSoul.Rare]..".png")
    -- UIUtil.SetSprite(hunImg,AtlasConfig.FightSoulSub,self.zFightSoul.Id..".png")
    UIUtil.SetSprite(classImage, AtlasConfig.Class, class.. "_" .. self.zFightSoul.Rare ..  ".png")
    UIPublic.InitEncyclopediaDetail(
        self.collection,
        self.zFightSoul.Id,
        RecordType.FightSoul
    )

    self.collectionMask:SetActive(false)
end

local function InitFightSoulFace(self)
    self.mask.gameObject:SetActive(false)
    -- self.mask:GetComponent("Image"):DOFade(1,0)
    local fightSoul = {
        TemplateId = self.zFightSoul.Id,
        Star = nil,
        Id = -1,
        isEquip = false,
        config = self.zFightSoul
    }

    UIPublic.InitFightSoulFace(fightSoul, self.fightSoulFace.transform, true)
end

function this:ChangeFightSoul(offset)
    if self.model.index + offset <= 0 or self.model.index + offset > #self.model.isOnCidList then
        return
    end
    self.model.index = self.model.index + offset
    self:OnRefresh()
end

function this:OnLangCreate()
    local prop = self.langRc:GetObject("Prop").transform
    self.desc = LangUtil.BindText(self.langRc:GetObject("Desc"))

    LangUtil.BindText(prop:Find("Info/Rare/Text")).text = LangUtil.GetSysLang(166)
    LangUtil.BindText(prop:Find("Info/Class/Text")).text = LangUtil.GetSysLang(1182)
    LangUtil.GetSpriteLang(470, function(sprite) prop:Find("Title"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(471, function(sprite) self.langRc:GetObject("CollectionTitle"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(472, function(sprite) self.langRc:GetObject("EquipEffectTitle"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(478, function(sprite) self.langRc:GetObject("PropertyTitle"):GetComponent("Image").sprite = sprite end)

    LangUtil.BindText(self.levelButton.transform:Find("Text")).text = "LV.1"
    LangUtil.BindText(self.levelMaxButton.transform:Find("Text")).text = "LV." .. Game.Scene.Player:GetComponent("FightSoulComponent"):GetMaxLevelByStar(FIGHT_SOUL_MERGE_COUNT_LIMIT)

    LangUtil.BindText(self.starButton.transform:Find("Text")).text = LangUtil.GetSysLang(1279)
    LangUtil.BindText(self.starMaxButton.transform:Find("Text")).text = LangUtil.GetSysLang(1280)

    for key, value in ipairs(self.propertyList) do
        self.propertyList[key].text = LangUtil.BindText(value.text)
        self.propertyList[key].value = LangUtil.BindText(value.value, FontType.All_Number)
    end
end

function this:OnCreate()
    base.OnCreate(self);
    self.mask= self.rc:GetObject("Mask")
    self.fightSoulFace = self.rc:GetObject("UIFightSoulCardInfo")
    self.image = self.fightSoulFace.transform:Find("Mask/Face"):GetComponent("Image")
    self.prop = self.rc:GetObject("Prop")

    self.maxRoot = self.rc:GetObject("MaxRoot")
    self.animBg = self.rc:GetObject("AnimBg")
    self.minRoot = self.rc:GetObject("Left")

    self.collection = self.rc:GetObject("Collection").transform
    self.collectionMask = self.rc:GetObject("CollectionMask")

    self.width = self.fightSoulFace:GetComponent("RectTransform").rect.width
    self.height = self.fightSoulFace:GetComponent("RectTransform").rect.height
    EventTriggerListener.Get(self.fightSoulFace).onLuaClick = function() OnClickFightSoulFace(self) end

    local backBtn = self.rc:GetObject("BackButton")
    UIPublic.SetBackButton(
        backBtn,
        UIWindowNames.UIFightSoulHandBookDetail,
        423
    )

    self.numerical = self.rc:GetObject("Numerical").transform
    self.propertyList = {}
    for index, value in ipairs(showPropertySort) do
        self.propertyList[index] = {}
        self.propertyList[index].property = value
        local numericalChild = self.numerical:GetChild(index - 1)
        self.propertyList[index].text = numericalChild:Find("Text"):GetComponent("Text")
        self.propertyList[index].value = numericalChild:Find("Value"):GetComponent("Text")
    end

    self.levelIsMax = false
    self.starIsMax = false
    self.levelButton = self.rc:GetObject("LevelButton")
    self.levelMask = self.levelButton.transform:Find("Mask").gameObject
    self.levelMaxButton = self.rc:GetObject("LevelMaxButton")
    self.levelMaxMask = self.levelMaxButton.transform:Find("Mask").gameObject
    self.starButton = self.rc:GetObject("StarButton")
    self.starMask = self.starButton.transform:Find("Mask").gameObject
    self.starMaxButton = self.rc:GetObject("StarMaxButton")
    self.starMaxMask = self.starMaxButton.transform:Find("Mask").gameObject
    
    UIUtil.AddBtnEvent(self.levelButton,function()
       OnLevelButton(self, false)
    end)
    UIUtil.AddBtnEvent(self.levelMaxButton,function()
        OnLevelButton(self, true)
     end)
     
    UIUtil.AddBtnEvent(self.starButton,function()
        OnStarButton(self, false)
    end)
    UIUtil.AddBtnEvent(self.starMaxButton,function()
        OnStarButton(self, true)
    end)


    self.lastButton = self.rc:GetObject("LastButton")
    self.nextButton = self.rc:GetObject("NextButton")
    UIUtil.AddBtnEvent(self.lastButton,function()
        self:ChangeFightSoul(-1)
    end)
    UIUtil.AddBtnEvent(self.nextButton,function()
        self:ChangeFightSoul(1)
    end)
end

function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh();
end

function this:OnRefresh()
    self.state = 1
    self.zFightSoul = Z_FightSoul[self.model.isOnCidList[self.model.index]]

    self.lastButton:SetActive(self.model.index ~= 1)
    self.nextButton:SetActive(self.model.index ~= #self.model.isOnCidList)

    coroutine.start(function()
        InitProp(self)
        InitFightSoulFace(self)
    end)

    OnLevelButton(self)
    OnStarButton(self)
end

function this.OnDisable(self)
    base.OnDisable(self);
end

return this;