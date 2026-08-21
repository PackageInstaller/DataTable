local BeeGameCtrl = BaseClass("BeeGameCtrl", Updatable)
local M = BeeGameCtrl
local tInsert = table.insert
local tRemove = table.remove

function M:_InitMonsterData(line, index, pos)
    local data = {}
    data.id = GamesHelper.Random(self._levelConfig['type'..line], self._levelConfig['hight'..line])
    data.beeSize = GamesHelper.Games_BeeMonsterSize(data.id)
    data.index = (line - 1) * 10 + (index)
    data.sorce = self._levelConfig.fraction[data.id]
    data.posX = self._beeStartPos.x + (data.beeSize.x + self._beeSpacing) * (index - 1)
    data.posY = self._beeStartPos.y + (data.beeSize.y + self._beeSpacing) * line
    data.pos = {x = data.posX, y = data.posY}
    data.beeObj = data.id == 4 and self._view.bee2 or self._view.bee1
    data.beeView = data.id == 4 and self._bee2View or self._bee1View
    return data
end


function M:_CreateMonster(line, index, pos)
    if pos <= 0 then
        return
    end

    local data, obj, ctrl
    data = self:_InitMonsterData(line, index, pos)
    obj  = GameUtil.Instantiate(data.beeObj, self._view.bees.transform)
    ctrl = self._beeCtrl.New(data.beeView.New(obj), data )
    ctrl:UpdataBeesPos(self._view.bees.transform.localPosition)
    tInsert( self._bees , ctrl )
end


function M:_CreateMonsters(line)
    local nums = self._levelConfig['monsterGroup'..line]
    for i,v in ipairs(nums) do
        line = self._lineNum - (line - 1)
        self:_CreateMonster(line, i, v)
    end
end


function M:_InitMonsters()
    self._bees = {}
    for i=1,self._lineNum do
        self:_CreateMonsters(i)
    end
end


function M:_InitPlan()
    if not self._plane then
        local obj = GameUtil.Instantiate(self._view.plane, self._view.battle.transform)
        self._plane = self._planeCtrl.New(self._planeView.New(obj))
    end
    
    self._plane:Reset(self._planeSpacing, self._planeMaxSpacing)
end


function M:_InitBullet()
    for i = 1 , 20 do 
        local obj  = GameUtil.Instantiate(self._view.bullet.gameObject, self._view.battle.transform)
        local ctrl = self._bulletCtrl.New(self._bulletView.New(obj), self._bulletNum, self._bulletSpacing)
        ctrl:SetActive(false)
        tInsert(self._bulletPool,ctrl)
    end
    -- local obj, ctrl, pos
    -- self._bulletNum = self._bulletNum + 1
    -- obj  = GameUtil.Instantiate(self._view.bullet.gameObject, self._view.battle.transform)
    -- ctrl = self._bulletCtrl.New(self._bulletView.New(obj), self._bulletNum, self._bulletSpacing)
    -- pos  = self._plane:LocalPos()
    -- ctrl:InitLocalPos(pos)
    -- tInsert( self._bullets, ctrl)
end


