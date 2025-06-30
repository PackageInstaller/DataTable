local this = require "UI.UIDialog.UIDialogView"

function this.OnCgEnable(self)

end

function this.OnCgDisable(self)
    self.cg:GetComponent("Image").sprite = nil
end

-- 显示cg
function this.ShowCg(self, path, time)
    if time == nil or string.IsNullOrEmpty(time) then
        time = 0.5
    end
    if string.IsNullOrEmpty(path) then
        self.cg:SetActive(false)
        return
    end
    self.cg:SetActive(true)
    local img = self.cg:GetComponent("Image")
    img:DOFade(0, 0)
    coroutine.start(function ()
        img.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path)
        img:SetNativeSize()
        img:DOFade(1, time)
    end)
end

return this