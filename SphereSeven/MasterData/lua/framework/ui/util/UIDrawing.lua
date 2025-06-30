local UIDrawing = {}
local this = UIDrawing

local prefabPath = "UI/Prefabs/View/Items/UILandlady.prefab"

function this.__init(self, root, picRoot, spineRoot, soundType, viewName, linesRoot)
    self.root = root
    self.picRoot = picRoot
    self.spineRoot = spineRoot
    self.soundType = soundType
    self.viewName = viewName
    self.linesRoot = linesRoot
    
    if not IsNull(linesRoot) then
        self.linesParent = linesRoot.transform.parent
    end

    self.cardId = nil
    self.stage = nil
    self.showType = ShowGirlShowType.Customize

    if viewName == UIWindowNames.UIHome then
        self.showMode = ClientData:GetInstance():GetHomeLive2DMode()
        self.bgMode = ClientData:GetInstance():GetHomeLive2DBgMode()
    elseif viewName == UIWindowNames.UIRoom then
        self.showMode = ClientData:GetInstance():GetRoomLive2DMode()
        self.bgMode = ClientData:GetInstance():GetRoomLive2DBgMode()
    end
    
    -- 如果没有显示模式
    if self.showMode == 0 then
        self.showMode = 1 -- 默认显示的
        if self.viewName == UIWindowNames.UIHome then
            ClientData:GetInstance():SetHomeLive2DMode(self.showMode)
        elseif self.viewName == UIWindowNames.UIRoom then
            ClientData:GetInstance():SetRoomLive2DMode(self.showMode)
        end
    end
    if self.bgMode == 0 or self.bgMode == nil then
        self.bgMode = 1 -- 默认显示的
        if self.viewName == UIWindowNames.UIHome then
            ClientData:GetInstance():SetHomeLive2DBgMode(self.bgMode)
        elseif self.viewName == UIWindowNames.UIRoom then
            ClientData:GetInstance():SetRoomLive2DBgMode(self.bgMode)
        end
    end
    
    self.offsetMode = "CardOffset"
    
    self.prefab = nil
    self.livePrefab = nil
    self.faceId = nil
    self.faceTnf = nil
    self.folder = nil
    self.soundName = nil
    self.isPlaying = false
    self.stopPlaying = false
    self.onComplete = nil
    self.timer = nil
    
    self.live2dPath = nil
    self.live2dObj = nil
    
    self.str = {}
end

-- API:主界面需要切换背景
function this.BackgroundSetting(self, bg, particle, defaultSprite)
    self.bg = bg
    self.particle = particle
    self.defaultSprite = defaultSprite
end

function this.OffsetSetting(self, mode)
    self.offsetMode = mode
end

-- API:点击
function this.CoClick(self, soundType, cardId, skinId)
    self.soundType = soundType or self.soundType
    assert(self.soundType)
    self:GetMainCardInfo(cardId, skinId) -- 获取要显示的cardId和stage
    self:LoadImage()
    self:Random()
    self:PlayAnim()
    if not self.isPlaying then
        self.onComplete = function ()
            self.onComplete = nil
            self:ResetMusicAndFace()
        end
    end
    self:PlaySound()
end

-- API:播放立绘，表情，音效
function this.CoPlay(self, soundType, cardId, stage)
    if self.isPlaying then
        return
    end
    self.soundType = soundType or self.soundType
    assert(self.soundType)
    self:GetMainCardInfo(cardId, stage) -- 获取要显示的cardId和stage
    self:LoadImage()
    self:Random()
    self:LoadFace(self.faceId)
    self.onComplete = function ()
        self.onComplete = nil
        self:ResetMusicAndFace()
    end
    self:PlaySound()
end

-- API:播放立绘，表情，音效
function this.CoPlayForce(self, soundType, soundId)
    self.soundType = soundType or self.soundType
    self.onComplete = nil
    self.isPlaying = false
    assert(self.soundType)
    self:GetMainCardInfo() -- 获取要显示的cardId和stage
    self:LoadImage()
    self:Random(soundId)
    self:LoadFace(self.faceId)
    self.onComplete = function ()
        self.onComplete = nil
        self:ResetMusicAndFace()
    end
    self:PlaySound()
