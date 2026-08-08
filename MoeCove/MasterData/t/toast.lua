---@class Toast : Toast_Generate
---##################### 【Toast Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【Toast Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local Toast = require "Toast_Generate"

function Toast:InitLogic(data)
	self.maxWidth = self.rectTransform.rect.width
	self.tmpAnchoredPosition = self.rectTransform.anchoredPosition
end

function Toast:StartCreating(time)
	self.gameObject:SetToAlpha(0)
end

function Toast:StartShowing(time)
	self.gameObject:FadeTo(0.9, 0.3, nil)
	self.rectTransform:DoMoveDeltaY(200, time, false)
	EngineUtil.DelayCallback(time - 0.3, 
				function()
					self.gameObject:FadeTo(0, 0.3, nil)
				end)
end

function Toast:StartRemoving(time)
end

function Toast:OnOpen(data, initiative)
	local canvas = self.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"
	if initiative then
		self.rectTransform.anchoredPosition = self.tmpAnchoredPosition
		--self.text.contentSizeFitter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
		self.text.text.text = data
		local preferredWidth =  self.text.text.preferredWidth + 30
		local preferredHeight = self.text.text.preferredHeight + 30
		if self.text.text.preferredWidth + 30 > self.maxWidth then
			self.text.rectTransform:SetSize(Vector2.New(self.maxWidth - 30, 100))
			--self.text.contentSizeFitter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
			preferredWidth = self.maxWidth
		else
			preferredHeight = 25 + 30
		end
		self.rectTransform:SetSize(Vector2.New(preferredWidth, preferredHeight))
	end
end

--function Toast:OnClose(initiative)
--
--end

--function Toast:OnDestroy()
--
--end

--function Toast:OnRefresh(data)
--
--end

return Toast
