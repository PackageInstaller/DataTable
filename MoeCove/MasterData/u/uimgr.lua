local SpriteLoaderData = require("SpriteLoaderData")
---@class UIMgr:UIManager
local UIMgr = class("UIMgr", function (...)
    return UIManager.Instance
end)

local OperType = {
    Create = 1,
    Remove = 2,
    Enter = 3,
    Exit = 4,
}

function UIMgr:ctor(...)
    self.Frame = 1
    self:extensionInit()
    ---@type table<string, function>
    self.InitFunc = {}
    ---@type table<string, function>
    self.OpenFunc = {}
    ---@type table<string, function>
    self.CloseFunc = {}
    ---@type table<string, function>
    self.RemoveFunc = {}
    ---@type table<string, function>
    self.HideFunc = {}
    ---@type table<string, function>
    self.ShowFunc = {}
    ---@type table
    self.currDeal_Toast = {}
    ---@type table
    self.currDeal_Loader = {}

    self.delayQueue = {}

    --需要创建和删除的队列
    ---@type table
    self.WndQueue = {} --{ {data = data, tbData = tbData, opertype = OperType.Create},{data = name, tbData = tbData, opertype = OperType.Remove} }
    ---@type table
    self.ToastQueue = {}
    ---@type table
    self.MsgBoxQueue = {}
    ---@type table
    self.LoaderQueue = {}

    ---@type table
    self.LoadWait = {}
    ---@type table
    self.Toast = {}
    ---@type table
    self.MsgBox = {}
    ---@type table
    self.UI = {}
    --是否正在异步创建loader
    self.isCreatingLoader = false

    ---@type table<integer, SpriteLoaderData>
    self.imageLoaders = nil

    self:Clear(true)

    self.startLoaderFunc = function(file, time)
        local tbData = Config.GetUIConfigInfo("Loader")
        if UICommonUtils.GetUIPath(tbData.AssetPath) == file then
            return -1
        end
        --ClickLongPressListener.BlockClick()
        return self:startLoad(time)
    end

    self.endLoaderFunc = function(file, id)
        local tbData = Config.GetUIConfigInfo("Loader")
        if UICommonUtils.GetUIPath(tbData.AssetPath) == file then
            return
        end
        self:endLoad(id)
    end
end

---移除定时器
---@param curr table 当前定时器所在的表
---@param ti table 定时器信息
function UIMgr:RemoveTimer(curr, ti)
    ti.OnComp = nil
    DTimer.Instance:RemoveTimer(ti)
end

---创建定时器
---@param curr table 当前定时器所在的表
---@param time number 定时器时间
---@param callBack function 定时器回调
function UIMgr:Timer(curr, time, callBack)
    if time <= 0 then
        callBack()

        return
    end
    local ti = DTimer.TimerInfo.New()
    ti.Left = time
    ti.Interval = 100
    ti.MaxRepeatNum = 1
    ti.CombMode = true
    if curr.timer == nil then
        curr.timer = {}
    end
    curr.timer[ti] = 1
    ti.OnComp = function()
        if curr then
            curr.timer[ti] = nil
        end
        callBack()
    end
    DTimer.Instance:StartTimer(ti)
end

function UIMgr:__SetUIVisible(ui, visible, data)
    if ui then
        -- local canvas = ui.gameObject:GetOrAddComponent(TypeInfo.Canvas)
        if visible == true then
            if ui.gameObject.activeSelf == false then
                ui.gameObject:SetActive(true)
                if ui.OnOpenStart then
                    ui:OnOpenStart(data, false)
                end
            end
            -- canvas.enabled = true
            if ui.OnVisibleChange then
                ui:OnVisibleChange(true)
            end
        else
            if ui.gameObject.activeSelf == true then
                ui.gameObject:SetActive(false)
            end
            -- canvas.enabled = false
            if ui.OnVisibleChange then
                ui:OnVisibleChange(false)
            end
        end
    end
end

---优化UI显示
---@param opFullScreen boolean 是否全屏
function UIMgr:optimize(opFullScreen)
    local uiCount = #self.UI

    local visibleCount = 1
    if opFullScreen then
        visibleCount = 2
    end
    local tmpCount = 0
    for i=1,uiCount do
        local ui = self.UI[uiCount - i + 1]
        if ui and not ui.bClose then
            if tmpCount < visibleCount then
                if not ui.isHide then
                    self:__SetUIVisible(ui.ui, true);
                    self:__SetUIVisible(ui.mask, true); 
                end
                
                if ui.tbData.bFullScreen == true then
                    tmpCount = tmpCount + 1
                end
            else
                self:__SetUIVisible(ui.ui, false);
                self:__SetUIVisible(ui.mask, false);
            end

        end
    end
end

---更新
function UIMgr:Update()
    self:globalClickAndDragEffect()
    self:checkDelayUIRemove()
    self.Frame = self.Frame + 1
end


function UIMgr:Clear(onlyLuaUI)
    self.InitFunc = {}
    self.OpenFunc = {}
    self.CloseFunc = {}
    self.RemoveFunc = {}
    self.HideFunc = {}
    self.ShowFunc = {}
    self.loadIndex = 1
    self._hasGuidUI = false
    self:ClearUI(true)
    if not onlyLuaUI or not self.clearAllCSharpUI then
        self:clearAllUI()
    end
end

---清除UI
---@param all boolean 是否清除所有UI
function UIMgr:ClearUI(all)
    if self.UI then
        for i,v in ipairs(self.UI) do
            if not all and v.top then
            else
                DUtil.Destroy(v.mask)

                DUtil.Destroy(v.ui.gameObject)
            end
            
        end
    end

    local function stopTimer(curr)
        if curr then
            if curr.timer then
                for k,v in pairs(curr.timer) do
                    self:RemoveTimer(curr, k)
                end
            end
        end
    end
    stopTimer(self.currDeal_Wnd)
    stopTimer(self.currDeal_MsgBox)
    if self.currDeal_Toast then
        for k,v in pairs(self.currDeal_Toast) do
            stopTimer(v)
        end
    end
    if self.currDeal_Loader then
        for k,v in pairs(self.currDeal_Loader) do
            stopTimer(v)
        end
    end

    self.currDeal_Wnd = nil --{ op1 = {time = time, callFunc = callFunc, opertype = currOperType, data = obj, tbData = data.tbData}, op2 = {}}
    self.currDeal_Toast = {}
    self.currDeal_MsgBox = nil
    self.currDeal_Loader = {}

    --需要创建和删除的队列
    self.WndQueue = {} --{ {data = data, tbData = tbData, opertype = OperType.Create},{data = name, tbData = tbData, opertype = OperType.Remove} }
    self.ToastQueue = {}
    self.MsgBoxQueue = {}
    self.LoaderQueue = {}

    self.LoadWait = {}

    --已经创建对象队列
    --过滤top窗口
    local tmpWnd = {}
    if not all and self.Wnd then
        for k,v in pairs(self.Wnd) do
            if v.top then
                table.insert(tmpWnd, v)
            end
        end
    end

    self.Wnd = tmpWnd --{ {ui = wnd, mask = mask, tbData = tbData, state = UIState.Entered, bClose = false} }
    self.Toast = {}
    self.MsgBox = {}
    self.Loader = nil

    local tmpUI = {}
    if not all and self.UI then
        for k,v in pairs(self.UI) do
            if v.top then
                table.insert(tmpUI, v)
            end
        end
    end

    self.UI = tmpUI --{ {ui = wnd, mask = mask, tbData = tbData, state = UIState.Entered, bClose = false}, {} }
    self.ResetInput()
    self:clear()

end

---调用初始化
---@param uiLuaObj table UI对象
---@param tbData table UI数据
function UIMgr:CallInit(uiLuaObj, tbData)
    for i,v in ipairs(self.InitFunc) do
        if v then
            v(uiLuaObj, tbData)
        end
    end
end

---调用打开
---@param uiLuaObj table UI对象
---@param tbData table UI数据
function UIMgr:CallOpen(uiLuaObj, tbData)
    if tbData.UIType == UIType.Wnd or tbData.UIType == UIType.MsgBox then
        self.EnableInput(true)

    end
    if uiLuaObj.openValid then
        uiLuaObj:openValid()
    end
    if not uiLuaObj.bOpened then
        uiLuaObj.bOpened = true
        for _,v in ipairs(self.OpenFunc) do
            if v then
                v(uiLuaObj, tbData)
            end
        end
    end
end

function UIMgr:CallClose(uiLuaObj, tbData)
    if uiLuaObj.closeInvalid then
        uiLuaObj:closeInvalid()
    end
    for _,v in ipairs(self.CloseFunc) do
        if v then
            v(uiLuaObj, tbData)
        end
    end
end

