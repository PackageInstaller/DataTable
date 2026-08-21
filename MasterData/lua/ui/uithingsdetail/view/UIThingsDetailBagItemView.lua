
---@class UIThingsDetailBagItemView
---@field label UnityEngine.GameObject @ icon下 标题图标(目测表示item类型用的)
local UIThingsDetailBagItemView = BaseClass("UIThingsDetailBagItemView",UIBaseView)
local base = UIBaseView
local this = UIThingsDetailBagItemView

local stageConfig = {}
local labConfig = {}
local prefabName = "ItemWayButtonPrefab"

local ScrollViewHeight = {
    [0] = 0,
    85, 145, 205, 240
}

---@param self UIThingsDetailBagItemView
local function InitItemPanel(self,data)
    local count = UIPublic.GetItemAmount(data.tempId)
    self.countText.text = string.gsub(LangUtil.GetSysLang(1320),"XX",count)
    local zItem = Z_Item[data.tempId]
    self.itemClass.SetData(data.tempId)
    self.itemClass.hideName()
    self.itemClass.SetClickAble(false)
    self.nameText.text = zItem.Name
    self.descText.text = zItem.Desc

    local wayCount = 0
    ListChildPool:GetInstance():ClearContent(self.content)
    if zItem.LevelJump ~= nil then
        for _, levelJumpId in ipairs(zItem.LevelJump) do
            local zLevelJump = Z_LevelJump[levelJumpId]
            if zLevelJump ~= nil then
                for index, value in ipairs(zLevelJump) do
                    wayCount = wayCount + 1
                    ListChildPool:GetInstance():GetChild(prefabName, self.content, function(gameObject)
                        local transform = gameObject.transform
                        ---@type ReferenceCollector
                        local rc = transform:GetComponent("ReferenceCollector")
                        local text = LangUtil.BindText(rc:GetObject("Text"))
                        local Button = rc:GetObject("Button")
                        local ButtonText = LangUtil.BindText(rc:GetObject("ButtonText"))
                        local button0 = rc:GetObject("Button0")
                        local button1 = rc:GetObject("Button1")
                        text.text = LangUtil.GetConfLang(value, "Desc")
                        if value.JumpType == 0 then
                            Button:SetActive(false)
                        else
                            Button:SetActive(true)
                            local isUnlock = UIPublic.CheckJumpLevel(value.JumpType, value.Arg1, value.Arg2)
                            button0:SetActive(not isUnlock)
                            button1:SetActive(isUnlock)
                            UIUtil.AddBtnEvent(Button,function()
                                if isUnlock then
                                    UIPublic.JumpLevel(value.JumpType, value.Arg1, value.Arg2)
                                    self.ctrl.CloseSelf()
                                end
                            end)
                            if isUnlock then
                                ButtonText.text = LangUtil.GetSysLang(460)
                            else
                                ButtonText.text = LangUtil.GetSysLang(1311)
                            end
                        end
                    end)
                end
            end
        end
    end

    self.wayTitle.gameObject:SetActive(wayCount > 0)
    self.content:SetActive(wayCount > 0)

    -- 调整self.ScrollView的高度为ScrollViewHeight
    if ScrollViewHeight[wayCount] == nil then
        self.ScrollView.sizeDelta = Vector2.New(self.ScrollView.sizeDelta.x, ScrollViewHeight[4])
    else
        self.ScrollView.sizeDelta = Vector2.New(self.ScrollView.sizeDelta.x, ScrollViewHeight[wayCount])
    end

end

---@param self UIThingsDetailBagItemView
local function OnLangCreate(self)
    LangUtil.BindText(self.langRc:GetObject("TitleText")).text = LangUtil.GetSysLang(229) -- 详情
    self.wayTitle = LangUtil.BindText(self.langRc:GetObject("WayTitle"))
    self.wayTitle.text = LangUtil.GetSysLang(1310)
    self.nameText = LangUtil.BindText(self.langRc:GetObject("NameText"))
    self.descText = LangUtil.BindText(self.langRc:GetObject("DescText"))
    self.countText = LangUtil.BindText(self.langRc:GetObject("CountText"))
end

---@param self UIThingsDetailBagItemView
local function OnCreate(self)
    base.OnCreate(self)
    UIUtil.AddBtnEvent(self.rc:GetObject("EventBg"), function()
        self.ctrl.CloseSelf()
    end)
    self.ItemPrefab = self.rc:GetObject("ItemPrefab")
    self.itemClass = UIItemClass(nil, self.ItemPrefab)
    self.content = self.rc:GetObject("Content")
    self.ScrollView = self.rc:GetObject("Scroll View"):GetComponent("RectTransform")
end

---@param self UIThingsDetailBagItemView
local function OnEnable(self)
    base.OnEnable(self)
    coroutine.start(function()
        self.gameObject:SetActive(false)
        self.content.transform:DOLocalMoveY(0, 0)
        self:OnRefresh()
        self.gameObject:SetActive(true)
    end)
end

---@param self UIThingsDetailBagItemView
local function OnRefresh(self)
    InitItemPanel(self,self.model.data)
end

local function OnAddListener(self)
    base.OnAddListener(self)
end

local function OnRemoveListener(self)
    base.OnRemoveListener(self)
end

---@param self UIThingsDetailBagItemView
local function OnDisable(self)
end

local function OnDestroy(self)
    base.OnDestroy(self)
end



UIThingsDetailBagItemView.OnCreate = OnCreate
UIThingsDetailBagItemView.OnEnable = OnEnable
UIThingsDetailBagItemView.OnRefresh = OnRefresh
UIThingsDetailBagItemView.OnAddListener = OnAddListener
UIThingsDetailBagItemView.OnRemoveListener = OnRemoveListener
UIThingsDetailBagItemView.OnDisable= OnDisable
UIThingsDetailBagItemView.OnDestroy = OnDestroy
UIThingsDetailBagItemView.OnLangCreate = OnLangCreate

return UIThingsDetailBagItemView