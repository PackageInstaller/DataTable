local M = BaseClass("ComChooseHeroCtrl", BaseUICtrl)
local tInsert = table.insert

function M:Init()
    self.m_index = 0 -- 替换哪个位置，0：全部
    self.m_curIdx = 0
    self.m_fixHeroIds = {} -- 固定长度的id数组
    self.m_sortHandler = Bind(self, self.OnSortHeros)
    self._view.btn_close:onClick(Bind(self, self.Close))
    self._view.btn_confirm:onClick(Bind(self, self.OnClickYes))
    self._view.looplist:InitByFunc(Bind(self, self.OnUpdateItem))
    for i = 1, 7 do
        local handler = Bind(self, self.OnClickHeroType, i)
        self._view["toggle" .. i]:OnToggleClick(handler)
    end
end

-- index 0:全部，否则指定位置
-- heroIds: 需要选几个就初始化几个位置
-- assignDic:已上阵队员，key：heroId,value:描述字符串
-- tagDic:标签文本，key：heroId,value:标签字符串
-- sortDic: 排序字典，key:heroId,value:索引，大在最前
function M:OnEnter(index, heroIds, callback, assignDic, tagDic, sortDic)
    self.m_index = index
    self.m_callback = callback
    self.m_tagDic = tagDic or {}
    self.m_sortDic = sortDic or {}
    self.m_assignDic = assignDic or {}
    self:_UpdateHeroIds(heroIds)
    self:OnClickHeroType(1)
end

function M:OnClose()
    self.m_tagDic = nil
    self.m_sortDic = nil
    self.m_callback = nil
    self.m_assignDic = nil
    self.m_fixHeroIds = nil
    self.m_sortHandler = nil
    self.m_tabHeroDatas = nil
    M.super.OnClose(self)
end

function M:OnUpdateItem(obj, index)
    local heroItem = obj:GetHeroHeadItem()
    local lv = self.m_tabHeroDatas[index]:GetLevel()
    local heroId = self.m_tabHeroDatas[index]:GetHeroId()
    local arrayIdx = table.indexof(self.m_fixHeroIds, heroId)
    heroItem:onClick(Bind(self, self.OnClickItem, heroId))
    heroItem:SetOnText(self.m_assignDic[heroId] or "")
    heroItem:SetTagText(self.m_tagDic[heroId] or "")
    heroItem.select = arrayIdx ~= false
    heroItem:SetHeroId(heroId)
    heroItem:SetHeroLevel(lv)
end

function M:_UpdateHeroIds(heroIds)
    for i, v in ipairs(heroIds) do
        tInsert(self.m_fixHeroIds, v)
        if (self.m_curIdx == 0) and (v == 0) then
            self.m_curIdx = i
        end
    end
    if self.m_curIdx == 0 then
        self.m_curIdx = #self.m_fixHeroIds
    end
end

function M:OnClickHeroType(index)
    local type, data = index - 1, nil
    if type == 0 then
        data = IHeroDataMgr:GetHeros()
    else
        data = IHeroDataMgr:GetHerosByProfessinal(type)
    end

    self.m_tabHeroDatas = {}
    for i = 0, data.Count - 1 do
        tInsert(self.m_tabHeroDatas, data[i])
    end

    table.sort(self.m_tabHeroDatas, self.m_sortHandler)
    self._view.looplist:SetData(#self.m_tabHeroDatas)
end

function M:OnClickItem(heroId)
    if self.m_assignDic[heroId] then
        GameHelper.TipsById(5653) -- 队员已指派
        return
    end

    local arrIdx = table.indexof(self.m_fixHeroIds, heroId)
    if arrIdx then
        -- 取消已选中的
        self.m_fixHeroIds[arrIdx] = 0
        self.m_curIdx = arrIdx
    else
        for i, id in ipairs(self.m_fixHeroIds) do
            if id <= 0 then
                self.m_fixHeroIds[i] = heroId
                self.m_curIdx = i
                break
            end
        end

        self.m_fixHeroIds[self.m_curIdx] = heroId
    end

    self._view.looplist:UpdateList()
end

function M:OnClickYes()
    self.m_callback(self.m_fixHeroIds, self.m_index)
    self:Close()
end

function M:OnSortHeros(v1, v2)
    local id1 = v1:GetHeroId()
    local id2 = v2:GetHeroId()
    local assign1 = self.m_assignDic[id1] ~= nil
    local assign2 = self.m_assignDic[id2] ~= nil
    if assign1 == assign2 then
        local idx1 = self.m_sortDic[id1] or 0
        local idx2 = self.m_sortDic[id2] or 0
        if idx1 == idx2 then
            local lv1 = v1:GetLevel()
            local lv2 = v2:GetLevel()
            if lv1 == lv2 then
                local rare1 = v1:GetRare()
                local rare2 = v2:GetRare()
                if rare1 == rare2 then
                    return id1 > id2 -- 5.id大到小
                else
                    return rare1 > rare2 -- 4.品质大到小
                end
            else
                return lv1 > lv2 -- 3.等级大到小
            end
        else
            return idx1 > idx2 -- 2. 主要战员 > 次要战员 > 其他
        end
    else
        return not assign1 -- 1.未占用大于已占用
    end
end

return M
