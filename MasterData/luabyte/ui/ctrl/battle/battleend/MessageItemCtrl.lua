local MessageItemCtrl = BaseClass( 'MessageItemCtrl' )
local M = MessageItemCtrl 



function M:SetActive(isShow)
    self._view:SetActive(isShow)
end


function M:SetMessage(text)
    self._view.text:SetText(text)
end


function M:__init(view)
    self._view = view
end


function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end


return MessageItemCtrl