function UIMgr:CallRemove(uiLuaObj, tbData)
    for i,v in ipairs(self.RemoveFunc) do
        if v then
            v(uiLuaObj, tbData)
        end
    end
end

---将指定界面移到 self.UI / self.Wnd / self.Toast / self.MsgBox 栈顶，供 resetRenderHierarchy 分配最高 sortingOrder
---@param ui UIBase
function UIMgr:bringUIToTop(ui)
    if not ui then
        return
    end
    local function moveInList(list)
        if not list then
            return
        end
        for i, v in ipairs(list) do
            if v.ui == ui then
                table.insert(list, table.remove(list, i))
                break
            end
        end
    end
    moveInList(self.UI)
    moveInList(self.Wnd)
    moveInList(self.Toast)
    moveInList(self.MsgBox)
end

function UIMgr:resetRenderHierarchy()
    --LuaLogger.ds("UIMgr:resetRenderHierarchy", debug.traceback())
    local index = 1
    local preMask = nil
    local function ResetMaskBG(mask, b)
        if mask then
            local bg = mask.transform:Find("bg")
            if bg then
                bg.gameObject:SetActive(b)
            end
        end
    end
    for i,v in ipairs(self.UI) do
        --LuaLogger.ds("UIMgr:resetRenderHierarchy ui", v.tbData.Name)
        local canvasUIIndex = -1
        if not v.bClose then
            canvasUIIndex = index*500 + 1
        end
        v.ui.transform:SetSiblingIndex(index)
        EngineUtil.SetSortingOrder(v.ui.gameObject, canvasUIIndex)
        v.ui:SetSortingOrderIndex(canvasUIIndex)
        local canvasMasIndex = -1
        if not v.bClose then
            canvasMasIndex = canvasUIIndex-1
        end
        if v.mask then
            v.mask.transform:SetSiblingIndex(index)
            EngineUtil.SetSortingOrder(v.mask.gameObject, canvasMasIndex)
            if not v.bClose then
                ResetMaskBG(preMask, false)
                preMask = v.mask
                ResetMaskBG(preMask, true)
            end
        end
        if not v.bClose then
            index = index + 1
        end
    end
end

function UIMgr:doLoadUI(fileName, callBack, newInst, bSceneUI)
    local index = self.loadIndex
    self.loadIndex = self.loadIndex + 1
    self.LoadWait[index] = true
    LuaLogger.ds("start load" .. fileName)
    self:LoadUI(fileName,function(obj)
        if self.LoadWait[index] then
            LuaLogger.ds("loadUI", fileName)
            callBack(obj)
            self.LoadWait[index] = nil
        else
            LuaLogger.ds("load destroy!!!", fileName)
            self:remove(obj)
            DUtil.DestroyImmediate(obj)
        end
    end,newInst,bSceneUI)

end

-- WebGL环境下改为异步加载
function UIMgr:doLoadUISync(fileName, callBack, newInst, bSceneUI)
    if EngineGlobal.useNewResource or EngineUtil.IsWebGL() then
        self:LoadUI(fileName, function(obj)
            callBack(obj)
        end, newInst, bSceneUI)
    else
        local obj = self:LoadUISync(fileName,newInst,bSceneUI)
        callBack(obj)
    end
end

function UIMgr:doAddUI(ui, op, uiType)
    local tbData = op.tbData
    local data = op.data
    local function SetMask(t)
        if string.len(tbData.ContainMask) > 0 then
            --到时候改成同步接口
            self:doLoadUISync(UICommonUtils.GetMaskUIPath(tbData.ContainMask),function(obj)
                if obj then
                    obj.name = "Mask"
                    t.mask = obj
                    self:resetRenderHierarchy()
                end
            end,true,false)
        end
    end
    local mask = nil
    local state = UIState.None
    local t = {}

    local function getFixedEchelon( tableData, bTop )
        if bTop then
            return 10000000000000
        end
        if tableData.UIType == UIType.Toast then
            return tableData.Echelon + 10000
        elseif tableData.UIType == UIType.Loader then
            return tableData.Echelon + 100000000
        else
            return tableData.Echelon
        end
    end

    local function doAdd(addT)
        for i,v in ipairs(addT) do
            if v.ui == ui then
                mask = v.mask
                state = v.state
                -- Singleton UI 被复用时（同一 ui 对象引用），清除 delayQueue 中对该 UI 的
                -- 待删除记录，防止 clearAllUI 的异步移除操作在新实例打开后将其误关闭
                for j = #self.delayQueue, 1, -1 do
                    local qEntry = self.delayQueue[j]
                    if qEntry.type == "removeUI" and qEntry.nameOrObj == ui then
                        table.remove(self.delayQueue, j)
                    end
                end
                table.remove(addT, i)
                break
            end
        end

        local index = 1
        local b = false
        for i,v in ipairs(addT) do
            index = i
            if op.top and v.top and op.top < v.top then
                b = true
                break
            end
            if getFixedEchelon(v.tbData, v.top) > getFixedEchelon(tbData, op.top) then
                b = true
                break
            end
        end
        self:__SetUIVisible(ui, true, data)
        t = {ui = ui, mask = mask, tbData = tbData, state = state, bClose = false, top = op.top, openData = op.data}
        if mask == nil then
            SetMask(t)
        else
            self:__SetUIVisible(mask, true);
        end
        if b == false then
            table.insert(addT, t)
        else
            table.insert(addT, index, t)
        end
    end
    -- body
    if uiType == UIType.Wnd then
        doAdd(self.Wnd)
    elseif uiType == UIType.Toast then
        doAdd(self.Toast)
    elseif uiType == UIType.MsgBox then
        doAdd(self.MsgBox)
    elseif uiType == UIType.Loader then
        if self.Loader then
            t = self.Loader
        else
            self:__SetUIVisible(ui, true);
            t = {ui = ui, mask = mask, tbData = tbData, state = state, bClose = false}
            if mask == nil then
                SetMask(t)
            else
                self:__SetUIVisible(mask, true);
            end
            self.Loader = t
        end
    end

    --可以close
    --if tbData.Singleton then
        for i,v in ipairs(self.UI) do
            if v.ui == ui then
                table.remove(self.UI, i)
                break
            end
        end
    --end


    local index = 1
    local b = false
    for i,v in ipairs(self.UI) do
        index = i
        if op.top and v.top and op.top < v.top then
            b = true
            break
        end
       if getFixedEchelon(v.tbData, v.top) > getFixedEchelon(tbData, op.top) then
            b = true
            break
        end
    end
    if b == false then
        table.insert(self.UI, t)
    else
        table.insert(self.UI, index, t)
    end

    local curName = self.getCurUIName and self:getCurUIName()
    if uiType == UIType.Toast or uiType == UIType.MsgBox or (curName and tbData.id == curName) then
        self:bringUIToTop(ui)
    end
    self:resetRenderHierarchy()

    return t
end

function UIMgr:doRemoveUI(ui, tbData, uiType, bDelete)
    -- body
    local function doRemove( removeT, bDelete )
        if bDelete == true then
            for i,v in ipairs(removeT) do
                if v.ui == ui then
                    table.remove(removeT, i)
                    break
                end
            end
        else
            for i,v in ipairs(removeT) do
                if v.ui == ui then
                    self:__SetUIVisible(v.ui, false);
                    self:__SetUIVisible(v.mask, false);
                    v.bClose = true
                    break
                end
            end
        end
    end
    if bDelete == true then
        local mask = nil
        if uiType == UIType.Wnd then
            doRemove(self.Wnd, bDelete)
        elseif uiType == UIType.Toast then
            doRemove(self.Toast, bDelete)
        elseif uiType == UIType.MsgBox then
            doRemove(self.MsgBox, bDelete)
        elseif uiType == UIType.Loader then
            self.Loader = nil
        end

        for i,v in ipairs(self.UI) do
            if v.ui == ui then
                mask = v.mask
                table.remove(self.UI, i)
                break
            end
        end

        if ui then
            self:remove(ui.gameObject)
            DUtil.Destroy(ui.gameObject)
        end
        self:remove(mask)
        DUtil.Destroy(mask)

        if EngineGlobal.useNewResource or EngineUtil.IsWebGL() then
            if not self.destroyUINum then
                self.destroyUINum = 0
            end
            self.destroyUINum = self.destroyUINum + 1
            if self.destroyUINum >= 1 then
                self.destroyUINum = 0
                collectgarbage("collect")
                if EngineGlobal.useNewResource then
                    ResMgr:UnloadUnusedBundles()
                else
                    UnityEngine.Resources.UnloadUnusedAssets()
                end
            end
        end
    else
        if uiType == UIType.Wnd then
            doRemove(self.Wnd, bDelete)
        elseif uiType == UIType.Toast then
            doRemove(self.Toast, bDelete)
        elseif uiType == UIType.MsgBox then
            doRemove(self.MsgBox, bDelete)
        elseif uiType == UIType.Loader then
            if self.Loader then
                self:__SetUIVisible(self.Loader.ui, false);
                self:__SetUIVisible(self.Loader.mask, false);
                self.Loader.bClose = true
            end
            self.Loader = nil
        end
    end

    self:resetRenderHierarchy()
