--
-- <代码文件解释说明>
--

---@class View : UIBaseView
---@field model Model
---@field ctrl Ctrl
local UIBattleStatusView = BaseClass("UIBattleStatusView",UIBaseView)
local base = UIBaseView
local this = UIBattleStatusView

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
end

function this:OnCreate()
    base.OnCreate(self)
    UIUtil.AddBtnEvent(self.rc:GetObject("EventBg"), function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattleStatus)
    end)

    local battleComponent = Game.Scene:GetComponent("BattleComponent")
    self.scroll = VerticalScroll.New()
    self.scroll:SetUpdateCount(4)
    self.scrollView = self.rc:GetObject("ScrollView")

    self.scroll:Clear()


    self.scroll:ScrollInit({}, self.scrollView, "BattleStatusItem", function (arg)
        self:InitItemData(arg)
    end)

end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    self.noteText = LangUtil.BindText(self.langRc:GetObject("NoteText"))
    self.noteText.text = LangUtil.GetSysLang(1247)

    local battleComponent = Game.Scene:GetComponent("BattleComponent")

    local actUnit = self.rc:GetObject("ActUnit")
    local actUnitItem = actUnit.transform:GetChild("BattleStatusItem")
    local actUnitArg = {}
    actUnitArg.go = actUnitItem
    actUnitArg.data = battleComponent.CurActUnit
    self:InitItemData(actUnitArg)
    
    local units = {}
    for _, unit in pairs(battleComponent.IdUnits) do 
        if unit.UID ~= battleComponent.CurActUnit.UID and not unit:GetComponent("CharacterComponent").IsDead then
            table.insert(units, unit)
        end
    end
    table.sort(units, function (a, b)
        return a:GetComponent("BattleUnitComponent").ActValue < b:GetComponent("BattleUnitComponent").ActValue
    end)
    self.scroll:RefreshData(units)
end

function this:InitItemData(arg)
    local battleComponent = Game.Scene:GetComponent("BattleComponent")
    local unit = arg.data
    local battleUnitComponent = unit:GetComponent("BattleUnitComponent")
    local transform = arg.go.transform
    local rc = transform:GetComponent("ReferenceCollector")

    local avatar = rc:GetObject("Avatar"):GetComponent("Image")
    local playerAvatarFrame = rc:GetObject("PlayerAvatarFrame")
    local enemyAvatarFrame = rc:GetObject("EnemyAvatarFrame")
    local playerHp = rc:GetObject("PlayerHp")
    local enemyHp = rc:GetObject("EnemyHp")
    local skillLayout = rc:GetObject("SkillLayout")
    local buffLayout = rc:GetObject("BuffLayout")

    playerHp:SetActive(unit.IsPlayer)
    enemyHp:SetActive(not unit.IsPlayer)    

    local hp
    if unit.IsPlayer then
        hp = playerHp:GetComponent("Image")
    else
        hp = enemyHp:GetComponent("Image")
    end


    local raceText = rc:GetObject("RaceText"):GetComponent("Text")

    local skillItem = rc:GetObject("SkillItem")
    skillItem:SetActive(false)
    local buffItem = rc:GetObject("BuffItem")
    buffItem:SetActive(false)

    local figureAssetConfig = battleUnitComponent.FigureAssetConfig
    avatar.sprite = AtlasManager:GetInstance():CoLoadImageAsync(PathUtil.Path_UIAtlasCardLittle..figureAssetConfig.SrAvatar..".png")
    playerAvatarFrame:SetActive(unit.IsPlayer)
    enemyAvatarFrame:SetActive(not unit.IsPlayer)

    raceText.text = math.floor(battleUnitComponent.ActValue * 100 / BATTLE_ACT_VALUE_MAX) .. '%'
    if unit.UID == battleComponent.CurActUnit.UID then
        raceText.text = "100%"
    end

    local numericComponent = unit:GetComponent("NumericComponent")
    local hpProportion = numericComponent:Get(NumericType.Hp) / numericComponent:Get(NumericType.MaxHp)
    hp.fillAmount = hpProportion

    local skillComponent = unit:GetComponent("SkillComponent")
    local activeSkills = skillComponent.ActiveSkills
    local atk = skillLayout.transform:GetChild(0).gameObject
    local skill = skillLayout.transform:GetChild(1).gameObject
    local ultimate = skillLayout.transform:GetChild(2).gameObject

    -- local skill = GameObject.Instantiate(skillItem)
    -- skill.transform:SetParent(skillLayout.transform, false)
    -- local ultimate = GameObject.Instantiate(skillItem)
    -- ultimate.transform:SetParent(skillLayout.transform, false)
    atk:SetActive(true)
    skill:SetActive(true)    
    ultimate:SetActive(true)
    self:SetSkillItem(atk, unit, activeSkills[skillComponent.GeneralAtkId])
    self:SetSkillItem(skill, unit, activeSkills[skillComponent.Skill1Id])
    self:SetSkillItem(ultimate, unit, activeSkills[skillComponent.Skill2Id])

    local buffComponent = unit:GetComponent("BuffComponent")
    for i, buff in ipairs(buffComponent.buffs) do
        buffItem = buffLayout.transform:GetChild(i).gameObject
        buffItem.transform:SetParent(buffLayout.transform, false)
        buffItem:SetActive(true)
        self:SetBuffItem(buffItem, unit, buff, buffComponent.buffs)
    end
    for i = #buffComponent.buffs + 1, 12 do
        buffItem = buffLayout.transform:GetChild(i).gameObject
        buffItem:SetActive(false)
    end
end

function this:SetSkillItem(go, unit, skill)
    if skill == nil then
        go:SetActive(false)
        return
    end
    go:SetActive(true)
    local rc = go.transform:GetComponent("ReferenceCollector")
    -- local playerFrame = rc:GetObject("PlayerFrame")
    -- local enemyFrame = rc:GetObject("EnemyFrame")
    local skillIcon = rc:GetObject("Icon"):GetComponent("Image")
    local mask = rc:GetObject("Mask")
    local cdText = rc:GetObject("CDText")
    local cdTextComponent = cdText:GetComponent("Text")
    UIUtil.SetSprite(skillIcon, AtlasConfig.SkillIcon, skill.ZSkill.SkillIcon)
    if skill.LeftCooldownTurn > 0 then
        cdTextComponent.text = skill.LeftCooldownTurn
        mask:SetActive(true)
        cdText:SetActive(true)
    else
        mask:SetActive(false)
        cdText:SetActive(false)
    end
end

function this:SetBuffItem(go, unit, buff, buffList)
    local zBuff = Z_Buff[buff.BuffId]
    local rc = go.transform:GetComponent("ReferenceCollector")
    local buffIcon = rc:GetObject("Icon"):GetComponent("Image")
    local leftTurn = rc:GetObject("LeftTurn"):GetComponent("Text")
    local mask = rc:GetObject("Mask")
    buffIcon.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Atlas/LittleBuff/"..zBuff.LittleIcon..".png")
    leftTurn.text = buff.LeftTurn

    UIUtil.AddBtnEvent(go, function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipBuffDetail, buffList)
    end)
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
    self.scroll:Dispose()
end

return this
