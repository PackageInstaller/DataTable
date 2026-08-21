local M = BaseClass("GameUIText", UIText)

--设置角色名称
function M:SetAvatarName(templateId, type)
    self.unity_uitext:SetAvatarName(templateId, type)
end

--设置角色英文名
function M:SetAvatarEnName(templateId, type)
    self.unity_uitext:SetAvatarEnName(templateId, type)
end

--设置format 基础C#的string.format
function M:SetTextFormat(format, ...)
    self.unity_uitext:SetTextFormat(format, ...)
end

function M:SetDoTweenText(text)
    self.unity_uitext:SetDoTweenText(text)
end

function M:GetPreferredWidth(rectTransform)
    return self.unity_uitext:GetPreferredWidth(rectTransform)
end

function M:GetPreferredHeight()
    return self.unity_uitext.preferredHeight
end

function M:SetColorNew(color)
    return self.unity_uitext:SetColor(color.r / 255, color.g / 255, color.b / 255, color.a / 255)
end

function M:SetColorByColor(color)
    return self.unity_uitext:SetColor(color.r / 1, color.g / 1, color.b / 1, color.a / 1)
end

function M:SetColorTo16(colorStr)
    return self.unity_uitext:SetColor(colorStr)
end

function M:SetColor(r, g, b, a)
    if a == nil then
        a = 255
    end
    return self.unity_uitext:SetColor(r / 255, g / 255, b / 255, a / 255)
end

function M:GetColor()
    return self.unity_uitext.color
end

function M:SetDoFade(endValue, duration, ease)
    if not ease then
        ease = 1
    end
    return self.unity_uitext:SetDoFade(endValue, duration, ease)
end

function M:SetDoText(endValue, duration, ease)
    if not ease then
        ease = 1
    end
    return self.unity_uitext:SetDoText(endValue, duration, ease)
end

function M:SetEnable(enable)
    self.unity_uitext.enabled = enable
end

function M:SetItemIcon(itemId)
    self.unity_uitext:SetItemIcon(itemId)
end

function M:SetItemName(itemId)
    self.unity_uitext:SetItemName(itemId)
end

--去掉富文本的内容
function M:GetRealText()
    return self.unity_uitext:GetRealText()
end

function M:SetTextRoll(startValue, endValue, duration, callback)
    return self.unity_uitext:SetTextRoll(startValue, endValue, duration, callback)
end

function M:SetFontSize(size)
    self.unity_uitext:SetFontSize(size)
end

return M