end

-- API:播放表情，没有回调
function this.CoPlayForceWithoutCallback(self, soundType, soundId)
    self.soundType = soundType or self.soundType
    self.onComplete = nil
    self.isPlaying = false
    assert(self.soundType)
    self:GetMainCardInfo() -- 获取要显示的cardId和stage
    self:LoadImage()
    self:Random(soundId)
    self:LoadFace(self.faceId)
    self:PlaySound()
end

-- API:切换模式，并隐藏表情
function this.ChangeMode(self, cardId, skinID)
    -- if self.cardId == nil or self.stage == nil then
    --     return
    -- end

    if cardId == nil or skinID == nil then
        return
    end
    self.cardId = cardId
    self.stage = skinID
    self:GetMainCardInfo(self.cardId, self.stage)
    local zSkin = UIPublic.GetSkin(self.cardId, self.stage)
    if zSkin.IsSpine == 0 then -- 没有spine动画，必须是立绘模式
        self.showMode = 2
    else
        self.showMode = self.showMode == 1 and 2 or 1
    end
    if self.viewName == UIWindowNames.UIHome then
        ClientData:GetInstance():SetHomeLive2DMode(self.showMode)
    elseif self.viewName == UIWindowNames.UIRoom then
        ClientData:GetInstance():SetRoomLive2DMode(self.showMode)
    end
    self:ShowImage()
    self:LoadFace()
end

-- API:Spine模式
function this.PlaySpine(self, cardId, skinID)
    if cardId == nil or skinID == nil then
        return
    end
    self.cardId = cardId
    self.stage = skinID
    self:GetMainCardInfo(self.cardId, self.stage)
    local zSkin = UIPublic.GetSkin(self.cardId, self.stage)
    if zSkin.IsSpine == 0 then -- 没有spine动画，必须是立绘模式
        return
    else
        self.showMode = 1
    end
    self:ShowImage()
    self:LoadFace()
end

function this.HasLive2D(self)
    if self.cardId == nil or self.stage == nil then
        return false
    end
    local zSkin = UIPublic.GetSkin(self.cardId, self.stage)
    return zSkin.IsSpine ~= 0
end

-- API:只管加载立绘，表情不管
function this.CoPlayImageOnly(self, cardId, skinId)
    self:GetMainCardInfo(cardId, skinId) -- 获取要显示的cardid和stage
    self:ShowImage() -- 加载这个图片
end

-- API:只播放立绘并隐藏表情
function this.CoPlayImage(self, cardId, skinId)
    self:GetMainCardInfo(cardId, skinId) -- 获取要显示的cardid和stage
    self:ShowImage() -- 加载这个图片
    self:LoadFace()
end

function this.SetParent(self, picRoot, spineRoot, linesParent)
    if not IsNull(self.prefab) and not IsNull(picRoot) then
        self.prefab.transform:SetParent(picRoot.transform)
        self.picRoot = picRoot
        self.PaintRoot = picRoot.transform.parent
    end
    if not IsNull(self.live2dObj) and not IsNull(spineRoot) then
        self.live2dObj.transform:SetParent(spineRoot.transform)
        self.spineRoot = spineRoot
        self.PaintRoot = spineRoot.transform.parent
    end

    if not IsNull(spineRoot) then
        self.spineRoot = spineRoot
    end
    
    if not IsNull(self.linesRoot) and not IsNull(linesParent) then
        self.linesRoot.transform:SetParent(linesParent.transform)
        self.linesParent = linesParent
    end
end

