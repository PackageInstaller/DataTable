local GameMainUICtrl = BaseClass("GameMainUICtrl")
local M = GameMainUICtrl


function M:Id()
    return self._data.id
end

function M:PlayAni()
    self._gameAnimator.enabled = true
    self._gameAnimator:Play("ToggleGameBee")
end

function M:NormalAni()
    self._gameAnimator.enabled = false
end

function M:Close()
    self._data = nil
    self._gameAnimator = nil

    if self._game then
        self._game:Destory()
        self._game = nil
    end

    self:Delete(self)
end

function M:_InitGamePrefab()
    ResourceManager:GetInstance():InstanceView(GamesHelper.GamePrefabPath(self._data.id), function(go)
        self:_GameView(go)
    end)
end

function M:_GameView(view)
    self._game = view
    self._game:SetParent(self._view.game.transform)
    self._game:Reset()
    self._gameAnimator = self._game:FindComponent(typeof(CS.UnityEngine.Animator))
    self:NormalAni()
end

function M:_OnClickItem()
    if self._data.id < 0 then
        return
    end

    EventMgr:Broadcast(UIMessageNames.GAME_SELECE, self._data.id)
end

function M:__init(view, data)
    self._view = view
    self._data = data
    self._game = nil
    self._gameAnimator = nil

    self._view.transform:onClick(Bind(self, self._OnClickItem))

    if self._data.id > 0 then
        self:_InitGamePrefab()
    end
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return GameMainUICtrl
