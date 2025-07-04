---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/5/5 4:05
---
local HUDText = BaseClass("HUDText",Entity)
local base = Entity

local hudTextPfPath = PathUtil.Path_UIBattleCommonPrefab.."HUDTextPf.prefab"
local numericPfPath = PathUtil.Path_UIBattleCommonPrefab.."NumericPf.prefab"

if HUDTextType == nil then
    HUDTextType = {
        Red = 100, -- 红色
        Cyan = 101, -- 青色
        Brown = 102, -- 棕色
        Green = 103, -- 绿色
        Blue = 104, -- 蓝色
        Purple = 105, -- 紫色
        Grey = 106, -- 灰色
        Yellow = 107, -- 黄色
        
        Dmg = 1000,
        Tip = 1001,
        Total = 1002,
        Single = 1003,
    }
    HUDTextTask = DataClass("HUDTextTask", {
        Text = "",
        HudTextType = HUDTextType.Grey,
        HudTextType2 = HUDTextType.Dmg,
        IsSelf = false,
        __init = function(self, text,hudTextType, hudTextType2, isSelf)
            self.Text = text or ""
            self.HudTextType = hudTextType or HUDTextType.Grey
            self.HudTextType2 = hudTextType2 or HUDTextType.Dmg
            self.IsSelf = isSelf
        end
    })
end

local function LoadHudText1(self)
    self.hudTextGo = GameObjectPool:GetInstance():CoGetGameObjectAsync(hudTextPfPath)
    self.hudTextGo.transform:SetParent(self.root.transform, false)
    self.rectTnf = self.hudTextGo:GetComponent(typeof(RectTransform))

    self.textGo = self.hudTextGo.transform:Find("Image")
    local img = self.hudTextGo.transform:Find("Image"):GetComponent("Image")
    img.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Atlas/BattleTip_"..LangUtil.GetLangType().."/"..self.hudTextTask.Text..".png")
    if IsNull(img.sprite) then
        self.hudTextGo:SetActive(false) -- 保险起见
    end
    img:SetNativeSize()
    self.textGo.gameObject:SetActive(false)
end

local function Move1(self)
    self.randomPos = Vector2.New(0, 0)
    DOTween.Sequence()
           :Append(self.hudTextGo.transform:DOScale(1, 0))--:Insert(tmp:DOFade(0.25, 0))
           :Append(self.hudTextGo.transform:DOScale(1.5, 0.2))--:Insert(tmp:DOFade(1, 0.2))
           :Append(self.hudTextGo.transform:DOScale(1, 0.15))
           :AppendInterval(1)
    self.delay = 1.5
end

local function Move3(self)
    self.randomPos = Vector2.New(0, 0)
    local scale = 2.5
    DOTween.Sequence()
           :Append(self.hudTextGo.transform:DOScale(1.5, 0))--:Insert(tmp:DOFade(0.25, 0))
           :Append(self.hudTextGo.transform:DOScale(scale, 0.2))--:Insert(tmp:DOFade(1, 0.2))
           :Append(self.hudTextGo.transform:DOScale(1.5, 0.15))
    self.delay = 2.5
end

local function LoadHudText2(self)
    self.hudTextGo = GameObjectPool:GetInstance():CoGetGameObjectAsync(numericPfPath)
    self.hudTextGo.transform:SetParent(self.root.transform, false)
    self.rectTnf = self.hudTextGo:GetComponent(typeof(RectTransform))

    local func = function(color)
        local pre = 1
        if color == HUDTextType.Red then
            pre = 7
        elseif color == HUDTextType.Purple then
            pre = 3
        elseif color == HUDTextType.Green then
            pre = 4
        end
        return pre
    end
    for i = 1, self.hudTextGo.transform.childCount do
        self.hudTextGo.transform:GetChild(i - 1).gameObject:SetActive(false)
    end
    local t = tostring(math.modf(self.hudTextTask.Text))
    local pathList = {}
    if self.hudTextTask.HudTextType2 == HUDTextType.Total then
        table.insert(pathList, "common_t")
    end
    for i = 1, string.len(t) do
        table.insert(pathList, func(self.hudTextTask.HudTextType).."_"..string.sub(t, i, i))
    end
    if self.hudTextTask.HudTextType2 == HUDTextType.Total then
        table.insert(pathList, "common_"..func(self.hudTextTask.HudTextType))
    end
    for i = 1, table.count(pathList) do
        local go
        if i <= self.hudTextGo.transform.childCount then
            go = self.hudTextGo.transform:GetChild(i - 1).gameObject
        else
            go = GameObject.Instantiate(self.hudTextGo.transform:GetChild(0)).gameObject
            go.transform:SetParent(self.hudTextGo.transform, false)
        end
        go:SetActive(true)
        local img = go:GetComponent("Image")
        img.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Atlas/BattleNumeric/"..pathList[i]..".png")
        img:SetNativeSize(true)
    end
    self.hudTextGo:SetActive(false)
