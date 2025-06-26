local this = require("GameLogic.Battle.UI.UIBuffGlances.UIBuffGlancesView")

local buffPf = PathUtil.Path_UIBattleCommonBuffGlancePrefab.."Buff.prefab"

function this.OnPlayerInfoCreate(self)
    local rc = self.battlePlayerInfo:GetComponent("ReferenceCollector")
    EventTriggerListener.Get(rc:GetObject("EventBg2")).onLuaClick = function() self.battlePlayerInfo:SetActive(false) end
   
    self.dataContent = rc:GetObject("DataContent").transform
    LangUtil.BindText(self.dataContent:Find("5/Name")).text = LangUtil.GetSysLang(3040)
    LangUtil.BindText(self.dataContent:Find("6/Name")).text = LangUtil.GetSysLang(3041)
    LangUtil.BindText(self.dataContent:Find("7/Name")).text = LangUtil.GetSysLang(3042)
    LangUtil.BindText(self.dataContent:Find("8/Name")).text = LangUtil.GetSysLang(3043)
    LangUtil.BindText(self.dataContent:Find("9/Name")).text = LangUtil.GetSysLang(3044)
    LangUtil.BindText(self.dataContent:Find("10/Name")).text = LangUtil.GetSysLang(3045)
    LangUtil.BindText(self.dataContent:Find("11/Name")).text = LangUtil.GetSysLang(3046)
    LangUtil.BindText(self.dataContent:Find("12/Name")).text = LangUtil.GetSysLang(3047)
    LangUtil.BindText(self.dataContent:Find("13/Name")).text = LangUtil.GetSysLang(3048)

    local numerical = rc:GetObject("Numerical").transform
    self.hpTxt = LangUtil.BindText(numerical:Find("HP/Value"),"Number")
    self.atkTxt = LangUtil.BindText(numerical:Find("ATK/Value"),"Number")
    self.speedTxt = LangUtil.BindText(numerical:Find("SPEED/Value"),"Number")
    self.defTxt = LangUtil.BindText(numerical:Find("DEF/Value"),"Number")
    LangUtil.BindText(numerical:Find("HP/Text"))
    LangUtil.BindText(numerical:Find("ATK/Text"))
    LangUtil.BindText(numerical:Find("SPEED/Text"))
    LangUtil.BindText(numerical:Find("DEF/Text"))
    
    local dataRc = self.dataContent:GetComponent("ReferenceCollector")
    self.hitTxt = LangUtil.BindText(dataRc:GetObject("Hit"), FontType.All_Number)
    self.pryTxt = LangUtil.BindText(dataRc:GetObject("Pry"), FontType.All_Number)
    self.cacTxt = LangUtil.BindText(dataRc:GetObject("Cac"), FontType.All_Number)
    self.accTxt = LangUtil.BindText(dataRc:GetObject("Acc"), FontType.All_Number)
    self.stmTxt = LangUtil.BindText(dataRc:GetObject("Stm"), FontType.All_Number)
    self.criTxt = LangUtil.BindText(dataRc:GetObject("Cri"), FontType.All_Number)
    self.criDmgTxt = LangUtil.BindText(dataRc:GetObject("CriDamage"), FontType.All_Number)
    self.antiCriTxt = LangUtil.BindText(dataRc:GetObject("AntiCri"), FontType.All_Number)
    self.finalDmgTxt = LangUtil.BindText(dataRc:GetObject("FinalDamage"), FontType.All_Number)

    self.cardInfo = rc:GetObject("CardInfo").transform
    self.skillRoot = rc:GetObject("SKill").transform
    self.buffContent = rc:GetObject("BuffContent").transform
    self.closeBtn = rc:GetObject("CloseBtn")
    UIUtil.AddBtnEvent(self.closeBtn, function(go) self.battlePlayerInfo:SetActive(false) end)
    
    self.listener = Bind(self, self.OnValueChanged)
end

function this.OpenPlayerInfo(self, cardInfo, u, data)
    self:UpdatePlayerBuff(u)
    self.numeric_component = u:GetComponent("NumericComponent")
    self:InitNumerical()
    self.numeric_component:RemoveListener(self.listener)
    self.numeric_component:AddListener(self.listener)
    coroutine.start(function ()
        UIPublic.InitCardItemDataNew(cardInfo, self.cardInfo)
        self.battlePlayerInfo:SetActive(true)
        UIPublic.InitSkillArea(self.skillRoot.gameObject, cardInfo, data.left,{default = 1})
    end)
