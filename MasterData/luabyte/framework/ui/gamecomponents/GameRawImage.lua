local GameRawImage = BaseClass("GameRawImage", UIRawImage)
local M = GameRawImage

--设置URL图片
function M:SetUrlImage(url,callback)
    if self._rawUrl and self._rawUrl == url then 
        return
    end
    self.unity_rawimage:SetUrlImage(url,callback)
    self._rawUrl = url
end

--设置角色图标
function M:SetAvatarIcon(templateId, type, dataOrigin)
    if not dataOrigin then
        dataOrigin = 2
    end
    self.unity_rawimage:SetAvatarIcon(templateId, type, dataOrigin)
end

--设置角色全身像
function M:SetImageWhole(templateId, type, dataOrigin)
    if not dataOrigin then
        dataOrigin = 2
    end
    self.unity_rawimage:SetImageWhole(templateId, type, dataOrigin)
end

--设置角色战中半身像
function M:SetBattleHalf(templateId, type, dataOrigin)
    if not dataOrigin then
        dataOrigin = 2
    end
    self.unity_rawimage:SetBattleHalf(templateId, type, dataOrigin)
end

--用于展示的半身像
function M:SetShowHalf(templateId, type, dataOrigin)
    if not dataOrigin then
        dataOrigin = 2
    end
    self.unity_rawimage:SetShowHalf(templateId, type, dataOrigin)
end

--编队界面半身
function M:SetImageHalf(templateId, type, dataOrigin)
    if not dataOrigin then
        dataOrigin = 2
    end
    self.unity_rawimage:SetImageHalf(templateId, type, dataOrigin)
end

--设置英雄立绘
function M:SetHeroDrawing(templateId, dataOrigin)
    if not dataOrigin then
        dataOrigin = 2
    end
    self.unity_rawimage:SetHeroDrawing(templateId, dataOrigin)
end

-- 设置皮肤立绘
function M:SetSkinDrawing(skinId, dataOrigin)
    if not dataOrigin then
        dataOrigin = 4
    end
    self.unity_rawimage:SetSkinDrawing(skinId, dataOrigin)
end

--设置英雄插图
function M:SetHeroIllustration(templateId, dataOrigin)
    if not dataOrigin then
        dataOrigin = 2
    end
    self.unity_rawimage:SetHeroIllustration(templateId, dataOrigin)
end

-- --设置英雄形象图
-- function M:SetHeroDrawingPicture(templateId, dataOrigin)
--     if not dataOrigin then
--         dataOrigin = 2
--     end
--     self.unity_rawimage:SetHeroDrawingPicture(templateId, dataOrigin)
-- end

--设置英雄2D觉醒图
function M:SetHeroAwakePicture(templateId, dataOrigin)
    if not dataOrigin then
        dataOrigin = 2
    end
    self.unity_rawimage:SetHeroAwakePicture(templateId, dataOrigin)
end

function M:SetDoColor(r, g, b, a, duration, ease)
    a = a or 255
    ease = ease or 1
    self.unity_rawimage:SetDoColor(r / 255, g / 255, b / 255, a / 255, duration, ease)
end

function M:SetDoFade(endValue, duration, ease)
    if not ease then
        ease = 1
    end
    return self.unity_rawimage:SetDoFade(endValue, duration, ease)
end

function M:SetRectLocalPos(vector3)
    self.unity_rawimage:SetRectLocalPos(vector3.x, vector3.y, vector3.z)
end

function M:SetRectLocalPoint(container, x, y)
    self.unity_rawimage:SetRectLocalPoint(container, x, y)
end

function M:SetRectDoMove(container, x, y, duration, ease)
    if not ease then ease = 1 end
    return self.unity_rawimage:SetRectDoMove(container, x, y, duration, ease)
end

function M:SetTexture(texture)
    self.unity_rawimage:SetTexture(texture)
end

return GameRawImage