end

--[[
    callFunc   func(luaClass)
]]
function UIMgr:_popUIDo(name, data, callFunc, noExitAni, noAni, endCallBack, source)
    local uiData = Config.GetUIConfigInfo(name)
    if uiData == nil then
        return
    end

    -- self:SendUiUseMessage(name)
    UICommonUtils.SendOpenEvent(uiData.id, source or "")
    if self:showUI(name, data) then
        if callFunc then
            callFunc()
        end
        if endCallBack then
            endCallBack()
        end
        return
    end

    self.popUIStamp = DLuaUtil.GetGreenwichTime()
    
    LuaLogger.ds("[UI]popUI" .. name)
    if uiData.UIType == UIType.Toast then
        --LuaLogger.ds("toast content", data)
        table.insert(self.ToastQueue, {data = data, callFunc = callFunc, tbData = uiData, opertype = OperType.Create, noExitAni = noExitAni})
        self:__Create_Toast(endCallBack)
    else
        if uiData.UIType == UIType.Wnd then
            self.EnableInput(false)
            table.insert(self.WndQueue, {data = data, callFunc = callFunc, tbData = uiData, opertype = OperType.Create, noExitAni = noExitAni, noAni = noAni, frame = self.Frame})
            self:delatyCreateUI(name)
        elseif uiData.UIType == UIType.MsgBox then
            self.EnableInput(false)
            table.insert(self.MsgBoxQueue, {data = data, callFunc = callFunc, tbData = uiData, opertype = OperType.Create, noExitAni = noExitAni, noAni = noAni, frame = self.Frame})
            self:delatyCreateUI(name)
        end
        local sendData ={
            ui_name = name,
            ui_type = tostring(uiData.UIType),
            enter_time = tostring(EngineUtil.ServerTime_Seconds())
        }
        UICommonUtils.SendOperatelInfoReq("user.ClientUILogReq",sendData)

        self:__Create(endCallBack)
    end
end

function UIMgr:showUI(nameOrObj, data)
    local ui = self:getUIData(nameOrObj)
    if not ui or not ui.isHide then
        return false
    end
    table.insert(self.delayQueue, {nameOrObj = nameOrObj, type = "showUI", frame = self.Frame, data = data})
    
    return true
end


function UIMgr:showUIImmediately(nameOrObj, data)
    return self:doShowUI(nameOrObj, data)
end

function UIMgr:doShowUI(nameOrObj, data)
    local ui = self:getUIData(nameOrObj)
    if not ui then
        return false
    end
    -- if not ui.isHide then
    --     return false
    -- end
    ui.isHide = nil
    self:__SetUIVisible(ui.ui, true, data)
    self:__SetUIVisible(ui.mask, true)
    self:CallShow(ui.ui, ui.tbData)
    self:bringUIToTop(ui.ui)
    self:resetRenderHierarchy()
    return true
end

function UIMgr:hideUI(nameOrObj)
    local ui = self:getUIData(nameOrObj)
    if not ui then
        return false
    end

    table.insert(self.delayQueue, {nameOrObj = nameOrObj, type = "hideUI", frame = self.Frame})
    
    return true
end

function UIMgr:hideUIImmediately(nameOrObj)
    self:doHideUI(nameOrObj)
end

function UIMgr:doHideUI(nameOrObj)
    local ui = self:getUIData(nameOrObj)
    if not ui then
        return false
    end
    if ui.isHide then
        return false
    end
    ui.isHide = true
    self:__SetUIVisible(ui.ui, false)
    self:__SetUIVisible(ui.mask, false)
    self:CallHide(ui.ui, ui.tbData)
    return true
end

function UIMgr:hideUIBackMain(exceptUI)
    for _,ui in ipairs(self.UI) do
        local continue = true
        if ui.tbData.UIType == UIType.Loader or ui.tbData.UIType == UIType.Toast then
            continue = false
        else
            if ui.tbData.id == "MainPanel" then
                continue = false
            elseif ui.tbData.id == exceptUI then
                continue = false
            end
            if ui.isHide or ui.bClose then
                continue = false
            end
        end
        if continue then
            ui.backMain = true
            ui.isHide = true
            self:__SetUIVisible(ui.ui, false)
            self:__SetUIVisible(ui.mask, false)
            self:CallHide(ui.ui, ui.tbData)
        end
    end
end

function UIMgr:returnUIFromMain()
    for _,ui in ipairs(self.UI) do
        if ui.backMain then
            ui.backMain = nil
            ui.isHide = nil
            self:__SetUIVisible(ui.ui, true)
            self:__SetUIVisible(ui.mask, true)
            self:CallShow(ui.ui, ui.tbData)
        end
    end
end

---@param nameOrObj string|UIBase
function UIMgr:getUIData(nameOrObj)
    for _,v in ipairs(self.UI) do
        if isstring(nameOrObj) then
            if v.tbData.id == nameOrObj then
                return v
            end
        else
            if v.ui == nameOrObj then
                return v
            end
        end
    end
end

function UIMgr:removeUI(nameOrObj, noEnterAni, callFunc, noAni)
    if type(nameOrObj) == "string" then
        --LuaLogger.ws("[UI]removeUI", nameOrObj, debug.traceback())
    else
        --LuaLogger.ws("[UI]removeUI", nameOrObj:getClassName(), debug.traceback())
    end
    table.insert(self.delayQueue, {type = "removeUI", nameOrObj = nameOrObj, noEnterAni = noEnterAni, callFunc = callFunc, noAni = noAni, frame = self.Frame})
	--self:doCloseUI(nameOrObj, true, noEnterAni, callFunc, noAni)
end

function UIMgr:removeUIImmediately(nameOrObj, noEnterAni, callFunc, noAni)
    self:doCloseUI(nameOrObj, true, noEnterAni, callFunc, noAni)
end

function UIMgr:_closeUIDo(nameOrObj, noEnterAni, callFunc, noAni)
    if type(nameOrObj) == "string" then
        --LuaLogger.ws("[UI]closeUI", nameOrObj, debug.traceback())
    else
        --LuaLogger.ws("[UI]closeUI", nameOrObj:getClassName(), debug.traceback())
    end
    table.insert(self.delayQueue, {type = "closeUI", nameOrObj = nameOrObj, noEnterAni = noEnterAni, callFunc = callFunc, noAni = noAni, frame = self.Frame})
    --self:doCloseUI(nameOrObj, false, noEnterAni, callFunc, noAni)
end

function UIMgr:closeUIImmediately(nameOrObj, noEnterAni, callFunc, noAni)
    self:doCloseUI(nameOrObj, false, noEnterAni, callFunc, noAni)
end

function UIMgr:delatyCreateUI(name)
    table.insert(self.delayQueue, {type = "delayUI", frame = self.Frame})
end

function UIMgr:removeDelayUI(frame)
    if not frame then
        return
    end
    local queue = self.delayQueue
    for k, v in pairs(queue) do
        if v.type == "delayUI" and v.frame == frame then
            table.remove(queue, k)
            break
        end
    end
    self:checkDelayUIRemove()
end

function UIMgr:checkDelayUIRemove()
    local queMap = {}
    for _, v in pairs(self.delayQueue) do
        if not queMap[v.frame] then
            queMap[v.frame] = {}
            queMap[v.frame].list = {}
            queMap[v.frame].delayUI = 0
        end
        table.insert(queMap[v.frame].list, v)
        if v.type == "delayUI" then
            queMap[v.frame].delayUI = queMap[v.frame].delayUI + 1
        end
    end
    local queue = {}
    for _, v in pairs(queMap) do
        if v.delayUI > 0 then
            table.insert(queue, v)
        end
    end
    -- 先清空并补回 blocked 分组，再执行操作。
    -- 这样执行过程中若有同步回调（如 noAni 时 Timer(0) 触发 OnClose）再次调用
    -- _closeUIDo 插入新项，不会被后续的 delayQueue={} 抹掉。
    self.delayQueue = {}
    for _, v in pairs(queue) do
        for _, vv in pairs(v.list) do
            table.insert(self.delayQueue, vv)
        end
    end
    for _, v in pairs(queMap) do
        if v.delayUI == 0 then
            for _, vv in pairs(v.list) do
                if vv.type == "removeUI" then
                    self:doCloseUI(vv.nameOrObj, true, vv.noEnterAni, vv.callFunc, vv.noAni)
                elseif vv.type == "closeUI" then
                    self:doCloseUI(vv.nameOrObj, false, vv.noEnterAni, vv.callFunc, vv.noAni)
                elseif vv.type == "showUI" then
                    self:doShowUI(vv.nameOrObj, vv.data)
                elseif vv.type == "hideUI" then
                    self:doHideUI(vv.nameOrObj)
                end
            end
        end
    end
