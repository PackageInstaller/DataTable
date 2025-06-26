--[[
    以 _item 为例
local _item = UIEventHandler(parent) -- 传一个父节点
self.item.SetData(10001, 1)
self.item.SetClickCallback(function() print("click") end)
在关闭时调用 
self.item.OnDestroy()
--]] 
local UGUIDragEventListener = CS.UnityEngine.UI.Extension.UGUIDragEventListener

---@param gameObject UnityEngine.GameObject @ 如果有传入gameObject则不会从对象池中获取
---@param initClearListener boolean @ 是否初始化清除监听
local function UIEventHandler(gameObject, initClearListener)
    ---@class UIEventHandler
    local self = {}

    local onBeginDrag
    local onDrag
    local onEndDrag

    local function _init()
        if initClearListener then
            self.ClearListener()
        end
    end

    ---@param callback fun(pointer: CS.UnityEngine.EventSystems.PointerEventData) @ 拖拽开始回调
    function self.AddBeginDragListener(callback)
        UGUIDragEventListener.Get(gameObject):AddBeginDragListener(callback)
        onBeginDrag = callback
    end

    ---@param callback fun(pointer: CS.UnityEngine.EventSystems.PointerEventData) @ 拖拽中回调
    function self.AddDragListener(callback)
        UGUIDragEventListener.Get(gameObject):AddDragListener(callback)
        onDrag = callback
    end

    ---@param callback fun(pointer: CS.UnityEngine.EventSystems.PointerEventData) @ 拖拽结束回调
    function self.AddEndDragListener(callback)
        UGUIDragEventListener.Get(gameObject):AddEndDragListener(callback)
        onEndDrag = callback
    end

    function self.ClearListener()
        if onBeginDrag then
            UGUIDragEventListener.Get(gameObject):RemoveBeginDragListener(onBeginDrag)
            onBeginDrag = nil
        end
        if onDrag then
            UGUIDragEventListener.Get(gameObject):RemoveDragListener(onDrag)
            onDrag = nil
        end
        if onEndDrag then
            UGUIDragEventListener.Get(gameObject):RemoveEndDragListener(onEndDrag)
            onEndDrag = nil
        end
    end

    -- 销毁 需要外面手动调用
    function self.OnDestroy()
        self.ClearListener()
    end


    _init()

    return self
end
---@return UIEventHandler
return UIEventHandler