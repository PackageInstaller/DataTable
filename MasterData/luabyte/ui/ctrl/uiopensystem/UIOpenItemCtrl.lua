--baoruichang

local UIOpenItemCtrl = BaseClass("UIOpenItemCtrl", UIBaseComponent)
local M = UIOpenItemCtrl
function M:__init(view)
    self._view = view
    self._view:onClick(Bind(self, self._OnItemClick))
end

function M:UpdateData(data)
    self.data = data
    self._view.labName:SetText(data.name)
    self._view.labDes:SetText(data.desc)
end

function M:_OnItemClick()
    JumpMgr:GetInstance():Execute(self.data.jumpId)
    UIContextMgr:GetInstance():Close(UIDefine.UIOpenSystem)
end

return UIOpenItemCtrl