end

--[[
    弹出一个UI窗口到顶层
    @param name string UI配置名称
    @param data table 传递给UI的数据
    @param callFunc function 回调函数，在UI创建完成后调用
]]
function UIMgr:popTopUI(name, data, callFunc)
    -- 获取UI配置信息
    local uiData = Config.GetUIConfigInfo(name)
    if uiData == nil then
        return
    end
    -- 将UI创建请求加入窗口队列
    -- top = -1 表示放到当前层级的最上层
    -- noExitAni = true 表示不播放退出动画
    table.insert(self.WndQueue, {data = data, callFunc = callFunc, tbData = uiData, opertype = OperType.Create, noExitAni = true, top = -1})
    -- 开始处理UI创建
    self:__Create()
end

function UIMgr:closeTopUI(nameOrObj, callFunc)
    self:doCloseUI(nameOrObj, false, true, callFunc)
end

function UIMgr:popTopestUI(name, data, callFunc)
    local uiData = Config.GetUIConfigInfo(name)
    if uiData == nil then
        return
    end
    table.insert(self.WndQueue, {data = data, callFunc = callFunc, tbData = uiData, opertype = OperType.Create, noExitAni = true, top = 0})
    self:__Create()
end

function UIMgr:startLoad(time)
    if time == nil then
        time = 0
    end
    if self.loaderId == nil then
        self.loaderId = 0
    end
    self.loaderId = self.loaderId + 1
    --LuaLogger.ds("start Loader", self.loaderId, debug.traceback())
    local tbData = Config.GetUIConfigInfo("Loader")
    table.insert(self.LoaderQueue, {data = {time = time, id = self.loaderId}, callFunc = nil, tbData = tbData, opertype = OperType.Create, noExitAni = nil})
    self:__Create_Loader()
    if self._loaderDetail == nil then
        self._loaderDetail = {}
    end
    local data = self._loaderDetail[self.loaderId]
    if not data then
        data = {}
        data.num = 0
        data.trace = {}
        self._loaderDetail[self.loaderId] = data
    end
    data.num = data.num + 1
    table.insert(data.trace, debug.traceback())
    return self.loaderId
end

function UIMgr:endLoad(loadID)
    --LuaLogger.ds("end Loader", loadID, debug.traceback())

    local tbData = Config.GetUIConfigInfo("Loader")
    table.insert(self.LoaderQueue, {data = loadID, tbData = tbData, opertype = OperType.Remove, bDelete = false, noEnterAni = nil})
    self:__Create_Loader()
    local data = self._loaderDetail[loadID]
    if data then
        data.num = data.num - 1
        if data.num == 0 then
            self._loaderDetail[loadID] = nil
        end
    end
end


function UIMgr:AddInitFunc(func)
    if func then
        self:RemoveInitFunc(func)
        table.insert(self.InitFunc, func)
    end
end

function UIMgr:RemoveInitFunc(func)
    for i=#self.InitFunc, 1, -1 do
        if self.InitFunc[i] == func then
            table.remove(self.InitFunc, i)
        end
    end
end

function UIMgr:ClearInitFunc()
    self.InitFunc = {}
end

function UIMgr:AddOpenFunc(func)
    if func then
        self:RemoveOpenFunc(func)
        table.insert(self.OpenFunc, func)
    end
end

function UIMgr:RemoveOpenFunc(func)
    for i=#self.OpenFunc, 1, -1 do
        if self.OpenFunc[i] == func then
            table.remove(self.OpenFunc, i)
        end
    end
end

function UIMgr:ClearOpenFunc()
    self.OpenFunc = {}
end

function UIMgr:AddCloseFunc(func)
    if func then
        self:RemoveCloseFunc(func)
        table.insert(self.CloseFunc, func)
    end
end

function UIMgr:RemoveCloseFunc(func)
    for i=#self.CloseFunc, 1, -1 do
        if self.CloseFunc[i] == func then
            table.remove(self.CloseFunc, i)
        end
    end
end

function UIMgr:ClearCloseFunc()
    self.CloseFunc = {}
end

function UIMgr:AddRemoveFunc(func)
    if func then
        self:RemoveRemoveFunc(func)
        table.insert(self.RemoveFunc, func)
    end
end

function UIMgr:RemoveRemoveFunc(func)
    for i=#self.RemoveFunc, 1, -1 do
        if self.RemoveFunc[i] == func then
            table.remove(self.RemoveFunc, i)
        end
    end
end

function UIMgr:ClearRemoveFunc()
    self.RemoveFunc = {}
end

function UIMgr:CallHide(uiLuaObj, tbData)
    if uiLuaObj and uiLuaObj.OnClose then
        uiLuaObj:OnClose(false)
    end
    for _, v in ipairs(self.HideFunc) do
        if v then
            v(uiLuaObj, tbData)
        end
    end
end

function UIMgr:CallShow(uiLuaObj, tbData)
    for _, v in ipairs(self.ShowFunc) do
        if v then
            v(uiLuaObj, tbData)
        end
    end
end

function UIMgr:AddHideFunc(func)
    if func then
        self:RemoveHideFunc(func)
        table.insert(self.HideFunc, func)
    end
end

function UIMgr:RemoveHideFunc(func)
    for i = #self.HideFunc, 1, -1 do
        if self.HideFunc[i] == func then
            table.remove(self.HideFunc, i)
        end
    end
end

function UIMgr:ClearHideFunc()
    self.HideFunc = {}
end

function UIMgr:AddShowFunc(func)
    if func then
        self:RemoveShowFunc(func)
        table.insert(self.ShowFunc, func)
    end
end

function UIMgr:RemoveShowFunc(func)
    for i = #self.ShowFunc, 1, -1 do
        if self.ShowFunc[i] == func then
            table.remove(self.ShowFunc, i)
        end
    end
end

function UIMgr:ClearShowFunc()
    self.ShowFunc = {}
end

function UIMgr:doCloseUI(nameOrObj, bDelete, noEnterAni, callFunc, noAni)
    if nameOrObj == nil then
        return
    end
    
    local uiType = nil
    local tbData = nil
    local ui
    if type(nameOrObj) == "string" then
        local uiData = Config.GetUIConfigInfo(nameOrObj)
        if uiData ~= nil then
            uiType = uiData.UIType
            tbData = uiData
        end
        for _,v in ipairs(self.UI) do
            if v.tbData.id == nameOrObj then
                
                if v.ui.closeInvalid then
                    v.ui:closeInvalid()
                end
            end
        end
    else
        for _,v in ipairs(self.UI) do
            if v.ui == nameOrObj then
                uiType = v.tbData.UIType
                tbData = v.tbData
                
                if v.ui.closeInvalid then
                    v.ui:closeInvalid()
                end
                break
            end
        end
    end

    if uiType == nil then
        return
    end

    if tbData and bDelete == false then
        if not tbData.canClose then
            bDelete = true
        end
    end
    
    if uiType == UIType.Wnd then
        table.insert(self.WndQueue, {data = nameOrObj, tbData = tbData, opertype = OperType.Remove, bDelete = bDelete, noEnterAni = noEnterAni, callFunc = callFunc, noAni = noAni})
    elseif uiType == UIType.Toast then
        --table.insert(self.ToastQueue, {data = nameOrObj, tbData = tbData, opertype = OperType.Remove, bDelete = bDelete, noEnterAni = noEnterAni})
    elseif uiType == UIType.MsgBox then
        table.insert(self.MsgBoxQueue, {data = nameOrObj, tbData = tbData, opertype = OperType.Remove, bDelete = bDelete, noEnterAni = noEnterAni, callFunc = callFunc, noAni = noAni})
    end
    self:__Create()
end

---@param uiConfig UIConfigTable|integer
function UIMgr:PlayBGM(uiConfig)
    -- body
    ---@type integer
    local bgmId = uiConfig
    if type(uiConfig) == "table" then
        bgmId = uiConfig.BGMId
    end
    if bgmId and bgmId ~= 0 then
        local bgmConfig = Config.GetBGMInfo(bgmId)
        if bgmConfig then
            --LuaLogger.ds(">>>>>uiConfig<<<<<", tablex.dump(uiConfig))
            self.curBgmId = bgmId
            LuaMain:LuaPlayBgm(bgmConfig.resource, true)
        end
    end
end


function UIMgr:SetBasalBgm(id)
    self.basalBgm = id
end

function UIMgr:GetBasalBgm()
    local id = self.basalBgm
    if id == nil then
       id = 10001 
    end
    return id
end

function UIMgr:PlayBasalBgm()
    self:PlayBGM(self:GetBasalBgm())
