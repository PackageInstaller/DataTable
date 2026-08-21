local UIVotingGetMoreItemCtrl = BaseClass("UIVotingGetMoreItemCtrl")
local M = UIVotingGetMoreItemCtrl

function M:__init(view)
    self._view = view
    self._view.btn:SetOnClick(self, self.OnClickBtn)
end

function M:UpdateItem(data)
    self.data = data
    self._view.textDesc:SetText(data.desc)
end

function M:OnClickBtn()
    if GameHelper.Jump(self.data.id) then
        UIContextMgr:GetInstance():Close(UIDefine.UIVotingGetMore)
        UIContextMgr:GetInstance():Close(UIDefine.UIVoting)
    end
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return UIVotingGetMoreItemCtrl
