local FriendUICtrl = BaseClass("FriendUICtrl", BaseUICtrl)
local M = FriendUICtrl



function M:OnEnter()
    self:_OnClickUpdatePanel("info")
    GameHelper.DoPlayerAction(PlayerAction.OpenFriend)
end


function M:Init()
    self._uiConfig = {"info", "friend", "apply", "add", "up"}
    self:_InitBtn()
end

--点击设置退出键
function M:OnDeviceBack()
    if UIContextMgr:GetInstance():isVisible("SelectHero") then 
        UIContextMgr:GetInstance():Close("SelectHero")
        return true
    end
    self:Close()
    return true
end

function M:OnClose()
    UIContextMgr:GetInstance():Close("SelectHero")
end

function M:_InitBtn()
    for _,v in pairs(self._uiConfig) do
        local btn = string.format("%sUnSelect", v)
        self._view[btn]:onClick(Bind(self, self._OnClickUpdatePanel, v))
    end
end


function M:_OnClickUpdatePanel(type)
    for _,v in ipairs(self._uiConfig) do
        local state = v == type 
        local funcName = state and "OpenPanel" or "Hide" 
        self._view[v][funcName](self._view[v])
        self:_SetTabState(v, state)
    end
end


function M:_SetTabState(name, b)
    local selectName = string.format("%sSelect", name)
    local unSelectName = string.format("%sUnSelect", name)
    self._view[selectName]:SetActive(b)
    self._view[unSelectName]:SetActive(not b)
end


return FriendUICtrl