-- 1.获取主界面卡片信息
function this.GetMainCardInfo(self, cardId2, skinId)
    if cardId2 == nil then
        return
    end
    local cardId = cardId2--self.cardId
    local stage = self.stage
    local player = Game.Scene.Player
    local func = function (id)
        local card = player:GetComponent("CardComponent").Cards[id]
        if card == nil then
            --self.cardId = nil
            --self.stage = nil
            --Logger.Log("Main Card is nil=====================")
        else
            self.cardId = card.TemplateId
            --self.stage = card.SkinId
            if self.stage == nil or self.stage <= 0 then
                self.stage = 1
            end
        end
        -- 立绘切换，优先是live2d模式
        if cardId ~= nil and stage ~= nil then
            if cardId ~= self.cardId or (self.cardId == cardId and stage ~= self.stage) then
                local zSkin = UIPublic.GetSkin(self.cardId, self.stage)
                if zSkin.IsSpine == 1 then
                    self.showMode = 1
                    if self.viewName == UIWindowNames.UIHome then
                        ClientData:GetInstance():SetHomeLive2DMode(self.showMode)
                    elseif self.viewName == UIWindowNames.UIRoom then
                        ClientData:GetInstance():SetRoomLive2DMode(self.showMode)
                    end
                end
                if self.viewName == UIWindowNames.UIHome then
                    local pos = Vector2.New(-2.9,0)
                    ClientData:GetInstance():SetHomeCardRect({posX = pos.x, posY = pos.y, scale = 1})
                    DataManager:GetInstance():Broadcast(DataMessageNames.ON_HOME_CARD_RECT_CHG, {liveType = Live2DType.Home})
                elseif self.viewName == UIWindowNames.UIRoom then
                    local pos = Vector2.New(0,0)
                    ClientData:GetInstance():SetRoomCardRect({posX = pos.x, posY = pos.y, scale = 1})
                    DataManager:GetInstance():Broadcast(DataMessageNames.ON_HOME_CARD_RECT_CHG, {liveType = Live2DType.Room})
                end
            end
        end
    end
    if self.viewName == UIWindowNames.UIHome then
        self.cardId = cardId2
        func(cardId2)
    elseif self.viewName == UIWindowNames.UIRoom then
        self.cardId = player.MainWife
        func(player.MainWife)
    end
    -- 这里是强制按传入的id来

    self.showGirlSkinId = skinId
    self.cardId = cardId2
    self.stage = skinId
    if cardId2 then
        self.cardId = cardId2
    end
end

-- 2.显示立绘还是live2d
function this.ShowImage(self)
    if self.cardId == nil or self.showGirlSkinId == nil then
        return
    end
    local zSkin --= UIPublic.GetSkin(self.cardId, self.stage)

    if self.showGirlSkinId == nil then
        zSkin = UIPublic.GetSkin(self.cardId, self.stage)
    else
        zSkin = Z_Skin[self.showGirlSkinId]
    end

    assert(zSkin)
    if zSkin.IsSpine == 0 or IsNull(self.spineRoot) then -- 没有spine动画，必须是立绘模式
        self.showMode = 2
        if self.viewName == UIWindowNames.UIHome then
            ClientData:GetInstance():SetHomeLive2DMode(self.showMode)
        elseif self.viewName == UIWindowNames.UIRoom then
            ClientData:GetInstance():SetRoomLive2DMode(self.showMode)
        end
    end
    if not IsNull(self.picRoot) then
        self.picRoot.gameObject:SetActive(self.showMode == 2)
        
    end
    if not IsNull(self.spineRoot) then
        self.spineRoot.gameObject:SetActive(self.showMode == 1)
    end

    if self.showMode == 2 then -- 没有spine 或者是切换到立绘模式
        self:LoadImage()
    else
        self:LoadLive2D()
    end
    -- 显示背景
    if self.bg ~= nil and self.particle ~= nil and self.defaultSprite ~= nil then
        if zSkin.IsSpine == 0 then
            self.bg.sprite = self.defaultSprite
            self.particle.gameObject:SetActive(true)
        else
            self.particle.gameObject:SetActive(false)
            --local path = "UI/SkinShopBg/"..self.cardId.."_"..self.stage..".png"
            --Z_FigureAsset[self.showGirlSkinId].CardWithBG

            coroutine.start(function()
                coroutine.waitforframes(2)
                local path = "UI/SkinShopBg/".. Z_FigureAsset[self.showGirlSkinId].CardWithBG ..".png"
                self.bg.sprite =  AtlasManager:GetInstance():CoLoadImageAsync(path)
            end)
            -- local path = "UI/SkinShopBg/".. Z_FigureAsset[self.showGirlSkinId].CardWithBG ..".png"
            -- self.bg.sprite =  AtlasManager:GetInstance():CoLoadImageAsync(path)
        end
    end
    this.SetImagePosAndScale(self)
