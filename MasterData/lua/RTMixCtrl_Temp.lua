local this={};
--临时用，等CShape更新后删除
local RenderTexture=CS.UnityEngine.RenderTexture;
local Vector2=CS.UnityEngine.Vector2;
local Screen=CS.UnityEngine.Screen;
local Mathf= CS.UnityEngine.Mathf;
local rtSize=Vector2(1920,1080);
local RenderTextureFormat=CS.UnityEngine.RenderTextureFormat;
local mixMaterial=nil;
local hdrRT=nil;
local alphaRT=nil;
function this.SetRT(hdrCamera,alphaCamera,imgGO)
    if hdrCamera==nil or alphaCamera==nil or imgGO==nil then
        do return end
    end
    local rawImg=imgGO.gameObject:GetComponent("RawImage");
    mixMaterial=rawImg.material;
    hdrRT=this.CreateRT(true);
    alphaRT=this.CreateRT(false);
    this.SetCameraRT(hdrCamera,hdrRT);
    this.SetCameraRT(alphaCamera,alphaRT);
    if mixMaterial~=nil then
        mixMaterial:SetTexture("_HDRRT",hdrRT);
        mixMaterial:SetTexture("_AlphaRT",alphaRT);
    end
end

function this.CreateRT(isHDR)
    local wh = Screen.width * 1.0 / Screen.height * 1.0;--当前UI的宽高比
    local  rtWh = (rtSize.x / rtSize.y);--rt尺寸的宽高比
    local v2 = Vector2(0, 0);
    if (Mathf.Abs(wh - rtWh) <= 0.2) then
        v2 = Vector2(rtSize.x, rtSize.y);
    else
        v2 = Vector2(rtSize.y * wh, rtSize.y);
    end
    if (isHDR) then
        return RenderTexture(Mathf.CeilToInt(v2.x), Mathf.CeilToInt(v2.y), 24,RenderTextureFormat.DefaultHDR);
    else
        return RenderTexture(Mathf.CeilToInt(v2.x), Mathf.CeilToInt(v2.y), 24,RenderTextureFormat.ARGB32);
    end
end

function this.SetCameraRT(camera,rt)
    if camera==nil or rt==nil then
        do return end
    end
    local list=ComUtil.GetComsInChildren(camera,"Camera",true);
    for i=0,list.Length-1 do
        list[i].targetTexture=rt;
    end
end

function this.OnDestory()
    if hdrRT then
        CS.UnityEngine.GameObject.Destroy(hdrRT);
    end
    if alphaRT then
        CS.UnityEngine.GameObject.Destroy(alphaRT);
    end
end

return this;