local BaseEventHandler = require "Framework.UI.BaseEventHandler"
BaseUICtrl = BaseClass("BaseUICtrl", BaseEventHandler)
local M = BaseUICtrl

function M:__init(strName, view)
    self._strName = strName
    self._view = view
    self.view = view
    self._canvasContainer = nil
    -- self._container = UIBaseContainer.New()
    self:Init()
    self.config = UIContextMgr:GetInstance():GetUIConfig(strName)
end

function M:GetCanvasContainer()
    if self._canvasContainer == nil then
        self._canvasContainer = self._view.transform.parent:GetComponent(typeof(CS.UnityEngine.Canvas))
    end
    return self._canvasContainer
end

function M:Init()
end

function M:OpenModule(moduleId, ...)
    ModuleMgr:GetInstance():ChangeModule(moduleId, ...)
end

--进入UI，可传参数
function M:OnEnter()
end

function M:OnShow()
end

--当盖住自己的全屏UI关闭时掉用
function M:OnVisible()
end

--当被全屏UI盖住时，调用此
function M:OnInvisible()
end

--关闭时回调，无参
function M:OnClose()
end

--设置退出时调用，返回TRUE则为拦截底层逻辑
function M:OnDeviceBack()
    return false
end

function M:OnDispose()
    M.super.OnDispose(self)
    
    if self._view then
        self._view:OnDispose()
    end
    
    self._view = nil
end

function M:OnBack()
    return true
end

function M:OnHome()
    return true
end

function M:OnTips()
    return true
end

function M:SetActive(value)
    self._view.transform:SetActive(value)
end

--获得上下文
function M:GetContext()
    return UIContextMgr:GetInstance():GetContext(self._strName)
end

function M:Close()
    UIContextMgr:GetInstance():Close(self._strName)
end

function M:ReturnMainUI()
    GameHelper.Jump(1)
end

return BaseUICtrl
