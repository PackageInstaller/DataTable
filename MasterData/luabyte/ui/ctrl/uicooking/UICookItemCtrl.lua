--baoruichang

local UICookItemCtrl = BaseClass("UICookingCtrl")
local M = UICookItemCtrl

function M:__init(view)
    self._view = view
    self._view.imgIcon:onClick(Bind(self,self._OnBtnClick))
end

function M:Update(data)
    self._view.imgIcon:SetItemIcon(data.Id)
    self:UpdateNum(data.Num)
    self:SetActive(true)
end

function M:UpdateNum(num)
    self._view.labNum:SetText(tostring(num))
end

function M:SetActive(state)
    self._view:SetActive(state)
end

function M:AddCallBack(callBack)
    self.callBack = callBack
end

function M:_OnBtnClick()
    if self.callBack then
        self.callBack()
    end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UICookItemCtrl
