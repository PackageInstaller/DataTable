---@class HomelandFunctionQuickPositioningPanel : HomelandFunctionQuickPositioningPanel_Generate
---##################### 【HomelandFunctionQuickPositioningPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomelandFunctionQuickPositioningPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomelandFunctionQuickPositioningPanel = require "HomelandFunctionQuickPositioningPanel_Generate"

---@class FunctionQuickObj: UIObj
local FunctionQuickObj = class("HomelandFunctionQuickPositioningPanel_FunctionQuickObj", UIObj)
function FunctionQuickObj:Initialize()
    UIObj.Initialize(self)

    ---@type HomelandFunctionQuickPositioningPanel_Generate_funPrefab
    local peer = self
    peer.viewBtn.scaleButton.onClick:RemoveAllListeners()
    peer.viewBtn.scaleButton.onClick:AddListener(BindCallback_NoParams(self, self.OnClick))
end

function FunctionQuickObj:SetData(data)
    UIObj.SetData(self, data)
    ---@type HomelandFunctionQuickPositioningPanel_Generate_funPrefab
    local peer = self
    peer.viewBtn.gameObject:SetActive(data ~= nil)
    if data == nil then
        return
    end
    local iconPath = string.format(Config.SpritePath.HomeFunQuickIcon, data.constId)
    self.ui:LoadSpriteAsync(iconPath, function (s)
        peer.iconImage.image.sprite = s
    end)

    local cfg = Config.GetConstructionInfo(data.constId)
    if cfg == nil then
        LuaLogger.es("建筑配置错误 id:" .. tostring(data.constId))
       return 
    end
    peer.nameText.text.text = cfg.name
    local isShow = RedPointMgr:HomeBulidRedJudge(data.constId)
    peer.redPoint:SetActive(isShow)
end

function FunctionQuickObj:OnClick()
    if self.data == nil then
       return 
    end
    CoveManager.instance()._buildingMgr:FocusingBuild11(self.data.constId)
end

function FunctionQuickObj:UpdateRedPoint()
    
end

local funCfg = {
    [1] = {
        constId = GE.CoustructionEnum.CommandRoom,
    },
    [2] = {
        constId = GE.CoustructionEnum.Armory,
    },
    [3] = {
        constId = GE.CoustructionEnum.WS2,
    },
    [4] = {
        constId = GE.CoustructionEnum.Aluminum,
    },
    [5] = {
        constId = GE.CoustructionEnum.Steel,
    },
    [6] = {
        constId = GE.CoustructionEnum.OilWell,
    },
    [7] = {
        constId = GE.CoustructionEnum.Shop,
    },
    [8] = {
        constId = GE.CoustructionEnum.Dormitory,
    },
    [9] = {
        constId = GE.CoustructionEnum.TrainingCenter,
    },
    [10] ={
        constId = GE.CoustructionEnum.Intelligenct,
    },
}

function HomelandFunctionQuickPositioningPanel:InitLogic(data)

    ---@type FunctionQuickObj[]
    self.functionObjs = {}
end

--function HomelandFunctionQuickPositioningPanel:StartCreating(time)
--
--end

--function HomelandFunctionQuickPositioningPanel:StartEnter(time)
--
--end

--function HomelandFunctionQuickPositioningPanel:StartRemoving(time)
--
--end

--function HomelandFunctionQuickPositioningPanel:StartExit(time)
--
--end

function HomelandFunctionQuickPositioningPanel:OnOpen(data, initiative)
    if not self.init then
        local count = 30
        self.funPrefab.gameObject:SetActive(false)
        for i = 1, count do
            local data = funCfg[i]
            local obj = EngineUtil.Instantiate(self.funPrefab.gameObject)
            obj:SetActive(true)
            ---@type FriendObj
            local funObj = FunctionQuickObj:Create(obj, self, self.funPrefab)
            funObj:SetData(data)
            table.insert(self.functionObjs, funObj)
        end

        self.init = true
    end

    ---@type UnityEngine.CanvasGroup
    local canvasGroup = self.gameObject:GetComponent(TypeInfo.CanvasGroup)
    canvasGroup.alpha = 0
    canvasGroup:DOFade(1, 0.4)

    local trs = self.contentView.rectTransform
    local width = trs.sizeDelta.x
    trs.anchoredPosition = Vector2.New(width, 0)
    trs:DOAnchorPosX(0, 0.2):SetEase(DG.Tweening.Ease.Linear)
end

function HomelandFunctionQuickPositioningPanel:LateUpdate()

    if Input.GetMouseButtonDown(0) then
	
        ---@type Vector3
        local pos = Input.mousePosition
        pos = Vector2.New(pos.x, pos.y)
        local inRect = RectTransformUtility.RectangleContainsScreenPoint(self.contentView.rectTransform, pos, UIMgr.uiCamera)
        if not inRect then
            self:closeBtn_ScaleButton_onClick()
        end
	end
end

--function HomelandFunctionQuickPositioningPanel:OnClose(initiative)
--
--end

--function HomelandFunctionQuickPositioningPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function HomelandFunctionQuickPositioningPanel:OnRefresh(data)
--
--end

--[[
/contentView/funGrid/funPrefab/viewBtn onClick 
--]]
function HomelandFunctionQuickPositioningPanel:viewBtn_ScaleButton_onClick(viewBtn)

end

--[[
/contentView/closeBtn onClick 
--]]
function HomelandFunctionQuickPositioningPanel:closeBtn_ScaleButton_onClick(closeBtn)

    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)

    ---@type UnityEngine.CanvasGroup
    local canvasGroup = self.gameObject:GetComponent(TypeInfo.CanvasGroup)
    canvasGroup.alpha = 1
    canvasGroup:DOFade(0, 0.2)

    local trs = self.contentView.rectTransform
    local width = trs.sizeDelta.x
    trs.anchoredPosition = Vector2.New(0, 0)
    trs:DOAnchorPosX(width, 0.2):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
            UIMgr:closeUI(self)
        end)

end

return HomelandFunctionQuickPositioningPanel
