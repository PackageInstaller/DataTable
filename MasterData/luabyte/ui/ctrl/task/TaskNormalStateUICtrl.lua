local TaskNormalStateUICtrl = BaseClass("TaskNormalStateUICtrl")
local M = TaskNormalStateUICtrl

function M:__init(view)
    self._view = view
    self._tabLabel = { TaskConst.Tab.Main.labels, TaskConst.Tab.Daily.labels, TaskConst.Tab.Challenge.labels }
    --self._tabLabel = {TaskConst.Tab.Main.labels,TaskConst.Tab.Daily.labels,TaskConst.Tab.Weekly.labels,TaskConst.Tab.Challenge.labels,TaskConst.Tab.Achievement.labels}
    self._taskTyps = { TaskConst.TaskType.Main, TaskConst.TaskType.Daily, TaskConst.TaskType.Challenge }

    self._curTabType = 1
    self._tab = self._view.tab
end

--initTab 默认显示页签
--列表变化时回调
function M:SetTab(initTab)
    self._curTabType = initTab
    self._tab:InitItems(initTab - 1, self._tabLabel, function(idx)
        local tabType = idx + 1
        self._curTabType = tabType
        EventMgr:Broadcast(UIMessageNames.TASK_TYPE_TABLE_CHANGE, self._curTabType)
    end)
    self._tab:SetIndex(initTab - 1, false)
    local csType = typeof(CS.GameX.RedPoint)
    for i = 0, #self._tabLabel - 1 do
        local item = self._tab:GetTabItem(i)
        local redPoint = item:GetComponent(csType)
        if IsNull(redPoint) then
            redPoint = item.gameObject:AddComponent(csType)
        end
        if redPoint.types == nil or redPoint.types.Length == 0 then
            local taskType = self._taskTyps[i + 1]
            redPoint:AddData(CS.GameX.RedPointConst.TaskRedChecker, taskType)
            if taskType == TaskConst.TaskType.Daily then
                redPoint:AddData(CS.GameX.RedPointConst.TaskChestAwardRedPointChecker)
            end
        end
        redPoint:Check()
    end
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return TaskNormalStateUICtrl