end

function UIMgr:GetAllUI(uiName)
    -- body
    local uis = {}
    for i = #self.UI,1,-1 do
        local data = self.UI[i]
        if data.tbData.id == uiName then
            table.insert(uis, data.ui)
        end
    end
    return uis
end

function UIMgr:GetUI(uiName)
    -- body
    for i = #self.UI,1,-1 do
        local data = self.UI[i]
        if data.tbData.id == uiName then
            return data.ui
        end
    end
end

function UIMgr:hasGuidUI()
    return self._hasGuidUI
end

function UIMgr:SetGuidUI(val)
    self._hasGuidUI = val
end

function UIMgr:__Create(endCallBack)
    --设置为不可点击

    local function showEnd()
        self:__Create()
        if endCallBack then
            endCallBack()
        end
    end
    if self:__Create_Wnd(showEnd) then
        return
    end
    if self:__Create_MsgBox(showEnd) then
        return
    end
end

function UIMgr:__Create_Wnd(endCallBack)
    if self.currDeal_Wnd ~= nil or self.currDeal_MsgBox ~= nil then
        return
    end
    while(true) do
        local queue = self.WndQueue[1]
        if queue == nil then
            return
        end
        table.remove(self.WndQueue, 1)
        local op1 = nil
        local op2 = nil
        local opertype = queue.opertype
        --初始化 op1 op2
        if opertype == OperType.Create then
            local time = queue.tbData.OpenTime * 1/queue.tbData.Speed
            local currOperType = OperType.Create
            local data = queue.data
            local tbData = queue.tbData
            local callFunc = queue.callFunc
            local noExitAni = queue.noExitAni
            local noAni = queue.noAni
            local top = queue.top
            local frame = queue.frame
            op2 = { time = time, callFunc = callFunc, opertype = currOperType, data = data, tbData = tbData, uiData = nil, top = top, noAni = noAni, frame = frame}

            if noExitAni == false or noExitAni == nil then
                local index = 0
                for i,v in ipairs(self.UI) do
                    if v.bClose == false and v.tbData.Echelon > tbData.Echelon then
                        break
                    end
                    index = i
                end

                for i=index,1, -1 do
                    local data = self.UI[i]
                    if data.bClose == false then
                        if data.tbData.UIType == UIType.Wnd or data.tbData.UIType == UIType.MsgBox then
                            if data.tbData.Echelon <= queue.tbData.Echelon then
                                if data.tbData.UIType == UIType.Wnd then
                                    local time = data.tbData.ExitTime * 1/data.tbData.Speed
                                    local currOperType = OperType.Exit
                                    local obj = data.ui
                                    op1 = { time = time, opertype = currOperType, data = obj, tbData = data.tbData, uiData = data, noAni = noAni }
                                end
                                break
                            end
                        end
                    end
                end
            end

            --处理单例类,如果op1和op2是同一个ui
            -- if tbData.Singleton == true then
            --     if op1 ~= nil and op1.tbData.id == tbData.id then
            --         op1 = nil
            --         op2 = nil
            --     end
            -- end
            self.currDeal_Wnd = {}
            self.currDeal_Wnd.ops = {}
            table.insert(self.currDeal_Wnd.ops, op1)
            table.insert(self.currDeal_Wnd.ops, op2)

        elseif opertype == OperType.Remove then
            local bDelete = queue.bDelete
            local noEnterAni = queue.noEnterAni
            local noAni = queue.noAni
            local removeUI= {}
            local enterUI = nil
            for i=#self.UI,1, -1 do
                local data = self.UI[i]
                if data.bClose == false then
                    if data.tbData.UIType == UIType.Wnd or data.tbData.UIType == UIType.MsgBox then
                        if #removeUI > 0 and enterUI == nil then
                            if data.tbData.UIType == UIType.Wnd then
                                enterUI = data
                            end
                        end
                        if type(queue.data) == "string" then
                            if data.tbData.id == queue.data then
                                table.insert(removeUI, data)
                            end
                        else
                            if data.ui == queue.data then
                                table.insert(removeUI, data)
                            end
                        end
                    end
                end
            end

            if #removeUI > 0 then
                op1 = { t = {}, opertype = OperType.Remove, callFunc = queue.callFunc, noAni = noAni}

                for i,v in ipairs(removeUI) do
                    local time = v.tbData.CloseTime * 1/v.tbData.Speed
                    local currOperType = OperType.Remove
                    local obj = v.ui
                    local op = { time = time, opertype = currOperType, data = obj, tbData = v.tbData, uiData = v, bDelete = bDelete}
                    table.insert(op1.t, op)
                end
                if noEnterAni == false or noEnterAni == nil then
                    if enterUI then
                        local time = enterUI.tbData.EnterTime * 1/enterUI.tbData.Speed
                        local currOperType = OperType.Enter
                        local obj = enterUI.ui
                        op2 = { time = time, opertype = currOperType, data = obj, tbData = enterUI.tbData, uiData = enterUI, noAni = noAni}
                    end
                end

                self.currDeal_Wnd = {}
                self.currDeal_Wnd.ops = {}
                table.insert(self.currDeal_Wnd.ops, op1)
                table.insert(self.currDeal_Wnd.ops, op2)
            end

        end

        if self.currDeal_Wnd then
            local function opEnd()
                self.currDeal_Wnd = nil
                --设置为可点击
                --print("Enable true", queue.tbData.id, debug.traceback())
                self:optimize()
                self.EnableInput(true)
                endCallBack()
            end

            local function AllOps()
                local op = self.currDeal_Wnd.ops[1]
                if op == nil then
                    opEnd()
                    return
                end
                self:__LogicOP(self.currDeal_Wnd, op, function()
                    table.remove(self.currDeal_Wnd.ops, 1)
                    AllOps()
                end)
            end
            self.EnableInput(false)
            AllOps()
            return true
        end
    end

    return false
end


function UIMgr:__Create_MsgBox(endCallBack)
    if self.currDeal_MsgBox ~= nil or self.currDeal_Wnd ~= nil then
        return
    end
    while(true) do
        local queue = self.MsgBoxQueue[1]
        if queue == nil then
            return
        end
        table.remove(self.MsgBoxQueue, 1)
        local op1 = nil
        local op2 = nil
        local opertype = queue.opertype
        --初始化 op1 op2
        if opertype == OperType.Create then
            local time = queue.tbData.OpenTime * 1/queue.tbData.Speed
            local currOperType = OperType.Create
            local data = queue.data
            local tbData = queue.tbData
            local callFunc = queue.callFunc
            local frame = queue.frame
            op2 = { time = time, callFunc = callFunc, opertype = currOperType, data = data, tbData = tbData, uiData = nil, frame = frame}

            self.currDeal_MsgBox = {}
            self.currDeal_MsgBox.ops = {}
            table.insert(self.currDeal_MsgBox.ops, op1)
            table.insert(self.currDeal_MsgBox.ops, op2)

        elseif opertype == OperType.Remove then
            local bDelete = queue.bDelete
            local noAni = queue.noAni
            local removeUI= {}
            local enterUI = nil
            for i=#self.UI,1, -1 do
                local data = self.UI[i]
                if data.bClose == false then
                    if data.tbData.UIType == UIType.Wnd or data.tbData.UIType == UIType.MsgBox then
                        if #removeUI > 0 and enterUI == nil then
                            enterUI = data
                        end
                        if type(queue.data) == "string" then
                            if data.tbData.id == queue.data then
                                table.insert(removeUI, data)
                            end
                        else
                            if data.ui == queue.data then
                                table.insert(removeUI, data)
                            end
                        end
                    end
                end
            end

            if #removeUI > 0 then
                op1 = { t = {}, opertype = OperType.Remove, callFunc = queue.callFunc, noAni = noAni}

                for i,v in ipairs(removeUI) do
                    local time = v.tbData.CloseTime * 1/v.tbData.Speed
                    local currOperType = OperType.Remove
                    local obj = v.ui
                    local op = { time = time, opertype = currOperType, data = obj, tbData = v.tbData, uiData = v, bDelete = bDelete}
                    table.insert(op1.t, op)
                end
                self.currDeal_MsgBox = {}
                self.currDeal_MsgBox.ops = {}
                table.insert(self.currDeal_MsgBox.ops, op1)
                table.insert(self.currDeal_MsgBox.ops, op2)
            end
        end

        if self.currDeal_MsgBox then
            local function opEnd()
                self.currDeal_MsgBox = nil
                --设置为可点击
                --print("Enable true", queue.tbData.id, debug.traceback())
                self:optimize()
                self.EnableInput(true)
                endCallBack()
            end

            local function AllOps()
                local op = self.currDeal_MsgBox.ops[1]
                if op == nil then
                    opEnd()
                    return
                end
                self:__LogicOP(self.currDeal_MsgBox, op, function()
                    table.remove(self.currDeal_MsgBox.ops, 1)
                    AllOps()
                end)
            end
            self.EnableInput(false)
            AllOps()
            return true
        end
    end
    return false
