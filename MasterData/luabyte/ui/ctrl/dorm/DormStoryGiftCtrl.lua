local DormStoryGiftCtrl = BaseClass("DormStoryGiftCtrl")
local M = DormStoryGiftCtrl

function M:__init(view)
    self._view = view
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.m_allItems = nil
    self.m_curTabType = BagConst.TabType.ITEM
    self.m_selectDatas = {}
    self.m_bottomBarCtrl = self._view.Tab -- 道具页签
    self._view.BtnCancel:onClick(Bind(self, self.OnClickCancel))
    self._view.BtnConfirm:onClick(Bind(self, self.OnClickConfirm))
    self.m_loopList = self._view.ScrollView
    self.m_loopList:SetCreateItemCallback(Bind(self, self.OnCreatItem))
    self.m_loopList:Init(require("UI.Ctrl.Dorm.DormStoryGiftItemCtrl"), require("UI.View.Dorm.DormStoryGiftItemView"))
    self._selectItemCallback = EventMgr:AddListener(UIMessageNames.DORM_STORY_SELECT_ITEM, Bind(self, self.OnSelectItem))
    self._TabChangeCallback = EventMgr:AddListener(UIMessageNames.BAG_TYPE_TABLE_CHANGE, Bind(self, self.OnTagChange))
    self.m_givingItems = {}
end

function M:OnEnter(type, allItems, itemTask, givingCallback)
    self.type = type
    self.m_itemTask = itemTask
    self.m_allItems = allItems
    self.givingCallback = givingCallback
    self:InitGivingItemList()
    self:Enable(true)
end

function M:OnCreatItem(ctrl)
    ctrl:SetCallBack(function(itemId)
        return self:CheckTaskItem(itemId)
    end,
        function(itemId)
            return self:CheckSelectItem(itemId)
        end)
end

function M:CheckSelectItem(itemId)
    for k, v in pairs(self.m_selectDatas) do
        if v.Id == itemId then
            return true
        end
    end
    return false
end

function M:CheckTaskItem(itemId)
    for k, v in pairs(self.m_itemTask) do
        if v.item == itemId then
            return true
        end
    end
    return false
end

function M:CheckGiving()
    for key, value in pairs(self.m_itemTask) do
        if value.curNum ~= value.num then
            return false
        end
    end
    return true
end

-- 主页签回调
function M:OnTagChange(tabType)
    self.m_curTabType = tabType
    local list = self:GetDataList(self.m_curTabType)
    self.m_loopList:SetDataList(list)
end

--用于道具页签时，分类筛选
function M:GetDataList(tabType)
    local rtnList = {}
    rtnList = self.m_allItems[tabType]
    return rtnList
end

-- 点击道具
function M:OnSelectItem(data)
    table.insert(self.m_selectDatas, data)
    for key, value in pairs(self.m_itemTask) do
        if value.item == data.Id then
            value.curNum = data.Num > value.num and value.num or data.Num
            EventMgr:Broadcast(UIMessageNames.DORM_STORY_SELECT_GIVING_ITEM, value)
        end
    end
    self.m_loopList:UpdateList()
end

--初始化提交道具
function M:InitGivingItemList()
    local ctrlItemCls = require("UI.Ctrl.Dorm.DormStoryGivingItemCtrl")
    for key, value in pairs(self.m_itemTask) do
        local itemView = self._view.Item:Instantiate()
        itemView:SetParent(self._view.Content)
        itemView:SetActive(true)
        local ctrlItem = ctrlItemCls.New(itemView)
        ctrlItem:UpdateItem(value)
        table.insert(self.m_givingItems, ctrlItem)
    end
    if #self.m_givingItems > 0 then
        local cfg = ConfigHelper.GetCfgByLua("item", self.m_givingItems[1].m_data.item)
        for _, tabInfo in pairs(BagConst.Tab) do
            if table.indexof(tabInfo.types, cfg.type) ~= false then
                self.m_bottomBarCtrl:SetTab(tabInfo.Index, true)
                return
            end
        end
    end
end

--点击提交
function M:OnClickConfirm()
    if self:CheckGiving() then
        if self.type == DormConst.StoryType.TheatTaskStory then
            DormDataMgr:HeroEventStoryTrigger(self.module.heroId, self.module.roomEventType + 1, self.module.roomEvent,
                Bind(self, self.HeroEventStoryCallBack))
        end

        if self.type == DormConst.StoryType.ActivityStory then
            DormPuzzleActivityDataMgr:GetInstance():FlipCardStoryTrigger(self.module.activityEventType + 1, Bind(self, self.ActivityEventStoryCallBack))
        end
    end
end

--点击取消
function M:OnClickCancel()
    self.givingCallback(false)
end

--英雄触发小剧场任务回调(接取任务)
function M:HeroEventStoryCallBack(msg)
    --更新数据
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.module.heroId)
    if not IsNull(rshd) then
        rshd:UpdateEventNode(msg.EventId)
        rshd:UpdateEventNodeType(msg.EventType)
        self.module.roomEvent = msg.EventId
        self.module.roomEventType = msg.EventType
        self.module.roomTask = DormHelper.GetDormTask(self.module.heroId)
    end
    self.givingCallback(true)
end

function M:ActivityEventStoryCallBack(msg)
    --英雄触发小剧场任务回调(接取任务)
    self.module.activityEvent = msg.EventId
    self.module.activityEventType = msg.EventType
    self.module.activityTask = DormPuzzleActivityDataMgr:GetInstance():GetActivityTask()
    self.givingCallback(true)
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.DORM_STORY_SELECT_ITEM, self._selectItemCallback)
    EventMgr:RemoveListener(UIMessageNames.BAG_TYPE_TABLE_CHANGE, self._TabChangeCallback)
    for key, value in pairs(self.m_givingItems) do
        value:OnDispose()
    end
    self.m_givingItems = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormStoryGiftCtrl
