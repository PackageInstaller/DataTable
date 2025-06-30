--
-- <代码文件解释说明>
--

---@class UIFightSoulMergeMaterialsView : UIBaseView
---@field model UIFightSoulMergeMaterialsModel
---@field ctrl UIFightSoulMergeMaterialsCtrl
local UIFightSoulMergeMaterialsView = BaseClass("UIFightSoulMergeMaterialsView",UIBaseView)
local base = UIBaseView
local this = UIFightSoulMergeMaterialsView
local PrefabName = "FightVisitItemMid_Decompose"

local FIGHT_SOUL_MERGE_COUNT_LIMIT = tonumber(Z_Misc["FIGHT_SOUL_MERGE_COUNT_LIMIT"].Value[1])
function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    LangUtil.GetSpriteLang(507, function(Sprite) self.cancelButton.transform:Find("Text"):GetComponent("Image").sprite = Sprite  end) -- 取消
    LangUtil.GetSpriteLang(426, function(Sprite) self.confirmButton.transform:Find("Text"):GetComponent("Image").sprite = Sprite  end) -- 取消
end

function this:OnFightSoulItem(id)
    if table.contains(self.model.chooseIds, id) then
        table.removebyvalue(self.model.chooseIds, id)
    else
        local fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(id)

        if fightSoul.Lock then
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(2037)) -- 战魂已被锁定
            return
        end
        -- 判断 是否超了, 如果太多了 就return吧
        table.insert(self.model.chooseIds, id)
    end
end

function this:OnCreate()
    base.OnCreate(self)

    self.scroll = VerticalScroll.New()
    self.scroll:SetUpdateCount(15)
    self.scrollView = self.rc:GetObject("Scroll View"):GetComponent("ScrollRect")
    self.scroll:Clear()
    self.scroll:ScrollInit({}, self.scrollView, PrefabName, function (arg)
        local gameObject = arg.go
        ---@type FightSoul
        local fightSoul = arg.data
        local mask = gameObject.transform:Find("Select").gameObject
        local selectImage = gameObject.transform:Find("SelectImage").gameObject
        UIPublic.InitVsFightSoulItemMId(fightSoul,gameObject)
        UIUtil.AddBtnEventNoBug(gameObject, function()
            if fightSoul.isEquip or fightSoul.Lock then
                return
            end
            if not table.contains(self.model.chooseIds, fightSoul.Id) then
                local star = self.model.fightsoul.Star
                for index, id in ipairs(self.model.chooseIds) do
                    star = star + self.model.fightSoulMap[id].Star
                end
                if star >= FIGHT_SOUL_MERGE_COUNT_LIMIT then
                    return
                end
            end

            self:OnFightSoulItem(fightSoul.Id)
            local isSelect = table.first(self.model.chooseIds,function(v) return v == fightSoul.Id  end)
            mask:SetActive(isSelect)
            selectImage:SetActive(isSelect)
            self.scroll:RefreshData(self.model.fightSoulList)
        end)

        local isSelect = table.first(self.model.chooseIds,function(v) return v == fightSoul.Id  end)
        selectImage:SetActive(isSelect)
        local star = self.model.fightsoul.Star
        for index, id in ipairs(self.model.chooseIds) do
            star = star + self.model.fightSoulMap[id].Star
        end
        if star >= 5 and not table.contains(self.model.chooseIds, fightSoul.Id) then
            mask:SetActive(true)
        else
            mask:SetActive(isSelect or fightSoul.isEquip or fightSoul.Lock)
        end
    end)
    self.confirmButton = self.rc:GetObject("ConfirmButton")
    self.cancelButton = self.rc:GetObject("CancelButton")
    self.eventBg = self.rc:GetObject("EventBg")
    UIUtil.AddBtnEvent(self.confirmButton, function()
        if self.model.callBack ~= nil then
            self.model.callBack(self.model.chooseIds)
            self.ctrl.CloseSelf()
        end
    end)
    UIUtil.AddBtnEvent(self.cancelButton, function()
        self.ctrl.CloseSelf()
    end)
    UIUtil.AddBtnEvent(self.eventBg, function()
        self.ctrl.CloseSelf()
    end)
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    ---@param a FightSoul
    ---@param b FightSoul
    table.sort(self.model.fightSoulList, function(a, b)
        if a.isEquip ~= b.isEquip then
            return not a.isEquip and b.isEquip 
        end
        if a.Lock and not b.Lock then
            return a.Lock
        end
        if a.level ~= b.level then
            return a.level > b.level
        end
        if a.Star ~= b.Star then
            return a.Star > b.Star
        end
        return a.Id < b.Id
    end )
    
    self.scroll:RefreshData(self.model.fightSoulList)
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
