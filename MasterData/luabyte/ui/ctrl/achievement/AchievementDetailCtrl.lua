local AchievementDetailCtrl = BaseClass("AchievementDetailCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = AchievementDetailCtrl



function M:Refresh(data)
    self._data = data
    self._list = self:_TaskData()
    self:_SortData()
    self:_SetProgress()
    self._view.scrollView:SetDataList(self._list)
end


function M:_TaskData()
    local tasks = self._data:Tasks()
    local data = MapUtil.FilterValues(tasks, function (v) return self._data:PreposeComplete(v:Front()) end)
    return data
end


function M:_SortData()
    table.sort(self._list, function (v1, v2)
       local s1 = v1:State()
       local s2 = v2:State()
       local id1 = v1:Id()
       local id2 = v2:Id()

       if s1 == 2 and s2 == 2 then
          return id1 < id2
       end

       if s1 == 2 or s2 == 2 then
          return s1 < s2
       end

       if s1 == s2 then
          return id1 < id2
       end

       return s1 > s2
    end)
end


function M:_SetProgress()
    local progress = math.floor(self._data:ProgressValue() * 100)  
    local progress = progress > 100 and 100 or progress
    local progressText = string.format("%d/%d", self._data:Score(), self._data:AllScore())
    local valueText = string.format("<size=60>%d</size>", progress) .. "%"
    local cfg =  self._data:Config()
    self._view.bar.size = self._data:ProgressValue()
    self._view.barValue:SetText(valueText)
    self._view.barText:SetText(progressText)
    self._view.icon:SetPic(cfg.icon[self._data:Level()])
    self:SetBarLines()
end


function M:SetBarLines()
    local allScore = self._data:AllScore()
    local cfg = self._data:Config()
    local count = #cfg.upIntegral

    local index = 0
    for i=2, count do
        index = index + 1
        local score = cfg.upIntegral[i]
        local sub = score / allScore
        local x = self.m_LineNum * sub

        if not self.m_LineList[index] then
            self.m_LineList[index] = self._view.barLine:Instantiate()
        end

        self.m_LineList[index]:SetRectLocalPos(x, 0, 0)
        self.m_LineList[index]:SetActive(true)
    end

    if #self.m_LineList == count - 1 then
        return
    end

    local subNum = #self.m_LineList - count - 1
    local curIndex = count - 1
    for i = curIndex, #self.m_LineList do
        self.m_LineList[i]:SetActive(false)
    end
end


function M:Init()
    self.m_LineNum = 794
    self.m_LineList = {}
    self._view.scrollView:Init(require("UI.Ctrl.Achievement.AchievementContentItemCtrl"), require("UI.View.Achievement.AchievementContentItemView"))
    self._view.scrollView:SetCreateItemCallback(Bind(self, self._OnCreateItem))
    self:ShowPanel()
end


function M:_OnCreateItem(item)
    item:ClickCallback(Bind(self, self._OnSelectItem))
end


function M:_OnSelectItem(id)
    AchievementDataMgr:GetInstance():SendRequestAchievementReward(self._data:Id(), id)
end




return AchievementDetailCtrl