--baoruichang
--2022/2/28 14:31:06
-- ItemEquip_New
local UIItemCtrl = BaseClass("UIItemCtrl", BaseUICtrl)
local M = UIItemCtrl
local tInsert = table.insert
local sGsub = string.gsub
local UIItemGetCtrl = require("UI.Ctrl.UIItemEquip.UIItemGetCtrl")
local UIItemGetView = require("UI.View.UIItemEquip.UIItemGetView")
local UIHeroCtrl = require("UI.Ctrl.UIItemEquip.UIHeroCtrl")
local UIHeroView = require("UI.View.UIItemEquip.UIHeroView")
local ItemPfbCtrl = require("UI.Ctrl.Common.ItemPfbCtrl")
local ItemPfbView = require("UI.View.Common.ItemPfbView")

function M:Init()
    self.gridScroll = self._view.gridScroll
    self.gridScroll:Init(UIItemGetCtrl, UIItemGetView)
    self.gridScroll:SetCreateItemCallback(Bind(self, self.OnCreateItem))
    self.gridHero = self._view.HeroList
    self.gridHero:Init(UIHeroCtrl, UIHeroView)
    self.gridItem = self._view.ItemList
    self.gridItem:Init(ItemPfbCtrl, ItemPfbView)
end

function M:OnEnter(itemId, needNum, target, closeFunc)
    self.itemId = itemId or 0
    self.target = target
    self.needNum = needNum or 0
    self.closeFunc = closeFunc
    self:InitData()
    self:InitItemGet()
    self:InitTips()
end

function M:OnCreateItem(ctrl)
    ctrl:SetCallBack(function(jump)
        local data = nil
        local eType = EnumConst.NotesWorkType.ItemJump
        if ItemDataMgr:GetInstance():GetItemNumById(self.itemId) < self.needNum then
            data = { itemId = self.itemId, itemNum = self.needNum }
        end
        NotesWorkMgr:GetInstance():UpdateNote(eType, data)
        if UIContextMgr:GetInstance():IsShow(UIDefine.RoleDevelopMain) then
            UIContextMgr:GetInstance():GetContext(UIDefine.RoleDevelopMain):SetJumpState(jump)
        end
    end, self.itemId)
end

function M:InitData()
    local item = ConfigHelper.GetCfgByLua("item", self.itemId) or {}
    local num = ItemDataMgr:GetInstance():GetItemNumById(self.itemId) or 0
    self._view.labAllNum:SetText(tostring(num))
    local desc = ConfigHelper.GetLocalString(item.desc)
    desc = sGsub(desc, "<playerName>", IPlayerData.NickName)
    self._view.labDesc:SetText(desc)
    self._view.labName:SetText(item.name)
    self._view.Icon:SetItemIcon(self.itemId)
    self._view.UIStateQuality:SetState(item.quality)

    if item.type == 8 and item.effectType == 11 then --英雄自选箱
        self._view.btnClose:onClick(Bind(self, self.Close))
        self._view.UIStateType:SetState(3)
        local heros = {}
        for i = 1, #item.effectArgs do
            local heroId = item.effectArgs[i]
            if heroId > 0 then
                tInsert(heros, heroId)
            end
        end
        self.gridHero:SetDataList(heros)
        return
    end
    if item.type == 8 and item.effectType == 1 then --道具箱
        self._view.btnClose:onClick(Bind(self, self.Close))
        self._view.UIStateType:SetState(2)
        local allItems = {}
        for i = 1, #item.effectArgs do
            local itemGroup = ConfigHelper.GetCfgByLua("itemGroup", item.effectArgs[i])
            if itemGroup then
                if #itemGroup.items > 0 then
                    for j = 1, #itemGroup.items do
                        local itemId = itemGroup.items[j]
                        if allItems[itemId] then
                            allItems[itemId] = allItems[itemId] + itemGroup.cnts[j]
                        else
                            allItems[itemId] = itemGroup.cnts[j]
                        end
                    end
                end
            end
        end
        local items = {}
        for k, v in pairs(allItems) do
            local data = { id = k, num = v }
            tInsert(items, data)
        end
        self.gridItem:SetDataList(items)
        return
    end
    self._view.UIStateType:SetState(1)
    if self.target then
        self._view.posCtrl:Init(self.target.gameObject, self._view.Content.gameObject, self._view.ClickArea.gameObject,
            Bind(self, self.Close))
    else
        self._view.ClickArea.gameObject:SetActive(false)
        self._view.btnClose.gameObject:SetActive(true)
        self._view.btnClose:onClick(Bind(self, self.Close))
    end
end

--来源
function M:InitItemGet()
    local itemCfg = ConfigHelper.GetCfgByLua("item", self.itemId) or {}
    if itemCfg.getWay ~= 1 then
        self._view.goFromPanel:SetActive(false)
        return
    end

    local wayValue2 = itemCfg.wayValue2 or {}
    if #wayValue2 <= 0 then
        self._view.goFromPanel:SetActive(false)
        return
    end

    local inst = JumpMgr:GetInstance()
    local openList, lockList, labels = {}, {}, itemCfg.wayLabel
    for i = 1, #wayValue2 do
        local jId = wayValue2[i]
        if inst:CheckShowLimitById(jId) == 0 then --判断是否显示
            if JumpMgr:GetInstance():CheckLockByJumpId(jId) > 0 then
                tInsert(lockList, { jumpId = jId, wayLabel = labels[i] or 1 })
            else
                tInsert(openList, { jumpId = jId, wayLabel = labels[i] or 1 })
            end
        end
    end

    for _, v in ipairs(lockList) do tInsert(openList, v) end

    -- 已解锁在前
    self.gridScroll:SetDataList(openList)
    self._view.goFromPanel:SetActive(true)
end

function M:InitTips()
    local itemCfg = ConfigHelper.GetCfgByLua("item", self.itemId) or {}
    local getWay = itemCfg.getWay

    if getWay == 1 then
        self._view.goTips:SetActive(false)
        return
    end

    if getWay == 0 then
        local wayValue1 = itemCfg.wayValue1
        local tips = wayValue1 > 0 and wayValue1 or ""
        self._view.labTips:SetText(tips)
        self._view.goTips:SetActive(true)
    end
end

--点击设置退出按键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:Close()
    self.target = nil
    if self.closeFunc then
        self:closeFunc()
    end
    self.closeFunc = nil
    self._view.posCtrl:DisposeAll()
    M.super.Close(self)
end

return UIItemCtrl
