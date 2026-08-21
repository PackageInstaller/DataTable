--遭遇战驻守A的界面
local EncounterGarrisonSelect = BaseClass("EncounterGarrisonSelect",BaseUICtrl)
local M = EncounterGarrisonSelect

function M:__init()
    self._view.mask:onClick(Bind(self,self._OnCloseUI))
    self._checkSelect = Bind(self,self._OnCheckSelect)
    self._selectHandler = Bind(self,self._OnSelect)
    self._view.btnOk:onClick(Bind(self,self._OnClickOk))
    self._view.btnCancel:onClick(Bind(self,self._OnCloseUI))
    self._lastSelectHeroId = {}
    self._flag = 1 
end

function M:_OnCloseUI(go)
    self:Close()
end

function M:OnClose()
    if self._allItems then 
        for _,item in pairs(self._allItems) do 
            item.selectBack = nil
            item.longPressCallback = nil
            item.checkSelect = nil
        end
    self._allItems = {}
    end
    M.super.OnClose(self)
    self._callback = nil
end

function M:OnDeviceBack()
    self:Close()
    return true
end

function M:_RerefshHeros(selectHeros)
    self._garrsionNum = 0
    if self._allItems then 
        for _,heroId in ipairs(self._heroIds) do 
            local item = self:_GetItem(heroId)
            if selectHeros then
                item:SetSelect(table.indexof(selectHeros,heroId) )
            end
            if item.select then 
                self._garrsionNum = self._garrsionNum + 1
            end
        end
    end
    if self._garrsionNum > self._lockNum then 
        if #self._lastSelectHeroId > 1 then 
            local removeHeroId = self._lastSelectHeroId[#self._lastSelectHeroId-1]
            local item = self:_GetItem(removeHeroId)
            if item.select then 
                item:SetSelect(false)
                self._garrsionNum = self._garrsionNum - 1
            end
            if selectHeros and table.indexof(selectHeros,removeHeroId) then 
                table.removebyvalue(selectHeros,removeHeroId)
            end
        end
    end
    self._view.txtNum:SetText( self._garrsionNum .. "/" .. self._lockNum )
    local desc = ConfigHelper.GetLocalString(5856) -- "%d/%d还需驻守%d人(语言Id=?)"
    if self._garrsionNum < self._lockNum then 
        self._view.state:SetState(1)
        self._view.needGarssionTxt:SetText(string.format(desc,self._garrsionNum, self._lockNum,(self._lockNum-self._garrsionNum) ))
    else
        self._view.state:SetState(2)
    end
    
end

function M:_GetSelectNum()
    local garrsionNum = 0
    if self._allItems then 
        for _,heroId in ipairs(self._heroIds) do 
            local item = self:_GetItem(heroId)
            if item.select then 
                garrsionNum = garrsionNum + 1
            end
        end
    end
    return garrsionNum
end

function M:_GetItem(heroId)
    local item = nil
    if self._allItems[heroId] then 
        item = self._allItems[heroId]
    else
        item = GameUtil.InstantiateComponent(self._view.itemPrefab,self._view.itemContainer)
        item.canSelect = true
        self._allItems[heroId] = item
    end
    local lv = IHeroDataMgr:GetHeroLevel(heroId)
    item:SetHeroId(heroId,lv)
    if item.checkSelect == nil then 
        item.checkSelect = self._checkSelect
        item.selectBack = self._selectHandler
    end
    return item 
end

function M:_OnCheckSelect(curItem)
    return true
    -- if self._allItems then 
    --     local selectNum = 0 
    --     --限制选中数量
    --     for heroId,item in pairs(self._allItems) do 
    --         if item.select then 
    --             selectNum = selectNum + 1 
    --         end
    --         if selectNum >= self._lockNum then 
    --             return false
    --         end
    --     end
    --     return true
    -- end
    -- return false
end

function M:_OnSelect(isSelect,curItem)
    for heroId,item in pairs(self._allItems) do 
        if item == curItem then
            if table.indexof(self._lastSelectHeroId,heroId) then 
                table.removebyvalue(self._lastSelectHeroId,heroId)
            end
            table.insert(self._lastSelectHeroId,heroId)
        end
    end
    self:_RerefshHeros()
end

function M:OnEnter(heroIds,lockNum,selectHeros,callback)
    self._lockNum = lockNum
    self._garrsionNum = 0
    self._allItems = {}
    self._heroIds = heroIds 
    self._callback = callback
    self._view.itemPrefab:SetActive(false)
    self._lastSelectHeroId = {}
    for _,hid in ipairs(selectHeros) do 
        table.insert(self._lastSelectHeroId,hid)
    end
    self:_RerefshHeros(selectHeros)
end

function M:_OnClickOk(go)
    if self._callback then 
        local heros = {}
        for heroId,item in pairs(self._allItems) do 
            if item.select then 
                table.insert(heros,heroId)
            end
        end
        if #heros < self._lockNum then
            return
        end
        EncounterConfMgr:GetInstance():Garrsion(heros,Bind(self,self._OnGarrsion))
    end
end

function M:_OnGarrsion(heros)
    if self._callback then 
        self._callback(heros)
        self._callback = nil
    end
    self:Close()
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return M

