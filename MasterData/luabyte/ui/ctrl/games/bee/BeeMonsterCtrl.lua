local BeeMonsterCtrl = BaseClass("BeeMonsterCtrl")
local M = BeeMonsterCtrl

function M:Index()
    return self._index
end

function M:Sorce()
    return self._sorce
end

function M:Min()
    return self._min
end

function M:Max()
    return self._max
end

function M:UpdataBeesPos(pos)
    self._min.x = self._baseMin.x + pos.x
    self._min.y = self._baseMin.y + pos.y
    self._max.x = self._baseMax.x + pos.x
    self._max.y = self._baseMax.y + pos.y
end

function M:TweenPause()
    self._view:DoTweenPause()
end

function M:TweenPlay()
    self._view:DoTweenPlay()
end

function M:_PlayAni(type)
    if type == 'Die' then

    end

    if type == 'Idle' then

    end

    if type == 'Fly' then

    end

    if type == 'Attack' then

    end
end

function M:__init(view, data)
    self._view = view
    self._id = data.id
    self._index = data.index
    self._sorce = data.sorce
    self._pos = data.pos

    self._beesPos = { x = 0, y = 0, z = 0 }
    self._size = GamesHelper.Games_BeeMonsterSize(self._id)
    self._min = {}
    self._max = {}

    self._baseMax = {}
    self._baseMin = {}
    self._baseMin.x = self._pos.x
    self._baseMax.y = self._pos.y
    self._baseMax.x = self._pos.x + self._size.x * 0.5
    self._baseMin.y = self._pos.y - self._size.y * 0.5

    self._view.image:SetPic(GamesHelper.Games_BeeMonsterImagePath(self._id))
    self._view:SetLocalPos(self._pos.x, self._pos.y, self._pos.z)
end

function M:Clear()
    if self._view then
        self._view:Destory()
        self._view = nil
    end

    self._id = nil
    self._index = nil
    self._sorce = nil
    self._pos = nil
    self._beesPos = nil
    self._size = nil
    self._max = nil
    self._min = nil
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return BeeMonsterCtrl
