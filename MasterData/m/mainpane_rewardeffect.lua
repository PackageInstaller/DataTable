---@class MainPane_RewardEffect : MainPane_RewardEffect_Generate
---##################### 【MainPane_RewardEffect Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【MainPane_RewardEffect Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local MainPane_RewardEffect = require "MainPane_RewardEffect_Generate"

---@class MainPane_RewardEffect_EffectObj:UIObj
local EffectObj = class("MainPane_RewardEffect_EffectObj", UIObj)

function EffectObj:Initialize()
    UIObj.Initialize(self)
    ---@type UnityEngine.UI.Image
    self.image = self:GetChildCompon("", TypeInfo.Image)

    ---@type DG.Tweening.Sequence
    self.seq = nil
end

---@param data {itemId:integer, startPos:Vector2, centerPos:Vector2, endPos:Vector2}?
function EffectObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= nil)
    if self.seq ~= nil then
       self.seq:Kill() 
    end
    if data == nil then
       return
    end
    self.transform.anchoredPosition = data.startPos
    local itemId = data.itemId

    local itemCfg = Config.GetItemInfo(itemId)
    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemCfg.icon), self.image)

    local dir_1 = data.startPos - data.centerPos
    local dis_1 = Vector2.Magnitude(dir_1)
    Vector2.SetNormalize(dir_1)

    ---@type UnityEngine.RectTransform
    local rTrs = self.transform
    rTrs.anchoredPosition = data.centerPos
    rTrs.localScale = Vector3(0.6, 0.6, 0.6)
    local seq = DOTween.Sequence()

    local t1 = 0.5
    seq:Append(rTrs:DOAnchorPos(data.startPos, t1):SetEase(DG.Tweening.Ease.OutCubic))
    seq:Join(rTrs:DOScale(1, t1))

    local dis_2 = Vector2.Distance(data.startPos, data.endPos)
    local speed2 = 1000
    local t2 = dis_2 / speed2
    seq:Append(rTrs:DOAnchorPos(data.endPos, t2):SetEase(DG.Tweening.Ease.InCirc))
    seq:AppendCallback(function()
        self:SetData(nil)
    end)
    self.seq = seq
end

function MainPane_RewardEffect:InitLogic(data)
    ---@type MainPane_RewardEffect_EffectObj[]
    self.itemImages = {}

    self.effectPrefab:SetActive(false)
    ---@type MarkInfo[]
    self.marks = {}

    self.uiCamera = UIMgr.uiCamera
    ---@type UnityEngine.RectTransform
    local rectTrs = self.transform
    self.viewSize = Vector2.New(rectTrs.rect.width / 2, rectTrs.rect.height / 2)
end

--function MainPane_RewardEffectl_RewardEffect:OnDestroy()
--	self.super:OnDestroy(self)
--end

---@param ui UIBase
function MainPane_RewardEffect:SetParentUI(ui)
    ---@type MainPanel
    self.parentUI = ui
    self.LoadSpriteAsync = function(self, path, callBack)
        self.parentUI:LoadSpriteAsync(path, callBack)
    end
    self.LoadGameObjectAsync = function(self, path, callBack)
        self.parentUI:LoadGameObjectAsync(path, callBack)
    end
end

---@param worldPos Vector3
---@param camera UnityEngine.Camera
function MainPane_RewardEffect:WorldPosToUIPos(worldPos, camera)

    local screenPoint = camera:WorldToScreenPoint(worldPos)
    if screenPoint.z < 0 then
        screenPoint = screenPoint * -1
    end
    
    local _,uiPos = RectTransformUtility.ScreenPointToLocalPointInRectangle(self.transform, screenPoint, self.uiCamera, nil)

    uiPos = Vector2.New(uiPos.x, uiPos.y)
    return uiPos, false
end

---播放获得奖励的爆炸特效
---@param worldPos Vector3 世界坐标
---@param rewards RewardInfo[]
function MainPane_RewardEffect:PlayEffect(worldPos, rewards)
    local uiPos, _ = self:WorldPosToUIPos(worldPos, CoveManager.instance().camera)
    ---@type integer[]
    local rs = {}
    for i = 1, #rewards do
        local num = rewards[i].num
        local l = math.floor(math.log(num, 10))
        local createCount = 0
        if num < 14 then
            createCount = num
        else
            createCount = l * 4 + 8
        end
        local id = rewards[i].id
        for j = 1, createCount do
            table.insert(rs, id)
        end
    end
    ---爆炸范围
    local size = 300
    for i= 1, #rs do
        local rPos = DUtil.Random_InsideUnitCircle()
        rPos = Vector2.New(rPos.x, rPos.y)

        local itemId = rs[i]
        local ePos = self.parentUI:GetResrouceItemPos(itemId)
        rPos = rPos * size + uiPos
        local effectObj = self.itemImages[i]
        if effectObj == nil then
            ---@type UnityEngine.GameObject
            local obj = EngineUtil.Instantiate(self.effectPrefab)
            effectObj = EffectObj:Create(obj, self)
            self.itemImages[i] = effectObj
        end
        local data = {itemId = itemId, startPos = rPos, centerPos = uiPos, endPos = ePos}
        effectObj:SetData(data)
    end

    for i = #rs + 1, #self.itemImages do
        self.itemImages[i]:SetData(nil)
    end
end

return MainPane_RewardEffect
