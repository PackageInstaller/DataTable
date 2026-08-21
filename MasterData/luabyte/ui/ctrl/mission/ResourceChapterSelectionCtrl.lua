-- 资源章节选择面板
local M = BaseClass("ResourceChapterSelectionCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))

function M:Init()
    self.m_inital = false
    self.m_weekHour = GameHelper.GetParamter(361)  -- 几点解锁
    self.m_openTimes = GameHelper.GetParamter(339) -- 资源本新手期时长
    local resCtrl = require("UI.Ctrl.Mission.ResourceChapterItemCtrl")
    local resView = require("UI.View.Mission.ResourceChapterItemView")
    self._view.node_loop:Init(resCtrl, resView)
end

function M:OpenPanel(doubleData)
    self:ShowPanel()
    if self.m_inital then
        self._view.node_loop:UpdateList()
    else
        self:_InitResourceChapter(doubleData)
    end
end

-- 初始化资源副本
function M:_InitResourceChapter(doubleData)
    if self.m_inital then return end
    self.m_inital = true

    ActivityDataMgr:GetInstance():GetActivitysByTypeAsyn(ActivityType.RES_ACTIVITY_COPY, function(datas)
        local actData = datas and datas[1] or nil
        local CSCheckWeekDay = GameHelper.CSCheckWeekDay
        local CSCheckLockId = GameHelper.CSGetFirstLockReason
        local isOpen = actData and actData:IsOpen() or false
        local itemChapters, allResource = {}, CS.GameBase.JChapter.AllResource()
        local isInNewRoleOpen = TimeUtil.IsInCreatRoleOpenTime(self.m_openTimes)
        for i = 0, allResource.Length - 1 do
            local chapter = allResource[i]
            table.insert(itemChapters, {
                Id = chapter.id,
                Chapter = chapter,
                Double = doubleData,
                IsActivityOpen = isOpen,                       -- 资源活动是否开启
                IsNewRoleOpen = isInNewRoleOpen,               -- 创角限时开启
                LockId = CSCheckLockId(chapter.openCondition), -- 主要解锁条件
                IsWeekDay = CSCheckWeekDay(chapter.weekOpenCondition, self.m_weekHour),
            })
        end

        local isLimitOpen = isOpen or isInNewRoleOpen --这两都是开放全部资源本，取一个
        table.sort(itemChapters, function(x, y)       -- 排序，先排已解锁，再排id小到大
            local unlockX = (x.LockId == 0) and (isLimitOpen or x.IsWeekDay)
            local unlockY = (y.LockId == 0) and (isLimitOpen or y.IsWeekDay)
            if (unlockX == unlockY) then return x.Id < y.Id end
            return unlockX
        end)

        self._view.node_loop:SetDataList(itemChapters)
    end)
end

return M