end

-- 3.加载图片
function this.LoadImage(self)
    local zSkin
    if self.showGirlSkinId == nil then
        return
    else
        zSkin = Z_Skin[self.showGirlSkinId]
    end

    local offsetInfo = Z_SkinOriginalOffset[self.showGirlSkinId].CardOffset

    local path

    local cardPaintImage = Z_FigureAsset[self.showGirlSkinId].CardPaint
    -- 如果是主界面或自宅界面  判断是显示带背景还是不带背景
    local isStageImage = false

    if Z_FigureAsset[self.showGirlSkinId].CardWithBG ~= "" then
        isStageImage = true
        cardPaintImage = Z_FigureAsset[self.showGirlSkinId].CardPaintWithBG
    end

    path = "UI/CardPaint/" .. cardPaintImage

    -- 和谐
    -- local skin = table.first(Z_Skin, function (v) return v.id == self.cardId end)
    -- if skin ~= nil then
    --     path = "UI/CardPaint"..skin.CardPaint.."/"..self.cardId.."_"..cardPaintImage
    -- end
    
    self.prefab = self.prefab or GameObjectPool:GetInstance():CoGetGameObjectAsync(prefabPath)
    self.prefab:SetActive(false)
    self.prefab.transform:SetParent(self.picRoot.transform, false)
    local img
    local drawing = self.prefab.transform:Find("Drawing")
    drawing.gameObject:SetActive(true)
    img = drawing:GetComponent("Image")
    img.enabled = not isStageImage
    if not isStageImage then -- 带背景用通用的
        for i = 0, drawing.childCount - 1 do
            drawing:GetChild(i).gameObject:SetActive(false)
        end
    else
        for i = 0, drawing.childCount - 1 do -- 不带背景  位置单独调整
            local tnf = drawing:GetChild(i)
            tnf.gameObject:SetActive(tnf.name == cardPaintImage)
            if tnf.name == cardPaintImage then
                img = tnf:GetComponent("Image")
            end
        end
    end
    img:DOFade(1, 0)

    if Z_Skin[self.showGirlSkinId].IsNewBattleSpine == 1 then --避免相关报错
        return
    end

    img.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path..".png")
    if img.sprite == nil then
        if not string.IsNullOrEmpty(zSkin.StageImage) and (self.viewName == UIWindowNames.UIHome or self.viewName == UIWindowNames.UIRoom) then
            if not table.contains(self.str, "--缺立绘:"..self.cardId.."_"..zSkin.StageImage) then
                table.insert(self.str, "--缺立绘:"..self.cardId.."_"..zSkin.StageImage)
            end
        else
            if not table.contains(self.str, "--缺立绘:"..self.cardId.."_"..zSkin.stage) then
                table.insert(self.str, "--缺立绘:"..self.cardId.."_"..zSkin.stage)
            end
        end
        --Logger.LogError("--缺立绘!!!!!!!!"..path)
        img.enabled = false
    else
        img.enabled = true
    end
    img:SetNativeSize()
    self.prefab:SetActive(true)
    local rectTransform = self.picRoot.transform:GetComponent("RectTransform")
    rectTransform:DOLocalMove(Vector2.New(offsetInfo[1], offsetInfo[2]), 0)
    self.prefab.transform:DOScale(Vector3.New(1, 1, 1), 0)
    self.prefab.transform:DOLocalMove(Vector3.New(0, 0, 0), 0)
