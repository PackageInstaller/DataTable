--
-- <代码文件解释说明>
--

---@class UIFormationChooseSupportView : UIBaseView
---@field model UIFormationChooseSupportModel
---@field ctrl UIFormationChooseSupportCtrl
local UIFormationChooseSupportView = BaseClass("UIFormationChooseSupportView",UIBaseView)
local base = UIBaseView
local this = UIFormationChooseSupportView

local PrefabName = "FormationChooseSupportItem"

local recordOrder = {order = 1,kind = 1}  --是否正序  顺序类型(暂时没用)

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    LangUtil.BindText(self.langRc:GetObject("RefreshText")).text = LangUtil.GetSysLang(326) -- 刷新
    self.sortText = LangUtil.BindText(self.langRc:GetObject("SortText"))
end

function this:OnCreate()
    base.OnCreate(self)
    ---@type TeamComponent
    self.teamComponent = Game.Scene.Player:GetComponent("TeamComponent")

    self.scrollView = self.rc:GetObject("Scroll View"):GetComponent("ScrollRect")
    self.refreshButton = self.rc:GetObject("RefreshButton")
    self.sortButton = self.rc:GetObject("SortButton")

    UIUtil.AddBtnEventNoBug(self.refreshButton, function()
        self.ctrl:ReqSupportList()
    end)

    UIUtil.AddBtnEventNoBug(self.sortButton, function()
        recordOrder.order = (recordOrder.order == 1 and {2} or {1} )[1]
        self.sortText.text = (recordOrder.order == 1 and {LangUtil.GetSysLang(154)} or {LangUtil.GetSysLang(153)})[1]
        self:RefreshContent()
    end)

    UIPublic.SetBackButton(
        self.rc:GetObject("ReturnButton"),
        UIWindowNames.UIFormationChooseSupport,
        564
    )


    self.supportList = {}
    self.scroll = VerticalScroll.New()

    self:RefreshContent()
end

function this:OnEnable()
    base.OnEnable(self)
    self.sortText.text = (recordOrder.order == 1 and {LangUtil.GetSysLang(154)} or {LangUtil.GetSysLang(153)})[1]

    self:OnRefresh()
end

function this:OnRefresh()
    self.supportList = self.ctrl:GetSupportList()
    if self.supportList == nil then
        self.ctrl:ReqSupportList()
    else
        self:RefreshContent()
    end
end

function this:RefreshContent()
    local showList
    if recordOrder.order ~= 1 then
        showList = table.reverseTable(self.supportList)
    else
        showList = self.supportList
    end
    self.scroll:Clear()
    ---@param arg {go:UnityEngine.GameObject, data:SocietyRole}
    self.scroll:ScrollInit(showList, self.scrollView, PrefabName, function (arg)
        local rc = arg.go:GetComponent("ReferenceCollector")
        local bgImage = rc:GetObject("BgImage")
        -- 玩家信息
        local avatar = rc:GetObject("Avatar"):GetComponent("Image")
        if arg.data.info ~= nil and arg.data.info.avatar ~= nil and Z_FigureAsset[arg.data.info.avatar] ~= nil then
            local avatarStr = Z_FigureAsset[arg.data.info.avatar].CardAvatar
            UIUtil.SetPlayerIcon(avatar, avatarStr)
        end
        local idText = LangUtil.BindText(rc:GetObject("IDText"), FontType.All_Number)
        idText.text = arg.data.info.roleId
        local name = LangUtil.BindText(rc:GetObject("Name"))
        name.text = arg.data.info.username
        local level = LangUtil.BindText(rc:GetObject("LevelText"), FontType.All_Number)
        level.text = arg.data.info.level

        local cardItem = rc:GetObject("CardItem")
        local fightSoulItem = rc:GetObject("FightSoulItem")
        local noFightSoulImage = rc:GetObject("NoFightSoulImage"):GetComponent("Image")
        if arg.data.supportUnits.cardData ~= nil then
            UIPublic.InitCardItemLittle(
                arg.data.supportUnits.cardData,
                cardItem
            )
        end

        if arg.data.supportUnits.fightSoulEntity ~= nil then
            UIPublic.InitVsFightSoulItemMId(
                arg.data.supportUnits.fightSoulEntity,
                fightSoulItem,
                nil,
                true
            )
            fightSoulItem:SetActive(true)
        else
            fightSoulItem:SetActive(false)
        end
        UIUtil.AddBtnEvent(cardItem, function()
            UIManager:GetInstance():OpenWindow(UIWindowNames.UISupportCard, {
                battleUnit = arg.data.supportUnits,
            })
        end)
        UIUtil.AddBtnEvent(fightSoulItem, function()
            UIManager:GetInstance():OpenWindow(UIWindowNames.UISupportCard, {
                battleUnit = arg.data.supportUnits,
            })
        end)
        UIUtil.AddBtnEvent(noFightSoulImage, function()
            UIManager:GetInstance():OpenWindow(UIWindowNames.UISupportCard, {
                battleUnit = arg.data.supportUnits,
            })
        end)

        LangUtil.GetSpriteLang(459, function(sprite) noFightSoulImage:GetComponent("Image").sprite = sprite end)

        -- 按钮
        local UnloadButton = rc:GetObject("UnloadButton")
        LangUtil.BindText(rc:GetObject("UnloadButtonText")).text = LangUtil.GetSysLang(1216)
        local ChooseButton = rc:GetObject("ChooseButton")
        LangUtil.BindText(rc:GetObject("ChooseButtonText")).text = LangUtil.GetSysLang(2049)
        if self.model.role ~= nil and self.model.role.info.roleId == arg.data.info.roleId then
            UnloadButton:SetActive(true)
            ChooseButton:SetActive(false)
            LangUtil.GetSpriteLang(460, function(sprite) bgImage:GetComponent("Image").sprite = sprite end)
        else
            UnloadButton:SetActive(false)
            ChooseButton:SetActive(true)
            LangUtil.GetSpriteLang(461, function(sprite) bgImage:GetComponent("Image").sprite = sprite end)
        end
        UIUtil.AddBtnEventNoBug(UnloadButton, function()
            self.model.callBack(nil)
            self.ctrl:CloseSelf()
        end)

        UIUtil.AddBtnEventNoBug(ChooseButton, function()
            self.model.callBack(arg.data)
            self.ctrl:CloseSelf()
        end)

    end)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_SUPPORT_CHG, this.OnRefresh)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_SUPPORT_CHG)
end


function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
    self.scroll:Dispose()
end

return this
