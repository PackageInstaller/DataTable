local M = BaseClass("BridgeChooseHeroCtrl", BaseUICtrl)
local tInsert = table.insert
-- 指挥官技能选择战员界面

function M:Init()
    self._heroList = {}
    self._chooseHero = 0
    self._selectData = nil
    local itemView = require("UI.View.Bridge.BridgeChooseHeroItemView")
    local itemCtrl = require("UI.Ctrl.Bridge.BridgeChooseHeroItemCtrl")
    self._heroScroll = self._view.heroList
    self._heroScroll:Init(itemCtrl, itemView)
    self._view.mask:onClick(Bind(self, self._OnClickClose))
    self._view.cancel:onClick(Bind(self, self._OnClickClose))
    self._view.confirm:onClick(Bind(self, self._OnClickConfirm))
    self._heroScroll:SetCreateItemCallback(Bind(self, self._OnCreateCallback))
end

function M:OnEnter(data)
    self._data = data
    local equippedHeros = IPlayerData:GetCommanderSkillHeros()
    local heroDatas = IHeroDataMgr:GetHeros()
    local cmdId = self._data.Config.cmdID
    local euippedList = {} -- 未配置的英雄列表
    for i = 0, heroDatas.Count - 1 do
        local hero = heroDatas[i]
        local heroId = hero:GetHeroId()
        local addLevel = CmderSkillMgr:GetAddValue(cmdId, heroId)

        if hero and hero:IsHave() and addLevel > 0 then
            if equippedHeros:ContainsKey(heroId) then
                local tmpData = {
                    IsChoose = equippedHeros[heroId] == cmdId,
                    IsEquipped = true,
                    AddLevel = addLevel,
                    HeroData = hero
                }
                if tmpData.IsChoose then
                    self._selectData = tmpData
                end
                tInsert(self._heroList, tmpData)
            else
                tInsert(euippedList, {
                    IsChoose = false,
                    IsEquipped = false,
                    AddLevel = addLevel,
                    HeroData = hero
                })
            end
        end
    end

    self:_SortHeros(euippedList)
    self:_SortHeros(self._heroList)

    for _, heroInfo in ipairs(euippedList) do
        tInsert(self._heroList, heroInfo)
    end

    self._heroScroll:SetDataList(self._heroList)
    self._view.uiState:SetState(#self._heroList > 0 and 1 or 2)
end

function M:OnClose()
    self._heroList = {}
    self._chooseHero = 0
    self._selectData = nil
end

--点击设置退出键【关闭带顶栏的popup窗口】
function M:OnDeviceBack()
    self:Close()
    return true 
end

-- 点击退出
function M:_OnClickClose(go)
    self:Close()
end

-- 确认按钮
function M:_OnClickConfirm(go)
    local request = {
        SkillId = self._data.Config.cmdID,
        HeroId = self._chooseHero
    }
    CmderSkillMgr:RqCmderSkillSettingHero(request)

    self:Close()
end

function M:_SortHeros(list)
    if not self._data then
        return
    end

    local cmdId = self._data.Config.cmdID
    table.sort(list, function(a, b)
        local a_addLv = CmderSkillMgr:GetAddValue(cmdId, a.HeroData:GetHeroId())
        local b_addLv = CmderSkillMgr:GetAddValue(cmdId, b.HeroData:GetHeroId())

        if a_addLv == b_addLv then
            return a.HeroData:GetHeroId() < b.HeroData:GetHeroId()
        else
            return a_addLv > b_addLv
        end
    end)
end

function M:_OnCreateCallback(itemCtrl)
    itemCtrl:SetSelectCallback(function(data)
        if self._selectData then
            local preHeroId = self._selectData.HeroData:GetHeroId()
            local curHeroId = data.HeroData:GetHeroId()
            if preHeroId ~= curHeroId then
                self._selectData.IsChoose = false
            end
        end
        -- 引用原数据
        self._selectData = data
        if self._selectData.IsChoose then
            self._chooseHero = self._selectData.HeroData:GetHeroId()
        else
            self._chooseHero = 0
        end

        self._heroScroll:UpdateList()
    end)
end

return M