end

-- 4.加载live2d
function this.LoadLive2D(self)
    if self.cardId == nil or self.stage == nil then
        return
    end
    -- 还没加载出live2d   又要修改  就不改了
    if not string.IsNullOrEmpty(self.live2dPath) and IsNull(self.live2dObj) then
        return
    end
    if not string.IsNullOrEmpty(self.live2dPath) then
        GameObjectPool:GetInstance():RecycleGameObject(self.live2dPath, self.live2dObj)
        self.live2dObj = nil
    end
    local cardSpine = Z_FigureAsset[self.showGirlSkinId].CardSpine
    local path = "UI/SpineAnimations/".. cardSpine ..".prefab"
    self.live2dPath = path
    self.live2dObj = GameObjectPool:GetInstance():CoGetGameObjectAsync(path)

    self.live2dObj.transform:SetParent(self.spineRoot.transform)
    self.live2dObj.transform:DOScale(Vector3.New(1, 1, 1), 0)
    self.live2dObj.transform:DOLocalMove(Vector3.New(0, 0, 0), 0)
    local sk = self.live2dObj.transform:GetChild(0):GetComponent("SkeletonGraphic")
    self:HideLive2D(sk)
    self:ShowOrHideBg(self.bgMode)
end

function this.HideLive2D(self, sk)
    local zSkin = UIPublic.GetSkin(self.cardId, self.stage)
    if not string.IsNullOrEmpty(zSkin.Hide) then
        local tab = loadtable(zSkin.Hide)
        xpcall(function ()
            table.walk(tab, function (k, v)
                sk.Skeleton:SetAttachment(v)
            end)
        end, function (msg)
            Logger.LogError("Lua:HideLive2D: " + msg)
        end)
    end
end

function this.ChangeBgMode(self)
    self.bgMode = self.bgMode == 1 and 2 or 1
    if self.viewName == UIWindowNames.UIHome then
        ClientData:GetInstance():SetHomeLive2DBgMode(self.bgMode)
    elseif self.viewName == UIWindowNames.UIRoom then
        ClientData:GetInstance():SetRoomLive2DBgMode(self.bgMode)
    end
end

function this.ShowOrHideBg(self, mode)
    if self.showMode == 1 then
        local sk = self.live2dObj.transform:GetChild(0):GetComponent("SkeletonGraphic")
        local zSkin = UIPublic.GetSkin(self.cardId, self.stage)
        if not string.IsNullOrEmpty(zSkin.HideLiveBg) then
            local tab = loadtable(zSkin.HideLiveBg)
            table.walk(tab, function (k, v)
                local attachmentName = mode == 1 and v.attachment or nil
                sk.Skeleton:SetAttachment(v.slot, attachmentName)
            end)
        end
    else
        if self.cardId == nil or self.stage == nil then
            return
        end
        self:GetMainCardInfo()
        self:ShowImage()
        self:LoadFace()
    end
end

-- 5.随机表情和语音
function this.Random(self, soundId)
    if self.soundType == nil then
        return
    end
    if self.cardId == nil then
        return
    end
    local zSkin = UIPublic.GetSkin(self.cardId, self.stage)
    assert(zSkin)
    local zCardSound = Z_CardSound[self.cardId]
    assert(zCardSound)
    local sounds
    local head = "N"
    if string.IsNullOrEmpty(zSkin.SkinSound) then -- 无专属语音
        sounds = zCardSound[self.soundType]
    else -- 有专属语音
        local tab = loadtable(zCardSound[zSkin.SkinSound]) -- 加载皮肤语音配置
        sounds = tab[self.soundType] -- 有专属语音（目前是主界面专属语音）
        head = zSkin.SkinSound -- A
        if sounds == nil then -- 没有配置该类型的专属语音
            sounds = zCardSound[self.soundType]
            head = "N"
        end
    end
    assert(sounds)
    local sound
    if type(sounds) == "string" then
        sound = sounds
    else
        if soundId == nil then
            sound = table.randget(sounds)
        else
            sound = sounds[soundId]
        end
    end
    assert(sound)
    self.soundName = sound
    local faceId
    faceId = zCardSound.Face[head..sound]
    self.folder = head
    if faceId == nil then
        Logger.LogError("cannot find face by mp3: "..sound)
    end
    self.faceId = faceId
