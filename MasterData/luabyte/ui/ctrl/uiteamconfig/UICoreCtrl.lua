--baoruichang
local UICoreCtrl = BaseClass("UICoreCtrl")
local M = UICoreCtrl
local ITEMNUM = 6

function M:__init(view)
    self._view = view
end

function M:Updata(star, showBg)

    for i = 1, ITEMNUM do
        if showBg then
            self._view["tf" .. i].gameObject:SetActive(i <= star)
            self._view["tf" .. i].parent.gameObject:SetActive(true)
        else
            self._view["tf" .. i].gameObject:SetActive(i <= star)
            self._view["tf" .. i].parent.gameObject:SetActive(i <= star)
        end
    end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UICoreCtrl