end

function UIMgr:__LogicOP(currDeal, op, endCallBack)
    if op.opertype == OperType.Remove then
        self:__LogicOP_Remove(currDeal, op, endCallBack)
    elseif op.opertype == OperType.Exit then
        self:__LogicOP_Exit(currDeal, op, endCallBack)
    elseif op.opertype == OperType.Create then
        self:__LogicOP_Create(currDeal, op, endCallBack)
    elseif op.opertype == OperType.Enter then
        self:__LogicOP_Enter(currDeal, op, endCallBack)
    end
end

function UIMgr:__LogicOP_Remove(currDeal, op, endCallBack)
    local function Removing(i)
        local op_ = op.t[i]
        if op_.bDelete == true then
            op_.data.isDeleting = true
        end
        if op_.data.OnClose then
            op_.data:OnClose(true)
        end
        self:CallClose(op_.data, op_.tbData)
        if op_.bDelete == true then
            self:CallRemove(op_.data, op_.tbData)
        end
        local uiType = op_.tbData.UIType
        self:doRemoveUI(op_.data, op_.tbData, uiType, op_.bDelete)
        op_.uiData.state = UIState.None
        op.t[i] = nil
        if tablex.size(op.t) == 0 then
            if op.callFunc then
                op.callFunc()
            end
            endCallBack()
        end
    end
    local function startRemove()
        local noAni = op.noAni
        for i,v in ipairs(op.t) do
            local op = v
            op.data.uiState = UIState.None
            local time = op.time
            if noAni then
                time = 0
            end
            if op.data.StartRemoving then
                op.data:StartRemoving(time)
            end
            self:Timer(currDeal, time, function()
                Removing(i)
            end)
        end
    end
    startRemove()
    local op_ = op.t[1];
    local opFullScreen = false;
    if op_ and op_.tbData then
        opFullScreen = op_.tbData.bFullScreen;
    end
    self:optimize(opFullScreen)
end

function UIMgr:__LogicOP_Exit(currDeal, op, endCallBack)
    local  function Exiting()
        if op.data.OnClose then
            op.data:OnClose(false)
        end
        op.uiData.state = UIState.Exited
        endCallBack()
    end
    local function startExit()
        op.data.uiState = UIState.Exited
        local time = op.time
        if op.noAni then
            time = 0
        end
        if op.uiData.state == UIState.None then
            op.time = 0
        elseif op.uiData.state == UIState.Exited then
            op.time = 0
        elseif op.uiData.state == UIState.Entered then
            if op.data.StartExit then
                op.data:StartExit(time)
            end
        end
        self:Timer(currDeal, time, function()
            Exiting()
        end)
    end
    startExit()

    self:optimize()
end

function UIMgr:__LogicOP_Create(currDeal, op, endCallBack)
    LuaLogger.ds("__LogicOP_Create")
    local function Creating()
        op.uiData.state = UIState.Entered
        endCallBack()
    end
    local function startCreate()
        --异步加载prefab
        local tbData = op.tbData
        local frame = op.frame
        --单例处理
        local newInst = true
        if tbData.Singleton then
            newInst = false
        end
        local uiObj = nil
        for i,v in ipairs(self.UI) do
            if v.tbData.id == tbData.id and v.bClose == true then
                uiObj = v.ui.gameObject
                break
            end
        end
        local createFunc =  function(obj)
            if obj  then
                local ui = obj:GetComponentLua(tbData.LuaName)
                AudioMgr:set2DSoundMute(true)
                if ui == nil then
                    ui = obj:AddComponentLua(tbData.LuaName, op.data)
                    ui:AfterInit()
                    self:CallInit(ui, tbData)
                end
                if ui then
                    local uiType = tbData.UIType
                    local t = self:doAddUI(ui, op, uiType)
                    -- 必须在 doAddUI 之后调用，确保 UI 已加入 self.UI，
                    -- 这样 checkDelayUIRemove 触发的 doCloseUI 能找到该 UI 并正确关闭。
                    self:removeDelayUI(frame)
                    ui.uiState = UIState.Entered
                    if op.callFunc then
                        op.callFunc(ui)
                    end
                    self:CallOpen(ui, tbData)
                    if ui.OnOpenStart then
                        ui:OnOpenStart(op.data, true)
                        if uiType == UIType.Wnd and not ui.isHide then
                            ui.super:OnOpen(op.data,nil, ui)
                        end
                    end
                    -- if uiType == UIType.Wnd then
                    --     self:PlayBGM(tbData)
                    -- end
                    local time = op.time
                    if op.noAni then
                        time = 0
                    end
                    if t.state == UIState.None then
                        if ui.StartCreating then
                            ui:StartCreating(time)
                        end
                    elseif t.state == UIState.Exited then
                        --单例模式下exit以后再create
                        op.time = tbData.EnterTime
                        if ui.StartEnter then
                            ui:StartEnter(time)
                        end
                    elseif t.state == UIState.Entered then
                        op.time = 0
                    end
                    op.uiData = t
                    AudioMgr:set2DSoundMute(false)
                    self:Timer(currDeal, time, function()
                        Creating()
                    end)
                else
                    AudioMgr:set2DSoundMute(false)
                    endCallBack()
                end
            else
                endCallBack()
            end
        end
        if uiObj then
            createFunc(uiObj)
        else
            self:doLoadUISync(UICommonUtils.GetUIPath(tbData.AssetPath),function(obj)
                createFunc(obj)
            end,newInst,false)
        end
    end
    startCreate()
end

function UIMgr:__LogicOP_Enter(currDeal, op, endCallBack)
    local function Entering()
        op.uiData.state = UIState.Entered
        endCallBack()
    end
    local function startEnter()
        AudioMgr:set2DSoundMute(true)
        op.data.uiState = UIState.Entered
        -- if op.data.OnOpen then
        --     op.data:OnOpen(nil, false)
        -- end
        --self:PlayBGM(op.tbData)
        local time = op.time
        if op.noAni then
            time = 0
        end
        if op.uiData.state == UIState.None then
            --不应该进到这里
            op.time = op.tbData.OpenTime
            if op.data.StartCreating then
                op.data:StartCreating(time)
            end
        elseif op.uiData.state == UIState.Exited then
            if op.data.StartEnter then
                op.data:StartEnter(time)
            end
        elseif op.uiData.state == UIState.Entered then
            op.time = 0
        end
        AudioMgr:set2DSoundMute(false)
        self:Timer(currDeal, time, function()
            Entering()
        end)
    end
    startEnter()
end

function UIMgr:__Create_Loader(tmpCount, customQueue)
    local op1 = nil
    local op2 = nil
    local queue = customQueue
    if not queue then
        queue = self.LoaderQueue[1]
        if queue == nil then
            return
        end
        table.remove(self.LoaderQueue, 1)
    end

    local opertype = queue.opertype
    --初始化 op1 op2
    local currDeal = nil
    local loaderID = nil
    if opertype == OperType.Create then
        local currOperType = OperType.Create
        local data = queue.data
        local tbData = queue.tbData
        local callFunc = queue.callFunc
        op2 = { time = 0, callFunc = callFunc, opertype = currOperType, data = data, tbData = tbData, uiData = nil}
        currDeal = {}
        currDeal.ops = {}
        currDeal.AssetPath = tbData.AssetPath
        table.insert(currDeal.ops, op1)
        table.insert(currDeal.ops, op2)
        loaderID = data.id
        self.currDeal_Loader[loaderID] = currDeal
    elseif opertype == OperType.Remove then
        local bDelete = queue.bDelete

        local currOperType = OperType.Remove
        local obj = queue.data
        local tbData = queue.tbData
        op1 = { time = 0, opertype = currOperType, data = obj, tbData = tbData, uiData = nil, bDelete = bDelete}
        currDeal = {}
        currDeal.ops = {}
        table.insert(currDeal.ops, op1)
        table.insert(currDeal.ops, op2)
        loaderID = op1.data
        --如果没有创建
        if self.currDeal_Loader[loaderID] and self.Loader == nil then
            if not tmpCount then
                tmpCount = 1
            end
            if tmpCount <= 10 then
                EngineUtil.DelayCallback(1,function()
                    self:__Create_Loader(tmpCount, queue)
                end)
            end
            currDeal = nil
        end
    end

    if currDeal then
        local function opEnd()
            if opertype == OperType.Remove then
                self.currDeal_Loader[loaderID] = nil
            end
            --设置为可点击
            --print("Enable true", queue.tbData.id, debug.traceback())
            self:optimize()
            self.EnableInput(true)
        end

        local function AllOps()
            local op = currDeal.ops[1]
            if op == nil then
                opEnd()
                return
            end
            self:__LogicLoaderOP(currDeal, op, function()
                table.remove(currDeal.ops, 1)
                AllOps()
            end)
        end
        self.EnableInput(false)
        AllOps()
        return true
    end