end

local function Move2(self)
    self.randomPos = Vector2.New(0, -50)
    local scale = 2.5
    DOTween.Sequence()
           :Append(self.hudTextGo.transform:DOScale(1.5, 0))--:Insert(tmp:DOFade(0.25, 0))
           :Append(self.hudTextGo.transform:DOScale(scale, 0.2))--:Insert(tmp:DOFade(1, 0.2))
           :Append(self.hudTextGo.transform:DOScale(1.5, 0.15))
    self.delay = 0.5
end

-- 敌人身上    己方身上    己方伤害    敌方伤害
local function Awake(self, hudTextRoot, curCamera, entity, hudTextTask)
    base.Awake(self)
    if curCamera == nil then return end
    self.battle_camera_component = Game.Scene:GetComponent("BattleCameraComponent")
    self.entity = entity
    self.canvasTnf = hudTextRoot:GetComponent(typeof(RectTransform))
    self.hudTextTask = hudTextTask
    self.hudTextGo = nil
    self.root = hudTextRoot
    
    if hudTextTask.HudTextType2 == HUDTextType.Tip then
        self:LoadHudText1()
        self:Move1()
        self.isStart = true
        self.time = Time.time
    else
        self:LoadHudText2()
        if hudTextTask.HudTextType2 == HUDTextType.Total or hudTextTask.HudTextType2 == HUDTextType.Single then
            self:Move3()
        elseif hudTextTask.HudTextType == HUDTextType.Green then
            self:Move1()
        else
            self:Move2()
        end
        self.isStart = true
        self.time = Time.time
    end
end

local function LateUpdate(self)
    if self.isStart then
        if Time.time - self.time >= self.delay then
            self:Dispose()
            return
        end
        if self.hudTextTask.HudTextType2 == HUDTextType.Tip then
            self.textGo.gameObject:SetActive(true)
        else
            self.hudTextGo:SetActive(true)
        end
        local hitPosOffset = self.entity.ZSsUnit.HitPosOffset
        local offset = Vector3.New(hitPosOffset[1] or 0, hitPosOffset[2] or 0, hitPosOffset[3] or 0)
        self.pos = self.entity.GameObject.transform.position + offset
        if self.battle_camera_component == nil then return end
        local cam = self.battle_camera_component:GetCamera(CameraType.CurCamera)
        if IsNull(cam) then return end
        local screenPoint = cam:WorldToScreenPoint(self.pos)
        local x = screenPoint.x * self.canvasTnf.sizeDelta.x / Screen.width + self.randomPos.x
        local y = screenPoint.y * self.canvasTnf.sizeDelta.y / Screen.height + self.randomPos.y
        if self.hudTextTask.HudTextType2 == HUDTextType.Tip then
            self.randomPos = self.randomPos + Vector2.New(0, Time.deltaTime * 80)
        elseif self.hudTextTask.HudTextType2 == HUDTextType.Total or self.hudTextTask.HudTextType2 == HUDTextType.Single then
            self.randomPos = self.randomPos + Vector2.New(0, Time.deltaTime * 30)
        else
            self.randomPos = self.randomPos + Vector2.New(0, Time.deltaTime * 100)
        end
        self.rectTnf.anchoredPosition = Vector3.New(x, y)
    end
end

local function Dispose(self)
    base.Dispose(self)
    self.isStart = false
    if self.IsDispose then return end
    
    if self.hudTextGo ~= nil then
        if self.hudTextTask.HudTextType2 == HUDTextType.Tip then
            GameObjectPool:GetInstance():RecycleGameObject(hudTextPfPath, self.hudTextGo)
        else
            GameObjectPool:GetInstance():RecycleGameObject(numericPfPath, self.hudTextGo)
        end
    end
    self.hudTextGo = nil
end

HUDText.Awake = Awake
HUDText.LateUpdate = LateUpdate
HUDText.Dispose = Dispose
HUDText.LoadHudText1 = LoadHudText1
HUDText.Move1 = Move1
HUDText.LoadHudText2 = LoadHudText2
HUDText.Move2 = Move2
HUDText.Move3 = Move3

return HUDText