end

-- 6.加载表情
function this.LoadFace(self, faceId)
    if self.prefab == nil then
        return
    end
    if self.cardId == nil or self.stage == nil then
        return
    end
    local zSkin = UIPublic.GetSkin(self.cardId, self.stage)
    local name = self.stage
    if not string.IsNullOrEmpty(zSkin.StageImage) and (self.viewName == UIWindowNames.UIHome or self.viewName == UIWindowNames.UIRoom) then
        name = zSkin.StageImage
    end

    local skinInfo = Z_FigureAsset[self.stage]
    local faceParent = self.prefab.transform:Find("Face")
    for i = 0, faceParent.childCount - 1 do
        local tnf = faceParent:GetChild(i)
        if tnf.name == skinInfo.CardAvatar then
            self.faceTnf = tnf
        else
            tnf.gameObject:SetActive(false)
        end
    end
    if IsNull(self.faceTnf) then
        if skinInfo.IsNewBattleSpine == 1 then
            return
        end
        Logger.LogError("FaceTnf!!!!!!!!" .. skinInfo.CardAvatar)
        return
    end
    if faceId == nil then
        self.faceTnf.gameObject:SetActive(false)
        return
    end
    local faceImg = AtlasManager:GetInstance():CoLoadImageAsync("UI/CardPaintFace/".. skinInfo.CardAvatar .."_"..faceId..".png")
    if faceImg == nil then
        if not table.contains(self.str, "--缺表情:".. skinInfo.CardAvatar .."_"..faceId) then
            table.insert(self.str, "--缺表情:".. skinInfo.CardAvatar .."_"..faceId)
        end
        self.faceTnf.gameObject:SetActive(false)
        return
    end
    local img = self.faceTnf:GetComponent("Image")
    img.sprite = faceImg
    img:DOFade(1, 0)
    self.faceTnf.gameObject:SetActive(true)
end

function this.Callback(self)
    if self == nil then
        return
    end
    self.isPlaying = false
    self.timer = nil
    if self.linesRoot then
        self.linesRoot.gameObject:SetActive(false)
    end
    if self.onComplete ~= nil then
        self.onComplete()
    end
end

-- 8.播放音效
function this.PlaySound(self)
    if self.isPlaying or self.stopPlaying or string.IsNullOrEmpty(self.soundName) then
        return
    end
    if self.timer ~= nil then
        self.timer:Stop()
        self.timer = nil
    end
    self.isPlaying = true
    local soundPath = "Sound/"..self.cardId.."/"..self.folder.."/"..self.soundName..".mp3"
    -- 根据声音类型   角色id  声音名字   找台词
    if self.linesRoot then
        local zLines = table.first(Z_Lines, function (v) return v.BelongCard == self.cardId and v.SoundType == self.folder and v.SoundName == self.soundName end)
        self.linesRoot.gameObject:SetActive(zLines ~= nil)
        if zLines then
            LangUtil.BindText(self.linesRoot.transform:Find("Text")).text = zLines.Lines
        end
    end
    local asset = ResourcesManager:GetInstance():CoLoadAsync(soundPath, typeof(AudioClip))
    if not self.isPlaying or self.stopPlaying  then
        return
    end
    Game.Scene:GetComponent("SoundComponent"):CoCardPlay(soundPath)
    self.timer = TimerManager:GetInstance():GetTimer(asset.length, self.Callback, self, true)
    self.timer:Start()
end

