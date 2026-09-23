local canvasGroup=nil
function Awake()
    canvasGroup=ComUtil.GetCom(gameObject,"CanvasGroup");
end

function Refresh(goods,idx)
    --根据品质加载不同的球体颜色
    if goods then
        ResUtil.GachaBall:Load(img,"img_09_0"..goods:GetQuality());
        -- ResUtil.GachaBall:Load(img,"img_09_0"..idx);
    end
end

function SetAlpha(val)
    val= val==nil and 1 or val;
    canvasGroup.alpha=val;
end