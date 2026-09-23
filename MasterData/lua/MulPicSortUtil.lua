-- 多人插图排序工具
local this = {};
local funcs = {}

function this:Init()
end

function this:SortByCondition(_cards)
    self.newDatas = _cards or {}
    self:SelectBy1()
    return self.newDatas
end

function this:SelectBy1()
    local curDatas = {}
    local rule = MulPicMgr:SGetCurFiltrateType().ThemeType
    if (rule[1] == 0) then
        return
    end
    local newRule = {}
    for i, v in ipairs(rule) do
        newRule[v] = v
    end
    local len = #self.newDatas
    for i = len, 1, -1 do
        if (newRule[self.newDatas[i]:GetThemeType()] == nil) then
            table.remove(self.newDatas, i)
        end
    end
end

this:Init()

return this