function M:_TryGetBullet()
    if self._bulletPool and #self._bulletPool > 0 then 
        local bulletCtrl = self._bulletPool[#self._bulletPool]
        local pos = self._plane:LocalPos()
        bulletCtrl:InitLocalPos(pos)
        self._bulletPool[#self._bulletPool]=nil 
        tInsert( self._bullets, bulletCtrl)
    else
        local obj  = GameUtil.Instantiate(self._view.bullet.gameObject, self._view.battle.transform)
        local ctrl = self._bulletCtrl.New(self._bulletView.New(obj), self._bulletNum, self._bulletSpacing)
        local pos = self._plane:LocalPos()
        ctrl:InitLocalPos(pos)
        tInsert( self._bullets, ctrl)
    end

    GameHelper.PlayAudioById(1230)
end


function M:_BeesMove()
    local tween = self._view.bees:SetDoLocalMoveY(-700, self._beesDefaultSpacing, 1)
    tween.onComplete = function ()
        Logger.Log('到底了！！！！！！！')
        self:_GameEnd()
    end
    tween.onUpdate = function ()
        self:_BeesHorizontalMove()
        self:_UpdateBeesPos()
    end
end


function M:_BeesHorizontalMove()
    local posX = self._view.bees.transform.localPosition.x
    self._factor = posX >= self._beesMaxSpacing and -1 or self._factor
    self._factor = posX <= -self._beesMaxSpacing and 1 or self._factor

    local x = posX + self._factor * 1
    self._view.bees:SetLocalPos(x, self._view.bees.transform.localPosition.y, self._view.bees.transform.localPosition.z)
end


function M:_UpdateBeesPos()
    for _,v in ipairs(self._bees) do
        v:UpdataBeesPos(self._view.bees.transform.localPosition)
    end
end


function M:_GameStart()
    self:_InitPlan()
    self:_BeesMove()
    self._isStart = true
end


function M:_LevelData()
    self._level = self._level + 1
    self._levelConfig = self._config[self._level]
    self._shootMaxSpacing = tonumber(self._levelConfig.shootSpeed) 
    self._shootSpacing = self._levelConfig.shootSpeed - self._levelConfig.shootAdd * (self._level - 1)
    self._beesDownTime = self._levelConfig.attackSpeed + self._levelConfig.attackAdd * (self._level - 1)
    self._beesDefaultSpacing = self._beesDefaultSpacing - self._beesDownTime
    self._shootSpacing = math.max(self._shootMaxSpacing, self._shootSpacing)
end


function M:_ResetData()
    self:_Clear()
    self._view.bees:DoTweenKill()
    self._view.bees:SetLocalPos(0,0,0)
    self._bulletNum = 0
    self._shootTime = 0
end


function M:_NextLevel()
    self:_ResetData()
    self:_LevelData()
    self:_InitMonsters()
    self:_GameStart()
end


function M:_GameEnd()
    self._view.bees:DoTweenKill()
    self._isStart = false
    self._gameTime = math.floor(self._gameTime)
    GamesDataMgr:GetInstance():HeroGamesEndData(1, self._heroId, self._gameTime, self._score)
    UIContextMgr:GetInstance():Show('GamesPopup', 1, SmaillGamesType.GamesState.End, self._score)
    Logger.Log('游戏结束！！！！！！！！！')
end


function M:_PlayWinEmoji()
    self._view.emoji:SetActive(true)
    self._isPlayEmoji = true
end


function M:_BulletDie(index)
    self:_OnBulletFinish(self._bullets[index])
    tRemove( self._bullets, index )
end


function M:_OnBulletFinish(bulletCtrl)
    if bulletCtrl == nil then 
        return 
    end
    
    bulletCtrl:Clear()
    tInsert( self._bulletPool,bulletCtrl)
end


function M:_OnHit(bulletIndex, beeIndex)
    GameHelper.PlayAudioById(1231)
    
    self:_BulletDie(bulletIndex)

    self._score = self._score + self._bees[beeIndex]:Sorce()
    self._bees[beeIndex]:Clear()
    tRemove( self._bees, beeIndex )

    self:_RefreshText()
    if #self._bees == 0 then
        self._isStart = false
        -- self:_PlayWinEmoji()
        self:_NextLevel()
    end
end


function M:_IsHitPlane(min, max)
    local bmin, bmax, hit
    bmin = self._plane:Min()
    bmax = self._plane:Max()
    hit  = (bmax.x < min.x) or (max.x < bmin.x) or (bmax.y < min.y) or (max.y < bmin.y)
    return not hit
end


function M:_IsHitBullet(min, max)
    local bmin, bmax, hit
    
    for i,v in ipairs(self._bullets) do
        bmin = v:Min()
        bmax = v:Max()
        
        hit = (bmax.x < min.x) or (max.x < bmin.x) or (bmax.y < min.y) or (max.y < bmin.y)
        if not hit then
            return i
        end

        if self:_IsBulletBorder(v:LocalPos()) then
            self:_BulletDie(i)
        end
    end
    return
end


function M:_HitCheck()
    local bmin, bmax, hit, index

    for i,v in ipairs(self._bees) do
        bmin = v:Min()
        bmax = v:Max()

        if self:_IsHitPlane(bmin, bmax) then
            Logger.Log('飞机死亡！！！！！！！')
            self:_GameEnd()
            return
        end

        index = self:_IsHitBullet(bmin, bmax)
        if index then
            self:_OnHit(index, i)
        end
    end
end


function M:_IsBulletBorder(pos)
    if pos.y > 740 then
        return true
    end

    return false
end


function M:_PlaneMove()
    self._plane:PlaneMove(self._view:InputMousePositionX(), self._view.bgAnimator)
end


function M:Update()
    if not self._isStart then
        return
    end

    self._gameTime = self._gameTime + Time.deltaTime
    self._shootTime = self._shootTime + Time.deltaTime
    if self._shootTime >= self._shootSpacing then
        self._shootTime = 0
        self:_TryGetBullet()
    end

    self:_HitCheck()
    self:_PlaneMove()
end


function M:_GamePause()
    self._isStart = false

    self._view.bees:DoTweenPause()
    for _,v in pairs(self._bees) do
        v:TweenPause()
    end

    for _,v in pairs(self._bullets) do
        v:TweenPause()
    end
end


function M:_GameReply()
    self._view.bees:DoTweenPlay()
    for _,v in pairs(self._bees) do
        v:TweenPlay()
    end

    for _,v in pairs(self._bullets) do
        v:TweenPlay()
    end

    self._isStart = true
end


function M:__init(name, view)
    self._view = view
    self._name = name
    self._planeCtrl = require("UI.Ctrl.Games.Bee.BeePlaneCtrl")
    self._planeView = require("UI.View.Games.Bee.BeePlaneView")
    self._beeCtrl = require("UI.Ctrl.Games.Bee.BeeMonsterCtrl")
    self._bee1View = require("UI.View.Games.Bee.Bee1MonsterView")
    self._bee2View = require("UI.View.Games.Bee.Bee2MonsterView")
    self._bulletCtrl = require("UI.Ctrl.Games.Bee.BeePlaneBulletCtrl")
    self._bulletView = require("UI.View.Games.Bee.BeePlaneBulletView")

    self._startAniTime = self._view.animator.runtimeAnimatorController.animationClips[0].length
    self._config = ConfigHelper.GetCfgs('gameBee')  -- 游戏总表数据
    self._bulletPool = {}                           -- 子弹对象池
    self._plane = nil                               -- 飞机ctrl
    self._bees = {}                                 -- 小蜜蜂全部ctrl
    self._bullets = {}                              -- 子弹全部ctrl
    self._lineNum = 5                               -- 行数 
    self._planeSpacing = 150                        -- 飞机移动速度
    self._planeMaxSpacing = 800                     -- 飞机左右移动阈值
    self._beeSize = {x=64, y=64}                    -- 小蜜蜂大小
    self._beeSpacing = 20                           -- 小蜜蜂间距
    self._beesDefaultSpacing = 60                   -- 初始下落速度
    self._beesMaxSpacing = 360                      -- 左右移动阈值
    self._bulletSpacing = 5                         -- 子弹速度
 
    self._score = 0                                 -- 分数
    self._level = 0                                 -- 关卡
    self._bulletNum = 0                             -- 子弹数量=id
    self._shootTime = 0                             -- 攻击时间
    self._shootSpacing = 0                          -- 攻击间隔
    self._shootMaxSpacing = 0                       -- 攻击间隔最大
    self._beesDownTime = 0                          -- 小蜜蜂矩阵下落速度
    self._factor = 1                                -- 小蜜蜂矩阵移动方向
    self._isStart = false                           -- 是否开始 
    self._beeStartPos = {x = 0, y = 0}              -- 初始位置
    self._gameTime = 0                              -- 游戏时间
    self._isOpenShoot = false                       -- 飞机是否发射子弹
    self._heroId = 110006                           -- 当前指挥官id

    self._view.backBtn:onClick(Bind(self, self._OnClickClose))

    self._gameClose   = EventMgr:AddListener(UIMessageNames.GAME_CLOSE, Bind(self, self._OnGameClose))
    self._gameReturn  = EventMgr:AddListener(UIMessageNames.GAME_RETURN, Bind(self, self._OnGameReturn))
    self._gameRestart = EventMgr:AddListener(UIMessageNames.GAME_RESTART, Bind(self, self._OnGameRestart))
    self._gameStartTimer = TimerManager:GetInstance():GetTimer(self._startAniTime, Bind(self, self._OnGameStart), nil, true)

    self:_InitBullet()
    self._gameStartTimer:Start()
    GameHelper.PlayAudioById(322)
end


function M:OnEnter()
    -- 数据重置
    self._score = 0
    self._level = 0
    self._gameTime = 0
    self._beeStartPos.x = -((self._beeSize.x + self._beeSpacing) * 0.5 + (self._beeSize.x + self._beeSpacing) * 4)
    self:_RefreshText()
    self:_ResetData()
    self:_LevelData()
    self:_InitMonsters()
end


function M:_RefreshText()
    self._view.scoreText:SetText(tostring(self._score))
end


function M:_OnGameClose()
    self._isStart = false
    UIContextMgr:GetInstance():Close(self._name)
end


function M:_OnGameStart()
    self._view.animator.enabled = false
    self:_GameStart()
end


function M:_OnGameReturn()
    self:_GameReply()
end


function M:_OnGameRestart()
    self:OnEnter()
    self:_OnGameStart()
end


function M:_OnClickClose()
    self:_GamePause()
    UIContextMgr:GetInstance():Show('GamesPopup', 1, SmaillGamesType.GamesState.Close)
end


function M:_Clear()
    self._view.bees:DoTweenKill()
    
    for _,v in ipairs(self._bullets) do
        v:Clear()
    end
   
    for _,v in ipairs(self._bees) do
        v:Clear()
    end

    self._bullets = {} 
    self._bees = {}
end


function M:OnClose()
    GameHelper.PlayAudioById(316)
    self:_Clear()

    self._planeCtrl = nil
    self._planeView = nil
    self._beeCtrl = nil
    self._beeView = nil
    self._shoot = nil 
    self._bees = nil
    self._bulletDie = nil

    for _,v in pairs(self._bullets) do
        v:Dispose()
    end

    for _,v in pairs(self._bulletPool) do
        v:Dispose()
    end

    if self._plane then
        self._plane:Clear()
    end
    self._plane = nil

    EventMgr:RemoveListener(UIMessageNames.GAME_CLOSE, self._gameClose)
    EventMgr:RemoveListener(UIMessageNames.GAME_RETURN, self._gameReturn)
    EventMgr:RemoveListener(UIMessageNames.GAME_RESTART, self._gameRestart)
end


function M:OnDispose()
    
end




return BeeGameCtrl
