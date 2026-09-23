function Awake()
    canvasGroup=ComUtil.GetCom(gameObject,"CanvasGroup");
end

function Refresh(data,elseData)
    local tLv=0;
    if elseData and elseData.lv then
        tLv=elseData.lv
    end
    if data then
        CSAPI.SetText(gameObject,data.sDetailed);
        if data.nLv>tLv then
            canvasGroup.alpha=0.5
        else
            canvasGroup.alpha=1
        end
    end
end