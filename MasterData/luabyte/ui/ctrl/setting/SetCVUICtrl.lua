local SetCVUICtrl = BaseClass("SetCVUICtrl")

local M = SetCVUICtrl

function M:__init(view)
    self._view = view
    self._csUICV = self._view.transform:GetComponent(typeof(CS.GameX.SettingUICV))
end

function M:Open()

end


function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end
    self._csUICV = nil 
    self._view = nil
end

function M:RevertAll(active)
    if IsNull(self._csUICV) or not active then 
        return 
    end
    self._csUICV:RevertAll()
end

return SetCVUICtrl
