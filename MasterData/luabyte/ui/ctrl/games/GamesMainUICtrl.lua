local GamesMainUICtrl = BaseClass("GamesMainUICtrl", BaseUICtrl)
local M = GamesMainUICtrl


function M:_GameSelect(id)
    if self._curGameId == id then
        self:_OpenGameDetails(id)
        return
    end

    self:_PlayGameAni(id)
    self._curGameId = id
end


function M:_PlayGameAni(id)
    for _,v in pairs(self._games) do
        if v:Id() == self._curGameId then 
            v:NormalAni() 
        end

        if v:Id() == id then 
            v:PlayAni() 
        end 
    end
end


function M:_OpenGameDetails(id)
    UIContextMgr:GetInstance():Show('GamesDetailsUI', id)
end


function M:OnEnter()
    self._curGameId = 0 
    self._gamesCfg = ConfigHelper.GetCfgs("gameMachine")

    GameHelper.PlayAudioById(1244)
    GamesDataMgr:GetInstance():HeroGamesData()
end


function M:_InitGames()
    self._games = {}
    for _,v in ipairs(self._gameList) do
        local data = ConfigHelper.GetCfg('gameMachine', v)
        self:_CreateGame(data)
    end

    self:_CreateGame({id = -100,})
end


function M:_CreateGame(data)
    local _obj = GameUtil.Instantiate(self._view.game, self._view.content.transform)
    table.insert(self._games, self._gameItemCtrl.New(self._gameItemView.New(_obj), data))
end


function M:Init() 
    self._gameItemCtrl = require("UI.Ctrl.Games.GameItemCtrl")
    self._gameItemView = require("UI.View.Games.GameItemView")
  
    self._gameList = {}
    self._games = {}

    self._view.closeBtn:onClick(Bind(self, self._OnClickClose))
    
    self._gameSelect = EventMgr:AddListener(UIMessageNames.GAME_SELECE, Bind(self, self._GameSelect))
    self._gameData = EventMgr:AddListener(UIMessageNames.GAME_GAMEEFRESH, Bind(self, self._OnRefreshData))
end


function M:_OnClickClose()
    self:Close()
end


function M:_OnRefreshData()
    self._gameList = GamesDataMgr:GetInstance():Games()
    self:_InitGames()
end


function M:OnClose()
    for _,v in pairs(self._games) do
        v:Close()
    end

    self._games = nil
    self._gameItemCtrl = nil
    self._gameItemView = nil

    EventMgr:RemoveListener(UIMessageNames.GAME_SELECE, self._gameSelect)
    EventMgr:RemoveListener(UIMessageNames.GAME_GAMEEFRESH, self._gameData)
end






return GamesMainUICtrl