end

local function GetNumeric(self, numericType, numText)
    local final = math.modf(numericType)
    local bas = math.modf(final * 10 + 1)
    
    local basNum =  math.modf(self.numeric_component:Get(bas))
    local finalNum = math.modf(self.numeric_component:Get(numericType))
    
    if NumericType.FinalDamage == numericType then
        finalNum = math.modf(finalNum / 100 - 1)
        basNum = math.modf(finalNum / 100)
    end

    return finalNum
end


function this.OnValueChanged(self, type)
    if self.numeric_component == nil then
        return
    end

    if type == NumericType.Hp or type == NumericType.MaxHp then
        self.hpTxt.text = math.modf(self.numeric_component:Get(NumericType.Hp)).."/"..math.modf(GetNumeric(self,NumericType.MaxHp,self.hpTxt))
    end
    if type == NumericType.Atk then
        self.atkTxt.text = GetNumeric(self,NumericType.Atk,self.atkTxt)
    end
    if type == NumericType.Def then
        self.defTxt.text = GetNumeric(self,NumericType.Def,self.defTxt)
    end
    if type == NumericType.Speed then
        self.speedTxt.text = GetNumeric(self,NumericType.Speed,self.speedTxt)
    end
    if type == NumericType.Hit then
        self.hitTxt.text = GetNumeric(self,NumericType.Hit,self.hitTxt)
    end
    if type == NumericType.Pry then
        self.pryTxt.text = GetNumeric(self,NumericType.Pry,self.pryTxt)
    end
    if type == NumericType.Cac then
        self.cacTxt.text = GetNumeric(self,NumericType.Cac,self.cacTxt)
    end
    if type == NumericType.Acc then
        self.accTxt.text = GetNumeric(self,NumericType.Acc,self.accTxt)
    end
    if type == NumericType.Stm then
        self.stmTxt.text = GetNumeric(self,NumericType.Stm,self.stmTxt)
    end
    if type == NumericType.Cri then
        self.criTxt.text = GetNumeric(self,NumericType.Cri,self.criTxt)
    end
    if type == NumericType.CriDamage then
        self.criDmgTxt.text = (GetNumeric(self,NumericType.CriDamage,self.criDmgTxt)) .."%"
    end
    if type == NumericType.AntiCri then
        self.antiCriTxt.text = (GetNumeric(self,NumericType.AntiCri,self.antiCriTxt)) .."%"
    end
    if type == NumericType.FinalDamage then
        self.finalDmgTxt.text = GetNumeric(self,NumericType.FinalDamage,self.finalDmgTxt) .."%"
    end
end

function this.InitNumerical(self)
    self:OnValueChanged(NumericType.Hp)
    --self:OnValueChanged(NumericType.MaxHp)
    self:OnValueChanged(NumericType.Atk)
    self:OnValueChanged(NumericType.Def)
    self:OnValueChanged(NumericType.Speed)
    self:OnValueChanged(NumericType.Hit)
    self:OnValueChanged(NumericType.Pry)
    self:OnValueChanged(NumericType.Cac)
    self:OnValueChanged(NumericType.Acc)
    self:OnValueChanged(NumericType.Stm)
    self:OnValueChanged(NumericType.Cri)
    self:OnValueChanged(NumericType.CriDamage)
    self:OnValueChanged(NumericType.AntiCri)
    self:OnValueChanged(NumericType.FinalDamage)
end

function this.UpdatePlayerBuff(self, u)
    coroutine.start(function ()
        if self.playerBuffs == nil then
            self.playerBuffs = {}
        end
        local buffs = u:GetComponent("BuffComponent"):GetBuffs()
        table.walk(self.playerBuffs, function (k, v)
            v:SetActive(false)
        end)
        for i = 1, #buffs do
            local zBuff = Z_Buff[buffs[i].Id]
            local buff
            if self.playerBuffs[i] ~= nil then
                buff = self.playerBuffs[i]
            else
                buff = GameObjectPool:GetInstance():CoGetGameObjectAsync(buffPf)
                buff.transform:SetParent(self.buffContent, false)
            end
            for index = 0, buff.transform.childCount - 1 do
                buff.transform:GetChild(index).gameObject:SetActive(false)
            end
            local img = buff:GetComponent("Image")
            img.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Atlas/Buff_"..LangUtil.GetLangType().."/"..zBuff.Icon..".png")
            img:SetNativeSize()
            self.playerBuffs[i] = buff
            buff:SetActive(true)
        end
    end)
end

return this
