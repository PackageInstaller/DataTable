-- 无限滚动工具
UIInfiniteAnimType = {}
UIInfiniteAnimType.None = 0
-- 通用（首次打开时的动画）
UIInfiniteAnimType.Normal = "UIInfiniteAnimNormal" -- 顺序生成(以列为单位)
UIInfiniteAnimType.Diagonal = "UIInfiniteAnimDiagonal" -- 斜角生成
UIInfiniteAnimType.MoveByType = "UIInfiniteAnimMoveByType" -- 按参数方向做缩进动画
UIInfiniteAnimType.MoveByType2 = "UIInfiniteAnimMoveByType2" -- 按参数方向做缩进动画，根据内容计算时间
UIInfiniteAnimType.OneByOne = "UIInfiniteAnimOneByOne" -- 逐一生成(以列为单位)

-- 冷却
--UIInfiniteAnimType.Cool = "UIInfiniteAnimCol" -- 冷却 向下

-- 滚动时的动画
UIInfiniteAnimType.Oval = "UIInfiniteAnimOval" -- 椭圆 
-- 上移补位（任务专用）
UIInfiniteAnimType.MoveUp = "UIInfiniteAnimMoveUp"
-- 下移入场
UIInfiniteAnimType.MoveDownEnter = "UIInfiniteAnimMoveDownEnter"
-- 左移入场
UIInfiniteAnimType.MoveLeftEnter = "UIInfiniteAnimMoveLeftEnter"
-- 合成，上到下，小到大 
UIInfiniteAnimType.MatrixCompound = "UIInfiniteAnimCompound"

UIInfiniteAnimType.RogueT = "UIInfiniteAnimRogueT"
UIInfiniteAnimType.RogueTM = "UIInfiniteAnimRogueTM"

UIInfiniteAnimType.CustomTween="UIInfiniteAnimCustomTween"--调用自定义播放动画的方法

local this = {}

function this:AddUIInfiniteAnim(layout, type, param, addListener)
    if (not layout or not type) then
        return
    end
    addListener = addListener == nil and true or addListener
    if (type == UIInfiniteAnimType.None) then
        return
    else
        local animLua = require(type)
        local tlua = animLua.New()
        tlua:InitData(layout, param)

        if (addListener) then
            -- 椭圆动画，滑动时回调
            if (type == UIInfiniteAnimType.Oval) then
                layout:AddOnValueChangeFunc(function()
                    tlua:AnimPlay()
                end)
            else
                -- 打开时回调
                layout:AddOnOpenFunc(function()
                    tlua:AnimPlay()
                end)
            end
        end
        return tlua
    end
end

return this