-- 9.播放表情和动画
function this.PlayAnim(self)
    if self.cardId == nil or self.stage == nil then
        return
    end
    if self.showMode == 2 then -- spine不需要表情
        if not IsNull(self.prefab) then
            self.prefab.transform:DOLocalMoveY(20, 0.3)
            coroutine.waitforseconds(0.5)
            self.prefab.transform:DOLocalMoveY(0, 0.3)
        end
        if self.isPlaying or self.stopPlaying then -- 正在播放不允许更换表情和声音
            return
        end
        self:LoadFace(self.faceId)
    elseif self.showMode == 1 then
        self:PlaySpineAnim(SpineAnimType.Home)
        if not IsNull(self.live2dObj) then
            self.live2dObj.transform:DOLocalMoveY(20, 0.3)
            coroutine.waitforseconds(0.5)
            self.live2dObj.transform:DOLocalMoveY(0, 0.3)
        end
    end
end

-- 10.Spine动画
function this.PlaySpineAnim(self, spineAnimType)
    if self.cardId == nil or self.stage == nil then
        return
    end
    local root = self.spineRoot.transform
    local gameObject
    if root.childCount <= 0 then
        return
    end
    gameObject = self.spineRoot.transform:GetChild(0):GetChild(0).gameObject
    local zSkin = UIPublic.GetSkin(self.cardId, self.stage)
    local animTb = loadtable(zSkin.SpineAnimNames)
    local defName = animTb.default
    local playTb = animTb[spineAnimType]
    local rdNum = Mathf.Random(1,table.count(playTb))
    local playName = playTb[rdNum]
    local sk = gameObject:GetComponent("SkeletonGraphic")
    sk.AnimationState:ClearTracks()
    sk.Skeleton:SetToSetupPose()
    sk.Skeleton:SetSlotsToSetupPose()
    sk.Skeleton:SetBonesToSetupPose()
    self:HideLive2D(sk)
    self:ShowOrHideBg(self.bgMode)
    coroutine.start(function()
        local state = sk.AnimationState:SetAnimation(0, playName, false)
        coroutine.waituntil(function()
            if not IsNull(gameObject) then
                return state.IsComplete
            else
                return true
            end
        end)
        if not IsNull(gameObject) then
            sk.AnimationState:SetAnimation(0, defName, true)
        end
    end)
end

