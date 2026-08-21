local M = BaseClass("BridgeUpgradeItemCtrl")
local numPath = "UI/SpritePics/common/RomanNum/ui_develop_text_%d.png"

function M:__init(view)
    self._view = view
end

function M:UpdateItem(data)
    self._view.txt_name:SetText(data.roomName)

    if data.curMaxNum > 9 then
        local low = data.curMaxNum % 10
        local hight = math.floor(data.curMaxNum / 10)
        self._view.img_nowLv2:SetPic(string.format(numPath, low))
        self._view.img_nowLv1:SetPic(string.format(numPath, hight))
        self._view.img_nowLv2:SetActive(true)
    else
        self._view.img_nowLv1:SetPic(string.format(numPath, data.curMaxNum))
    end

    if data.nextMaxNum > 9 then
        local low = data.nextMaxNum % 10
        local hight = math.floor(data.nextMaxNum / 10)
        self._view.img_nextLv2:SetPic(string.format(numPath, low))
        self._view.img_nextLv1:SetPic(string.format(numPath, hight))
        self._view.img_nextLv2:SetActive(true)
    else
        self._view.img_nextLv1:SetPic(string.format(numPath, data.nextMaxNum))
    end

    if data.roomIcon then self._view.img_icon:SetPic(data.roomIcon) end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