end

function UIMgr:__LogicLoaderOP(currDeal, op, endCallBack)
    if op.opertype == OperType.Remove then
        self:__LogicLoaderOP_Remove(currDeal, op, endCallBack)
    elseif op.opertype == OperType.Exit then
    elseif op.opertype == OperType.Create then
        self:__LogicLoaderOP_Create(currDeal, op, endCallBack)
    elseif op.opertype == OperType.Enter then
    end
end

function UIMgr:__LogicLoaderOP_Create(currDeal, op, endCallBack)
    local function showLoader()
        --防止第一个异步加载的loader 在异步加载之前remove掉了但却通过回调打开了
        if self.Loader and self.currDeal_Loader[op.data.id] then
            currDeal.showed = true
            self.Loader.ui:Show()
        end
    end

    local function startCreate(endCreate)
        if self.isCreatingLoader then
            return
        end
        if self.Loader == nil then
            --异步加载prefab
            local tbData = op.tbData
            --单例处理
            local newInst = true
            if tbData.Singleton then
                newInst = false
            end
            local uiObj = nil
            for i,v in ipairs(self.UI) do
                if v.tbData.id == tbData.id and v.bClose == true then
                    uiObj = v.ui.gameObject
                    break
                end
            end
            local createFunc =  function(obj)
                if obj  then
                    local ui = obj:GetComponentLua(tbData.LuaName)
                    AudioMgr:set2DSoundMute(true)
                    if ui == nil then
                        ui = obj:AddComponentLua(tbData.LuaName, op.data)
                        ui:AfterInit()
                        self:CallInit(ui, tbData)
                    end
                    if ui then
                        local t = self:doAddUI(ui, op, UIType.Loader)
                        ui.uiState = UIState.Entered
                        if op.callFunc then
                            op.callFunc(ui)
                        end
                        self:CallOpen(ui, tbData)
                        if ui.OnOpenStart then
                            ui:OnOpenStart(op.data, true)
                        end
                        if t.state == UIState.None then
                            if ui.StartCreating then
                                ui:StartCreating(op.time)
                            end
                        elseif t.state == UIState.Exited then
                            --单例模式下exit以后再create
                            op.time = tbData.EnterTime
                            if ui.StartEnter then
                                ui:StartEnter(op.time)
                            end
                        elseif t.state == UIState.Entered then
                            op.time = 0
                        end
                        op.uiData = t
                        AudioMgr:set2DSoundMute(false)
                        self:Timer(currDeal, op.data.time, function()
                            showLoader()
                        end)
                    else
                        AudioMgr:set2DSoundMute(false)
                    end
                else

                end
            end
            if uiObj then
                createFunc(uiObj)
                endCreate()
            else
                self.isCreatingLoader = true
                self:doLoadUISync(UICommonUtils.GetUIPath(tbData.AssetPath),function(obj)
                    createFunc(obj)
                    self.isCreatingLoader = false
                    endCreate()
                end,newInst,false)
            end
        else
            op.uiData = self.Loader
            self:Timer(currDeal, op.data.time, function()
                showLoader()
            end)
            endCreate()
        end
    end
    startCreate(function()
        op.uiData.state = UIState.Entered
        endCallBack()
    end)
end

function UIMgr:__LogicLoaderOP_Remove(currDeal, op, endCallBack)
    local function resetShowHide()
        if self.Loader then
            self.Loader.ui:Hide()
            for _,v in pairs(self.currDeal_Loader) do
                if v.showed then
                    self.Loader.ui:Show()
                    return
                end
            end
            if tablex.size(self.currDeal_Loader) == 0  then
                if self.Loader.ui.OnClose then
                    self.Loader.ui:OnClose(true)
                end
                self:CallClose(self.Loader.ui, op.tbData)
                self.Loader.ui.state = UIState.None
                self:doRemoveUI(self.Loader.ui, op.tbData, UIType.Loader, false)
            end
        end
    end
    local function startRemove()
        local id = op.data
        if self.currDeal_Loader[id] then
            if self.currDeal_Loader[id].timer then
                for k,v in pairs(self.currDeal_Loader[id].timer) do
                    self:RemoveTimer(self.currDeal_Loader[id], k)
                end
            end
            self.currDeal_Loader[id] = nil
            LuaLogger.ds("Remove Loader", id)
            resetShowHide()
        end
    end
    startRemove()
    endCallBack()
end

function UIMgr:__Create_Toast(endCallBack)
    local queueIndex = nil
    if #self.ToastQueue > 0 then
        for index, queue in pairs(self.ToastQueue) do
            local canNewToast = true
            for k,v in pairs(self.currDeal_Toast) do
                if queue.tbData.ToastGroup == v.tbData.ToastGroup then
                    if queue.tbData.BAhead then
                        if v.canCreatNext == nil then
                            canNewToast = false
                            break
                        end
                    else
                        canNewToast = false
                        break
                    end
                end
            end
            if canNewToast == true then
                queueIndex = index
                break
            end
        end
    end

    if queueIndex == nil then
        return
    end

    local queue = self.ToastQueue[queueIndex]
    if queue == nil then
        return
    end
    table.remove(self.ToastQueue, queueIndex)
    local opertype = queue.opertype
    local fixSpeed = 1
    local op2
    local newToast
    if opertype == OperType.Create then
        local time = queue.tbData.OpenTime * fixSpeed
        local currOperType = OperType.Create
        local data = queue.data
        local tbData = queue.tbData
        local callFunc = queue.callFunc
        local AheadTime = tbData.AheadTime
        if tbData.BAhead then
            if AheadTime < 0  then
                AheadTime = AheadTime + tbData.OpenTime + tbData.CloseTime + tbData.ShowTime
            end
        else
            AheadTime = tbData.OpenTime + tbData.CloseTime + tbData.ShowTime
        end
        AheadTime = AheadTime*fixSpeed
        op2 = { time = time, callFunc = callFunc, opertype = currOperType, data = data, tbData = tbData, uiData = nil, AheadTime = AheadTime, Speed = fixSpeed, bDelete = false}
        newToast = {}
        newToast.tbData = tbData
        newToast.ops = {}
        table.insert(newToast.ops, op2)
        table.insert(self.currDeal_Toast, newToast)
    end

    if newToast then
        local function opEnd()
            for kk,vv in pairs(self.currDeal_Toast) do
                if vv == newToast then
                    table.remove(self.currDeal_Toast, kk)
                    break
                end
            end
            self:__Create_Toast()
            if endCallBack then
                endCallBack()
            end
        end

        local function AllOps()
            local op = newToast.ops[1]
            if op == nil then
                opEnd()
                return
            end
            self:__LogicToastOP(newToast, op, function()
                table.remove(newToast.ops, 1)
                AllOps()
            end)
        end
        AllOps()
    end

end

function UIMgr:__LogicToastOP(currDeal, op, endCallBack)
    if op.opertype == OperType.Create then
        self:__LogicToastOP_Create(currDeal, op, endCallBack)
    end
end

