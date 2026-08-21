local M = BaseClass("PlotAtlasProgressItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

-- 百科图鉴列表Item
function M:Init()
    self._callback = nil
    self._bookId = 0
    self._view.btn_enter:onClick(Bind(self, self._OnClickItem))
end

function M:UpdateItem(data)
    if data == nil then return end

    -- bookReward数据
    local bookId = data.Config.id
    if self._bookId ~= bookId then
        self._data = data
        self._bookId = bookId
        self._view.node_lock:SetActive(not self._data.IsUnlock)
        self._view.img_icon:SetPic(self._data.Config.smallPicture, false)
    end
    self._view.node_select:SetActive(self._data.IsSelect or false)

    self._view.redPoint:SetParam(0, self._bookId)
    self._view.redPoint:Check()
end

function M:Dispose()
    self._bookId = nil
    self._callback = nil
    M.super.Dispose(self)
end

-- 点击item
function M:_OnClickItem(go)
    if self._callback then
        PlayerPrefTools.SetPlayerPrefs("Encyclopedia" .. tostring(self._bookId), 1)
        IRedPointMgr:ForceCheck(RedPointConst.EncyclopediaByTypeRedPointChecker)
        self._callback(self._data)
    end
end

function M:SetClickCallback(callback)
    self._callback = callback
end

return M
