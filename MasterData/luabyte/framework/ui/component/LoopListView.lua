----使用说明
----1、预制体上需要使用C# LoopListView2脚本调试好位置，通过LUA生成工具生成本类链接
----2、有两种模式可以使用，第1种是单ITEM模式，item可以自由设置内容，此模式适用于大部分情况；
---                         用法：初始化 LoopListView:Init(itemType,itemViewType,prefabName)
----                              设置数据列表 LoopListView:SetDataList 参数为dataList
----                              获得数据列表 LoopListView:GetDataList 参数为dataList
---                               当列表修改时，更新数据列表 LoopListView:UpdateList  参数为dataList
---                               当列表中某些item数据修改，但又没有拖动，使用LoopListView:ReFreshLayout
---
---                      第2种是多ITEM模式，即通过不同的数据，使用不同的itemPrefab来当作item,
---                         用法：初始化 LoopListView:Init(getItemCallback)
---                                     getItemCallback 参数为 getItemCallback(dataIndex) 返回值开共有4个 data,ctrlClass,viewClass , prefabName
----                              设置数据列表 LoopListView:SetDataList 参数为 dataLength长度
----                              获得数据列表 LoopListView:GetDataList 参数为 dataLength长度
---                               当列表修改时，更新数据列表 LoopListView:UpdateList  参数为 dataLength长度
---                               当列表中某些item数据修改，但又没有拖动，使用LoopListView:ReFreshLayout

local LoopListView = BaseClass("LoopListView", UIBaseComponent)
local M = LoopListView

-- function M:__init(loopListView)
--     self._dataList = {}
--     self._nextDataList = {}
--     self._itemList = {}
--     self._itemViewDic = {}
--     self._itemType = nil
--     self._itemViewType = nil
--     self._prefabName = nil
--     self._csLoopListView = loopListView
--     self._GetItemCallback = nil
--     if IsNull( loopListView ) then
--         Logger.LogError("loopListView is nil " )
--     end
--     self._cellUpdateCallBack = Bind(self,self._CellUpdate)
-- end

function M:OnCreate(loopListView)
    self._dataList = {}
    self._nextDataList = {}
    self._itemList = {}
    self._itemViewDic = {}
    self._itemType = nil
    self._itemViewType = nil
    self._prefabName = nil
    self._csLoopListView = loopListView
    self._GetItemCallback = nil
    self._dragCallback = nil
    self._isDataUpdated = false -- 是否已经刷新数据
    if IsNull(loopListView) then
        Logger.LogError("loopListView is nil ")
    end
    self._cellUpdateCallBack = Bind(self, self._CellUpdate)
end

--当容器改变时，可以调用此方法刷新布局
function M:ReFreshLayout()
    self._csLoopListView:ReFreshLayout()
end

--初始化Item , itemType item的控制类, itemViewType 视图类，prfabName prefab名称
function M:Init(itemType, itemViewType, prefabName)
    --self._csLoopListView:InitListView(3, self._cellUpdateCallBack)
    if type(itemType) == "function" then
        self._GetItemCallback = itemType
        return
    end
    self._itemType = itemType
    self._itemViewType = itemViewType
    self._prefabName = prefabName
end

function M:SetCreateItemCallback(createCallback)
    self._createCallback = createCallback
end

--设置数据列表
function M:SetDataList(dataList)
    if dataList == nil then return end

    local t = type(dataList)
    local length = 0
    if t == "table" then
        self._dataList = dataList
        length = #self._dataList
    elseif t == "number" then
        length = dataList
    else
        return
    end
    --如果prefabName 没有填，则直接去取_csLoopListView中默认的
    if string.isNullOrEmpty(self._prefabName) then
        self._prefabName = self._csLoopListView.defaultItemName
    end
    self._isDataUpdated = false
    self._csLoopListView:InitListView(length, self._cellUpdateCallBack)
    self._csLoopListView:MovePanelToItemIndex(length, 0)
    self._isDataUpdated = true
end

--获得所有数据
function M:GetDataList()
    return self._dataList
end

--主动刷新
function M:UpdateList(dataList)
    if dataList == nil then return end

    local t = type(dataList)
    local length = 0
    if t == "table" then
        self._dataList = dataList
        length = #self._dataList
    elseif t == "number" then
        length = dataList
    else
        return
    end
    self._isDataUpdated = false
    self._csLoopListView:SetListItemCount(length, false)
    self._csLoopListView:RefreshAllShownItem()
    self._isDataUpdated = true
end

function M:OnItemSizeChanged(itemIndex)
    self._csLoopListView:OnItemSizeChanged(itemIndex)
end

function M:SetDragCallback(callback)
    self._dragCallback = callback
end

function M:MovePanelToItemIndex(index, offset)
    if not offset then offset = 0 end
    self._isDataUpdated = false
    self._csLoopListView:MovePanelToItemIndex(index, offset)
    self._isDataUpdated = true
end

function M:GetCurItemIndex(prefabName, normalize)
    return self._csLoopListView:GetCurItemIndex(prefabName, normalize)
end

function M:ScrollCallback(callback)
    self._csLoopListView:ScrollCallback(callback)
end

function M:_CellUpdate(go, idx)
    if idx < 0 then return nil end

    local luaIdx = idx + 1
    local data = nil
    local itemTypeClass = nil
    local itemViewClass = nil
    local prefabName = nil
    if self._GetItemCallback then
        data, itemTypeClass, itemViewClass, prefabName = self._GetItemCallback(luaIdx)
        if itemTypeClass == nil or itemViewClass == nil or prefabName == nil then
            Logger.LogError("严重错误,itemType or itemView or prefabName 为空 idx = " .. idx)
        end
    else
        data = self._dataList[luaIdx]
        itemTypeClass = self._itemType
        itemViewClass = self._itemViewType
        prefabName = self._prefabName
    end
    local itemLoopItem = go:NewListViewItem(prefabName)
    itemLoopItem.IsInitHandlerCalled = true
    local item = self._itemList[itemLoopItem]
    if not item then
        local itemView
        if self._itemViewDic[itemLoopItem] then
            itemView = self._itemViewDic[itemLoopItem]
        else
            itemView = itemViewClass.New(itemLoopItem.transform)
            self._itemViewDic[itemLoopItem] = itemView
        end
        item = itemTypeClass.New(itemView)
        self._itemList[itemLoopItem] = item
        if self._createCallback then
            self._createCallback(item)
        end
    end
    item:UpdateItem(data)

    if self._dragCallback and self._isDataUpdated then
        self._dragCallback(luaIdx)
    end
    return itemLoopItem
end

function M:OnDestroy()
    M.super.OnDestroy(self)
    self:Dispose()
end

function M:Dispose()
    if self._itemList ~= nil then
        for i, v in pairs(self._itemList) do
            if v.OnDestroy then
                v:OnDestroy()
            elseif v.Dispose then
                v:Dispose()
            elseif v.OnDispose then
                v:OnDispose()
            end
        end
    end

    if self._csLoopListView then
        self._csLoopListView:DisposeAll()
    end

    self._dataList = nil
    self._itemList = nil
    self._itemViewDic = nil
    self._itemType = nil
    self._itemViewType = nil
    self._csLoopListView = nil
    self._cellUpdateCallBack = nil
    self._dragCallback = nil
    self._createCallback = nil
    self._isDataUpdated = nil
end

return LoopListView