function UIMgr:__LogicToastOP_Create(currDeal, op, endCallBack)
    local function Removing()
        if op.bDelete == true then
            op.uiData.ui.isDeleting = true
        end
        if op.uiData.ui.OnClose then
            op.uiData.ui:OnClose(true)
        end
        self:CallClose(op.uiData.ui, op.tbData)
        if op.bDelete == true then
            self:CallRemove(op.uiData.ui, op.tbData)
        end
        self:doRemoveUI(op.uiData.ui, op.tbData, UIType.Toast, op.bDelete)
        op.uiData.state = UIState.None
        op.removed = true
        endCallBack()
    end
    local function Showing()
        op.uiData.state = UIState.Entered
        op.showed = true
        op.time = op.tbData.CloseTime * op.Speed
        if op.uiData.ui.StartRemoving then
            op.uiData.ui:StartRemoving(op.time)
        end
        self:Timer(currDeal, op.time, function()
            Removing()
        end)
    end
    local function Creating()
        op.uiData.state = UIState.Entered
        op.entered = true
        op.time = op.tbData.ShowTime * op.Speed
        if op.uiData.ui.StartShowing then
            op.uiData.ui:StartShowing(op.time)
        end
        self:Timer(currDeal, op.time, function()
            Showing()
        end)
    end
    local function startCreate()
        local tbData = op.tbData
        --单例处理
        local newInst = true
        -- if tbData.Singleton then
        --     newInst = false
        -- end
        local uiObj = nil
        for i,v in ipairs(self.UI) do
            if v.tbData.id == tbData.id and v.bClose == true then
                uiObj = v.ui.gameObject
                break
            end
        end
        local createFunc =  function(obj)
            if obj  then
                local ui = obj:GetComponentLua(tbData.LuaName)
                AudioMgr:set2DSoundMute(true)
                if ui == nil then
                    ui = obj:AddComponentLua(tbData.LuaName, op.data)
                    ui:AfterInit()
                    self:CallInit(ui, tbData)
                end
                if ui then
                    local t = self:doAddUI(ui, op, UIType.Toast)
                    ui.uiState = UIState.Entered
                    if op.callFunc then
                        op.callFunc(ui)
                    end
                    self:CallOpen(ui, tbData)
                    if ui.OnOpenStart then
                        ui:OnOpenStart(op.data, true)
                    end
                    if t.state == UIState.None then
                        if ui.StartCreating then
                            ui:StartCreating(op.time)
                        end
                    elseif t.state == UIState.Exited then
                        --单例模式下exit以后再create
                        op.time = tbData.EnterTime
                        if ui.StartEnter then
                            ui:StartEnter(op.time)
                        end
                    elseif t.state == UIState.Entered then
                        op.time = 0
                    end
                    op.uiData = t
                    if op.AheadTime then
                        self:Timer(currDeal, op.AheadTime, function()
                            currDeal.canCreatNext = true
                            self:__Create_Toast()
                        end)
                    end
                    AudioMgr:set2DSoundMute(false)
                    self:Timer(currDeal, op.time, function()
                        Creating()
                    end)
                else
                    AudioMgr:set2DSoundMute(false)
                end
            else
            end
        end
        if uiObj then
            createFunc(uiObj)
        else
            self:doLoadUI(UICommonUtils.GetUIPath(tbData.AssetPath),function(obj)
                createFunc(obj)
            end,newInst,false)
        end
    end
    startCreate()
end

function UIMgr:ReloadWnd(name)
    --local wnd = self:GetWndByName(name)
    --self:removeUI(name, nil, function ()
    --    self:popUI(name, wnd.data, wnd.callFunc, wnd.noExitAni)
    --end)
    --
    --if true then
    --    return
    --end
    --
    ReloadModule(name)

    local newTb
    for k,v in pairs(self.UI) do
        local ui = v.ui
        if ui.uiConfig.id == name then
            local luaMono = ui.gameObject:GetComponent(typeof(LuaMono))
            luaMono:Reload()
            newTb = luaMono.LuaScriptIns
            newTb.uiConfig = ui.uiConfig
            if v.ui.OnClose then
                v.ui:OnClose(true)
            end
            if v.ui.OnDestroy then
                v.ui:OnDestroy()
            end
            v.ui:AutoReleaseTimers()
            v.ui:AutoReleaseAssets()
            v.ui:UnRegAllMsg(GameMsgMgr)
            v.ui = newTb
            AudioMgr:set2DSoundMute(true)
            self:CallInit(v.ui, v.tbData)
            v.ui:OnOpenStart(v.openData, true)
            AudioMgr:set2DSoundMute(false)
            break
        end
    end
end

function UIMgr:GetWndByName(name)
    for k,v in pairs(self.UI) do
        local ui = v.ui
        if ui.uiConfig.id == name then
            return ui
        end
    end
end

function UIMgr:GetTopUI()
    for i = #self.UI, 1, -1 do
        local wndData = self.UI[i]
        if not wndData.bClose then
            return wndData.ui
        end
    end
    LuaLogger.e("No UI")
end

function UIMgr:GetTopWnd()
    for i = #self.Wnd, 1, -1 do
        local wndData = self.Wnd[i]
        if not wndData.bClose then
            return wndData.ui
        end
    end
    LuaLogger.e("TopWnd not found")
end

function UIMgr:RemoveTopWnd(reload)
    if reload then
        local wndName = self:GetTopWnd().uiConfig.id
        ReloadModule(wndName) 
    end
    
    self:removeUI(self:GetTopWnd())
end

function UIMgr:_RemoveAllUIDo()
    local wndDatas = {}
    for i = #self.UI, 1, -1 do
        local wndData = self.UI[i]
        local wndName = wndData.ui.uiConfig.id
        if not wndData.bClose and wndName ~= "AdapterPanel" and wndName ~= "InterludeLoadingPanel" 
          and wndName ~= "UISwitchPanel" then
            table.insert(wndDatas, wndData)
        end
    end

    for i, v in ipairs(wndDatas) do
        self:removeUI(v.ui)
    end
end

function UIMgr:_RemoveAllUIImmediatelyDo()
    local wndDatas = {}
    for i = #self.UI, 1, -1 do
        local wndData = self.UI[i]
        local wndName = wndData.ui.uiConfig.id
        if not wndData.bClose and wndName ~= "AdapterPanel" and wndName ~= "InterludeLoadingPanel" 
        and wndName ~= "UISwitchPanel" then
            table.insert(wndDatas, wndData)
        end
    end

    for i, v in ipairs(wndDatas) do
        self:removeUIImmediately(v.ui)
    end
end

function UIMgr:ClearLoader()
    if self.currDeal_Loader == nil then
        return
    end
    local delKey = {}

    local tbData = Config.GetUIConfigInfo("Loader")
    if tbData == nil then
       return 
    end
    for k, v in pairs(self.currDeal_Loader) do
        if v.AssetPath == tbData.AssetPath then
           table.insert(delKey, k) 
        end
    end
    for i = 1, #delKey do
        self.currDeal_Loader[delKey[i]] = nil
    end
    if self.Loader ~= nil then
        self.Loader.ui:Hide()
    end

    self:CheckAllImageLoaders()
end

function UIMgr:SetRtCanvasOrder(order)
    UIManager.rtCanvas.sortingOrder = order
end


---发送打开界面埋点
---调整为按钮点击埋点日志
function UIMgr:SendUiUseMessage(uiName)
    -- print("SendUiUseMessage", uiName)
    -- if (not Config.UiUseStr[uiName]) then
    --     return
    -- end
    if Me and Me.uid then
        local data = {
            user_name = Me:getUserName(),
            user_aid = Me.aid,
            user_uid = Me.uid,
            ui_name = uiName,
            distinct_id = SDKMgr:getDistinctId(),
            server_id = GV.GlobalConfig.LogServerId
        }
        -- ClientData:sendDailyLogMessage(data)
        ThinkingAnalytics:track("ui_use", data)
    end
end




---@param image UnityEngine.UI.Image Image
---@param path string 路径
---@param owner UnityEngine.GameObject
---@param callback fun(sprite:UnityEngine.Sprite, image:UnityEngine.UI.Image, path:string)? 完成时回调
function UIMgr:LoadSprite(image, path, owner, callback)

    if IsNull(owner) then
       return 
    end

    if IsNull(image) then
       return 
    end
    if string.isNullOrEmpty(path) then
       return 
    end

    local spriteName = string.match(path, Config.Match.FileName)
    if (not IsNull(image.sprite)) and image.sprite.name == spriteName then
        if callback then
            callback(image.sprite, image, path)
        end
        return
    end
    self.imageLoaders = self.imageLoaders or {}
    ---@type integer
    local id = image.gameObject:GetInstanceID()
    ---@type SpriteLoaderData
    local data = self.imageLoaders[id]


    if data == nil then
        data = SpriteLoaderData:InitData()
        data.id = id
        data.image = image
        data.loadPath = path
        data.loadingPath = path
        data.spriteName = spriteName
        data.callback = callback
        data:Init()
        self.imageLoaders[id] = data
    else
        data.callback = callback
        if data.loadPath == path then
            if IsNull(data.image.sprite) or data.image.sprite.name ~= spriteName then
                data.loadPath = nil
            else
                if callback then
                    callback(data.image.sprite, image, path)
                end
                return
            end
        end

        if data.loadingPath == path then
            data.callback = callback
            return
        end
        data.spriteName = spriteName
        data.loadingPath = path
    end
    ResMgr:LoadSpriteAsync(path, owner, function(sprite)
        data:Loader(sprite, path)
    end)
end

---删除卸载的image
---@param id integer
function UIMgr:DeleteImageLoader(id)
    if self.imageLoaders == nil then
        return
    end
    local loadData = self.imageLoaders[id]
    if loadData == nil then
       return 
    end
    loadData:OnRelease()
    self.imageLoaders[id] = nil
end

---检测被删除的image
function UIMgr:CheckAllImageLoaders()
    if self.imageLoaders == nil then
       return 
    end

    for k, v in pairs(self.imageLoaders) do
        if IsNull(v.image) then
            self.imageLoaders[k] = nil
        end
    end
end



-- 加载并扩展 UIMgrExtension.lua
local UIMgrExtension = require "UIMgrExtension"

for k, v in pairs(UIMgrExtension) do
    UIMgr[k] = v
end




return UIMgr