local PhotoWallDataMgr = BaseClass("PhotoWallDataMgr", Singleton)
local M = PhotoWallDataMgr
local VotingTimer = EnumConst.VotingTimer

function M:__init()
end

function M:UpdateData(data)
    self._data =data
end

function M:SetSelectIndex(selectIndex)
    self._selectIndex = selectIndex
end

function M:GetSelectIndex()
    return self._selectIndex or 0
end

--临时这样写
function M:GetHeroId()
    return 110003
end

return PhotoWallDataMgr