function this.SetImagePosAndScale(self)
    if self.showType == ShowGirlShowType.Original then
        local offsetInfo = Z_SkinOriginalOffset[self.showGirlSkinId].CardOffset
        local SpineOffset = Z_SkinOriginalOffset[self.showGirlSkinId].SpineOffset
        local SpineScale = Z_SkinOriginalOffset[self.showGirlSkinId].SpineScale
        local rectTransform = self.picRoot.transform:GetComponent("RectTransform")
        local spineRectTransform = self.spineRoot.transform:GetComponent("RectTransform")
        local maintouch = self.picRoot.transform.parent
        rectTransform:DOLocalMove(Vector2.New(offsetInfo[1], offsetInfo[2]), 0)
        spineRectTransform:DOLocalMove(Vector2.New(SpineOffset[1], SpineOffset[2]), 0)
        spineRectTransform:DOScale(Vector3.New(SpineScale[1], SpineScale[2], 1), 0)
        maintouch.transform:DOScale(Vector3.New(1, 1, 1), 0)
        maintouch.transform:DOLocalMove(Vector3.New(-213.2, 0, 0), 0)
    elseif self.showType == ShowGirlShowType.Customize then
        local showgirlInfo = Game.Scene.Player.ShowGirlInfo
        local SpineScale = Z_SkinOriginalOffset[self.showGirlSkinId].SpineScale
        local offsetInfo = Z_SkinOriginalOffset[self.showGirlSkinId].CardOffset
        local SpineOffset = Z_SkinOriginalOffset[self.showGirlSkinId].SpineOffset
        --local rectTransform = self.picRoot.transform:GetComponent("RectTransform")
        local maintouch = self.picRoot.transform.parent
        --rectTransform:DOLocalMove(Vector2.New(offsetInfo[1], offsetInfo[2]), 0)
        --maintouch.transform:DOScale(Vector3.New(showgirlInfo.scale, showgirlInfo.scale, 1), 0)
        --maintouch.transform:DOLocalMove(Vector3.New(showgirlInfo.pos_x, showgirlInfo.pos_y, 0), 0)
        local spineRectTransform = self.spineRoot.transform:GetComponent("RectTransform")
        spineRectTransform:DOLocalMove(Vector2.New(SpineOffset[1], SpineOffset[2]), 0)
        spineRectTransform:DOScale(Vector3.New(SpineScale[1], SpineScale[2], 1), 0)

        maintouch.transform:DOMove(Vector3.New(showgirlInfo.pos_x, showgirlInfo.pos_y,0),0)
        maintouch.transform:DOLocalMoveZ(0, 0)
        maintouch.transform:DOScale(Vector2.New(showgirlInfo.scale, showgirlInfo.scale),0)
    elseif self.showType == ShowGirlShowType.Marry then
        local offsetInfo = Z_SkinOriginalOffset[self.showGirlSkinId].CardOffset
        local SpineOffset = Z_SkinOriginalOffset[self.showGirlSkinId].SpineOffset
        local SpineScale = Z_SkinOriginalOffset[self.showGirlSkinId].SpineScale
        local rectTransform = self.picRoot.transform:GetComponent("RectTransform")
        local maintouch = self.picRoot.transform.parent

        local spineRectTransform = self.spineRoot.transform:GetComponent("RectTransform")
        spineRectTransform:DOLocalMove(Vector2.New(SpineOffset[1], SpineOffset[2]), 0)

        rectTransform:DOLocalMove(Vector2.New(offsetInfo[1], offsetInfo[2]), 0)
        maintouch.transform:DOScale(Vector3.New(SpineScale[1], SpineScale[2], 1), 0)
        maintouch.transform:DOLocalMove(Vector3.New(0, 0, 0), 0)
    end
end

function this.changeType(self, showType)
    self.showType = showType
end

function this.DOFade(self, a, time)
    if IsNull(self.prefab) then
        return
    end
    local drawing = self.prefab.transform:Find("Drawing")
    table.csenu(drawing:GetComponentsInChildren(typeof(UE_UI.Image)), function (v) 
        v:DOFade(a, time)
    end)
    if not IsNull(self.faceTnf) then
        self.faceTnf:GetComponent("Image"):DOFade(a, time)
    end
end

function this.ResetMusicAndFace(self)
    self.isPlaying = false
    if not IsNull(self.faceTnf) then
        self.faceTnf.gameObject:SetActive(false)
    end
    if self.linesRoot then
        self.linesRoot.gameObject:SetActive(false)
    end
end

function this.StopMusicAndFace(self, isStop)
    self.stopPlaying = isStop
    if isStop then
        self:ResetMusicAndFace()
    end
end

function this.Disable(self)
    if not IsNull(self.prefab) then
        local faceParent = self.prefab.transform:Find("Face")
        for i = 0, faceParent.childCount - 1 do
            faceParent:GetChild(i).gameObject:SetActive(false)
        end
        local drawing = self.prefab.transform:Find("Drawing")
        for i = 0, drawing.childCount - 1 do
            drawing:GetChild(i).gameObject:SetActive(false)
        end
        if self.linesRoot then
            self.linesRoot.gameObject:SetActive(false)
        end
        GameObjectPool:GetInstance():RecycleGameObject(prefabPath, self.prefab)
        self.prefab = nil
    end
    if not string.IsNullOrEmpty(self.live2dPath) then
        GameObjectPool:GetInstance():RecycleGameObject(self.live2dPath, self.live2dObj)
        self.live2dPath = nil
        self.live2dObj = nil
    end
    
    self.cardId = nil
    self.stage = nil

    self.prefab = nil
    self.faceId = nil
    self.faceTnf = nil
    self.folder = nil
    self.soundName = nil
    self.isPlaying = false
    self.stopPlaying = false
end

return DataClass("UIDrawing", this)