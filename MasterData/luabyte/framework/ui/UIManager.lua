UIManager = BaseClass("UIManager", Singleton)
local M = UIManager

-- 构造函数
function M:__init()
    self._allCtrl = {}
    self._topCanvas = nil
    self._canvasTransformNormal = nil
    self._canvasTransformFixed = nil
    self._canvasTransformPopUp = nil
    self._canvasTransformTop = nil
    self._canvasTransformTimeline = nil
    self._allVisibuleCallback = {}
end

function M:CreateUI(strUIforName, gameObject, ctrlClassName, viewClassName)
    local ctrlCls = require(ctrlClassName)
    local viewCls = require(viewClassName)

    if viewCls == nil or type(viewCls) ~= "table" then
        Logger.LogError("view error : " .. viewClassName)
    end

    local view = viewCls.New(gameObject)
    self._allCtrl[strUIforName] = ctrlCls.New(strUIforName, view)
end

function M:DestoryAll()
    for _, uiCtrl in pairs(self._allCtrl) do
        if uiCtrl then uiCtrl:OnDispose() end
    end
end

function M:Show(strUIFormName, ...)
    IUIManager:Show(strUIFormName)

    local uiCtrl = self._allCtrl[strUIFormName]
    if uiCtrl ~= nil then
        if uiCtrl.OnEnter then uiCtrl:OnEnter(...) end
        if uiCtrl.OnShow then uiCtrl:OnShow() end
    else
        print('xxxxxxxxxxxxxxa')
    end

    if self._allVisibuleCallback[strUIFormName] then
        self._allVisibuleCallback[strUIFormName]()
        self._allVisibuleCallback[strUIFormName] = nil
    end
end

function M:SetVisibleCallback(uiName, callback)
    if uiName and callback then
        self._allVisibuleCallback[uiName] = callback
    end
end

function M:CacheAysn()
    IUIManager:CacheAysn()
end

function M:GetCtrl(uiName)
    if self._allCtrl[uiName] then
        return self._allCtrl[uiName]
    end
    return nil
end

function M:GetTopCtrl(formsType)
    return IUIManager:GetTopCtrl(formsType)
end

function M:IsShow(uiname)
    return IUIManager:IsShow(uiname)
end

function M:isVisible(uiName)
    return IUIManager:isVisible(uiName)
end

function M:Close(strUIFormName)
    IUIManager:Close(strUIFormName)
    self:_Close(strUIFormName)
end

function M:_OnVisible(uiName, isVisible)
    local uiCtrl = self._allCtrl[uiName]
    if uiCtrl ~= nil then
        if isVisible then
            if uiCtrl.OnVisible then uiCtrl:OnVisible() end
        else
            if uiCtrl.OnInvisible then uiCtrl:OnInvisible() end
        end
    end
end

function M:_CtrlOnDeviceBack(uiName)
    local uiCtrl = self._allCtrl[uiName]
    if uiCtrl ~= nil and uiCtrl.OnDeviceBack then
        return uiCtrl:OnDeviceBack()
    end
    return false
end

function M:_Close(strUIFormName)
    if self._allCtrl[strUIFormName] ~= nil then
        self._allCtrl[strUIFormName]:OnClose()
    end
end

function M:_Destory(strUIFormName)
    local uiCtrl = self._allCtrl[strUIFormName]
    if uiCtrl ~= nil then
        if uiCtrl.OnClose ~= nil then uiCtrl:OnClose() end

        uiCtrl:OnDispose()
    end

    self._allCtrl[strUIFormName] = nil
end

function M:SwitchScene()
    IUIManager:SwitchScene()
end

function M:Destory(strUIFormName)
    self._allCtrl[strUIFormName] = nil
    IUIManager:Destory()
end

function M:topCanvas()
    if self._topCanvas == nil then
        self._topCanvas = IUIManager.topCanvas
    end
    return self._topCanvas
end

function M:canvasTransformNormal()
    if self._canvasTransformNormal == nil then
        self._canvasTransformNormal = IUIManager.canvasTransformNormal
    end
    return self._canvasTransformNormal
end

function M:canvasTransformFixed()
    if self._canvasTransformFixed == nil then
        self._canvasTransformFixed = IUIManager.canvasTransformFixed
    end
    return self._canvasTransformFixed
end

function M:canvasTransformPopUp()
    if self._canvasTransformPopUp == nil then
        self._canvasTransformPopUp = IUIManager.canvasTransformPopUp
    end
    return self._canvasTransformPopUp
end

function M:canvasTransformTop()
    if self._canvasTransformTop == nil then
        self._canvasTransformTop = IUIManager.canvasTransformTop
    end
    return self._canvasTransformTop
end

function M:canvasTransformTimeline()
    if self._canvasTransformTimeline == nil then
        self._canvasTransformTimeline = IUIManager.canvasTransformTimeline
    end
    return self._canvasTransformTimeline
end

return UIManager;
