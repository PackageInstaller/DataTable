---@class ImgToast : ImgToast__Generate
---##################### 【ImgToast Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ImgToast Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ImgToast = require "ImgToast_Generate"

function ImgToast:InitLogic(data)
    self.maxWidth = self.rectTransform.rect.width
    self.tmpAnchoredPosition = self.rectTransform.anchoredPosition
end

function ImgToast:StartCreating(time)
    self.gameObject:SetToAlpha(0)
end

function ImgToast:StartShowing(time)
    self.gameObject:FadeTo(1, 0.3, nil)
    --self.rectTransform:DoMoveDeltaY(200, time, false)
    EngineUtil.DelayCallback(time - 0.3,
            function()
                self.gameObject:FadeTo(0, 0.3, nil)
            end)
end

function ImgToast:StartRemoving(time)
end

function ImgToast:OnOpen(data, initiative)
    if initiative then
        self.rectTransform.anchoredPosition = self.tmpAnchoredPosition
        self.image.image.sprite = ResMgr:LoadSpriteSync(data.path)
        self.image.rectTransform.sizeDelta = Vector2.New(data.w, data.h)
        self.frame.gameObject:SetActive(true)
        self.frame.rectTransform.sizeDelta = Vector2.New(data.w, data.h)
--[[        self.text.contentSizeFitter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
        self.text.text.text = data
        local preferredWidth =  self.text.text.preferredWidth + 30
        local preferredHeight = self.text.text.preferredHeight + 30
        if self.text.text.preferredWidth + 30 > self.maxWidth then
            self.text.rectTransform:SetSize(Vector2.New(self.maxWidth - 30, 100))
            self.text.contentSizeFitter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
            preferredWidth = self.maxWidth
        else
            preferredHeight = 25 + 30
        end
        self.rectTransform:SetSize(Vector2.New(preferredWidth, preferredHeight))]]
    end
end

--function ImgToast:OnClose(initiative)
--
--end

--function ImgToast:OnDestroy()
--
--end

--function ImgToast:OnRefresh(data)
--
--end

return ImgToast
