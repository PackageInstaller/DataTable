local TestLuaComponentCtrl = BaseClass("TestLuaComponentCtrl" , BaseUICtrl )
local M = TestLuaComponentCtrl 

function M:Init()
    self._view.img_closeBtn:SetOnClick(function()
        self:Close()
    end)
    
end


function M:OnEnter()
    self._view.sRect_test:Init(require("UI.Ctrl.TestLuaComponent.TestLuaScrollItemCtrl"),require("UI.View.TestLuaComponent.TestLuaComponentScrollItem"))
    self._view.sRect_test._scrollView:SetDataList({[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}})
end

function M:OnClose()

end

function M:OnDispose()
    M.super.OnDispose(self)
end



return TestLuaComponentCtrl
